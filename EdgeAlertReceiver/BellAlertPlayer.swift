//
//  BellAlertPlayer.swift
//  EdgeAlertReceiver
//

import Foundation
import AVFoundation
import UIKit

final class BellAlertPlayer {
    static let shared = BellAlertPlayer()

    private let session = AVAudioSession.sharedInstance()
    private let engine = AVAudioEngine()
    private let playerNode = AVAudioPlayerNode()
    private var alarmBuffer: AVAudioPCMBuffer?
    private var wavPlayer: AVAudioPlayer?
    private var isEngineReady = false

    private init() {}

    func ringLoud() {
        DispatchQueue.main.async {
            guard self.configureAudioSession() else { return }
            self.prepareEngineIfNeeded()
            self.playAlarmBurst()
        }
    }

    private func configureAudioSession() -> Bool {
        do {
            try session.setCategory(.playback, mode: .default, options: [.duckOthers])
            try session.setActive(true)
            return true
        } catch {
            print("[ConnectIQ][Bell] Failed to configure audio session: \(error.localizedDescription)")
            return false
        }
    }

    private func prepareEngineIfNeeded() {
        if isEngineReady { return }

        engine.attach(playerNode)
        let format = AVAudioFormat(standardFormatWithSampleRate: 44_100, channels: 1)!
        engine.connect(playerNode, to: engine.mainMixerNode, format: format)
        engine.mainMixerNode.outputVolume = 1.0

        alarmBuffer = makeAlarmBuffer(format: format)

        do {
            try engine.start()
            isEngineReady = true
        } catch {
            print("[ConnectIQ][Bell] Failed to start audio engine: \(error.localizedDescription)")
            isEngineReady = false
        }
    }

    private func playAlarmBurst() {
        let burstCount = 3
        let intervalSeconds = 0.2
        for index in 0..<burstCount {
            let delay = Double(index) * intervalSeconds
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.playSingleAlarmHit()
            }
        }
    }

    private func playSingleAlarmHit() {
        if playBundledBellWav() {
            return
        }

        guard isEngineReady, let alarmBuffer else { return }

        playerNode.stop()
        playerNode.volume = 1.0
        playerNode.scheduleBuffer(alarmBuffer, at: nil, options: [], completionHandler: nil)
        playerNode.play()
    }

    private func playBundledBellWav() -> Bool {
        guard let dataAsset = NSDataAsset(name: "bell") else {
            print("[ConnectIQ][Bell] bell.dataset not found in asset catalog")
            return false
        }

        do {
            let player = try AVAudioPlayer(data: dataAsset.data)
            player.volume = 1.0
            player.prepareToPlay()
            player.play()
            wavPlayer = player
            return true
        } catch {
            print("[ConnectIQ][Bell] Failed to play bell.wav from dataset: \(error.localizedDescription)")
            return false
        }
    }

    private func makeAlarmBuffer(format: AVAudioFormat) -> AVAudioPCMBuffer {
        // Non-critical high-intensity alarm tone (single hit), heavy-weather style.
        let sampleRate = format.sampleRate
        let durationSeconds = 0.95
        let frameCount = AVAudioFrameCount(sampleRate * durationSeconds)
        let buffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: frameCount)!
        buffer.frameLength = frameCount

        guard let channelData = buffer.floatChannelData?[0] else { return buffer }

        let tone1Frequency = 980.0
        let tone2Frequency = 720.0
        let amplitude: Float = 0.95
        let firstSegmentFrames = Int(Double(frameCount) * 0.55)

        for frame in 0..<Int(frameCount) {
            let frequency = frame < firstSegmentFrames ? tone1Frequency : tone2Frequency
            let time = Double(frame) / sampleRate
            let phase = sin(2.0 * Double.pi * frequency * time)

            // Soft attack/release to avoid clicks while staying loud.
            let attackFrames = Int(sampleRate * 0.01)
            let releaseFrames = Int(sampleRate * 0.04)
            let envelope: Float
            if frame < attackFrames {
                envelope = Float(frame) / Float(max(attackFrames, 1))
            } else if frame > Int(frameCount) - releaseFrames {
                envelope = Float(Int(frameCount) - frame) / Float(max(releaseFrames, 1))
            } else {
                envelope = 1.0
            }

            channelData[frame] = Float(phase) * amplitude * max(Float(0), envelope)
        }

        return buffer
    }
}

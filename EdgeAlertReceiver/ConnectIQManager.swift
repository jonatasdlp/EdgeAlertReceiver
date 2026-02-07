//
//  ConnectIQManager.swift
//  EdgeAlertReceiver
//
//  Created by Jonatas Santos on 17/01/26.
//

import Foundation
import ConnectIQ
internal import Combine

final class ConnectIQManager: NSObject, ObservableObject {
    static let shared = ConnectIQManager()

    @Published private(set) var lastMessage: String = "Waiting for Garmin message..."

    private var connectedDevice: IQDevice?
    private var app: IQApp?
    private var registeredAppDeviceUUID: UUID?
    private var pendingCharacteristicsDeviceUUID: UUID?
    private var hasInitializedSDK = false
    private let defaults = UserDefaults.standard
    private let lastDeviceUUIDKey = "connectiq.lastDeviceUUID"
    private let lastDeviceModelKey = "connectiq.lastDeviceModel"
    private let lastDeviceNameKey = "connectiq.lastDeviceName"
    private let isoFormatter = ISO8601DateFormatter()

    // TODO: Replace these UUIDs with the app UUIDs from your Garmin CIQ app.
    private let appUUID = UUID(uuidString: "727b0923-e041-4f23-ad69-784bb96a8369")!
    private let storeUUID = UUID(uuidString: "727b0923-e041-4f23-ad69-784bb96a8369")!

    private override init() {
        super.init()
        log("Manager initialized")
        log("Configured appUUID=\(appUUID.uuidString) storeUUID=\(storeUUID.uuidString)")
        debugSnapshot(context: "init")
    }

    func initializeConnectIQ(urlScheme: String) {
        if hasInitializedSDK {
            log("initializeConnectIQ skipped (already initialized)")
            return
        }
        hasInitializedSDK = true
        log("initializeConnectIQ called with scheme=\(urlScheme)")
        ConnectIQ.sharedInstance().initialize(
            withUrlScheme: urlScheme,
            uiOverrideDelegate: self,
            stateRestorationIdentifier: "edgealertreceiver-ciq"
        )
        log("SDK initialize invoked with stateRestorationIdentifier=edgealertreceiver-ciq")
        restoreLastSelectedDeviceIfAvailable()
        debugSnapshot(context: "post-initialize")
    }

    func handleOpenURL(_ url: URL) {
        log("handleOpenURL url=\(url.absoluteString)")
        log("URL details scheme=\(url.scheme ?? "nil") host=\(url.host ?? "nil") path=\(url.path) query=\(url.query ?? "nil")")
        let isExpectedScheme = (url.scheme == "edgealertreceiver") || (url.scheme == "https")
        if !isExpectedScheme {
            log("Ignoring unrelated URL callback scheme=\(url.scheme ?? "nil")")
            return
        }
        let devices = ConnectIQ.sharedInstance().parseDeviceSelectionResponse(from: url) as? [IQDevice]
        log("parseDeviceSelectionResponse count=\(devices?.count ?? 0)")
        if let parsedDevices = devices {
            for (index, parsedDevice) in parsedDevices.enumerated() {
                log("parsedDevice[\(index)] \(deviceSummary(parsedDevice))")
            }
        }
        guard let device = devices?.first else {
            updateMessage("No device found from ConnectIQ response.")
            debugSnapshot(context: "handleOpenURL-no-device")
            return
        }

        saveLastSelectedDevice(device)
        connectedDevice = device
        log("Selected device \(deviceSummary(device))")
        registerForDeviceEvents(device)
        pendingCharacteristicsDeviceUUID = device.uuid
        debugSnapshot(context: "handleOpenURL-selected-device")
    }

    func showDeviceSelection() {
        log("showDeviceSelection requested")
        ConnectIQ.sharedInstance().showDeviceSelection()
        debugSnapshot(context: "showDeviceSelection")
    }

    private func registerForDeviceEvents(_ device: IQDevice) {
        log("registerForDeviceEvents for \(deviceSummary(device))")
        ConnectIQ.sharedInstance().register(forDeviceEvents: device, delegate: self)
        log("registerForDeviceEvents completed")
    }

    private func registerForAppMessages(_ device: IQDevice) {
        if registeredAppDeviceUUID == device.uuid {
            log("registerForAppMessages skipped (already registered) for deviceUUID=\(device.uuid.uuidString)")
            return
        }

        if registeredAppDeviceUUID != nil {
            log("registerForAppMessages replacing previous deviceUUID=\(registeredAppDeviceUUID?.uuidString ?? "nil")")
            ConnectIQ.sharedInstance().unregister(forAllAppMessages: self)
            registeredAppDeviceUUID = nil
        }

        let app = IQApp.init(uuid: appUUID, store: storeUUID, device: device)
        self.app = app
        log("registerForAppMessages appUUID=\(appUUID.uuidString) storeUUID=\(storeUUID.uuidString) deviceUUID=\(device.uuid.uuidString)")
        ConnectIQ.sharedInstance().getAppStatus(app) { [weak self] status in
            guard let self else { return }
            guard let status else {
                self.log("getAppStatus returned nil (device unavailable/timeout)")
                return
            }
            self.log("getAppStatus isInstalled=\(status.isInstalled) version=\(status.version)")
            if !status.isInstalled {
                self.updateMessage("Connect IQ app is not installed on this device.")
            }
        }
        ConnectIQ.sharedInstance().register(forAppMessages: app, delegate: self)
        registeredAppDeviceUUID = device.uuid
        log("registerForAppMessages completed")
        debugSnapshot(context: "registerForAppMessages")
    }

    private func updateMessage(_ message: String) {
        log("updateMessage -> \(message)")
        DispatchQueue.main.async {
            self.lastMessage = message
        }
    }

    private func saveLastSelectedDevice(_ device: IQDevice) {
        defaults.set(device.uuid.uuidString, forKey: lastDeviceUUIDKey)
        defaults.set(device.modelName, forKey: lastDeviceModelKey)
        defaults.set(device.friendlyName, forKey: lastDeviceNameKey)
        log("Saved device in UserDefaults \(deviceSummary(device))")
    }

    private func restoreLastSelectedDeviceIfAvailable() {
        log("restoreLastSelectedDeviceIfAvailable started")
        guard
            let uuidString = defaults.string(forKey: lastDeviceUUIDKey),
            let uuid = UUID(uuidString: uuidString),
            let modelName = defaults.string(forKey: lastDeviceModelKey),
            let friendlyName = defaults.string(forKey: lastDeviceNameKey)
        else {
            log("No stored device in UserDefaults")
            return
        }

        log("Stored device values uuid=\(uuidString) model=\(modelName) name=\(friendlyName)")
        guard let device = IQDevice(id: uuid, modelName: modelName, friendlyName: friendlyName) else {
            log("Failed to rebuild IQDevice from stored values")
            return
        }
        connectedDevice = device
        log("Restored device \(deviceSummary(device))")
        registerForDeviceEvents(device)
        pendingCharacteristicsDeviceUUID = device.uuid
        debugSnapshot(context: "restoreLastSelectedDeviceIfAvailable")
    }
}

extension ConnectIQManager: IQDeviceEventDelegate {
    func deviceStatusChanged(_ device: IQDevice, status: IQDeviceStatus) {
        log("deviceStatusChanged device=\(deviceSummary(device)) status=\(statusSummary(status))")
        logDeviceStatus(status, deviceName: device.friendlyName)

        if status == IQDeviceStatus.connected {
            log("Device connected; waiting for deviceCharacteristicsDiscovered before app message registration")
            pendingCharacteristicsDeviceUUID = device.uuid
            return
        }

        if registeredAppDeviceUUID == device.uuid {
            log("Device no longer connected; unregistering app messages for deviceUUID=\(device.uuid.uuidString)")
            ConnectIQ.sharedInstance().unregister(forAllAppMessages: self)
            registeredAppDeviceUUID = nil
            app = nil
            debugSnapshot(context: "deviceStatusChanged-unregistered-app-messages")
        }
        if pendingCharacteristicsDeviceUUID == device.uuid {
            pendingCharacteristicsDeviceUUID = nil
        }
    }

    func deviceCharacteristicsDiscovered(_ device: IQDevice) {
        log("deviceCharacteristicsDiscovered for \(deviceSummary(device))")
        if pendingCharacteristicsDeviceUUID == device.uuid || registeredAppDeviceUUID != device.uuid {
            log("Characteristics discovered; registering app messages")
            registerForAppMessages(device)
            pendingCharacteristicsDeviceUUID = nil
        }
    }
}

extension ConnectIQManager: IQAppMessageDelegate {
    func receivedMessage(_ message: Any, from app: IQApp) {
        BellAlertPlayer.shared.ringLoud()
        log("receivedMessage from appUUID=\(app.uuid.uuidString) messageType=\(type(of: message))")
        
        if let dictionary = message as? [String: Any] {
            log("receivedMessage dictionary keys=\(Array(dictionary.keys).sorted())")
        } else if let stringMessage = message as? String {
            log("receivedMessage string length=\(stringMessage.count)")
        }

        if let stringMessage = message as? String {
            updateMessage(stringMessage)
            return
        }

        if let dict = message as? [String: Any] {
            updateMessage(dict.description)
            return
        }

        updateMessage(String(describing: message))
    }
}

extension ConnectIQManager: IQUIOverrideDelegate {
    
    func needsToInstallConnectMobile() {
        let message = "Garmin Connect Mobile is not installed."
        updateMessage(message)
        log(message)
    }
}

private extension ConnectIQManager {
    func log(_ message: String,
             function: StaticString = #function,
             line: UInt = #line) {
        let timestamp = isoFormatter.string(from: Date())
        let threadName = Thread.isMainThread ? "main" : "background"
        print("[ConnectIQ][\(timestamp)][\(threadName)][\(function):\(line)] \(message)")
    }

    func deviceSummary(_ device: IQDevice) -> String {
        "name=\(device.friendlyName) model=\(device.modelName) uuid=\(device.uuid.uuidString)"
    }

    func statusSummary(_ status: IQDeviceStatus) -> String {
        switch status {
        case .connected:
            return "connected"
        case .notConnected:
            return "notConnected"
        case .notFound:
            return "notFound"
        case .bluetoothNotReady:
            return "bluetoothNotReady"
        case .invalidDevice:
            return "invalidDevice"
        @unknown default:
            return "unknown(\(status.rawValue))"
        }
    }

    func debugSnapshot(context: String) {
        let connectedDeviceSummary = connectedDevice.map(deviceSummary(_:)) ?? "nil"
        let appUUIDSummary = app?.uuid.uuidString ?? "nil"
        let registeredDeviceSummary = registeredAppDeviceUUID?.uuidString ?? "nil"
        let pendingDeviceSummary = pendingCharacteristicsDeviceUUID?.uuidString ?? "nil"
        log("snapshot[\(context)] connectedDevice=\(connectedDeviceSummary) registeredAppDeviceUUID=\(registeredDeviceSummary) pendingCharacteristicsDeviceUUID=\(pendingDeviceSummary) appUUID=\(appUUIDSummary) lastMessage=\(lastMessage)")
    }

    func logDeviceStatus(_ status: IQDeviceStatus, deviceName: String?) {
        let name = deviceName ?? "device"
        let message: String
        switch status {
        case .connected:
            message = "Connected to \(name)."
        case .notConnected:
            message = "Not connected to \(name)."
        case .notFound:
            message = "Device \(name) not found."
        case .bluetoothNotReady:
            message = "Bluetooth not ready."
        case .invalidDevice:
            message = "Invalid device."
        @unknown default:
            message = "Unknown device status."
        }
        updateMessage(message)
        log(message)
    }
}

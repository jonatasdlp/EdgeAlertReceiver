//
//  EdgeAlertReceiverApp.swift
//  EdgeAlertReceiver
//
//  Created by Jonatas Santos on 17/01/26.
//

import SwiftUI
import UIKit
import ConnectIQ

@main
struct EdgeAlertReceiverApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @StateObject private var connectIQManager = ConnectIQManager.shared

    init() {
        ConnectIQManager.shared.initializeConnectIQ(urlScheme: "edgealertreceiver")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(connectIQManager)
                .onOpenURL { url in
                    print("[ConnectIQ][SwiftUI] onOpenURL url=\(url.absoluteString)")
                    connectIQManager.handleOpenURL(url)
                }
                .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
                    let url = userActivity.webpageURL?.absoluteString ?? "nil"
                    print("[ConnectIQ][SwiftUI] onContinueUserActivity type=\(userActivity.activityType) url=\(url)")
                    if let webpageURL = userActivity.webpageURL {
                        connectIQManager.handleOpenURL(webpageURL)
                    }
                }
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    weak var connectIQManager: ConnectIQManager? = ConnectIQManager.shared

    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let sourceApp = options[.sourceApplication] as? String ?? "unknown"
        print("[ConnectIQ][AppDelegate] openURL sourceApp=\(sourceApp) url=\(url.absoluteString) hasManager=\(connectIQManager != nil)")
        connectIQManager?.handleOpenURL(url)
        return true
    }

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        let url = userActivity.webpageURL?.absoluteString ?? "nil"
        print("[ConnectIQ][AppDelegate] continueUserActivity type=\(userActivity.activityType) url=\(url) hasManager=\(connectIQManager != nil)")
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let webpageURL = userActivity.webpageURL else {
            return false
        }
        connectIQManager?.handleOpenURL(webpageURL)
        return true
    }
}

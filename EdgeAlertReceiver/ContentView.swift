//
//  ContentView.swift
//  EdgeAlertReceiver
//
//  Created by Jonatas Santos on 17/01/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var connectIQManager: ConnectIQManager

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)

            Text(connectIQManager.lastMessage)
                .multilineTextAlignment(.center)

            Button("Connect to Garmin Device") {
                connectIQManager.showDeviceSelection()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

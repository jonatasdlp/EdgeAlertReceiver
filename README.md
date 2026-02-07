# EdgeAlertReceiver

EdgeAlertReceiver is an iOS companion app for Garmin Connect IQ devices (tested with Garmin Edge family) built with SwiftUI + Connect IQ Mobile SDK.

It connects to a user-authorized Garmin device, listens for app messages from a Connect IQ app, and triggers a loud pedestrian alert (`bell.wav`) on iPhone when a message arrives.

## Features

- Connect IQ SDK integration (iOS)
- Device selection through Garmin Connect Mobile
- Device event lifecycle handling
- App message reception from Connect IQ app
- Loud iPhone audible alert on incoming message
  - Uses `Assets.xcassets/bell.dataset/bell.wav`
  - Plays 3 quick hits for high noticeability
- Structured runtime logs for debugging and diagnostics

## Tech Stack

- SwiftUI
- UIKit app delegate bridge
- Garmin Connect IQ Mobile SDK (`ConnectIQ`)
- AVFoundation for audio alert playback

## Project Structure

- `EdgeAlertReceiver/EdgeAlertReceiverApp.swift`
  - App entry point
  - SDK initialization
  - URL and universal-link callback routing
- `EdgeAlertReceiver/ConnectIQManager.swift`
  - Connect IQ orchestration
  - Device selection parsing
  - Device/app message registration
  - Status and diagnostics logging
- `EdgeAlertReceiver/BellAlertPlayer.swift`
  - Alert sound playback engine
- `EdgeAlertReceiver/ContentView.swift`
  - Minimal UI and connect action

## Requirements

- Xcode 15+
- iOS device (physical device recommended)
- Garmin Connect Mobile installed on iPhone
- Garmin device paired with Garmin Connect Mobile
- Connect IQ app installed on Garmin device (matching UUID used in app)

## Setup

### 1. Open the project

Open:

`EdgeAlertReceiver.xcodeproj`

### 2. Configure your Connect IQ app UUIDs

In `EdgeAlertReceiver/ConnectIQManager.swift`, set:

- `appUUID`
- `storeUUID`

These must match your Connect IQ app.

### 3. Verify Info.plist essentials

Already included in this project:

- URL scheme: `edgealertreceiver`
- `LSApplicationQueriesSchemes` contains `gcm-ciq`
- Bluetooth usage description keys
- `CFBundleDisplayName`

### 4. Build and run on iPhone

Use a real iPhone for full BLE and Garmin Connect interaction.

## How It Works

1. App initializes Connect IQ SDK at startup.
2. User taps **Connect to Garmin Device**.
3. App opens Garmin Connect Mobile device selection.
4. Garmin Connect returns authorized devices via callback URL.
5. App parses selected device and registers:
   - Device event delegate
   - App message delegate (after `deviceCharacteristicsDiscovered`)
6. When a Connect IQ message arrives, app:
   - Updates UI text
   - Plays loud bell alert (`bell.wav`) 3 times quickly

## Logging & Debugging

Logs are prefixed with:

`[ConnectIQ]`

Useful events to watch:

- `showDeviceSelection requested`
- `onOpenURL` / `continueUserActivity`
- `parseDeviceSelectionResponse count=...`
- `deviceStatusChanged ...`
- `deviceCharacteristicsDiscovered ...`
- `getAppStatus isInstalled=...`
- `receivedMessage ...`

## Troubleshooting

### Garmin Connect opens but app does not receive callback

- Ensure URL scheme in Info.plist matches SDK initialization scheme.
- Ensure Garmin Connect Mobile is installed (not only Garmin Connect web account).
- Reinstall app after changing URL/callback settings.
- Confirm callback logs in app delegate / SwiftUI `onOpenURL`.

### Device connects but no messages are received

- Confirm app UUID/store UUID are correct.
- Confirm Connect IQ app is installed on the Garmin device.
- Check `getAppStatus isInstalled`.
- Ensure your Connect IQ app is actually sending mailbox messages.

### Alert sound too quiet

- iOS does not allow apps to override system volume beyond user/device settings without Critical Alerts entitlement.
- This app already uses a custom bell + playback session and repeated hits for maximum non-critical alert volume.

## Security & Privacy Notes

- Device metadata is cached locally via `UserDefaults` for reconnection flow.
- No backend or cloud dependency is required for current behavior.

## Roadmap Ideas

- In-app device diagnostics panel (status, app install status, last callback timestamp)
- Message type filtering / prioritization
- Haptic pattern customization
- Foreground/background alert policy controls

## License

MIT. See `LICENSE`.

# Garmin Connect IQ Integration Context

## Required Setup
- Connect IQ SDK linked correctly.
- `-ObjC` in Other Linker Flags.
- `LSApplicationQueriesSchemes` includes `gcm-ciq`.
- URL scheme or universal links configured and handled by app lifecycle callbacks.

## Reliable Flow
1. Initialize `ConnectIQ.sharedInstance` at startup.
2. Launch `showConnectIQDeviceSelection`.
3. Parse return URL with `parseDeviceSelectionResponseFromURL`.
4. Register device events.
5. Wait for `deviceCharacteristicsDiscovered`.
6. Create `IQApp` and call `getAppStatus`.
7. Register app message delegate.
8. Handle `receivedMessage` and trigger local alert behavior.

## Common Failures
- Invalid device ID format: ID must be UUID.
- No callback from GCM: callback handlers not wired or scheme mismatch.
- Message send/receive instability: communication started before characteristics discovery.

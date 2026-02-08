# Known Issues

## Open
- iPhone output loudness is limited by system volume and route.
- "Critical alert" style behavior requires Apple entitlement (not generally available).

## Watchouts
- If `showConnectIQDeviceSelection` appears to do nothing, verify URL scheme/universal link callback wiring and GCM install state.
- If app status is nil, check device connection + characteristic discovery timing.

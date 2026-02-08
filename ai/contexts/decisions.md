# Decisions (ADR Lite)

## 2026-02 - Initialize ConnectIQ at app startup
- Decision: Initialize SDK in app init instead of waiting for a view lifecycle callback.
- Reason: Prevent callback race and missed responses from Garmin Connect Mobile.
- Impact: More reliable device selection return path.

## 2026-02 - Gate communication on characteristic discovery
- Decision: Treat `connected` as insufficient, wait for `deviceCharacteristicsDiscovered`.
- Reason: SDK headers indicate full readiness only after characteristic discovery.
- Impact: Fewer message/app-status failures.

## 2026-02 - Remove manual device entry
- Decision: Keep only official GCM selection flow.
- Reason: Device IDs are UUID-based and manual IDs caused invalid format errors.
- Impact: Simpler, safer onboarding.

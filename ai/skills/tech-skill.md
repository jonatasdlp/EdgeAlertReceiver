# Technical Skill

## Stack
- Swift / SwiftUI
- Connect IQ Mobile SDK (iOS)
- AVFoundation for audio playback

## Architecture Notes
- `ConnectIQManager` is the integration orchestrator.
- App entry initializes SDK early at startup.
- URL/universal link callbacks are handled in app lifecycle entry points.

## Coding Conventions
- Prefer small methods with explicit names.
- Log critical flow checkpoints with timestamps and source method.
- Keep async callback handling on main thread when updating UI state.

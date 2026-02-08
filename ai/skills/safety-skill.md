# Safety Skill

## Guardrails
- Do not hardcode secrets/credentials.
- Do not use private iOS APIs.
- Respect platform limits (e.g., no forced max volume without Apple entitlement).

## Integration Safety
- Do not communicate with device app before `deviceCharacteristicsDiscovered`.
- Handle nil/timeout paths explicitly in app status and message send flows.

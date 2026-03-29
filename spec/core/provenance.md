# Provenance model (OGIS v0.1)

The `provenance` object on `glucose.reading` is **required**. It establishes **lineage** from canonical event back to source data and the adapter that performed the mapping.

## Fields

| Field | Description |
|-------|-------------|
| **`source_system`** | Logical identifier for the upstream system. Examples: `com.apple.health`, `dexcom`, `app.manual`, vendor API base URLs or reverse-DNS strings. **must** be stable for the same integration. |
| **`raw_event_id`** | Identifier of the **source record** (e.g. HealthKit `UUID` string, Dexcom event id). Used for idempotency and support. **must** be stable for the life of that source record. |
| **`adapter_version`** | [Semantic versioning](https://semver.org/) (or semver-compatible string) of the **adapter or mapper** that emitted this OGIS event. |
| **`ingested_at`** | RFC 3339 timestamp when the event was accepted by the **OGT collector** (or app-internal equivalent). **Not** the device clock. |

## Relationship to ingestion envelope (OGT)

OGT may also carry `trace_id`, `received_at`, and adapter metadata on an **ingestion envelope**. Those values complement but do not replace `provenance`; mappers **should** fill `provenance` from envelope + source payload.

## Privacy

`raw_event_id` **must not** introduce new PII beyond what the source already exposes. Subject identity belongs in `subject_id` policy, not in provenance free text.

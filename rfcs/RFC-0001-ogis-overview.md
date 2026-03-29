# RFC-0001: OGIS Overview (v0.1 MVP slice)

| Field | Value |
|-------|--------|
| Status | Draft |
| Created | 2026-03-29 |
| Scope | MVP v0.1 aligned with [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](../specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) |

## Mission

The **Open Glucose Interoperability Standard (OGIS)** defines vendor-neutral **meaning** for glucose-related events: canonical shapes, semantics, units, timestamps, and provenance so adapters, apps, and pipelines can interoperate without re-implementing each source’s idiosyncrasies.

## Scope (v0.1 GAT)

For the GlucoseAITracker / Open Glucose Telemetry integration slice, v0.1 **normatively** includes:

- **`glucose.reading`** JSON Schema **0.1** ([schemas/jsonschema/glucose.reading.v0_1.json](../schemas/jsonschema/glucose.reading.v0_1.json))
- Core semantics: [time](../spec/core/time-semantics.md), [units](../spec/core/unit-semantics.md), [provenance](../spec/core/provenance.md)
- [Semantic conventions registry](../spec/semantic-conventions/README.md)
- Validated [examples](../examples/)

## Non-goals (v0.1 GAT)

- **`glucose.alert`** and other event types (deferred)
- Sensor session lifecycle, therapy shells, full API contracts
- Full FHIR mapping document (informative pointer only below)
- Full conformance / certification program

## Relationship to Open Glucose Telemetry (OGT)

- **OGIS** specifies **what** a valid `glucose.reading` (and future events) **is**.
- **OGT** ingests raw payloads, maps to OGIS structures, validates, normalizes, and routes events.

OGT implementations **must** treat the JSON Schema and core docs in this repository as the **authoritative** contract for v0.1 validation unless a **pinned copy** is vendored with an explicit revision reference.

## Relationship to FHIR (informative)

OGIS is **not** a replacement for HL7 FHIR. Future work will publish mapping guidance (e.g. `Observation`, `Device`, `Provenance`). For v0.1, implementers may map fields best-effort for reporting; no normative FHIR profile is part of this MVP.

## Versioning

### `event_type` and `event_version`

Each event carries:

- `event_type` — stable string identifier (e.g. `glucose.reading`)
- `event_version` — string semver **major.minor** for the **schema contract** of that event (v0.1 uses **`"0.1"`**)

### Additive vs breaking changes

- **Additive (minor bump example 0.1 → 0.2):** new **optional** properties; stricter validation of existing fields avoided.
- **Breaking (major bump example 0.x → 1.0):** renamed/removed required fields, enum removals, or unit/timestamp semantics incompatible with prior validators.

Deprecation: fields marked deprecated in schema/docs should be supported for a published transition period before removal in a major version.

## References

- [spec/README.md](../spec/README.md)
- [FEATURE.md](../FEATURE.md) (v0.1 GAT feature IDs)

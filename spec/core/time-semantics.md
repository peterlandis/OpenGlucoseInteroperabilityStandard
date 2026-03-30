# Time semantics (OGIS v0.1)

All timestamps in `glucose.reading` use **RFC 3339** / **ISO 8601** strings. **UTC** is required (`Z` offset or explicit `+00:00`). Implementations **should** serialize with `Z` for clarity.

## Fields

| Field | Meaning |
|-------|--------|
| **`observed_at`** (required) | The instant the glucose value **applies** clinically — the user-facing “reading time.” This is the primary sort key for timelines and insights. |
| **`source_recorded_at`** (optional) | When the **source device or app** recorded the sample, if it differs from clinical observation time (rare; use when the vendor exposes both). |
| **`received_at`** (optional) | When the **submitting system** (e.g. phone app or OGT ingestion boundary) **received** the payload. Distinct from pipeline `provenance.ingested_at` when batching or relaying. |
| **`provenance.ingested_at`** (required on provenance) | When the event entered the **OGT collector** (or equivalent). Set by the ingest layer, not the source device. |

## Ordering

For a single subject, consumers **should** order readings by `observed_at` ascending unless a product-specific rule (e.g. dedupe) requires otherwise.

## Future timestamps

Validators **may** reject `observed_at` more than a small clock-skew window in the future (e.g. > 15 minutes); exact policy is **implementation-defined** but **must** be documented by OGT or the app.

## HealthKit

For `HKQuantitySample` blood glucose, map **`startDate`** (and typically `endDate` when equal) to **`observed_at`**. Apple does not split “system time” vs “display time” in the same way as some CGM clouds; if metadata provides a display-time override, mappers may set `source_recorded_at` or document the choice in adapter notes.

## `date-time` format

Strings **must** be valid `date-time` per JSON Schema validation (full date + time + offset).

## Wire format (RFC 3339) — informative

On the wire, prefer **RFC 3339** profiles that interop cleanly across JavaScript, Swift, and log pipelines:

- **UTC with `Z`** — e.g. `2026-03-29T14:32:00.000Z`. Easiest to compare lexicographically when all events are UTC.
- **Fractional seconds** — include when the source has sub-second precision (JSON Schema `date-time` allows fractional seconds). Omit trailing noise if your clock is whole-second only, but **do not** strip precision that the source provides without policy.
- **Explicit offset** — `+00:00` is equivalent to `Z`; mixed offsets are valid JSON Schema `date-time` but consumers **should** normalize to UTC for storage when possible.
- **Ambiguous local times** — strings **without** a timezone offset (bare local “wall clock” serializations) are **not** valid `date-time` for OGIS v0.1. Producers **should** reject or normalize them before emitting canonical events. Where legacy data exists, document the normalization rule (e.g. assume device local zone with named timezone) in adapter notes—**not** in the canonical payload.

## Implementation notes — informative

Platform behavior varies; OGIS does **not** mandate a specific library. These notes reduce surprise when parsing **RFC 3339** strings:

- **JavaScript** — `Date.parse` and `new Date(isoString)` accept many ISO-like strings; some edge cases (certain year-only or non-RFC extensions) differ between engines. Prefer a dedicated ISO/RFC 3339 parser for ingest if you need strictness. Fractional-second support is generally available on modern runtimes.
- **Swift** — `ISO8601DateFormatter` requires an explicit format option to enable fractional seconds (e.g. `.withFractionalSeconds`) when reading sub-second timestamps; without it, strings with fractional components may fail to parse. Choose formatter options to match the producer’s wire format.

For field meanings (`observed_at` vs `ingested_at`, etc.), see the table at the top of this document.

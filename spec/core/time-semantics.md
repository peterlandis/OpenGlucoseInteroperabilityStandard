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

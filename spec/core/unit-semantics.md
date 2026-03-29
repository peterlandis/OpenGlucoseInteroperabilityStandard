# Unit semantics (OGIS v0.1)

## Allowed glucose units

The `unit` property on `glucose.reading` **must** be exactly one of:

| Value | Description |
|-------|-------------|
| `mg/dL` | Milligrams per deciliter |
| `mmol/L` | Millimoles per liter |

No other strings are valid in v0.1.

## Conversion

\[
\text{mmol/L} = \text{mg/dL} \times 0.0555\ldots \quad (\text{exactly } \text{mg/dL} / 18.018)
\]

\[
\text{mg/dL} = \text{mmol/L} \times 18.018\ldots
\]

Implementations **should** use sufficient precision for medical display; rounding policy is product-specific but **must** be consistent across a single pipeline.

## Normalization policy (normative for v0.1)

**Producers may emit either `mg/dL` or `mmol/L`.** Downstream systems (e.g. OGT normalization stage) **may** convert to a **single canonical unit** for storage or analytics, but **must** preserve the **original** `value`/`unit` in a lossless way **or** document that only normalized values are retained.

For **GlucoseAITracker GAT MVP**, OGT **should** normalize to **`mg/dL`** for app-internal series while retaining provenance that the source reported in another unit when available.

## Plausible ranges (informative)

Clinical plausibility checks are **not** encoded in the JSON Schema (unit-dependent). Typical screening ranges used by apps:

- **mg/dL:** roughly 20–600 for validation UX (not a clinical endorsement)
- **mmol/L:** roughly 1.1–33.3

OGT semantic validators **may** enforce bounds per unit using rules outside the schema.

# Informative `source_system` registry (OGIS v0.1)

**Status:** **Informative only.** These strings are **not** a closed enum in [glucose.reading.v0_1.json](../../schemas/jsonschema/glucose.reading.v0_1.json). Producers may use other stable identifiers (reverse-DNS, vendor URLs, tenant-specific prefixes). This table collects **recommended** values that appear across **OpenGlucoseTelemetry (OGT)**, **GlucoseAITracker**, and common vendor integrations so implementations stay aligned.

**Normative field definition:** [provenance.md](./provenance.md).

---

## Recommended values

| `source_system` | Typical use | Example producers | Notes |
|-----------------|-------------|-------------------|--------|
| `com.apple.health` | Glucose row read from Apple **HealthKit** (any bundle that wrote the sample) | iOS HealthKit adapters, OGT HealthKit collector | Stable choice when the canonical event is derived from HK quantity samples. Does not replace `device.*` or `measurement_source`. |
| `dexcom` | Dexcom **cloud or API** EGV / equivalent | Dexcom REST adapters, server-side ingest | Use a single stable literal per integration (e.g. not mixed case). |
| `app.manual` | **User-entered** reading in the producer app (phone, tablet, or watch UI) | GlucoseAITracker manual entry, OGT manual path | Prefer over ad hoc `manual` or `user` strings. |
| `libre` / `freestyle` | Abbott FreeStyle / Libre ecosystem | Vendor-specific adapters | Pick **one** stable string per product line and document it in release notes. |
| `medtronic` | Medtronic CGM / cloud | Vendor adapters | Same as above—consistency beats novelty. |
| `unknown.cgm` | CGM stream where **vendor is not classified** | Generic CGM parsers, legacy imports | Pattern: `unknown.<class>` (e.g. `unknown.bgm`) for unknown class; prefer resolving to a real vendor when possible. |
| Reverse-DNS bundle id (e.g. `com.example.GlucoseAITracker`) | First-party app as **logical source** when not using HealthKit | Apps emitting their own canonical events | Acceptable when `com.apple.health` does not apply; **must** stay stable per release train. |
| HTTPS API origin (e.g. `https://api.vendor.example`) | **Vendor API** identified by base URL | Server-side collectors | Ensure normalization (no trailing slash drift); treat as opaque string for equality. |

---

## Anti-patterns (informative)

- **Random or per-session values** — breaks dedupe and support (`raw_event_id` is for the record; `source_system` is for the integration).
- **Mixed casing** for the same integration (`Dexcom` vs `dexcom`) — pick one and enforce in CI or codegen.
- **PII in `source_system`** — keep it a logical system id, not user or patient text.

---

## See also

- [provenance.md](./provenance.md) — required provenance fields  
- [semantic conventions](../semantic-conventions/README.md) — `measurement_source`, `device.type`  
- **OGT ↔ Swift parity:** OpenGlucoseTelemetry [OGT-SWIFT-PARITY-MATRIX.md](../../../OpenGlucoseTelemetry/specifications/handoff/OGT-SWIFT-PARITY-MATRIX.md) (sibling repo) for conversion and ingest alignment

**Last updated:** 2026-03-29

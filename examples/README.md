# Examples (`/examples`)

This folder holds **normative JSON fixtures** for the OGIS **`glucose.reading`** event, **`event_version` `0.1`**.

## What this is

- Each `*.json` file is a **complete canonical event** — the same shape that **Open Glucose Telemetry (OGT)** should emit after mapping a source (HealthKit, manual entry, Dexcom API, etc.) and that **consumers** (e.g. GlucoseAITracker) can treat as the contract for a single reading.
- These files are **not** raw vendor payloads. They are the **target** format defined by [glucose.reading.v0_1.json](../schemas/jsonschema/glucose.reading.v0_1.json).
- Fixtures here are **valid OGIS v0.1 documents** for interchange and testing. They are **not** a prescription of normalized **storage** form — pipelines may retain original units, sidecars, or envelopes per [unit-semantics.md](../spec/core/unit-semantics.md) (including the **18.018** conversion conformance note).

## What it is doing

1. **Documents real-world shapes** — HealthKit-style CGM, in-app manual entry (mmol/L), and a Dexcom-style narrative — so implementers can compare adapters and UIs to concrete data.
2. **Locks the schema in CI** — every `*.json` here **must** validate against the v0.1 JSON Schema. If the schema or examples drift, `npm run validate:examples` (and GitHub Actions) fails.
3. **Feeds golden tests** — OGT and other pipelines can copy or diff against these files as **expected** canonical output for fixtures.

## Files

| File | Intent |
|------|--------|
| `glucose.reading.healthkit.json` | Canonical output for one **HealthKit** glucose sample — see [Apple HealthKit to OGIS](#apple-healthkit-to-ogis-glucose-reading). |
| `glucose.reading.manual.json` | Canonical output for **in-app manual** entry — see [Manual entry to OGIS](#manual-entry-to-ogis-glucose-reading). |
| `glucose.reading.dexcom.json` | Canonical output for one Dexcom **EGV** row — see [Dexcom EGV to OGIS](#dexcom-egv-to-ogis-glucose-reading). |
| `glucose.reading.watch.json` | Canonical output for **watch companion quick log** (manual entry on wearable) — see [Watch quick log to OGIS](#watch-quick-log-to-ogis-glucose-reading). |

Add new examples only if they **validate**; extend the schema in a new `event_version` rather than shipping invalid JSON.

## Apple HealthKit to OGIS glucose.reading

On iOS, glucose arrives as **`HKQuantitySample`** (type identifier **`HKQuantityTypeIdentifierBloodGlucose`**). OGIS is a **portable JSON event**; adapters usually serialize the sample (or a subset) before mapping.

**Illustrative serialized payload** (not valid OGIS; OGT-style JSON for Linux CI / fixtures — adjust keys to your adapter contract):

```json
{
  "uuid": "A1B2C3D4-E5F6-7890-ABCD-EF1234567890",
  "quantityType": "HKQuantityTypeIdentifierBloodGlucose",
  "value": 142,
  "unit": "mg/dL",
  "startDate": "2026-03-29T14:32:00.000Z",
  "endDate": "2026-03-29T14:32:00.000Z",
  "sourceName": "Dexcom G7",
  "sourceBundleIdentifier": "com.dexcom.G7",
  "metadata": {
    "HKMetadataKeySyncIdentifier": "optional-vendor-sync-id",
    "HKMetadataKeySyncVersion": 1
  }
}
```

Native HealthKit uses `Date` and `HKUnit`; your adapter is responsible for **RFC 3339 UTC strings** and **exactly** `mg/dL` or `mmol/L` for OGIS `unit`.

### Field mapping (HealthKit → OGIS)

| HealthKit / serialized field | OGIS `glucose.reading` v0.1 | Notes |
|-----------------------------|-----------------------------|--------|
| — | `event_type` | Always `glucose.reading`. |
| — | `event_version` | Always `0.1` until schema bumps. |
| — | `subject_id` | Your app’s stable subject key (opaque id); **not** the HK sample UUID. |
| `startDate` | `observed_at` | Primary reading time; express as ISO 8601 **UTC** (`Z`). See [time-semantics.md](../spec/core/time-semantics.md). |
| `endDate` | `source_recorded_at` (optional) | Often equals `startDate` for point samples; omit if redundant. |
| — | `received_at` (optional) | When your app or OGT **received** the sample off the observer query (your clock). |
| `value` (in display unit) | `value` | Must match OGIS `unit` after conversion. |
| Display unit string | `unit` | Must be **`mg/dL`** or **`mmol/L`**; map from `HKQuantity` / `HKUnit` (e.g. `mg/dL` vs `mmol/L`). |
| — | `measurement_source` | **`cgm`** if source suggests CGM (bundle id, name heuristics); **`bgm`** for meter apps; use **`manual`** only if `HKMetadataKeyWasUserEntered` is true. |
| `sourceName`, `sourceBundleIdentifier`, device from revision | `device.manufacturer` / `device.model` / `device.type` | Best-effort: e.g. Dexcom → manufacturer `Dexcom`, model from name, `type` **`cgm`**. Use `phone` / `unknown` when unsure. |
| `uuid` | `provenance.raw_event_id` | HK’s **`UUID.uuidString`** for idempotency. |
| — | `provenance.source_system` | Use **`com.apple.health`** when the row is read from HealthKit. |
| — | `provenance.adapter_version` | Your HealthKit adapter semver. |
| — | `provenance.ingested_at` | When the event enters **OGT / collector** (UTC). |
| Metadata / paired reads | `trend` (optional) | HealthKit **often** does not carry CGM trend on the quantity sample; fill only if you have vendor metadata or a separate trend API. |
| Sample deletion / user-entered flags | `quality` (optional) | Map HK metadata (e.g. user-entered, unreliable) to `valid` \| `questionable` \| `invalid` \| `unknown` per policy. |

The file [`glucose.reading.healthkit.json`](./glucose.reading.healthkit.json) is the **canonical result** for the illustrative row above (with CGM device, optional trend/quality filled for documentation).

---

## Manual entry to OGIS glucose.reading

Manual readings are created **inside your app** (form, quick log, watch). There is no single vendor schema; adapters map **your UI model** (or a small internal JSON) to OGIS.

**Illustrative in-app payload** (not valid OGIS; shape is typical for a local save before OGT):

```json
{
  "localEntryId": "9f2c4e8a-1b3d-4c5e-9f0a-123456789abc",
  "value": 5.9,
  "unit": "mmol/L",
  "recordedAt": "2026-03-29T08:15:00.000Z",
  "appBundleId": "com.example.GlucoseAITracker"
}
```

### Field mapping (manual → OGIS)

| App / internal field | OGIS `glucose.reading` v0.1 | Notes |
|---------------------|-----------------------------|--------|
| — | `event_type` | Always `glucose.reading`. |
| — | `event_version` | Always `0.1` until schema bumps. |
| — | `subject_id` | Your stable user/subject id for the account or device. |
| User-selected or “now” time | `observed_at` | RFC 3339 **UTC**; the time the user intends for the reading. |
| — | `source_recorded_at` | Usually **omit** (same as `observed_at`) unless you track separate device vs wall time. |
| — | `received_at` (optional) | When the entry was **submitted** to sync or OGT, if distinct from `observed_at`. |
| `value` | `value` | As entered, consistent with `unit`. |
| `unit` | `unit` | **`mg/dL`** or **`mmol/L`** only. |
| — | `measurement_source` | Always **`manual`** for user-typed or user-confirmed meter entry without an automated CGM stream. |
| — | `device.type` | Often **`app`**; `manufacturer` / `model` optional (e.g. phone model if you store it). |
| `localEntryId` (or generated id) | `provenance.raw_event_id` | Stable id for dedupe/export; prefix e.g. `manual:` if you combine multiple id spaces. |
| — | `provenance.source_system` | e.g. **`app.manual`** or your bundle id reverse-DNS. |
| — | `provenance.adapter_version` | Mapper / app pipeline semver. |
| — | `provenance.ingested_at` | When the event enters **OGT / collector** (UTC). |
| — | `trend` | **Omit** for typical manual entry. |
| — | `quality` | Optional; default **`valid`** if the user attested the value, or `unknown` if unverified. |

The file [`glucose.reading.manual.json`](./glucose.reading.manual.json) matches the illustrative payload above (mmol/L, minimal `device`, no trend).

---

## Watch quick log to OGIS glucose.reading

Watch **quick log** flows are the same **manual** semantic path as phone entry (`measurement_source` **`manual`**), but the recording host is a wearable: set **`device.type`** to **`watch`** when the user confirms the value on the watch (and optionally populate `device.manufacturer` / `device.model`). This is **materially different** from [`glucose.reading.manual.json`](./glucose.reading.manual.json), which uses **`device.type` `app`** for a phone-centric example.

**`provenance.source_system`** may stay **`app.manual`** (same app family as phone) or use a distinct stable string (e.g. reverse-DNS for the watch extension); see [source-system-registry.md](../spec/core/source-system-registry.md).

The file [`glucose.reading.watch.json`](./glucose.reading.watch.json) shows **`mg/dL`**, **`watch`**, and a `watch:`-prefixed `raw_event_id` for idempotency clarity.

---

## Dexcom EGV to OGIS glucose.reading

Dexcom returns **wrapper JSON** (e.g. `recordType`, `recordVersion`, `userId`, `records: [...]`). OGIS is **one event per reading**: each element of `records` becomes **one** `glucose.reading` object.

**Illustrative vendor payload** (not valid OGIS; shown for mapping only):

```json
{
  "recordType": "egv",
  "recordVersion": "3.0",
  "userId": "5b329ebcfbf2f0ba7e49d4c5eb57775468f5ee657ac16fcde07e1fd08197b4c7",
  "records": [
    {
      "recordId": "2cab70ee-d3b4-5a34-9aa9-767513ab72bd",
      "systemTime": "2025-01-30T23:49:55Z",
      "displayTime": "2025-01-30T15:49:55-08:00",
      "value": 39,
      "unit": "mg/dL",
      "trend": "flat",
      "trendRate": 0,
      "rateUnit": "mg/dL/min",
      "status": "low",
      "transmitterGeneration": "g7",
      "transmitterId": "cdb4f8eea4392295413c64d5bc7a9e0e0ee9b215fb43c5a6d71d4431e540046b",
      "displayDevice": "iOS",
      "displayApp": "G7"
    }
  ]
}
```

### Field mapping (per `records[]` item)

| Dexcom (EGV record) | OGIS `glucose.reading` v0.1 | Notes |
|---------------------|-----------------------------|--------|
| — | `event_type` | Always `glucose.reading`. |
| — | `event_version` | Always `0.1` until schema bumps. |
| `userId` (parent) | `subject_id` | **Do not** echo raw vendor IDs in logs if policy forbids; map through your tenant’s stable subject key. Example file uses a prefixed form for clarity. |
| `systemTime` | `observed_at` | RFC 3339 **UTC** (`Z`). Primary clinical timeline for many pipelines. |
| `displayTime` | `source_recorded_at` (optional) | If you need both clocks: normalize to UTC in the string. If identical instant to `systemTime`, you may omit or duplicate per product policy. |
| — | `received_at` (optional) | When **your** service received the API response, not Dexcom’s field. |
| `value` | `value` | Same numeric magnitude; must match `unit`. |
| `unit` | `unit` | Must be `mg/dL` or `mmol/L` per schema (convert if Dexcom ever differs). |
| — | `measurement_source` | `cgm` for EGV. |
| `transmitterGeneration`, `displayApp`, … | `device.manufacturer` / `device.model` / `device.type` | e.g. manufacturer `Dexcom`, model `G7`, `device.type` `cgm`. Extra Dexcom fields (transmitter id, ticks) are **not** in v0.1 schema — preserve in sidecar, extensions, or future schema version. |
| `recordId` | `provenance.raw_event_id` | Stable idempotency key; use UUID string as returned. |
| — | `provenance.source_system` | e.g. `dexcom`. |
| — | `provenance.adapter_version` | Your mapper’s semver. |
| — | `provenance.ingested_at` | Set when the event enters **OGT / your collector** (UTC). |
| `trend` | `trend.direction` | Map Dexcom arrows/strings → OGIS enum: e.g. `flat` → `stable`; `up`/`down` → `rising`/`falling`; unknown → `unknown`. |
| `trendRate` | `trend.rate` | Same numeric value when present. |
| `rateUnit` | `trend.rate_unit` | e.g. `mg/dL/min`. |
| `status` (e.g. `low`, high, OK) | `quality.status` | OGIS allows `valid` \| `questionable` \| `invalid` \| `unknown`. Example: Dexcom `low` / out-of-range → often `questionable`; adapter policy should define each vendor code. |

The file [`glucose.reading.dexcom.json`](./glucose.reading.dexcom.json) is the **canonical result** for the sample row above (with example `ingested_at` and `quality` choice for `status: low`).

## Validate locally

```bash
npm install
npm run validate:examples
```

Same check runs in CI on push/PR (see `.github/workflows/validate-examples.yml`).

## See also

- [schemas/jsonschema/README.md](../schemas/jsonschema/README.md) — required vs optional fields  
- [spec/README.md](../spec/README.md) — time, unit, and provenance semantics  

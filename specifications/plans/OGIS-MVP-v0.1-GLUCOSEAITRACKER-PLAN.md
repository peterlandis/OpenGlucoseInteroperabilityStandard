# OGIS MVP v0.1 — Plan (GlucoseAITracker / OGT integration)

**Audience:** OGIS editors, OGT implementers, GlucoseAITracker (GLUCOSE-009)  
**Scope:** Minimum specification and machine-readable artifacts so **OGT** can validate and emit **`glucose.reading` v0.1** with no ambiguity.  
**Non-goals for MVP v0.1:** `glucose.alert`, sensor session lifecycle, FHIR mapping completeness, full conformance suite, API transport specs.

---

## Goal

Establish the **schema layer** that GlucoseAITracker and Open Glucose Telemetry depend on:

1. **Canonical `glucose.reading` event** — single JSON representation with explicit versioning.
2. **Semantic conventions** — enums and definitions referenced by the schema and OGT validators.
3. **Time, unit, and provenance rules** — enough detail for OGT normalization and tests.
4. **Examples and fixtures** — HealthKit-derived, Dexcom-derived (optional for MVP), manual entry.
5. **Alignment** with root `README.md` examples (update README when schema names differ from narrative examples).

**OGIS defines meaning; OGT implements motion.** OGIS MVP delivers the contracts OGT’s collector validates against.

---

## Relationship to Open Glucose Telemetry (OGT)

| Artifact | OGIS | OGT |
|----------|------|-----|
| `glucose.reading` JSON Schema | Authoritative source in OGIS `/schemas/jsonschema` | Imports pins; validates output |
| RFC-0001 overview | OGIS `/rfcs` | Links from OGT README |
| Example canonical JSON | OGIS `/examples` | Golden test expected outputs |
| Ingestion envelope | Not specified (OGT-owned) | OGT `/spec` |

---

## Phase 1 — MVP specification deliverables

### 1. Repository structure

```text
OpenGlucoseInteroperabilityStandard/
├── spec/
│   ├── core/
│   ├── semantic-conventions/
│   ├── event-model/
│   └── ...
├── schemas/
│   └── jsonschema/
├── examples/
├── rfcs/
├── specifications/
│   ├── plans/
│   └── tasks/
└── README.md
```

**Deliverable:** Directories created; `README.md` updated to point to `schemas/jsonschema/glucose.reading.v0_1.json` (exact filename TBD).

---

### 2. RFC-0001 — OGIS Overview (MVP slice)

Minimum sections:

- Mission, scope, **non-goals** (v0.1).
- Relationship to **OGT** (ingestion/runtime).
- Relationship to **FHIR** (informative mapping pointer only for MVP).
- Versioning: `event_version` field semantics; additive vs breaking changes.

**Deliverable:** `rfcs/RFC-0001-ogis-overview.md` (or similar naming convention).

---

### 3. `glucose.reading` schema v0.1

Align with GLUCOSE-009 intent (canonical event). **Illustrative** shape — final field names are whatever the merged schema publishes:

| Area | Contents |
|------|----------|
| Identity | `event_type` = `glucose.reading`, `event_version` = `0.1` |
| Subject | `subject_id` |
| Time | `observed_at` (required); optional `source_recorded_at`, `received_at` |
| Value | `value` (number), `unit` (`mg/dL` \| `mmol/L`) |
| Measurement | `measurement_source` (`cgm` \| `bgm` \| `manual` or OGIS enum set) |
| Device | Object: manufacturer, model, type (see semantic conventions) |
| Provenance | `source_system`, `raw_event_id`, `adapter_version`, `ingested_at` |
| Optional | `trend`, `quality` — include only if OGT MVP requires them for HealthKit parity |

**Deliverable:** `schemas/jsonschema/glucose.reading.v0_1.json` + `$id` / `$schema` + documented `required` array.

---

### 4. Semantic conventions (MVP)

Publish under `spec/semantic-conventions/`:

- `measurement_source`
- `trend.direction` (if trend object in v0.1)
- `quality.status` (if quality object in v0.1)
- `device.type` (minimal set)

**Deliverable:** One markdown registry + JSON enum constants file optional.

---

### 5. Time semantics (MVP)

Document in `spec/core/time-semantics.md`:

- Definition of `observed_at` vs `source_recorded_at` vs `received_at`
- UTC requirement
- Ordering and “future timestamp” policy
- HealthKit note: Apple sample `startDate` maps to which field

**Deliverable:** OGT references this doc for validator rules.

---

### 6. Unit semantics (MVP)

Document in `spec/core/unit-semantics.md`:

- Allowed glucose units
- Conversion formula (mg/dL ↔ mmol/L)
- Whether implementations **must** normalize storage or **may** preserve source unit (pick one for v0.1 and state normatively)

**Deliverable:** OGT normalization implements this doc only.

---

### 7. Provenance model (MVP)

Document in `spec/core/provenance.md`:

- `source_system` (e.g. `com.apple.health`, `dexcom`, `app.manual`)
- `raw_event_id` stability expectations
- `adapter_version` semver
- `ingested_at` set by OGT collector

**Deliverable:** Schema `provenance` object matches this doc.

---

### 8. Examples (fixtures for OGT / GlucoseAITracker)

Under `/examples`:

- `glucose.reading.healthkit.json`
- `glucose.reading.manual.json`
- `glucose.reading.dexcom.json` (optional if deferred)

Each file **must validate** against the v0.1 JSON Schema in CI.

---

### 9. README reconciliation

**Done for GAT v0.1:** Root `README.md` canonical and narrative “Step 2” examples use `event_version` **0.1**, `observed_at`, top-level `value`/`unit`, `device` object, and `provenance.source_system` / `ingested_at` per schema. Normative copies live under `/examples`.

---

## GlucoseAITracker consumer (GLUCOSE-009)

The app ships a **feature flag** to toggle **legacy** vs **OGT** ingestion while keeping **one insights codebase**: calculators consume **canonical `glucose.reading`-shaped data** only; with the flag off, a legacy adapter maps stored `Glucose` rows into that shape. Schema and unit/time semantics in this repo must stay stable enough for those adapters and for golden-test parity.

**App plan:** `GlucoseAITracker/specifications/plans/GLUCOSE-009-OGT-OGIS-INTEGRATION-PLAN.md`.

---

## Milestones

1. **M1:** RFC-0001 draft + repo scaffold + time/unit/provenance docs stubbed.
2. **M2:** `glucose.reading` JSON Schema v0.1 merged + semantic conventions.
3. **M3:** Examples validated in CI + README aligned.
4. **M4:** Tag **ogis-v0.1.0-schema** (or equivalent) for OGT to pin.

---

## Traceability to FEATURE.md

`FEATURE.md` uses phase **v0.1 (GAT)** for this plan. In-scope feature IDs include:

- **GOV-001** — RFC-0001 overview (MVP slice)  
- **EVT-001** — `glucose.reading` JSON Schema v0.1  
- **SEM-001** — semantic conventions registry (minimal)  
- **TUP-001, TUP-002, TUP-003** — time, unit, provenance docs  
- **CONF-002** — `/examples` validated against schema  
- **REPO-001** — repository scaffold  

**Next** (explicit non-goals or post-GAT): GOV-002, EVT-002–004, SEM-002, API-*, SEC-*, FHIR-001 (full doc), CONF-001.

---

## Document history

| Date | Change |
|------|--------|
| 2026-03-29 | Initial OGIS MVP v0.1 plan for GlucoseAITracker / OGT |
| 2026-03-29 | Noted GlucoseAITracker feature flag + unified insights on canonical model |
| 2026-03-29 | `FEATURE.md`: phase **v0.1 (GAT)** aligned; Traceability lists feature IDs |
| 2026-03-29 | Implemented: JSON Schema v0.1, RFC-0001, core + semantic docs, examples, `npm run validate:examples`, GitHub Actions |

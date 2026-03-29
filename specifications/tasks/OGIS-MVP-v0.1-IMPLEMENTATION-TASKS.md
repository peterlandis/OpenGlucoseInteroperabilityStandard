# OGIS MVP v0.1 — Implementation Tasks (GlucoseAITracker / OGT)

Companion to [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](../plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md).

**Legend:** `[ ]` open · `[x]` done

**Status:** Initial GAT v0.1 scaffold completed in-repo (schema, RFC, docs, examples, CI). Further review / tag `ogis-v0.1.0-schema` on git when ready.

---

## Track R — Repository scaffold

- [x] **OGIS-MVP-R-01** Create `spec/core`, `spec/semantic-conventions`, `spec/event-model` (minimal).
- [x] **OGIS-MVP-R-02** Create `schemas/jsonschema`, `examples`, `rfcs`.
- [x] **OGIS-MVP-R-03** Add `specifications/plans`, `specifications/tasks`; link from root `README.md`.

---

## Track G — Governance / overview

- [x] **OGIS-MVP-G-01** Draft **RFC-0001** (`rfcs/…`): mission, scope, non-goals, OGT relationship, FHIR positioning (informative).
- [x] **OGIS-MVP-G-02** Add versioning subsection: `event_version`, additive vs breaking, deprecation note (stub OK for v0.1).

---

## Track S — Schemas

- [x] **OGIS-MVP-S-01** Author **`glucose.reading` JSON Schema v0.1** under `schemas/jsonschema/` with `$id` URL or path policy documented.
- [x] **OGIS-MVP-S-02** List all `required` properties; document optional `trend` / `quality` decision for v0.1.
- [x] **OGIS-MVP-S-03** Add schema lint CI (e.g. ajv compile check) on PR.

---

## Track C — Core semantics (docs)

- [x] **OGIS-MVP-C-01** `spec/core/time-semantics.md` — `observed_at`, `source_recorded_at`, `received_at`, UTC, HealthKit mapping note.
- [x] **OGIS-MVP-C-02** `spec/core/unit-semantics.md` — allowed units, conversion, normalization policy (normative choice).
- [x] **OGIS-MVP-C-03** `spec/core/provenance.md` — provenance object fields and meanings.

---

## Track M — Semantic conventions

- [x] **OGIS-MVP-M-01** `spec/semantic-conventions/README.md` — registry of enums for v0.1.
- [x] **OGIS-MVP-M-02** Define `measurement_source` values and definitions.
- [x] **OGIS-MVP-M-03** Define `device.type` minimal set.
- [x] **OGIS-MVP-M-04** If schema includes trend/quality: define `trend.direction`, `quality.status`.

---

## Track E — Examples

- [x] **OGIS-MVP-E-01** `examples/glucose.reading.healthkit.json` — validates against schema.
- [x] **OGIS-MVP-E-02** `examples/glucose.reading.manual.json` — validates against schema.
- [x] **OGIS-MVP-E-03** (Optional) `examples/glucose.reading.dexcom.json`.
- [x] **OGIS-MVP-E-04** CI job: validate all `examples/*.json` against `glucose.reading` schema.

---

## Track D — Documentation consistency

- [x] **OGIS-MVP-D-01** Update root `README.md` canonical example to match v0.1 schema **or** mark legacy and link to `/examples`.
- [x] **OGIS-MVP-D-02** Add “Consumers” subsection: link to OGT MVP plan and GlucoseAITracker GLUCOSE-009 plan (feature flag + unified insights engine on canonical readings).

---

## Track P — Release for downstream pins

- [x] **OGIS-MVP-P-01** Tag or release label documented for OGT to pin (version file in OGT listing OGIS schema SHA or semver).
- [x] **OGIS-MVP-P-02** Update `FEATURE.md`: mark EVT-001, TUP-001–003, SEM-001, CONF-002, REPO-001, GOV-001 as in progress / complete with plan links.

---

## Follow-ups (not closed above)

- [ ] Create git tag **`ogis-v0.1.0-schema`** on the commit that contains this schema (manual step after merge).
- [ ] **GOV-002** standalone versioning policy document (still **Next** in [FEATURE.md](../../FEATURE.md)).

---

## Suggested order

1. R-01 → R-03  
2. G-01 → G-02  
3. C-01 → C-03 (can parallel with G-01)  
4. M-01 → M-04  
5. S-01 → S-03 (schema must exist before E-04)  
6. E-01 → E-04  
7. D-01 → D-02 → P-01 → P-02  

---

## Dependency note

**OGT MVP** tasks that validate canonical output should start only after **OGIS-MVP-S-01** exists (draft OK for parallel work using feature branches).

---

**Last updated:** 2026-03-29 (GAT v0.1 scaffold implemented)

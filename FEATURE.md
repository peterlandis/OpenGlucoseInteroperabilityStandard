# OGIS Feature Tracking

Feature backlog for the **Open Glucose Interoperability Standard (OGIS)** repository, formatted for the Features Kanban app. Each row is a shippable slice of the architecture; detailed task plans can branch from a single feature without splitting the spec into micro-tasks.

## Status Legend

- 🔨 **WorkInProgress** - Currently being developed
- 🧪 **Testing** - Feature is complete and being tested
- 🟢 **ReadyToMerge** - PR approved by reviewer, ready to merge
- ✅ **Complete** - Feature is complete and merged
- 📋 **Planned** - Planned but not started
- 🚫 **Blocked** - Blocked by dependencies or issues
- ⏸️ **Paused** - Temporarily paused

## Phase Legend (GlucoseAITracker / OGT integration)

- **v0.1 (GAT)** — Delivered per **[OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md)** (✅ **Complete** in table below): `glucose.reading` v0.1, RFC-0001, semantic conventions, time/unit/provenance docs, examples + CI, repo scaffold, README alignment. *Out of this slice:* `glucose.alert`, sensor/therapy shells, full API/security/FHIR/conformance packs.
- **v0.1** — Broader OGIS v0.1 backlog not required for the GAT slice (shown as **Next** when deferred).
- **Next** — After the GAT v0.1 slice
- **Later** — Governance/process or post–v0.1 waves

## Feature Categories

### 📜 Governance & Core Specification

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| GOV-001 | RFC-0001: OGIS Overview | RFC covering mission, scope, principles, ecosystem role, and relationship to OGT | v0.1 (GAT) | ✅ Complete | @peterlandis | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | [rfcs/RFC-0001-ogis-overview.md](rfcs/RFC-0001-ogis-overview.md); versioning § in RFC |
| GOV-002 | Versioning & compatibility policy | Rules for schema and event versioning, additive vs breaking changes, deprecation | Next | 📋 Planned | - | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | Full policy doc beyond RFC stub; not required for GAT MVP |
| GOV-003 | Governance & contribution guide | How RFCs are proposed, reviewed, and merged; roles and decision process | Later | 📋 Planned | - | - | Supports `/governance` and open evolution |

### 📦 Canonical Event Schemas

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| EVT-001 | `glucose.reading` schema v0.1 | Versioned canonical schema (e.g. JSON Schema) with required/optional fields, examples | v0.1 (GAT) | ✅ Complete | @peterlandis | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | [schemas/jsonschema/glucose.reading.v0_1.json](schemas/jsonschema/glucose.reading.v0_1.json) |
| EVT-002 | `glucose.alert` schema v0.1 | Alert event schema (thresholds, severities, linkage to readings where applicable) | Next | 📋 Planned | - | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | Explicit non-goal for GAT MVP v0.1 |
| EVT-003 | Sensor session lifecycle schemas | `sensor.session.started` / `sensor.session.ended` (and shared session fields) | Next | 📋 Planned | - | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | Non-goal for GAT MVP v0.1 |
| EVT-004 | `device.status` & `therapy.event` v0.1 | Minimal schemas for device state and therapy-context events (extensible shells) | Next | 📋 Planned | - | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | Non-goal for GAT MVP v0.1 |

### 🏷️ Semantic Conventions

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| SEM-001 | Semantic conventions registry v0.1 | Documented enums and meanings: e.g. `trend.direction`, `measurement_source`, `quality.status`, `device.type` | v0.1 (GAT) | ✅ Complete | @peterlandis | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | [spec/semantic-conventions/README.md](spec/semantic-conventions/README.md), [enums.v0_1.json](spec/semantic-conventions/enums.v0_1.json) |
| SEM-002 | Cross-event naming & metadata rules | Stable `event_type` patterns, subject/device identifier guidance, extension points | Next | 📋 Planned | - | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | Broader multi-event consistency; not blocking GAT MVP |

### ⏱️ Time, Units & Provenance

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| TUP-001 | Time semantics specification | Definitions and rules for observed, device-recorded, received, exported timestamps; ordering | v0.1 (GAT) | ✅ Complete | @peterlandis | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | [spec/core/time-semantics.md](spec/core/time-semantics.md) |
| TUP-002 | Unit semantics specification | Explicit glucose units (e.g. mg/dL, mmol/L), conversion rules, preserving source units | v0.1 (GAT) | ✅ Complete | @peterlandis | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | [spec/core/unit-semantics.md](spec/core/unit-semantics.md) |
| TUP-003 | Provenance model specification | Source vendor/system, raw event id, adapter/producer versions, transformation metadata | v0.1 (GAT) | ✅ Complete | @peterlandis | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | [spec/core/provenance.md](spec/core/provenance.md) |

### 🔌 API, Transport & Operations

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| API-001 | API contract draft v0.1 | Spec-level query/resource shapes that expose OGIS events (no OGT implementation here) | Next | 📋 Planned | - | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | Non-goal for GAT MVP v0.1 |
| API-002 | Transport payload expectations | Envelope or batch patterns, content types, replay/idempotency semantics at spec layer | Next | 📋 Planned | - | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | Non-goal for GAT MVP v0.1 |

### 🔐 Security & Privacy

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| SEC-001 | Security guidance v0.1 | AuthN/Z expectations, encryption in transit/at rest, audit hooks for implementations | Next | 📋 Planned | - | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | Non-goal for GAT MVP v0.1 |
| SEC-002 | Privacy guidance v0.1 | Data minimization, consent-related fields, boundaries for PII/PHI in events | Next | 📋 Planned | - | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | Non-goal for GAT MVP v0.1 |

### 🏥 Clinical Mapping

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| FHIR-001 | FHIR mapping draft v0.1 | Mapping guidance for Observation, Device, Provenance (and related) for core events | Next | 📋 Planned | - | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | GAT MVP: informative pointer in RFC only; full mapping doc Next |

### ✅ Conformance, Examples & Repository Layout

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| CONF-001 | Conformance model draft v0.1 | Definition of OGIS compatibility: required behaviors, validation, semantic checks | Next | 📋 Planned | - | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | Full conformance suite non-goal for GAT MVP v0.1 |
| CONF-002 | Example payloads & fixtures | Curated examples under `/examples` aligned to v0.1 schemas (incl. vendor→canonical narrative) | v0.1 (GAT) | ✅ Complete | @peterlandis | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | [examples/](examples/) + [examples/README.md](examples/README.md); `npm run validate:examples`; GitHub Actions |
| REPO-001 | Spec and schema repository scaffold | Create `/spec`, `/schemas/jsonschema` (and protobuf placeholder if needed), `/rfcs` per README layout | v0.1 (GAT) | ✅ Complete | @peterlandis | [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | `spec/`, `schemas/`, `rfcs/`, `scripts/`, `package.json`, `.github/workflows` |

---

## GlucoseAITracker / OGT integration (MVP v0.1)

**Status:** GAT v0.1 deliverables from the plan are **complete** in this repo (see ✅ rows above: GOV-001, EVT-001, SEM-001, TUP-001–003, CONF-002, REPO-001). OGT can pin schema + examples; GlucoseAITracker uses this contract per GLUCOSE-009 (feature-flagged pipeline + unified insights).

| Document | Purpose |
|----------|---------|
| [OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md](specifications/plans/OGIS-MVP-v0.1-GLUCOSEAITRACKER-PLAN.md) | MVP spec deliverables and milestones |
| [OGIS-MVP-v0.1-IMPLEMENTATION-TASKS.md](specifications/tasks/OGIS-MVP-v0.1-IMPLEMENTATION-TASKS.md) | Checkbox implementation tasks |
| [OGIS-MVP-v0.1-GAT-COMPLETION-SUMMARY.md](specifications/summary/OGIS-MVP-v0.1-GAT-COMPLETION-SUMMARY.md) | Completion summary (deliverables, verification, follow-ups) |

**Downstream:** **OpenGlucoseTelemetry** — see `specifications/plans/OGT-MVP-GLUCOSEAITRACKER-PIPELINE-PLAN.md` in that repository (often cloned as a sibling of this repo in GlucoseAIWorkspace).

## How to Use This File

### Adding a New Feature

1. Add a row in the appropriate category table.
2. Assign a unique Feature ID (e.g. `EVT-005`).
3. Fill Title, Description, Phase, Status, Assignee, Plan Document, and Notes.
4. Set status to `📋 Planned` until work starts.

### Updating Feature Status

1. Locate the feature row.
2. Update Status (and Assignee if ownership changes).
3. Use Notes for dependencies, blockers, or links to PRs/RFCs.

**Note:** The `🟢 ReadyToMerge` status should be assigned by the reviewer after PR approval.

### Example Workflow

```
1. Feature starts: Status = 📋 Planned, Assignee = -
2. Owner picked up: Status = 🔨 WorkInProgress, Assignee = @username
3. Spec/schema ready for review: Status = 🧪 Testing, Assignee = @username
4. Reviewer approves PR: Status = 🟢 ReadyToMerge, Assignee = @username
5. Merged: Status = ✅ Complete, Assignee = @username
```

**Last Updated:** 2026-03-29 (GAT v0.1 plan items marked ✅ Complete)  
**Maintainer:** OGIS contributors

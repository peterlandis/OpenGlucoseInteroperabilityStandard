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

## Feature Categories

### 📜 Governance & Core Specification

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| GOV-001 | RFC-0001: OGIS Overview | RFC covering mission, scope, principles, ecosystem role, and relationship to OGT | v0.1 | 📋 Planned | - | - | Entry point for readers and implementers |
| GOV-002 | Versioning & compatibility policy | Rules for schema and event versioning, additive vs breaking changes, deprecation | v0.1 | 📋 Planned | - | - | Aligns semantic versioning with event `event_version` |
| GOV-003 | Governance & contribution guide | How RFCs are proposed, reviewed, and merged; roles and decision process | Later | 📋 Planned | - | - | Supports `/governance` and open evolution |

### 📦 Canonical Event Schemas

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| EVT-001 | `glucose.reading` schema v0.1 | Versioned canonical schema (e.g. JSON Schema) with required/optional fields, examples | v0.1 | 📋 Planned | - | - | Core path; matches README exemplar |
| EVT-002 | `glucose.alert` schema v0.1 | Alert event schema (thresholds, severities, linkage to readings where applicable) | v0.1 | 📋 Planned | - | - | Pairs with readings for downstream UX |
| EVT-003 | Sensor session lifecycle schemas | `sensor.session.started` / `sensor.session.ended` (and shared session fields) | v0.1 | 📋 Planned | - | - | One deliverable for lifecycle pair |
| EVT-004 | `device.status` & `therapy.event` v0.1 | Minimal schemas for device state and therapy-context events (extensible shells) | v0.1 | 📋 Planned | - | - | Single slice for non-glucose-primary events |

### 🏷️ Semantic Conventions

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| SEM-001 | Semantic conventions registry v0.1 | Documented enums and meanings: e.g. `trend.direction`, `measurement_source`, `quality.status`, `device.type` | v0.1 | 📋 Planned | - | - | Referenced by event schemas |
| SEM-002 | Cross-event naming & metadata rules | Stable `event_type` patterns, subject/device identifier guidance, extension points | v0.1 | 📋 Planned | - | - | Keeps adapters and validators consistent |

### ⏱️ Time, Units & Provenance

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| TUP-001 | Time semantics specification | Definitions and rules for observed, device-recorded, received, exported timestamps; ordering | v0.1 | 📋 Planned | - | - | First-class time model from README |
| TUP-002 | Unit semantics specification | Explicit glucose units (e.g. mg/dL, mmol/L), conversion rules, preserving source units | v0.1 | 📋 Planned | - | - | No implicit unit assumptions |
| TUP-003 | Provenance model specification | Source vendor/system, raw event id, adapter/producer versions, transformation metadata | v0.1 | 📋 Planned | - | - | Trust, audit, and clinical alignment |

### 🔌 API, Transport & Operations

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| API-001 | API contract draft v0.1 | Spec-level query/resource shapes that expose OGIS events (no OGT implementation here) | v0.1 | 📋 Planned | - | - | Under `/spec/api-contracts` |
| API-002 | Transport payload expectations | Envelope or batch patterns, content types, replay/idempotency semantics at spec layer | v0.1 | 📋 Planned | - | - | Complements OGT without mandating a broker |

### 🔐 Security & Privacy

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| SEC-001 | Security guidance v0.1 | AuthN/Z expectations, encryption in transit/at rest, audit hooks for implementations | v0.1 | 📋 Planned | - | - | `/spec/security` |
| SEC-002 | Privacy guidance v0.1 | Data minimization, consent-related fields, boundaries for PII/PHI in events | v0.1 | 📋 Planned | - | - | `/spec/privacy` |

### 🏥 Clinical Mapping

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| FHIR-001 | FHIR mapping draft v0.1 | Mapping guidance for Observation, Device, Provenance (and related) for core events | v0.1 | 📋 Planned | - | - | Does not replace FHIR; aligns OGIS to clinical use |

### ✅ Conformance, Examples & Repository Layout

| Feature ID | Title | Description | Phase | Status | Assignee | Plan Document | Notes |
|------------|-------|-------------|-------|--------|----------|---------------|-------|
| CONF-001 | Conformance model draft v0.1 | Definition of OGIS compatibility: required behaviors, validation, semantic checks | v0.1 | 📋 Planned | - | - | Foundation for future test suites |
| CONF-002 | Example payloads & fixtures | Curated examples under `/examples` aligned to v0.1 schemas (incl. vendor→canonical narrative) | v0.1 | 📋 Planned | - | - | Supports docs and tooling |
| REPO-001 | Spec and schema repository scaffold | Create `/spec`, `/schemas/jsonschema` (and protobuf placeholder if needed), `/rfcs` per README layout | v0.1 | 📋 Planned | - | - | Index READMEs per subtree optional follow-up |

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

**Last Updated:** 2026-03-28  
**Maintainer:** OGIS contributors

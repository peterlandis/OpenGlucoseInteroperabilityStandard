# Open Glucose Interoperability Standard (OGIS)

OGIS is an open, vendor-neutral interoperability standard for defining how glucose-related data is modeled, described, exchanged, and integrated across devices, applications, and clinical systems.

## Mission

Glucose data is fragmented across proprietary vendor APIs, inconsistent application schemas, delayed synchronization paths, and incompatible data semantics. OGIS provides a common language for glucose interoperability so manufacturers, developers, providers, and researchers can integrate once and interoperate everywhere.

## Relationship to Open Glucose Telemetry (OGT)

OGIS and OGT are complementary:

- **OGIS** defines the standard
- **OGT** implements the runtime architecture that transports and operationalizes OGIS-compliant events

In simple terms:

**OGIS defines what glucose data means, and OGT defines how glucose data moves.**

## Architecture

### OGIS architecture

OGIS is the specification layer, not the runtime layer. It defines:

- Canonical schemas
- Semantic conventions
- Units and conversions
- Timestamp rules
- Provenance model
- Event definitions
- API contracts
- FHIR / clinical mappings
- Conformance rules

```text
┌──────────────────────────────────────────────────────────────────────────────┐
│           Open Glucose Interoperability Standard (OGIS)                     │
│------------------------------------------------------------------------------│
│ OGIS is the specification layer, not the runtime layer.                     │
│                                                                              │
│ It defines:                                                                  │
│ • Canonical schemas                                                          │
│ • Semantic conventions                                                       │
│ • Units and conversions                                                      │
│ • Timestamp rules                                                            │
│ • Provenance model                                                           │
│ • Event definitions                                                          │
│ • API contracts                                                              │
│ • FHIR / clinical mappings                                                   │
│ • Conformance rules                                                          │
└──────────────────────────────────────────────────────────────────────────────┘
```

### Where OGIS fits in the ecosystem

```text
┌──────────────────────────────────────────────────────────────────────────────┐
│                             Consumer Systems                                 │
│------------------------------------------------------------------------------│
│ AI apps • mobile apps • analytics • dashboards • EHRs • research systems    │
└──────────────────────────────────────────────────────────────────────────────┘
                                      ▲
                                      │ consume OGIS-compliant data
                                      │
┌──────────────────────────────────────────────────────────────────────────────┐
│                     Open Glucose Telemetry (OGT) Runtime                     │
│------------------------------------------------------------------------------│
│ Adapters • Collector • Event Bus • Query APIs • Streaming APIs • Exporters  │
│                                                                              │
│ OGT operationalizes and transports OGIS-defined events.                     │
└──────────────────────────────────────────────────────────────────────────────┘
                                      ▲
                                      │ implements
                                      │
┌──────────────────────────────────────────────────────────────────────────────┐
│          Open Glucose Interoperability Standard (OGIS) Specification         │
│------------------------------------------------------------------------------│
│ Defines the shared contract for how glucose data should be modeled, named,   │
│ validated, and exchanged.                                                    │
└──────────────────────────────────────────────────────────────────────────────┘
                                      ▲
                                      │ standardizes data from
                                      │
┌──────────────────────────────────────────────────────────────────────────────┐
│                               Source Systems                                 │
│------------------------------------------------------------------------------│
│ CGMs • glucose meters • pumps • wearables • vendor clouds • apps            │
└──────────────────────────────────────────────────────────────────────────────┘
```

### How devices use OGIS

Devices usually do not need to implement all of OGIS directly in firmware. OGIS gives device makers and integrators a **common target format**.

```text
[Device / Vendor Cloud / App]
          │
          │ raw proprietary payload
          ▼
[Adapter or Integration Layer]
          │
          │ maps source data into OGIS format
          ▼
[OGIS Canonical Event]
```

Different sources emit different shapes (for example Dexcom, Abbott, a BLE meter, or manual app entry). OGIS says: **no matter where the data came from, convert it into this shared model.**

Standard event types include:

- `glucose.reading`
- `glucose.alert`
- `sensor.session.started`
- `sensor.session.ended`
- `device.status`
- `therapy.event`

### How OGT uses OGIS

OGT is the runtime system that takes OGIS from “documented spec” to “working ecosystem.”

```text
[Raw Source Data]
      ▼
[OGT Adapter]
      ▼   maps to OGIS schema
[OGT Collector]
      ▼   validates against OGIS rules
[OGT Event Bus]
      ▼   carries OGIS-compliant events
[APIs / Exporters / Streams]
      ▼
[Apps / AI / Clinical Systems]
```

- **OGIS** defines the contract.
- **OGT** enforces and transports the contract.

### Mental model

- **OGIS** = the grammar and dictionary  
- **OGT** = the postal system and roads  

Without OGIS, everyone speaks differently. Without OGT, nobody has a common way to move the data around.

### Detailed architecture view

```text
                          ┌─────────────────────────────┐
                          │            OGIS             │
                          │-----------------------------│
                          │ Core Spec                   │
                          │ Semantic Conventions        │
                          │ Canonical Event Schemas     │
                          │ Time Semantics              │
                          │ Unit Semantics              │
                          │ Provenance Rules            │
                          │ API Contracts               │
                          │ FHIR Mappings               │
                          │ Conformance Suite           │
                          └──────────────┬──────────────┘
                                         │
                                         │ defines
                                         ▼
┌──────────────────────────────────────────────────────────────────────────────┐
│                                 OGT Runtime                                 │
│------------------------------------------------------------------------------│
│  Adapters      Collector      Event Bus      APIs      Streams    Exporters  │
│                                                                              │
│  • Vendor API  • Validate     • Fan-out      • REST    • WS       • FHIR     │
│  • BLE         • Normalize    • Replay       • gRPC    • MQTT     • Webhooks │
│  • Files       • Dedupe       • Routing                           • Warehouse │
│  • Apps        • Enrich                                            • Apps    │
└──────────────┬──────────────┬──────────────┬──────────────┬──────────────────┘
               ▲              ▲              ▲              ▲
               │              │              │              │
               └────── all produce / consume OGIS-compliant events ───────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│                                Source Systems                                │
│------------------------------------------------------------------------------│
│ CGMs • glucose meters • insulin pumps • wearables • vendor clouds • apps    │
└──────────────────────────────────────────────────────────────────────────────┘
```

### What OGIS specifies

This repository and the standard logically cover:

```text
OGIS
├── Core specification
├── Event model
│   ├── glucose.reading
│   ├── glucose.alert
│   ├── sensor.session.started
│   ├── sensor.session.ended
│   ├── device.status
│   └── therapy.event
├── Semantic conventions
│   ├── trend.direction
│   ├── measurement_source
│   ├── quality.status
│   └── device.type
├── Time semantics
├── Unit semantics
├── Provenance model
├── API contracts
├── FHIR mappings
└── Conformance rules
```

### Example: end-to-end usage

**Scenario:** An Abbott sensor reading arrives from a vendor cloud.

**Step 1 — Raw event from the device ecosystem**

```json
{
  "sg": 142,
  "u": "mg/dL",
  "time": "2026-03-28T15:05:00Z",
  "trendArrow": 3
}
```

**Step 2 — OGT adapter maps it using OGIS**

```json
{
  "event_type": "glucose.reading",
  "event_version": "1.0",
  "subject_id": "subj_123",
  "device_id": "abbott:abc123",
  "timestamp_observed": "2026-03-28T15:05:00Z",
  "timestamp_received": "2026-03-28T15:05:08Z",
  "glucose": {
    "value": 142,
    "unit": "mg/dL"
  },
  "measurement_source": "interstitial",
  "trend": {
    "direction": "rising"
  },
  "provenance": {
    "source_vendor": "Abbott",
    "raw_event_id": "raw_789",
    "adapter_version": "0.1.0"
  }
}
```

**Step 3 — OGT collector validates against OGIS**

- Schema is valid
- Required fields exist
- Units are explicit
- Timestamps are coherent
- Provenance is present

**Step 4 — OGT routes the event**

The event can flow to a mobile app, an AI meal coach, analytics, a provider dashboard, a FHIR exporter, and other consumers.

### Why OGIS matters

OGIS gives the ecosystem one shared language so that:

- Manufacturers are not forced into custom formats for every app
- Apps do not need separate logic per vendor
- OGT can operate as a common telemetry framework
- Data can be reused across consumer, AI, and clinical use cases

### At a glance

OGIS sits **above** devices and **below** applications as the shared specification layer. OGT sits **on top of** OGIS as the runtime framework that ingests device data, converts it into OGIS-compliant events, and delivers it to downstream systems.

## What OGIS Is

OGIS defines the shared interoperability contract for glucose data, including:

- canonical schemas
- semantic conventions
- timestamp and unit semantics
- provenance requirements
- API contracts
- interoperability mappings
- conformance rules

OGIS answers questions like:

- What is a glucose reading?
- How should trend direction be represented?
- How do we distinguish observed time from uploaded time?
- How should alerts, sensor states, calibrations, meals, insulin, and annotations be modeled?
- How do we preserve data lineage and provenance?
- How can glucose data map cleanly into clinical standards such as FHIR?

## What OGIS Is Not

OGIS does not:

- replace FHIR or other healthcare standards
- mandate device hardware or firmware protocols
- define manufacturer-specific transport implementations
- act as a regulatory authority

## Core Principles

- **Vendor-neutral** — not owned by any one device maker or application vendor
- **Developer-friendly** — practical and easy to implement
- **Clinically alignable** — compatible with existing healthcare interoperability models
- **Provenance-first** — all data should remain traceable to its source
- **Time-aware** — observed, device, ingest, and export times must be distinct where possible
- **Extensible** — designed to support future devices, metrics, and therapy events
- **Open governance** — intended to evolve through transparent RFCs and community input

## Scope

The initial OGIS scope includes:

- glucose readings
- glucose alerts
- device metadata
- sensor lifecycle events
- user annotations
- therapy context
- interoperability mappings
- conformance requirements

## Repository Goals

This repository will contain:

- core specifications
- canonical schemas
- semantic conventions
- transport contracts
- security and privacy guidance
- FHIR mapping guidance
- conformance rules
- RFCs and governance docs

## Proposed Repository Structure

```text
/spec
  /core
  /semantic-conventions
  /event-model
  /api-contracts
  /security
  /privacy
  /fhir-mappings
  /conformance
/schemas
  /jsonschema
  /protobuf
/rfcs
/examples
/governance
```

## Initial Deliverables

- RFC-0001: OGIS Overview
- `glucose.reading` schema v0.1
- `glucose.alert` schema v0.1
- device and sensor lifecycle schemas
- semantic conventions draft
- FHIR mapping draft
- conformance model draft

## Example Canonical Event

```json
{
  "event_type": "glucose.reading",
  "event_version": "1.0",
  "subject_id": "subj_123",
  "device_id": "dev_456",
  "timestamp_observed": "2026-03-28T14:32:00Z",
  "timestamp_received": "2026-03-28T14:33:15Z",
  "glucose": {
    "value": 142,
    "unit": "mg/dL"
  },
  "measurement_source": "interstitial",
  "trend": {
    "direction": "rising",
    "rate": 1.8,
    "unit": "mg/dL/min"
  },
  "quality": {
    "status": "valid"
  },
  "provenance": {
    "source_vendor": "example_vendor",
    "raw_event_id": "evt_789",
    "adapter_version": "0.1.0"
  }
}
```

## Status

Draft v0.1 — foundational design phase

## Vision

A world where glucose data is portable, interoperable, trusted, and easy to build on.

## License

TBD

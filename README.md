# Open Glucose Interoperability Standard (OGIS)

OGIS is an open, vendor-neutral interoperability standard for defining how glucose-related data is modeled, described, exchanged, and integrated across devices, applications, and clinical systems.

## Mission

Glucose data is fragmented across proprietary vendor APIs, inconsistent application schemas, delayed synchronization paths, and incompatible data semantics. OGIS provides a common language for glucose interoperability so manufacturers, developers, providers, and researchers can integrate once and interoperate everywhere.

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

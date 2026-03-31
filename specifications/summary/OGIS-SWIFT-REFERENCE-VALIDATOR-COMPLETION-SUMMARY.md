# OGIS — Swift reference validator package — completion summary

This document summarizes work on branch **`feat/swift-reference-validator`**: adding an **optional Swift Package** to the OGIS repo so Swift implementers can validate `glucose.reading` v0.1 payloads without adopting a full JSON Schema engine.

## What shipped

| Deliverable | Location |
|-------------|----------|
| Swift Package manifest | `Package.swift` (repo root) |
| Swift sources | `swift/Sources/OpenGlucoseInteroperabilityStandardSwift/` |
| Swift tests | `swift/Tests/OpenGlucoseInteroperabilityStandardSwiftTests/` |
| README documentation | `README.md` (“Swift reference package (optional)”) |

## Package contents

- **`JSONSchemaValidator`** — a lightweight Draft 2020-12 subset validator suitable for OGIS v0.1:
  - `required`, `additionalProperties: false`, `type`
  - `enum`, `const`, `minLength`, `exclusiveMinimum`
  - `$ref` / `$defs`
  - `format: "date-time"` (ISO8601/RFC3339, fractional + non-fractional)
  - `oneOf` / `anyOf` / `allOf`, `array/items` (future-proofing)
- **`OGISGlucoseReadingV0_1Schema`** — embedded schema string for `glucose.reading` v0.1, parsed to a schema object.
- **`OGISGlucoseReadingValidator`** — convenience APIs to validate:
  - a single JSON object payload (`validateV0_1(jsonObject:)`)
  - an array payload (`validateV0_1(jsonArrayData:)`) for producers that export batches

## Why this exists

- OGIS is primarily a **spec/schema** repo; Swift implementers frequently want a **small, dependency-free** validator for on-device apps and Swift runtimes.
- This package provides a reference implementation aligned to the normative schema and the repository’s interop guidance (especially around RFC3339 parsing behavior).

## Verification

From the repo root:

```bash
swift test
```

The test suite validates at least one OGIS example (`examples/glucose.reading.dexcom.json`) against the Swift validator.

---

**Last updated:** 2026-03-31


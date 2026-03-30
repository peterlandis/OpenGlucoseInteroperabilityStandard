# OGIS — Implementer interoperability guidance (wave 2)

**Audience:** OGIS editors, OGT and GlucoseAITracker implementers, third-party app authors emitting `glucose.reading` v0.1  
**Scope:** **Informative** (non-normative unless explicitly stated) guidance that reduces ecosystem drift: **`source_system` conventions**, **time wire encoding notes**, and **tightening examples** where helpful.  
**Non-goals:** New event types, breaking JSON Schema changes, or duplicating OGT pipeline specs (those stay in OpenGlucoseTelemetry).

---

## Problem statement

Implementations in **TypeScript (OGT)** and **Swift (GlucoseAITracker)** already consume OGIS v0.1. Field-level semantics exist in `spec/core/`, but:

- **`provenance.source_system`** has no **informative registry** of strings used in the wild—each app invents values (`dexcom`, `com.apple.health`, `app.manual`, …).
- **RFC 3339** on the wire (fractional seconds, `Z` vs offsets) causes **interop bugs** that JSON Schema alone does not catch.
- **Unit conversion** is normative (**18.018**) in [unit-semantics.md](../../spec/core/unit-semantics.md); some consumers still use **18.0**—documentation should call this out as a **conformance consideration** without immediately re-versioning the schema.

This wave adds **documentation and optional examples** so OGIS remains the **clarity layer** while OGT/GlucoseAITracker do the **motion**.

---

## Goals

1. **`source_system` registry (informative)** — Table of **recommended** strings and meanings; **not** a closed enum in v0.1 schema (additive registry doc + link from `provenance.md`).
2. **Time wire implementation notes** — Extend or companion section in `spec/core/time-semantics.md`: RFC 3339, fractional seconds, parsing fallbacks (reference Swift `ISO8601DateFormatter` / JS `Date` behavior at a high level).
3. **Conformance pointer for conversion factor** — Short subsection in `unit-semantics.md` or `examples/README.md`: **using 18.0 vs 18.018** breaks numerical parity—implementers **should** use the normative factor unless a product documents a waiver (link OGT/Swift parity matrix when available).
4. **Optional new validated example** — e.g. **Watch companion quick log** canonical JSON **if** it differs materially from `glucose.reading.manual.json`; otherwise skip and reference manual example.

---

## Deliverables

| # | Deliverable | Location |
|---|-------------|----------|
| D1 | `source_system` informative registry | `spec/core/source-system-registry.md` (new) |
| D2 | Link from provenance core doc | `spec/core/provenance.md` |
| D3 | Time wire notes | `spec/core/time-semantics.md` (new subsection) |
| D4 | Conversion factor conformance note | `spec/core/unit-semantics.md` and/or `examples/README.md` |
| D5 | Optional example JSON + validate in CI | `examples/glucose.reading.*.json` |
| D6 | Feature tracker + task checkboxes | [FEATURE.md](../../FEATURE.md), tasks file |
| D7 | Completion summary | `specifications/summary/OGIS-IMPLEMENTER-INTEROP-GUIDANCE-COMPLETION-SUMMARY.md` |

---

## Relationship to OGT / GlucoseAITracker

| Repo | Role |
|------|------|
| **OGIS (this plan)** | Clarify **meaning** and **recommended strings**; optional examples |
| **OGT** | [OGT-CROSS-RUNTIME-PARITY-AND-CONSUMER-DOCS-PLAN.md](../../../OpenGlucoseTelemetry/specifications/plans/OGT-CROSS-RUNTIME-PARITY-AND-CONSUMER-DOCS-PLAN.md) — TS vs Swift **behavior** matrix |
| **GlucoseAITracker** | May **align Swift** to OGIS 18.018 and registry strings in app PRs |

---

## Success criteria

- New implementers can choose **`source_system`** values **consistently** without reading private app source.
- Time and unit docs **explicitly** mention wire encoding and conversion pitfalls.
- `npm run validate:examples` still passes; no schema regression without RFC/version bump.

---

**Last updated:** 2026-03-30

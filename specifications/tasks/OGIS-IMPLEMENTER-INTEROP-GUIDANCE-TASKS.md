# OGIS — Implementer interoperability guidance — Implementation tasks

Companion to [OGIS-IMPLEMENTER-INTEROP-GUIDANCE-PLAN.md](../plans/OGIS-IMPLEMENTER-INTEROP-GUIDANCE-PLAN.md).

**Legend:** `[ ]` open · `[x]` done

---

## Track R — Registry & core doc links

- [x] **OGIS-IIR-R-01** Add `spec/core/source-system-registry.md` — informative table: **source_system** string | **Typical use** | **Example producers** | **Notes** (include `dexcom`, `com.apple.health`, `app.manual`, generic `unknown.cgm` pattern).
- [x] **OGIS-IIR-R-02** Update `spec/core/provenance.md` — link registry; state clearly **registry is informative**, not schema enum for v0.1.
- [x] **OGIS-IIR-R-03** Update `spec/semantic-conventions/README.md` — bullet linking **source_system** registry under provenance.

---

## Track T — Time semantics

- [x] **OGIS-IIR-T-01** Extend `spec/core/time-semantics.md` with **Wire format (RFC 3339)** subsection: UTC `Z`, fractional seconds, recommend rejecting ambiguous local strings without offset where feasible.
- [x] **OGIS-IIR-T-02** Add **Implementation notes** paragraph: JS `Date.parse`, Swift `ISO8601DateFormatter` (fractional vs non-fractional)—**informative**, not normative platform requirements.

---

## Track U — Unit semantics & examples narrative

- [x] **OGIS-IIR-U-01** Update `spec/core/unit-semantics.md` — short **Conformance** box: implementations **must** use stated factor for normative conversion; using **18.0** causes measurable drift—reference OGT/Swift parity work.
- [x] **OGIS-IIR-U-02** Update `examples/README.md` — link unit-semantics and note that examples are **valid** v0.1 documents, not normalized storage form.

---

## Track E — Optional example

- [x] **OGIS-IIR-E-01** Decide if **Watch quick log** needs distinct example; if yes, add `examples/glucose.reading.watch.json` (or similar) and row in `examples/README.md`.
- [x] **OGIS-IIR-E-02** Run `npm run validate:examples` and fix CI if new file added.

---

## Track M — Metadata & completion

- [x] **OGIS-IIR-M-01** Update [FEATURE.md](../../FEATURE.md) — set **SEM-003**, **TUP-004**, **TUP-005**, **CONF-003** to ✅ when done (or note partial).
- [x] **OGIS-IIR-M-02** Add `specifications/summary/OGIS-IMPLEMENTER-INTEROP-GUIDANCE-COMPLETION-SUMMARY.md` when wave closes.
- [x] **OGIS-IIR-M-03** Cross-link from OGT handoff `OGT-SWIFT-PARITY-MATRIX.md` to OGIS **source-system-registry**, **unit-semantics**, and **time-semantics** (sibling-repo relative paths).

---

## Suggested order

R-01 → R-02 → R-03 → T-01 → T-02 → U-01 → U-02 → (E-01 → E-02) → M-01 → M-02 → M-03 (coordinate with OGT PR)

---

**Last updated:** 2026-03-30 (wave complete)

# AGENTS.md

## Cursor Cloud specific instructions

This is a **specification-only repository** (Open Glucose Interoperability Standard). There are no runtime services, databases, or Docker containers to start.

### Development workflow

- **Install deps:** `npm install` (installs `ajv` and `ajv-formats` for JSON Schema validation)
- **Run tests/validation:** `npm run validate:examples` — validates all JSON files in `examples/` against the `glucose.reading` v0.1 schema
- **CI mirrors this exactly:** see `.github/workflows/validate-examples.yml` (Node 20, `npm ci`, `npm run validate:examples`)

### Swift reference validator (optional)

The repo includes an optional Swift package (`Package.swift`) with a reference JSON Schema validator. Run with `swift test`. Swift is **not** installed in the Cloud Agent VM by default; this is acceptable since the Swift package is supplementary.

### Key files

| Path | Purpose |
|------|---------|
| `schemas/jsonschema/glucose.reading.v0_1.json` | Normative JSON Schema (Draft 2020-12) |
| `examples/*.json` | Validated example payloads |
| `scripts/validate-examples.mjs` | Validation script (Node.js ESM) |
| `spec/` | Human-readable specification prose |
| `rfcs/` | RFC documents |

### Notes

- No linter (ESLint/Prettier) is configured; the only automated check is `npm run validate:examples`.
- The `package.json` uses `"type": "module"` (ESM).
- Node.js 20+ is required (CI uses Node 20; the VM has Node 22 which is compatible).

# JSON Schema artifacts

## `$id` policy (v0.1)

Published schemas use HTTPS `$id` URIs under:

`https://openglucoseinteroperability.org/schemas/`

Implementations may resolve schemas from this repository path for development:

`schemas/jsonschema/<name>.json`

## `glucose.reading` v0.1

| File | Description |
|------|-------------|
| [glucose.reading.v0_1.json](./glucose.reading.v0_1.json) | Canonical `glucose.reading` event, `event_version` **0.1** |

### Required properties (v0.1)

`event_type`, `event_version`, `subject_id`, `observed_at`, `value`, `unit`, `measurement_source`, `device`, `provenance`

### Optional properties (v0.1)

- `source_recorded_at`, `received_at`
- **`trend`** — optional root object for CGM trend (`direction`, optional `rate` / `rate_unit`). Omitted for BGM/manual when unknown.
- **`quality`** — optional root object (`status`). Omitted when unknown.

**OGIS-MVP-S-02 decision:** Both `trend` and `quality` are **optional** at the event root for v0.1; when present, nested fields follow `$defs` in the schema.

Downstream pins: see [../VERSION.md](../VERSION.md).

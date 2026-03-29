# Semantic conventions registry (OGIS v0.1)

Normative enums are enforced by [glucose.reading.v0_1.json](../../schemas/jsonschema/glucose.reading.v0_1.json). This document is the human-readable registry.

## `measurement_source`

| Value | Definition |
|-------|------------|
| `cgm` | Continuous glucose monitor (interstitial fluid). |
| `bgm` | Blood glucose meter (capillary blood). |
| `manual` | User-entered or app-entered without automated device classification. |

## `device.type`

| Value | Definition |
|-------|------------|
| `cgm` | Hardware CGM transmitter / sensor system. |
| `bgm` | Hardware blood glucose meter. |
| `unknown` | Class not determined. |
| `phone` | Smartphone as the recording host (e.g. HealthKit store). |
| `watch` | Wearable host. |
| `app` | Application-only context (e.g. manual entry UI). |
| `other` | Other device class. |

## `trend.direction` (when `trend` object present)

| Value | Definition |
|-------|------------|
| `rising` | Glucose increasing per source trend. |
| `falling` | Glucose decreasing per source trend. |
| `stable` | No significant change per source. |
| `unknown` | Trend not provided or not interpretable. |

## `quality.status` (when `quality` object present)

| Value | Definition |
|-------|------------|
| `valid` | Source considers reading trustworthy. |
| `questionable` | Suspect (e.g. compression, warmup). |
| `invalid` | Should not be used for clinical decisions. |
| `unknown` | Quality not specified. |

## Machine-readable mirror

Optional constants for code generation: [enums.v0_1.json](./enums.v0_1.json)

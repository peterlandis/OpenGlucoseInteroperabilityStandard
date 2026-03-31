import Foundation

public enum OGISGlucoseReadingV0_1Schema {
    public static let schemaJSONString: String = """
    {
      "$schema": "https://json-schema.org/draft/2020-12/schema",
      "$id": "https://openglucoseinteroperability.org/schemas/glucose.reading.v0_1.json",
      "title": "glucose.reading",
      "description": "OGIS canonical glucose reading event, version 0.1 (GlucoseAITracker / OGT GAT MVP).",
      "type": "object",
      "additionalProperties": false,
      "required": [
        "event_type",
        "event_version",
        "subject_id",
        "observed_at",
        "value",
        "unit",
        "measurement_source",
        "device",
        "provenance"
      ],
      "properties": {
        "event_type": { "type": "string", "const": "glucose.reading" },
        "event_version": { "type": "string", "const": "0.1" },
        "subject_id": { "type": "string", "minLength": 1 },
        "observed_at": { "type": "string", "format": "date-time" },
        "source_recorded_at": { "type": "string", "format": "date-time" },
        "received_at": { "type": "string", "format": "date-time" },
        "value": { "type": "number", "exclusiveMinimum": 0 },
        "unit": { "type": "string", "enum": ["mg/dL", "mmol/L"] },
        "measurement_source": { "type": "string", "enum": ["cgm", "bgm", "manual"] },
        "device": { "$ref": "#/$defs/device" },
        "provenance": { "$ref": "#/$defs/provenance" },
        "trend": { "$ref": "#/$defs/trend" },
        "quality": { "$ref": "#/$defs/quality" }
      },
      "$defs": {
        "device": {
          "type": "object",
          "additionalProperties": false,
          "required": ["type"],
          "properties": {
            "manufacturer": { "type": "string" },
            "model": { "type": "string" },
            "type": { "type": "string", "enum": ["cgm", "bgm", "unknown", "phone", "watch", "app", "other"] }
          }
        },
        "provenance": {
          "type": "object",
          "additionalProperties": false,
          "required": ["source_system", "raw_event_id", "adapter_version", "ingested_at"],
          "properties": {
            "source_system": { "type": "string", "minLength": 1 },
            "raw_event_id": { "type": "string", "minLength": 1 },
            "adapter_version": { "type": "string", "minLength": 1 },
            "ingested_at": { "type": "string", "format": "date-time" }
          }
        },
        "trend": {
          "type": "object",
          "additionalProperties": false,
          "properties": {
            "direction": { "type": "string", "enum": ["rising", "falling", "stable", "unknown"] },
            "rate": { "type": "number" },
            "rate_unit": { "type": "string" }
          }
        },
        "quality": {
          "type": "object",
          "additionalProperties": false,
          "properties": {
            "status": { "type": "string", "enum": ["valid", "questionable", "invalid", "unknown"] }
          }
        }
      }
    }
    """

    public static func schemaObject() throws -> [String: Any] {
        let data: Data = Data(schemaJSONString.utf8)
        let json: Any = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
        guard let dict: [String: Any] = json as? [String: Any] else {
            throw JSONSchemaValidator.ValidationError.schemaInvalid("root schema must be an object")
        }
        return dict
    }
}


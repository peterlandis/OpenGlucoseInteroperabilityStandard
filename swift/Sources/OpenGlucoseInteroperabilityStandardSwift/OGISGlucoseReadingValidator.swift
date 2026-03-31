import Foundation

public enum OGISGlucoseReadingValidator {
    /// Validate a JSON object (already parsed) for `glucose.reading` v0.1.
    public static func validateV0_1(jsonObject: [String: Any]) throws {
        let schema: [String: Any] = try OGISGlucoseReadingV0_1Schema.schemaObject()
        try JSONSchemaValidator.validate(instance: jsonObject, schema: schema)
    }

    /// Validate a JSON array payload of `glucose.reading` v0.1 events.
    public static func validateV0_1(jsonArrayData: Data) throws {
        let schema: [String: Any] = try OGISGlucoseReadingV0_1Schema.schemaObject()
        let json: Any = try JSONSerialization.jsonObject(with: jsonArrayData, options: [.fragmentsAllowed])
        guard let arr: [Any] = json as? [Any] else {
            throw JSONSchemaValidator.ValidationError.typeMismatch(expected: "array", actual: "non-array")
        }
        for item: Any in arr {
            try JSONSchemaValidator.validate(instance: item, schema: schema)
        }
    }
}


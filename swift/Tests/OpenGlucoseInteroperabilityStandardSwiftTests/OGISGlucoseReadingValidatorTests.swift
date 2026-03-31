import Foundation
import XCTest
@testable import OpenGlucoseInteroperabilityStandardSwift

final class OGISGlucoseReadingValidatorTests: XCTestCase {
    func testValidateV0_1_acceptsExampleDexcom() throws {
        let url: URL = URL(fileURLWithPath: "\(#filePath)", isDirectory: false)
        let root: URL = url.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
        let example: URL = root.appendingPathComponent("examples/glucose.reading.dexcom.json", isDirectory: false)
        let data: Data = try Data(contentsOf: example)
        let json: Any = try JSONSerialization.jsonObject(with: data, options: [.fragmentsAllowed])
        guard let object: [String: Any] = json as? [String: Any] else {
            XCTFail("Expected example to be a JSON object")
            return
        }
        try OGISGlucoseReadingValidator.validateV0_1(jsonObject: object)
    }
}


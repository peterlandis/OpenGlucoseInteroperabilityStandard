// swift-tools-version: 5.10
import PackageDescription

let package: Package = Package(
    name: "OpenGlucoseInteroperabilityStandardSwift",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
    ],
    products: [
        .library(
            name: "OpenGlucoseInteroperabilityStandardSwift",
            targets: ["OpenGlucoseInteroperabilityStandardSwift"]
        )
    ],
    targets: [
        .target(
            name: "OpenGlucoseInteroperabilityStandardSwift",
            path: "swift/Sources/OpenGlucoseInteroperabilityStandardSwift"
        ),
        .testTarget(
            name: "OpenGlucoseInteroperabilityStandardSwiftTests",
            dependencies: ["OpenGlucoseInteroperabilityStandardSwift"],
            path: "swift/Tests/OpenGlucoseInteroperabilityStandardSwiftTests"
        ),
    ]
)


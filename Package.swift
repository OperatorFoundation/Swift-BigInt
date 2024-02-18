// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "BigNumber",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "BigNumber",
            targets: ["BigNumber"]),
    ],
    dependencies: [
        .package(url: "https://github.com/OperatorFoundation/Datable", from: "4.0.1"),
        .package(url: "https://github.com/OperatorFoundation/SwiftHexTools", from: "1.2.6"),
        .package(url: "https://github.com/OperatorFoundation/Transmission", from: "1.2.11"),
        .package(url: "https://github.com/OperatorFoundation/TransmissionData", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "BigNumber",
            dependencies: [
                "Datable",
                "Transmission",
            ],
            path: "Sources"),
        .testTarget(
            name: "BigNumberTests",
            dependencies: [
                "BigNumber",
                "SwiftHexTools",
                "TransmissionData",
            ],
            path: "Tests"),
    ],
    swiftLanguageVersions: [.v5]
)

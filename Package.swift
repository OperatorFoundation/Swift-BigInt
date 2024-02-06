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
        .package(url: "https://github.com/OperatorFoundation/Datable", branch: "4.0.0"),
        .package(url: "https://github.com/OperatorFoundation/SwiftHexTools", branch: "1.2.6"),
        .package(url: "https://github.com/OperatorFoundation/Transmission", branch: "release"),
        .package(url: "https://github.com/OperatorFoundation/TransmissionData", branch: "release"),
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

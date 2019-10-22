// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "InstantMock",
    products: [
        .library(
            name: "InstantMock",
            targets: [
                "InstantMock"
            ]
        )
    ],
    targets: [
        .target(
            name: "InstantMock",
            path: "Sources"),
        .testTarget(
            name: "InstantMockTests",
            dependencies: ["InstantMock"],
            path: "Tests"),
    ],
    swiftLanguageVersions: [.v5]
)

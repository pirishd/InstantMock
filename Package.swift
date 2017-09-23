// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "InstantMock",
	targets: [
        .target(
            name: "InstantMock",
            path: "Sources"),
        .testTarget(
            name: "InstantMockTests",
            dependencies: ["InstantMock"],
            path: "Tests"),
    ]
)
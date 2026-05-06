// swift-tools-version: 6.3.1

// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-manifest-primitives open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-manifest-primitives project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

import PackageDescription

let package = Package(
    name: "swift-manifest-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(name: "Manifest Primitives", targets: ["Manifest Primitives"]),
    ],
    dependencies: [
        .package(path: "../swift-ascii-primitives"),
        .package(path: "../swift-parser-primitives"),
    ],
    targets: [
        .target(
            name: "Manifest Primitives",
            dependencies: [
                .product(name: "ASCII Primitives", package: "swift-ascii-primitives"),
                .product(name: "Parser Literal Primitives", package: "swift-parser-primitives"),
            ]
        ),
        .testTarget(
            name: "Manifest Primitives Tests",
            dependencies: [
                "Manifest Primitives",
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}

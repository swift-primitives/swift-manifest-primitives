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

import Testing
import Manifest_Primitives

extension Manifest.Configuration {
    @Suite
    struct Test {
        @Suite struct Construction {}
    }
}

extension Manifest.Configuration.Test.Construction {
    @Test
    func `Configuration constructs with all parameters`() {
        let configuration = Manifest.Configuration(
            packageRoot: "/tmp/example",
            filename: "Lint.swift",
            valueName: "manifest",
            dependencies: [
                Manifest.Dependency(
                    path: "/tmp/some-package",
                    packageName: "some-package",
                    product: "Some Product",
                    imports: ["Some_Product"]
                )
            ]
        )
        #expect(configuration.packageRoot == "/tmp/example")
        #expect(configuration.filename == "Lint.swift")
        #expect(configuration.valueName == "manifest")
        #expect(configuration.dependencies.count == 1)
        #expect(configuration.toolchain == nil)
    }

    @Test
    func `Configuration accepts an explicit toolchain override`() {
        let configuration = Manifest.Configuration(
            packageRoot: "/tmp/example",
            filename: "Lint.swift",
            valueName: "manifest",
            dependencies: [],
            toolchain: "/usr/bin/swift"
        )
        #expect(configuration.toolchain == "/usr/bin/swift")
    }
}

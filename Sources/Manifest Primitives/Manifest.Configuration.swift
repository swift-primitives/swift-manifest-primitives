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

extension Manifest {
    /// Inputs for the L3 manifest loader's primary entry point.
    ///
    /// Aggregates all parameters as a struct so callers can store
    /// and reuse a fully-specified configuration. Each field has a
    /// 1:1 mapping to a load-call parameter.
    public struct Configuration: Swift.Sendable {
        /// Filesystem path to the consumer package's root.
        ///
        /// The eval project lands under
        /// `\(root)/.build/.\(filename).eval/`.
        public let root: Swift.String

        /// Filename of the manifest at the consumer package's root,
        /// e.g., `"Lint.swift"` or `"Package.swift"`.
        public let filename: Swift.String

        /// File-scope binding the manifest declares whose value is
        /// the Output type.
        ///
        /// For example, `"manifest"` if the consumer's `Lint.swift`
        /// declares `let manifest: LintManifest = ...`.
        public let binding: Swift.String

        /// Packages whose products the driver compiles against.
        public let dependencies: [Dependency]

        /// Optional override for the swift toolchain binary path.
        ///
        /// `nil` (default) uses `/usr/bin/env swift` so the swift in
        /// the parent's `PATH` runs the driver. CI / hermetic builds
        /// SHOULD pass an absolute path to a known toolchain.
        public let toolchain: Swift.String?

        public init(
            root: Swift.String,
            filename: Swift.String,
            binding: Swift.String,
            dependencies: [Dependency],
            toolchain: Swift.String? = nil
        ) {
            self.root = root
            self.filename = filename
            self.binding = binding
            self.dependencies = dependencies
            self.toolchain = toolchain
        }
    }
}

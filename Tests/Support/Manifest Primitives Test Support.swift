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

// Manifest Primitives Test Support
//
// Re-exports `Manifest Primitives` for tests. Test-factory extension
// inits and shared fixture types will land here as the test corpus
// grows; the structural spine ([MOD-024]) lands first so cross-package
// test consumers (e.g., `swift-manifests` integration tests) can wire
// against `import Manifest_Primitives_Test_Support` from day one.

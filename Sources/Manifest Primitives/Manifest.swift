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

/// Namespace for manifest-domain abstractions used across the
/// ``Manifest_Loader`` and ``Manifest_Resolver`` modules of
/// `swift-manifests`.
///
/// A *manifest* is a file-scope `let`-bound typed value declared in a
/// Swift source file (e.g., `Lint.swift`, `Format.swift`). The
/// concrete subprocess-based loader and the chain-resolution machinery
/// both consume the abstractions defined under this namespace, but
/// neither lives at this layer — both compose at L3-Foundations on top
/// of these L1 primitives.
///
/// At L1 the namespace owns:
/// - ``Manifest/ParentDirective`` — pure byte-level parsing of
///   `// parent: <URL>` directives in a manifest's leading comment
///   lines. Returns raw URL bytes; URI typing is the consumer's
///   responsibility (URI is L2 and above).
///
/// L1 by deliberate construction is Foundation-clean per
/// `[PRIM-FOUND-001]` and does not depend on `JSON`, `URI`, `File`,
/// or any L2/L3 type. Layer abstractions that would naturally live
/// here (such as a `Manifest.Serializable` constraint on top of
/// `JSON.Serializable`) belong at the layer that owns the primitive
/// they depend on.
public enum Manifest: Swift.Sendable {}

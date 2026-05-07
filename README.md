# swift-manifest-primitives

L1-Primitives package owning the `Manifest` namespace and the
foundation-clean abstractions that higher-layer manifest modules build
on top of.

## What it is

A *manifest* in this ecosystem is a file-scope `let`-bound typed value
declared in a Swift source file (e.g., `Lint.swift`, `Format.swift`).
This package owns the abstractions that BOTH the subprocess loader and
the chain-resolution machinery consume — without itself being either
loader or resolver.

## What's here

- `Manifest` — namespace declaration.
- `Manifest.Parent.scan(in:)` — pure byte-level scan for
  `// parent: <URL>` directives in a manifest's leading comment lines.
  Returns raw URL bytes; scheme validation and URI construction are
  consumer concerns.
- `Manifest.Dependency` — a SwiftPM dep description used by the L3
  loader's driver-shim materialization (path, package name, product,
  imports). Pure struct of strings; no L2/L3 deps.
- `Manifest.Configuration` — aggregates manifest-load inputs as a
  reusable struct (`root`, `filename`, `binding`,
  `dependencies`, optional `toolchain`).

## Layer position

Layer 1 (Primitives), Foundation-clean per `[PRIM-FOUND-001]`:
no `Foundation`, no `URI` (L2), no `JSON` (L3), no `File` (L3).
Depends on `swift-ascii-primitives` and `swift-parser-primitives`
(intra-L1).

## Consumers

`swift-foundations/swift-manifests` consumes this package from both
its `Manifest Loader` and `Manifest Resolver` modules.

## Status

Pre-1.0. API may evolve as additional manifest modules surface.

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

internal import ASCII_Primitives
internal import Byte_Parser_Primitives

extension Manifest {
    /// The parent of a manifest in an inheritance chain.
    ///
    /// Manifests may declare a parent via a leading `// parent: <URL>`
    /// directive in their source file. ``Manifest/Parent`` exposes the
    /// pure byte-level scanner that extracts the parent's URL bytes
    /// from a manifest's source text. Scheme validation, URI typing,
    /// fetching, and chain walking are consumer concerns at higher
    /// layers (URI is L2; fetching and chain composition are L3).
    public enum Parent: Swift.Sendable {}
}

extension Manifest.Parent {
    /// Scan the leading lines of `source` for a `// parent: <URL>`
    /// directive and return the URL bytes of the FIRST match, or
    /// `nil` if no match is found.
    ///
    /// The returned bytes are everything after `// parent:` (modulo
    /// horizontal whitespace) up to the next whitespace boundary.
    /// They are NOT scheme-validated; the caller is responsible for
    /// prefix checks (`http://`, `https://`, `file://`) and `URI`
    /// construction.
    ///
    /// The scan terminates after the first 30 line-feed boundaries
    /// without a match. Treats absent and malformed directives
    /// identically — a chain resolver's fall-back path is the same
    /// in both cases.
    public static func scan(
        in source: borrowing Swift.String
    ) -> [Swift.UInt8]? {
        var lineBuffer: [Swift.UInt8] = []
        lineBuffer.reserveCapacity(128)
        var lineCount = 0
        for byte in source.utf8 {
            if byte == .ascii.lf {
                if let urlBytes = parse(lineBuffer[...]) {
                    return urlBytes
                }
                lineCount += 1
                if lineCount >= 30 { return nil }
                lineBuffer.removeAll(keepingCapacity: true)
            } else {
                lineBuffer.append(byte)
            }
        }
        if lineCount < 30 {
            return parse(lineBuffer[...])
        }
        return nil
    }

    @inline(__always)
    private static func parse(
        _ line: Swift.ArraySlice<Swift.UInt8>
    ) -> [Swift.UInt8]? {
        var input = Byte.Input(Swift.Array(line))

        while let first = input.first,
              first == .ascii.space || first == .ascii.tab
        {
            _ = try? input.advance()
        }

        do {
            try (Byte.Literal.Parser<Byte.Input>("// parent:")).parse(&input)
        } catch {
            return nil
        }

        while let first = input.first,
              first == .ascii.space || first == .ascii.tab
        {
            _ = try? input.advance()
        }

        var urlBytes: [Swift.UInt8] = []
        urlBytes.reserveCapacity(64)
        while let first = input.first {
            if first == .ascii.space || first == .ascii.tab || first == .ascii.cr {
                break
            }
            urlBytes.append(first)
            _ = try? input.advance()
        }
        return urlBytes.isEmpty ? nil : urlBytes
    }
}

/// Pure type-argument variant expansion engine for `@D4rtUserProxy` /
/// `@D4rtUserRelaxer` (cleanup_todos #27 / P&R #6, sub-steps a + c).
///
/// This module is deliberately analyzer-free and side-effect-free: it parses
/// the declarative variant strings carried by the user annotations and expands
/// them into concrete type-argument tuples. The bridge generator (and the
/// future user-proxy/-relaxer scanner) consume these tuples to emit the
/// per-variant proxy/relaxer cases. Keeping the parsing/expansion logic here
/// makes the `$0`/`$1` templating contract and the multi-type-parameter
/// expansion independently testable.
///
/// ## Variant syntax
///
/// A *variant* is a comma-separated list of slots, one slot per type parameter
/// of the generic base class:
///
/// - **Explicit** variant — every slot is a literal type name:
///   `'Customer, CustomerDetailForm'` → the single tuple
///   `['Customer', 'CustomerDetailForm']`.
/// - **Pattern** variant — exactly one slot carries a single-`*` wildcard (the
///   *driver* slot); every other slot is a `$0`/`$1` template:
///   `'*DO, $1Form'`. For each candidate class name matching the driver
///   pattern, the captured parts fill the template slots.
///
/// ## `$0` / `$1` semantics (confirmed 2026-06-05)
///
/// - `$0` = the **full matched name** (e.g. `CustomerDO`).
/// - `$1` = the **wildcard-captured substring** (e.g. `Customer`).
/// - A pattern allows **exactly one `*`**, at the start (`*DO` ⇒ `endsWith`
///   match) or the end (`Customer*` ⇒ `startsWith` match). Zero or more than
///   one `*` is malformed and is rejected.
/// - **Exactly one** slot per variant may carry the `*`; the rest are literals
///   or `$0`/`$1` templates.
///
/// Worked example: `'*DO, $1Form'` matched against `CustomerDO` yields
/// `$0 = CustomerDO`, `$1 = Customer`, deriving the tuple
/// `['CustomerDO', 'CustomerForm']`.
library;

/// How a [WildcardPattern] matches a candidate class name.
enum WildcardMatchKind {
  /// `Customer*` — the candidate must start with the literal portion.
  startsWith,

  /// `*DO` — the candidate must end with the literal portion.
  endsWith,
}

/// The `$0`/`$1` capture produced when a [WildcardPattern] matches a candidate.
class WildcardCapture {
  /// `$0` — the full matched name (the whole candidate).
  final String full;

  /// `$1` — the wildcard-captured substring (the candidate minus the literal).
  final String captured;

  const WildcardCapture({required this.full, required this.captured});

  /// Expand a slot template by substituting the `$0`/`$1` tokens.
  ///
  /// Literal slots (no `$` token) are returned unchanged.
  String expandTemplate(String template) =>
      template.replaceAll(r'$0', full).replaceAll(r'$1', captured);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WildcardCapture &&
          full == other.full &&
          captured == other.captured;

  @override
  int get hashCode => Object.hash(full, captured);

  @override
  String toString() => 'WildcardCapture(\$0=$full, \$1=$captured)';
}

/// A parsed single-`*` wildcard pattern for the driver slot of a variant.
class WildcardPattern {
  /// Whether the literal portion anchors the start or the end of a candidate.
  final WildcardMatchKind kind;

  /// The non-`*` portion of the pattern (may be empty for a bare `*`).
  final String literal;

  const WildcardPattern._(this.kind, this.literal);

  /// Whether [slot] contains a wildcard `*` (and is therefore a driver slot).
  static bool isPattern(String slot) => slot.contains('*');

  /// Parse a single-`*` pattern. Throws [FormatException] when the wildcard is
  /// missing, repeated, or not anchored at the start or end.
  factory WildcardPattern.parse(String raw) {
    final slot = raw.trim();
    final starCount = '*'.allMatches(slot).length;
    if (starCount == 0) {
      throw FormatException('Wildcard pattern must contain a "*": "$raw"');
    }
    if (starCount > 1) {
      throw FormatException(
        'Wildcard pattern allows exactly one "*", found $starCount: "$raw"',
      );
    }
    if (slot.startsWith('*')) {
      return WildcardPattern._(WildcardMatchKind.endsWith, slot.substring(1));
    }
    if (slot.endsWith('*')) {
      return WildcardPattern._(
        WildcardMatchKind.startsWith,
        slot.substring(0, slot.length - 1),
      );
    }
    throw FormatException(
      'Wildcard "*" must be at the start or the end of the slot: "$raw"',
    );
  }

  /// Match [candidate] against this pattern, returning the `$0`/`$1` capture,
  /// or `null` when the candidate does not match.
  WildcardCapture? match(String candidate) {
    switch (kind) {
      case WildcardMatchKind.endsWith:
        if (!candidate.endsWith(literal)) return null;
        return WildcardCapture(
          full: candidate,
          captured: candidate.substring(0, candidate.length - literal.length),
        );
      case WildcardMatchKind.startsWith:
        if (!candidate.startsWith(literal)) return null;
        return WildcardCapture(
          full: candidate,
          captured: candidate.substring(literal.length),
        );
    }
  }

  @override
  String toString() => 'WildcardPattern($kind, literal="$literal")';
}

/// A single declared type-argument variant: a list of slot templates, one per
/// type parameter of the generic base class.
///
/// Zero or one slot may carry a single-`*` wildcard (the driver slot); the rest
/// are literal type names or `$0`/`$1` templates. Use [expand] to produce the
/// concrete type-argument tuple(s).
class TypeArgVariantSpec {
  /// The raw, trimmed slot strings (length == the generic's type-param arity).
  final List<String> slots;

  /// Index of the wildcard driver slot, or `null` for an explicit variant.
  final int? driverIndex;

  /// The parsed driver pattern, or `null` for an explicit variant.
  final WildcardPattern? driver;

  const TypeArgVariantSpec._(this.slots, this.driverIndex, this.driver);

  /// Whether this variant is pattern-driven (has a `*` slot) rather than a
  /// fully-literal explicit tuple.
  bool get isPattern => driver != null;

  /// The number of type-argument slots (the generic's type-parameter arity).
  int get arity => slots.length;

  /// Parse a comma-separated variant string (`'Customer, CustomerForm'` or
  /// `'*DO, $1Form'`) into a spec.
  factory TypeArgVariantSpec.parse(String raw) =>
      TypeArgVariantSpec.fromSlots(raw.split(','));

  /// Build a spec from already-split slot strings (each is trimmed here).
  ///
  /// Throws [FormatException] when: a slot is empty; more than one slot carries
  /// a `*`; or a `$0`/`$1` template appears with no wildcard slot to capture
  /// from.
  factory TypeArgVariantSpec.fromSlots(List<String> rawSlots) {
    final slots = rawSlots.map((s) => s.trim()).toList();
    if (slots.isEmpty || slots.any((s) => s.isEmpty)) {
      throw FormatException(
        'Variant has empty type-argument slot(s): $rawSlots',
      );
    }
    final patternIndices = <int>[
      for (var i = 0; i < slots.length; i++)
        if (WildcardPattern.isPattern(slots[i])) i,
    ];
    if (patternIndices.length > 1) {
      throw FormatException(
        'A variant may carry the "*" pattern in exactly one slot, '
        'found ${patternIndices.length}: $slots',
      );
    }
    if (patternIndices.isEmpty) {
      // Explicit literal variant — $0/$1 templates require a wildcard source.
      for (final slot in slots) {
        if (slot.contains(r'$')) {
          throw FormatException(
            'Template token (\$0/\$1) requires a "*" wildcard slot in the '
            'variant: "$slot" in $slots',
          );
        }
      }
      return TypeArgVariantSpec._(slots, null, null);
    }
    final index = patternIndices.single;
    return TypeArgVariantSpec._(
      slots,
      index,
      WildcardPattern.parse(slots[index]),
    );
  }

  /// Expand this spec into concrete type-argument tuples.
  ///
  /// - Explicit variants yield exactly one tuple (their literal slots) and
  ///   ignore [candidates].
  /// - Pattern variants iterate [candidates]; for each that matches the driver
  ///   slot, every slot's `$0`/`$1` tokens are expanded (the driver slot itself
  ///   resolves to the full matched name).
  List<List<String>> expand(Iterable<String> candidates) {
    if (!isPattern) return [List<String>.from(slots)];
    final out = <List<String>>[];
    for (final candidate in candidates) {
      final capture = driver!.match(candidate);
      if (capture == null) continue;
      out.add([
        for (var i = 0; i < slots.length; i++)
          if (i == driverIndex)
            capture.full
          else
            capture.expandTemplate(slots[i]),
      ]);
    }
    return out;
  }

  @override
  String toString() =>
      'TypeArgVariantSpec($slots${isPattern ? ', driver@$driverIndex' : ''})';
}

/// Expand a list of variant specs against a candidate pool, de-duplicating the
/// resulting tuples while preserving first-seen order.
///
/// Throws [ArgumentError] when the specs do not all share the same arity (a
/// generic base has a fixed number of type parameters, so every variant for it
/// must declare the same number of slots).
List<List<String>> expandUserVariants(
  Iterable<TypeArgVariantSpec> specs,
  Iterable<String> candidates,
) {
  final specList = specs.toList();
  if (specList.isNotEmpty) {
    final arity = specList.first.arity;
    for (final spec in specList) {
      if (spec.arity != arity) {
        throw ArgumentError(
          'All variants for a generic base must share the same arity; '
          'expected $arity, found ${spec.arity} in $spec',
        );
      }
    }
  }
  final seen = <String>{};
  final out = <List<String>>[];
  for (final spec in specList) {
    for (final tuple in spec.expand(candidates)) {
      if (seen.add(tuple.join(' '))) out.add(tuple);
    }
  }
  return out;
}

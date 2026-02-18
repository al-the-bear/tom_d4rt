/// Errors for the reflection runtime.
///
/// Defines error types thrown by reflection operations.
library;

import 'type_mirror.dart';

// ═══════════════════════════════════════════════════════════════════════════
// AmbiguousNameError
// ═══════════════════════════════════════════════════════════════════════════

/// Thrown when a short name matches multiple types.
///
/// Use [qualifiedNames] to see all matching types and choose the correct one
/// using the fully qualified name.
class AmbiguousNameError extends Error {
  /// The ambiguous short name.
  final String name;

  /// The matching types.
  final List<TypeMirror<Object>> matches;

  /// Creates an [AmbiguousNameError].
  AmbiguousNameError(this.name, this.matches);

  /// The qualified names of all matching types.
  List<String> get qualifiedNames => matches.map((m) => m.qualifiedName).toList();

  @override
  String toString() {
    final matchNames = qualifiedNames.join('\n  - ');
    return 'AmbiguousNameError: "$name" matches multiple types:\n  - $matchNames';
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ReadOnlyFieldError
// ═══════════════════════════════════════════════════════════════════════════

/// Thrown when attempting to write to a read-only field.
///
/// Read-only fields are those that:
/// - Are `final` fields
/// - Only have a getter (no setter)
/// - Are computed properties
class ReadOnlyFieldError extends Error {
  /// The name of the read-only field.
  final String fieldName;

  /// The name of the owner (class, mixin, etc.) containing the field.
  final String ownerName;

  /// Creates a [ReadOnlyFieldError].
  ReadOnlyFieldError(this.fieldName, this.ownerName);

  @override
  String toString() =>
      'ReadOnlyFieldError: Field "$fieldName" in "$ownerName" is read-only';
}

// ═══════════════════════════════════════════════════════════════════════════
// UncoveredMemberError
// ═══════════════════════════════════════════════════════════════════════════

/// Thrown when attempting to invoke a member that was not covered by reflection.
///
/// Members may be uncovered because:
/// - They were explicitly excluded by filters
/// - They are from external packages not included
/// - They are private and privacy filter is enabled
/// - They exceeded the configured depth limit
class UncoveredMemberError extends Error {
  /// The name of the uncovered member.
  final String memberName;

  /// The reason the member was not covered.
  final FilterReason? reason;

  /// Creates an [UncoveredMemberError].
  UncoveredMemberError(this.memberName, [this.reason]);

  @override
  String toString() {
    final reasonStr = reason != null ? ' (reason: ${reason!.description})' : '';
    return 'UncoveredMemberError: Member "$memberName" is not covered by reflection$reasonStr';
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// UncoveredTypeError
// ═══════════════════════════════════════════════════════════════════════════

/// Thrown when attempting to access a type that was not covered by reflection.
class UncoveredTypeError extends Error {
  /// The name of the uncovered type.
  final String typeName;

  /// The reason the type was not covered.
  final FilterReason? reason;

  /// Creates an [UncoveredTypeError].
  UncoveredTypeError(this.typeName, [this.reason]);

  @override
  String toString() {
    final reasonStr = reason != null ? ' (reason: ${reason!.description})' : '';
    return 'UncoveredTypeError: Type "$typeName" is not covered by reflection$reasonStr';
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// InvalidInvocationError
// ═══════════════════════════════════════════════════════════════════════════

/// Thrown when a method/constructor invocation has invalid arguments.
class InvalidInvocationError extends Error {
  /// The name of the invokable (method, constructor).
  final String invokableName;

  /// Description of the problem.
  final String message;

  /// Creates an [InvalidInvocationError].
  InvalidInvocationError(this.invokableName, this.message);

  @override
  String toString() =>
      'InvalidInvocationError: Cannot invoke "$invokableName": $message';
}

// ═══════════════════════════════════════════════════════════════════════════
// FilterReason
// ═══════════════════════════════════════════════════════════════════════════

/// Reason why a member or type was filtered out from reflection coverage.
enum FilterReason {
  /// Not included in any coverage configuration.
  notCovered('not covered by reflection configuration'),

  /// From an external package not included in coverage.
  external('external package not included'),

  /// Explicitly excluded by a filter rule.
  excluded('explicitly excluded by filter'),

  /// Private member and privacy filter is enabled.
  private('private member excluded'),

  /// Exceeded the configured depth limit for transitive inclusion.
  depthLimited('exceeded depth limit'),

  /// From a library not included in entry points.
  libraryNotIncluded('library not in entry points'),

  /// Excluded by a custom filter predicate.
  customFilter('excluded by custom filter');

  /// Human-readable description of the filter reason.
  final String description;

  const FilterReason(this.description);

  /// Create a [FilterReason] from encoded flags.
  ///
  /// The encoding uses bit patterns to store multiple reasons efficiently
  /// in generated code.
  static FilterReason fromFlags(int flags) {
    // Decode bit pattern - lower bits indicate primary reason
    if (flags & 0x01 != 0) return FilterReason.notCovered;
    if (flags & 0x02 != 0) return FilterReason.external;
    if (flags & 0x04 != 0) return FilterReason.excluded;
    if (flags & 0x08 != 0) return FilterReason.private;
    if (flags & 0x10 != 0) return FilterReason.depthLimited;
    if (flags & 0x20 != 0) return FilterReason.libraryNotIncluded;
    if (flags & 0x40 != 0) return FilterReason.customFilter;
    return FilterReason.notCovered;
  }

  /// Encode this reason as flags for compact storage.
  int toFlags() {
    return switch (this) {
      FilterReason.notCovered => 0x01,
      FilterReason.external => 0x02,
      FilterReason.excluded => 0x04,
      FilterReason.private => 0x08,
      FilterReason.depthLimited => 0x10,
      FilterReason.libraryNotIncluded => 0x20,
      FilterReason.customFilter => 0x40,
    };
  }
}

/// OwnedElement trait for elements that belong to another element.
///
/// This trait provides ownership information for members (methods, fields, etc.)
/// that belong to a class, mixin, enum, or extension.
library;

import 'element.dart';

// ═══════════════════════════════════════════════════════════════════════════
// OwnedElement Trait
// ═══════════════════════════════════════════════════════════════════════════

/// Trait for elements that belong to another element.
///
/// Members like methods, fields, constructors belong to a type (class, enum,
/// mixin, etc.). This trait provides access to ownership information.
abstract class OwnedElement implements Element {
  /// The element that owns this member.
  ///
  /// For inherited members, this is the class where the member was declared,
  /// not the class where it was found through inheritance.
  Element? get owner;

  /// The name of the declaring type (for members).
  ///
  /// Returns the simple name of the type that declares this member.
  /// For top-level elements, this is null.
  String? get declaringTypeName;

  /// Whether this is a global (top-level) element.
  ///
  /// Returns true for top-level functions and variables,
  /// false for class/mixin members.
  bool get isGlobal;

  /// Whether this element is inherited from a supertype.
  ///
  /// Returns true if the element was not declared directly in the
  /// class where it was found, but inherited from a superclass or mixin.
  bool get isInherited;

  /// Whether this element is declared directly in its containing type.
  ///
  /// Returns true if the element was declared in the class where it
  /// was found, not inherited.
  bool get isDeclared;
}

// ═══════════════════════════════════════════════════════════════════════════
// OwnedElementMixin - Default Implementation
// ═══════════════════════════════════════════════════════════════════════════

/// Mixin providing default implementations for [OwnedElement].
mixin OwnedElementMixin implements OwnedElement {
  @override
  bool get isGlobal => owner == null;

  @override
  bool get isDeclared => !isInherited;
}

// ═══════════════════════════════════════════════════════════════════════════
// OwnedElementFilter
// ═══════════════════════════════════════════════════════════════════════════

/// Filter for [OwnedElement] elements.
class OwnedElementFilter {
  /// Filter function.
  final bool Function(OwnedElement)? filter;

  const OwnedElementFilter({this.filter});

  /// Evaluate the filter.
  bool evaluate(OwnedElement element) {
    return filter?.call(element) ?? true;
  }

  /// Filter for global (top-level) elements.
  static const OwnedElementFilter global = OwnedElementFilter(
    filter: _isGlobal,
  );

  /// Filter for non-global (member) elements.
  static const OwnedElementFilter member = OwnedElementFilter(
    filter: _isMember,
  );

  /// Filter for inherited elements.
  static const OwnedElementFilter inherited = OwnedElementFilter(
    filter: _isInherited,
  );

  /// Filter for declared (non-inherited) elements.
  static const OwnedElementFilter declared = OwnedElementFilter(
    filter: _isDeclared,
  );

  static bool _isGlobal(OwnedElement e) => e.isGlobal;
  static bool _isMember(OwnedElement e) => !e.isGlobal;
  static bool _isInherited(OwnedElement e) => e.isInherited;
  static bool _isDeclared(OwnedElement e) => e.isDeclared;

  /// Filter by owner element kind.
  static OwnedElementFilter ownerKind(ElementKind kind) => OwnedElementFilter(
        filter: (e) => e.owner?.kind == kind,
      );

  /// Filter by declaring type name.
  static OwnedElementFilter declaringType(String typeName) =>
      OwnedElementFilter(
        filter: (e) => e.declaringTypeName == typeName,
      );

  /// Combine with AND logic.
  OwnedElementFilter and(OwnedElementFilter other) => OwnedElementFilter(
        filter: (e) => evaluate(e) && other.evaluate(e),
      );

  /// Combine with OR logic.
  OwnedElementFilter or(OwnedElementFilter other) => OwnedElementFilter(
        filter: (e) => evaluate(e) || other.evaluate(e),
      );

  /// Negate this filter.
  OwnedElementFilter get not => OwnedElementFilter(
        filter: (e) => !evaluate(e),
      );
}

// ═══════════════════════════════════════════════════════════════════════════
// OwnedElementProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for [OwnedElement] elements.
class OwnedElementProcessor {
  /// Process any owned element.
  final void Function(OwnedElement)? process;

  const OwnedElementProcessor({this.process});

  /// Execute the processor.
  void execute(OwnedElement element) {
    process?.call(element);
  }
}

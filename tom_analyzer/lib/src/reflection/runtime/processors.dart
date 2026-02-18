/// Specialized processors for reflection elements.
///
/// Provides callback-based processing with type-specific dispatch.
library;

import 'class_mirror.dart';
import 'enum_mirror.dart';
import 'mixin_mirror.dart';
import 'extension_mirror.dart';
import 'extension_type_mirror.dart';
import 'type_mirror.dart';
import 'type_alias_mirror.dart';
import 'method_mirror.dart';
import 'field_mirror.dart';
import 'getter_setter_mirror.dart';
import 'constructor_mirror.dart';
import 'element.dart';

// ═══════════════════════════════════════════════════════════════════════════
// TypeProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for all type mirror kinds with type-specific dispatch.
///
/// Example:
/// ```dart
/// final processor = TypeProcessor(
///   onClass: (cls) => print('Class: ${cls.name}'),
///   onEnum: (e) => print('Enum: ${e.name}'),
/// );
///
/// for (final type in reflectionApi.allTypeElements) {
///   processor.process(type as TypeMirror);
/// }
/// ```
class TypeProcessor {
  /// Callback for [ClassMirror] types.
  final void Function(ClassMirror<Object>)? onClass;

  /// Callback for [EnumMirror] types.
  final void Function(EnumMirror<Object>)? onEnum;

  /// Callback for [MixinMirror] types.
  final void Function(MixinMirror<Object>)? onMixin;

  /// Callback for [ExtensionTypeMirror] types.
  final void Function(ExtensionTypeMirror<Object>)? onExtensionType;

  /// Callback for [ExtensionMirror] types.
  final void Function(ExtensionMirror<Object>)? onExtension;

  /// Callback for [TypeAliasMirror] types.
  final void Function(TypeAliasMirror)? onTypeAlias;

  /// Callback for any unhandled element (fallback).
  final void Function(Element)? onUnhandled;

  /// Creates a [TypeProcessor] with type-specific callbacks.
  const TypeProcessor({
    this.onClass,
    this.onEnum,
    this.onMixin,
    this.onExtensionType,
    this.onExtension,
    this.onTypeAlias,
    this.onUnhandled,
  });

  /// Process an element, dispatching to the appropriate callback.
  ///
  /// Accepts [TypeMirror], [ExtensionMirror], or [TypeAliasMirror].
  void process(Element element) {
    if (element is ClassMirror<Object>) {
      if (onClass != null) {
        onClass!(element);
      } else {
        onUnhandled?.call(element);
      }
    } else if (element is EnumMirror<Object>) {
      if (onEnum != null) {
        onEnum!(element);
      } else {
        onUnhandled?.call(element);
      }
    } else if (element is MixinMirror<Object>) {
      if (onMixin != null) {
        onMixin!(element);
      } else {
        onUnhandled?.call(element);
      }
    } else if (element is ExtensionTypeMirror<Object>) {
      if (onExtensionType != null) {
        onExtensionType!(element);
      } else {
        onUnhandled?.call(element);
      }
    } else if (element is ExtensionMirror<Object>) {
      if (onExtension != null) {
        onExtension!(element);
      } else {
        onUnhandled?.call(element);
      }
    } else if (element is TypeAliasMirror) {
      if (onTypeAlias != null) {
        onTypeAlias!(element);
      } else {
        onUnhandled?.call(element);
      }
    } else {
      onUnhandled?.call(element);
    }
  }

  /// Process all elements in a collection.
  void processAll(Iterable<Element> elements) {
    for (final element in elements) {
      process(element);
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// MemberProcessor
// ═══════════════════════════════════════════════════════════════════════════

/// Processor for all member mirror kinds with type-specific dispatch.
///
/// Example:
/// ```dart
/// final processor = MemberProcessor(
///   onMethod: (m) => print('Method: ${m.name}'),
///   onField: (f) => print('Field: ${f.name}'),
/// );
///
/// for (final member in classMirror.allMembers) {
///   processor.process(member);
/// }
/// ```
class MemberProcessor {
  /// Callback for [MethodMirror] members.
  final void Function(MethodMirror<Object?>)? onMethod;

  /// Callback for [FieldMirror] members.
  final void Function(FieldMirror<Object?>)? onField;

  /// Callback for [GetterMirror] members.
  final void Function(GetterMirror<Object?>)? onGetter;

  /// Callback for [SetterMirror] members.
  final void Function(SetterMirror<Object?>)? onSetter;

  /// Callback for [ConstructorMirror] members.
  final void Function(ConstructorMirror<Object>)? onConstructor;

  /// Callback for any unhandled member (fallback).
  final void Function(Element)? onUnhandled;

  /// Creates a [MemberProcessor] with member-specific callbacks.
  const MemberProcessor({
    this.onMethod,
    this.onField,
    this.onGetter,
    this.onSetter,
    this.onConstructor,
    this.onUnhandled,
  });

  /// Process an element, dispatching to the appropriate callback.
  void process(Element member) {
    if (member is MethodMirror<Object?>) {
      if (onMethod != null) {
        onMethod!(member);
      } else {
        onUnhandled?.call(member);
      }
    } else if (member is FieldMirror<Object?>) {
      if (onField != null) {
        onField!(member);
      } else {
        onUnhandled?.call(member);
      }
    } else if (member is GetterMirror<Object?>) {
      if (onGetter != null) {
        onGetter!(member);
      } else {
        onUnhandled?.call(member);
      }
    } else if (member is SetterMirror<Object?>) {
      if (onSetter != null) {
        onSetter!(member);
      } else {
        onUnhandled?.call(member);
      }
    } else if (member is ConstructorMirror<Object>) {
      if (onConstructor != null) {
        onConstructor!(member);
      } else {
        onUnhandled?.call(member);
      }
    } else {
      onUnhandled?.call(member);
    }
  }

  /// Process all members in a collection.
  void processAll(Iterable<Element> members) {
    for (final member in members) {
      process(member);
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ElementVisitor
// ═══════════════════════════════════════════════════════════════════════════

/// Comprehensive visitor for all reflection elements.
///
/// Combines [TypeProcessor] and [MemberProcessor] for processing any element.
class ElementVisitor {
  /// Processor for type elements.
  final TypeProcessor? typeProcessor;

  /// Processor for member elements.
  final MemberProcessor? memberProcessor;

  /// Callback for unhandled elements.
  final void Function(Element)? onUnhandled;

  /// Creates an [ElementVisitor] with type and member processors.
  const ElementVisitor({
    this.typeProcessor,
    this.memberProcessor,
    this.onUnhandled,
  });

  /// Visit an element, dispatching to the appropriate processor.
  void visit(Element element) {
    if (element is TypeMirror<Object>) {
      if (typeProcessor != null) {
        typeProcessor!.process(element);
      } else {
        onUnhandled?.call(element);
      }
    } else if (element is MethodMirror<Object?> ||
        element is FieldMirror<Object?> ||
        element is GetterMirror<Object?> ||
        element is SetterMirror<Object?> ||
        element is ConstructorMirror<Object>) {
      if (memberProcessor != null) {
        memberProcessor!.process(element);
      } else {
        onUnhandled?.call(element);
      }
    } else {
      onUnhandled?.call(element);
    }
  }

  /// Visit all elements in a collection.
  void visitAll(Iterable<Element> elements) {
    for (final element in elements) {
      visit(element);
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Collecting Processors
// ═══════════════════════════════════════════════════════════════════════════

/// A processor that collects elements into lists by type.
class CollectingTypeProcessor {
  /// Collected class mirrors.
  final List<ClassMirror<Object>> classes = [];

  /// Collected enum mirrors.
  final List<EnumMirror<Object>> enums = [];

  /// Collected mixin mirrors.
  final List<MixinMirror<Object>> mixins = [];

  /// Collected extension type mirrors.
  final List<ExtensionTypeMirror<Object>> extensionTypes = [];

  /// Collected extension mirrors.
  final List<ExtensionMirror<Object>> extensions = [];

  /// Collected type alias mirrors.
  final List<TypeAliasMirror> typeAliases = [];

  /// Get the processor for collecting.
  TypeProcessor get processor => TypeProcessor(
        onClass: classes.add,
        onEnum: enums.add,
        onMixin: mixins.add,
        onExtensionType: extensionTypes.add,
        onExtension: extensions.add,
        onTypeAlias: typeAliases.add,
      );

  /// Process an element, collecting it into the appropriate list.
  void process(Element element) => processor.process(element);

  /// Process all elements, collecting them into lists.
  void processAll(Iterable<Element> elements) {
    for (final element in elements) {
      process(element);
    }
  }

  /// Clear all collected elements.
  void clear() {
    classes.clear();
    enums.clear();
    mixins.clear();
    extensionTypes.clear();
    extensions.clear();
    typeAliases.clear();
  }
}

/// A processor that collects members into lists by type.
class CollectingMemberProcessor {
  /// Collected method mirrors.
  final List<MethodMirror<Object?>> methods = [];

  /// Collected field mirrors.
  final List<FieldMirror<Object?>> fields = [];

  /// Collected getter mirrors.
  final List<GetterMirror<Object?>> getters = [];

  /// Collected setter mirrors.
  final List<SetterMirror<Object?>> setters = [];

  /// Collected constructor mirrors.
  final List<ConstructorMirror<Object>> constructors = [];

  /// Get the processor for collecting.
  MemberProcessor get processor => MemberProcessor(
        onMethod: methods.add,
        onField: fields.add,
        onGetter: getters.add,
        onSetter: setters.add,
        onConstructor: constructors.add,
      );

  /// Process a member, collecting it into the appropriate list.
  void process(Element member) => processor.process(member);

  /// Process all members, collecting them into lists.
  void processAll(Iterable<Element> members) {
    for (final member in members) {
      process(member);
    }
  }

  /// Clear all collected elements.
  void clear() {
    methods.clear();
    fields.clear();
    getters.clear();
    setters.clear();
    constructors.clear();
  }
}

import 'package:tom_d4rt/d4rt.dart';

// ghissues73: a write into a collection the script created with written type
// arguments (`<String>[]`, `<String, int>{}`, `Map<String, int>()`) is
// checked against them, as Dart's covariance check does at run time:
// `(<String>[] as dynamic).add(1)` throws
// `type 'int' is not a subtype of type 'String' of 'value'`.
//
// Only a collection with recorded arguments (ghissues67) is checked; an
// untyped literal, a native collection, and native code writing into the same
// object are not. An `int` into a `double` collection widens, as an integer
// literal does in Dart's typed context: the interpreter cannot tell
// `(d as dynamic).add(1)` (Dart: TypeError) from `d.add(1)` (Dart: 1.0).

/// [value] as it may be written at type-argument position [index] of
/// [collection] - unchanged, or an `int` widened to `double` - or throws a
/// [D4rtTypeError] naming the parameter [parameter] as the SDK does.
Object? checkWrittenElement(
  InterpreterVisitor visitor,
  Object? collection,
  int index,
  Object? value,
  String parameter,
) {
  final native = collection is BridgedInstance
      ? collection.nativeObject
      : collection;
  final arguments = writtenCollectionTypeArgumentsOf(native);
  if (arguments == null || index >= arguments.length) return value;
  final expected = arguments[index];
  final name = expected.name;
  if (isTopTypeName(name) || expected is TypeParameter) return value;
  if (value == null) {
    if (expected is NullableRuntimeType || name == 'Null') return null;
    throw D4rtTypeError(
      "type 'Null' is not a subtype of type '$name' of '$parameter'",
    );
  }
  final inner = expected is NullableRuntimeType ? expected.inner : expected;
  if (inner is TypeParameter) return value;
  final innerName = inner.name;
  if (innerName == 'Object' || innerName == 'Function') return value;
  if (innerName == 'double' && value is int) return value.toDouble();
  final base = inner is AppliedRuntimeType ? inner.baseType : inner;
  final RuntimeType? valueType;
  try {
    valueType = visitor.environment.getRuntimeType(value);
  } catch (_) {
    return value;
  }
  if (valueType == null || valueType is TypeParameter) return value;
  if (valueType.isSubtypeOf(base, value: value)) return value;
  final behind = D4.interpretedBehind(value);
  if (behind != null) {
    try {
      final behindType = visitor.environment.getRuntimeType(behind);
      if (behindType != null && behindType.isSubtypeOf(base, value: behind)) {
        return value;
      }
    } catch (_) {
      return value;
    }
  }
  throw D4rtTypeError(
    "type '${valueType.name}' is not a subtype of type '$name' of "
    "'$parameter'",
  );
}

/// The elements of [elements] as [checkWrittenElement] lets them be written
/// at position [index] of [collection], unwrapped from their bridge
/// wrappers. When [elements] is itself a written collection, its type
/// argument is checked first, as Dart checks the argument's type
/// (`<Object>['s']` is not an `Iterable<String>`, whatever it holds).
List<Object?> checkWrittenElements(
  InterpreterVisitor visitor,
  Object? collection,
  int index,
  Iterable elements,
  String parameter,
) {
  checkWrittenArgument(collection, elements, parameter);
  return [
    for (final element in elements)
      checkWrittenElement(
        visitor,
        collection,
        index,
        element is BridgedInstance ? element.nativeObject : element,
        parameter,
      ),
  ];
}

/// Throws when [argument] - an iterable or a map passed to [collection]'s
/// `addAll`, `insertAll`, ... - is a written collection whose type arguments
/// are not [collection]'s, as Dart's argument check does: `<Object>['s']`
/// passed to a `List<String>`'s `addAll` is refused. An argument without written type arguments is checked
/// element by element by the caller.
void checkWrittenArgument(
  Object? collection,
  Object? argument,
  String parameter,
) {
  final native = collection is BridgedInstance
      ? collection.nativeObject
      : collection;
  final expected = writtenCollectionTypeArgumentsOf(native);
  final arg = argument is BridgedInstance ? argument.nativeObject : argument;
  final given = writtenCollectionTypeArgumentsOf(arg);
  if (expected == null || given == null) return;
  // A map's argument is a map (both arguments); a list's or set's is an
  // iterable of its element type.
  final pairs = native is Map && arg is Map ? 2 : 1;
  if (given.length < pairs || expected.length < pairs) return;
  for (var i = 0; i < pairs; i++) {
    if (!writtenTypeArgumentIsSubtype(given[i], expected[i])) {
      final wanted = native is Map
          ? 'Map<${expected[0].name}, ${expected[1].name}>'
          : 'Iterable<${expected[0].name}>';
      throw D4rtTypeError(
        "type '${WrittenCollectionType.of(arg)}' is not a subtype of type "
        "'$wanted' of '$parameter'",
      );
    }
  }
}

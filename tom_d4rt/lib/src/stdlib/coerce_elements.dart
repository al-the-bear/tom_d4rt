import 'package:tom_d4rt/d4rt.dart';

/// Coerces an adapter argument that the SDK expects as `Iterable<E>`.
///
/// **Why a bare cast is not enough.** d4rt evaluates a list literal to
/// `List<Object?>` — element types are erased — and elements that came from
/// bridged code arrive as `BridgedInstance` wrappers. So
/// `positionalArgs[n] as Iterable<int>` throws `_TypeError` on
/// `l.setAll(0, [7, 8])` even though every element really is an `int`. The
/// same call with a typed-data argument (`l.setAll(0, Uint8List.fromList([7,
/// 8]))`) passes the cast, which is why the bug survived: the natural
/// spot-check uses the typed form.
///
/// **Why it matters twice over.** On a member that should succeed, the failed
/// cast simply kills the script. On a length-*changing* member it is worse:
/// the cast throws *before* the native call, so the `UnsupportedError` that a
/// fixed-length list would have raised never happens, and a script written as
///
///     try { list.addAll(more); } on UnsupportedError { … }
///
/// dies instead of taking its recovery path.
///
/// An element whose type genuinely does not match still fails — this widens
/// nothing. `Float32List.setAll(0, [7, 8])` (ints into a `double` list) is a
/// type error in Dart and stays one here.
List<E> coerceElements<E>(Object? arg, String member) {
  final value = arg is BridgedInstance ? arg.nativeObject : arg;
  if (value is Iterable<E>) return value.toList();
  if (value is Iterable) {
    return value.map<E>((element) {
      final unwrapped = element is BridgedInstance
          ? element.nativeObject
          : element;
      if (unwrapped is E) return unwrapped;
      // SCD29: an `int` where a `double` is wanted. This is not a widening —
      // it is what DART does. In a context expecting `double`, an integer
      // literal IS a double: `Float32List.fromList([1, 2])`,
      // `l.setAll(0, [7, 8])` and `l.followedBy([9])` all compile, verified
      // against the analyzer. Rejecting them made valid Dart fail here, which
      // is the SCD26 defect shape rather than the must-not-widen one.
      //
      // THE LIMIT IS REAL AND WORTH STATING. Dart accepts the LITERAL and
      // rejects a genuine `List<int>` variable. d4rt erases element types, so
      // `[7, 8]` and a `List<int>` arrive here indistinguishable, and no rule
      // written at this point can separate them. Accepting is the side that
      // admits the common, valid script; rejecting is the side that breaks it.
      // The residue — a `List<int>` variable that Dart would refuse — is a
      // known consequence of erasure, not an oversight.
      //
      // AND IT CANNOT BE LIFTED BY CARRYING THE TYPE, which is the obvious
      // next thought and was measured rather than left open (SCE72). The
      // analyzer does separate the two — resolved, `[1, 2]` is `List<double>`
      // and `ints` is `List<int>` — but only under RESOLUTION. Every parse in
      // this repo, both interpreters and the bundler, calls `parseString`,
      // where `staticType` is null on both. So the mirror is not failing to
      // carry something; it was never computed. Nor could it be at interpret
      // time: `execute(source:)` takes a string with no file, and the Flutter
      // line runs a bundle on a device with no analyzer.
      //
      // The bundler COULD resolve — it has a path — and it still would not
      // help: this helper is shared by both lines and cannot know whether its
      // caller came from a resolved bundle, so using a bundle-only type would
      // make the Flutter line stricter than the source line for the same
      // script. That divergence is what the mirror rule forbids. See
      // `tom_d4rt/doc/stdlib_sdk_gap_audit.md`, "Could the bundle carry the
      // static type?".
      //
      // Deliberately narrow: only `int` -> `double`, only when that is what
      // `E` is. `double` -> `int` is lossy and stays refused, and no other
      // numeric pair is converted.
      if (unwrapped is int && <E>[] is List<double>) {
        return unwrapped.toDouble() as E;
      }
      throw RuntimeD4rtException(
        "$member expects an Iterable<$E>, but an element was "
        "${unwrapped.runtimeType}.",
      );
    }).toList();
  }
  throw RuntimeD4rtException(
    "$member expects an Iterable<$E>, got ${value.runtimeType}.",
  );
}

/// Coerces an adapter argument that the SDK expects as `Map<K, V>`.
///
/// The `Iterable` sibling above explains the defect; a map literal has it
/// twice over. d4rt evaluates `{'a': 'b'}` to `Map<Object?, Object?>`, so
/// `namedArgs['queryParameters'] as Map<String, dynamic>?` throws
/// `_TypeError` on `Uri(queryParameters: {'a': 'b'})` even though every key
/// really is a `String` — and the natural spot-check, passing a map built by
/// bridged code, passes the cast.
///
/// Null passes through, because every call site that needs this takes an
/// optional named argument and `null` means "not supplied" rather than "empty".
///
/// KEYS AND VALUES ARE BOTH RE-CHECKED, and neither is widened. A key whose
/// type genuinely does not fit still fails: `Uri(queryParameters: {1: 'b'})` is
/// a type error in Dart and stays one here. Widening would make a script green
/// that cannot compile as Dart, which is the one bridge defect no passing test
/// can catch.
Map<K, V>? coerceMapArg<K, V>(Object? arg, String member) {
  final value = arg is BridgedInstance ? arg.nativeObject : arg;
  if (value == null) return null;
  if (value is Map<K, V>) return value;
  if (value is Map) {
    final out = <K, V>{};
    value.forEach((key, element) {
      final k = key is BridgedInstance ? key.nativeObject : key;
      final v = element is BridgedInstance ? element.nativeObject : element;
      if (k is! K) {
        throw RuntimeD4rtException(
          "$member expects a Map<$K, $V>, but a key was ${k.runtimeType}.",
        );
      }
      if (v is! V) {
        throw RuntimeD4rtException(
          "$member expects a Map<$K, $V>, but a value was ${v.runtimeType}.",
        );
      }
      out[k] = v;
    });
    return out;
  }
  throw RuntimeD4rtException(
    "$member expects a Map<$K, $V>, got ${value.runtimeType}.",
  );
}

/// The nullable sibling of [coerceElements], for optional named arguments.
///
/// Same rules, same refusal to widen; `null` means "not supplied".
List<E>? coerceElementsOrNull<E>(Object? arg, String member) =>
    arg == null ? null : coerceElements<E>(arg, member);

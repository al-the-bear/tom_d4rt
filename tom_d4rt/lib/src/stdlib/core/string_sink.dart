import 'package:tom_d4rt/d4rt.dart';

/// `dart:core`'s `StringSink`.
///
/// **There is deliberately no `isAssignable` predicate, and it is not an
/// oversight.** SCC77 was filed to add one, on the reasoning that without it
/// "a native object is never recognised as a `StringSink`". That was true when
/// it was written and is not any more: SCC56 declared the supertype edges
/// (`StringBuffer -> StringSink`, `IOSink -> StreamSink, StringSink`) and those
/// carry the whole answer. Measured 2026-09-06 with the predicate added and
/// then removed again, resolution is IDENTICAL either way —
///
///     StringBuffer         -> StringBuffer
///     stdout               -> Stdout
///     ClosableStringSink   -> ClosableStringSink
///
/// — because every `StringSink` the stdlib can hand a script already has a more
/// specific bridge of its own. The predicate would be a no-op today and a
/// latent hazard tomorrow: it is what lets a bridge win the `isAssignable`
/// fallback pass, so the first stdlib type that implements `StringSink` without
/// its own bridge would start resolving HERE and lose whatever members its real
/// class declares. That is the SCB26 failure shape, arriving from the other
/// direction. `core_hierarchy.dart` makes the same argument for `Comparable`
/// and `Pattern`, which are predicate-free for the same reason.
///
/// Add one only with a value in hand that needs it, and pin that value.
class StringSinkCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: StringSink,
    name: 'StringSink',
    typeParameterCount: 0,
    constructors: {},
    methods: {
      'write': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException(
            'StringSink.write requires exactly one argument.',
          );
        }
        (target as StringSink).write(positionalArgs[0]);
        return null;
      },
      'writeln': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length > 1) {
          throw RuntimeD4rtException(
            'StringSink.writeln takes at most one argument.',
          );
        }
        (target as StringSink).writeln(positionalArgs.get<Object?>(0) ?? "");
        return null;
      },
      'writeAll': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty ||
            positionalArgs.length > 2 ||
            positionalArgs[0] is! Iterable) {
          throw RuntimeD4rtException(
            'StringSink.writeAll requires an Iterable and an optional separator String.',
          );
        }
        (target as StringSink).writeAll(
          positionalArgs[0] as Iterable,
          positionalArgs.get<String?>(1) ?? "",
        );
        return null;
      },
      'writeCharCode': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! int) {
          throw RuntimeD4rtException(
            'StringSink.writeCharCode requires one integer argument.',
          );
        }
        (target as StringSink).writeCharCode(positionalArgs[0] as int);
        return null;
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as StringSink).toString(),
    },
    getters: {
      'hashCode': (visitor, target) => (target as StringSink).hashCode,
      'runtimeType': (visitor, target) => (target as StringSink).runtimeType,
    },
  );
}

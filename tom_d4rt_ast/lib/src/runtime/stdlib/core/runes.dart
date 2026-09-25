import 'package:tom_d4rt_ast/runtime.dart';
import '../coerce_elements.dart';

class RunesCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Runes,
    name: 'Runes',
    isAssignable: (v) => v is Runes,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        return Runes(positionalArgs[0] as String);
      },
    },
    methods: {
      // SCE185 deleted thirteen callback members from here — `any`, `every`,
      // `expand`, `firstWhere`, `lastWhere`, `singleWhere`, `forEach`, `map`,
      // `where`, `skipWhile`, `takeWhile`, `fold`, `reduce`. Each cast its
      // callback with `as bool Function(int)` (or similar), and a script's
      // callback is a `Callable`, never a Dart function, so every one of them
      // threw a host `_TypeError` on every call: `'abc'.runes.where(...)` could
      // not run. The inherited `Iterable` adapters take the `Callable` and are
      // right. Nothing replaces them; do not add them back.
      'contains': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Runes.contains', atMost: 1);
        return (target as Runes).contains(positionalArgs[0]);
      },
      'elementAt': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Runes.elementAt', atMost: 1);
        return (target as Runes).elementAt(positionalArgs[0] as int);
      },
      'whereType': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Runes).whereType();
      },
      'skip': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Runes.skip', atMost: 1);
        return (target as Runes).skip(positionalArgs[0] as int);
      },
      'take': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Runes.take', atMost: 1);
        return (target as Runes).take(positionalArgs[0] as int);
      },
      'toList': (visitor, target, positionalArgs, namedArgs, _) {
        final growable = namedArgs['growable'] as bool? ?? true;
        return (target as Runes).toList(growable: growable);
      },
      'toSet': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Runes).toSet();
      },
      'join': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Runes.join', atMost: 1);
        final separator = positionalArgs.isNotEmpty
            ? positionalArgs[0] as String
            : '';
        return (target as Runes).join(separator);
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Runes).toString();
      },
      'cast': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Runes).cast();
      },
      'followedBy': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Runes.followedBy', atMost: 1);
        return (target as Runes).followedBy(
          coerceElements<int>(positionalArgs[0], 'Runes.followedBy'),
        );
      },
    },
    getters: {
      'iterator': (visitor, target) => (target as Runes).iterator,
      'length': (visitor, target) {
        return (target as Runes).length;
      },
      'isEmpty': (visitor, target) {
        return (target as Runes).isEmpty;
      },
      'isNotEmpty': (visitor, target) {
        return (target as Runes).isNotEmpty;
      },
      'first': (visitor, target) {
        return (target as Runes).first;
      },
      'last': (visitor, target) {
        return (target as Runes).last;
      },
      'single': (visitor, target) {
        return (target as Runes).single;
      },
      'string': (visitor, target) {
        return (target as Runes).string;
      },
      'hashCode': (visitor, target) {
        return (target as Runes).hashCode;
      },
      'runtimeType': (visitor, target) {
        return (target as Runes).runtimeType;
      },
    },
  );
}

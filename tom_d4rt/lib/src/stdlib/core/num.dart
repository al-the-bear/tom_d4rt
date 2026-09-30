import 'package:tom_d4rt/d4rt.dart';

class NumCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: num,
    name: 'num',
    isAssignable: (v) => v is num,
    typeParameterCount: 0,
    constructors: {},
    staticMethods: {
      'parse': (visitor, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'num.parse', atMost: 2);
        final source = positionalArgs[0] as String;
        // SCF36: the SDK's deprecated second parameter, `onError`, was
        // accepted and ignored. It is honoured by the behaviour it names —
        // called with the input when the input does not parse — rather than
        // by passing it to the deprecated parameter.
        final onError = positionalArgs.length > 1
            ? positionalArgs[1] as Callable?
            : null;
        if (onError == null) return num.parse(source);
        return num.tryParse(source) ?? onError.call(visitor, [source]);
      },
      'tryParse': (visitor, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'num.tryParse', atMost: 1);
        return num.tryParse(positionalArgs[0] as String);
      },
    },
    // SCE233: NO INSTANCE MEMBERS, on purpose. Every `num` value is an `int` or
    // a `double`; Dart forbids any other class to extend or implement `num`,
    // and both of those bridges declare every `num` instance member
    // themselves. So no value ever resolves to this bridge and no member lookup
    // falls through to it. The 32 adapters that used to be here had never run
    // (SCD197), and an unreachable list is where drift hides (SCB26).
    //
    // A new `num` member belongs on the `int` AND `double` bridges.
    // F-SCE233-1 in `scc24_native_name_coverage_test.dart` checks that both
    // still declare every member this list held. The bridge stays for
    // `is num`, `num.parse` and `num.tryParse`.
  );
}

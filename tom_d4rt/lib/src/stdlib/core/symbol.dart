import 'package:tom_d4rt/d4rt.dart';

class SymbolCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: Symbol,
        name: 'Symbol',
        isAssignable: (v) => v is Symbol,
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            final name = positionalArgs.isNotEmpty ? positionalArgs[0] as String : '';
            return Symbol(name);
          },
        },
        // `empty` and `unaryMinus` are `static const` fields, so they belong
        // here and not in `getters`: an instance getter takes
        // `(visitor, target)` and a static getter takes `(visitor)`, so a
        // static const placed in the instance map registers, exports and
        // analyses cleanly — and is inert, because nothing ever looks it up
        // there.
        staticGetters: {
          'empty': (visitor) => Symbol.empty,
          'unaryMinus': (visitor) => Symbol.unaryMinus,
        },
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Symbol).toString();
          },
        },
        getters: {
          'hashCode': (visitor, target) => (target as Symbol).hashCode,
          'runtimeType': (visitor, target) => (target as Symbol).runtimeType,
        },
      );
}

import 'package:tom_d4rt_exec/d4rt.dart';

class SymbolCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: Symbol,
        name: 'Symbol',
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            final name = positionalArgs.isNotEmpty ? positionalArgs[0] as String : '';
            return Symbol(name);
          },
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

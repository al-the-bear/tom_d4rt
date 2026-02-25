import 'package:tom_d4rt_ast/runtime.dart';

/// Bridge for the Never type (bottom type in Dart).
/// Never represents a type that no value can have - functions returning Never
/// always throw or never return.
class NeverCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: Never,
        name: 'Never',
        typeParameterCount: 0,
        // Never has no constructors - you can't create an instance of Never
        constructors: {},
        methods: {},
        getters: {},
      );
}

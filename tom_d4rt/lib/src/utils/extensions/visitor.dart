import 'package:tom_d4rt/d4rt.dart';

extension InterpreterVisitorExtension on InterpreterVisitor {
  (BridgedInstance?, bool) toBridgedInstance(Object? nativeObject,
      {String? methodName}) {
    //adjustment for the extension method
    if (methodName != null) {
      final extensionCallable =
          environment.findExtensionMember(nativeObject, methodName);
      if (extensionCallable is ExtensionMemberCallable) {
        return (null, false);
      }
    }
    if (nativeObject == null) {
      return (null, false);
    }
    if (nativeObject is BridgedInstance) {
      return (nativeObject, true);
    }
    try {
      return (globalEnvironment.toBridgedInstance(nativeObject), true);
    } catch (e) {
      // Revoke the error since we're handling it gracefully by returning false
      // This prevents spurious "BridgedClass not registered" errors when
      // the target is an internal D4rt type (BridgedEnum, BridgedClass, etc.)
      if (e is D4rtException) {
        e.revoke();
      }
      return (null, false);
    }
  }
}

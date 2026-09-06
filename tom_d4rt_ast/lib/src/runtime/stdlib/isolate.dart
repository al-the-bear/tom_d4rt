import 'package:tom_d4rt_ast/src/runtime/environment.dart';
import 'isolate/capability.dart';
import 'isolate/isolate.dart';
import 'isolate/isolate_hierarchy.dart';

export 'package:tom_d4rt_ast/src/runtime/environment.dart';

class IsolateStdlib {
  static void register(Environment environment) {
    // Register Capability bridge
    environment.defineBridge(CapabilityIsolate.definition);

    // Register all Isolate-related bridges
    environment.defineBridge(IsolateSpawnExceptionIsolate.definition);
    environment.defineBridge(IsolateIsolate.definition);
    environment.defineBridge(SendPortIsolate.definition);
    environment.defineBridge(ReceivePortIsolate.definition);
    environment.defineBridge(RawReceivePortIsolate.definition);
    environment.defineBridge(RemoteErrorIsolate.definition);
    environment.defineBridge(TransferableTypedDataIsolate.definition);

    // Last: the supertype edges key on NAME, so every bridge they refer to must
    // already be defined. `ReceivePort -> Stream` and `RemoteError -> Error`
    // both point out of this library.
    IsolateHierarchyIsolate.register();
  }
}

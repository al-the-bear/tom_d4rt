import 'package:tom_d4rt/src/environment.dart';
import 'package:tom_d4rt/src/stdlib/io/directory.dart';
import 'package:tom_d4rt/src/stdlib/io/file_system_entity.dart';
import 'package:tom_d4rt/src/stdlib/io/file.dart';
import 'package:tom_d4rt/src/stdlib/io/stdio.dart';
import 'package:tom_d4rt/src/stdlib/io/http.dart';
import 'package:tom_d4rt/src/stdlib/io/process.dart';
import 'package:tom_d4rt/src/stdlib/io/platform.dart';
import 'package:tom_d4rt/src/stdlib/io/io_sink.dart';
import 'package:tom_d4rt/src/stdlib/io/io_exception.dart';
import 'package:tom_d4rt/src/stdlib/io/socket.dart';
import 'package:tom_d4rt/src/stdlib/io/io_hierarchy.dart';

export 'package:tom_d4rt/src/environment.dart';
export 'package:tom_d4rt/src/stdlib/io/directory.dart';
export 'package:tom_d4rt/src/stdlib/io/file_system_entity.dart';
export 'package:tom_d4rt/src/stdlib/io/file.dart';
export 'package:tom_d4rt/src/stdlib/io/stdio.dart';
export 'package:tom_d4rt/src/stdlib/io/http.dart';
export 'package:tom_d4rt/src/stdlib/io/process.dart';
export 'package:tom_d4rt/src/stdlib/io/platform.dart';
export 'package:tom_d4rt/src/stdlib/io/io_sink.dart';
export 'package:tom_d4rt/src/stdlib/io/io_exception.dart';
export 'package:tom_d4rt/src/stdlib/io/socket.dart';
export 'package:tom_d4rt/src/stdlib/io/io_hierarchy.dart';

class IoStdlib {
  static void register(Environment environment) {
    // Register FileSystemEntity classes (converted)
    environment.defineBridge(FileSystemEntityIo.definition);
    environment.defineBridge(FileStatIo.definition);
    environment.defineBridge(FileSystemEntityTypeIo.definition);
    environment.defineBridge(FileSystemEventIo.definition);
    environment.defineBridge(DirectoryIo.definition);
    environment.defineBridge(FileIo.definition);

    // Register File-related classes
    environment.defineBridge(FileModeIo.definition);
    environment.defineBridge(FileLockIo.definition);
    environment.defineBridge(RandomAccessFileIo.definition);
    // Must be registered alongside the exceptions that return it — every
    // `osError` getter below produces one, and without this bridge the
    // result is inert. See SCC24.
    environment.defineBridge(OSErrorIo.definition);
    // The root of the `dart:io` error hierarchy, registered before the leaves
    // it covers so the file reads top-down. Order does not matter to the
    // runtime — supertype edges key on name and are declared separately — but
    // an unbridged root is a silently dead `on IOException catch`, which is
    // what SCC61 fixed.
    environment.defineBridge(IOExceptionIo.definition);
    environment.defineBridge(FileSystemExceptionIo.definition);
    environment.defineBridge(PathAccessExceptionIo.definition);
    environment.defineBridge(PathExistsExceptionIo.definition);
    environment.defineBridge(PathNotFoundExceptionIo.definition);
    environment.defineBridge(PipeIo.definition);

    // Register Stdio classes (converted)
    IoStdioStdlib.register(environment);

    // Register HTTP classes (converted)
    IoHttpStdlib.register(environment);

    // Register Process classes
    environment.defineBridge(ProcessIo.definition);
    environment.defineBridge(ProcessResultIo.definition);
    environment.defineBridge(ProcessSignalIo.definition);
    environment.defineBridge(ProcessStartModeIo.definition);

    // Register Platform class
    environment.defineBridge(PlatformIo.definition);

    // Register IOSink bridge
    environment.defineBridge(IOSinkIo.definition);

    // `StringSink` is deliberately NOT registered here. `dart:io` does not
    // declare it — it re-exports the `dart:core` declaration, which
    // `CoreStdlib` (always registered eagerly, before this registrar can run)
    // already owns. A second definition under the same name would displace
    // that one on last-wins, and because both would carry
    // `nativeType: StringSink` the collision reads as a benign re-export and
    // is never flagged as ambiguous. See SCB26.

    // Register Socket classes
    environment.defineBridge(SocketIo.definition);
    environment.defineBridge(InternetAddressIo.definition);
    environment.defineBridge(SocketOptionIo.definition);
    environment.defineBridge(InternetAddressTypeIo.definition);
    environment.defineBridge(ServerSocketIo.definition);

    // Register Raw Socket classes
    environment.defineBridge(RawSocketIo.definition);
    environment.defineBridge(RawServerSocketIo.definition);
    environment.defineBridge(RawSocketOptionIo.definition);
    environment.defineBridge(RawSocketEventIo.definition);
    environment.defineBridge(SocketDirectionIo.definition);

    // Register Socket support classes
    environment.defineBridge(SocketExceptionIo.definition);
    environment.defineBridge(ConnectionTaskIo.definition);
    environment.defineBridge(DatagramIo.definition);
    environment.defineBridge(RawDatagramSocketIo.definition);
    environment.defineBridge(NetworkInterfaceIo.definition);

    // Last: the supertype edges key on NAME, so every bridge they refer to must
    // already be defined. Several of them point out of this library — `IOSink`
    // reaches `StreamSink` and `StringSink`, the servers reach `Stream` — which
    // is why the block lives here rather than beside any one bridge.
    IoHierarchyIo.register();
  }
}

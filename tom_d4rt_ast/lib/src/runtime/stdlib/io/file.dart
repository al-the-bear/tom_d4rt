import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:tom_d4rt_ast/runtime.dart';

import 'filesystem_permission_helper.dart';

/// File mode for opening files
class FileModeIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: FileMode,
    name: 'FileMode',
    isAssignable: (v) => v is FileMode,
    typeParameterCount: 0,
    staticGetters: {
      'read': (visitor) => FileMode.read,
      'write': (visitor) => FileMode.write,
      'append': (visitor) => FileMode.append,
      'writeOnly': (visitor) => FileMode.writeOnly,
      'writeOnlyAppend': (visitor) => FileMode.writeOnlyAppend,
    },
  );
}

/// File lock types
class FileLockIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: FileLock,
    name: 'FileLock',
    isAssignable: (v) => v is FileLock,
    typeParameterCount: 0,
    staticGetters: {
      'shared': (visitor) => FileLock.shared,
      'exclusive': (visitor) => FileLock.exclusive,
      'blockingShared': (visitor) => FileLock.blockingShared,
      'blockingExclusive': (visitor) => FileLock.blockingExclusive,
    },
  );
}

/// Random access file operations
class RandomAccessFileIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: RandomAccessFile,
    name: 'RandomAccessFile',
    isAssignable: (v) => v is RandomAccessFile,
    typeParameterCount: 0,
    methods: {
      'close': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as RandomAccessFile).close(),
      'closeSync': (visitor, target, positionalArgs, namedArgs, _) {
        (target as RandomAccessFile).closeSync();
        return null;
      },
      'readByte': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as RandomAccessFile).readByte(),
      'readByteSync': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as RandomAccessFile).readByteSync(),
      'read': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! int) {
          throw RuntimeD4rtException(
            'RandomAccessFile.read requires one int argument (count).',
          );
        }
        return (target as RandomAccessFile).read(positionalArgs[0] as int);
      },
      'readSync': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! int) {
          throw RuntimeD4rtException(
            'RandomAccessFile.readSync requires one int argument (count).',
          );
        }
        return (target as RandomAccessFile).readSync(positionalArgs[0] as int);
      },
      'readInto': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! List) {
          throw RuntimeD4rtException(
            'RandomAccessFile.readInto requires a List<int> buffer.',
          );
        }
        final buffer = positionalArgs[0] as List<int>;
        final start = positionalArgs.length > 1
            ? positionalArgs[1] as int? ?? 0
            : 0;
        final end = positionalArgs.length > 2
            ? positionalArgs[2] as int?
            : null;
        return (target as RandomAccessFile).readInto(buffer, start, end);
      },
      'readIntoSync': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! List) {
          throw RuntimeD4rtException(
            'RandomAccessFile.readIntoSync requires a List<int> buffer.',
          );
        }
        final buffer = positionalArgs[0] as List<int>;
        final start = positionalArgs.length > 1
            ? positionalArgs[1] as int? ?? 0
            : 0;
        final end = positionalArgs.length > 2
            ? positionalArgs[2] as int?
            : null;
        return (target as RandomAccessFile).readIntoSync(buffer, start, end);
      },
      'writeByte': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! int) {
          throw RuntimeD4rtException(
            'RandomAccessFile.writeByte requires one int argument (value).',
          );
        }
        return (target as RandomAccessFile).writeByte(positionalArgs[0] as int);
      },
      'writeByteSync': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! int) {
          throw RuntimeD4rtException(
            'RandomAccessFile.writeByteSync requires one int argument (value).',
          );
        }
        return (target as RandomAccessFile).writeByteSync(
          positionalArgs[0] as int,
        );
      },
      'writeFrom': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! List) {
          throw RuntimeD4rtException(
            'RandomAccessFile.writeFrom requires a List<int> buffer.',
          );
        }
        final buffer = positionalArgs[0] as List<int>;
        final start = positionalArgs.length > 1
            ? positionalArgs[1] as int? ?? 0
            : 0;
        final end = positionalArgs.length > 2
            ? positionalArgs[2] as int?
            : null;
        return (target as RandomAccessFile).writeFrom(buffer, start, end);
      },
      'writeFromSync': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! List) {
          throw RuntimeD4rtException(
            'RandomAccessFile.writeFromSync requires a List<int> buffer.',
          );
        }
        final buffer = positionalArgs[0] as List<int>;
        final start = positionalArgs.length > 1
            ? positionalArgs[1] as int? ?? 0
            : 0;
        final end = positionalArgs.length > 2
            ? positionalArgs[2] as int?
            : null;
        (target as RandomAccessFile).writeFromSync(buffer, start, end);
        return null;
      },
      'writeString': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'RandomAccessFile.writeString requires one String argument.',
          );
        }
        final encoding = namedArgs['encoding'] as Encoding? ?? utf8;
        return (target as RandomAccessFile).writeString(
          positionalArgs[0] as String,
          encoding: encoding,
        );
      },
      'writeStringSync': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'RandomAccessFile.writeStringSync requires one String argument.',
          );
        }
        final encoding = namedArgs['encoding'] as Encoding? ?? utf8;
        (target as RandomAccessFile).writeStringSync(
          positionalArgs[0] as String,
          encoding: encoding,
        );
        return null;
      },
      'position': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as RandomAccessFile).position(),
      'positionSync': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as RandomAccessFile).positionSync(),
      'setPosition': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! int) {
          throw RuntimeD4rtException(
            'RandomAccessFile.setPosition requires one int argument (position).',
          );
        }
        return (target as RandomAccessFile).setPosition(
          positionalArgs[0] as int,
        );
      },
      'setPositionSync': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! int) {
          throw RuntimeD4rtException(
            'RandomAccessFile.setPositionSync requires one int argument (position).',
          );
        }
        (target as RandomAccessFile).setPositionSync(positionalArgs[0] as int);
        return null;
      },
      'truncate': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! int) {
          throw RuntimeD4rtException(
            'RandomAccessFile.truncate requires one int argument (length).',
          );
        }
        return (target as RandomAccessFile).truncate(positionalArgs[0] as int);
      },
      'truncateSync': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! int) {
          throw RuntimeD4rtException(
            'RandomAccessFile.truncateSync requires one int argument (length).',
          );
        }
        (target as RandomAccessFile).truncateSync(positionalArgs[0] as int);
        return null;
      },
      'length': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as RandomAccessFile).length(),
      'lengthSync': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as RandomAccessFile).lengthSync(),
      'flush': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as RandomAccessFile).flush(),
      'flushSync': (visitor, target, positionalArgs, namedArgs, _) {
        (target as RandomAccessFile).flushSync();
        return null;
      },
      'lock': (visitor, target, positionalArgs, namedArgs, _) {
        final mode = namedArgs['mode'] as FileLock? ?? FileLock.exclusive;
        final start = namedArgs['start'] as int? ?? 0;
        final end = namedArgs['end'] as int? ?? -1;
        return (target as RandomAccessFile).lock(mode, start, end);
      },
      'lockSync': (visitor, target, positionalArgs, namedArgs, _) {
        final mode = namedArgs['mode'] as FileLock? ?? FileLock.exclusive;
        final start = namedArgs['start'] as int? ?? 0;
        final end = namedArgs['end'] as int? ?? -1;
        (target as RandomAccessFile).lockSync(mode, start, end);
        return null;
      },
      'unlock': (visitor, target, positionalArgs, namedArgs, _) {
        final start = namedArgs['start'] as int? ?? 0;
        final end = namedArgs['end'] as int? ?? -1;
        return (target as RandomAccessFile).unlock(start, end);
      },
      'unlockSync': (visitor, target, positionalArgs, namedArgs, _) {
        final start = namedArgs['start'] as int? ?? 0;
        final end = namedArgs['end'] as int? ?? -1;
        (target as RandomAccessFile).unlockSync(start, end);
        return null;
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as RandomAccessFile).toString(),
    },
    getters: {'path': (visitor, target) => (target as RandomAccessFile).path},
  );
}

/// The operating-system error carried by every `dart:io` exception.
///
/// Four bridges already expose an `osError` getter and two constructors
/// already accept an `OSError` argument, but the class itself was never
/// registered — so the getter returned successfully and the result was then
/// inert: `e.osError.errorCode` failed with "Undefined property or method
/// 'errorCode' on OSError". Found by the SCC24 sweep.
///
/// This is the same defect shape as a missing `nativeNames` entry with a
/// different cause: not an unclaimed private implementation type, but a
/// public type with no bridge at all. Worth distinguishing when reading the
/// sweep's output — the fix is a registration, not a name.
class OSErrorIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: OSError,
    name: 'OSError',
    isAssignable: (v) => v is OSError,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        final message = positionalArgs.isNotEmpty
            ? positionalArgs[0] as String?
            : null;
        final errorCode = positionalArgs.length > 1
            ? positionalArgs[1] as int?
            : null;
        return OSError(message ?? '', errorCode ?? OSError.noErrorCode);
      },
    },
    staticGetters: {'noErrorCode': (visitor) => OSError.noErrorCode},
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as OSError).toString(),
    },
    getters: {
      'message': (visitor, target) => (target as OSError).message,
      'errorCode': (visitor, target) => (target as OSError).errorCode,
      'hashCode': (visitor, target) => (target as OSError).hashCode,
      'runtimeType': (visitor, target) => (target as OSError).runtimeType,
    },
  );
}

/// FileSystemException base class
class FileSystemExceptionIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: FileSystemException,
    name: 'FileSystemException',
    isAssignable: (v) => v is FileSystemException,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        final message = positionalArgs.isNotEmpty
            ? positionalArgs[0] as String? ?? ""
            : "";
        final path = positionalArgs.length > 1
            ? positionalArgs[1] as String? ?? ""
            : "";
        final osError = positionalArgs.length > 2
            ? positionalArgs[2] as OSError?
            : null;
        return FileSystemException(message, path, osError);
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as FileSystemException).toString(),
    },
    getters: {
      'message': (visitor, target) => (target as FileSystemException).message,
      'path': (visitor, target) => (target as FileSystemException).path,
      'osError': (visitor, target) => (target as FileSystemException).osError,
    },
  );
}

/// PathAccessException for access denied errors
class PathAccessExceptionIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: PathAccessException,
    name: 'PathAccessException',
    isAssignable: (v) => v is PathAccessException,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length < 2) {
          throw RuntimeD4rtException(
            'PathAccessException requires path and osError arguments.',
          );
        }
        final path = positionalArgs[0] as String;
        final osError = positionalArgs[1] as OSError;
        final message = positionalArgs.length > 2
            ? positionalArgs[2] as String? ?? ""
            : "";
        return PathAccessException(path, osError, message);
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as PathAccessException).toString(),
    },
    getters: {
      'message': (visitor, target) => (target as PathAccessException).message,
      'path': (visitor, target) => (target as PathAccessException).path,
      'osError': (visitor, target) => (target as PathAccessException).osError,
    },
  );
}

/// PathExistsException for file exists errors
class PathExistsExceptionIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: PathExistsException,
    name: 'PathExistsException',
    isAssignable: (v) => v is PathExistsException,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length < 2) {
          throw RuntimeD4rtException(
            'PathExistsException requires path and osError arguments.',
          );
        }
        final path = positionalArgs[0] as String;
        final osError = positionalArgs[1] as OSError;
        final message = positionalArgs.length > 2
            ? positionalArgs[2] as String? ?? ""
            : "";
        return PathExistsException(path, osError, message);
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as PathExistsException).toString(),
    },
    getters: {
      'message': (visitor, target) => (target as PathExistsException).message,
      'path': (visitor, target) => (target as PathExistsException).path,
      'osError': (visitor, target) => (target as PathExistsException).osError,
    },
  );
}

/// PathNotFoundException for file not found errors
class PathNotFoundExceptionIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: PathNotFoundException,
    name: 'PathNotFoundException',
    isAssignable: (v) => v is PathNotFoundException,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length < 2) {
          throw RuntimeD4rtException(
            'PathNotFoundException requires path and osError arguments.',
          );
        }
        final path = positionalArgs[0] as String;
        final osError = positionalArgs[1] as OSError;
        final message = positionalArgs.length > 2
            ? positionalArgs[2] as String? ?? ""
            : "";
        return PathNotFoundException(path, osError, message);
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as PathNotFoundException).toString(),
    },
    getters: {
      'message': (visitor, target) => (target as PathNotFoundException).message,
      'path': (visitor, target) => (target as PathNotFoundException).path,
      'osError': (visitor, target) => (target as PathNotFoundException).osError,
    },
  );
}

/// Pipe for interprocess communication
class PipeIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: Pipe,
    name: 'Pipe',
    isAssignable: (v) => v is Pipe,
    typeParameterCount: 0,
    staticMethods: {
      'create': (visitor, positionalArgs, namedArgs, _) => Pipe.create(),
      'createSync': (visitor, positionalArgs, namedArgs, _) =>
          Pipe.createSync(),
    },
    getters: {
      'read': (visitor, target) => (target as Pipe).read,
      'write': (visitor, target) => (target as Pipe).write,
    },
  );
}

class FileIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: File,
    name: 'File',
    isAssignable: (v) => v is File,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'File constructor requires one String argument (path).',
          );
        }
        return File(positionalArgs[0] as String);
      },
    },
    staticMethods: {
      'fromRawPath': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Uint8List) {
          throw RuntimeD4rtException(
            'File.fromRawPath requires one Uint8List argument.',
          );
        }
        return File.fromRawPath(positionalArgs[0] as Uint8List);
      },
      'fromUri': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Uri) {
          throw RuntimeD4rtException('File.fromUri requires one Uri argument.');
        }
        return File.fromUri(positionalArgs[0] as Uri);
      },
    },
    methods: {
      'exists': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'check existence',
        );
        return file.exists();
      },
      'existsSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'check existence',
        );
        return file.existsSync();
      },
      'readAsString': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'read file',
        );
        return file.readAsString(
          encoding: namedArgs['encoding'] as Encoding? ?? utf8,
        );
      },
      'readAsStringSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'read file',
        );
        return file.readAsStringSync(
          encoding: namedArgs['encoding'] as Encoding? ?? utf8,
        );
      },
      'readAsBytes': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'read file',
        );
        return file.readAsBytes();
      },
      'readAsBytesSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'read file',
        );
        return file.readAsBytesSync();
      },
      'readAsLines': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'read file',
        );
        return file.readAsLines(
          encoding: namedArgs['encoding'] as Encoding? ?? utf8,
        );
      },
      'readAsLinesSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'read file',
        );
        return file.readAsLinesSync(
          encoding: namedArgs['encoding'] as Encoding? ?? utf8,
        );
      },
      'writeAsString': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'File.writeAsString requires one String argument (contents).',
          );
        }
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'write file',
        );
        return file.writeAsString(
          positionalArgs[0] as String,
          mode: namedArgs['mode'] as FileMode? ?? FileMode.write,
          encoding: namedArgs['encoding'] as Encoding? ?? utf8,
          flush: namedArgs['flush'] as bool? ?? false,
        );
      },
      'writeAsStringSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'File.writeAsStringSync requires one String argument (contents).',
          );
        }
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'write file',
        );
        file.writeAsStringSync(
          positionalArgs[0] as String,
          mode: namedArgs['mode'] as FileMode? ?? FileMode.write,
          encoding: namedArgs['encoding'] as Encoding? ?? utf8,
          flush: namedArgs['flush'] as bool? ?? false,
        );
        return null;
      },
      'writeAsBytes': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        if (positionalArgs.length != 1 || positionalArgs[0] is! List) {
          throw RuntimeD4rtException(
            'File.writeAsBytes requires one List<int> argument (bytes).',
          );
        }
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'write file',
        );
        return file.writeAsBytes(
          (positionalArgs[0] as List).cast(),
          mode: namedArgs['mode'] as FileMode? ?? FileMode.write,
          flush: namedArgs['flush'] as bool? ?? false,
        );
      },
      'writeAsBytesSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        if (positionalArgs.length != 1 || positionalArgs[0] is! List) {
          throw RuntimeD4rtException(
            'File.writeAsBytesSync requires one List<int> argument (bytes).',
          );
        }
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'write file',
        );
        file.writeAsBytesSync(
          (positionalArgs[0] as List).cast(),
          mode: namedArgs['mode'] as FileMode? ?? FileMode.write,
          flush: namedArgs['flush'] as bool? ?? false,
        );
        return null;
      },
      'delete': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'delete file',
        );
        return file.delete(recursive: namedArgs['recursive'] as bool? ?? false);
      },
      'deleteSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'delete file',
        );
        file.deleteSync(recursive: namedArgs['recursive'] as bool? ?? false);
        return null;
      },
      'rename': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'File.rename requires one String argument (newPath).',
          );
        }
        final newPath = positionalArgs[0] as String;
        // A rename mutates BOTH ends: it removes the old path and creates
        // the new one, so a write grant is needed on each.
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'rename file',
        );
        checkFilesystemWritePermission(
          visitor,
          newPath,
          operation: 'rename file',
        );
        return file.rename(newPath);
      },
      'renameSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'File.renameSync requires one String argument (newPath).',
          );
        }
        final newPath = positionalArgs[0] as String;
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'rename file',
        );
        checkFilesystemWritePermission(
          visitor,
          newPath,
          operation: 'rename file',
        );
        return file.renameSync(newPath);
      },
      'copy': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'File.copy requires one String argument (newPath).',
          );
        }
        final newPath = positionalArgs[0] as String;
        // Reads the source and creates the target — one grant does not
        // imply the other.
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'copy file',
        );
        checkFilesystemWritePermission(
          visitor,
          newPath,
          operation: 'copy file',
        );
        return file.copy(newPath);
      },
      'copySync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'File.copySync requires one String argument (newPath).',
          );
        }
        final newPath = positionalArgs[0] as String;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'copy file',
        );
        checkFilesystemWritePermission(
          visitor,
          newPath,
          operation: 'copy file',
        );
        return file.copySync(newPath);
      },
      'length': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'read file length',
        );
        return file.length();
      },
      'lengthSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'read file length',
        );
        return file.lengthSync();
      },
      'lastAccessed': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'read file timestamp',
        );
        return file.lastAccessed();
      },
      'lastAccessedSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'read file timestamp',
        );
        return file.lastAccessedSync();
      },
      'setLastAccessed': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        if (positionalArgs.length != 1 || positionalArgs[0] is! DateTime) {
          throw RuntimeD4rtException(
            'File.setLastAccessed requires one DateTime argument.',
          );
        }
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'set file timestamp',
        );
        return file.setLastAccessed(positionalArgs[0] as DateTime);
      },
      'setLastAccessedSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        if (positionalArgs.length != 1 || positionalArgs[0] is! DateTime) {
          throw RuntimeD4rtException(
            'File.setLastAccessedSync requires one DateTime argument.',
          );
        }
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'set file timestamp',
        );
        file.setLastAccessedSync(positionalArgs[0] as DateTime);
        return null;
      },
      'lastModified': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'read file timestamp',
        );
        return file.lastModified();
      },
      'lastModifiedSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'read file timestamp',
        );
        return file.lastModifiedSync();
      },
      'setLastModified': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        if (positionalArgs.length != 1 || positionalArgs[0] is! DateTime) {
          throw RuntimeD4rtException(
            'File.setLastModified requires one DateTime argument.',
          );
        }
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'set file timestamp',
        );
        return file.setLastModified(positionalArgs[0] as DateTime);
      },
      'setLastModifiedSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        if (positionalArgs.length != 1 || positionalArgs[0] is! DateTime) {
          throw RuntimeD4rtException(
            'File.setLastModifiedSync requires one DateTime argument.',
          );
        }
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'set file timestamp',
        );
        file.setLastModifiedSync(positionalArgs[0] as DateTime);
        return null;
      },
      'open': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        final mode = namedArgs['mode'] as FileMode? ?? FileMode.read;
        // The returned RandomAccessFile is unchecked from here on, so the
        // mode decides which grant the whole handle needs.
        _checkOpenModePermission(visitor, file.path, mode);
        return file.open(mode: mode);
      },
      'openSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        final mode = namedArgs['mode'] as FileMode? ?? FileMode.read;
        _checkOpenModePermission(visitor, file.path, mode);
        return file.openSync(mode: mode);
      },
      'openRead': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'open file',
        );
        return file.openRead(
          positionalArgs.isNotEmpty ? positionalArgs[0] as int? : null,
          positionalArgs.length > 1 ? positionalArgs[1] as int? : null,
        );
      },
      'openWrite': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'open file',
        );
        return file.openWrite(
          mode: namedArgs['mode'] as FileMode? ?? FileMode.write,
          encoding: namedArgs['encoding'] as Encoding? ?? utf8,
        );
      },
      'stat': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'stat file',
        );
        return file.stat();
      },
      'statSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'stat file',
        );
        return file.statSync();
      },
      'resolveSymbolicLinks': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'resolve links',
        );
        return file.resolveSymbolicLinks();
      },
      'resolveSymbolicLinksSync':
          (visitor, target, positionalArgs, namedArgs, _) {
            final file = target as File;
            checkFilesystemReadPermission(
              visitor,
              file.path,
              operation: 'resolve links',
            );
            return file.resolveSymbolicLinksSync();
          },
      'create': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'create file',
        );
        return file.create(
          recursive: namedArgs['recursive'] as bool? ?? false,
          exclusive: namedArgs['exclusive'] as bool? ?? false,
        );
      },
      'createSync': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemWritePermission(
          visitor,
          file.path,
          operation: 'create file',
        );
        file.createSync(
          recursive: namedArgs['recursive'] as bool? ?? false,
          exclusive: namedArgs['exclusive'] as bool? ?? false,
        );
        return null;
      },
      'watch': (visitor, target, positionalArgs, namedArgs, _) {
        final file = target as File;
        checkFilesystemReadPermission(
          visitor,
          file.path,
          operation: 'watch file',
        );
        return file.watch(
          events: namedArgs['events'] as int? ?? FileSystemEvent.all,
          recursive: namedArgs['recursive'] as bool? ?? false,
        );
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as File).toString(),
    },
    getters: {
      'path': (visitor, target) => (target as File).path,
      'absolute': (visitor, target) => (target as File).absolute,
      'parent': (visitor, target) => (target as File).parent,
      'isAbsolute': (visitor, target) => (target as File).isAbsolute,
      'uri': (visitor, target) => (target as File).uri,
      'runtimeType': (visitor, target) => (target as File).runtimeType,
      'hashCode': (visitor, target) => (target as File).hashCode,
    },
  );
}

/// Gates `File.open`/`openSync` according to the requested [mode].
///
/// `FileMode.read` is the only mode that leaves the file untouched; every
/// other mode can write, so it needs a write grant.
void _checkOpenModePermission(
  InterpreterVisitor visitor,
  String path,
  FileMode mode,
) {
  if (mode == FileMode.read) {
    checkFilesystemReadPermission(visitor, path, operation: 'open file');
  } else {
    checkFilesystemWritePermission(visitor, path, operation: 'open file');
  }
}

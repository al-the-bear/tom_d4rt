import 'dart:io';
import 'package:tom_d4rt/d4rt.dart';

import 'filesystem_permission_helper.dart';

class FileSystemEntityIo {
  static BridgedClass get definition => BridgedClass(
        nativeType: FileSystemEntity,
        name: 'FileSystemEntity',
        isAssignable: (v) => v is FileSystemEntity,
        typeParameterCount: 0,
        staticMethods: {
          'identical': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 2 ||
                positionalArgs[0] is! String ||
                positionalArgs[1] is! String) {
              throw RuntimeD4rtException(
                  'FileSystemEntity.identical requires two String arguments (path1, path2).');
            }
            checkFilesystemReadPermission(visitor, positionalArgs[0] as String,
                operation: 'compare file system entities');
            checkFilesystemReadPermission(visitor, positionalArgs[1] as String,
                operation: 'compare file system entities');
            return FileSystemEntity.identical(
                positionalArgs[0] as String, positionalArgs[1] as String);
          },
          'identicalSync': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 2 ||
                positionalArgs[0] is! String ||
                positionalArgs[1] is! String) {
              throw RuntimeD4rtException(
                  'FileSystemEntity.identicalSync requires two String arguments (path1, path2).');
            }
            checkFilesystemReadPermission(visitor, positionalArgs[0] as String,
                operation: 'compare file system entities');
            checkFilesystemReadPermission(visitor, positionalArgs[1] as String,
                operation: 'compare file system entities');
            return FileSystemEntity.identicalSync(
                positionalArgs[0] as String, positionalArgs[1] as String);
          },
          'isDirectory': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'FileSystemEntity.isDirectory requires one String argument (path).');
            }
            checkFilesystemReadPermission(visitor, positionalArgs[0] as String,
                operation: 'inspect path');
            return FileSystemEntity.isDirectory(positionalArgs[0] as String);
          },
          'isDirectorySync': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'FileSystemEntity.isDirectorySync requires one String argument (path).');
            }
            checkFilesystemReadPermission(visitor, positionalArgs[0] as String,
                operation: 'inspect path');
            return FileSystemEntity.isDirectorySync(
                positionalArgs[0] as String);
          },
          'isFile': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'FileSystemEntity.isFile requires one String argument (path).');
            }
            checkFilesystemReadPermission(visitor, positionalArgs[0] as String,
                operation: 'inspect path');
            return FileSystemEntity.isFile(positionalArgs[0] as String);
          },
          'isFileSync': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'FileSystemEntity.isFileSync requires one String argument (path).');
            }
            checkFilesystemReadPermission(visitor, positionalArgs[0] as String,
                operation: 'inspect path');
            return FileSystemEntity.isFileSync(positionalArgs[0] as String);
          },
          'isLink': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'FileSystemEntity.isLink requires one String argument (path).');
            }
            checkFilesystemReadPermission(visitor, positionalArgs[0] as String,
                operation: 'inspect path');
            return FileSystemEntity.isLink(positionalArgs[0] as String);
          },
          'isLinkSync': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'FileSystemEntity.isLinkSync requires one String argument (path).');
            }
            checkFilesystemReadPermission(visitor, positionalArgs[0] as String,
                operation: 'inspect path');
            return FileSystemEntity.isLinkSync(positionalArgs[0] as String);
          },
          'type': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'FileSystemEntity.type requires one String argument (path).');
            }
            checkFilesystemReadPermission(visitor, positionalArgs[0] as String,
                operation: 'inspect path');
            return FileSystemEntity.type(positionalArgs[0] as String,
                followLinks: namedArgs['followLinks'] as bool? ?? true);
          },
          'typeSync': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'FileSystemEntity.typeSync requires one String argument (path).');
            }
            checkFilesystemReadPermission(visitor, positionalArgs[0] as String,
                operation: 'inspect path');
            return FileSystemEntity.typeSync(positionalArgs[0] as String,
                followLinks: namedArgs['followLinks'] as bool? ?? true);
          },
          'parentOf': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'FileSystemEntity.parentOf requires one String argument (path).');
            }
            checkFilesystemReadPermission(visitor, positionalArgs[0] as String,
                operation: 'inspect path');
            return FileSystemEntity.parentOf(positionalArgs[0] as String);
          },
        },
        methods: {
          'exists': (visitor, target, positionalArgs, namedArgs, _) {
            final entity = target as FileSystemEntity;
            checkFilesystemReadPermission(visitor, entity.path,
                operation: 'check existence');
            return entity.exists();
          },
          'existsSync': (visitor, target, positionalArgs, namedArgs, _) {
            final entity = target as FileSystemEntity;
            checkFilesystemReadPermission(visitor, entity.path,
                operation: 'check existence');
            return entity.existsSync();
          },
          'delete': (visitor, target, positionalArgs, namedArgs, _) {
            final entity = target as FileSystemEntity;
            checkFilesystemWritePermission(visitor, entity.path,
                operation: 'delete entity');
            return entity.delete(
                recursive: namedArgs['recursive'] as bool? ?? false);
          },
          'deleteSync': (visitor, target, positionalArgs, namedArgs, _) {
            final entity = target as FileSystemEntity;
            checkFilesystemWritePermission(visitor, entity.path,
                operation: 'delete entity');
            entity.deleteSync(
                recursive: namedArgs['recursive'] as bool? ?? false);
            return null;
          },
          'rename': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'FileSystemEntity.rename requires one String argument (newPath).');
            }
            final entity = target as FileSystemEntity;
            final newPath = positionalArgs[0] as String;
            checkFilesystemWritePermission(visitor, entity.path,
                operation: 'rename entity');
            checkFilesystemWritePermission(visitor, newPath,
                operation: 'rename entity');
            return entity.rename(newPath);
          },
          'renameSync': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'FileSystemEntity.renameSync requires one String argument (newPath).');
            }
            final entity = target as FileSystemEntity;
            final newPath = positionalArgs[0] as String;
            checkFilesystemWritePermission(visitor, entity.path,
                operation: 'rename entity');
            checkFilesystemWritePermission(visitor, newPath,
                operation: 'rename entity');
            entity.renameSync(newPath);
            return null;
          },
          'stat': (visitor, target, positionalArgs, namedArgs, _) {
            final entity = target as FileSystemEntity;
            checkFilesystemReadPermission(visitor, entity.path,
                operation: 'stat entity');
            return entity.stat();
          },
          'statSync': (visitor, target, positionalArgs, namedArgs, _) {
            final entity = target as FileSystemEntity;
            checkFilesystemReadPermission(visitor, entity.path,
                operation: 'stat entity');
            return entity.statSync();
          },
          'watch': (visitor, target, positionalArgs, namedArgs, _) {
            final entity = target as FileSystemEntity;
            checkFilesystemReadPermission(visitor, entity.path,
                operation: 'watch entity');
            return entity.watch(
                events: namedArgs['events'] as int? ?? FileSystemEvent.all,
                recursive: namedArgs['recursive'] as bool? ?? false);
          },
          'resolveSymbolicLinks':
              (visitor, target, positionalArgs, namedArgs, _) {
            final entity = target as FileSystemEntity;
            checkFilesystemReadPermission(visitor, entity.path,
                operation: 'resolve links');
            return entity.resolveSymbolicLinks();
          },
          'resolveSymbolicLinksSync':
              (visitor, target, positionalArgs, namedArgs, _) {
            final entity = target as FileSystemEntity;
            checkFilesystemReadPermission(visitor, entity.path,
                operation: 'resolve links');
            return entity.resolveSymbolicLinksSync();
          },
        },
        getters: {
          'absolute': (visitor, target) =>
              (target as FileSystemEntity).absolute,
          'uri': (visitor, target) => (target as FileSystemEntity).uri,
          'parent': (visitor, target) => (target as FileSystemEntity).parent,
          'path': (visitor, target) => (target as FileSystemEntity).path,
          'isAbsolute': (visitor, target) =>
              (target as FileSystemEntity).isAbsolute,
        },
        staticGetters: {
          'isWatchSupported': (visitor) => FileSystemEntity.isWatchSupported,
        },
      );
}

class FileStatIo {
  static BridgedClass get definition => BridgedClass(
        nativeType: FileStat,
        name: 'FileStat',
        isAssignable: (v) => v is FileStat,
        typeParameterCount: 0,
        constructors: {
          // FileStat is typically obtained from stat() operations
        },
        staticMethods: {
          'stat': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'FileStat.stat requires one String argument (path).');
            }
            // Takes a raw path, so it would otherwise sidestep every gate on
            // File/Directory/FileSystemEntity.
            checkFilesystemReadPermission(visitor, positionalArgs[0] as String,
                operation: 'stat path');
            return FileStat.stat(positionalArgs[0] as String);
          },
          'statSync': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'FileStat.statSync requires one String argument (path).');
            }
            checkFilesystemReadPermission(visitor, positionalArgs[0] as String,
                operation: 'stat path');
            return FileStat.statSync(positionalArgs[0] as String);
          },
        },
        methods: {
          'modeString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as FileStat).modeString();
          },
          'toString': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as FileStat).toString(),
        },
        getters: {
          'changed': (visitor, target) => (target as FileStat).changed,
          'modified': (visitor, target) => (target as FileStat).modified,
          'accessed': (visitor, target) => (target as FileStat).accessed,
          'type': (visitor, target) => (target as FileStat).type,
          'mode': (visitor, target) => (target as FileStat).mode,
          'size': (visitor, target) => (target as FileStat).size,
        },
      );
}

class FileSystemEntityTypeIo {
  static BridgedClass get definition => BridgedClass(
        nativeType: FileSystemEntityType,
        name: 'FileSystemEntityType',
        isAssignable: (v) => v is FileSystemEntityType,
        typeParameterCount: 0,
        constructors: {},
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as FileSystemEntityType).toString(),
        },
        staticGetters: {
          'file': (visitor) => FileSystemEntityType.file,
          'directory': (visitor) => FileSystemEntityType.directory,
          'link': (visitor) => FileSystemEntityType.link,
          'unixDomainSock': (visitor) => FileSystemEntityType.unixDomainSock,
          'pipe': (visitor) => FileSystemEntityType.pipe,
          'notFound': (visitor) => FileSystemEntityType.notFound,
        },
        getters: {},
      );
}

class FileSystemEventIo {
  static BridgedClass get definition => BridgedClass(
        nativeType: FileSystemEvent,
        name: 'FileSystemEvent',
        isAssignable: (v) => v is FileSystemEvent,
        typeParameterCount: 0,
        constructors: {},
        staticGetters: {
          'create': (visitor) => FileSystemEvent.create,
          'delete': (visitor) => FileSystemEvent.delete,
          'modify': (visitor) => FileSystemEvent.modify,
          'move': (visitor) => FileSystemEvent.move,
          'all': (visitor) => FileSystemEvent.all,
        },
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as FileSystemEvent).toString(),
        },
        getters: {
          'type': (visitor, target) => (target as FileSystemEvent).type,
          'path': (visitor, target) => (target as FileSystemEvent).path,
          'isDirectory': (visitor, target) =>
              (target as FileSystemEvent).isDirectory,
          // Convenience getters for type checking
          'isCreate': (visitor, target) =>
              (target as FileSystemEvent).type == FileSystemEvent.create,
          'isModify': (visitor, target) =>
              (target as FileSystemEvent).type == FileSystemEvent.modify,
          'isDelete': (visitor, target) =>
              (target as FileSystemEvent).type == FileSystemEvent.delete,
          'isMove': (visitor, target) =>
              (target as FileSystemEvent).type == FileSystemEvent.move,
        },
      );
}

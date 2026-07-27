import 'dart:io';
import 'dart:typed_data';
import 'package:tom_d4rt/d4rt.dart';

import 'filesystem_permission_helper.dart';

class DirectoryIo {
  static BridgedClass get definition => BridgedClass(
        nativeType: Directory,
        name: 'Directory',
        isAssignable: (v) => v is Directory,
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isEmpty || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'Directory constructor requires one String argument (path).');
            }
            return Directory(positionalArgs[0] as String);
          },
        },
        staticMethods: {
          'fromRawPath': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! Uint8List) {
              throw RuntimeD4rtException(
                  'Directory.fromRawPath requires one Uint8List argument.');
            }
            return Directory.fromRawPath(positionalArgs[0] as Uint8List);
          },
          'fromUri': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! Uri) {
              throw RuntimeD4rtException(
                  'Directory.fromUri requires one Uri argument.');
            }
            return Directory.fromUri(positionalArgs[0] as Uri);
          },
        },
        methods: {
          'exists': (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemReadPermission(visitor, directory.path,
                operation: 'check directory existence');
            return directory.exists();
          },
          'existsSync': (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemReadPermission(visitor, directory.path,
                operation: 'check directory existence');
            return directory.existsSync();
          },
          'create': (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemWritePermission(visitor, directory.path,
                operation: 'create directory');
            return directory.create(
                recursive: namedArgs['recursive'] as bool? ?? false);
          },
          'createSync': (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemWritePermission(visitor, directory.path,
                operation: 'create directory');
            directory.createSync(
                recursive: namedArgs['recursive'] as bool? ?? false);
            return null;
          },
          'delete': (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemWritePermission(visitor, directory.path,
                operation: 'delete directory');
            return directory.delete(
                recursive: namedArgs['recursive'] as bool? ?? false);
          },
          'deleteSync': (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemWritePermission(visitor, directory.path,
                operation: 'delete directory');
            directory.deleteSync(
                recursive: namedArgs['recursive'] as bool? ?? false);
            return null;
          },
          'list': (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemReadPermission(visitor, directory.path,
                operation: 'list directory');
            return directory.list(
                recursive: namedArgs['recursive'] as bool? ?? false,
                followLinks: namedArgs['followLinks'] as bool? ?? true);
          },
          'listSync': (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemReadPermission(visitor, directory.path,
                operation: 'list directory');
            return directory.listSync(
                recursive: namedArgs['recursive'] as bool? ?? false,
                followLinks: namedArgs['followLinks'] as bool? ?? true);
          },
          'rename': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'Directory.rename requires one String argument (newPath).');
            }
            final directory = target as Directory;
            final newPath = positionalArgs[0] as String;
            // A rename mutates BOTH ends: it removes the old path and creates
            // the new one, so a write grant is needed on each.
            checkFilesystemWritePermission(visitor, directory.path,
                operation: 'rename directory');
            checkFilesystemWritePermission(visitor, newPath,
                operation: 'rename directory');
            return directory.rename(newPath);
          },
          'renameSync': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'Directory.renameSync requires one String argument (newPath).');
            }
            final directory = target as Directory;
            final newPath = positionalArgs[0] as String;
            checkFilesystemWritePermission(visitor, directory.path,
                operation: 'rename directory');
            checkFilesystemWritePermission(visitor, newPath,
                operation: 'rename directory');
            directory.renameSync(newPath);
            return null;
          },
          'stat': (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemReadPermission(visitor, directory.path,
                operation: 'stat directory');
            return directory.stat();
          },
          'statSync': (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemReadPermission(visitor, directory.path,
                operation: 'stat directory');
            return directory.statSync();
          },
          'watch': (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemReadPermission(visitor, directory.path,
                operation: 'watch directory');
            return directory.watch(
                events: namedArgs['events'] as int? ?? FileSystemEvent.all,
                recursive: namedArgs['recursive'] as bool? ?? false);
          },
          'resolveSymbolicLinks':
              (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemReadPermission(visitor, directory.path,
                operation: 'resolve links');
            return directory.resolveSymbolicLinks();
          },
          'resolveSymbolicLinksSync':
              (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemReadPermission(visitor, directory.path,
                operation: 'resolve links');
            return directory.resolveSymbolicLinksSync();
          },
          'createTemp': (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemWritePermission(visitor, directory.path,
                operation: 'create temporary directory');
            return directory.createTemp(positionalArgs.isNotEmpty
                ? positionalArgs[0] as String?
                : null);
          },
          'createTempSync': (visitor, target, positionalArgs, namedArgs, _) {
            final directory = target as Directory;
            checkFilesystemWritePermission(visitor, directory.path,
                operation: 'create temporary directory');
            return directory.createTempSync(positionalArgs.isNotEmpty
                ? positionalArgs[0] as String?
                : null);
          },
          'toString': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as Directory).toString(),
        },
        getters: {
          'path': (visitor, target) => (target as Directory).path,
          'absolute': (visitor, target) => (target as Directory).absolute,
          'uri': (visitor, target) => (target as Directory).uri,
          'parent': (visitor, target) => (target as Directory).parent,
          'isAbsolute': (visitor, target) => (target as Directory).isAbsolute,
        },
        staticGetters: {
          'systemTemp': (visitor) => Directory.systemTemp,
          'current': (visitor) => Directory.current,
        },
        staticSetters: {
          'current': (visitor, value) {
            Directory.current = value;
            return;
          },
        },
      );
}

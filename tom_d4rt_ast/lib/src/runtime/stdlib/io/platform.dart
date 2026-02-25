import 'dart:io';
import 'package:tom_d4rt_ast/runtime.dart';

/// Bridged implementation of dart:io Platform functionality
class PlatformIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: Platform,
    name: 'Platform',
    typeParameterCount: 0,
    staticGetters: {
      'numberOfProcessors': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.numberOfProcessors;
      },
      'pathSeparator': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.pathSeparator;
      },
      'operatingSystem': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.operatingSystem;
      },
      'operatingSystemVersion': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.operatingSystemVersion;
      },
      'localHostname': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.localHostname;
      },
      'environment': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.environment;
      },
      'executable': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.executable;
      },
      'resolvedExecutable': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.resolvedExecutable;
      },
      'script': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.script;
      },
      'executableArguments': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.executableArguments;
      },
      'packageConfig': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.packageConfig;
      },
      'version': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.version;
      },
      'localeName': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.localeName;
      },
      'isLinux': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.isLinux;
      },
      'isMacOS': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.isMacOS;
      },
      'isWindows': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.isWindows;
      },
      'isAndroid': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.isAndroid;
      },
      'isIOS': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.isIOS;
      },
      'isFuchsia': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.isFuchsia;
      },
    },
  );

  /// Helper method to check if DangerousPermission is granted
  static void _checkDangerousPermission(InterpreterVisitor visitor) {
    // Check for DangerousPermission via moduleContext
    if (!visitor.moduleContext.checkPermission({'type': 'dangerous'})) {
      throw RuntimeD4rtException(
        'Access to Platform requires DangerousPermission. '
        'Use d4rt.grant(DangerousPermission.any) to allow Platform access.',
      );
    }
  }
}

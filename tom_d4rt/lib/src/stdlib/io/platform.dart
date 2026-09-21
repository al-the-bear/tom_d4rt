import 'dart:io';
import 'package:tom_d4rt/d4rt.dart';

/// Bridged implementation of dart:io Platform functionality
class PlatformIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: Platform,
    name: 'Platform',
    isAssignable: (v) => v is Platform,
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
      // SCE82: `isWindows ? '\r\n' : '\n'` in the SDK — a pure value, but it
      // is a host property like `pathSeparator` beside it, so it goes through
      // the same gate rather than being the one Platform member a script can
      // read ungated.
      'lineTerminator': (visitor) {
        _checkDangerousPermission(visitor);
        return Platform.lineTerminator;
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
    // No interpreter instance means no permission set to enforce — the
    // bridges are being driven directly (e.g. from a unit test), not
    // sandboxed. NOT a sandbox hole: every path that runs a SCRIPT builds its
    // loader with `d4rt: this`, so a script's visitor always carries one and
    // this branch is unreachable from interpreted code. The analyzer-free twin
    // is permissive in the same state for the same reason — its
    // `NoOpModuleContext.checkPermission` returns true when no checker is
    // wired — so the two trees agree on the un-sandboxed mode and differ only
    // in where they express it. Pinned by
    // `test/stdlib/io/sce87_permission_gate_null_handle_test.dart`.
    final d4rt = visitor.moduleLoader.d4rt;
    if (d4rt == null) return;

    // Check for DangerousPermission
    if (!d4rt.checkPermission({'type': 'dangerous'})) {
      throw RuntimeD4rtException(
        'Access to Platform requires DangerousPermission. '
        'Use d4rt.grant(DangerousPermission.any) to allow Platform access.',
      );
    }
  }
}

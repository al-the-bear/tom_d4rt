// DFIN10 (dgu6): two user bridges for one target are reported, not resolved in
// silence.
//
// `UserBridgeScanner` keyed user bridges by (library, class) and globals bridges
// by library, and simply overwrote an existing entry. With two `@D4rtUserBridge`
// classes for the same target, the one scanned LAST won and nothing said the
// other had been dropped — and which one is last depends on directory listing
// order. The scan now warns, naming both and the one it keeps. The behaviour is
// otherwise unchanged (still last-wins), so no existing project breaks.
//
// The same bridge seen twice is NOT a duplicate: the generator scans libraries
// itself as well as through the pre-scan, so one class can legitimately be
// registered more than once.
//
// The temporary projects live under this package's `.dart_tool/`, so the
// analyzer resolves `package:tom_d4rt` through this package's own package
// config. NOTE: like the GEN-12x suites, nothing here changes the process
// working directory, which `dart test` shares between concurrently running
// test files.
@Tags(['generation'])
library;

import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/user_bridge_prescan.dart';

/// A user bridge for `Thing` in `package:x/thing.dart`, named [name].
String _classBridge(String name) =>
    '''
import 'package:tom_d4rt/d4rt.dart';

@D4rtUserBridge('package:x/thing.dart', 'Thing')
class $name extends D4UserBridge {}
''';

/// A globals user bridge for `package:x/globals.dart`, named [name].
String _globalsBridge(String name) =>
    '''
import 'package:tom_d4rt/d4rt.dart';

@D4rtGlobalsUserBridge('package:x/globals.dart')
class $name extends D4UserBridge {}
''';

/// Writes a project whose `lib/src/d4rt_user_bridges/` holds [files], scans
/// it, and returns the warnings the scan reported.
Future<List<String>> _scan(Map<String, String> files) async {
  final root = Directory(
    p.join(
      Directory.current.path,
      '.dart_tool',
      'dfin10_${Random().nextInt(1 << 30)}',
    ),
  );
  final bridges = Directory(
    p.join(root.path, 'lib', 'src', 'd4rt_user_bridges'),
  )..createSync(recursive: true);
  try {
    files.forEach(
      (name, content) =>
          File(p.join(bridges.path, name)).writeAsStringSync(content),
    );
    final warnings = <String>[];
    final scanner = await preScanUserBridges(
      root.path,
      onWarning: warnings.add,
    );
    // Anti-vacuity: the fixture's bridges were really found, so an empty
    // warning list means "no duplicate", not "nothing was scanned".
    expect(scanner.d4UserBridgeClasses, isNotEmpty);
    return warnings;
  } finally {
    root.deleteSync(recursive: true);
  }
}

void main() {
  group('DFIN10: duplicate user bridges are reported', () {
    test('F-DFIN10-1: two class bridges for one target name both, and the '
        'one kept [2026-10-03]', () async {
      final warnings = await _scan({
        'a_bridge.dart': _classBridge('FirstThingUserBridge'),
        'b_bridge.dart': _classBridge('SecondThingUserBridge'),
      });
      expect(warnings, hasLength(1));
      expect(
        warnings.single,
        allOf(
          contains('FirstThingUserBridge'),
          contains('SecondThingUserBridge'),
          contains('Thing'),
          contains('package:x/thing.dart'),
          contains('keeping'),
        ),
      );
    });

    test('F-DFIN10-2: two globals bridges for one library name both '
        '[2026-10-03]', () async {
      final warnings = await _scan({
        'a_bridge.dart': _globalsBridge('FirstGlobalsUserBridge'),
        'b_bridge.dart': _globalsBridge('SecondGlobalsUserBridge'),
      });
      expect(warnings, hasLength(1));
      expect(
        warnings.single,
        allOf(
          contains('FirstGlobalsUserBridge'),
          contains('SecondGlobalsUserBridge'),
          contains('package:x/globals.dart'),
        ),
      );
    });

    test('F-DFIN10-3 (control): one bridge per target warns about nothing '
        '[2026-10-03]', () async {
      final warnings = await _scan({
        'a_bridge.dart': _classBridge('OnlyThingUserBridge'),
        'b_bridge.dart': _globalsBridge('OnlyGlobalsUserBridge'),
      });
      expect(warnings, isEmpty);
    });
  });
}

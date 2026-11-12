// The legacy package search behind `_getFilePathForPackageUri` (used when
// `.dart_tool/package_config.json` does not name a package) starts at the
// workspace root, which is the nearest `buildkit_master.yaml`
// (build_tom build_cleanup3). The retired markers mark nothing.
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_generator.dart'
    show fallbackSearchRoot;

void main() {
  late Directory tmp;

  setUp(() => tmp = Directory.systemTemp.createTempSync('fallback_root_'));
  tearDown(() => tmp.deleteSync(recursive: true));

  String dir(String rel) =>
      (Directory(p.join(tmp.path, rel))..createSync(recursive: true)).path;
  void file(String rel) => File(p.join(tmp.path, rel))
    ..parent.createSync(recursive: true)
    ..writeAsStringSync('');

  test('BCL3-FSR-1: the search starts at the nearest buildkit_master.yaml; '
      'a stray tom_workspace.yaml or tom.code-workspace below it marks '
      'nothing', () {
    file('ws/buildkit_master.yaml');
    file('ws/a/tom_workspace.yaml');
    file('ws/a/tom.code-workspace');
    expect(fallbackSearchRoot(dir('ws/a/pkg')), p.join(tmp.path, 'ws'));
  });

  test('BCL3-FSR-2: outside a workspace the search starts where it was '
      'asked to', () {
    file('lonely/tom_workspace.yaml');
    final start = dir('lonely/pkg');
    expect(fallbackSearchRoot(start), start);
  });
}

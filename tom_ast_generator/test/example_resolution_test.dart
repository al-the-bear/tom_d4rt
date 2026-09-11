// Every example/ project must still resolve.
//
// The examples carry `buildkit_skip.yaml`, so no workspace scan resolves them.
// A project that stops resolving keeps its last package config, and whatever
// reads it next fails on a downstream symptom — once an apparent analyzer API
// break that was really a config naming a version the pub cache had lost. This
// test asks pub directly, one project at a time: `resolveIfUnresolved` repairs
// a config that merely went stale (it re-downloads what the cache lost) and
// fails, with pub's own message, on a project that cannot resolve at all.
//
// It covers every pubspec under example/, not only the projects with bridges:
// the script-only projects rot the same way.

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/testing.dart';

void main() {
  final projects = findDartProjects('example');

  test('AG-RESOLVE-EX-00: discovery finds the example projects '
      '[2026-09-11] (PASS)', () {
    expect(projects, isNotEmpty);
  });

  for (final project in projects) {
    test('AG-RESOLVE-EX[$project]: resolves, and its package config names only '
        'packages that exist [2026-09-11] (PASS)', () async {
      final failure = await resolveIfUnresolved(p.absolute('example', project));
      expect(failure, isNull, reason: failure);
    }, timeout: const Timeout(Duration(minutes: 3)));
  }
}

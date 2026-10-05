// DFIN8: the browser test's fixture, run on the VM.
//
// `bundle_in_browser_test.dart` needs Chrome and is skipped by the default run.
// This file runs the same fixture where every host can, so the fixture itself
// is checked on every `dart test`, and a browser-only failure is unambiguously
// a web difference rather than a broken fixture.
@TestOn('vm')
library;

import 'dart:convert';
import 'dart:io' as io;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/d4rt.dart';

import 'support/bundle_fixture.dart';

void main() {
  group('DFIN8: the browser fixture on the VM', () {
    setUp(D4rtRunner.debugResetPool);
    tearDown(D4rtRunner.debugResetPool);

    test('F-DFIN8-5: it is native gzip and decodes with dart:io too '
        '[2026-10-03]', () {
      final json = jsonDecode(utf8.decode(io.gzip.decode(fixtureBundleGzip)));
      expect(
        (json as Map<String, dynamic>)[AstBundleFormat.keyEntryPoint],
        fixtureEntryPoint,
      );
    });

    test('F-DFIN8-6: it runs to the value the browser test expects '
        '[2026-10-03]', () {
      final bundle = AstBundle.fromBytes(fixtureBundleGzip);
      expect(bundle.modules, hasLength(2));
      expect(D4rtRunner().executeBundle(bundle), fixtureExpectedResult);
    });
  });
}

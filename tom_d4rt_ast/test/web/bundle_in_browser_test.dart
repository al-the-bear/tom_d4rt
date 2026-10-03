// DFIN8: the analyzer-free interpreter loads and runs a bundle in a browser.
//
// `web_safety_test.dart` proves that `dart:io` is unreachable from the public
// barrels, which is what pub.dev's web badge reads. It does not prove that a
// bundle DECODES on the web (gzip there is `package:archive`'s pure-Dart ZLib,
// not the native codec) or that the interpreter RUNS once compiled to
// JavaScript. This does, against a bundle the analyzer front end produced and
// the native codec compressed on a host — what a deployment actually ships
// (see `support/bundle_fixture.dart` for its provenance).
//
// RUN IT (Chrome required; the default `dart test` run skips this file):
//
//     dart test -p chrome test/web/        # or: dart test -P browser
//
// `dart_test.yaml` keeps the default platform `vm`, so a host without Chrome
// still passes the suite: under `vm` this file is filtered out by the
// `@TestOn('browser')` below rather than failed. `bundle_fixture_vm_test.dart`
// runs the same fixture on the VM, so a difference between the two platforms
// shows up as exactly one of them failing.
@TestOn('browser')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/d4rt.dart';

import 'support/bundle_fixture.dart';

void main() {
  group('DFIN8: a bundle in a browser', () {
    setUp(D4rtRunner.debugResetPool);
    tearDown(D4rtRunner.debugResetPool);

    test('F-DFIN8-1: this really is a web build [2026-10-03]', () {
      // Without it every case below would pass just as well on the VM, and a
      // misconfigured platform would go unnoticed.
      expect(const bool.fromEnvironment('dart.library.js_interop'), isTrue);
      expect(const bool.fromEnvironment('dart.library.io'), isFalse);
    });

    test('F-DFIN8-2: a host-built, natively gzipped bundle decodes and runs '
        '[2026-10-03]', () {
      final bundle = AstBundle.fromBytes(fixtureBundleGzip);
      expect(bundle.entryPointUri, fixtureEntryPoint);
      expect(bundle.modules, hasLength(2));
      expect(D4rtRunner().executeBundle(bundle), fixtureExpectedResult);
    });

    test('F-DFIN8-3: a bundle the web codec writes, the web codec reads '
        '[2026-10-03]', () {
      final bytes = AstBundle.fromBytes(fixtureBundleGzip).toBytes();
      expect(bytes.take(2), [0x1F, 0x8B]);
      final bundle = AstBundle.fromBytes(bytes);
      expect(D4rtRunner().executeBundle(bundle), fixtureExpectedResult);
    });

    test('F-DFIN8-4: the ZIP form round-trips and runs [2026-10-03]', () {
      final zip = AstBundle.fromBytes(fixtureBundleGzip).toZip();
      final bundle = AstBundle.fromZip(zip);
      expect(D4rtRunner().executeBundle(bundle), fixtureExpectedResult);
    });
  });
}

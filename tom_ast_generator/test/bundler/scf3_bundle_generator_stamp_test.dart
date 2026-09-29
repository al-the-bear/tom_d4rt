// SCF3 / SCE15 — a bundle astgen writes names the astgen that wrote it.
//
// tom_d4rt_ast carries the optional `generator` field on AstBundle and its ZIP
// manifest (SCE15's read side). Every bundle this package builds now fills it
// with `tom_ast_generator <version>`, the same stamp `astgen --version` prints,
// so a bundle that misbehaves on a device can say which tool produced it.
//
// Asserted on a FRESHLY PRODUCED bundle through every serialization the
// runtime offers, never on a hand-built map: the point is what the bundler
// actually writes.

import 'package:test/test.dart';
import 'package:tom_ast_generator/src/bundler/ast_bundler.dart';
import 'package:tom_ast_generator/src/version.versioner.dart';
import 'package:tom_d4rt_ast/runtime.dart' show AstBundle, AstBundleFormat;

void main() {
  final expected = 'tom_ast_generator ${AstgenVersionInfo.version}';

  late AstBundle bundle;
  setUpAll(() async {
    bundle = await AstBundler().createFromSource('int main() => 1;');
  });

  test('F-SCF3-1: the bundle object carries the generator stamp '
      '[2026-09-29] (PASS)', () {
    expect(bundle.generator, expected);
  });

  test('F-SCF3-2: the plain JSON form writes it under the format key '
      '[2026-09-29] (PASS)', () {
    final json = bundle.toJson();
    expect(json[AstBundleFormat.keyGenerator], expected);
    expect(AstBundle.fromJson(json).generator, expected);
  });

  test('F-SCF3-3: the gzip bytes and the ZIP manifest round-trip it '
      '[2026-09-29] (PASS)', () {
    expect(AstBundle.fromBytes(bundle.toBytes()).generator, expected);
    expect(AstBundle.fromZip(bundle.toZip()).generator, expected);
  });

  test('F-SCF3-4: the stamp is the versioner\'s, the value astgen prints as '
      '--version [2026-09-29] (PASS)', () {
    // The version comes from lib/src/version.versioner.dart, which
    // test/version_stamp_test.dart holds equal to pubspec.yaml, so a bundle
    // cannot disagree with the tool's own banner.
    expect(expected, matches(RegExp(r'^tom_ast_generator \d+\.\d+\.\d+$')));
  });
}

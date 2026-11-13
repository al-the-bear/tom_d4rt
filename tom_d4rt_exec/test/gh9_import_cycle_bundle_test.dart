/// GitHub al-the-bear/tom_d4rt#9 on the BUNDLE PATH: intl 0.20.3, whose
/// libraries import each other in a cycle and reach their declarations through
/// a barrel, compiled with `createBundleFromSource`, sent through `toBytes` /
/// `fromBytes` as an app receives a bundle, and run by `D4rtRunner`.
///
/// `gh9_import_cycle_test.dart` next door is the verbatim port of the
/// analyzer-based suite and runs intl through `execute(sources:)`. This file
/// is its bundle half, which has no counterpart in `tom_d4rt` and so can only
/// be pinned here; splitting them keeps the shared-name file a verbatim port
/// (see `_plan_e2_static_in_closure_bundle_test.dart`). It is the issue's own
/// shape: a Slang project ships intl inside its bundle, and the bundler must
/// carry every library of the cycle for the runtime to defer the lookups to.
library;

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('gh9 on the bundle path: intl 0.20.3', () {
    // The unmodified intl source closure, read from the pub cache (intl,
    // clock, path, meta), as `gh9_import_cycle_test.dart` reads it.
    final cache = '${Platform.environment['HOME']}/.pub-cache/hosted/pub.dev';
    final packages = {
      'intl': '$cache/intl-0.20.3',
      'clock': '$cache/clock-1.1.2',
      'path': '$cache/path-1.9.1',
      'meta': '$cache/meta-1.18.0',
    };
    final missing = packages.values.where((d) => !Directory(d).existsSync());
    final sources = <String, String>{
      if (missing.isEmpty)
        for (final MapEntry(key: name, value: dir) in packages.entries)
          for (final file
              in Directory('$dir/lib')
                  .listSync(recursive: true)
                  .whereType<File>()
                  .where((f) => f.path.endsWith('.dart')))
            'package:$name/${file.path.substring(dir.length + 5)}': file
                .readAsStringSync(),
    };

    for (final (label, imports) in [
      ('intl.dart alone', "import 'package:intl/intl.dart';"),
      (
        'message_lookup_by_library.dart first',
        "import 'package:intl/message_lookup_by_library.dart';\n"
            "import 'package:intl/intl.dart';",
      ),
    ]) {
      test(
        'GH9-B1: Intl.canonicalizedLocale from a bundle, $label [2026-11-13]',
        () async {
          final bundle = await D4rt().createBundleFromSource(
            "$imports\nmain() => Intl.canonicalizedLocale('en-US');",
            explicitSources: sources,
          );
          final received = AstBundle.fromBytes(bundle.toBytes());
          expect(D4rtRunner().executeBundle(received), 'en_US');
        },
        skip: missing.isEmpty
            ? false
            : 'the intl 0.20.3 source closure is not in this pub cache: '
                  '${missing.join(', ')}',
        timeout: const Timeout(Duration(minutes: 3)),
      );
    }
  });
}

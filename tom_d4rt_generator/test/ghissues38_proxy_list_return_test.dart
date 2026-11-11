// ghissues38: a proxy hands native code a typed list for a script's list.
//
// A script builds its list literals as `List<Object?>` whatever their element
// type. When native code called a proxied override declared to return
// `List<E>` or `Future<List<E>?>` - Flutter 3.47 calls a script's
// `SpellCheckService.fetchSpellCheckSuggestions` from the text field it
// configures - the proxy passed the script list to
// `extractBridgedArg<List<E>>`, which refused it ("expected
// List<SuggestionSpan>?, got List<Object?>"). The proxy now rebuilds such a
// list with `D4.coerceList<E>`, directly and inside the future's `then`.
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String generatedCode;

  setUpAll(() async {
    final tempDir = Directory.systemTemp.createTempSync('ghissues38_proxy_');
    final outputFile = p.join(tempDir.path, 'file_proxy.b.dart');
    final result = await generateProxies(
      config: BridgeConfig(
        name: 'ghissues38_proxy',
        d4rtImport: 'package:tom_d4rt/d4rt.dart',
        generateProxies: true,
        proxiesOutputPath: outputFile,
        proxyClasses: const [ProxyClassConfig(className: 'File')],
        modules: const [
          ModuleConfig(
            name: 'dart_io',
            barrelFiles: ['dart:io'],
            outputPath: 'unused_bridges.b.dart',
            barrelImport: 'dart:io',
          ),
        ],
      ),
      projectPath: Directory.current.path,
    );
    expect(result.errors, isEmpty);
    // The formatter reflows long lines, so compare with whitespace removed.
    generatedCode = (await File(
      result.outputFile!,
    ).readAsString()).replaceAll(RegExp(r'\s+'), '');
  });

  group('ghissues38: list-returning proxy methods', () {
    test('GHI38-G1: a returned script list is rebuilt as List<E> '
        '[2026-11-11]', () {
      expect(
        generatedCode,
        contains(
          "if(resultisList&&resultis!List<String>){returnD4.coerceList<String>(result,'readAsLinesSync');}",
        ),
      );
    });

    test('GHI38-G2: a future completing with a script list completes with '
        'a List<E> [2026-11-11]', () {
      expect(
        generatedCode,
        contains(
          "returnresult.then((v)=>visList&&vis!List<String>?D4.coerceList<String>(v,'readAsLines'):D4.extractBridgedArg<List<String>>(v,'readAsLines',visitor",
        ),
      );
    });
  });
}

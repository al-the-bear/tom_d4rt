// VSTDM3: a proxy re-types the Future an interpreted async override returns.
//
// An interpreted `async` method returns `Future<Object?>` whatever it
// declares. When native code calls such an override through a generated
// proxy - Flutter 3.47 calls a script's `SpellCheckService
// .fetchSpellCheckSuggestions` from the text field it configures - the proxy
// handed that future to `extractBridgedArg<Future<List<SuggestionSpan>?>>`,
// which cannot make a `Future<Object?>` into a `Future<List<...>?>` and threw
// ("expected Future<List<SuggestionSpan>?>, got Future<Object?>"). The proxy
// now maps the value through `then`, extracting each completion as the element
// type, which yields a genuine `Future<T>`.
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String generatedCode;

  setUpAll(() async {
    final tempDir = Directory.systemTemp.createTempSync('vstdm3_future_proxy_');
    final outputFile = p.join(tempDir.path, 'fse_proxy.b.dart');
    final result = await generateProxies(
      config: BridgeConfig(
        name: 'vstdm3_future_proxy',
        d4rtImport: 'package:tom_d4rt/d4rt.dart',
        generateProxies: true,
        proxiesOutputPath: outputFile,
        proxyClasses: const [ProxyClassConfig(className: 'FileSystemEntity')],
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

  group('VSTDM3: Future-returning proxy methods', () {
    test('G-VSTDM3-1: an untyped future is re-typed through then '
        '[2026-11-06]', () {
      expect(
        generatedCode,
        contains(
          "returnresult.then((v)=>D4.extractBridgedArg<bool>(v,'exists',visitor)",
        ),
      );
    });

    test('G-VSTDM3-2: an already typed future passes through unchanged '
        '[2026-11-06]', () {
      expect(
        generatedCode,
        contains('if(resultisFuture&&resultis!Future<bool>){'),
      );
      expect(
        generatedCode,
        contains(
          "returnD4.extractBridgedArg<Future<bool>>(result,'exists',visitor);",
        ),
      );
    });
  });
}

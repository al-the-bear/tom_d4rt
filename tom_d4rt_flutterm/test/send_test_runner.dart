/// Test runner that builds AST bundles from test scripts and sends them
/// to the tom_d4rt_flutterm_app via HTTP.
///
/// Scripts are located in:
///   test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/
///
/// Each script must contain a `dynamic build(BuildContext context)` function
/// that returns a Widget.
///
/// The app captures print() output from scripts and returns it in the response.
///
/// Run with: flutter test test/send_test_runner.dart
@TestOn('vm')
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:tom_d4rt_flutterm/tom_d4rt_flutterm.dart';

const int _serverPort = 4247;
const String _serverHost = 'localhost';

void main() {
  late FlutterD4rt d4rt;
  late HttpClient client;
  late Directory scriptsDir;

  setUpAll(() {
    d4rt = FlutterD4rt();
    client = HttpClient();

    // Locate the scripts directory.
    // In Flutter test, Directory.current is typically the package root.
    // We look for test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/
    final packageRoot = Directory.current.path;
    scriptsDir = Directory(
      p.join(
        packageRoot,
        'test',
        'tom_d4rt_flutterm_app',
        'test',
        'send_ast_via_http_scripts',
      ),
    );

    if (!scriptsDir.existsSync()) {
      throw StateError('Scripts directory not found: ${scriptsDir.path}');
    }
  });

  tearDownAll(() {
    client.close();
  });

  test('send all test scripts to app', () async {
    // Check server is running
    final health = await _httpGet(client, '/health');
    expect(
      health['status'],
      'ok',
      reason: 'App server must be running on port $_serverPort',
    );

    // Find all .dart scripts
    final scripts =
        scriptsDir
            .listSync()
            .whereType<File>()
            .where((f) => f.path.endsWith('.dart'))
            .toList()
          ..sort((a, b) => p.basename(a.path).compareTo(p.basename(b.path)));

    expect(
      scripts,
      isNotEmpty,
      reason: 'No test scripts found in ${scriptsDir.path}',
    );

    print('\n${'=' * 60}');
    print('Found ${scripts.length} test script(s):');
    for (final script in scripts) {
      print('  - ${p.basename(script.path)}');
    }
    print('${'=' * 60}\n');

    // Run each script
    for (final script in scripts) {
      final name = p.basename(script.path);
      print('\n--- Running: $name ---');

      // Step 1: Clear the app UI
      final clearResponse = await _httpGet(client, '/clear');
      expect(
        clearResponse['status'],
        'cleared',
        reason: 'Failed to clear UI for $name',
      );
      print('  ✓ Cleared UI');

      // Step 2: Build bundle from script source
      final source = await script.readAsString();
      print('  Source: ${source.length} bytes');

      final bundle = await d4rt.interpreter.createBundleFromSource(source);
      final bundleJson = jsonEncode(bundle.toJson());
      print('  Bundle: ${bundleJson.length} bytes');

      // Step 3: Send bundle to app and await the build result
      final buildResponse = await _httpPost(client, '/build', bundleJson);
      final status = buildResponse['status'] as String;
      final output = (buildResponse['output'] as List?)?.cast<String>() ?? [];

      // Display captured output from the script
      if (output.isNotEmpty) {
        print('  Script output:');
        for (final line in output) {
          print('    > $line');
        }
      }

      if (status == 'success') {
        final widgetType = buildResponse['widgetType'] as String?;
        print('  ✓ Widget rendered: $widgetType');
      } else {
        final error = buildResponse['error'] as String?;
        print('  ✗ Build failed: $error');
        fail('Script $name failed: $error');
      }
    }

    print('\n${'=' * 60}');
    print('All ${scripts.length} scripts executed successfully!');
    print('${'=' * 60}\n');
  });
}

Future<Map<String, dynamic>> _httpGet(HttpClient client, String path) async {
  final request = await client.getUrl(
    Uri.parse('http://$_serverHost:$_serverPort$path'),
  );
  final response = await request.close();
  final body = await utf8.decoder.bind(response).join();
  return jsonDecode(body) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> _httpPost(
  HttpClient client,
  String path,
  String body,
) async {
  final request = await client.postUrl(
    Uri.parse('http://$_serverHost:$_serverPort$path'),
  );
  request.headers.contentType = ContentType.json;
  request.write(body);
  final response = await request.close();
  final responseBody = await utf8.decoder.bind(response).join();
  return jsonDecode(responseBody) as Map<String, dynamic>;
}

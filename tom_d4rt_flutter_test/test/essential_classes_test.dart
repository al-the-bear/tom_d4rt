/// Smoke-test suite for the source-based D4rt Flutter bridge.
///
/// Tests are run against the HTTP test app on port 4248.  The app must either
/// be started manually before running this file, or [SendTestRunner.setUp]
/// will launch it automatically.
///
/// IMPORTANT: never run this file concurrently with other test files that use
/// the same port — see dart_test.yaml (concurrency: 1).
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp(startApp: true);
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('Smoke tests', () {
    test('hello world returns Text widget', () async {
      final result = await SendTestRunner.send('hello_world_test.dart');
      expect(result.success, isTrue, reason: result.error ?? '');
      expect(result.widgetType, equals('Text'));
      expect(result.output, contains('hello from d4rt source interpreter'));
    });
  });
}

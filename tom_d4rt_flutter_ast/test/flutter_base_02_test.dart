/// Auto-split base bridge tests (file 02).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_base_02_test.dart';

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp(suite: _kTestFileName);
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('Test App Health', () {
    test('app is running', () async {
      final isRunning = await SendTestRunner.isAppRunning();
      expect(
        isRunning,
        isTrue,
        reason: 'Test app should be running (managed by setUpAll).',
      );
    });
  });

  // ============================================================
  // SEMANTICS PACKAGE TESTS (1 file)
  // ============================================================
  group('semantics/', () {
    test('semantics_test.dart', () async {
      final result = await SendTestRunner.send('semantics/semantics_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // WIDGETS PACKAGE TESTS (35 files)
  // ============================================================
  group('widgets/', () {
    test('align_test.dart', () async {
      final result = await SendTestRunner.send('widgets/align_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('animation_test.dart', () async {
      final result = await SendTestRunner.send('widgets/animation_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('center_test.dart', () async {
      final result = await SendTestRunner.send('widgets/center_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('changenotifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/changenotifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cliprrect_test.dart', () async {
      final result = await SendTestRunner.send('widgets/cliprrect_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('column_test.dart', () async {
      final result = await SendTestRunner.send('widgets/column_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('container_test.dart', () async {
      final result = await SendTestRunner.send('widgets/container_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('expanded_test.dart', () async {
      final result = await SendTestRunner.send('widgets/expanded_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('flexible_test.dart', () async {
      final result = await SendTestRunner.send('widgets/flexible_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('focusnode_test.dart', () async {
      final result = await SendTestRunner.send('widgets/focusnode_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('form_test.dart', () async {
      final result = await SendTestRunner.send('widgets/form_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('gesturedetector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/gesturedetector_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gridview_test.dart', () async {
      final result = await SendTestRunner.send('widgets/gridview_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_test.dart', () async {
      final result = await SendTestRunner.send('widgets/image_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('inkwell_test.dart', () async {
      final result = await SendTestRunner.send('widgets/inkwell_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_test.dart', () async {
      final result = await SendTestRunner.send('widgets/key_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('listview_test.dart', () async {
      final result = await SendTestRunner.send('widgets/listview_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigator_test.dart', () async {
      final result = await SendTestRunner.send('widgets/navigator_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('opacity_test.dart', () async {
      final result = await SendTestRunner.send('widgets/opacity_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('padding_test.dart', () async {
      final result = await SendTestRunner.send('widgets/padding_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('pageview_test.dart', () async {
      final result = await SendTestRunner.send('widgets/pageview_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('positioned_test.dart', () async {
      final result = await SendTestRunner.send('widgets/positioned_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('richtext_test.dart', () async {
      final result = await SendTestRunner.send('widgets/richtext_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('row_test.dart', () async {
      final result = await SendTestRunner.send('widgets/row_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_test.dart', () async {
      final result = await SendTestRunner.send('widgets/scaffold_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('sized_box_test.dart', () async {
      final result = await SendTestRunner.send('widgets/sized_box_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('stack_test.dart', () async {
      final result = await SendTestRunner.send('widgets/stack_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('statefulwidget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/statefulwidget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('textfield_test.dart', () async {
      final result = await SendTestRunner.send('widgets/textfield_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_test.dart', () async {
      final result = await SendTestRunner.send('widgets/text_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('transform_test.dart', () async {
      final result = await SendTestRunner.send('widgets/transform_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('wrap_test.dart', () async {
      final result = await SendTestRunner.send('widgets/wrap_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SERVICES PACKAGE TESTS (1 file)
  // ============================================================
  group('services/', () {
    test('textformatter_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/textformatter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // MATERIAL PACKAGE TESTS (7 files)
  // ============================================================
  group('material/', () {
    test('bottomappbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottomappbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('circleavatar_test.dart', () async {
      // 1944 TODO C.13 (2026-05-31): historical 20260524-2003 §6/T10
      // cold-start wrapper REMOVED. Script runs in ~1.6 s under
      // normal load (httpMs=1600). The original cold-start
      // contention from §6/T10 has been resolved by §U25/§U28
      // mitigations shipped across A.1-A.8 + B.1-B.12 closures.
      final result = await SendTestRunner.send(
        'material/circleavatar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollbar_test.dart', () async {
      final result = await SendTestRunner.send('material/scrollbar_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('segmentedbutton_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/segmentedbutton_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectabletext_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/selectabletext_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliverappbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/sliverappbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('togglebuttons_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/togglebuttons_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}

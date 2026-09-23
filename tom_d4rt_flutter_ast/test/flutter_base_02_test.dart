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
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // WIDGETS PACKAGE TESTS (35 files)
  // ============================================================
  group('widgets/', () {
    test('align_test.dart', () async {
      final result = await SendTestRunner.send('widgets/align_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('animation_test.dart', () async {
      final result = await SendTestRunner.send('widgets/animation_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('center_test.dart', () async {
      final result = await SendTestRunner.send('widgets/center_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('changenotifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/changenotifier_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cliprrect_test.dart', () async {
      final result = await SendTestRunner.send('widgets/cliprrect_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('column_test.dart', () async {
      final result = await SendTestRunner.send('widgets/column_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('container_test.dart', () async {
      final result = await SendTestRunner.send('widgets/container_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('expanded_test.dart', () async {
      final result = await SendTestRunner.send('widgets/expanded_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('flexible_test.dart', () async {
      final result = await SendTestRunner.send('widgets/flexible_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('focusnode_test.dart', () async {
      final result = await SendTestRunner.send('widgets/focusnode_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('form_test.dart', () async {
      final result = await SendTestRunner.send('widgets/form_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('gesturedetector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/gesturedetector_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('gridview_test.dart', () async {
      final result = await SendTestRunner.send('widgets/gridview_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('image_test.dart', () async {
      final result = await SendTestRunner.send('widgets/image_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('inkwell_test.dart', () async {
      final result = await SendTestRunner.send('widgets/inkwell_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('key_test.dart', () async {
      final result = await SendTestRunner.send('widgets/key_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('listview_test.dart', () async {
      final result = await SendTestRunner.send('widgets/listview_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('navigator_test.dart', () async {
      final result = await SendTestRunner.send('widgets/navigator_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('opacity_test.dart', () async {
      final result = await SendTestRunner.send('widgets/opacity_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('padding_test.dart', () async {
      final result = await SendTestRunner.send('widgets/padding_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('pageview_test.dart', () async {
      final result = await SendTestRunner.send('widgets/pageview_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('positioned_test.dart', () async {
      final result = await SendTestRunner.send('widgets/positioned_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('richtext_test.dart', () async {
      final result = await SendTestRunner.send('widgets/richtext_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('row_test.dart', () async {
      final result = await SendTestRunner.send('widgets/row_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('scaffold_test.dart', () async {
      final result = await SendTestRunner.send('widgets/scaffold_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('sized_box_test.dart', () async {
      final result = await SendTestRunner.send('widgets/sized_box_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('stack_test.dart', () async {
      final result = await SendTestRunner.send('widgets/stack_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('statefulwidget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/statefulwidget_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('textfield_test.dart', () async {
      final result = await SendTestRunner.send('widgets/textfield_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('text_test.dart', () async {
      final result = await SendTestRunner.send('widgets/text_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('transform_test.dart', () async {
      final result = await SendTestRunner.send('widgets/transform_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('wrap_test.dart', () async {
      final result = await SendTestRunner.send('widgets/wrap_test.dart');
      SendTestRunner.expectSuccess(result);
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
      SendTestRunner.expectSuccess(result);
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
      SendTestRunner.expectSuccess(result);
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
      SendTestRunner.expectSuccess(result);
    });

    test('scrollbar_test.dart', () async {
      final result = await SendTestRunner.send('material/scrollbar_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('segmentedbutton_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/segmentedbutton_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('selectabletext_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/selectabletext_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliverappbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/sliverappbar_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('togglebuttons_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/togglebuttons_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}

/// Tests for secondary Flutter bridge classes (batch 1).
///
/// These tests use the SendTestRunner to send D4rt scripts to the test app
/// and verify they execute correctly. Each test corresponds to a script
/// in the send_ast_via_http_scripts directory.
///
/// Prerequisites:
/// 1. Start the test app: cd test/tom_d4rt_flutterm_app && flutter run
/// 2. Run tests: flutter test test/secondary_classes_test.dart
///
/// Tests are organized by Flutter package and test the bridged classes
/// listed in testplan_secondary.md.
///
/// Total: 38 test scripts (batch 1)
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp();
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
        reason:
            'Test app must be running. '
            'Start it with: cd test/tom_d4rt_flutterm_app && flutter run',
      );
    });
  });

  // ============================================================
  // ANIMATION PACKAGE TESTS (1 file)
  // ============================================================
  group('animation/', () {
    test('animation_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animation_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // CUPERTINO PACKAGE TESTS (1 file)
  // ============================================================
  group('cupertino/', () {
    test('cupertino_secondary_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_secondary_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // DART:UI PACKAGE TESTS (1 file)
  // ============================================================
  group('dart_ui/', () {
    test('enums_ui_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/enums_ui_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // FOUNDATION PACKAGE TESTS (4 files)
  // ============================================================
  group('foundation/', () {
    test('buffers_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/buffers_misc_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('observer_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/observer_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('synchronousfuture_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/synchronousfuture_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('targetplatform_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/targetplatform_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // GESTURES PACKAGE TESTS (1 file)
  // ============================================================
  group('gestures/', () {
    test('scale_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/scale_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // MATERIAL PACKAGE TESTS (5 files)
  // ============================================================
  group('material/', () {
    test('buttonstyle_popup_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/buttonstyle_popup_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('chip_variants_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/chip_variants_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('datetime_utils_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/datetime_utils_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fablocation_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/fablocation_messenger_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('texttheme_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/texttheme_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // PAINTING PACKAGE TESTS (6 files)
  // ============================================================
  group('painting/', () {
    test('enums_painting_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/enums_painting_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gradient_transform_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/gradient_transform_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_cache_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_cache_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('imagestream_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/imagestream_misc_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('matrixutils_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/matrixutils_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('notched_shapes_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/notched_shapes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // PHYSICS PACKAGE TESTS (1 file)
  // ============================================================
  group('physics/', () {
    test('springdescription_test.dart', () async {
      final result = await SendTestRunner.send(
        'physics/springdescription_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // RENDERING PACKAGE TESTS (1 file)
  // ============================================================
  group('rendering/', () {
    test('hittest_pipeline_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/hittest_pipeline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SCHEDULER PACKAGE TESTS (1 file)
  // ============================================================
  group('scheduler/', () {
    test('scheduler_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/scheduler_misc_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SEMANTICS PACKAGE TESTS (1 file)
  // ============================================================
  group('semantics/', () {
    test('semantics_properties_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_properties_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SERVICES PACKAGE TESTS (2 files)
  // ============================================================
  group('services/', () {
    test('system_chrome_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_chrome_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_value_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_value_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // WIDGETS PACKAGE TESTS (13 files)
  // ============================================================
  group('widgets/', () {
    test('defaulttextstyle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/defaulttextstyle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_properties_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focus_properties_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyedsubtree_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/keyedsubtree_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('physicalmodel_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/physicalmodel_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('placeholder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/placeholder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('preferredsize_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/preferredsize_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_values_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_values_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollbar_layout_misc_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollbar_layout_misc_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollphysics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollphysics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shaderfilter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shaderfilter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcuts_actions_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcuts_actions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_delegates_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_delegates_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('textspan_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/textspan_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}

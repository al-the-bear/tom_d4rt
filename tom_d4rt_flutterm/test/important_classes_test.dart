/// Tests for important Flutter bridge classes (batch 1).
///
/// These tests use the SendTestRunner to send D4rt scripts to the test app
/// and verify they execute correctly. Each test corresponds to a script
/// in the send_ast_via_http_scripts directory.
///
/// Prerequisites:
/// 1. Start the test app: cd test/tom_d4rt_flutterm_app && flutter run
/// 2. Run tests: flutter test test/important_classes_test.dart
///
/// Tests are organized by Flutter package (widgets, material)
/// and test the bridged classes listed in testplan_important.md.
///
/// Total: 60 test scripts (batch 1 + batch 2)
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
      final result = await SendTestRunner.send(
        'material/circleavatar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scrollbar_test.dart',
      );
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

  // ============================================================
  // WIDGETS PACKAGE TESTS (23 files)
  // ============================================================
  group('widgets/', () {
    test('absorbpointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/absorbpointer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedcontainer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedcontainer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedlist_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedlist_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedopacity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedopacity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('builder_test.dart', () async {
      final result = await SendTestRunner.send('widgets/builder_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('constrainedbox_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/constrainedbox_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('custompaint_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/custompaint_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('customscrollview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/customscrollview_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('decoratedbox_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/decoratedbox_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('draggable_test.dart', () async {
      final result = await SendTestRunner.send('widgets/draggable_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('fadetransition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fadetransition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hero_test.dart', () async {
      final result = await SendTestRunner.send('widgets/hero_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('interactiveviewer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/interactiveviewer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('layoutbuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/layoutbuilder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mediaquery_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/mediaquery_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('offstage_test.dart', () async {
      final result = await SendTestRunner.send('widgets/offstage_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('rotationtransition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/rotationtransition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('safearea_test.dart', () async {
      final result = await SendTestRunner.send('widgets/safearea_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaletransition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scaletransition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slidetransition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slidetransition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliverlist_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliverlist_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('table_test.dart', () async {
      final result = await SendTestRunner.send('widgets/table_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('visibility_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/visibility_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // --- Batch 2 widgets ---

    test('clipping_test.dart', () async {
      final result = await SendTestRunner.send('widgets/clipping_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('transform_full_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/transform_full_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sizing_test.dart', () async {
      final result = await SendTestRunner.send('widgets/sizing_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedpadding_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedpadding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedpositioned_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedpositioned_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedsize_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedsize_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedbuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedbuilder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('heromode_test.dart', () async {
      final result = await SendTestRunner.send('widgets/heromode_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('futurebuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/futurebuilder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('streambuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/streambuilder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('valuelistenablebuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/valuelistenablebuilder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_test.dart', () async {
      final result = await SendTestRunner.send('widgets/tooltip_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_test.dart', () async {
      final result = await SendTestRunner.send('widgets/semantics_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('textcontroller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/textcontroller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_test.dart', () async {
      final result = await SendTestRunner.send('widgets/focus_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('nestedscrollview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/nestedscrollview_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('draggablescrollablesheet_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggablescrollablesheet_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('reorderablelistview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/reorderablelistview_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('notificationlistener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/notificationlistener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliverfillremaining_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliverfillremaining_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('opacity_full_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/opacity_full_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('banner_test.dart', () async {
      final result = await SendTestRunner.send('widgets/banner_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // MATERIAL PACKAGE TESTS - BATCH 2 (8 files)
  // ============================================================
  group('material/ batch 2', () {
    test('snackbar_test.dart', () async {
      final result = await SendTestRunner.send('material/snackbar_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('aboutdialog_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/aboutdialog_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menuanchor_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menuanchor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expansionpanel_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/expansionpanel_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('datarow_test.dart', () async {
      final result = await SendTestRunner.send('material/datarow_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('refreshindicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/refreshindicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedicon_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/animatedicon_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('timeofday_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/timeofday_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}

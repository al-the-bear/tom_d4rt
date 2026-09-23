/// Auto-split base bridge tests (file 03).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_base_03_test.dart';

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
  // WIDGETS PACKAGE TESTS (23 files)
  // ============================================================
  group('widgets/', () {
    test('absorbpointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/absorbpointer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animatedcontainer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedcontainer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animatedlist_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedlist_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animatedopacity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedopacity_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('builder_test.dart', () async {
      final result = await SendTestRunner.send('widgets/builder_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('constrainedbox_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/constrainedbox_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('custompaint_test.dart', () async {
      final result = await SendTestRunner.send('widgets/custompaint_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('decoratedbox_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/decoratedbox_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('draggable_test.dart', () async {
      final result = await SendTestRunner.send('widgets/draggable_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('fadetransition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fadetransition_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('hero_test.dart', () async {
      final result = await SendTestRunner.send('widgets/hero_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('interactiveviewer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/interactiveviewer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('layoutbuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/layoutbuilder_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('mediaquery_test.dart', () async {
      final result = await SendTestRunner.send('widgets/mediaquery_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('offstage_test.dart', () async {
      final result = await SendTestRunner.send('widgets/offstage_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('rotationtransition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/rotationtransition_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('safearea_test.dart', () async {
      final result = await SendTestRunner.send('widgets/safearea_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('scaletransition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scaletransition_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('slidetransition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slidetransition_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliverlist_test.dart', () async {
      final result = await SendTestRunner.send('widgets/sliverlist_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('table_test.dart', () async {
      final result = await SendTestRunner.send('widgets/table_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('visibility_test.dart', () async {
      final result = await SendTestRunner.send('widgets/visibility_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    // --- Batch 2 widgets ---

    test('clipping_test.dart', () async {
      final result = await SendTestRunner.send('widgets/clipping_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('sizing_test.dart', () async {
      final result = await SendTestRunner.send('widgets/sizing_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('animatedpadding_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedpadding_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animatedpositioned_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedpositioned_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animatedsize_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedsize_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animatedbuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedbuilder_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('heromode_test.dart', () async {
      final result = await SendTestRunner.send('widgets/heromode_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('futurebuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/futurebuilder_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('streambuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/streambuilder_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('valuelistenablebuilder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/valuelistenablebuilder_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tooltip_test.dart', () async {
      final result = await SendTestRunner.send('widgets/tooltip_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('semantics_test.dart', () async {
      final result = await SendTestRunner.send('widgets/semantics_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('textcontroller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/textcontroller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('focus_test.dart', () async {
      final result = await SendTestRunner.send('widgets/focus_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('nestedscrollview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/nestedscrollview_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('draggablescrollablesheet_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/draggablescrollablesheet_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('reorderablelistview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/reorderablelistview_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('notificationlistener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/notificationlistener_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliverfillremaining_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliverfillremaining_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('opacity_full_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/opacity_full_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('banner_test.dart', () async {
      final result = await SendTestRunner.send('widgets/banner_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // MATERIAL PACKAGE TESTS - BATCH 2 (8 files)
  // ============================================================
  group('material/ batch 2', () {
    test('snackbar_test.dart', () async {
      final result = await SendTestRunner.send('material/snackbar_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('aboutdialog_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/aboutdialog_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('menuanchor_test.dart', () async {
      final result = await SendTestRunner.send('material/menuanchor_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('expansionpanel_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/expansionpanel_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('datarow_test.dart', () async {
      final result = await SendTestRunner.send('material/datarow_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('refreshindicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/refreshindicator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animatedicon_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/animatedicon_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('timeofday_test.dart', () async {
      final result = await SendTestRunner.send('material/timeofday_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });
}

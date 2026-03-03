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
/// Total: 169 test scripts (batch 1 + batch 2 + batch 3 + proxies)
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
      final result = await SendTestRunner.send('widgets/custompaint_test.dart');
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
      final result = await SendTestRunner.send('widgets/mediaquery_test.dart');
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
      final result = await SendTestRunner.send('widgets/sliverlist_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('table_test.dart', () async {
      final result = await SendTestRunner.send('widgets/table_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('visibility_test.dart', () async {
      final result = await SendTestRunner.send('widgets/visibility_test.dart');
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
      final result = await SendTestRunner.send('material/menuanchor_test.dart');
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
      final result = await SendTestRunner.send('material/timeofday_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // MATERIAL PACKAGE TESTS - BATCH 3 (27 files)
  // ============================================================
  group('material/ batch 3', () {
    test('themadata_test.dart', () async {
      final result = await SendTestRunner.send('material/themadata_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('appbar_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/appbar_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('component_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/component_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dialog_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('input_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/input_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('picker_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/picker_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('misc_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/misc_themes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgetstate_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/widgetstate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('licensepage_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/licensepage_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('datepicker_widgets_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/datepicker_widgets_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('timepicker_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/timepicker_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menubar_test.dart', () async {
      final result = await SendTestRunner.send('material/menubar_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('expansiontile_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/expansiontile_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('badge_test.dart', () async {
      final result = await SendTestRunner.send('material/badge_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('material_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pageroute_test.dart', () async {
      final result = await SendTestRunner.send('material/pageroute_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('nav_destinations_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/nav_destinations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dropdownform_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdownform_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rawscrollbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rawscrollbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mergeable_test.dart', () async {
      final result = await SendTestRunner.send('material/mergeable_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('showdialog_test.dart', () async {
      final result = await SendTestRunner.send('material/showdialog_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('showbottomsheet_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/showbottomsheet_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('showmenu_test.dart', () async {
      final result = await SendTestRunner.send('material/showmenu_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('showdatepicker_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/showdatepicker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('showtimepicker_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/showtimepicker_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // WIDGETS PACKAGE TESTS - BATCH 3 (20 files)
  // ============================================================
  group('widgets/ batch 3', () {
    test('listbody_test.dart', () async {
      final result = await SendTestRunner.send('widgets/listbody_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('flow_test.dart', () async {
      final result = await SendTestRunner.send('widgets/flow_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('pagecontroller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/pagecontroller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tabcontroller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tabcontroller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_test.dart', () async {
      final result = await SendTestRunner.send('widgets/overlay_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_test.dart', () async {
      final result = await SendTestRunner.send('widgets/route_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('localizations_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/localizations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('actions_test.dart', () async {
      final result = await SendTestRunner.send('widgets/actions_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('focustraversal_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focustraversal_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('blocksemantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/blocksemantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollnotification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollnotification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keepalive_test.dart', () async {
      final result = await SendTestRunner.send('widgets/keepalive_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliverwidgets_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliverwidgets_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatedgrid_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedgrid_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('listener_test.dart', () async {
      final result = await SendTestRunner.send('widgets/listener_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('backbutton_test.dart', () async {
      final result = await SendTestRunner.send('widgets/backbutton_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('router_test.dart', () async {
      final result = await SendTestRunner.send('widgets/router_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigatorstate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigatorstate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('formstate_test.dart', () async {
      final result = await SendTestRunner.send('widgets/formstate_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffoldstate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scaffoldstate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // CUPERTINO PACKAGE TESTS (12 files)
  // ============================================================
  group('cupertino/', () {
    test('localization_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/localization_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_widgets_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/menu_widgets_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pulldown_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/pulldown_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('toolbar_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/toolbar_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('magnifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/magnifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('refresh_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/refresh_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('datepicker_modes_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/datepicker_modes_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tab_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/tab_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_themes_batch1_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_themes_batch1_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_themes_batch2_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_themes_batch2_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_themes_batch3_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_themes_batch3_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertino_themes_batch4_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_themes_batch4_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // PAINTING PACKAGE TESTS (8 files)
  // ============================================================
  group('painting/', () {
    test('shapes_test.dart', () async {
      final result = await SendTestRunner.send('painting/shapes_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('gradients_test.dart', () async {
      final result = await SendTestRunner.send('painting/gradients_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('decoration_test.dart', () async {
      final result = await SendTestRunner.send('painting/decoration_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_providers_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_providers_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('colors_test.dart', () async {
      final result = await SendTestRunner.send('painting/colors_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('matrix_test.dart', () async {
      final result = await SendTestRunner.send('painting/matrix_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_painting_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/text_painting_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/text_selection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // ANIMATION PACKAGE TESTS (5 files)
  // ============================================================
  group('animation/', () {
    test('animationstyle_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animationstyle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('alwaysstoppedanimation_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/alwaysstoppedanimation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('compoundanimation_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/compoundanimation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tweensequence_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/tweensequence_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('animatable_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animatable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // PHYSICS PACKAGE TESTS (1 file)
  // ============================================================
  group('physics/', () {
    test('simulations_test.dart', () async {
      final result = await SendTestRunner.send(
        'physics/simulations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // FOUNDATION PACKAGE TESTS (3 files)
  // ============================================================
  group('foundation/', () {
    test('error_test.dart', () async {
      final result = await SendTestRunner.send('foundation/error_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostics_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('license_test.dart', () async {
      final result = await SendTestRunner.send('foundation/license_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // DART:UI PACKAGE TESTS (6 files)
  // ============================================================
  group('dart_ui/', () {
    test('paragraph_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/paragraph_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_data_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/text_data_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('filters_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/filters_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('font_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/font_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('vertices_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/vertices_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('picture_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/picture_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // GESTURES PACKAGE TESTS (2 files)
  // ============================================================
  group('gestures/', () {
    test('recognizers_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/recognizers_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('velocity_test.dart', () async {
      final result = await SendTestRunner.send('gestures/velocity_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SERVICES PACKAGE TESTS (8 files)
  // ============================================================
  group('services/', () {
    test('codecs_test.dart', () async {
      final result = await SendTestRunner.send('services/codecs_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('channels_test.dart', () async {
      final result = await SendTestRunner.send('services/channels_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_test.dart', () async {
      final result = await SendTestRunner.send('services/keyboard_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('cursor_test.dart', () async {
      final result = await SendTestRunner.send('services/cursor_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('textboundary_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/textboundary_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('spellcheck_test.dart', () async {
      final result = await SendTestRunner.send('services/spellcheck_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_test.dart', () async {
      final result = await SendTestRunner.send('services/platform_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('asset_test.dart', () async {
      final result = await SendTestRunner.send('services/asset_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SEMANTICS PACKAGE TESTS (1 file)
  // ============================================================
  group('semantics/', () {
    test('semantics_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SCHEDULER PACKAGE TESTS (1 file)
  // ============================================================
  group('scheduler/', () {
    test('tickerfuture_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/tickerfuture_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // RENDERING PACKAGE TESTS (10 files)
  // ============================================================
  group('rendering/', () {
    test('renderobjects_basic_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_basic_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('renderobjects_clip_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_clip_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('renderobjects_layout_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_layout_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('renderobjects_sizing_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_sizing_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('renderobjects_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_sliver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('renderobjects_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderobjects_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('canvas_test.dart', () async {
      final result = await SendTestRunner.send('rendering/canvas_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('layers_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/layers_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_delegates_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_delegates_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('parentdata_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/parentdata_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // PROXY CLASS TESTS (5 files) — Phase 4: GEN-083
  // ============================================================
  group('proxies/', () {
    test('custompaint_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/custompaint_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('customclipper_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/customclipper_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flowdelegate_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/flowdelegate_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multichildlayout_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/multichildlayout_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('singlechildlayout_proxy_test.dart', () async {
      final result = await SendTestRunner.send(
        'proxies/singlechildlayout_proxy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}

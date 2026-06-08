/// Auto-split base bridge tests (file 04).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
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
        reason: 'Test app should be running (managed by setUpAll).',
      );
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

    // GEN-088: menu_widgets_test.dart and pulldown_test.dart removed —
    // CupertinoMenuAnchor and CupertinoPulldownButton don't exist in
    // Flutter 3.41.2 stable. Re-add when upgrading to a Flutter version
    // that includes these APIs.

    test('toolbar_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/toolbar_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('magnifier_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/magnifier_test.dart');
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
      final result = await SendTestRunner.send('physics/simulations_test.dart');
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
}

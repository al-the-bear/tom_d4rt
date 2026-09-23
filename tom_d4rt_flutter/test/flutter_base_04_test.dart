/// Auto-split base bridge tests (file 04).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_base_04_test.dart';

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
  // MATERIAL PACKAGE TESTS - BATCH 3 (27 files)
  // ============================================================
  group('material/ batch 3', () {
    test('themadata_test.dart', () async {
      final result = await SendTestRunner.send('material/themadata_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('appbar_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/appbar_themes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('navigation_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/navigation_themes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('component_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/component_themes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dialog_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dialog_themes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('input_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/input_themes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('picker_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/picker_themes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('menu_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/menu_themes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('misc_themes_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/misc_themes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('widgetstate_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/widgetstate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('licensepage_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/licensepage_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('datepicker_widgets_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/datepicker_widgets_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('timepicker_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/timepicker_widget_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('menubar_test.dart', () async {
      final result = await SendTestRunner.send('material/menubar_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('expansiontile_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/expansiontile_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('badge_test.dart', () async {
      final result = await SendTestRunner.send('material/badge_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('material_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/material_widget_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('pageroute_test.dart', () async {
      final result = await SendTestRunner.send('material/pageroute_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('nav_destinations_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/nav_destinations_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dropdownform_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/dropdownform_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('rawscrollbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/rawscrollbar_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('mergeable_test.dart', () async {
      final result = await SendTestRunner.send('material/mergeable_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // WIDGETS PACKAGE TESTS - BATCH 3 (20 files)
  // ============================================================
  group('widgets/ batch 3', () {
    test('listbody_test.dart', () async {
      final result = await SendTestRunner.send('widgets/listbody_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('flow_test.dart', () async {
      final result = await SendTestRunner.send('widgets/flow_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('pagecontroller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/pagecontroller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tabcontroller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tabcontroller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('overlay_test.dart', () async {
      final result = await SendTestRunner.send('widgets/overlay_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('route_test.dart', () async {
      final result = await SendTestRunner.send('widgets/route_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('localizations_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/localizations_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('actions_test.dart', () async {
      final result = await SendTestRunner.send('widgets/actions_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('focustraversal_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/focustraversal_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('blocksemantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/blocksemantics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scrollnotification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollnotification_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('keepalive_test.dart', () async {
      final result = await SendTestRunner.send('widgets/keepalive_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('sliverwidgets_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliverwidgets_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animatedgrid_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animatedgrid_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('listener_test.dart', () async {
      final result = await SendTestRunner.send('widgets/listener_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('backbutton_test.dart', () async {
      final result = await SendTestRunner.send('widgets/backbutton_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('router_test.dart', () async {
      final result = await SendTestRunner.send('widgets/router_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('navigatorstate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigatorstate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('formstate_test.dart', () async {
      final result = await SendTestRunner.send('widgets/formstate_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('scaffoldstate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scaffoldstate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
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
      SendTestRunner.expectSuccess(result);
    });

    // GEN-088: menu_widgets_test.dart and pulldown_test.dart removed —
    // CupertinoMenuAnchor and CupertinoPulldownButton don't exist in
    // Flutter 3.41.2 stable. Re-add when upgrading to a Flutter version
    // that includes these APIs.

    test('toolbar_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/toolbar_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('magnifier_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/magnifier_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('refresh_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/refresh_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('datepicker_modes_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/datepicker_modes_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tab_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/tab_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_themes_batch1_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_themes_batch1_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_themes_batch2_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_themes_batch2_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_themes_batch3_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_themes_batch3_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('cupertino_themes_batch4_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_themes_batch4_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // PAINTING PACKAGE TESTS (8 files)
  // ============================================================
  group('painting/', () {
    test('shapes_test.dart', () async {
      final result = await SendTestRunner.send('painting/shapes_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('gradients_test.dart', () async {
      final result = await SendTestRunner.send('painting/gradients_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('decoration_test.dart', () async {
      final result = await SendTestRunner.send('painting/decoration_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('image_providers_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/image_providers_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('colors_test.dart', () async {
      final result = await SendTestRunner.send('painting/colors_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('matrix_test.dart', () async {
      final result = await SendTestRunner.send('painting/matrix_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('text_painting_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/text_painting_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_selection_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/text_selection_test.dart',
      );
      SendTestRunner.expectSuccess(result);
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
      SendTestRunner.expectSuccess(result);
    });

    test('alwaysstoppedanimation_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/alwaysstoppedanimation_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('compoundanimation_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/compoundanimation_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tweensequence_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/tweensequence_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('animatable_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/animatable_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // PHYSICS PACKAGE TESTS (1 file)
  // ============================================================
  group('physics/', () {
    test('simulations_test.dart', () async {
      final result = await SendTestRunner.send('physics/simulations_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // FOUNDATION PACKAGE TESTS (3 files)
  // ============================================================
  group('foundation/', () {
    test('error_test.dart', () async {
      final result = await SendTestRunner.send('foundation/error_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('diagnostics_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('license_test.dart', () async {
      final result = await SendTestRunner.send('foundation/license_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });
}

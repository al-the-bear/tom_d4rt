/// Tests for essential Flutter bridge classes.
///
/// These tests use the SendTestRunner to send D4rt scripts to the test app
/// and verify they execute correctly. Each test corresponds to a script
/// in the send_ast_via_http_scripts directory.
///
/// Prerequisites:
/// 1. Start the test app: cd test/tom_d4rt_flutterm_app && flutter run
/// 2. Run tests: flutter test test/essential_classes_test.dart
///
/// Tests are organized by Flutter package (widgets, material, cupertino, etc.)
/// and test the bridged classes listed in testplan_essential.md.
///
/// Total: 107 test scripts
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
  // ANIMATION PACKAGE TESTS (2 files)
  // ============================================================
  group('animation/', () {
    test('curve_test.dart', () async {
      final result = await SendTestRunner.send('animation/curve_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('tween_test.dart', () async {
      final result = await SendTestRunner.send('animation/tween_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // CUPERTINO PACKAGE TESTS (14 files)
  // ============================================================
  group('cupertino/', () {
    test('button_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/button_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('contextmenu_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/contextmenu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('controls_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/controls_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('cupertinoapp_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertinoapp_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/dialog_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('form_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/form_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('icons_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/icons_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/list_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('picker_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/picker_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/route_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/scaffold_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('segmented_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/segmented_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('textfield_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/textfield_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('theme_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/theme_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // DART:UI PACKAGE TESTS (8 files)
  // ============================================================
  group('dart_ui/', () {
    test('color_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/color_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('geometry_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/geometry_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('offset_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/offset_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('paint_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/paint_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('primitives_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/primitives_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('rect_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/rect_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('size_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/size_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/text_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // FOUNDATION PACKAGE TESTS (2 files)
  // ============================================================
  group('foundation/', () {
    test('key_test.dart', () async {
      final result = await SendTestRunner.send('foundation/key_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('notifier_test.dart', () async {
      final result = await SendTestRunner.send('foundation/notifier_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // GESTURES PACKAGE TESTS (1 file)
  // ============================================================
  group('gestures/', () {
    test('details_test.dart', () async {
      final result = await SendTestRunner.send('gestures/details_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // MATERIAL PACKAGE TESTS (29 files)
  // ============================================================
  group('material/', () {
    test('bottomnavigationbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/bottomnavigationbar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('buttons_test.dart', () async {
      final result = await SendTestRunner.send('material/buttons_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('buttonstyle_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/buttonstyle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('card_test.dart', () async {
      final result = await SendTestRunner.send('material/card_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('chips_test.dart', () async {
      final result = await SendTestRunner.send('material/chips_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('datatable_test.dart', () async {
      final result = await SendTestRunner.send('material/datatable_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('dialog_test.dart', () async {
      final result = await SendTestRunner.send('material/dialog_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('divider_test.dart', () async {
      final result = await SendTestRunner.send('material/divider_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('dropdown_test.dart', () async {
      final result = await SendTestRunner.send('material/dropdown_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('elevated_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/elevated_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expansion_test.dart', () async {
      final result = await SendTestRunner.send('material/expansion_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('floatingactionbutton_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/floatingactionbutton_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('formcontrols_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/formcontrols_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('icon_test.dart', () async {
      final result = await SendTestRunner.send('material/icon_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('icontheme_test.dart', () async {
      final result = await SendTestRunner.send('material/icontheme_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('inputdecoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/inputdecoration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('listtile_test.dart', () async {
      final result = await SendTestRunner.send('material/listtile_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('materialapp_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/materialapp_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('materialbanner_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/materialbanner_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('materialcolor_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/materialcolor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_test.dart', () async {
      final result = await SendTestRunner.send('material/navigation_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('progress_test.dart', () async {
      final result = await SendTestRunner.send('material/progress_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_test.dart', () async {
      final result = await SendTestRunner.send('material/scaffold_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('search_test.dart', () async {
      final result = await SendTestRunner.send('material/search_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('stepper_test.dart', () async {
      final result = await SendTestRunner.send('material/stepper_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('tabs_test.dart', () async {
      final result = await SendTestRunner.send('material/tabs_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_button_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('theme_test.dart', () async {
      final result = await SendTestRunner.send('material/theme_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_badge_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tooltip_badge_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // PAINTING PACKAGE TESTS (8 files)
  // ============================================================
  group('painting/', () {
    test('alignment_test.dart', () async {
      final result = await SendTestRunner.send('painting/alignment_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('border_radius_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/border_radius_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('border_test.dart', () async {
      final result = await SendTestRunner.send('painting/border_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('box_decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/box_decoration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('edge_insets_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/edge_insets_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('edgeinsets_test.dart', () async {
      final result = await SendTestRunner.send('painting/edgeinsets_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('gradient_shadow_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/gradient_shadow_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('textstyle_test.dart', () async {
      final result = await SendTestRunner.send('painting/textstyle_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // PHYSICS PACKAGE TESTS (1 file)
  // ============================================================
  group('physics/', () {
    test('spring_test.dart', () async {
      final result = await SendTestRunner.send('physics/spring_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // RENDERING PACKAGE TESTS (4 files)
  // ============================================================
  group('rendering/', () {
    test('boxconstraints_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/boxconstraints_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('layers_test.dart', () async {
      final result = await SendTestRunner.send('rendering/layers_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('textpainter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/textpainter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('viewport_test.dart', () async {
      final result = await SendTestRunner.send('rendering/viewport_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SCHEDULER PACKAGE TESTS (1 file)
  // ============================================================
  group('scheduler/', () {
    test('ticker_test.dart', () async {
      final result = await SendTestRunner.send('scheduler/ticker_test.dart');
      expect(result.success, isTrue, reason: result.error);
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

    test('appbar_test.dart', () async {
      final result = await SendTestRunner.send('widgets/appbar_test.dart');
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

    test('icon_test.dart', () async {
      final result = await SendTestRunner.send('widgets/icon_test.dart');
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

    test('singlechildscrollview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/singlechildscrollview_test.dart',
      );
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
}

/// Auto-split base bridge tests (file 01).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_base_01_test.dart';

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
      // 1944 TODO C.1 (2026-05-31): historical 60 s wrapper +
      // `httpBuildTimeout: 50 s` REMOVED. The script now runs in
      // ~3 s under normal load (verified httpMs=3088 on isolated
      // retest) — well inside the default 30 s `test()` timeout
      // and the default 25 s `httpBuildTimeout`. The original
      // 20260524-2003 §6/T1 cold-start contention that motivated
      // the wrapper has been resolved by the §U25/§U28 mitigations
      // shipped across A.1-A.8 + B.1-B.12 closures.
      final result = await SendTestRunner.send('cupertino/list_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    // 20260524-2003 baseline §6/E1–E4: the first 4 large cupertino scripts
    // in essential_classes_test cascade-fail under cold-start contention on
    // a freshly-launched test app. Historical 60 s wrapper +
    // `httpBuildTimeout: 50 s` on each. 1944 TODO C.2-C.5 (2026-05-31)
    // closures remove the wrappers one at a time as each script is
    // re-verified under normal load after the §U25/§U28 mitigations
    // from A.1-A.8 + B.1-B.12 closures.
    test('picker_test.dart', () async {
      // 1944 TODO C.2 (2026-05-31): wrapper REMOVED. Script runs in
      // ~2.4 s under normal load (httpMs=2446) — well inside the
      // default 30 s `test()` timeout and 25 s `httpBuildTimeout`.
      final result = await SendTestRunner.send('cupertino/picker_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/route_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('scaffold_test.dart', () async {
      // 1944 TODO C.3 (2026-05-31): wrapper REMOVED. Script runs in
      // ~2.6 s under normal load (httpMs=2580) — well inside the
      // default 30 s `test()` timeout and 25 s `httpBuildTimeout`.
      final result = await SendTestRunner.send('cupertino/scaffold_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('segmented_test.dart', () async {
      // 1944 TODO C.4 (2026-05-31): wrapper REMOVED. Script runs in
      // ~2.7 s under normal load (httpMs=2728).
      final result = await SendTestRunner.send('cupertino/segmented_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('textfield_test.dart', () async {
      // 1944 TODO C.5 (2026-05-31): wrapper REMOVED. Script runs in
      // ~1.8 s under normal load (httpMs=1825). This is the last of
      // the historical §6/E1-E4 cluster (picker/scaffold/segmented/
      // textfield) cold-start wrappers — all four removed across
      // C.2-C.5; the cluster comment above picker_test no longer
      // applies but is retained as historical context.
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
      // 1944 TODO C.6 (2026-05-31): historical 20260524-2003 §6/E5
      // cold-start cascade wrapper REMOVED. Script runs in ~1.4 s
      // under normal load (httpMs=1432).
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
}

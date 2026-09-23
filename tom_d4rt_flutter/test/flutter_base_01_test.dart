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
      SendTestRunner.expectSuccess(result);
    });

    test('tween_test.dart', () async {
      final result = await SendTestRunner.send('animation/tween_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // CUPERTINO PACKAGE TESTS (14 files)
  // ============================================================
  group('cupertino/', () {
    test('button_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/button_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('contextmenu_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/contextmenu_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('controls_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/controls_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('cupertinoapp_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertinoapp_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('dialog_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/dialog_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('form_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/form_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('icons_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/icons_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('list_test.dart', () async {
      // 1944 TODO C.7 (2026-05-31): historical 20260524-2003 §6/T1
      // cold-start wrapper REMOVED. Script runs in ~3.4 s under
      // normal load (httpMs=3421) on the source-direct TEST path —
      // well inside the default 30 s `test()` timeout and the
      // default 25 s `httpBuildTimeout`. Mirror of the AST C.1
      // closure.
      final result = await SendTestRunner.send('cupertino/list_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    // 20260524-2003 baseline §6/E1–E4: the first 4 large cupertino scripts
    // in essential_classes_test cascade-fail under cold-start contention on
    // a freshly-launched test app (flutter_ast variant; flutter_test was
    // clean in the baseline but kept symmetric to avoid future drift).
    // Bump cap from 25 s to 50 s with 60 s dart-test wrapper on each.
    test('picker_test.dart', () async {
      // 1944 TODO C.8 (2026-05-31): wrapper REMOVED. Script runs in
      // ~2.7 s under normal load (httpMs=2652). TEST mirror of C.2.
      final result = await SendTestRunner.send('cupertino/picker_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('route_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/route_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('scaffold_test.dart', () async {
      // 1944 TODO C.9 (2026-05-31): wrapper REMOVED. Script runs in
      // ~2.8 s under normal load (httpMs=2789). TEST mirror of C.3.
      final result = await SendTestRunner.send('cupertino/scaffold_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('segmented_test.dart', () async {
      // 1944 TODO C.10 (2026-05-31): wrapper REMOVED. Script runs in
      // ~3.2 s under normal load (httpMs=3167). TEST mirror of C.4.
      final result = await SendTestRunner.send('cupertino/segmented_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('textfield_test.dart', () async {
      // 1944 TODO C.11 (2026-05-31): wrapper REMOVED. Script runs in
      // ~1.9 s under normal load (httpMs=1938). TEST mirror of C.5.
      // Last of the TEST §6/T1/§6/E1-E4 cluster (C.7-C.11 closed
      // the TEST mirrors of the AST cupertino cold-start cluster).
      final result = await SendTestRunner.send('cupertino/textfield_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('theme_test.dart', () async {
      final result = await SendTestRunner.send('cupertino/theme_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // DART:UI PACKAGE TESTS (8 files)
  // ============================================================
  group('dart_ui/', () {
    // 20260524-2003 baseline §6/E5: cold-start cascade victim from the
    // cupertino group above. Bump cap from 25 s to 50 s.
    test('color_test.dart', () async {
      // 1944 TODO C.12 (2026-05-31): wrapper REMOVED. Script runs in
      // ~1.5 s under normal load (httpMs=1461). TEST mirror of C.6.
      // Last entry in §C.i — closes the entire essential_classes_test
      // historical cold-start wrapper cleanup (C.1-C.12).
      final result = await SendTestRunner.send('dart_ui/color_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('geometry_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/geometry_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('offset_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/offset_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('paint_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/paint_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('primitives_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/primitives_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('rect_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/rect_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('size_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/size_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('text_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/text_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // FOUNDATION PACKAGE TESTS (2 files)
  // ============================================================
  group('foundation/', () {
    test('key_test.dart', () async {
      final result = await SendTestRunner.send('foundation/key_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('notifier_test.dart', () async {
      final result = await SendTestRunner.send('foundation/notifier_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // GESTURES PACKAGE TESTS (1 file)
  // ============================================================
  group('gestures/', () {
    test('details_test.dart', () async {
      final result = await SendTestRunner.send('gestures/details_test.dart');
      SendTestRunner.expectSuccess(result);
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
      SendTestRunner.expectSuccess(result);
    });

    test('buttons_test.dart', () async {
      final result = await SendTestRunner.send('material/buttons_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('buttonstyle_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/buttonstyle_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('card_test.dart', () async {
      final result = await SendTestRunner.send('material/card_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('chips_test.dart', () async {
      final result = await SendTestRunner.send('material/chips_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('datatable_test.dart', () async {
      final result = await SendTestRunner.send('material/datatable_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('dialog_test.dart', () async {
      final result = await SendTestRunner.send('material/dialog_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('divider_test.dart', () async {
      final result = await SendTestRunner.send('material/divider_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('dropdown_test.dart', () async {
      final result = await SendTestRunner.send('material/dropdown_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('elevated_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/elevated_button_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('expansion_test.dart', () async {
      final result = await SendTestRunner.send('material/expansion_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('floatingactionbutton_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/floatingactionbutton_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('formcontrols_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/formcontrols_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('icon_test.dart', () async {
      final result = await SendTestRunner.send('material/icon_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('icontheme_test.dart', () async {
      final result = await SendTestRunner.send('material/icontheme_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('inputdecoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/inputdecoration_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('listtile_test.dart', () async {
      final result = await SendTestRunner.send('material/listtile_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('materialapp_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/materialapp_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('materialbanner_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/materialbanner_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('materialcolor_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/materialcolor_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('navigation_test.dart', () async {
      final result = await SendTestRunner.send('material/navigation_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('progress_test.dart', () async {
      final result = await SendTestRunner.send('material/progress_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('scaffold_test.dart', () async {
      final result = await SendTestRunner.send('material/scaffold_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('search_test.dart', () async {
      final result = await SendTestRunner.send('material/search_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('stepper_test.dart', () async {
      final result = await SendTestRunner.send('material/stepper_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('tabs_test.dart', () async {
      final result = await SendTestRunner.send('material/tabs_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('text_button_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/text_button_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('theme_test.dart', () async {
      final result = await SendTestRunner.send('material/theme_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('tooltip_badge_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tooltip_badge_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // PAINTING PACKAGE TESTS (8 files)
  // ============================================================
  group('painting/', () {
    test('alignment_test.dart', () async {
      final result = await SendTestRunner.send('painting/alignment_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('border_radius_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/border_radius_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('border_test.dart', () async {
      final result = await SendTestRunner.send('painting/border_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('box_decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/box_decoration_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('edge_insets_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/edge_insets_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('edgeinsets_test.dart', () async {
      final result = await SendTestRunner.send('painting/edgeinsets_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('gradient_shadow_test.dart', () async {
      final result = await SendTestRunner.send(
        'painting/gradient_shadow_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('textstyle_test.dart', () async {
      final result = await SendTestRunner.send('painting/textstyle_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // PHYSICS PACKAGE TESTS (1 file)
  // ============================================================
  group('physics/', () {
    test('spring_test.dart', () async {
      final result = await SendTestRunner.send('physics/spring_test.dart');
      SendTestRunner.expectSuccess(result);
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
      SendTestRunner.expectSuccess(result);
    });

    test('layers_test.dart', () async {
      final result = await SendTestRunner.send('rendering/layers_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('textpainter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/textpainter_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('viewport_test.dart', () async {
      final result = await SendTestRunner.send('rendering/viewport_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // SCHEDULER PACKAGE TESTS (1 file)
  // ============================================================
  group('scheduler/', () {
    test('ticker_test.dart', () async {
      final result = await SendTestRunner.send('scheduler/ticker_test.dart');
      SendTestRunner.expectSuccess(result);
    });
  });
}

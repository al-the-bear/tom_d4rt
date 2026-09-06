/// Auto-split extended bridge tests (file 23).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'dart:io' show Platform;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_23_test.dart';

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

  group('Section 1 - Tests with workarounds reverted', () {
    // Animation
    test('retest: animation/reverse_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/animation/reverse_tween_test.dart',
      );
      expectSuccess(result);
    });

    // Dart UI
    test('retest: dart_ui/key_event_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/dart_ui/key_event_type_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: dart_ui/vertex_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/dart_ui/vertex_mode_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: dart_ui/color_space_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/dart_ui/color_space_test.dart',
      );
      expectSuccess(result);
    });

    test(
      'retest: dart_ui/system_color_palette_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/dart_ui/system_color_palette_test.dart',
        );
        expectSuccess(result);
      },
      // SCC47 (2026-09-06): this test used to carry
      //   skip: 'SystemColor not supported on desktop platforms (web-only API)'
      // whose comment blamed the d4rt bridge for "wrapping the native
      // UnsupportedError so the script's catch (e) does not intercept it".
      // That accusation was false. tom_d4rt{,_ast}'s
      // scc47_bridged_throw_catchable_test.dart shows a throwing bridged
      // static getter / static method / instance getter / instance method is
      // caught by interpreted `catch (e)`, and by `on UnsupportedError` too.
      //
      // The real cause was a mis-placed guard in the script: `SystemColor.light`
      // and `.dark` are non-throwing `static final` fields, so the try/catch
      // wrapped around them could never fire, while the PALETTE MEMBER reads
      // below it (canvas, canvasText, ...) throw on every non-web platform and
      // ran unguarded. Compiled Flutter fails identically. The script now gates
      // on `platformProvidesSystemColors` — the probe its own "Usage Example"
      // card recommends — and passes measured on desktop.
    );

    // Foundation
    test('retest: foundation/object_created_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/foundation/object_created_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: foundation/object_disposed_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/foundation/object_disposed_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: foundation/object_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/foundation/object_event_test.dart',
      );
      expectSuccess(result);
    });

    // Material
    test('retest: material/bottom_navigation_bar_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/bottom_navigation_bar_type_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/button_bar_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/button_bar_theme_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/button_bar_layout_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/button_bar_layout_behavior_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/button_text_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/button_text_theme_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/dropdown_menu_close_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/dropdown_menu_close_behavior_test.dart',
      );
      expectSuccess(result);
    });

    test(
      'retest: material/gapped_range_slider_track_shape_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/material/gapped_range_slider_track_shape_test.dart',
        );
        expectSuccess(result);
      },
    );

    test('retest: material/hour_format_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/hour_format_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/material_banner_closed_reason_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/material_banner_closed_reason_test.dart',
      );
      expectSuccess(result);
    });

    test(
      'retest: material/navigation_destination_label_behavior_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/material/navigation_destination_label_behavior_test.dart',
        );
        expectSuccess(result);
      },
    );

    test('retest: material/navigation_rail_label_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/navigation_rail_label_type_test.dart',
      );
      expectSuccess(result);
    });

    // 1944 TODO C.150 (2026-06-02): wrapper removed. Isolated retest
    // runs in ~2.2 s (httpMs≈2.0 s, frameworkErrors=0, outputLines=75
    // — rich coverage). The 60 s `_slowTestTimeout` was cold-start
    // padding only; defaults (25 s httpBuildTimeout + 30 s dart-test
    // timeout) leave ~28 s headroom. `_slowTestTimeout` is retained —
    // it is still used by many other entries in this file.
    test('retest: material/popup_menu_position_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/popup_menu_position_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/theme_extension_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/theme_extension_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/toggle_buttons_theme_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/toggle_buttons_theme_data_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: material/toggle_buttons_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/material/toggle_buttons_theme_test.dart',
      );
      expectSuccess(result);
    });

    // Painting
    test('retest: painting/axis_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/painting/axis_direction_test.dart',
      );
      expectSuccess(result);
    });

    // Rendering
    test('retest: rendering/hit_test_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/rendering/hit_test_behavior_test.dart',
      );
      expectSuccess(result);
    });

    test(
      'retest: rendering/over_scroll_header_stretch_configuration_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/rendering/over_scroll_header_stretch_configuration_test.dart',
        );
        expectSuccess(result);
      },
    );

    test(
      'retest: rendering/render_android_view_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/rendering/render_android_view_test.dart',
        );
        expectSuccess(result);
      },
      skip: Platform.isAndroid
          // This script builds an AndroidView PlatformView with the view type
          // `demo/native-map`. On any non-Android host the Flutter embedder's
          // platform-view channel does not just return a catchable Dart
          // `PlatformException` — on macOS `-[FlutterPlatformViewController
          // handleMethodCall:result:]` throws an uncatchable native
          // `NSInvalidArgumentException` that terminates the whole companion
          // app ("Lost connection to device"). The app death then fails the
          // NEXT test's `/clear` with `httpStatus=-1` (collateral damage), so a
          // single Android-only test takes a sibling down with it. AndroidView
          // is meaningful only on Android, so gate the retest accordingly.
          //
          // SCC47 (2026-09-06) re-derived this from git history rather than
          // assuming it: the skip was added by 7817bcc31 on 2026-06-24, which
          // is what turned extended_23's `+44 ~1 -1` into `+44 ~2`. It is a
          // genuine HOST-CAPABILITY guard, not a silenced interpreter defect —
          // the exception is an uncatchable Objective-C
          // NSInvalidArgumentException raised inside the macOS embedder,
          // outside any Dart (let alone interpreted) frame, and it kills the
          // companion app. Nothing in the interpreter can observe or survive
          // it, so leaving this measured would cost a sibling test as well.
          // This one stays skipped, deliberately.
          ? null
          : 'AndroidView PlatformView crashes the embedder on non-Android hosts',
    );

    // 1944 TODO C.162 (2026-06-02): the 60 s `_slowTestTimeout` wrapper was
    // removed. Pre-fix isolated retest builds the 54 KB source in ~2.0 s
    // (httpMs=1781, totalMs=2015, frameworkErrors=0, outputLines=19,
    // sourceChars=54210, status=success) — the §U25 cold-start padding masked
    // nothing on the build side. Defaults now apply (25 s httpBuildTimeout +
    // 30 s dart-test timeout), leaving ~28 s headroom over the ~2.0 s build.
    // No `waitBeforeClear` buffer was attached, so the strip is wrapper-only.
    // `_slowTestTimeout` const retained — still used by other entries.
    test('retest: widgets/nested_scroll_view_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/nested_scroll_view_state_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/next_focus_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/next_focus_intent_test.dart',
      );
      expectSuccess(result);
    });

    // 1944 TODO C.163 (2026-06-02): the 60 s `_slowTestTimeout` wrapper was
    // §U25 cold-start padding only — the build runs in ~2.0 s (httpMs=1758,
    // totalMs=2034, frameworkErrors=0, outputLines=26, sourceChars=47530).
    // Stripped the `timeout: _slowTestTimeout` argument; defaults (25 s
    // httpBuildTimeout + 30 s dart-test timeout) leave ~28 s headroom.
    // `_slowTestTimeout` const retained — still used by 9 other entries.
    test('retest: widgets/object_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/object_key_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/raw_dialog_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/raw_dialog_route_test.dart',
      );
      expectSuccess(result);
    });

    // 1944 TODO C.164 (2026-06-02): the 60 s `_slowTestTimeout` wrapper was
    // §U25 cold-start padding that masked nothing on the build side. The
    // isolated retest builds the 74 KB source in ~2.0 s (httpMs≈2006,
    // totalMs≈2237, frameworkErrors=0, outputLines=0, sourceChars=74407).
    // Stripped the `timeout: _slowTestTimeout` argument; defaults (25 s
    // httpBuildTimeout + 30 s dart-test timeout) now apply with ~28 s
    // headroom over the ~2.2 s build. No `waitBeforeClear` buffer and no
    // B.6/B.7 requestRecycle() §U28 protection on this script — clean
    // wrapper-only strip. `_slowTestTimeout` const retained — still used by
    // 7 other entries.
    test('retest: widgets/raw_keyboard_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/raw_keyboard_listener_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/raw_menu_overlay_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/raw_menu_overlay_info_test.dart',
      );
      expectSuccess(result);
    });

    // 1944 TODO C.165 (2026-06-02): the 60 s `_slowTestTimeout` wrapper was
    // §U25 cold-start padding that masked nothing on the build side. The
    // isolated retest builds the 47 KB source in ~1.8 s (httpMs≈1751,
    // totalMs≈2026, frameworkErrors=0, outputLines=11, sourceChars=46879).
    // Stripped the `timeout: _slowTestTimeout` argument; defaults (25 s
    // httpBuildTimeout + 30 s dart-test timeout) now apply with ~28 s
    // headroom over the ~2.0 s build. No `waitBeforeClear` buffer and no
    // B.6/B.7 requestRecycle() §U28 protection on this script — clean
    // wrapper-only strip. `_slowTestTimeout` const retained — still used by
    // 6 other entries.
    test('retest: widgets/raw_radio_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/raw_radio_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/redo_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/redo_text_intent_test.dart',
      );
      expectSuccess(result);
    });

    // 1944 TODO C.166 (2026-06-02): the 60 s `_slowTestTimeout` wrapper was
    // §U25 cold-start padding only — the build runs in ~1.85 s (httpMs=1638,
    // totalMs=1852, frameworkErrors=0, outputLines=1, sourceChars=67980 — 68 KB
    // source exercising the full RegularWindowControllerDelegate widget API).
    // Stripped the `timeout: _slowTestTimeout` argument; defaults (25 s
    // httpBuildTimeout + 30 s dart-test timeout) now apply with ~28 s headroom
    // over the ~1.9 s build. No `waitBeforeClear` buffer and no B.6/B.7
    // requestRecycle() §U28 protection on this script — clean wrapper-only
    // strip. `_slowTestTimeout` const retained — still used by 5 other entries.
    test(
      'retest: widgets/regular_window_controller_delegate_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/widgets/regular_window_controller_delegate_test.dart',
        );
        expectSuccess(result);
      },
    );

    test('retest: widgets/regular_window_controller_linux_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/regular_window_controller_linux_test.dart',
      );
      expectSuccess(result);
    });

    // 1944 TODO C.167 (2026-06-02): the 60 s `_slowTestTimeout` wrapper was
    // §U25 cold-start padding only — the build runs in ~2.0 s (httpMs=1756,
    // totalMs=1990, frameworkErrors=0, outputLines=1, sourceChars=72928 — 73 KB
    // source exercising the full RegularWindowControllerMacOS widget API).
    // Stripped the `timeout: _slowTestTimeout` argument; defaults (25 s
    // httpBuildTimeout + 30 s dart-test timeout) now apply with ~28 s headroom
    // over the ~2.0 s build. No `waitBeforeClear` buffer and no B.6/B.7
    // requestRecycle() §U28 protection on this script — clean wrapper-only
    // strip. `_slowTestTimeout` const retained — still used by 4 other entries.
    test(
      'retest: widgets/regular_window_controller_mac_o_s_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/widgets/regular_window_controller_mac_o_s_test.dart',
        );
        expectSuccess(result);
      },
    );

    test('retest: widgets/regular_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/regular_window_controller_test.dart',
      );
      expectSuccess(result);
    });

    // 1944 TODO C.168 (2026-06-02): the 60 s `_slowTestTimeout` wrapper was
    // §U25 cold-start padding only — the build runs in ~1.8 s (httpMs=1580,
    // totalMs=1799, frameworkErrors=0, outputLines=1, sourceChars=56775 — 57 KB
    // source exercising the full RegularWindowControllerWin32 widget API).
    // Stripped the `timeout: _slowTestTimeout` argument; defaults (25 s
    // httpBuildTimeout + 30 s dart-test timeout) now apply with ~28 s headroom
    // over the ~1.8 s build. No `waitBeforeClear` buffer and no B.6/B.7
    // requestRecycle() §U28 protection on this script — clean wrapper-only
    // strip. `_slowTestTimeout` const retained — still used by 3 other entries.
    test('retest: widgets/regular_window_controller_win32_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/regular_window_controller_win32_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/regular_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/regular_window_test.dart',
      );
      expectSuccess(result);
    });

    // 1944 TODO C.169 (2026-06-02): the 60 s `_slowTestTimeout` wrapper was
    // §U25 cold-start padding that masked nothing on the build side. The
    // isolated retest builds the 42 KB source in ~1.6 s (httpMs≈1566,
    // totalMs≈1784, frameworkErrors=0, outputLines=0, sourceChars=42352,
    // status=success; app stages appInterpretEndMs=1179, appFirstFrameMs=1355,
    // appPumpEndMs=1555). Stripped the `timeout: _slowTestTimeout` argument;
    // defaults (25 s httpBuildTimeout + 30 s dart-test timeout) now apply with
    // ~28 s headroom over the ~1.8 s build. No `waitBeforeClear` buffer and no
    // B.6/B.7 requestRecycle() §U28 protection on this script — clean
    // wrapper-only strip. `_slowTestTimeout` const retained — still used by
    // 2 other entries.
    test(
      'retest: widgets/render_abstract_layout_builder_mixin_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/widgets/render_abstract_layout_builder_mixin_test.dart',
        );
        expectSuccess(result);
      },
    );

    test(
      'retest: widgets/render_nested_scroll_view_viewport_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'retest/widgets/render_nested_scroll_view_viewport_test.dart',
        );
        expectSuccess(result);
      },
    );

    // 1944 TODO C.170 (2026-06-02): stripped the `timeout: _slowTestTimeout`
    // (60 s) §U25 cold-start wrapper. Pre-fix isolated retest passed in
    // ~1.8 s (httpMs=1573, totalMs=1789, frameworkErrors=0, sourceChars=38539
    // — exercises the full `RenderTapRegionSurface`/`TapRegion` widget API);
    // the 60 s padding masked nothing. TEST-side wrapper-only strip; AST
    // sibling never wrapped this script; no `waitBeforeClear` buffer and no
    // B.6/B.7 requestRecycle() §U28 protection on this script. Defaults now
    // apply (25 s httpBuildTimeout + 30 s dart-test timeout). `_slowTestTimeout`
    // const retained — still used by 1 other entry (request_focus_action C.171).
    test('retest: widgets/render_tap_region_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/render_tap_region_surface_test.dart',
      );
      expectSuccess(result);
    });

    test('retest: widgets/replace_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/replace_text_intent_test.dart',
      );
      expectSuccess(result);
    });

    // 1944 TODO C.171 (2026-06-02): stripped the `timeout: _slowTestTimeout`
    // (60 s) §U25 cold-start wrapper. Pre-fix isolated retest passed in
    // ~1.6 s (httpMs=1403, totalMs=1619, frameworkErrors=0, sourceChars=49789,
    // outputLines=1 — exercises the full `RequestFocusAction`/`RequestFocusIntent`
    // widget API); the 60 s padding masked nothing. TEST-side wrapper-only
    // strip; AST sibling never wrapped this script; no `waitBeforeClear`
    // buffer and no B.6/B.7 requestRecycle() §U28 protection on this script.
    // Defaults now apply (25 s httpBuildTimeout + 30 s dart-test timeout).
    // This was the LAST `_slowTestTimeout` usage in the file, so the now-
    // orphaned const declaration (+ its doc comment) was removed — mirror of
    // the C.160 `_verySlowTestTimeout` single-usage cleanup.
    test('retest: widgets/request_focus_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/request_focus_action_test.dart',
      );
      expectSuccess(result);
    });
  });
}

void expectSuccess(SendResult result) {
  final errors = result.frameworkErrors.isNotEmpty
      ? result.frameworkErrors.join('; ')
      : null;
  final reason = result.error ?? errors;
  expect(result.success && !result.hasFrameworkErrors, isTrue, reason: reason);
}

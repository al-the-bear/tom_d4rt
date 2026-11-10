/// Extended bridge tests (file 25): the classes Flutter 3.47 added.
///
/// One script per class or small class group bridged since the corpus was
/// written against Flutter 3.41 (ghissues15). Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_25_test.dart';

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

  group('Flutter 3.47 classes', () {
    // CupertinoMenuAnchor, CupertinoMenuItem, CupertinoMenuDivider, CupertinoMenuEntry
    test('cupertino/cupertino_menu_anchor_test.dart', () async {
      final result = await SendTestRunner.send(
        'cupertino/cupertino_menu_anchor_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // DisplayCornerRadii
    test('dart_ui/display_corner_radii_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/display_corner_radii_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // HitTestRequest, HitTestResponse
    test('dart_ui/hit_test_request_response_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/hit_test_request_response_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // UniformType, UniformArray, UniformMat2Slot, UniformMat3Slot
    test('dart_ui/uniform_slots_new_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/uniform_slots_new_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // NativeHitTestTarget
    test('gestures/native_hit_test_target_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/native_hit_test_target_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // ShapedInputBorder
    test('material/shaped_input_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/shaped_input_border_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // TabBarScrollController
    test('material/tab_bar_scroll_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_bar_scroll_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // ScrollCacheExtent
    test('rendering/scroll_cache_extent_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/scroll_cache_extent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // TextInputStyle
    test('services/text_input_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_style_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // UiKitViewGestureBlockingPolicy
    test('services/uikit_view_gesture_blocking_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/uikit_view_gesture_blocking_policy_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    // ContextMenuButtonKind
    test('widgets/context_menu_button_kind_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/context_menu_button_kind_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}

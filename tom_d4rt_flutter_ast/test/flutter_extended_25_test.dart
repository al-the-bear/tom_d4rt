/// Extended bridge tests (file 25): the classes Flutter 3.47 added.
///
/// One script per class or small class group bridged on Flutter 3.47.9 and
/// not declared in Flutter 3.41.3, the release the corpus was written against
/// (ghissues15). Each test also checks lines the script prints, so a script
/// that runs but computes the wrong value fails. Own test app.
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
      expect(
        result.output,
        containsAll(<String>[
          'menu entries: 4, dividers: 1',
          'delete isDestructiveAction: true',
          'anchor menuChildren: 4',
          'anchor enableSwipe: true',
          'anchor consumeOutsideTaps: false',
        ]),
      );
    });

    // DisplayCornerRadii
    test('dart_ui/display_corner_radii_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/display_corner_radii_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'phone == phoneAgain: true',
          'hashCodes match: true',
          'phone == tablet: false',
        ]),
      );
    });

    // HitTestRequest, HitTestResponse
    test('dart_ui/hit_test_request_response_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/hit_test_request_response_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'requests on this view: 2',
          'hit hasPlatformView: true',
          'miss hasPlatformView: false',
          'empty hasPlatformView: false',
          'empty is a response: true',
        ]),
      );
    });

    // UniformType, UniformArray, UniformMat2Slot, UniformMat3Slot
    test('dart_ui/uniform_slots_new_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/uniform_slots_new_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'no mat2 slot',
          'no mat3 slot',
          'no uniform array',
          'string is UniformType: false',
          'string is UniformMat2Slot: false',
          'null is UniformArray: false',
          'empty List<UniformType>: 0',
        ]),
      );
    });

    // NativeHitTestTarget
    test('gestures/native_hit_test_target_test.dart', () async {
      final result = await SendTestRunner.send(
        'gestures/native_hit_test_target_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'map view: native=true',
          'flutter box: native=false',
          'web view: native=true',
          'native targets: 2',
        ]),
      );
    });

    // ShapedInputBorder
    test('material/shaped_input_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/shaped_input_border_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'stadium isOutline: true',
          'stadium gapPadding: 4.0',
          'stadium shape: StadiumBorder',
          'beveled gapPadding: 6.0',
          'copyWith width: 3.0',
          'copyWith keeps gapPadding: 6.0',
          'copyWith shape: CircleBorder',
          'is InputBorder: true',
        ]),
      );
    });

    // TabBarScrollController
    test('material/tab_bar_scroll_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/tab_bar_scroll_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'is ScrollController: true',
          'hasClients before attach: false',
          'initialScrollOffset: 0.0',
          'keepScrollOffset: true',
        ]),
      );
    });

    // ScrollCacheExtent
    test('rendering/scroll_cache_extent_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/scroll_cache_extent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'pixels: style=CacheExtentStyle.pixel, value=250.0',
          'viewport: style=CacheExtentStyle.viewport, value=0.5',
          'pixels is ScrollCacheExtent: true',
          'styles differ: true',
        ]),
      );
    });

    // TextInputStyle
    test('services/text_input_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_style_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'minimal fontSize: null',
          'full fontFamily: Roboto',
          'full == fullAgain: true',
          'hashCodes match: true',
          'minimal == full: false',
        ]),
      );
    });

    // UiKitViewGestureBlockingPolicy
    test('services/uikit_view_gesture_blocking_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/uikit_view_gesture_blocking_policy_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'values: 4',
          '  0 eager: blocks as soon as a touch begins',
          '  2 doNotBlockGesture: never blocks',
          'UiKitView demo/waitUntilTouchesEnded -> waitUntilTouchesEnded',
        ]),
      );
    });

    // ContextMenuButtonKind
    test('widgets/context_menu_button_kind_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/context_menu_button_kind_test.dart',
      );
      SendTestRunner.expectSuccess(result);
      expect(
        result.output,
        containsAll(<String>[
          'values: 11',
          'cut == cut: true',
          'cut == copy: false',
          'values contains paste: true',
          'custom: custom',
        ]),
      );
    });
  });
}

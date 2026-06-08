/// Auto-split extended bridge tests (file 22).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'dart:io' show Platform;

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

  group('Section 2 - Bridge Generator Issues (80)', () {
    // 29. widgets/slidetransition_test.dart (idx 267)
    test('widgets/slidetransition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slidetransition_test.dart',
      );
      expectSuccess(result);
    });

    // 30. widgets/nestedscrollview_test.dart (idx 269)
    test('widgets/nestedscrollview_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/nestedscrollview_test.dart',
      );
      expectSuccess(result);
    });

    // 31. animation/tweensequence_test.dart (idx 278)
    test('animation/tweensequence_test.dart', () async {
      final result = await SendTestRunner.send(
        'animation/tweensequence_test.dart',
      );
      expectSuccess(result);
    });

    // 32. services/codecs_test.dart (idx 279)
    test('services/codecs_test.dart', () async {
      final result = await SendTestRunner.send('services/codecs_test.dart');
      expectSuccess(result);
    });

    // 33. services/channels_test.dart (idx 280)
    test('services/channels_test.dart', () async {
      final result = await SendTestRunner.send('services/channels_test.dart');
      expectSuccess(result);
    });

    // 34. semantics/semantics_config_test.dart (idx 290)
    test('semantics/semantics_config_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_config_test.dart',
      );
      expectSuccess(result);
    });

    // 35. widgets/layout_builder_adv_test.dart (idx 292)
    test('widgets/layout_builder_adv_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/layout_builder_adv_test.dart',
      );
      expectSuccess(result);
    });

    // 36. material/scaffold_messenger_test.dart (idx 303)
    test('material/scaffold_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'material/scaffold_messenger_test.dart',
      );
      expectSuccess(result);
    });

    // 37. rendering/box_hit_test_result_test.dart (idx 309)
    test('rendering/box_hit_test_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/box_hit_test_result_test.dart',
      );
      expectSuccess(result);
    });

    // 38. rendering/custom_painter_semantics_test.dart (idx 310)
    test('rendering/custom_painter_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/custom_painter_semantics_test.dart',
      );
      expectSuccess(result);
    });

    // 39. rendering/relayout_when_system_fonts_change_mixin_test.dart (idx 312)
    test(
      'rendering/relayout_when_system_fonts_change_mixin_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'rendering/relayout_when_system_fonts_change_mixin_test.dart',
        );
        expectSuccess(result);
      },
    );

    // 40. rendering/render_absorb_pointer_test.dart (idx 313)
    test('rendering/render_absorb_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_absorb_pointer_test.dart',
      );
      expectSuccess(result);
    });

    // 41. rendering/render_aligning_shifted_box_test.dart (idx 314)
    test('rendering/render_aligning_shifted_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_aligning_shifted_box_test.dart',
      );
      expectSuccess(result);
    });

    // 47. rendering/render_shrink_wrapping_viewport_test.dart (idx 325)
    test('rendering/render_shrink_wrapping_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_shrink_wrapping_viewport_test.dart',
      );
      expectSuccess(result);
    });

    // 48. widgets/android_view_test.dart (idx 329)
    test(
      'widgets/android_view_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/android_view_test.dart',
        );
        expectSuccess(result);
      },
      skip: !Platform.isAndroid ? 'AndroidView only renders on Android' : null,
    );

    // 49. widgets/animated_cross_fade_test.dart (idx 330)
    test('widgets/animated_cross_fade_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_cross_fade_test.dart',
      );
      expectSuccess(result);
    });

    // 51. widgets/autofill_group_test.dart (idx 333)
    test('widgets/autofill_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/autofill_group_test.dart',
      );
      expectSuccess(result);
    });

    // 52. widgets/backdrop_filter_test.dart (idx 334)
    test('widgets/backdrop_filter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/backdrop_filter_test.dart',
      );
      expectSuccess(result);
    });

    // 53. widgets/composited_transform_follower_test.dart (idx 336)
    test('widgets/composited_transform_follower_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/composited_transform_follower_test.dart',
      );
      expectSuccess(result);
    });

    // 54. widgets/fixed_extent_metrics_test.dart (idx 340)
    test('widgets/fixed_extent_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/fixed_extent_metrics_test.dart',
      );
      expectSuccess(result);
    });

    // 55. widgets/glowing_overscroll_indicator_test.dart (idx 341)
    test('widgets/glowing_overscroll_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/glowing_overscroll_indicator_test.dart',
      );
      expectSuccess(result);
    });

    // 56. widgets/html_element_view_test.dart (idx 342)
    // 1944 TODO C.131 (2026-06-01): historical 20260528-2206 TODO #4
    // follow-up `_slowTestTimeout` REMOVED. Last AST entry in §C.ix
    // — also the last `_slowTestTimeout` usage in this file, so the
    // const declaration is removed too. Script runs in ~3.3 s under
    // isolated retest (httpMs=2850, totalMs=3304, frameworkErrors=0,
    // sourceBytes=59882, sourceChars=59882, bundleJsonBytes=788267
    // — 60 KB / 788 KB bundle). First pre-fix retest hit U31;
    // retry #1 PASSED clean — standard U31 retry protocol. Defaults
    // apply. Closes AST half of §C.ix.
    test('widgets/html_element_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/html_element_view_test.dart',
      );
      expectSuccess(result);
    });

    // 57. widgets/image_filtered_test.dart (idx 343)
    test('widgets/image_filtered_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/image_filtered_test.dart',
      );
      expectSuccess(result);
    });

    // 58. widgets/indexed_stack_test.dart (idx 344)
    test('widgets/indexed_stack_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/indexed_stack_test.dart',
      );
      expectSuccess(result);
    });

    // 59. widgets/inherited_theme_test.dart (idx 346)
    test('widgets/inherited_theme_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_theme_test.dart',
      );
      expectSuccess(result);
    });

    // 60. widgets/inherited_widget_test.dart (idx 347)
    test('widgets/inherited_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/inherited_widget_test.dart',
      );
      expectSuccess(result);
    });

    // 61. widgets/list_wheel_scroll_view_test.dart (idx 348)
    test('widgets/list_wheel_scroll_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_scroll_view_test.dart',
      );
      expectSuccess(result);
    });

    // 62. widgets/list_wheel_viewport_test.dart (idx 349)
    test('widgets/list_wheel_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/list_wheel_viewport_test.dart',
      );
      expectSuccess(result);
    });

    // 63. widgets/magnifier_decoration_test.dart (idx 350)
    test('widgets/magnifier_decoration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/magnifier_decoration_test.dart',
      );
      expectSuccess(result);
    });

    // 64. widgets/navigation_toolbar_test.dart (idx 351)
    test('widgets/navigation_toolbar_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigation_toolbar_test.dart',
      );
      expectSuccess(result);
    });

    // 65. widgets/overflow_bar_test.dart (idx 352)
    test('widgets/overflow_bar_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overflow_bar_test.dart',
      );
      expectSuccess(result);
    });

    // 66. widgets/overflow_box_test.dart (idx 353)
    test('widgets/overflow_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overflow_box_test.dart',
      );
      expectSuccess(result);
    });

    // 67. widgets/page_storage_bucket_test.dart (idx 354)
    test('widgets/page_storage_bucket_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_storage_bucket_test.dart',
      );
      expectSuccess(result);
    });

    // 68. widgets/page_storage_test.dart (idx 355)
    test('widgets/page_storage_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_storage_test.dart',
      );
      expectSuccess(result);
    });

    // 69. widgets/parent_data_widget_test.dart (idx 356)
    test('widgets/parent_data_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/parent_data_widget_test.dart',
      );
      expectSuccess(result);
    });

    // 70. widgets/physical_model_test.dart (idx 358)
    test('widgets/physical_model_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/physical_model_test.dart',
      );
      expectSuccess(result);
    });

    // 71. widgets/render_object_element_test.dart (idx 359)
    test('widgets/render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_element_test.dart',
      );
      expectSuccess(result);
    });

    // 72. widgets/render_object_widget_test.dart (idx 360)
    test('widgets/render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_widget_test.dart',
      );
      expectSuccess(result);
    });

    // 73. widgets/restorable_enum_test.dart (idx 364)
    test('widgets/restorable_enum_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_enum_test.dart',
      );
      expectSuccess(result);
    });

    // 74. widgets/restorable_text_editing_controller_test.dart (idx 368)
    test('widgets/restorable_text_editing_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_text_editing_controller_test.dart',
      );
      expectSuccess(result);
    });

    // 75. widgets/root_widget_test.dart (idx 372)
    test('widgets/root_widget_test.dart', () async {
      final result = await SendTestRunner.send('widgets/root_widget_test.dart');
      expectSuccess(result);
    });

    // 79. widgets/stateful_element_test.dart (idx 380)
    test('widgets/stateful_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stateful_element_test.dart',
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

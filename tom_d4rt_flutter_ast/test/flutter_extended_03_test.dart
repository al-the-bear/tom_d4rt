/// Auto-split extended bridge tests (file 03).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
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
  // DART:UI PACKAGE (76 files)
  // ============================================================
  group('dart_ui/', () {
    test('text_affinity_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/text_affinity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_align_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/text_align_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_baseline_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/text_baseline_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_decoration_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/text_decoration_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/text_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_leading_distribution_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/text_leading_distribution_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tile_mode_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/tile_mode_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('transform_engine_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/transform_engine_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tristate_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/tristate_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('uniform_float_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/uniform_float_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('uniform_vec2_slot_test.dart', () async {
      // 1944 TODO C.50 (2026-05-31): historical 20260523-1056 §1.4/E13
      // cold-start-contention wrapper REMOVED. Script runs in ~1.7 s
      // under normal load (httpMs=1657, bundleJsonBytes=848674 —
      // 849 KB bundle / 68 KB / 2156-line script).
      final result = await SendTestRunner.send(
        'dart_ui/uniform_vec2_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('uniform_vec3_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/uniform_vec3_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('uniform_vec4_slot_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/uniform_vec4_slot_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('vertex_mode_test.dart', () async {
      final result = await SendTestRunner.send('dart_ui/vertex_mode_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('view_focus_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/view_focus_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('view_focus_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'dart_ui/view_focus_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // FOUNDATION PACKAGE (37 files)
  // ============================================================
  group('foundation/', () {
    test('abstract_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/abstract_node_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('caching_iterable_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/caching_iterable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('category_test.dart', () async {
      final result = await SendTestRunner.send('foundation/category_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('foundation/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostic_level_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostic_level_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnosticable_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnosticable_node_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnosticable_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnosticable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnosticable_tree_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnosticable_tree_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnosticable_tree_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnosticable_tree_node_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnosticable_tree_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnosticable_tree_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostics_block_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_block_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostics_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostics_serialization_delegate_test.dart', () async {
      // 1944 TODO C.51 (2026-05-31): historical 20260523-1056 §1.4/E14
      // cold-start-contention wrapper REMOVED. Script runs in ~2.0 s
      // under normal load (httpMs=2023, bundleJsonBytes=836826 —
      // 837 KB bundle / 70 KB / 2260-line script).
      final result = await SendTestRunner.send(
        'foundation/diagnostics_serialization_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostics_stack_trace_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_stack_trace_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostics_tree_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/diagnostics_tree_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('documentation_icon_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/documentation_icon_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('double_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/double_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('enum_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/enum_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('error_spacer_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/error_spacer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('factory_test.dart', () async {
      final result = await SendTestRunner.send('foundation/factory_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('flag_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/flag_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flags_summary_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/flags_summary_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flutter_memory_allocations_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/flutter_memory_allocations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('foundation_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/foundation_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('int_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/int_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('iterable_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/iterable_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('message_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/message_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('object_created_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/object_created_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('object_disposed_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/object_disposed_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('object_event_test.dart', () async {
      // 1944 TODO C.52 (2026-05-31): historical 20260523-1056 §1.4/E15
      // cold-start-contention wrapper REMOVED. Script runs in ~1.8 s
      // under normal load (httpMs=1797, bundleJsonBytes=853919 —
      // 854 KB bundle / 72 KB / 2326-line script).
      final result = await SendTestRunner.send(
        'foundation/object_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('object_flag_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/object_flag_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('percent_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/percent_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('string_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/string_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('summary_test.dart', () async {
      final result = await SendTestRunner.send('foundation/summary_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('target_platform_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/target_platform_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_tree_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/text_tree_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_tree_renderer_test.dart', () async {
      final result = await SendTestRunner.send(
        'foundation/text_tree_renderer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}

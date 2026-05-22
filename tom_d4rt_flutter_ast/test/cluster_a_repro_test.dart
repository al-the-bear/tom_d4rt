/// Cluster A verification — confirm all 24 scripts previously failing with
/// `Undefined variable: build` now load and execute via SendTestRunner.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const List<String> _clusterAScripts = <String>[
  'animation/tween_test.dart',
  'cupertino/scaffold_test.dart',
  'cupertino/theme_test.dart',
  'gestures/details_test.dart',
  'painting/gradient_shadow_test.dart',
  'painting/textstyle_test.dart',
  'dart_ui/accessibility_features_test.dart',
  'material/checkbox_list_tile_test.dart',
  'rendering/render_exclude_semantics_test.dart',
  'dart_ui/app_lifecycle_state_test.dart',
  'dart_ui/backdrop_filter_engine_layer_test.dart',
  'dart_ui/blend_mode_test.dart',
  'dart_ui/blur_style_test.dart',
  'dart_ui/box_width_style_test.dart',
  'dart_ui/channel_buffers_test.dart',
  'dart_ui/class_test.dart',
  'gestures/class_test.dart',
  'gestures/i_o_s_scroll_view_fling_velocity_tracker_test.dart',
  'material/drawer_button_test.dart',
  'material/dynamic_scheme_variant_test.dart',
  'material/material_tap_target_size_test.dart',
  'retest/material/button_bar_layout_behavior_test.dart',
  'retest/material/button_text_theme_test.dart',
  'retest/material/dropdown_menu_close_behavior_test.dart',
  'retest/material/material_banner_closed_reason_test.dart',
  'retest/material/navigation_destination_label_behavior_test.dart',
];

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp();
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  for (final script in _clusterAScripts) {
    test('[Cluster A] $script', () async {
      final result = await SendTestRunner.send(script);
      print('STATUS: ${result.success}  FE: ${result.frameworkErrors.length}');
      if (!result.success) {
        print('ERROR: ${result.error}');
      }
      expect(result.success, isTrue,
          reason: '$script still failed: ${result.error}');
    });
  }
}

// D4rt test script: Tests PerformanceOverlayLayer from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PerformanceOverlayLayer test executing');

  // ========== Basic PerformanceOverlayLayer creation ==========
  print('--- Basic PerformanceOverlayLayer ---');
  final layer1 = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 0,
  );
  print('  created: ${layer1.runtimeType}');
  print('  overlayRect: ${layer1.overlayRect}');
  print('  optionsMask: ${layer1.optionsMask}');

  // ========== Different overlayRect values ==========
  print('--- Different overlayRect values ---');
  final layer2 = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(10.0, 20.0, 200.0, 80.0),
    optionsMask: 0,
  );
  print('  rect (10, 20, 200, 80): ${layer2.overlayRect}');

  final layer3 = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 400.0, 150.0),
    optionsMask: 0,
  );
  print('  rect (0, 0, 400, 150): ${layer3.overlayRect}');

  final layer4 = PerformanceOverlayLayer(
    overlayRect: Rect.fromCenter(
      center: Offset(150.0, 50.0),
      width: 300.0,
      height: 100.0,
    ),
    optionsMask: 0,
  );
  print('  centered rect: ${layer4.overlayRect}');

  // ========== PerformanceOverlayOption masks ==========
  print('--- PerformanceOverlayOption ---');
  print(
    '  displayRasterizerStatistics: ${PerformanceOverlayOption.displayRasterizerStatistics.index}',
  );
  print(
    '  visualizeRasterizerStatistics: ${PerformanceOverlayOption.visualizeRasterizerStatistics.index}',
  );
  print(
    '  displayEngineStatistics: ${PerformanceOverlayOption.displayEngineStatistics.index}',
  );
  print(
    '  visualizeEngineStatistics: ${PerformanceOverlayOption.visualizeEngineStatistics.index}',
  );

  // ========== Creating with different option masks ==========
  print('--- Different option masks ---');
  final layerRaster = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask:
        1 << PerformanceOverlayOption.displayRasterizerStatistics.index,
  );
  print('  displayRasterizerStatistics mask: ${layerRaster.optionsMask}');

  final layerEngine = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 1 << PerformanceOverlayOption.displayEngineStatistics.index,
  );
  print('  displayEngineStatistics mask: ${layerEngine.optionsMask}');

  // Combined mask
  final combinedMask =
      (1 << PerformanceOverlayOption.displayRasterizerStatistics.index) |
      (1 << PerformanceOverlayOption.visualizeRasterizerStatistics.index);
  final layerCombined = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: combinedMask,
  );
  print(
    '  combined mask (raster display + visualize): ${layerCombined.optionsMask}',
  );

  // ========== rasterizerThreshold property ==========
  print('--- rasterizerThreshold property ---');
  final layerWithThreshold = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 0,
    rasterizerThreshold: 16,
  );
  print(
    '  rasterizerThreshold = 16: ${layerWithThreshold.rasterizerThreshold}',
  );

  final layerThreshold0 = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 0,
    rasterizerThreshold: 0,
  );
  print('  rasterizerThreshold = 0: ${layerThreshold0.rasterizerThreshold}');

  // ========== checkerboardRasterCacheImages property ==========
  print('--- checkerboardRasterCacheImages ---');
  final layerCheckerboard = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 0,
    checkerboardRasterCacheImages: true,
  );
  print(
    '  checkerboardRasterCacheImages = true: ${layerCheckerboard.checkerboardRasterCacheImages}',
  );

  final layerNoCheckerboard = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 0,
    checkerboardRasterCacheImages: false,
  );
  print(
    '  checkerboardRasterCacheImages = false: ${layerNoCheckerboard.checkerboardRasterCacheImages}',
  );

  // ========== checkerboardOffscreenLayers property ==========
  print('--- checkerboardOffscreenLayers ---');
  final layerOffscreen = PerformanceOverlayLayer(
    overlayRect: Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
    optionsMask: 0,
    checkerboardOffscreenLayers: true,
  );
  print(
    '  checkerboardOffscreenLayers = true: ${layerOffscreen.checkerboardOffscreenLayers}',
  );

  // ========== Layer inheritance ==========
  print('--- Layer inheritance ---');
  print('  is Layer: ${layer1 is Layer}');
  print('  is ContainerLayer: ${layer1 is ContainerLayer}');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  layer1.runtimeType: ${layer1.runtimeType}');
  print('  layerCheckerboard.runtimeType: ${layerCheckerboard.runtimeType}');

  print('PerformanceOverlayLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'PerformanceOverlayLayer Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Type: ${layer1.runtimeType}'),
          Text('overlayRect: ${layer1.overlayRect}'),
          Text('optionsMask: ${layer1.optionsMask}'),
          SizedBox(height: 8.0),
          Text('PerformanceOverlayOption values:'),
          Text(
            '  displayRasterizerStatistics: ${PerformanceOverlayOption.displayRasterizerStatistics.index}',
          ),
          Text(
            '  visualizeRasterizerStatistics: ${PerformanceOverlayOption.visualizeRasterizerStatistics.index}',
          ),
          Text(
            '  displayEngineStatistics: ${PerformanceOverlayOption.displayEngineStatistics.index}',
          ),
          Text(
            '  visualizeEngineStatistics: ${PerformanceOverlayOption.visualizeEngineStatistics.index}',
          ),
          SizedBox(height: 8.0),
          Text('Configuration options:'),
          Text(
            '  rasterizerThreshold: ${layerWithThreshold.rasterizerThreshold}',
          ),
          Text(
            '  checkerboardRasterCacheImages: ${layerCheckerboard.checkerboardRasterCacheImages}',
          ),
          Text(
            '  checkerboardOffscreenLayers: ${layerOffscreen.checkerboardOffscreenLayers}',
          ),
        ],
      ),
    ),
  );
}

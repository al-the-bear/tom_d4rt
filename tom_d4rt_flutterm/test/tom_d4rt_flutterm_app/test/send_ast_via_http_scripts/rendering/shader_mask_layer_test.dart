// D4rt test script: Tests ShaderMaskLayer from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShaderMaskLayer test executing');
  final results = <String>[];

  // ========== Section 1: Basic ShaderMaskLayer Creation ==========
  print('--- Section 1: Basic ShaderMaskLayer Creation ---');

  // Create a simple gradient shader
  final gradient = LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  final shader = gradient.createShader(Rect.fromLTWH(0, 0, 100, 100));

  final layer = ShaderMaskLayer();
  print('Created ShaderMaskLayer: ${layer.runtimeType}');
  results.add('ShaderMaskLayer created');

  // ========== Section 2: Setting Shader ==========
  print('--- Section 2: Setting Shader ---');

  layer.shader = shader;
  print('Shader set: ${layer.shader != null}');
  print('Shader type: ${layer.shader?.runtimeType}');
  results.add('Shader set: ${layer.shader != null}');

  // ========== Section 3: Setting MaskRect ==========
  print('--- Section 3: Setting MaskRect ---');

  final maskRect = Rect.fromLTWH(0, 0, 200, 150);
  layer.maskRect = maskRect;
  print('MaskRect set: ${layer.maskRect}');
  results.add('MaskRect: ${layer.maskRect}');

  // ========== Section 4: BlendMode ==========
  print('--- Section 4: BlendMode ---');

  layer.blendMode = BlendMode.srcIn;
  print('BlendMode set: ${layer.blendMode}');

  // Try different blend modes
  final blendModes = [
    BlendMode.srcOver,
    BlendMode.srcIn,
    BlendMode.srcOut,
    BlendMode.dstIn,
    BlendMode.dstOut,
    BlendMode.multiply,
    BlendMode.screen,
  ];

  print('Testing different blend modes:');
  for (final mode in blendModes) {
    layer.blendMode = mode;
    print('  ${mode.name}: set successfully');
  }
  results.add('BlendModes tested: ${blendModes.length}');

  // ========== Section 5: Layer Hierarchy ==========
  print('--- Section 5: Layer Hierarchy ---');

  print('ShaderMaskLayer parent: ${layer.parent}');
  print('ShaderMaskLayer is ContainerLayer: ${layer is ContainerLayer}');

  // ShaderMaskLayer extends ContainerLayer
  final containerCheck = layer as ContainerLayer;
  print('First child: ${containerCheck.firstChild}');
  print('Last child: ${containerCheck.lastChild}');
  results.add('Layer hierarchy verified');

  // ========== Section 6: New Layer with Different Gradients ==========
  print('--- Section 6: Different Gradients ---');

  // Radial gradient
  final radialGradient = RadialGradient(
    colors: [Color(0xFFFFFF00), Color(0xFF00FF00)],
    center: Alignment.center,
    radius: 0.5,
  );
  final radialShader = radialGradient.createShader(
    Rect.fromLTWH(0, 0, 100, 100),
  );

  final radialLayer = ShaderMaskLayer()
    ..shader = radialShader
    ..maskRect = Rect.fromLTWH(0, 0, 100, 100)
    ..blendMode = BlendMode.modulate;

  print('Radial gradient layer created');
  print('Radial shader: ${radialLayer.shader != null}');
  results.add('Radial gradient layer created');

  // Sweep gradient
  final sweepGradient = SweepGradient(
    colors: [Color(0xFFFF0000), Color(0xFF00FF00), Color(0xFF0000FF)],
    startAngle: 0.0,
    endAngle: 3.14159 * 2,
  );
  final sweepShader = sweepGradient.createShader(Rect.fromLTWH(0, 0, 100, 100));

  final sweepLayer = ShaderMaskLayer()
    ..shader = sweepShader
    ..maskRect = Rect.fromLTWH(50, 50, 150, 150)
    ..blendMode = BlendMode.overlay;

  print('Sweep gradient layer created');
  results.add('Sweep gradient layer created');

  // ========== Section 7: Append and Remove Children ==========
  print('--- Section 7: Append Children ---');

  final parentLayer = ShaderMaskLayer();
  final childLayer = OffsetLayer(offset: Offset(10, 20));

  parentLayer.append(childLayer);
  print('Child appended: ${parentLayer.firstChild != null}');
  print('First child type: ${parentLayer.firstChild?.runtimeType}');
  results.add('Child layer appended');

  // ========== Section 8: Multiple Mask Rects ==========
  print('--- Section 8: Multiple Mask Rects ---');

  final rects = [
    Rect.fromLTWH(0, 0, 50, 50),
    Rect.fromLTWH(100, 100, 200, 200),
    Rect.fromLTWH(-50, -50, 100, 100),
    Rect.zero,
  ];

  for (final rect in rects) {
    final testLayer = ShaderMaskLayer()..maskRect = rect;
    print('MaskRect $rect: ${testLayer.maskRect}');
  }
  results.add('Tested ${rects.length} mask rects');

  // ========== Section 9: EngineLayer ==========
  print('--- Section 9: EngineLayer Reference ---');

  print('Layer engineLayer: ${layer.engineLayer}');
  results.add('EngineLayer accessible');

  // ========== Section 10: ToString ==========
  print('--- Section 10: ToString ---');

  print('layer.toString(): ${layer.toString()}');
  results.add('ToString available');

  print('ShaderMaskLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ShaderMaskLayer Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...results.map(
            (r) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('✓ $r', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    ),
  );
}

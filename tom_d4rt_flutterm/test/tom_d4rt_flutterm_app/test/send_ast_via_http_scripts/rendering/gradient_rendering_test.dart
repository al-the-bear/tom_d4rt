// D4rt test script: Tests LinearGradient, RadialGradient, SweepGradient in rendering context with createShader
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('Gradient rendering test executing');

  // ========== LINEAR GRADIENT ==========
  print('--- LinearGradient Tests ---');

  final linearGrad = LinearGradient(colors: [Colors.red, Colors.blue]);
  print('LinearGradient created: ${linearGrad.runtimeType}');
  print('  begin: ${linearGrad.begin}');
  print('  end: ${linearGrad.end}');
  print('  colors: ${linearGrad.colors}');
  print('  tileMode: ${linearGrad.tileMode}');

  final linearGradCustom = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.red, Colors.yellow, Colors.green],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );
  print('LinearGradient(custom):');
  print('  begin: ${linearGradCustom.begin}');
  print('  end: ${linearGradCustom.end}');
  print('  colors count: ${linearGradCustom.colors.length}');
  print('  stops: ${linearGradCustom.stops}');
  print('  tileMode: ${linearGradCustom.tileMode}');

  // Create shader from gradient (rendering-specific usage)
  final linearShaderRect = Rect.fromLTWH(0, 0, 200, 200);
  final linearShader = linearGrad.createShader(linearShaderRect);
  print('LinearGradient.createShader: ${linearShader.runtimeType}');

  final linearShaderCustom = linearGradCustom.createShader(
    Rect.fromLTWH(0, 0, 100, 300),
  );
  print(
    'LinearGradient(custom).createShader: ${linearShaderCustom.runtimeType}',
  );

  // ========== RADIAL GRADIENT ==========
  print('--- RadialGradient Tests ---');

  final radialGrad = RadialGradient(colors: [Colors.white, Colors.black]);
  print('RadialGradient created: ${radialGrad.runtimeType}');
  print('  center: ${radialGrad.center}');
  print('  radius: ${radialGrad.radius}');
  print('  colors: ${radialGrad.colors}');
  print('  tileMode: ${radialGrad.tileMode}');

  final radialGradCustom = RadialGradient(
    center: Alignment.center,
    radius: 0.8,
    colors: [Colors.orange, Colors.purple, Colors.transparent],
    stops: [0.0, 0.7, 1.0],
    tileMode: TileMode.mirror,
  );
  print('RadialGradient(custom):');
  print('  center: ${radialGradCustom.center}');
  print('  radius: ${radialGradCustom.radius}');
  print('  colors count: ${radialGradCustom.colors.length}');
  print('  stops: ${radialGradCustom.stops}');
  print('  tileMode: ${radialGradCustom.tileMode}');

  final radialGradFocal = RadialGradient(
    center: Alignment.center,
    radius: 0.5,
    colors: [Colors.blue, Colors.green],
    focal: Alignment(-0.1, 0.6),
    focalRadius: 0.1,
  );
  print('RadialGradient(focal):');
  print('  focal: ${radialGradFocal.focal}');
  print('  focalRadius: ${radialGradFocal.focalRadius}');

  // Create shader from radial gradient
  final radialShader = radialGrad.createShader(Rect.fromLTWH(0, 0, 200, 200));
  print('RadialGradient.createShader: ${radialShader.runtimeType}');

  // ========== SWEEP GRADIENT ==========
  print('--- SweepGradient Tests ---');

  final sweepGrad = SweepGradient(
    colors: [Colors.red, Colors.green, Colors.blue, Colors.red],
  );
  print('SweepGradient created: ${sweepGrad.runtimeType}');
  print('  center: ${sweepGrad.center}');
  print('  startAngle: ${sweepGrad.startAngle}');
  print('  endAngle: ${sweepGrad.endAngle}');
  print('  colors count: ${sweepGrad.colors.length}');
  print('  tileMode: ${sweepGrad.tileMode}');

  final sweepGradCustom = SweepGradient(
    center: Alignment(0.0, 0.0),
    startAngle: 0.0,
    endAngle: 3.14159 * 2,
    colors: [Colors.cyan, Colors.pink, Colors.yellow, Colors.cyan],
    stops: [0.0, 0.33, 0.67, 1.0],
    tileMode: TileMode.clamp,
  );
  print('SweepGradient(custom):');
  print('  startAngle: ${sweepGradCustom.startAngle}');
  print('  endAngle: ${sweepGradCustom.endAngle}');
  print('  stops: ${sweepGradCustom.stops}');

  // Create shader from sweep gradient
  final sweepShader = sweepGrad.createShader(Rect.fromLTWH(0, 0, 200, 200));
  print('SweepGradient.createShader: ${sweepShader.runtimeType}');

  // ========== TILE MODE ENUM ==========
  print('--- TileMode values ---');
  print('TileMode.clamp: ${TileMode.clamp}');
  print('TileMode.repeated: ${TileMode.repeated}');
  print('TileMode.mirror: ${TileMode.mirror}');
  print('TileMode.decal: ${TileMode.decal}');

  // ========== GRADIENT IN PAINT ==========
  print('--- Gradient with Paint ---');

  final paint = Paint();
  paint.shader = linearGrad.createShader(Rect.fromLTWH(0, 0, 100, 100));
  print('Paint with gradient shader: ${paint.shader.runtimeType}');

  // ========== GRADIENT IN DECORATION ==========
  print('--- Gradient in BoxDecoration ---');

  final decoration = BoxDecoration(
    gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
  );
  print('BoxDecoration with gradient: ${decoration.runtimeType}');
  print('  gradient: ${decoration.gradient.runtimeType}');

  final radialDecoration = BoxDecoration(
    gradient: RadialGradient(colors: [Colors.white, Colors.grey], radius: 1.0),
  );
  print(
    'BoxDecoration with radial gradient: ${radialDecoration.gradient.runtimeType}',
  );

  final sweepDecoration = BoxDecoration(
    gradient: SweepGradient(colors: [Colors.red, Colors.blue, Colors.red]),
  );
  print(
    'BoxDecoration with sweep gradient: ${sweepDecoration.gradient.runtimeType}',
  );

  // ========== GRADIENT SCALE ==========
  print('--- Gradient scale ---');

  final scaledLinear = linearGrad.scale(0.5);
  print('LinearGradient.scale(0.5): ${scaledLinear.runtimeType}');

  final scaledRadial = radialGrad.scale(0.5);
  print('RadialGradient.scale(0.5): ${scaledRadial.runtimeType}');

  // ========== GRADIENT LERP ==========
  // Note: Gradient.lerp and LinearGradient.lerp are not bridged yet
  // (static methods on abstract Gradient class). Skip for now.

  print('Gradient rendering test completed');
  return Container(child: Text('Gradient rendering test passed'));
}

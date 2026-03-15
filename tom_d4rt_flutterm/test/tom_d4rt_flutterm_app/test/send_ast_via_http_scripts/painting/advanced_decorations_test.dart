// D4rt test script: Tests advanced painting — ImageFilter, ColorFilter,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// MaskFilter, Gradient advanced (sweep, radial stops), ShaderMask concept,
// TextHeightBehavior, StrutStyle
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('Advanced painting test executing');

  // ========== ImageFilter ==========
  print('--- ImageFilter Tests ---');
  final blur = ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  print('ImageFilter.blur: sigmaX=5, sigmaY=5');

  final matrix = ui.ImageFilter.matrix(
    Matrix4.identity().storage,
    filterQuality: FilterQuality.high,
  );
  print('ImageFilter.matrix: identity');

  final compose = ui.ImageFilter.compose(
    outer: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
    inner: ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
  );
  print('ImageFilter.compose: outer+inner blur');

  // ========== ColorFilter ==========
  print('--- ColorFilter Tests ---');
  final modeFilter = ColorFilter.mode(Colors.red, BlendMode.srcATop);
  print('ColorFilter.mode: red srcATop');

  final matrixFilter = ColorFilter.matrix(<double>[
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
  print('ColorFilter.matrix: identity');

  final saturationFilter = ColorFilter.linearToSrgbGamma();
  print('ColorFilter.linearToSrgbGamma created');

  final invGamma = ColorFilter.srgbToLinearGamma();
  print('ColorFilter.srgbToLinearGamma created');

  // ========== SweepGradient ==========
  print('--- SweepGradient Tests ---');
  final sweep = SweepGradient(
    center: Alignment.center,
    startAngle: 0.0,
    endAngle: 3.14159 * 2,
    colors: [Colors.red, Colors.green, Colors.blue, Colors.red],
    stops: [0.0, 0.33, 0.67, 1.0],
    tileMode: TileMode.clamp,
  );
  print('SweepGradient: 4 colors, full circle');

  // ========== RadialGradient advanced ==========
  print('--- RadialGradient advanced Tests ---');
  final radial = RadialGradient(
    center: Alignment.center,
    radius: 0.5,
    colors: [Colors.white, Colors.blue.shade200, Colors.blue.shade800],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.mirror,
    focal: Alignment(0.1, 0.1),
    focalRadius: 0.05,
  );
  print('RadialGradient: focal point, mirror mode');

  // ========== TextHeightBehavior ==========
  print('--- TextHeightBehavior Tests ---');
  final thb = TextHeightBehavior(
    applyHeightToFirstAscent: true,
    applyHeightToLastDescent: false,
    leadingDistribution: TextLeadingDistribution.proportional,
  );
  print('TextHeightBehavior: applyFirst=true, applyLast=false');
  print('  leadingDistribution: ${thb.leadingDistribution}');

  // ========== TextLeadingDistribution ==========
  print('--- TextLeadingDistribution Tests ---');
  for (final dist in TextLeadingDistribution.values) {
    print('TextLeadingDistribution: ${dist.name}');
  }

  // ========== StrutStyle ==========
  print('--- StrutStyle Tests ---');
  final strut = StrutStyle(
    fontFamily: 'Roboto',
    fontFamilyFallback: ['Arial', 'sans-serif'],
    fontSize: 16.0,
    height: 1.5,
    leading: 0.5,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    forceStrutHeight: false,
    leadingDistribution: TextLeadingDistribution.even,
  );
  print('StrutStyle: fontFamily=Roboto, fontSize=16, height=1.5');
  print('  forceStrutHeight: false');

  // ========== InlineSpan concepts ==========
  print('--- InlineSpan Tests ---');
  final textSpan = TextSpan(
    text: 'Hello ',
    style: TextStyle(color: Colors.black),
    children: [
      TextSpan(
        text: 'World',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Icon(Icons.star, size: 16),
      ),
    ],
  );
  print('TextSpan with children: text + WidgetSpan');

  // ========== PlaceholderAlignment ==========
  print('--- PlaceholderAlignment Tests ---');
  for (final pa in PlaceholderAlignment.values) {
    print('PlaceholderAlignment: ${pa.name}');
  }

  print('All advanced painting tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Advanced Painting Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(gradient: sweep),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: radial,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 16.0),
            Text.rich(textSpan, strutStyle: strut, textHeightBehavior: thb),
          ],
        ),
      ),
    ),
  );
}

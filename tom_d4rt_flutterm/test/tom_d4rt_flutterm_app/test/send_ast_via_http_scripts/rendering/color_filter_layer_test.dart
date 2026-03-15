// D4rt test script: Tests ColorFilterLayer from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ColorFilterLayer test executing');

  // ========== ColorFilterLayer Basic Creation ==========
  print('--- ColorFilterLayer Basic Creation ---');
  final colorFilter = ColorFilter.mode(Color(0xFF2196F3), BlendMode.srcIn);
  final filterLayer = ColorFilterLayer(colorFilter: colorFilter);
  print('  created: ${filterLayer.runtimeType}');
  print('  colorFilter: ${filterLayer.colorFilter}');

  // ========== ColorFilter.mode with Different BlendModes ==========
  print('--- ColorFilter.mode with Different BlendModes ---');
  final srcOverFilter = ColorFilter.mode(Color(0xFFFF5722), BlendMode.srcOver);
  final srcOverLayer = ColorFilterLayer(colorFilter: srcOverFilter);
  print('  srcOver filter: ${srcOverLayer.colorFilter}');

  final multiplyFilter = ColorFilter.mode(
    Color(0xFF4CAF50),
    BlendMode.multiply,
  );
  final multiplyLayer = ColorFilterLayer(colorFilter: multiplyFilter);
  print('  multiply filter: ${multiplyLayer.colorFilter}');

  final screenFilter = ColorFilter.mode(Color(0xFF9C27B0), BlendMode.screen);
  final screenLayer = ColorFilterLayer(colorFilter: screenFilter);
  print('  screen filter: ${screenLayer.colorFilter}');

  final overlayFilter = ColorFilter.mode(Color(0xFFE91E63), BlendMode.overlay);
  final overlayLayer = ColorFilterLayer(colorFilter: overlayFilter);
  print('  overlay filter: ${overlayLayer.colorFilter}');

  final colorDodgeFilter = ColorFilter.mode(
    Color(0xFF00BCD4),
    BlendMode.colorDodge,
  );
  final colorDodgeLayer = ColorFilterLayer(colorFilter: colorDodgeFilter);
  print('  colorDodge filter: ${colorDodgeLayer.colorFilter}');

  // ========== ColorFilter.matrix ==========
  print('--- ColorFilter.matrix ---');
  // Grayscale matrix
  final grayscaleMatrix = ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
  final grayscaleLayer = ColorFilterLayer(colorFilter: grayscaleMatrix);
  print('  grayscale matrix filter: created');

  // Sepia matrix
  final sepiaMatrix = ColorFilter.matrix(<double>[
    0.393,
    0.769,
    0.189,
    0,
    0,
    0.349,
    0.686,
    0.168,
    0,
    0,
    0.272,
    0.534,
    0.131,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
  final sepiaLayer = ColorFilterLayer(colorFilter: sepiaMatrix);
  print('  sepia matrix filter: created');

  // Invert matrix
  final invertMatrix = ColorFilter.matrix(<double>[
    -1,
    0,
    0,
    0,
    255,
    0,
    -1,
    0,
    0,
    255,
    0,
    0,
    -1,
    0,
    255,
    0,
    0,
    0,
    1,
    0,
  ]);
  final invertLayer = ColorFilterLayer(colorFilter: invertMatrix);
  print('  invert matrix filter: created');

  // ========== ColorFilter.linearToSrgbGamma ==========
  print('--- ColorFilter.linearToSrgbGamma ---');
  final linearToSrgb = ColorFilter.linearToSrgbGamma();
  final linearToSrgbLayer = ColorFilterLayer(colorFilter: linearToSrgb);
  print('  linearToSrgbGamma filter: created');

  // ========== ColorFilter.srgbToLinearGamma ==========
  print('--- ColorFilter.srgbToLinearGamma ---');
  final srgbToLinear = ColorFilter.srgbToLinearGamma();
  final srgbToLinearLayer = ColorFilterLayer(colorFilter: srgbToLinear);
  print('  srgbToLinearGamma filter: created');

  // ========== ColorFilterLayer Property Modification ==========
  print('--- ColorFilterLayer Property Modification ---');
  final mutableLayer = ColorFilterLayer(colorFilter: colorFilter);
  print('  initial colorFilter: ${mutableLayer.colorFilter}');

  final newFilter = ColorFilter.mode(Color(0xFF607D8B), BlendMode.saturation);
  mutableLayer.colorFilter = newFilter;
  print('  modified colorFilter: ${mutableLayer.colorFilter}');

  // ========== ColorFilterLayer Layer Hierarchy ==========
  print('--- ColorFilterLayer Layer Hierarchy ---');
  print('  parent: ${filterLayer.parent}');
  print('  firstChild: ${filterLayer.firstChild}');
  print('  lastChild: ${filterLayer.lastChild}');
  print('  nextSibling: ${filterLayer.nextSibling}');
  print('  previousSibling: ${filterLayer.previousSibling}');
  print('  hasChildren: ${filterLayer.hasChildren}');

  // ========== Various Colors with Mode ==========
  print('--- Various Colors with Mode ---');
  final colors = [
    Color(0xFFFF0000), // Red
    Color(0xFF00FF00), // Green
    Color(0xFF0000FF), // Blue
    Color(0xFFFFFF00), // Yellow
    Color(0xFFFF00FF), // Magenta
    Color(0xFF00FFFF), // Cyan
  ];
  for (int i = 0; i < colors.length; i++) {
    final filter = ColorFilter.mode(colors[i], BlendMode.srcIn);
    final layer = ColorFilterLayer(colorFilter: filter);
    print('  color[$i] filter: ${layer.colorFilter}');
  }

  // ========== BlendMode Values ==========
  print('--- BlendMode Values for ColorFilter ---');
  final usefulBlendModes = [
    BlendMode.srcIn,
    BlendMode.srcOver,
    BlendMode.multiply,
    BlendMode.screen,
    BlendMode.overlay,
    BlendMode.darken,
    BlendMode.lighten,
    BlendMode.colorDodge,
    BlendMode.colorBurn,
  ];
  for (final mode in usefulBlendModes) {
    print('  ${mode.name}: useful for color filtering');
  }

  print('ColorFilterLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ColorFilterLayer Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('ColorFilterLayer: ${filterLayer.runtimeType}'),
          Text('ColorFilter.mode: various blend modes'),
          Text('ColorFilter.matrix: grayscale, sepia, invert'),
          Text('Gamma conversions: linearToSrgb, srgbToLinear'),
          Text('Multiple colors tested'),
          Text('Layer hierarchy verified'),
        ],
      ),
    ),
  );
}

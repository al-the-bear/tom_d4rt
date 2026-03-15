// D4rt test script: Tests ImageFilterConfig from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageFilterConfig test executing');

  // ========== Basic ImageFilterConfig creation ==========
  print('--- Basic ImageFilterConfig ---');
  final blurFilter = ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  final config1 = ImageFilterConfig(filter: blurFilter);
  print('  created: ${config1.runtimeType}');
  print('  filter: ${config1.filter}');

  // ========== Different ImageFilter types ==========
  print('--- Different ImageFilter types ---');
  final gaussianBlur = ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0);
  final configBlur = ImageFilterConfig(filter: gaussianBlur);
  print('  gaussian blur config: ${configBlur.runtimeType}');
  print('  filter type: ${configBlur.filter.runtimeType}');

  final asymmetricBlur = ImageFilter.blur(sigmaX: 15.0, sigmaY: 5.0);
  final configAsymmetric = ImageFilterConfig(filter: asymmetricBlur);
  print('  asymmetric blur: ${configAsymmetric.filter.runtimeType}');

  // ========== Matrix filters ==========
  print('--- Matrix filters ---');
  final matrixFilter = ImageFilter.matrix(
    Float64List.fromList([
      1.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
    ]),
  );
  final configMatrix = ImageFilterConfig(filter: matrixFilter);
  print('  matrix filter config: ${configMatrix.runtimeType}');

  // ========== Composed filters ==========
  print('--- Composed filters ---');
  final innerFilter = ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0);
  final outerFilter = ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  final composedFilter = ImageFilter.compose(
    inner: innerFilter,
    outer: outerFilter,
  );
  final configComposed = ImageFilterConfig(filter: composedFilter);
  print('  composed filter: ${configComposed.runtimeType}');

  // ========== Blur sigma variations ==========
  print('--- Blur sigma variations ---');
  final smallBlur = ImageFilterConfig(
    filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
  );
  print('  small blur (1.0, 1.0): ${smallBlur.runtimeType}');

  final mediumBlur = ImageFilterConfig(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
  );
  print('  medium blur (5.0, 5.0): ${mediumBlur.runtimeType}');

  final largeBlur = ImageFilterConfig(
    filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
  );
  print('  large blur (20.0, 20.0): ${largeBlur.runtimeType}');

  // ========== TileMode variations ==========
  print('--- TileMode variations ---');
  final clampBlur = ImageFilter.blur(
    sigmaX: 5.0,
    sigmaY: 5.0,
    tileMode: TileMode.clamp,
  );
  final configClamp = ImageFilterConfig(filter: clampBlur);
  print('  clamp mode: ${configClamp.filter.runtimeType}');

  final repeatBlur = ImageFilter.blur(
    sigmaX: 5.0,
    sigmaY: 5.0,
    tileMode: TileMode.repeated,
  );
  final configRepeat = ImageFilterConfig(filter: repeatBlur);
  print('  repeat mode: ${configRepeat.filter.runtimeType}');

  final mirrorBlur = ImageFilter.blur(
    sigmaX: 5.0,
    sigmaY: 5.0,
    tileMode: TileMode.mirror,
  );
  final configMirror = ImageFilterConfig(filter: mirrorBlur);
  print('  mirror mode: ${configMirror.filter.runtimeType}');

  // ========== Equality checks ==========
  print('--- Equality checks ---');
  final configA = ImageFilterConfig(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
  );
  final configB = ImageFilterConfig(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
  );
  print('  configA: ${configA.runtimeType}');
  print('  configB: ${configB.runtimeType}');

  print('ImageFilterConfig test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ImageFilterConfig Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic config: ${config1.runtimeType}'),
          Text('Filter: ${config1.filter.runtimeType}'),
          SizedBox(height: 8.0),
          Text('Blur variations:'),
          Text('  - Small (1.0)'),
          Text('  - Medium (5.0)'),
          Text('  - Large (20.0)'),
          SizedBox(height: 8.0),
          Text('TileMode options:'),
          Text('  - clamp'),
          Text('  - repeated'),
          Text('  - mirror'),
        ],
      ),
    ),
  );
}

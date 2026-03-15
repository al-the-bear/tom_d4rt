// D4rt test script: Tests ImageFilterContext from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageFilterContext test executing');

  // ========== ImageFilterContext is abstract - documented behavior ==========
  print('--- ImageFilterContext (abstract) ---');
  print('  ImageFilterContext is an abstract interface');
  print('  Used by BackdropFilter and related widgets');
  print('  Provides filter and clip information');

  // ========== BackdropFilter usage (uses ImageFilterContext internally) ==========
  print('--- BackdropFilter (uses ImageFilterContext) ---');
  final backdropFilter = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    child: Container(width: 100.0, height: 100.0, color: Color(0x80FFFFFF)),
  );
  print('  BackdropFilter created');
  print('  filter: blur(5.0, 5.0)');

  // ========== Different filter configurations ==========
  print('--- Different filter configurations ---');
  final blurLight = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
    child: Container(width: 50.0, height: 50.0),
  );
  print('  light blur filter (2.0, 2.0)');

  final blurHeavy = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
    child: Container(width: 50.0, height: 50.0),
  );
  print('  heavy blur filter (15.0, 15.0)');

  final blurAsymmetric = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 2.0),
    child: Container(width: 50.0, height: 50.0),
  );
  print('  asymmetric blur (10.0, 2.0)');

  // ========== Composed filters ==========
  print('--- Composed filters ---');
  final composedFilter = ImageFilter.compose(
    inner: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
    outer: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
  );
  final composedBackdrop = BackdropFilter(
    filter: composedFilter,
    child: Container(width: 50.0, height: 50.0),
  );
  print('  composed filter: inner + outer blur');

  // ========== BlendMode with filters ==========
  print('--- BlendMode with filters ---');
  final blendNormal = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    blendMode: BlendMode.srcOver,
    child: Container(width: 50.0, height: 50.0),
  );
  print('  blendMode: srcOver');

  final blendMultiply = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    blendMode: BlendMode.multiply,
    child: Container(width: 50.0, height: 50.0),
  );
  print('  blendMode: multiply');

  // ========== Matrix transforms in filter ==========
  print('--- Matrix transforms ---');
  final identityMatrix = Float64List.fromList([
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
  ]);
  final matrixFilter = ImageFilter.matrix(identityMatrix);
  print('  identity matrix filter created');

  // ========== Filter chains ==========
  print('--- Filter chains ---');
  final filter1 = ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0);
  final filter2 = ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0);
  final filter3 = ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0);
  final chain1 = ImageFilter.compose(inner: filter1, outer: filter2);
  final chain2 = ImageFilter.compose(inner: chain1, outer: filter3);
  print('  3-filter chain created');
  print('  chain depth: 3');

  print('ImageFilterContext test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ImageFilterContext Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('ImageFilterContext is abstract'),
          Text('Used by BackdropFilter internally'),
          SizedBox(height: 8.0),
          Stack(
            children: [
              Container(
                width: 200.0,
                height: 100.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2196F3), Color(0xFF4CAF50)],
                  ),
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(color: Color(0x40FFFFFF)),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text('BackdropFilter with blur applied'),
        ],
      ),
    ),
  );
}

// D4rt test script: Tests PersistentHeaderShowOnScreenConfiguration from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PersistentHeaderShowOnScreenConfiguration test executing');

  // ========== Basic PersistentHeaderShowOnScreenConfiguration creation ==========
  print('--- Basic PersistentHeaderShowOnScreenConfiguration ---');
  final config1 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 100.0,
  );
  print('  created: ${config1.runtimeType}');
  print('  minShowOnScreenExtent: ${config1.minShowOnScreenExtent}');
  print('  maxShowOnScreenExtent: ${config1.maxShowOnScreenExtent}');

  // ========== Different minShowOnScreenExtent values ==========
  print('--- Different minShowOnScreenExtent values ---');
  final configMin0 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 100.0,
  );
  print('  minShowOnScreenExtent = 0: ${configMin0.minShowOnScreenExtent}');

  final configMin25 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 25.0,
    maxShowOnScreenExtent: 100.0,
  );
  print('  minShowOnScreenExtent = 25: ${configMin25.minShowOnScreenExtent}');

  final configMin50 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 50.0,
    maxShowOnScreenExtent: 100.0,
  );
  print('  minShowOnScreenExtent = 50: ${configMin50.minShowOnScreenExtent}');

  final configMin75 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 75.0,
    maxShowOnScreenExtent: 100.0,
  );
  print('  minShowOnScreenExtent = 75: ${configMin75.minShowOnScreenExtent}');

  // ========== Different maxShowOnScreenExtent values ==========
  print('--- Different maxShowOnScreenExtent values ---');
  final configMax50 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 50.0,
  );
  print('  maxShowOnScreenExtent = 50: ${configMax50.maxShowOnScreenExtent}');

  final configMax100 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 100.0,
  );
  print('  maxShowOnScreenExtent = 100: ${configMax100.maxShowOnScreenExtent}');

  final configMax150 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 150.0,
  );
  print('  maxShowOnScreenExtent = 150: ${configMax150.maxShowOnScreenExtent}');

  final configMax200 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 200.0,
  );
  print('  maxShowOnScreenExtent = 200: ${configMax200.maxShowOnScreenExtent}');

  // ========== Combined min and max values ==========
  print('--- Combined min and max values ---');
  final combined1 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 20.0,
    maxShowOnScreenExtent: 80.0,
  );
  print(
    '  min=20, max=80: ${combined1.minShowOnScreenExtent}, ${combined1.maxShowOnScreenExtent}',
  );

  final combined2 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 40.0,
    maxShowOnScreenExtent: 120.0,
  );
  print(
    '  min=40, max=120: ${combined2.minShowOnScreenExtent}, ${combined2.maxShowOnScreenExtent}',
  );

  final combined3 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 60.0,
    maxShowOnScreenExtent: 160.0,
  );
  print(
    '  min=60, max=160: ${combined3.minShowOnScreenExtent}, ${combined3.maxShowOnScreenExtent}',
  );

  // ========== Same min and max (fixed extent) ==========
  print('--- Same min and max (fixed extent) ---');
  final fixedExtent = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 100.0,
    maxShowOnScreenExtent: 100.0,
  );
  print(
    '  fixed at 100: min=${fixedExtent.minShowOnScreenExtent}, max=${fixedExtent.maxShowOnScreenExtent}',
  );

  // ========== Small extent range ==========
  print('--- Small extent range ---');
  final smallRange = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 45.0,
    maxShowOnScreenExtent: 55.0,
  );
  print(
    '  small range (45-55): ${smallRange.minShowOnScreenExtent} to ${smallRange.maxShowOnScreenExtent}',
  );

  // ========== Large extent range ==========
  print('--- Large extent range ---');
  final largeRange = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 500.0,
  );
  print(
    '  large range (0-500): ${largeRange.minShowOnScreenExtent} to ${largeRange.maxShowOnScreenExtent}',
  );

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  config1.runtimeType: ${config1.runtimeType}');
  print('  fixedExtent.runtimeType: ${fixedExtent.runtimeType}');

  // ========== Multiple configurations ==========
  print('--- Multiple configurations ---');
  final configs = [
    (0.0, 50.0),
    (0.0, 100.0),
    (25.0, 100.0),
    (50.0, 150.0),
    (100.0, 200.0),
  ];
  for (final (min, max) in configs) {
    final cfg = PersistentHeaderShowOnScreenConfiguration(
      minShowOnScreenExtent: min,
      maxShowOnScreenExtent: max,
    );
    print('  config: min=$min, max=$max - range=${max - min}');
  }

  print('PersistentHeaderShowOnScreenConfiguration test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'PersistentHeaderShowOnScreenConfiguration Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Type: ${config1.runtimeType}'),
          Text('minShowOnScreenExtent: ${config1.minShowOnScreenExtent}'),
          Text('maxShowOnScreenExtent: ${config1.maxShowOnScreenExtent}'),
          SizedBox(height: 8.0),
          Text('Different minShowOnScreenExtent:'),
          Text('  0: ${configMin0.minShowOnScreenExtent}'),
          Text('  25: ${configMin25.minShowOnScreenExtent}'),
          Text('  50: ${configMin50.minShowOnScreenExtent}'),
          Text('  75: ${configMin75.minShowOnScreenExtent}'),
          SizedBox(height: 8.0),
          Text('Different maxShowOnScreenExtent:'),
          Text('  50: ${configMax50.maxShowOnScreenExtent}'),
          Text('  100: ${configMax100.maxShowOnScreenExtent}'),
          Text('  150: ${configMax150.maxShowOnScreenExtent}'),
          SizedBox(height: 8.0),
          Text(
            'Fixed extent (100): ${fixedExtent.minShowOnScreenExtent} == ${fixedExtent.maxShowOnScreenExtent}',
          ),
        ],
      ),
    ),
  );
}

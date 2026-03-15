// D4rt test script: Tests AnnotationResult from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' show Offset;

dynamic build(BuildContext context) {
  print('AnnotationResult test executing');
  final results = <String>[];

  // ========== Section 1: Basic Construction ==========
  print('--- Section 1: Basic Construction ---');

  // Create empty AnnotationResult
  final emptyResult = AnnotationResult<String>();
  print('Created empty AnnotationResult<String>');
  print('Initial entries count: ${emptyResult.entries.length}');
  results.add('Empty result entries: ${emptyResult.entries.length}');

  // ========== Section 2: Adding Entries ==========
  print('--- Section 2: Adding Entries ---');

  final result = AnnotationResult<int>();

  // Add annotation entries manually via layer
  final layer1 = AnnotatedRegionLayer<int>(42, size: Size(100, 100));
  layer1.findAnnotations<int>(result, Offset(50, 50), onlyFirst: false);

  print('After adding via layer: ${result.entries.length} entries');
  results.add('Added entry via layer: ${result.entries.length} entries');

  // ========== Section 3: Accessing Entries ==========
  print('--- Section 3: Accessing Entries ---');

  if (result.entries.isNotEmpty) {
    final firstEntry = result.entries.first;
    print('First entry annotation: ${firstEntry.annotation}');
    print('First entry local position: ${firstEntry.localPosition}');
    results.add('First entry annotation: ${firstEntry.annotation}');
  }

  // ========== Section 4: Multiple Annotations ==========
  print('--- Section 4: Multiple Annotations ---');

  final multiResult = AnnotationResult<String>();

  // Create multiple layers and find annotations
  final container = ContainerLayer();
  final strLayer1 = AnnotatedRegionLayer<String>('first', size: Size(100, 100));
  final strLayer2 = AnnotatedRegionLayer<String>(
    'second',
    size: Size(100, 100),
  );

  container.append(strLayer1);
  container.append(strLayer2);

  // Find all string annotations at a point
  strLayer1.findAnnotations<String>(
    multiResult,
    Offset(50, 50),
    onlyFirst: false,
  );
  strLayer2.findAnnotations<String>(
    multiResult,
    Offset(50, 50),
    onlyFirst: false,
  );

  print('Multiple annotations found: ${multiResult.entries.length}');
  for (var entry in multiResult.entries) {
    print('  - ${entry.annotation}');
  }
  results.add('Multiple annotations: ${multiResult.entries.length}');

  // ========== Section 5: Typed Results ==========
  print('--- Section 5: Typed Results ---');

  // Test with different types
  final doubleResult = AnnotationResult<double>();
  final doubleLayer = AnnotatedRegionLayer<double>(3.14159, size: Size(50, 50));
  doubleLayer.findAnnotations<double>(
    doubleResult,
    Offset(25, 25),
    onlyFirst: false,
  );

  print('Double result entries: ${doubleResult.entries.length}');
  if (doubleResult.entries.isNotEmpty) {
    print('Double value: ${doubleResult.entries.first.annotation}');
    results.add('Double annotation: ${doubleResult.entries.first.annotation}');
  }

  // ========== Section 6: Entry Iteration ==========
  print('--- Section 6: Entry Iteration ---');

  final iterResult = AnnotationResult<int>();
  for (var i = 0; i < 3; i++) {
    final layer = AnnotatedRegionLayer<int>(i * 10, size: Size(100, 100));
    layer.findAnnotations<int>(iterResult, Offset(50, 50), onlyFirst: false);
  }

  print('Iterating ${iterResult.entries.length} entries:');
  final annotations = <int>[];
  for (var entry in iterResult.entries) {
    annotations.add(entry.annotation);
    print('  Annotation: ${entry.annotation}');
  }
  results.add('Iteration test: values=${annotations.join(", ")}');

  // ========== Section 7: OnlyFirst Flag ==========
  print('--- Section 7: OnlyFirst Flag ---');

  final onlyFirstResult = AnnotationResult<String>();
  final stopLayer = AnnotatedRegionLayer<String>(
    'stop-here',
    size: Size(100, 100),
  );

  final shouldStop = stopLayer.findAnnotations<String>(
    onlyFirstResult,
    Offset(50, 50),
    onlyFirst: true,
  );
  print('Should stop after first: $shouldStop');
  print('Entries in onlyFirst result: ${onlyFirstResult.entries.length}');
  results.add(
    'OnlyFirst result: $shouldStop, entries: ${onlyFirstResult.entries.length}',
  );

  print('AnnotationResult test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'AnnotationResult Tests',
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

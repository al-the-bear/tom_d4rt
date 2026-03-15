// D4rt test script: Tests AnnotatedRegionLayer from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnnotatedRegionLayer test executing');
  final results = <String>[];

  // ========== Section 1: Basic Construction ==========
  print('--- Section 1: Basic Construction ---');

  // Create AnnotatedRegionLayer with String value
  final stringLayer = AnnotatedRegionLayer<String>(
    'test-region',
    size: Size(100, 100),
    offset: Offset(10, 20),
  );
  print(
    'Created AnnotatedRegionLayer<String> with value: ${stringLayer.value}',
  );
  results.add('Created layer with value: ${stringLayer.value}');

  // Test properties
  print('Layer size: ${stringLayer.size}');
  print('Layer offset: ${stringLayer.offset}');
  results.add('Size: ${stringLayer.size}, Offset: ${stringLayer.offset}');

  // ========== Section 2: Integer Annotation ==========
  print('--- Section 2: Integer Annotation ---');

  final intLayer = AnnotatedRegionLayer<int>(
    42,
    size: Size(200, 150),
    offset: Offset.zero,
  );
  print('Created AnnotatedRegionLayer<int> with value: ${intLayer.value}');
  results.add('Integer layer value: ${intLayer.value}');

  // ========== Section 3: Nullable Size ==========
  print('--- Section 3: Nullable Size ---');

  final nullSizeLayer = AnnotatedRegionLayer<String>(
    'unbounded-region',
    size: null,
    offset: Offset(5, 5),
  );
  print('Created layer with null size (unbounded): ${nullSizeLayer.size}');
  results.add('Null size layer: size=${nullSizeLayer.size}');

  // ========== Section 4: Custom Object Annotation ==========
  print('--- Section 4: Custom Object Annotation ---');

  // Using a Map as annotation value
  final mapAnnotation = {'id': 1, 'name': 'region-1'};
  final mapLayer = AnnotatedRegionLayer<Map<String, dynamic>>(
    mapAnnotation,
    size: Size(50, 50),
    offset: Offset(100, 100),
  );
  print('Created layer with Map annotation: ${mapLayer.value}');
  results.add('Map annotation: ${mapLayer.value}');

  // ========== Section 5: Layer Operations ==========
  print('--- Section 5: Layer Operations ---');

  // Test layer tree operations
  final parentLayer = ContainerLayer();
  final testLayer = AnnotatedRegionLayer<String>(
    'child-region',
    size: Size(80, 80),
  );

  parentLayer.append(testLayer);
  print('Appended annotation layer to parent');
  print('Parent has child: ${parentLayer.firstChild != null}');
  results.add('Layer attached to parent: ${parentLayer.firstChild != null}');

  // ========== Section 6: Find Annotation ==========
  print('--- Section 6: Find Annotation ---');

  final result = AnnotationResult<String>();
  // Note: findAnnotations uses local position within the layer
  final found = stringLayer.findAnnotations<String>(
    result,
    Offset(50, 50),
    onlyFirst: false,
  );
  print('Find annotations returned: $found');
  print('Result entries: ${result.entries.length}');
  results.add('Annotations found: ${result.entries.length}');

  // ========== Section 7: Multiple Layers in Hierarchy ==========
  print('--- Section 7: Multiple Layers in Hierarchy ---');

  final container = ContainerLayer();
  final layer1 = AnnotatedRegionLayer<int>(1, size: Size(100, 100));
  final layer2 = AnnotatedRegionLayer<int>(2, size: Size(100, 100));

  container.append(layer1);
  container.append(layer2);

  var childCount = 0;
  var child = container.firstChild;
  while (child != null) {
    childCount++;
    child = child.nextSibling;
  }
  print('Container has $childCount children');
  results.add('Hierarchy test: $childCount children');

  print('AnnotatedRegionLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'AnnotatedRegionLayer Tests',
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

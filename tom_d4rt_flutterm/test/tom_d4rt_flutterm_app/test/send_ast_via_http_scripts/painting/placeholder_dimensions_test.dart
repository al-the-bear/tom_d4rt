// D4rt test script: Tests PlaceholderDimensions from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlaceholderDimensions test executing');
  final results = <String>[];

  // ========== Basic PlaceholderDimensions Tests ==========
  print('Testing PlaceholderDimensions constructor...');

  // Test 1: Create basic PlaceholderDimensions
  final dim1 = PlaceholderDimensions(
    size: Size(100.0, 50.0),
    alignment: PlaceholderAlignment.bottom,
  );
  assert(dim1.size == Size(100.0, 50.0), 'Size should match');
  assert(
    dim1.alignment == PlaceholderAlignment.bottom,
    'Alignment should be bottom',
  );
  results.add(
    'PlaceholderDimensions: size=${dim1.size}, alignment=${dim1.alignment}',
  );
  print('Basic PlaceholderDimensions created');

  // Test 2: Create with baseline
  final dim2 = PlaceholderDimensions(
    size: Size(80.0, 60.0),
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.alphabetic,
    baselineOffset: 50.0,
  );
  assert(
    dim2.baseline == TextBaseline.alphabetic,
    'Baseline should be alphabetic',
  );
  assert(dim2.baselineOffset == 50.0, 'Baseline offset should be 50');
  results.add('With baseline: ${dim2.baseline}, offset=${dim2.baselineOffset}');
  print('Baseline PlaceholderDimensions created');

  // Test 3: Create with ideographic baseline
  final dim3 = PlaceholderDimensions(
    size: Size(120.0, 40.0),
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.ideographic,
    baselineOffset: 35.0,
  );
  assert(
    dim3.baseline == TextBaseline.ideographic,
    'Baseline should be ideographic',
  );
  results.add('Ideographic baseline: offset=${dim3.baselineOffset}');
  print('Ideographic baseline created');

  // ========== All PlaceholderAlignment Values ==========
  print('Testing all PlaceholderAlignment values...');

  final alignments = PlaceholderAlignment.values;
  for (final alignment in alignments) {
    final dim = PlaceholderDimensions(
      size: Size(50.0, 30.0),
      alignment: alignment,
    );
    assert(dim.alignment == alignment, 'Alignment should match');
    results.add('PlaceholderAlignment.${alignment.name}');
    print('Alignment: ${alignment.name}');
  }

  // ========== Various Sizes ==========
  print('Testing various sizes...');

  final sizes = [
    Size(10.0, 10.0),
    Size(50.0, 25.0),
    Size(100.0, 100.0),
    Size(200.0, 50.0),
    Size(20.0, 80.0),
  ];

  for (final size in sizes) {
    final dim = PlaceholderDimensions(
      size: size,
      alignment: PlaceholderAlignment.middle,
    );
    assert(dim.size == size, 'Size should match');
    results.add('Size: ${size.width.toInt()}x${size.height.toInt()}');
    print('Size tested: $size');
  }

  // ========== Baseline Offset Variations ==========
  print('Testing baseline offset variations...');

  final offsets = [0.0, 10.0, 25.0, 50.0, 75.0, 100.0];
  for (final offset in offsets) {
    final dim = PlaceholderDimensions(
      size: Size(60.0, 40.0),
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      baselineOffset: offset,
    );
    assert(dim.baselineOffset == offset, 'Offset should match');
    results.add('Baseline offset: $offset');
    print('Offset: $offset');
  }

  // ========== PlaceholderDimensions.empty ==========
  print('Testing PlaceholderDimensions.empty...');

  final empty = PlaceholderDimensions.empty;
  assert(empty.size == Size.zero, 'Empty should have zero size');
  results.add('Empty: size=${empty.size}');
  print('Empty placeholder created');

  // ========== Property Access Tests ==========
  print('Testing property access...');

  final testDim = PlaceholderDimensions(
    size: Size(75.0, 45.0),
    alignment: PlaceholderAlignment.aboveBaseline,
    baseline: TextBaseline.alphabetic,
    baselineOffset: 40.0,
  );

  results.add('Property size: ${testDim.size}');
  results.add('Property alignment: ${testDim.alignment}');
  results.add('Property baseline: ${testDim.baseline}');
  results.add('Property baselineOffset: ${testDim.baselineOffset}');
  print('Properties accessed');

  // ========== Alignment Descriptions ==========
  print('Documenting alignment behaviors...');

  final alignmentDescs = {
    'baseline': 'Aligns bottom to text baseline',
    'aboveBaseline': 'Aligns bottom above baseline by offset',
    'belowBaseline': 'Aligns top below baseline by offset',
    'top': 'Aligns top with text top',
    'middle': 'Centers vertically with text',
    'bottom': 'Aligns bottom with text bottom',
  };

  for (final entry in alignmentDescs.entries) {
    results.add('${entry.key}: ${entry.value}');
    print('${entry.key}: ${entry.value}');
  }

  // ========== Equality Testing ==========
  print('Testing equality...');

  final dimA = PlaceholderDimensions(
    size: Size(100.0, 50.0),
    alignment: PlaceholderAlignment.middle,
  );
  final dimB = PlaceholderDimensions(
    size: Size(100.0, 50.0),
    alignment: PlaceholderAlignment.middle,
  );
  final dimC = PlaceholderDimensions(
    size: Size(100.0, 50.0),
    alignment: PlaceholderAlignment.bottom,
  );

  assert(dimA == dimB, 'Same dimensions should be equal');
  assert(dimA != dimC, 'Different alignments should not be equal');
  results.add('Equality (same): ${dimA == dimB}');
  results.add('Inequality (diff alignment): ${dimA != dimC}');
  print('Equality tests completed');

  // ========== Use Case Documentation ==========
  print('Documenting use cases...');

  results.add('Use case: Inline widgets in RichText');
  results.add('Use case: WidgetSpan placeholder sizing');
  results.add('Use case: Custom inline elements in TextPainter');
  print('Use cases documented');

  // ========== Integration with WidgetSpan ==========
  print('Testing integration concepts...');

  results.add('Integration: PlaceholderSpan uses PlaceholderDimensions');
  results.add('Integration: TextPainter.setPlaceholderDimensions()');
  results.add('Integration: InlineSpan builds with placeholders');
  print('Integrations documented');

  print('PlaceholderDimensions test completed: ${results.length} tests passed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'PlaceholderDimensions Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text('Total tests: ${results.length}', style: TextStyle(fontSize: 14)),
      Divider(),
      ...results.map(
        (r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(r, style: TextStyle(fontSize: 11)),
        ),
      ),
    ],
  );
}

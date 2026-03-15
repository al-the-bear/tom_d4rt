// D4rt test script: Tests SelectedContentRange from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectedContentRange test executing');

  // ========== Basic SelectedContentRange creation ==========
  print('--- Basic SelectedContentRange ---');
  final range1 = SelectedContentRange(startOffset: 0, endOffset: 10);
  print('  created: ${range1.runtimeType}');
  print('  startOffset: ${range1.startOffset}');
  print('  endOffset: ${range1.endOffset}');

  // ========== Different start/end values ==========
  print('--- Different start/end values ---');
  final rangeZeroZero = SelectedContentRange(startOffset: 0, endOffset: 0);
  final rangeLarge = SelectedContentRange(startOffset: 1000, endOffset: 5000);
  final rangeSmall = SelectedContentRange(startOffset: 5, endOffset: 6);
  print(
    '  zero range: ${rangeZeroZero.startOffset} to ${rangeZeroZero.endOffset}',
  );
  print('  large range: ${rangeLarge.startOffset} to ${rangeLarge.endOffset}');
  print('  small range: ${rangeSmall.startOffset} to ${rangeSmall.endOffset}');

  // ========== Calculate range length ==========
  print('--- Range length calculations ---');
  print('  range1 length: ${range1.endOffset - range1.startOffset}');
  print(
    '  zeroZero length: ${rangeZeroZero.endOffset - rangeZeroZero.startOffset}',
  );
  print('  large length: ${rangeLarge.endOffset - rangeLarge.startOffset}');
  print('  small length: ${rangeSmall.endOffset - rangeSmall.startOffset}');

  // ========== Check if range is empty ==========
  print('--- Empty range check ---');
  final isEmpty1 = range1.startOffset == range1.endOffset;
  final isEmpty2 = rangeZeroZero.startOffset == rangeZeroZero.endOffset;
  print('  range1 isEmpty: $isEmpty1');
  print('  rangeZeroZero isEmpty: $isEmpty2');

  // ========== Multiple ranges ==========
  print('--- Multiple ranges ---');
  final ranges = [
    SelectedContentRange(startOffset: 0, endOffset: 50),
    SelectedContentRange(startOffset: 50, endOffset: 100),
    SelectedContentRange(startOffset: 100, endOffset: 200),
    SelectedContentRange(startOffset: 200, endOffset: 250),
  ];
  print('  Created ${ranges.length} ranges');
  for (var i = 0; i < ranges.length; i++) {
    print('  [$i] ${ranges[i].startOffset} to ${ranges[i].endOffset}');
  }

  // ========== Check contiguous ranges ==========
  print('--- Contiguous range check ---');
  for (var i = 0; i < ranges.length - 1; i++) {
    final isContiguous = ranges[i].endOffset == ranges[i + 1].startOffset;
    print('  ranges[$i] -> ranges[${i + 1}] contiguous: $isContiguous');
  }

  // ========== Equality behavior ==========
  print('--- Equality behavior ---');
  final rangeA = SelectedContentRange(startOffset: 10, endOffset: 20);
  final rangeB = SelectedContentRange(startOffset: 10, endOffset: 20);
  final rangeC = SelectedContentRange(startOffset: 10, endOffset: 30);
  print('  rangeA == rangeA: ${rangeA == rangeA}');
  print('  rangeA == rangeB: ${rangeA == rangeB}');
  print('  rangeA == rangeC: ${rangeA == rangeC}');
  print(
    '  rangeA.startOffset == rangeB.startOffset: ${rangeA.startOffset == rangeB.startOffset}',
  );
  print(
    '  rangeA.endOffset == rangeB.endOffset: ${rangeA.endOffset == rangeB.endOffset}',
  );

  // ========== HashCode ==========
  print('--- HashCode ---');
  print('  rangeA.hashCode: ${rangeA.hashCode}');
  print('  rangeB.hashCode: ${rangeB.hashCode}');
  print('  rangeC.hashCode: ${rangeC.hashCode}');

  // ========== ToString ==========
  print('--- ToString ---');
  print('  range1.toString(): ${range1.toString()}');
  print('  rangeA.toString(): ${rangeA.toString()}');

  // ========== Range with single character ==========
  print('--- Single character ranges ---');
  final singleChar = SelectedContentRange(startOffset: 100, endOffset: 101);
  print(
    '  single char range: ${singleChar.startOffset} to ${singleChar.endOffset}',
  );
  print('  length: ${singleChar.endOffset - singleChar.startOffset}');

  print('SelectedContentRange test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectedContentRange Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic range: ${range1.startOffset} to ${range1.endOffset}'),
          Text('Range length: ${range1.endOffset - range1.startOffset}'),
          Text(
            'Zero range length: ${rangeZeroZero.endOffset - rangeZeroZero.startOffset}',
          ),
          Text(
            'Large range: ${rangeLarge.startOffset} to ${rangeLarge.endOffset}',
          ),
          Text('Ranges created: ${ranges.length}'),
        ],
      ),
    ),
  );
}

// D4rt test script: Tests PlaceholderSpanIndexSemanticsTag from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlaceholderSpanIndexSemanticsTag test executing');

  // ========== Basic PlaceholderSpanIndexSemanticsTag creation ==========
  print('--- Basic PlaceholderSpanIndexSemanticsTag ---');
  final tag1 = PlaceholderSpanIndexSemanticsTag(0);
  print('  created: ${tag1.runtimeType}');
  print('  index: ${tag1.index}');

  // ========== Different index values ==========
  print('--- Different index values ---');
  final tag0 = PlaceholderSpanIndexSemanticsTag(0);
  print('  index = 0: ${tag0.index}');

  final tag1b = PlaceholderSpanIndexSemanticsTag(1);
  print('  index = 1: ${tag1b.index}');

  final tag5 = PlaceholderSpanIndexSemanticsTag(5);
  print('  index = 5: ${tag5.index}');

  final tag10 = PlaceholderSpanIndexSemanticsTag(10);
  print('  index = 10: ${tag10.index}');

  final tag100 = PlaceholderSpanIndexSemanticsTag(100);
  print('  index = 100: ${tag100.index}');

  // ========== SemanticsTag inheritance ==========
  print('--- SemanticsTag inheritance ---');
  print('  is SemanticsTag: ${tag1 is SemanticsTag}');
  print('  tag1.name: ${tag1.name}');

  // ========== name property ==========
  print('--- name property ---');
  print('  tag0.name: ${tag0.name}');
  print('  tag5.name: ${tag5.name}');
  print('  tag10.name: ${tag10.name}');

  // ========== Multiple tags for inline placeholders ==========
  print('--- Multiple tags for inline placeholders ---');
  final inlineTags = List.generate(
    5,
    (i) => PlaceholderSpanIndexSemanticsTag(i),
  );
  for (int i = 0; i < inlineTags.length; i++) {
    print(
      '  placeholder $i: index=${inlineTags[i].index}, name=${inlineTags[i].name}',
    );
  }

  // ========== Equality comparison ==========
  print('--- Equality comparison ---');
  final tagA = PlaceholderSpanIndexSemanticsTag(3);
  final tagB = PlaceholderSpanIndexSemanticsTag(3);
  final tagC = PlaceholderSpanIndexSemanticsTag(4);
  print('  tagA.index = ${tagA.index}, tagB.index = ${tagB.index}');
  print('  tagA == tagB (same index): ${tagA == tagB}');
  print('  tagA == tagC (different index): ${tagA == tagC}');

  // ========== HashCode ==========
  print('--- HashCode ---');
  print('  tagA.hashCode: ${tagA.hashCode}');
  print('  tagB.hashCode: ${tagB.hashCode}');
  print('  tagC.hashCode: ${tagC.hashCode}');
  print('  hashCode match (same index): ${tagA.hashCode == tagB.hashCode}');

  // ========== Large index values ==========
  print('--- Large index values ---');
  final tagLarge1 = PlaceholderSpanIndexSemanticsTag(500);
  print('  index = 500: ${tagLarge1.index}');

  final tagLarge2 = PlaceholderSpanIndexSemanticsTag(1000);
  print('  index = 1000: ${tagLarge2.index}');

  // ========== Use case: Rich text with inline widgets ==========
  print('--- Use case: Rich text inline widgets ---');
  print('  PlaceholderSpanIndexSemanticsTag is used for accessibility');
  print('  Each inline placeholder in text gets a unique index');
  print('  Screen readers can identify embedded widgets');
  final richTextTags = [
    PlaceholderSpanIndexSemanticsTag(0), // First embedded widget
    PlaceholderSpanIndexSemanticsTag(1), // Second embedded widget
    PlaceholderSpanIndexSemanticsTag(2), // Third embedded widget
  ];
  for (int i = 0; i < richTextTags.length; i++) {
    print('  widget $i tag: ${richTextTags[i].name}');
  }

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  tag1.runtimeType: ${tag1.runtimeType}');
  print('  tagA.runtimeType: ${tagA.runtimeType}');

  // ========== toString ==========
  print('--- toString ---');
  print('  tag0.toString(): ${tag0.toString()}');
  print('  tag5.toString(): ${tag5.toString()}');
  print('  tag100.toString(): ${tag100.toString()}');

  print('PlaceholderSpanIndexSemanticsTag test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'PlaceholderSpanIndexSemanticsTag Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Type: ${tag1.runtimeType}'),
          Text('Inherits from: SemanticsTag'),
          SizedBox(height: 8.0),
          Text('Different indices:'),
          Text('  index 0: ${tag0.index}'),
          Text('  index 1: ${tag1b.index}'),
          Text('  index 5: ${tag5.index}'),
          Text('  index 10: ${tag10.index}'),
          Text('  index 100: ${tag100.index}'),
          SizedBox(height: 8.0),
          Text('Equality:'),
          Text('  tagA == tagB (same index): ${tagA == tagB}'),
          Text('  tagA == tagC (different): ${tagA == tagC}'),
          SizedBox(height: 8.0),
          Text('Purpose: Semantics for inline placeholders'),
          Text('Used in Text.rich() with WidgetSpan'),
          Text('Helps accessibility tools identify embedded widgets'),
          SizedBox(height: 8.0),
          Text.rich(
            TextSpan(
              text: 'Example: ',
              children: [
                TextSpan(text: 'Text with '),
                WidgetSpan(
                  child: Icon(Icons.star, size: 16.0, color: Color(0xFFFFC107)),
                ),
                TextSpan(text: ' inline widget'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

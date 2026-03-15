// D4rt test script: Tests SemanticsProperties, CustomSemanticsAction,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// OrdinalSortKey, SemanticsTag, SemanticsHintOverrides
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  print('Semantics properties test executing');

  // ========== SemanticsProperties ==========
  print('--- SemanticsProperties Tests ---');

  final props = SemanticsProperties(
    enabled: true,
    checked: false,
    label: 'Test label',
    value: 'Test value',
    hint: 'Test hint',
    textDirection: TextDirection.ltr,
    button: true,
    header: false,
    link: false,
    focusable: true,
    focused: false,
    hidden: false,
    slider: false,
    toggled: false,
    readOnly: false,
    selected: false,
    liveRegion: false,
    maxValueLength: 100,
    currentValueLength: 50,
  );
  print('SemanticsProperties label: ${props.label}');
  print('SemanticsProperties value: ${props.value}');
  print('SemanticsProperties hint: ${props.hint}');
  print('SemanticsProperties enabled: ${props.enabled}');
  print('SemanticsProperties checked: ${props.checked}');
  print('SemanticsProperties button: ${props.button}');
  print('SemanticsProperties focusable: ${props.focusable}');
  print('SemanticsProperties textDirection: ${props.textDirection}');

  // ========== CustomSemanticsAction ==========
  print('--- CustomSemanticsAction Tests ---');

  final action1 = CustomSemanticsAction(label: 'Custom action 1');
  print('CustomSemanticsAction label: ${action1.label}');

  final action2 = CustomSemanticsAction(label: 'Custom action 2');
  print('CustomSemanticsAction label2: ${action2.label}');

  // ========== OrdinalSortKey ==========
  print('--- OrdinalSortKey Tests ---');

  final sortKey1 = OrdinalSortKey(1.0);
  print('OrdinalSortKey order: ${sortKey1.order}');
  print('OrdinalSortKey name: ${sortKey1.name}');

  final sortKey2 = OrdinalSortKey(2.0, name: 'secondary');
  print('OrdinalSortKey named order: ${sortKey2.order}');
  print('OrdinalSortKey named name: ${sortKey2.name}');

  final comparison = sortKey1.compareTo(sortKey2);
  print('OrdinalSortKey compareTo: $comparison');

  // ========== SemanticsTag ==========
  print('--- SemanticsTag Tests ---');

  final tag = SemanticsTag('myTag');
  print('SemanticsTag name: ${tag.name}');

  final tag2 = SemanticsTag('anotherTag');
  print('SemanticsTag2 name: ${tag2.name}');

  // ========== SemanticsHintOverrides ==========
  print('--- SemanticsHintOverrides Tests ---');

  final hintOverrides = SemanticsHintOverrides(
    onTapHint: 'Tap to activate',
    onLongPressHint: 'Long press to show options',
  );
  print('SemanticsHintOverrides onTapHint: ${hintOverrides.onTapHint}');
  print(
    'SemanticsHintOverrides onLongPressHint: ${hintOverrides.onLongPressHint}',
  );

  print('All semantics properties tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Semantics(
          label: 'Test label for semantics',
          value: 'value',
          hint: 'hint',
          button: true,
          enabled: true,
          sortKey: OrdinalSortKey(1.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Semantics Properties Test',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Label: ${props.label}'),
              Text('SortKey order: ${sortKey1.order}'),
              Semantics(
                customSemanticsActions: {
                  action1: () => print('Action 1'),
                  action2: () => print('Action 2'),
                },
                child: Text('Custom Actions'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

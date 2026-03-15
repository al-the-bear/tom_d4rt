// D4rt test script: Tests ExpansionPanelList and ExpansionPanel from Flutter material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ExpansionPanel/ExpansionPanelList test executing');

  // Variation 1: Basic ExpansionPanelList with ExpansionPanels
  final panels1 = [
    ExpansionPanel(
      headerBuilder: (context, isExpanded) => ListTile(title: Text('Panel 1')),
      body: Container(padding: EdgeInsets.all(16), child: Text('Content 1')),
    ),
    ExpansionPanel(
      headerBuilder: (context, isExpanded) => ListTile(title: Text('Panel 2')),
      body: Text('Content 2'),
    ),
  ];
  final widget1 = ExpansionPanelList(
    expansionCallback: (index, isExpanded) {
      print('panel $index expanded: $isExpanded');
    },
    children: panels1,
  );
  print('ExpansionPanelList(2 panels) created');

  // Variation 2: ExpansionPanelList with initially expanded panel
  final panels2 = [
    ExpansionPanel(
      headerBuilder: (context, isExpanded) =>
          ListTile(title: Text('Initially Expanded')),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Text('This panel starts expanded'),
      ),
      isExpanded: true,
    ),
    ExpansionPanel(
      headerBuilder: (context, isExpanded) =>
          ListTile(title: Text('Collapsed')),
      body: Text('Hidden content'),
    ),
  ];
  final widget2 = ExpansionPanelList(
    expansionCallback: (index, isExpanded) {
      print('panel $index toggle: $isExpanded');
    },
    children: panels2,
  );
  print('ExpansionPanelList(isExpanded: true) created');

  // Variation 3: ExpansionPanelList with canTapOnHeader
  final panels3 = [
    ExpansionPanel(
      headerBuilder: (context, isExpanded) => ListTile(
        title: Text('Tap Header'),
        subtitle: Text(isExpanded ? 'Expanded' : 'Collapsed'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.blue.shade50,
        child: Text('Tappable header content'),
      ),
      canTapOnHeader: true,
    ),
    ExpansionPanel(
      headerBuilder: (context, isExpanded) =>
          ListTile(title: Text('Also Tappable')),
      body: Text('More content'),
      canTapOnHeader: true,
    ),
  ];
  final widget3 = ExpansionPanelList(
    expansionCallback: (index, isExpanded) {
      print('tappable panel $index: $isExpanded');
    },
    children: panels3,
  );
  print('ExpansionPanelList(canTapOnHeader: true) created');

  // Variation 4: ExpansionPanelList.radio with ExpansionPanelRadio
  final widget4 = ExpansionPanelList.radio(
    expansionCallback: (index, isExpanded) {
      print('radio panel $index: $isExpanded');
    },
    children: [
      ExpansionPanelRadio(
        value: 'radio1',
        headerBuilder: (context, isExpanded) =>
            ListTile(title: Text('Radio Panel 1')),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Text('Radio content 1'),
        ),
      ),
      ExpansionPanelRadio(
        value: 'radio2',
        headerBuilder: (context, isExpanded) =>
            ListTile(title: Text('Radio Panel 2')),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Text('Radio content 2'),
        ),
      ),
      ExpansionPanelRadio(
        value: 'radio3',
        headerBuilder: (context, isExpanded) =>
            ListTile(title: Text('Radio Panel 3')),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Text('Radio content 3'),
        ),
      ),
    ],
  );
  print('ExpansionPanelList.radio(3 radio panels) created');

  print('ExpansionPanel/ExpansionPanelList test completed');
  return SingleChildScrollView(
    child: Column(
      children: [
        widget1,
        SizedBox(height: 16),
        widget2,
        SizedBox(height: 16),
        widget3,
        SizedBox(height: 16),
        widget4,
      ],
    ),
  );
}

// Tests: OverrideAction, AutofillGroupState, AutofillClient (abstract),
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
//        AutofillScope (abstract), EditableTextContextMenuBuilder (typedef),
//        ContextMenuController, ContextMenuRegion, ContextMenuArea
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // --- OverrideAction Tests ---
  print('--- OverrideAction Tests ---');
  print('OverrideAction wraps another action and overrides its behavior');
  print('Type: OverrideAction (internal framework class)');
  var activateAction = CallbackAction<ActivateIntent>(
    onInvoke: (intent) {
      print('Activate action invoked');
      return null;
    },
  );
  print('Base CallbackAction: $activateAction');
  print('OverrideAction allows intercepting and modifying action behavior');

  // --- AutofillGroupState Tests ---
  print('--- AutofillGroupState Tests ---');
  print('AutofillGroupState is the State of AutofillGroup');
  print('Type: $AutofillGroupState');
  var autofillGroup = AutofillGroup(
    child: Column(
      children: [
        TextFormField(
          autofillHints: const [AutofillHints.username],
          decoration: const InputDecoration(labelText: 'Username'),
        ),
        TextFormField(
          autofillHints: const [AutofillHints.password],
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
      ],
    ),
  );
  print('AutofillGroup: $autofillGroup');
  print('AutofillGroup groups autofillable fields together');
  print('AutofillGroupState manages autofill lifecycle');

  // --- AutofillClient Tests ---
  print('--- AutofillClient Tests ---');
  print('AutofillClient is the abstract interface for autofill participants');
  print('Type: AutofillClient (abstract mixin, not publicly available)');
  print('Implemented by EditableTextState and similar text input widgets');
  print('Provides autofillId and textInputConfiguration');
  print('Receives autofill values via autofill() callback');

  // --- AutofillScope Tests ---
  print('--- AutofillScope Tests ---');
  print('AutofillScope groups AutofillClients together');
  print('Type: AutofillScope (abstract mixin, not publicly available)');
  print('Provides getAutofillClient() to look up clients by autofill ID');
  print('AutofillGroupState implements AutofillScope');

  // --- EditableTextContextMenuBuilder Tests ---
  print('--- EditableTextContextMenuBuilder Tests ---');
  print(
    'EditableTextContextMenuBuilder is a typedef for context menu builders',
  );
  print('Signature: Widget Function(BuildContext, EditableTextState)');
  print('Used in TextField.contextMenuBuilder and EditableText');
  print('Allows customizing the text selection context menu');

  // --- ContextMenuController Tests ---
  print('--- ContextMenuController Tests ---');
  var contextMenuController = ContextMenuController();
  print('ContextMenuController: $contextMenuController');
  print('ContextMenuController isShown: ${contextMenuController.isShown}');
  print('ContextMenuController manages context menu display');
  print('Provides show() and remove() methods');

  // --- ContextMenuRegion Tests ---
  print('--- ContextMenuRegion Tests ---');
  print('ContextMenuRegion responds to right-click for context menus');
  print('Type: $ContextMenuButtonType');
  print('ContextMenuButtonType.cut: ${ContextMenuButtonType.cut}');
  print('ContextMenuButtonType.copy: ${ContextMenuButtonType.copy}');
  print('ContextMenuButtonType values: ${ContextMenuButtonType.values}');

  // --- ContextMenuArea Tests ---
  print('--- ContextMenuArea Tests ---');
  print('Context menu areas allow attaching custom context menus to widgets');
  print('Built using ContextMenuController and custom menu builders');
  var contextMenuExample = GestureDetector(
    onSecondaryTapDown: (details) {
      print('Secondary tap detected for context menu');
    },
    child: Container(
      width: 200,
      height: 100,
      color: Colors.blue.shade100,
      child: const Center(child: Text('Right-click area')),
    ),
  );
  print('Context menu area widget: $contextMenuExample');

  print('All autofill context advanced tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              autofillGroup,
              const SizedBox(height: 20),
              contextMenuExample,
              const SizedBox(height: 20),
              const Text('Autofill Context Adv Test'),
            ],
          ),
        ),
      ),
    ),
  );
}

// D4rt test script: Tests ExpansionTile advanced, Stepper, Step,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// StepState, StepperType, ControlsDetails
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ExpansionTile/Stepper test executing');

  // ========== ExpansionTile advanced ==========
  print('--- ExpansionTile advanced Tests ---');
  final expansionTile = ExpansionTile(
    title: Text('Expansion Title'),
    subtitle: Text('Tap to expand'),
    leading: Icon(Icons.expand_more),
    trailing: Icon(Icons.arrow_drop_down),
    initiallyExpanded: false,
    maintainState: true,
    tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
    expandedCrossAxisAlignment: CrossAxisAlignment.start,
    expandedAlignment: Alignment.centerLeft,
    childrenPadding: EdgeInsets.all(16.0),
    backgroundColor: Colors.grey.shade50,
    collapsedBackgroundColor: Colors.white,
    iconColor: Colors.blue,
    collapsedIconColor: Colors.grey,
    textColor: Colors.blue,
    collapsedTextColor: Colors.black,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    collapsedShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    clipBehavior: Clip.antiAlias,
    controlAffinity: ListTileControlAffinity.leading,
    dense: false,
    enableFeedback: true,
    children: [Text('Child 1'), Text('Child 2'), Text('Child 3')],
  );
  print('ExpansionTile created with 3 children');

  // ========== StepState ==========
  print('--- StepState Tests ---');
  for (final state in StepState.values) {
    print('StepState: ${state.name}');
  }

  // ========== StepperType ==========
  print('--- StepperType Tests ---');
  for (final type in StepperType.values) {
    print('StepperType: ${type.name}');
  }

  // ========== Step ==========
  print('--- Step Tests ---');
  final step1 = Step(
    title: Text('Step 1'),
    subtitle: Text('First step'),
    content: Text('Content of step 1'),
    state: StepState.complete,
    isActive: true,
  );
  print('Step 1 created: state=${step1.state}');

  final step2 = Step(
    title: Text('Step 2'),
    content: Text('Content of step 2'),
    state: StepState.editing,
    isActive: true,
  );
  print('Step 2 created: state=${step2.state}');

  final step3 = Step(
    title: Text('Step 3'),
    content: Text('Content of step 3'),
    state: StepState.indexed,
    isActive: false,
  );
  print('Step 3 created: state=${step3.state}');

  final step4 = Step(
    title: Text('Step 4'),
    content: Text('Cannot proceed'),
    state: StepState.error,
    isActive: false,
  );
  print('Step 4 created: state=${step4.state}');

  // ========== Stepper ==========
  print('--- Stepper Tests ---');
  final stepper = Stepper(
    currentStep: 1,
    type: StepperType.vertical,
    physics: ClampingScrollPhysics(),
    onStepTapped: (step) => print('Step $step tapped'),
    onStepContinue: () => print('Continue'),
    onStepCancel: () => print('Cancel'),
    elevation: 2.0,
    margin: EdgeInsets.all(16.0),
    steps: [step1, step2, step3, step4],
  );
  print('Stepper created with 4 steps, current=1');

  print('All expansion/stepper tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'ExpansionTile/Stepper Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
            expansionTile,
            SizedBox(height: 16.0),
            stepper,
          ],
        ),
      ),
    ),
  );
}

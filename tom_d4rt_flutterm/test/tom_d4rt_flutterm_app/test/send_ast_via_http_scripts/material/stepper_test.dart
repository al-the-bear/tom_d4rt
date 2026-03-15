// D4rt test script: Tests Stepper, Step, StepState from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Stepper widgets test executing');

  // ========== STEP ==========
  print('--- Step Tests ---');

  // Note: Step must be used within Stepper

  // Test basic Step
  final basicSteps = [
    Step(title: Text('Step 1'), content: Text('Content for step 1')),
    Step(title: Text('Step 2'), content: Text('Content for step 2')),
    Step(title: Text('Step 3'), content: Text('Content for step 3')),
  ];
  print('Basic Steps created');

  // Test Step with subtitle
  final subtitleSteps = [
    Step(
      title: Text('Account'),
      subtitle: Text('Enter your details'),
      content: TextField(decoration: InputDecoration(labelText: 'Email')),
    ),
    Step(
      title: Text('Address'),
      subtitle: Text('Where do you live?'),
      content: TextField(decoration: InputDecoration(labelText: 'Address')),
    ),
    Step(
      title: Text('Confirm'),
      subtitle: Text('Review your info'),
      content: Text('All done!'),
    ),
  ];
  print('Steps with subtitle created');

  // Test Step with isActive
  final activeSteps = [
    Step(title: Text('Step 1'), isActive: true, content: Text('Active step')),
    Step(
      title: Text('Step 2'),
      isActive: false,
      content: Text('Inactive step'),
    ),
  ];
  print('Steps with isActive created');

  // Test Step with state
  final stateSteps = [
    Step(
      title: Text('Complete'),
      state: StepState.complete,
      content: Text('This step is complete'),
    ),
    Step(
      title: Text('Editing'),
      state: StepState.editing,
      content: Text('Currently editing this'),
    ),
    Step(
      title: Text('Indexed'),
      state: StepState.indexed,
      content: Text('Shows number'),
    ),
    Step(
      title: Text('Disabled'),
      state: StepState.disabled,
      content: Text('Cannot interact'),
    ),
    Step(
      title: Text('Error'),
      state: StepState.error,
      content: Text('Has an error'),
    ),
  ];
  print('Steps with various states created');

  // Test Step with label
  final labelSteps = [
    Step(
      title: Text('Select campaign settings'),
      label: Text('Step 1'),
      content: Text('Campaign settings content'),
    ),
    Step(
      title: Text('Create an ad group'),
      label: Text('Step 2'),
      content: Text('Ad group content'),
    ),
  ];
  print('Steps with label created');

  // ========== STEPPER ==========
  print('--- Stepper Tests ---');

  // Test vertical Stepper (default)
  final verticalStepper = Stepper(
    currentStep: 0,
    steps: basicSteps,
    onStepTapped: (int index) {
      print('Step tapped: $index');
    },
    onStepContinue: () {
      print('Continue pressed');
    },
    onStepCancel: () {
      print('Cancel pressed');
    },
  );
  print('Vertical Stepper created');

  // Test horizontal Stepper
  final horizontalStepper = Stepper(
    type: StepperType.horizontal,
    currentStep: 1,
    steps: [
      Step(title: Text('Step 1'), content: Text('First')),
      Step(title: Text('Step 2'), content: Text('Second')),
      Step(title: Text('Step 3'), content: Text('Third')),
    ],
    onStepTapped: (index) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );
  print('Horizontal Stepper created');

  // Test Stepper with physics
  final physicsStepper = Stepper(
    physics: ClampingScrollPhysics(),
    currentStep: 0,
    steps: basicSteps,
  );
  print('Stepper with physics created');

  // Test Stepper with elevation
  final elevatedStepper = Stepper(
    elevation: 8.0,
    currentStep: 0,
    steps: basicSteps,
  );
  print('Stepper with elevation created');

  // Test Stepper with margin
  final marginStepper = Stepper(
    margin: EdgeInsets.all(24.0),
    currentStep: 0,
    steps: basicSteps,
  );
  print('Stepper with margin created');

  // Test Stepper with controlsBuilder
  final customControlsStepper = Stepper(
    currentStep: 0,
    steps: basicSteps,
    controlsBuilder: (BuildContext context, ControlsDetails details) {
      return Row(
        children: [
          ElevatedButton(
            onPressed: details.onStepContinue,
            child: Text('Next'),
          ),
          SizedBox(width: 8),
          TextButton(onPressed: details.onStepCancel, child: Text('Back')),
        ],
      );
    },
  );
  print('Stepper with controlsBuilder created');

  // Test Stepper with stepIconBuilder
  final iconBuilderStepper = Stepper(
    currentStep: 0,
    steps: basicSteps,
    stepIconBuilder: (int stepIndex, StepState stepState) {
      if (stepState == StepState.complete) {
        return Icon(Icons.check_circle, color: Colors.green);
      }
      if (stepState == StepState.error) {
        return Icon(Icons.error, color: Colors.red);
      }
      return null; // Use default
    },
  );
  print('Stepper with stepIconBuilder created');

  // Test Stepper with connectorColor
  final connectorColorStepper = Stepper(
    currentStep: 0,
    connectorColor: MaterialStateProperty.all(Colors.purple),
    steps: basicSteps,
  );
  print('Stepper with connectorColor created');

  // Test Stepper with connectorThickness
  final connectorThicknessStepper = Stepper(
    currentStep: 0,
    connectorThickness: 3.0,
    steps: basicSteps,
  );
  print('Stepper with connectorThickness created');

  // Test Stepper with stepIconHeight and stepIconWidth
  final iconSizeStepper = Stepper(
    currentStep: 0,
    stepIconHeight: 40.0,
    stepIconWidth: 40.0,
    steps: basicSteps,
  );
  print('Stepper with stepIconHeight/Width created');

  // Test Stepper with stepIconMargin
  final iconMarginStepper = Stepper(
    currentStep: 0,
    stepIconMargin: EdgeInsets.all(8.0),
    steps: basicSteps,
  );
  print('Stepper with stepIconMargin created');

  // Demo Stepper with all step states
  final allStatesStepper = Stepper(
    currentStep: 1,
    steps: stateSteps,
    onStepTapped: (index) {},
    onStepContinue: () {},
    onStepCancel: () {},
  );
  print('Stepper with all step states created');

  print('Stepper widgets test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stepper Widgets Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'Vertical Stepper (default):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: verticalStepper,
        ),

        SizedBox(height: 24.0),
        Text(
          'Horizontal Stepper:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: horizontalStepper,
        ),

        SizedBox(height: 24.0),
        Text(
          'Step States Demo:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          '(Complete, Editing, Indexed, Disabled, Error)',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 500,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: allStatesStepper,
        ),

        SizedBox(height: 24.0),
        Text(
          'Custom Controls Stepper:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: customControlsStepper,
        ),

        SizedBox(height: 24.0),
        Text(
          'Stepper with Subtitles:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stepper(
            currentStep: 0,
            steps: subtitleSteps,
            onStepTapped: (index) {},
            onStepContinue: () {},
            onStepCancel: () {},
          ),
        ),
      ],
    ),
  );
}

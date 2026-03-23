// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Stepper, Step, StepState from material
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
  print('Steps with isActive created: $activeSteps');

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
  print('Steps with various states created: $stateSteps');

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
  print('Steps with label created: $labelSteps');

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
  print('Stepper with physics created: $physicsStepper');

  // Test Stepper with elevation
  final elevatedStepper = Stepper(
    elevation: 8.0,
    currentStep: 0,
    steps: basicSteps,
  );
  print('Stepper with elevation created: $elevatedStepper');

  // Test Stepper with margin
  final marginStepper = Stepper(
    margin: EdgeInsets.all(24.0),
    currentStep: 0,
    steps: basicSteps,
  );
  print('Stepper with margin created: $marginStepper');

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
  print('Stepper with stepIconBuilder created: $iconBuilderStepper');

  // Test Stepper with connectorColor
  final connectorColorStepper = Stepper(
    currentStep: 0,
    connectorColor: MaterialStateProperty.all(Colors.purple),
    steps: basicSteps,
  );
  print('Stepper with connectorColor created: $connectorColorStepper');

  // Test Stepper with connectorThickness
  final connectorThicknessStepper = Stepper(
    currentStep: 0,
    connectorThickness: 3.0,
    steps: basicSteps,
  );
  print('Stepper with connectorThickness created: $connectorThicknessStepper');

  // Test Stepper with stepIconHeight and stepIconWidth
  final iconSizeStepper = Stepper(
    currentStep: 0,
    stepIconHeight: 40.0,
    stepIconWidth: 40.0,
    steps: basicSteps,
  );
  print('Stepper with stepIconHeight/Width created: $iconSizeStepper');

  // Test Stepper with stepIconMargin
  final iconMarginStepper = Stepper(
    currentStep: 0,
    stepIconMargin: EdgeInsets.all(8.0),
    steps: basicSteps,
  );
  print('Stepper with stepIconMargin created: $iconMarginStepper');

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

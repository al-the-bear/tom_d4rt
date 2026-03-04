// D4rt test script: Tests ExpansionTile advanced, Stepper, Step,
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

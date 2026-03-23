// ignore_for_file: avoid_print
// D4rt test script: Tests ControlsDetails from material
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(top: 20, bottom: 10),
    decoration: BoxDecoration(
      color: Color(0xFF00695C),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      ),
    ),
  );
}

// Helper to build a demo card
Widget buildDemoCard(String label, Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 12),
        child,
      ],
    ),
  );
}

// Helper: info row
Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Color(0xFF616161),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: Color(0xFF212121)),
          ),
        ),
      ],
    ),
  );
}

// Helper: build a step indicator circle
Widget buildStepCircle(int number, bool isActive, bool isCompleted) {
  Color bgColor = isCompleted
      ? Color(0xFF4CAF50)
      : isActive
      ? Color(0xFF1976D2)
      : Color(0xFFBDBDBD);
  return Container(
    width: 36,
    height: 36,
    decoration: BoxDecoration(
      color: bgColor,
      shape: BoxShape.circle,
      boxShadow: isActive
          ? [
              BoxShadow(
                color: Color(0x4D1976D2),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ]
          : [],
    ),
    child: Center(
      child: isCompleted
          ? Icon(Icons.check, color: Color(0xFFFFFFFF), size: 20)
          : Text(
              number.toString(),
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
    ),
  );
}

// Helper: build a step line connector
Widget buildStepConnector(bool isCompleted) {
  return Container(
    width: 40,
    height: 3,
    color: isCompleted ? Color(0xFF4CAF50) : Color(0xFFBDBDBD),
  );
}

// Helper: horizontal stepper visualization
Widget buildHorizontalStepper(
  int currentStep,
  int totalSteps,
  List<String> labels,
) {
  List<Widget> children = [];
  for (int i = 0; i < totalSteps; i++) {
    bool isCompleted = i < currentStep;
    bool isActive = i == currentStep;
    children.add(
      Column(
        children: [
          buildStepCircle(i + 1, isActive, isCompleted),
          SizedBox(height: 4),
          Text(
            i < labels.length ? labels[i] : 'Step ${i + 1}',
            style: TextStyle(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? Color(0xFF1976D2) : Color(0xFF757575),
            ),
          ),
        ],
      ),
    );
    if (i < totalSteps - 1) {
      children.add(
        Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: buildStepConnector(isCompleted),
        ),
      );
    }
  }
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
}

// Helper: vertical step item
Widget buildVerticalStepItem(
  int number,
  String title,
  String subtitle,
  bool isActive,
  bool isCompleted,
  bool isLast,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          buildStepCircle(number, isActive, isCompleted),
          if (!isLast)
            Container(
              width: 3,
              height: 50,
              color: isCompleted ? Color(0xFF4CAF50) : Color(0xFFBDBDBD),
            ),
        ],
      ),
      SizedBox(width: 12),
      Expanded(
        child: Container(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive ? Color(0xFF1976D2) : Color(0xFF424242),
                ),
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
              ),
              if (isActive) ...[
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFFE0E0E0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Step content area',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF616161),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              debugPrint('Continue from step $number');
                            },
                            child: Text('Continue'),
                          ),
                          SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              debugPrint('Cancel at step $number');
                            },
                            child: Text('Cancel'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    ],
  );
}

// Helper: controls details info display
Widget buildControlsDetailsDisplay(
  int currentStep,
  int stepIndex,
  bool hasContinue,
  bool hasCancel,
) {
  return Container(
    padding: EdgeInsets.all(12),
    margin: EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: currentStep == stepIndex
                    ? Color(0xFF1976D2)
                    : Color(0xFF757575),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Step $stepIndex',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8),
            if (currentStep == stepIndex)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'ACTIVE',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (stepIndex < currentStep)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFF00796B),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'COMPLETED',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (stepIndex > currentStep)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFBDBDBD),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'PENDING',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8),
        buildInfoRow('currentStep', currentStep.toString()),
        buildInfoRow('stepIndex', stepIndex.toString()),
        buildInfoRow('onStepContinue', hasContinue ? 'available' : 'null'),
        buildInfoRow('onStepCancel', hasCancel ? 'available' : 'null'),
        SizedBox(height: 8),
        Row(
          children: [
            if (hasContinue)
              ElevatedButton(
                onPressed: () {
                  debugPrint('ControlsDetails: Continue from step $stepIndex');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1976D2),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            if (hasContinue) SizedBox(width: 8),
            if (hasCancel)
              OutlinedButton(
                onPressed: () {
                  debugPrint('ControlsDetails: Cancel at step $stepIndex');
                },
                child: Text('Cancel'),
              ),
          ],
        ),
      ],
    ),
  );
}

// Helper: build a step state icon
Widget buildStepStateIcon(
  String state,
  String label,
  IconData iconData,
  Color color,
) {
  return Column(
    children: [
      Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(iconData, color: Color(0xFFFFFFFF), size: 24),
      ),
      SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
    ],
  );
}

// Helper: build step progress bar
Widget buildStepProgressBar(int currentStep, int totalSteps) {
  double progress = totalSteps > 0 ? (currentStep / totalSteps) : 0.0;
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Step ${currentStep + 1} of $totalSteps',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          Text(
            '${(progress * 100).toInt()}%',
            style: TextStyle(fontSize: 13, color: Color(0xFF757575)),
          ),
        ],
      ),
      SizedBox(height: 6),
      Container(
        height: 8,
        decoration: BoxDecoration(
          color: Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(4),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: progress,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1976D2),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    ],
  );
}

// Helper: matrix row
Widget buildMatrixRow(
  String position,
  bool hasContinue,
  bool hasCancel,
  String state,
  Color bgColor,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: bgColor,
      border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(position, style: TextStyle(fontSize: 12)),
        ),
        Expanded(
          flex: 2,
          child: Icon(
            hasContinue ? Icons.check_circle : Icons.cancel,
            color: hasContinue ? Color(0xFF4CAF50) : Color(0xFFBDBDBD),
            size: 18,
          ),
        ),
        Expanded(
          flex: 2,
          child: Icon(
            hasCancel ? Icons.check_circle : Icons.cancel,
            color: hasCancel ? Color(0xFF4CAF50) : Color(0xFFBDBDBD),
            size: 18,
          ),
        ),
        Expanded(flex: 2, child: Text(state, style: TextStyle(fontSize: 12))),
      ],
    ),
  );
}

// Helper: error step item
Widget buildErrorStepItem(
  int step,
  String title,
  bool hasError,
  String message,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: hasError ? Color(0xFFFFEBEE) : Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: hasError ? Color(0xFFEF9A9A) : Color(0xFFE0E0E0),
        width: 1,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: hasError ? Color(0xFFD32F2F) : Color(0xFF4CAF50),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: hasError
                ? Icon(Icons.error, color: Color(0xFFFFFFFF), size: 18)
                : Icon(Icons.check, color: Color(0xFFFFFFFF), size: 18),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Step $step: $title',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: hasError ? Color(0xFFC62828) : Color(0xFF424242),
                ),
              ),
              Text(
                message,
                style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper: dot stepper
Widget buildDotStepper(int current, int total) {
  List<Widget> dots = [];
  for (int i = 0; i < total; i++) {
    dots.add(
      Container(
        width: i == current ? 24.0 : 10.0,
        height: 10,
        margin: EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: i == current
              ? Color(0xFF1976D2)
              : i < current
              ? Color(0xFF4CAF50)
              : Color(0xFFBDBDBD),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: dots);
}

dynamic build(BuildContext context) {
  debugPrint('=== ControlsDetails Deep Demo ===');
  debugPrint('Testing stepper controls, step states, and ControlsDetails data');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('ControlsDetails Deep Demo'),
        backgroundColor: Color(0xFF00695C),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: ControlsDetails Properties
            buildSectionHeader('1. ControlsDetails Properties'),
            buildDemoCard(
              'ControlsDetails provides data about stepper state',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow(
                    'currentStep',
                    'The index of the currently active step',
                  ),
                  buildInfoRow(
                    'stepIndex',
                    'The index of the step this control belongs to',
                  ),
                  buildInfoRow(
                    'onStepContinue',
                    'Callback when user taps continue',
                  ),
                  buildInfoRow(
                    'onStepCancel',
                    'Callback when user taps cancel',
                  ),
                ],
              ),
            ),
            Text(
              'Section 1: ControlsDetails properties displayed',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 2: Step States
            buildSectionHeader('2. Step States'),
            buildDemoCard(
              'StepState visual representations',
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildStepStateIcon(
                    'indexed',
                    'indexed',
                    Icons.looks_one,
                    Color(0xFF1976D2),
                  ),
                  buildStepStateIcon(
                    'editing',
                    'editing',
                    Icons.edit,
                    Color(0xFFF57C00),
                  ),
                  buildStepStateIcon(
                    'complete',
                    'complete',
                    Icons.check_circle,
                    Color(0xFF4CAF50),
                  ),
                  buildStepStateIcon(
                    'disabled',
                    'disabled',
                    Icons.block,
                    Color(0xFFBDBDBD),
                  ),
                  buildStepStateIcon(
                    'error',
                    'error',
                    Icons.error,
                    Color(0xFFD32F2F),
                  ),
                ],
              ),
            ),
            Text(
              'Section 2: Step states rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 3: Horizontal Stepper Visualization
            buildSectionHeader('3. Horizontal Stepper Visualizations'),
            buildDemoCard(
              'Step 1 Active (of 4)',
              buildHorizontalStepper(0, 4, [
                'Account',
                'Details',
                'Review',
                'Submit',
              ]),
            ),
            buildDemoCard(
              'Step 2 Active (of 4)',
              buildHorizontalStepper(1, 4, [
                'Account',
                'Details',
                'Review',
                'Submit',
              ]),
            ),
            buildDemoCard(
              'Step 3 Active (of 4)',
              buildHorizontalStepper(2, 4, [
                'Account',
                'Details',
                'Review',
                'Submit',
              ]),
            ),
            buildDemoCard(
              'Step 4 Active (of 4)',
              buildHorizontalStepper(3, 4, [
                'Account',
                'Details',
                'Review',
                'Submit',
              ]),
            ),
            Text(
              'Section 3: Horizontal steppers rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 4: ControlsDetails for Each Step
            buildSectionHeader('4. ControlsDetails Per Step'),
            buildDemoCard(
              'Controls details when currentStep = 1',
              Column(
                children: [
                  buildControlsDetailsDisplay(1, 0, true, false),
                  buildControlsDetailsDisplay(1, 1, true, true),
                  buildControlsDetailsDisplay(1, 2, true, true),
                  buildControlsDetailsDisplay(1, 3, false, true),
                ],
              ),
            ),
            Text(
              'Section 4: ControlsDetails per step rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 5: Vertical Stepper
            buildSectionHeader('5. Vertical Stepper Visualization'),
            buildDemoCard(
              'Form wizard - step 2 active',
              Column(
                children: [
                  buildVerticalStepItem(
                    1,
                    'Personal Info',
                    'Name, email, phone',
                    false,
                    true,
                    false,
                  ),
                  buildVerticalStepItem(
                    2,
                    'Address',
                    'Street, city, zip code',
                    true,
                    false,
                    false,
                  ),
                  buildVerticalStepItem(
                    3,
                    'Payment',
                    'Card number, expiry',
                    false,
                    false,
                    false,
                  ),
                  buildVerticalStepItem(
                    4,
                    'Confirmation',
                    'Review and submit',
                    false,
                    false,
                    true,
                  ),
                ],
              ),
            ),
            Text(
              'Section 5: Vertical stepper rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 6: Step Progress Bars
            buildSectionHeader('6. Step Progress Indicators'),
            buildDemoCard(
              'Progress bars at various steps',
              Column(
                children: [
                  buildStepProgressBar(0, 5),
                  SizedBox(height: 16),
                  buildStepProgressBar(1, 5),
                  SizedBox(height: 16),
                  buildStepProgressBar(2, 5),
                  SizedBox(height: 16),
                  buildStepProgressBar(3, 5),
                  SizedBox(height: 16),
                  buildStepProgressBar(4, 5),
                ],
              ),
            ),
            Text(
              'Section 6: Progress bars rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 7: Controls Availability Matrix
            buildSectionHeader('7. Controls Availability Matrix'),
            buildDemoCard(
              'Which controls are available at each step position',
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Color(0xFF37474F),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Position',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'State',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildMatrixRow(
                    'First step',
                    true,
                    false,
                    'Active',
                    Color(0xFFE3F2FD),
                  ),
                  buildMatrixRow(
                    'Middle step',
                    true,
                    true,
                    'Active',
                    Color(0xFFFFFFFF),
                  ),
                  buildMatrixRow(
                    'Last step',
                    false,
                    true,
                    'Active',
                    Color(0xFFE3F2FD),
                  ),
                  buildMatrixRow(
                    'Completed',
                    true,
                    true,
                    'Done',
                    Color(0xFFFFFFFF),
                  ),
                  buildMatrixRow(
                    'Disabled',
                    false,
                    false,
                    'Disabled',
                    Color(0xFFE3F2FD),
                  ),
                  buildMatrixRow(
                    'Error step',
                    true,
                    true,
                    'Error',
                    Color(0xFFFFFFFF),
                  ),
                ],
              ),
            ),
            Text(
              'Section 7: Controls availability matrix rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 8: Different Stepper Types
            buildSectionHeader('8. Stepper Types'),
            buildDemoCard(
              'StepperType.vertical',
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    buildVerticalStepItem(
                      1,
                      'Select Product',
                      'Choose from catalog',
                      false,
                      true,
                      false,
                    ),
                    buildVerticalStepItem(
                      2,
                      'Configure',
                      'Set options and preferences',
                      true,
                      false,
                      false,
                    ),
                    buildVerticalStepItem(
                      3,
                      'Checkout',
                      'Review and pay',
                      false,
                      false,
                      true,
                    ),
                  ],
                ),
              ),
            ),
            buildDemoCard(
              'StepperType.horizontal',
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: buildHorizontalStepper(1, 3, [
                  'Select',
                  'Configure',
                  'Checkout',
                ]),
              ),
            ),
            Text(
              'Section 8: Stepper types rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 9: Multi-Phase Process
            buildSectionHeader('9. Multi-Phase Process'),
            buildDemoCard(
              'Build and Deploy Pipeline (5 steps)',
              Column(
                children: [
                  buildHorizontalStepper(2, 5, [
                    'Code',
                    'Build',
                    'Test',
                    'Stage',
                    'Deploy',
                  ]),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Phase: Test',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1565C0),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Running automated test suite...',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF616161),
                          ),
                        ),
                        SizedBox(height: 8),
                        buildStepProgressBar(2, 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Section 9: Multi-phase process rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 10: Step Error Handling
            buildSectionHeader('10. Step Error Handling'),
            buildDemoCard(
              'Steps with error states',
              Column(
                children: [
                  buildErrorStepItem(1, 'Validate Input', false, 'Passed'),
                  buildErrorStepItem(
                    2,
                    'Check Dependencies',
                    true,
                    'Missing package: flutter_svg',
                  ),
                  buildErrorStepItem(3, 'Run Tests', false, 'Waiting'),
                  buildErrorStepItem(4, 'Deploy', false, 'Waiting'),
                ],
              ),
            ),
            Text(
              'Section 10: Error handling rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 11: Compact Stepper
            buildSectionHeader('11. Compact Stepper Indicator'),
            buildDemoCard(
              'Dot-style step indicators',
              Column(
                children: [
                  buildDotStepper(0, 6),
                  SizedBox(height: 12),
                  buildDotStepper(2, 6),
                  SizedBox(height: 12),
                  buildDotStepper(4, 6),
                  SizedBox(height: 12),
                  buildDotStepper(5, 6),
                ],
              ),
            ),
            Text(
              'Section 11: Compact stepper rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Summary
            buildSectionHeader('Summary'),
            buildDemoCard(
              'ControlsDetails Features Demonstrated',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('1', 'ControlsDetails property descriptions'),
                  buildInfoRow('2', 'All five StepState visuals'),
                  buildInfoRow('3', 'Horizontal steppers at each position'),
                  buildInfoRow('4', 'ControlsDetails per step with actions'),
                  buildInfoRow('5', 'Vertical stepper with content areas'),
                  buildInfoRow('6', 'Step progress bar indicators'),
                  buildInfoRow('7', 'Controls availability matrix'),
                  buildInfoRow('8', 'Vertical vs horizontal stepper types'),
                  buildInfoRow('9', 'Multi-phase pipeline visualization'),
                  buildInfoRow('10', 'Error state handling in steps'),
                  buildInfoRow('11', 'Compact dot-style indicators'),
                ],
              ),
            ),
            Text(
              '=== ControlsDetails Deep Demo Complete ===',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

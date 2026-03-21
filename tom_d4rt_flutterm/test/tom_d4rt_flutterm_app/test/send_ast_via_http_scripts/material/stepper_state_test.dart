// D4rt test script: Tests StepperState from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildStepperOverview() {
  print('Building stepper overview section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.format_list_numbered,
                color: Colors.indigo.shade700,
                size: 32,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stepper Widget',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Multi-step process indicator',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'StepperState manages the internal state of a Stepper widget, including step animations, expansion, and navigation. It tracks which step is currently active and handles state transitions when users interact with steps.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildFeatureChip('Step Navigation', Colors.blue),
            _buildFeatureChip('Step Animation', Colors.green),
            _buildFeatureChip('Vertical/Horizontal', Colors.orange),
            _buildFeatureChip('Custom Controls', Colors.purple),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFeatureChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    ),
  );
}

Widget buildBasicStepperDemo() {
  print('Building basic stepper demo');
  List<Step> steps = [
    Step(
      title: Text('Account'),
      subtitle: Text('Enter credentials'),
      content: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create your account with email and password',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
          ],
        ),
      ),
      isActive: true,
      state: StepState.complete,
    ),
    Step(
      title: Text('Profile'),
      subtitle: Text('Personal info'),
      content: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fill in your profile details',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ],
        ),
      ),
      isActive: true,
      state: StepState.editing,
    ),
    Step(
      title: Text('Confirm'),
      subtitle: Text('Review details'),
      content: Container(
        padding: EdgeInsets.all(16),
        child: Text(
          'Review and confirm your information',
          style: TextStyle(fontSize: 14),
        ),
      ),
      isActive: false,
      state: StepState.indexed,
    ),
  ];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.checklist, color: Colors.indigo.shade700),
              SizedBox(width: 8),
              Text(
                'Basic Vertical Stepper',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
            ],
          ),
        ),
        Stepper(
          currentStep: 1,
          steps: steps,
          type: StepperType.vertical,
          onStepContinue: () {},
          onStepCancel: () {},
          onStepTapped: (int step) {},
        ),
      ],
    ),
  );
}

Widget buildStepsListDemo() {
  print('Building steps list demo');
  List<Map<String, dynamic>> stepConfigs = [
    {
      'title': 'Shipping',
      'icon': Icons.local_shipping,
      'state': StepState.complete,
      'color': Colors.green,
    },
    {
      'title': 'Payment',
      'icon': Icons.payment,
      'state': StepState.editing,
      'color': Colors.blue,
    },
    {
      'title': 'Review',
      'icon': Icons.rate_review,
      'state': StepState.indexed,
      'color': Colors.orange,
    },
    {
      'title': 'Confirm',
      'icon': Icons.check_circle,
      'state': StepState.disabled,
      'color': Colors.grey,
    },
  ];

  List<Widget> stepCards = [];
  int idx = 0;
  for (idx = 0; idx < stepConfigs.length; idx = idx + 1) {
    Map<String, dynamic> cfg = stepConfigs[idx];
    Color c = cfg['color'] as Color;
    stepCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: c.withAlpha(15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: c.withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: c.withAlpha(40),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${idx + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: c,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cfg['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'State: ${(cfg['state'] as StepState).toString().split('.').last}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(cfg['icon'] as IconData, color: c, size: 24),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Steps List Configuration',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Each step has title, subtitle, content, state, and isActive properties',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: stepCards),
      ],
    ),
  );
}

Widget buildCurrentStepDemo() {
  print('Building current step demo');
  List<int> stepIndices = [0, 1, 2];
  List<String> stepLabels = ['First Step Active', 'Second Step Active', 'Third Step Active'];
  List<MaterialColor> stepColors = [Colors.indigo, Colors.teal, Colors.orange];

  List<Widget> demos = [];
  int i = 0;
  for (i = 0; i < stepIndices.length; i = i + 1) {
    int currentIdx = stepIndices[i];
    MaterialColor c = stepColors[i];

    List<Step> stepsForDemo = [
      Step(
        title: Text('Step 1'),
        content: Container(
          height: 40,
          color: Colors.grey.shade100,
          child: Center(child: Text('Content 1')),
        ),
        isActive: currentIdx >= 0,
        state: currentIdx > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Step 2'),
        content: Container(
          height: 40,
          color: Colors.grey.shade100,
          child: Center(child: Text('Content 2')),
        ),
        isActive: currentIdx >= 1,
        state: currentIdx > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text('Step 3'),
        content: Container(
          height: 40,
          color: Colors.grey.shade100,
          child: Center(child: Text('Content 3')),
        ),
        isActive: currentIdx >= 2,
        state: StepState.indexed,
      ),
    ];

    demos.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: c.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: c.shade50,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: c.shade700,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${currentIdx + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    stepLabels[i],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: c.shade800,
                    ),
                  ),
                ],
              ),
            ),
            Stepper(
              currentStep: currentIdx,
              steps: stepsForDemo,
              type: StepperType.horizontal,
              onStepContinue: () {},
              onStepCancel: () {},
            ),
          ],
        ),
      ),
    );
  }

  return Column(children: demos);
}

Widget buildStepperTypeDemo() {
  print('Building stepper type demo');

  List<Step> horizontalSteps = [
    Step(
      title: Text('Select'),
      content: Container(
        height: 50,
        child: Center(
          child: Text('Choose your preferences'),
        ),
      ),
      isActive: true,
      state: StepState.complete,
    ),
    Step(
      title: Text('Configure'),
      content: Container(
        height: 50,
        child: Center(
          child: Text('Set up your options'),
        ),
      ),
      isActive: true,
      state: StepState.editing,
    ),
    Step(
      title: Text('Finish'),
      content: Container(
        height: 50,
        child: Center(
          child: Text('Complete setup'),
        ),
      ),
      isActive: false,
    ),
  ];

  List<Step> verticalSteps = [
    Step(
      title: Text('Create Account'),
      subtitle: Text('Set up credentials'),
      content: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter username and password'),
            SizedBox(height: 8),
            Container(
              height: 40,
              color: Colors.grey.shade200,
              child: Center(child: Text('Form fields here')),
            ),
          ],
        ),
      ),
      isActive: true,
      state: StepState.complete,
    ),
    Step(
      title: Text('Verify Email'),
      subtitle: Text('Confirm your address'),
      content: Container(
        padding: EdgeInsets.all(12),
        child: Text('Check your inbox for verification code'),
      ),
      isActive: true,
      state: StepState.editing,
    ),
    Step(
      title: Text('Complete Profile'),
      subtitle: Text('Add personal details'),
      content: Container(
        padding: EdgeInsets.all(12),
        child: Text('Fill in your profile information'),
      ),
    ),
  ];

  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.swap_horiz, color: Colors.blue.shade700),
                  SizedBox(width: 8),
                  Text(
                    'StepperType.horizontal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            ),
            Stepper(
              currentStep: 1,
              steps: horizontalSteps,
              type: StepperType.horizontal,
              onStepContinue: () {},
              onStepCancel: () {},
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.swap_vert, color: Colors.green.shade700),
                  SizedBox(width: 8),
                  Text(
                    'StepperType.vertical',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
            ),
            Stepper(
              currentStep: 1,
              steps: verticalSteps,
              type: StepperType.vertical,
              onStepContinue: () {},
              onStepCancel: () {},
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildCallbacksDemo() {
  print('Building callbacks demo');

  List<Map<String, dynamic>> callbacks = [
    {
      'name': 'onStepContinue',
      'description': 'Called when Continue button is pressed',
      'signature': 'VoidCallback?',
      'icon': Icons.arrow_forward,
      'color': Colors.green,
    },
    {
      'name': 'onStepCancel',
      'description': 'Called when Cancel button is pressed',
      'signature': 'VoidCallback?',
      'icon': Icons.arrow_back,
      'color': Colors.red,
    },
    {
      'name': 'onStepTapped',
      'description': 'Called when a step header is tapped',
      'signature': 'ValueChanged<int>?',
      'icon': Icons.touch_app,
      'color': Colors.blue,
    },
  ];

  List<Widget> callbackCards = [];
  int c = 0;
  for (c = 0; c < callbacks.length; c = c + 1) {
    Map<String, dynamic> cb = callbacks[c];
    Color clr = cb['color'] as Color;
    callbackCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: clr.withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: clr.withAlpha(60)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: clr.withAlpha(40),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(cb['icon'] as IconData, color: clr, size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cb['name'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: clr,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    cb['signature'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    cb['description'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Navigation Callbacks',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Handle step navigation in your widget state',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: callbackCards),
      ],
    ),
  );
}

Widget buildControlsBuilderDemo() {
  print('Building controls builder demo');

  List<Step> customSteps = [
    Step(
      title: Text('Setup'),
      content: Container(
        padding: EdgeInsets.all(12),
        child: Text('Configure initial settings'),
      ),
      isActive: true,
      state: StepState.complete,
    ),
    Step(
      title: Text('Customize'),
      content: Container(
        padding: EdgeInsets.all(12),
        child: Text('Personalize your experience'),
      ),
      isActive: true,
      state: StepState.editing,
    ),
    Step(
      title: Text('Launch'),
      content: Container(
        padding: EdgeInsets.all(12),
        child: Text('Start using the app'),
      ),
    ),
  ];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Custom Controls Builder',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Use controlsBuilder to customize step buttons',
                style: TextStyle(fontSize: 13, color: Colors.purple.shade600),
              ),
            ],
          ),
        ),
        Stepper(
          currentStep: 1,
          steps: customSteps,
          type: StepperType.vertical,
          onStepContinue: () {},
          onStepCancel: () {},
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Container(
              margin: EdgeInsets.only(top: 12),
              child: Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: details.onStepContinue,
                    icon: Icon(Icons.arrow_forward, size: 18),
                    label: Text('Next'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade600,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                  SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: details.onStepCancel,
                    icon: Icon(Icons.arrow_back, size: 18),
                    label: Text('Back'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.purple.shade600,
                      side: BorderSide(color: Colors.purple.shade300),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ControlsDetails parameters:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                SizedBox(height: 8),
                _buildCodeLine('currentStep', 'int'),
                _buildCodeLine('stepIndex', 'int'),
                _buildCodeLine('onStepContinue', 'VoidCallback?'),
                _buildCodeLine('onStepCancel', 'VoidCallback?'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeLine(String name, String type) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Colors.purple.shade700,
          ),
        ),
        Text(
          ': ',
          style: TextStyle(fontSize: 12),
        ),
        Text(
          type,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Colors.blue.shade700,
          ),
        ),
      ],
    ),
  );
}

Widget buildConnectorColorDemo() {
  print('Building connector color demo');

  List<Color> connectorColors = [
    Colors.indigo,
    Colors.teal,
    Colors.orange,
    Colors.pink,
  ];
  List<String> colorNames = ['Indigo', 'Teal', 'Orange', 'Pink'];

  List<Widget> connectorDemos = [];
  int j = 0;
  for (j = 0; j < connectorColors.length; j = j + 1) {
    Color cc = connectorColors[j];
    connectorDemos.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cc.withAlpha(100)),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: cc,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 60,
              height: 3,
              color: cc,
            ),
            SizedBox(width: 8),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: cc.withAlpha(80),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 60,
              height: 3,
              color: cc.withAlpha(80),
            ),
            SizedBox(width: 8),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: cc.withAlpha(40),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 16),
            Text(
              colorNames[j],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cc,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connector Color Options',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'connectorColor changes the color of lines between steps',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: connectorDemos),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Use WidgetStateProperty for dynamic connector colors based on step state',
                  style: TextStyle(fontSize: 12, color: Colors.amber.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildElevationDemo() {
  print('Building elevation demo');

  List<double> elevations = [0, 2, 4, 8, 12];
  List<Widget> elevationCards = [];

  int e = 0;
  for (e = 0; e < elevations.length; e = e + 1) {
    double elev = elevations[e];
    elevationCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Material(
          elevation: elev,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '${elev.toInt()}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'elevation: ${elev.toInt()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        elev == 0.0 ? 'No shadow' : 'Elevated with shadow',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${elev.toInt()}dp',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stepper Elevation',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'elevation property adds shadow depth to the stepper',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 8),
        Column(children: elevationCards),
      ],
    ),
  );
}

Widget buildStepStateGrid() {
  print('Building step state grid');
  List<Map<String, dynamic>> states = [
    {
      'state': StepState.indexed,
      'name': 'indexed',
      'description': 'Shows step number',
      'icon': Icons.format_list_numbered,
      'color': Colors.grey,
    },
    {
      'state': StepState.editing,
      'name': 'editing',
      'description': 'Shows edit icon',
      'icon': Icons.edit,
      'color': Colors.blue,
    },
    {
      'state': StepState.complete,
      'name': 'complete',
      'description': 'Shows check mark',
      'icon': Icons.check,
      'color': Colors.green,
    },
    {
      'state': StepState.disabled,
      'name': 'disabled',
      'description': 'Greyed out',
      'icon': Icons.block,
      'color': Colors.grey.shade400,
    },
    {
      'state': StepState.error,
      'name': 'error',
      'description': 'Shows exclamation',
      'icon': Icons.error,
      'color': Colors.red,
    },
  ];

  List<Widget> stateCards = [];
  int s = 0;
  for (s = 0; s < states.length; s = s + 1) {
    Map<String, dynamic> st = states[s];
    Color clr = st['color'] as Color;
    stateCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: clr.withAlpha(100)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: clr.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(st['icon'] as IconData, color: clr, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'StepState.${st['name']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    st['description'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Step States',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Each step can have one of five different states',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: stateCards),
      ],
    ),
  );
}

Widget buildUsageTips() {
  print('Building usage tips');

  List<Map<String, String>> tips = [
    {
      'title': 'Track currentStep in State',
      'content': 'Store currentStep in your StatefulWidget state and update it in callbacks',
    },
    {
      'title': 'Validate Before Continue',
      'content': 'Check form validity in onStepContinue before incrementing step',
    },
    {
      'title': 'Use Step.state Wisely',
      'content': 'Set appropriate StepState for completed, editing, or error steps',
    },
    {
      'title': 'Custom Controls for Branding',
      'content': 'Use controlsBuilder to match your app design language',
    },
    {
      'title': 'Consider Accessibility',
      'content': 'Steps support screen readers - ensure meaningful titles and subtitles',
    },
  ];

  List<Widget> tipWidgets = [];
  int t = 0;
  for (t = 0; t < tips.length; t = t + 1) {
    tipWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              margin: EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: Colors.indigo.shade700,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${t + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tips[t]['title'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    tips[t]['content'] ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tipWidgets,
    ),
  );
}

dynamic build(BuildContext context) {
  print('StepperState deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('StepperState Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Stepper Widget Overview'),
            buildStepperOverview(),
            buildInfoCard('Widget', 'Stepper'),
            buildInfoCard('State Class', 'StepperState'),
            buildInfoCard('Purpose', 'Display progress through a sequence of steps'),
            buildInfoCard('Mixin', 'TickerProviderStateMixin for animations'),

            buildSectionHeader('2. Steps List'),
            buildStepsListDemo(),
            buildStepStateGrid(),

            buildSectionHeader('3. Current Step'),
            buildInfoCard('Property', 'currentStep (int)'),
            buildInfoCard('Default', '0 (first step)'),
            buildInfoCard('Usage', 'Controls which step is expanded and active'),
            buildCurrentStepDemo(),

            buildSectionHeader('4. Type (Horizontal/Vertical)'),
            buildInfoCard('Property', 'type (StepperType)'),
            buildInfoCard('Values', 'StepperType.horizontal, StepperType.vertical'),
            buildStepperTypeDemo(),

            buildSectionHeader('5. onStepContinue'),
            buildInfoCard('Type', 'VoidCallback?'),
            buildInfoCard('Called', 'When Continue button is pressed'),
            buildInfoCard('Common Use', 'Increment currentStep after validation'),

            buildSectionHeader('6. onStepCancel'),
            buildInfoCard('Type', 'VoidCallback?'),
            buildInfoCard('Called', 'When Cancel button is pressed'),
            buildInfoCard('Common Use', 'Decrement currentStep or show confirmation'),

            buildSectionHeader('7. onStepTapped'),
            buildInfoCard('Type', 'ValueChanged<int>?'),
            buildInfoCard('Called', 'When step header circle is tapped'),
            buildInfoCard('Parameter', 'Index of the tapped step'),
            buildCallbacksDemo(),

            buildSectionHeader('8. Controls Builder'),
            buildInfoCard('Property', 'controlsBuilder'),
            buildInfoCard('Type', 'ControlsWidgetBuilder?'),
            buildInfoCard('Purpose', 'Customize Continue and Cancel buttons'),
            buildControlsBuilderDemo(),

            buildSectionHeader('9. Connector Color'),
            buildInfoCard('Property', 'connectorColor'),
            buildInfoCard('Type', 'WidgetStateProperty<Color>?'),
            buildInfoCard('Affects', 'Color of lines connecting step circles'),
            buildConnectorColorDemo(),

            buildSectionHeader('10. Elevation'),
            buildInfoCard('Property', 'elevation'),
            buildInfoCard('Type', 'double?'),
            buildInfoCard('Affects', 'Shadow depth of the stepper'),
            buildElevationDemo(),

            buildSectionHeader('Usage Tips'),
            buildUsageTips(),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('StepperState deep demo completed');
  return result;
}

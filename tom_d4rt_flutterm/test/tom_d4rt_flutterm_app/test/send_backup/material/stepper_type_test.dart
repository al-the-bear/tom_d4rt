import 'package:flutter/material.dart';

/// Deep visual demo for StepperType
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('StepperType Demo')), body: Column(children: [Expanded(child: Stepper(type: StepperType.vertical, steps: [Step(title: Text('Vertical Step 1'), content: Text('Vertical stepper content')), Step(title: Text('Vertical Step 2'), content: Text('More vertical content'))])), Divider(), Container(height: 120, child: Stepper(type: StepperType.horizontal, steps: [Step(title: Text('H1'), content: SizedBox()), Step(title: Text('H2'), content: SizedBox()), Step(title: Text('H3'), content: SizedBox())]))]));
}

import 'package:flutter/material.dart';

/// Deep visual demo for StepStyle
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('StepStyle Demo')), body: Stepper(steps: [Step(title: Text('Custom Styled Step'), subtitle: Text('With StepStyle'), content: Text('Step content here'), stepStyle: StepStyle(color: Colors.purple, indexStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))), Step(title: Text('Another Styled Step'), content: Text('More content'), stepStyle: StepStyle(color: Colors.orange, connectorColor: Colors.orange.shade200))]));
}

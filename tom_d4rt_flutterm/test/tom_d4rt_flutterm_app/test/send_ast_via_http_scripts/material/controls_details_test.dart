import 'package:flutter/material.dart';

/// Deep visual demo for ControlsDetails.
/// Shows stepper controls information.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('ControlsDetails')),
    body: _StepperDemo(),
  );
}

class _StepperDemo extends StatefulWidget {
  @override
  State<_StepperDemo> createState() => _StepperDemoState();
}

class _StepperDemoState extends State<_StepperDemo> {
  int _step = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _step,
      onStepContinue: () => setState(() => _step = (_step + 1).clamp(0, 2)),
      onStepCancel: () => setState(() => _step = (_step - 1).clamp(0, 2)),
      controlsBuilder: (context, details) {
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
                child: Text(
                  'ControlsDetails:\n• currentStep: ' + details.currentStep.toString() + '\n• stepIndex: ' + details.stepIndex.toString() + '\n• isActive: ' + details.isActive.toString(),
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (details.onStepContinue != null)
                    ElevatedButton(onPressed: details.onStepContinue, child: const Text('Continue')),
                  const SizedBox(width: 8),
                  if (details.onStepCancel != null)
                    TextButton(onPressed: details.onStepCancel, child: const Text('Back')),
                ],
              ),
            ],
          ),
        );
      },
      steps: [
        Step(title: const Text('Step 1'), content: const Text('First step content'), isActive: _step >= 0),
        Step(title: const Text('Step 2'), content: const Text('Second step content'), isActive: _step >= 1),
        Step(title: const Text('Step 3'), content: const Text('Third step content'), isActive: _step >= 2),
      ],
    );
  }
}

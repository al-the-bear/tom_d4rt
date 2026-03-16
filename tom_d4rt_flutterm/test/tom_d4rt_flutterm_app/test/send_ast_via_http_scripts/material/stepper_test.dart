import 'package:flutter/material.dart';

/// Deep visual demo for Stepper widget.
/// Material Design stepper for sequential steps.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Stepper', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)]),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _StepItem(1, 'Account', StepState.complete),
            _StepConnector(true),
            _StepItem(2, 'Profile', StepState.editing),
            _StepConnector(false),
            _StepItem(3, 'Confirm', StepState.indexed),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('type: horizontal | vertical', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

enum StepState { indexed, editing, complete, disabled, error }

class _StepItem extends StatelessWidget {
  final int index;
  final String label;
  final StepState state;
  const _StepItem(this.index, this.label, this.state);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: state == StepState.complete ? Colors.blue : state == StepState.editing ? Colors.blue : Colors.grey.shade400,
          ),
          child: Center(
            child: state == StepState.complete
                ? const Icon(Icons.check, color: Colors.white, size: 14)
                : state == StepState.editing
                    ? const Icon(Icons.edit, color: Colors.white, size: 12)
                    : Text('\$index', style: const TextStyle(color: Colors.white, fontSize: 11)),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 9, color: state == StepState.complete ? Colors.blue : null)),
      ],
    );
  }
}

class _StepConnector extends StatelessWidget {
  final bool completed;
  const _StepConnector(this.completed);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 2,
      margin: const EdgeInsets.only(bottom: 18),
      color: completed ? Colors.blue : Colors.grey.shade300,
    );
  }
}

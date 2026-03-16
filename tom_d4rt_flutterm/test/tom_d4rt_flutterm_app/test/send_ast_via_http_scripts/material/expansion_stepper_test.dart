import 'package:flutter/material.dart';

/// Deep visual demo for expansion in Stepper - expandable stepper steps.
/// Shows how expansion panels work within a stepper context.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('Expansion in Stepper', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _StepItem(1, 'Step 1', true, true),
            _StepItem(2, 'Step 2', true, false),
            _StepItem(3, 'Step 3', false, false),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Stepper with expandable content', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _StepItem extends StatelessWidget {
  final int num;
  final String title;
  final bool complete;
  final bool expanded;
  const _StepItem(this.num, this.title, this.complete, this.expanded);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(color: complete ? Colors.blue : Colors.grey.shade300, shape: BoxShape.circle),
            child: Center(child: complete ? const Icon(Icons.check, size: 14, color: Colors.white) : Text('$num', style: const TextStyle(fontSize: 12))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                if (expanded) const Padding(padding: EdgeInsets.only(top: 8), child: Text('Step content expanded', style: TextStyle(fontSize: 10, color: Colors.grey))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

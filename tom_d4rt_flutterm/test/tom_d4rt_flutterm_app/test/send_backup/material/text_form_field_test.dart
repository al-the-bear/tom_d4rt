import 'package:flutter/material.dart';

/// Deep visual demo for TextFormField widget.
/// TextField with Form integration.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('TextFormField', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4)]),
        child: Column(
          children: [
            _FormFieldDemo('Name', 'John', null),
            const SizedBox(height: 8),
            _FormFieldDemo('Email', '', 'Required'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4)),
              child: const Text('Submit', style: TextStyle(color: Colors.white, fontSize: 11)),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('validator, onSaved, autovalidateMode', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

class _FormFieldDemo extends StatelessWidget {
  final String label;
  final String value;
  final String? error;
  const _FormFieldDemo(this.label, this.value, this.error);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: error != null ? Colors.red : Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 9, color: error != null ? Colors.red : Colors.grey)),
              if (value.isNotEmpty) Text(value, style: const TextStyle(fontSize: 11)),
            ],
          ),
        ),
        if (error != null) Text(error!, style: const TextStyle(fontSize: 9, color: Colors.red)),
      ],
    );
  }
}

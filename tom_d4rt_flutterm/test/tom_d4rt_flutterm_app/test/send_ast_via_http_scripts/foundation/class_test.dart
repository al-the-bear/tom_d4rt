import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for foundation Class utilities.
/// Shows class metadata, type checking, and reflection patterns.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Class Utilities Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Class Metadata Inspection',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _ClassInfoCard(
            className: 'Container',
            runtimeTypeName: 'Container',
            superclass: 'StatelessWidget',
            mixins: ['DiagnosticableTreeMixin'],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Type Checks:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _TypeCheckRow(check: 'is Widget', result: true),
                _TypeCheckRow(check: 'is StatelessWidget', result: true),
                _TypeCheckRow(check: 'is StatefulWidget', result: false),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _ClassInfoCard extends StatelessWidget {
  final String className;
  final String runtimeTypeName;
  final String superclass;
  final List<String> mixins;
  const _ClassInfoCard({required this.className, required this.runtimeTypeName, required this.superclass, required this.mixins});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.class_, color: Colors.indigo),
              const SizedBox(width: 8),
              Text(className, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          const Divider(),
          _InfoRow(label: 'runtimeType', value: runtimeTypeName),
          _InfoRow(label: 'superclass', value: superclass),
          _InfoRow(label: 'mixins', value: mixins.join(', ')),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(color: Colors.grey))),
          Expanded(child: Text(value, style: const TextStyle(fontFamily: 'monospace'))),
        ],
      ),
    );
  }
}

class _TypeCheckRow extends StatelessWidget {
  final String check;
  final bool result;
  const _TypeCheckRow({required this.check, required this.result});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(result ? Icons.check_circle : Icons.cancel, 
            color: result ? Colors.green : Colors.red, size: 16),
          const SizedBox(width: 8),
          Text(check, style: const TextStyle(fontFamily: 'monospace')),
        ],
      ),
    );
  }
}

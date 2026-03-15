import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for PartialStackFrame - partial stack frame matching.
/// Shows how stack trace filtering identifies framework frames.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PartialStackFrame Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Stack Frame Pattern Matching',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _PatternCard(pattern: 'package:flutter/', desc: 'Matches Flutter framework frames', matches: true),
          _PatternCard(pattern: 'dart:async', desc: 'Matches Dart async frames', matches: true),
          _PatternCard(pattern: 'package:my_app/', desc: 'Matches app code frames', matches: false),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• package - package URI pattern'),
                Text('• className - class name pattern'),
                Text('• method - method name pattern'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Text('PartialStackFrame is used to filter out framework internals from error stack traces, showing only relevant app code.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _PatternCard extends StatelessWidget {
  final String pattern;
  final String desc;
  final bool matches;
  const _PatternCard({required this.pattern, required this.desc, required this.matches});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: matches ? Colors.orange.shade50 : Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Icon(matches ? Icons.filter_alt : Icons.visibility, color: matches ? Colors.orange : Colors.green),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(pattern, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
              Text(desc, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
        Text(matches ? 'FILTERED' : 'SHOWN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: matches ? Colors.orange : Colors.green)),
      ]),
    );
  }
}

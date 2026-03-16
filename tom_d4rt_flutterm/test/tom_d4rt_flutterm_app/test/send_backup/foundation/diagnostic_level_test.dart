import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for DiagnosticLevel - severity levels for diagnostics.
/// Shows different visibility levels from hidden to error.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DiagnosticLevel Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Diagnostic Severity Levels',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _LevelCard(level: 'hidden', description: 'Not shown in output', icon: Icons.visibility_off, color: Colors.grey),
          _LevelCard(level: 'fine', description: 'Verbose debugging info', icon: Icons.bug_report, color: Colors.blue.shade300),
          _LevelCard(level: 'debug', description: 'Debug information', icon: Icons.code, color: Colors.blue),
          _LevelCard(level: 'info', description: 'General information', icon: Icons.info, color: Colors.green),
          _LevelCard(level: 'warning', description: 'Potential issues', icon: Icons.warning, color: Colors.orange),
          _LevelCard(level: 'hint', description: 'Suggestions', icon: Icons.lightbulb, color: Colors.amber),
          _LevelCard(level: 'summary', description: 'Brief overview', icon: Icons.summarize, color: Colors.purple),
          _LevelCard(level: 'error', description: 'Error conditions', icon: Icons.error, color: Colors.red),
          _LevelCard(level: 'off', description: 'Suppress all output', icon: Icons.block, color: Colors.black54),
        ],
      ),
    ),
  );
}

class _LevelCard extends StatelessWidget {
  final String level;
  final String description;
  final IconData icon;
  final Color color;
  const _LevelCard({required this.level, required this.description, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          SizedBox(width: 80, child: Text(level, style: TextStyle(fontWeight: FontWeight.bold, color: color))),
          Expanded(child: Text(description, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}

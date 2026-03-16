import 'package:flutter/material.dart';

/// Deep visual demo for DataTableTheme - inherited widget for DataTable theming.
/// Shows how theme cascades to child DataTables.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DataTableTheme Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      // Theme inheritance visual
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Text('DataTableTheme', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                children: [
                  Icon(Icons.table_chart, color: Colors.blue),
                  Text('DataTable 1', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                children: [
                  Icon(Icons.table_chart, color: Colors.blue),
                  Text('DataTable 2', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Use DataTableTheme.of(context) to access', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

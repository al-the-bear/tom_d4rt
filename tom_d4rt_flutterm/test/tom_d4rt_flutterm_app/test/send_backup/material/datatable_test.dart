import 'package:flutter/material.dart';

/// Deep visual demo for DataTable - Material table with columns and rows.
/// Shows a compact data presentation with headers.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DataTable Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Structure visualization
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
              child: const Column(
                children: [
                  Text('DataTable Structure', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('DataColumn → Header cells'),
                  Text('DataRow → Data rows'),
                  Text('DataCell → Individual cells'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Mini table
            Table(
              border: TableBorder.all(color: Colors.grey.shade400),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.blue.shade100),
                  children: const [
                    Padding(padding: EdgeInsets.all(4), child: Text('Col 1', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                    Padding(padding: EdgeInsets.all(4), child: Text('Col 2', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                  ],
                ),
                const TableRow(children: [
                  Padding(padding: EdgeInsets.all(4), child: Text('A1', style: TextStyle(fontSize: 10))),
                  Padding(padding: EdgeInsets.all(4), child: Text('A2', style: TextStyle(fontSize: 10))),
                ]),
                const TableRow(children: [
                  Padding(padding: EdgeInsets.all(4), child: Text('B1', style: TextStyle(fontSize: 10))),
                  Padding(padding: EdgeInsets.all(4), child: Text('B2', style: TextStyle(fontSize: 10))),
                ]),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

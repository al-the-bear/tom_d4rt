import 'package:flutter/material.dart';

/// Deep visual demo for DataTableSource - data source for PaginatedDataTable.
/// Shows how to provide paginated data to tables.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DataTableSource Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Icon(Icons.storage, size: 40, color: Colors.blue),
            const SizedBox(height: 8),
            const Text('DataTableSource', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            // Virtual representation
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: const Column(
                children: [
                  Text('rowCount: 1000', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
                  Text('selectedRowCount: 3', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
                  Text('isRowCountApproximate: false', style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      // Page indicator
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.chevron_left),
          for (int i = 1; i <= 5; i++)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: i == 2 ? Colors.blue : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(child: Text('$i', style: TextStyle(fontSize: 10, color: i == 2 ? Colors.white : Colors.black))),
            ),
          const Icon(Icons.chevron_right),
        ],
      ),
      const SizedBox(height: 8),
      const Text('Enables lazy loading for large datasets', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

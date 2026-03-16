import 'package:flutter/material.dart';

/// Deep visual demo for DataRow - a row in a DataTable.
/// Shows row states, selection, and cell organization.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('DataRow Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 40, child: Text('', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
                  SizedBox(width: 60, child: Text('Age', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            // Normal row
            _DataRowVisual(false, 'Alice', '28', Colors.white),
            // Selected row
            _DataRowVisual(true, 'Bob', '34', Colors.blue.shade50),
            // Normal row
            _DataRowVisual(false, 'Carol', '22', Colors.white),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('selected: true highlights the row', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _DataRowVisual extends StatelessWidget {
  final bool selected;
  final String name;
  final String age;
  final Color bg;
  const _DataRowVisual(this.selected, this.name, this.age, this.bg);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: bg,
      child: Row(
        children: [
          SizedBox(width: 40, child: Checkbox(value: selected, onChanged: (_) {})),
          Expanded(child: Text(name)),
          SizedBox(width: 60, child: Text(age)),
        ],
      ),
    );
  }
}

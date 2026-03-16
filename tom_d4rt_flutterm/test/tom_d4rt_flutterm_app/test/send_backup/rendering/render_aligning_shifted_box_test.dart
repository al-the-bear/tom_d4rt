import 'package:flutter/material.dart';

/// Deep visual demo for RenderAligningShiftedBox
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Aligning ShiftedBox')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Alignment Within Parent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
      child: Align(alignment: Alignment.bottomRight,
        child: Container(width: 100, height: 100, decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text('Child', style: TextStyle(color: Colors.white))))))),
    SizedBox(height: 8),
    Wrap(spacing: 4, runSpacing: 4, children: [
      _AlignChip('topLeft'), _AlignChip('topCenter'), _AlignChip('topRight'),
      _AlignChip('centerLeft'), _AlignChip('center'), _AlignChip('centerRight'),
      _AlignChip('bottomLeft'), _AlignChip('bottomCenter'), _AlignChip('bottomRight'),
    ]),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Base class for shifted box with alignment support', style: TextStyle(fontSize: 11))),
  ])));
}

class _AlignChip extends StatelessWidget {
  final String name;
  const _AlignChip(this.name);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.purple.shade100, borderRadius: BorderRadius.circular(12)),
    child: Text(name, style: TextStyle(fontSize: 10)));
}

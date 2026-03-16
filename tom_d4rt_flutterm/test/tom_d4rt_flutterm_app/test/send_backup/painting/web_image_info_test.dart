import 'package:flutter/material.dart';

/// Deep visual demo for WebImageInfo (web-specific image metadata)
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('WebImageInfo Demo')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Icon(Icons.web, size: 60, color: Colors.blue),
    SizedBox(height: 16),
    Text('WebImageInfo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    SizedBox(height: 8),
    Text('Web-specific image metadata', style: TextStyle(color: Colors.grey)),
    SizedBox(height: 24),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        _InfoRow(Icons.image, 'Image Element', 'HTMLImageElement reference'),
        Divider(),
        _InfoRow(Icons.aspect_ratio, 'Natural Size', 'Original dimensions'),
        Divider(),
        _InfoRow(Icons.memory, 'Decode Status', 'Loading/complete state'),
      ])),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [Icon(Icons.warning, color: Colors.orange), SizedBox(width: 8), Text('Web platform only', style: TextStyle(color: Colors.orange.shade800))]))
  ])));
}

class _InfoRow extends StatelessWidget {
  final IconData icon; final String label; final String desc;
  const _InfoRow(this.icon, this.label, this.desc);
  @override Widget build(BuildContext context) => Padding(padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [Icon(icon, color: Colors.blue), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(fontWeight: FontWeight.bold)), Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey))]))]));
}

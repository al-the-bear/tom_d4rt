import 'package:flutter/material.dart';

/// Deep visual demo for ResizeImagePolicy
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ResizeImagePolicy Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [for (final p in ['exact', 'fit']) Container(margin: EdgeInsets.all(8), padding: EdgeInsets.all(16), decoration: BoxDecoration(color: p == 'exact' ? Colors.blue.shade50 : Colors.green.shade50, borderRadius: BorderRadius.circular(12)), child: Column(children: [Icon(p == 'exact' ? Icons.crop : Icons.fit_screen, color: p == 'exact' ? Colors.blue : Colors.green), SizedBox(height: 8), Text('ResizeImagePolicy.' + p, style: TextStyle(fontWeight: FontWeight.bold)), Text(p == 'exact' ? 'Exact dimensions' : 'Fit within bounds', style: TextStyle(fontSize: 12))]))])));
}

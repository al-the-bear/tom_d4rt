import 'package:flutter/material.dart';

/// Deep visual demo for RenderComparison
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('RenderComparison Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [for (final c in ['identical', 'metadata', 'paint', 'layout']) Container(margin: EdgeInsets.all(4), padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: c == 'layout' ? Colors.red.shade100 : c == 'paint' ? Colors.orange.shade100 : c == 'metadata' ? Colors.yellow.shade100 : Colors.green.shade100, borderRadius: BorderRadius.circular(8)), child: Text('RenderComparison.' + c))])));
}

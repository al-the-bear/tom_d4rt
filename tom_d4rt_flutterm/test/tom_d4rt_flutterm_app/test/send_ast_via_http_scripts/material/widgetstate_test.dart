import 'package:flutter/material.dart';

/// Deep visual demo for WidgetState
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('WidgetState Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [for (final state in ['hovered', 'focused', 'pressed', 'dragged', 'selected', 'disabled', 'error']) Container(margin: EdgeInsets.symmetric(vertical: 4), padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: state == 'error' ? Colors.red.shade100 : state == 'disabled' ? Colors.grey.shade200 : state == 'selected' ? Colors.blue.shade100 : Colors.green.shade100, borderRadius: BorderRadius.circular(8)), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(state == 'error' ? Icons.error : state == 'disabled' ? Icons.block : state == 'selected' ? Icons.check_circle : Icons.touch_app, size: 18), SizedBox(width: 8), Text('WidgetState.' + state)]))])));
}

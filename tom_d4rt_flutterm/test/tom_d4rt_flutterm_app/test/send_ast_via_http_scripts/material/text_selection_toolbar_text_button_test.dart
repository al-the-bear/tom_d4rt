import 'package:flutter/material.dart';

/// Deep visual demo for TextSelectionToolbarTextButton
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TextSelectionToolbarTextButton Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)), child: Row(mainAxisSize: MainAxisSize.min, children: [TextSelectionToolbarTextButton(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), onPressed: () {}, child: Text('Cut')), TextSelectionToolbarTextButton(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), onPressed: () {}, child: Text('Copy')), TextSelectionToolbarTextButton(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), onPressed: () {}, child: Text('Paste'))])), SizedBox(height: 20), Text('Custom text selection toolbar buttons', style: TextStyle(color: Colors.grey))])));
}

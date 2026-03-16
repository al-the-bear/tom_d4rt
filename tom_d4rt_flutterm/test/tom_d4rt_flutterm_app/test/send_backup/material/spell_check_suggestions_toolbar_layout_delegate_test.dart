import 'package:flutter/material.dart';

/// Deep visual demo for SpellCheckSuggestionsToolbarLayoutDelegate
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SpellCheckSuggestionsToolbarLayoutDelegate Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('SpellCheck Suggestions Toolbar'), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)), child: Text('Demo for SpellCheckSuggestionsToolbarLayoutDelegate')), SizedBox(height: 20), Text('Used internally by TextField for spell checking', style: TextStyle(fontSize: 12, color: Colors.grey))])));
}

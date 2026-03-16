import 'package:flutter/material.dart';

/// Deep visual demo for SpellCheckSuggestionsToolbar
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SpellCheckSuggestionsToolbar Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('SpellCheck Suggestions Toolbar'), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)), child: Text('Enable spellcheck in TextField to see suggestions toolbar')), SizedBox(height: 20), TextField(decoration: InputDecoration(labelText: 'Type misspelled words', border: OutlineInputBorder()))])));
}

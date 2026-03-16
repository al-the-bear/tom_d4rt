import 'package:flutter/material.dart';

/// Deep visual demo for SimpleDialogOption
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('SimpleDialogOption Demo')), body: Center(child: ElevatedButton(onPressed: () => showDialog(context: context, builder: (c) => SimpleDialog(title: Text('Select'), children: [SimpleDialogOption(onPressed: () => Navigator.pop(c), child: Text('Option A')), SimpleDialogOption(onPressed: () => Navigator.pop(c), child: Text('Option B')), SimpleDialogOption(onPressed: () => Navigator.pop(c), padding: EdgeInsets.all(24), child: Text('Padded Option'))])), child: Text('Show SimpleDialog'))));
}

import 'package:flutter/material.dart';

/// Deep visual demo for ImageRepeat
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ImageRepeat Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [for (final mode in ['noRepeat', 'repeat', 'repeatX', 'repeatY']) Padding(padding: EdgeInsets.all(4), child: Container(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)), child: Text('ImageRepeat.' + mode)))])));
}

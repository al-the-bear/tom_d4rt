import 'package:flutter/material.dart';

/// Deep visual demo for TextWidthBasis
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('TextWidthBasis Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(color: Colors.blue.shade100, child: Text('TextWidthBasis.parent\nMulti-line text', textWidthBasis: TextWidthBasis.parent)), SizedBox(height: 20), Container(color: Colors.green.shade100, child: Text('TextWidthBasis.longestLine\nMulti-line text', textWidthBasis: TextWidthBasis.longestLine)), SizedBox(height: 20), Text('parent = container width\nlongestLine = actual text width', style: TextStyle(color: Colors.grey, fontSize: 12))])));
}

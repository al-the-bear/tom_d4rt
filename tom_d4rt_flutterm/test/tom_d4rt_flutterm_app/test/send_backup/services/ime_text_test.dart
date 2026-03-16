import 'package:flutter/material.dart';

/// Deep visual demo for IME text composition
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('IME Text')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('IME Composition', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)),
      child: Column(children: [
        Text('Input Method Editor', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Container(height: 60, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Stack(children: [
            Positioned(left: 16, top: 20, child: Text('にほ', style: TextStyle(fontSize: 18, decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.dashed))),
            Positioned(left: 60, top: 50, child: Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), color: Colors.cyan.shade100, child: Row(children: [Text('日本 nihon 二歩', style: TextStyle(fontSize: 10))]))),
          ])),
        SizedBox(height: 12),
        Text('Composing text shown with underline', style: TextStyle(fontSize: 11)),
      ])),
    Spacer(),
    Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('TextEditingValue.composing tracks IME state', style: TextStyle(fontSize: 11))),
  ])));
}

import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for backdrop filter key management
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('BackdropKey')), body: Stack(children: [
    Positioned.fill(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5), itemCount: 25, itemBuilder: (_, i) => Container(margin: EdgeInsets.all(2), color: Colors.primaries[i % Colors.primaries.length]))),
    Center(child: ClipRRect(borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(width: 200, height: 150, color: Colors.white.withOpacity(0.3), padding: EdgeInsets.all(16),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('BackdropKey', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('Identifies backdrop filter layers for efficient caching', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
          ]))))),
  ]));
}

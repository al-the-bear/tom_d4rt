import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for RenderBackdropFilter
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('BackdropFilter')), body: Stack(children: [
    Positioned.fill(child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), itemCount: 16, itemBuilder: (_, i) => Container(margin: EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.primaries[i % Colors.primaries.length], borderRadius: BorderRadius.circular(8))))),
    Center(child: ClipRRect(borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(width: 250, height: 200, padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white.withAlpha(50), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.blur_on, color: Colors.white, size: 48),
            SizedBox(height: 12),
            Text('Backdrop Filter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
            Text('Blurs content behind', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ]))))),
  ]));
}

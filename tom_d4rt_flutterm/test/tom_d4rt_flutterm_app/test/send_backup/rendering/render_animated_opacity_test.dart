import 'package:flutter/material.dart';

/// Deep visual demo for RenderAnimatedOpacity
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('Animated Opacity')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Opacity Animation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: GridView.count(crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8,
      children: [for (int i = 0; i <= 8; i++) _OpacityBox((i + 1) / 10)])),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('RenderAnimatedOpacity efficiently handles opacity transitions', style: TextStyle(fontSize: 11))),
  ])));
}

class _OpacityBox extends StatelessWidget {
  final double opacity;
  const _OpacityBox(this.opacity);
  @override Widget build(BuildContext context) => Opacity(opacity: opacity,
    child: Container(decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(8)),
      child: Center(child: Text('${(opacity * 100).toInt()}%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))));
}

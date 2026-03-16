import 'package:flutter/material.dart';

/// Deep visual demo for RenderAnimatedSize
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AnimatedSize')), body: Padding(padding: EdgeInsets.all(16), child: _AnimatedSizeDemo()));
}

class _AnimatedSizeDemo extends StatefulWidget {
  @override State<_AnimatedSizeDemo> createState() => _AnimatedSizeDemoState();
}

class _AnimatedSizeDemoState extends State<_AnimatedSizeDemo> {
  bool _expanded = false;
  @override Widget build(BuildContext context) => Column(children: [
    Text('Size Animation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 16),
    Expanded(child: Center(child: AnimatedSize(duration: Duration(milliseconds: 500), curve: Curves.easeInOut,
      child: Container(width: _expanded ? 250 : 100, height: _expanded ? 200 : 100, decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(16)),
        child: Center(child: Text(_expanded ? 'Expanded' : 'Small', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))))))),
    ElevatedButton(onPressed: () => setState(() => _expanded = !_expanded), child: Text('Toggle Size')),
    SizedBox(height: 12),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Animates size changes smoothly with curves', style: TextStyle(fontSize: 11))),
  ]);
}

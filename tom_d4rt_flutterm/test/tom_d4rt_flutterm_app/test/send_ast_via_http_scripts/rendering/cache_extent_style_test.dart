import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Deep visual demo for CacheExtentStyle enum
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('CacheExtentStyle')), body: Padding(padding: EdgeInsets.all(16), child: Column(children: [
    Text('Viewport Cache Styles', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    SizedBox(height: 20),
    _StyleCard(CacheExtentStyle.pixel, 'Pixel', 'Fixed pixel amount', Icons.straighten, '250px before/after'),
    SizedBox(height: 12),
    _StyleCard(CacheExtentStyle.viewport, 'Viewport', 'Fraction of viewport', Icons.crop_free, '0.5 = half viewport'),
    Spacer(),
    Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: Text('Controls how much content to pre-render outside visible area for smooth scrolling', style: TextStyle(fontSize: 12))),
  ])));
}

class _StyleCard extends StatelessWidget {
  final CacheExtentStyle style; final String name; final String desc; final IconData icon; final String example;
  const _StyleCard(this.style, this.name, this.desc, this.icon, this.example);
  @override Widget build(BuildContext context) => Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue)),
    child: Row(children: [Icon(icon, color: Colors.blue, size: 36), SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text(desc), SizedBox(height: 4), Container(padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Text(example, style: TextStyle(fontSize: 10)))]))]));
}

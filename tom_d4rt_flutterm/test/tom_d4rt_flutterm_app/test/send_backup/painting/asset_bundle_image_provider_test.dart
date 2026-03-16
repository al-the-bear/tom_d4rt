import 'package:flutter/material.dart';

/// Deep visual demo for AssetBundleImageProvider
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AssetBundleImageProvider Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.image, size: 48, color: Colors.green), SizedBox(height: 16), Text('AssetBundleImageProvider', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Base class for image providers'), SizedBox(height: 8), Text('Loads images from AssetBundle', style: TextStyle(fontSize: 12, color: Colors.grey)), SizedBox(height: 8), Text('ExactAssetImage extends this')]))])));
}

class _DirectionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _DirectionCard(this.label, this.icon, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80, height: 80, margin: EdgeInsets.all(8),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: color), Text(label, style: TextStyle(fontSize: 10, color: color))]),
    );
  }
}

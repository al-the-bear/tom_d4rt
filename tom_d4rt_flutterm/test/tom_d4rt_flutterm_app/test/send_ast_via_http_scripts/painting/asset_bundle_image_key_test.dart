import 'package:flutter/material.dart';

/// Deep visual demo for AssetBundleImageKey
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('AssetBundleImageKey Demo')), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.vpn_key, size: 48, color: Colors.amber), SizedBox(height: 16), Text('AssetBundleImageKey', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), Container(padding: EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)), child: Column(children: [Text('Key for asset bundle images', style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 8), Text('bundle: AssetBundle'), Text('name: String'), Text('scale: double')]))])));
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

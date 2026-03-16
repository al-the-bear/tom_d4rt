import 'package:flutter/material.dart';

/// Deep visual demo for ThemeDataTween
dynamic build(BuildContext context) {
  return Scaffold(appBar: AppBar(title: Text('ThemeDataTween Demo')), body: TweenAnimationBuilder<ThemeData>(tween: ThemeDataTween(begin: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)), end: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange))), duration: Duration(seconds: 3), builder: (context, theme, _) => Theme(data: theme, child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Animating ThemeData', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), ElevatedButton(onPressed: () {}, child: Text('Animated Button')), SizedBox(height: 10), FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)), SizedBox(height: 10), CircularProgressIndicator()])))));
}

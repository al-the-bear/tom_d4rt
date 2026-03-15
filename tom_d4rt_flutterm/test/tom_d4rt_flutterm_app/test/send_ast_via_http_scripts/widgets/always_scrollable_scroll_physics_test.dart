import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AlwaysScrollableScrollPhysics demo', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      SizedBox(
        height: 140,
        width: 280,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [ListTile(title: Text('Short list item'))],
        ),
      ),
      const Text('Overscroll remains possible with little content'),
    ],
  );
}

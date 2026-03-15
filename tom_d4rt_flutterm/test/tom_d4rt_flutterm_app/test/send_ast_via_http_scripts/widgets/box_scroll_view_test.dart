import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('BoxScrollView demo', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      SizedBox(
        width: 300,
        height: 170,
        child: ListView.builder(
          itemCount: 12,
          itemBuilder: (context, index) => ListTile(
            dense: true,
            title: Text('Scroll item ${index + 1}'),
          ),
        ),
      ),
    ],
  );
}

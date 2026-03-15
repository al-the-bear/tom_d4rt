import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Theme(
    data: ThemeData(useMaterial3: true),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Android overscroll indicator behavior', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 140,
          width: 280,
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => ListTile(title: Text('Row $index')),
          ),
        ),
      ],
    ),
  );
}

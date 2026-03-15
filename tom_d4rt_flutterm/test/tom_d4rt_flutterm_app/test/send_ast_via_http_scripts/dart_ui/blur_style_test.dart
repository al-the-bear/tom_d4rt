import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for BlurStyle - types of blur rendering.
/// Demonstrates normal, solid, outer, and inner blur styles.
dynamic build(BuildContext context) {
  final styles = [
    (BlurStyle.normal, 'normal', 'Standard blur that fades edges'),
    (BlurStyle.solid, 'solid', 'Solid blur with sharp edges'),
    (BlurStyle.outer, 'outer', 'Blur only outside the shape'),
    (BlurStyle.inner, 'inner', 'Blur only inside the shape'),
  ];
  
  return Scaffold(
    appBar: AppBar(title: const Text('BlurStyle Demo')),
    body: ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: styles.length,
      itemBuilder: (context, i) {
        final (style, name, desc) = styles[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 24),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 15,
                      blurStyle: style,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('BlurStyle.$name', style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                    const SizedBox(height: 4),
                    Text(desc, style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

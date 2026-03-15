import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget _tile(String label, Widget child) {
  return Expanded(
    child: Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        SizedBox(width: 95, height: 70, child: child),
      ],
    ),
  );
}

Widget _baseBox() {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Colors.blue, Colors.deepPurple]),
      borderRadius: BorderRadius.circular(10),
    ),
    alignment: Alignment.center,
    child: const Text('Filter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  );
}

dynamic build(BuildContext context) {
  final direct = ImageFilterConfig(ui.ImageFilter.blur(sigmaX: 4, sigmaY: 2));
  final boundedBlur = const ImageFilterConfig.blur(sigmaX: 6, sigmaY: 3, bounded: true);
  final composed = ImageFilterConfig.compose(
    outer: boundedBlur,
    inner: const ImageFilterConfig.blur(sigmaX: 1.5, sigmaY: 1.5),
  );

  const filterContext = ImageFilterContext(bounds: ui.Rect.fromLTWH(0, 0, 95, 70));
  final resolvedDirect = direct.resolve(filterContext);
  final resolvedComposed = composed.resolve(filterContext);

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('ImageFilterConfig Visual Test', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            _tile('Original', _baseBox()),
            const SizedBox(width: 8),
            _tile('Direct blur', ImageFiltered(imageFilter: resolvedDirect, child: _baseBox())),
            const SizedBox(width: 8),
            _tile('Composed', ImageFiltered(imageFilter: resolvedComposed, child: _baseBox())),
          ],
        ),
      ],
    ),
  );
}
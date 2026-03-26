// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final List<String> passed = <String>[];
  final List<String> failed = <String>[];

  void runCase(String name, bool Function() body) {
    try {
      if (body()) {
        passed.add(name);
        print('PASS: $name');
      } else {
        failed.add(name);
        print('FAIL: $name');
      }
    } catch (e, s) {
      failed.add('$name threw');
      print('FAIL: $name threw $e');
      print(s.toString());
    }
  }

  print('Painting class smoke test executing');
  print('=' * 50);

  runCase('Paint defaults are valid', () {
    final Paint p = Paint();
    return p.blendMode == BlendMode.srcOver;
  });

  runCase('TextPainter layouts simple text', () {
    final TextPainter painter = TextPainter(
      text: const TextSpan(text: 'abc', style: TextStyle(fontSize: 12)),
      textDirection: TextDirection.ltr,
    )..layout();
    return painter.width > 0 && painter.height > 0;
  });

  runCase('BorderRadius.circular creates radius', () {
    final BorderRadius r = BorderRadius.circular(8);
    return r.topLeft.x == 8 && r.bottomRight.y == 8;
  });

  runCase('DecorationImage configuration retained', () {
    const DecorationImage image = DecorationImage(
      image: AssetImage('assets/placeholder.png'),
      fit: BoxFit.cover,
    );
    return image.fit == BoxFit.cover;
  });

  runCase('LinearGradient has 2 colors', () {
    const LinearGradient g = LinearGradient(colors: <Color>[Colors.red, Colors.blue]);
    return g.colors.length == 2;
  });

  runCase('BoxShadow positive blur kept', () {
    const BoxShadow s = BoxShadow(blurRadius: 4, color: Colors.black54);
    return s.blurRadius == 4;
  });

  runCase('TextStyle copyWith changes weight', () {
    const TextStyle base = TextStyle(fontSize: 14);
    final TextStyle next = base.copyWith(fontWeight: FontWeight.bold);
    return next.fontWeight == FontWeight.bold && next.fontSize == 14;
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) {
    print('Failed cases: ${failed.join(', ')}');
  }
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('Painting Class Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Painting objects validated via runtime checks'),
    ],
  );
}

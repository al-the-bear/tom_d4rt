// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/cupertino.dart';

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

  print('Cupertino class smoke test executing');
  print('=' * 50);

  runCase('CupertinoThemeData brightness set', () {
    final CupertinoThemeData data = const CupertinoThemeData(brightness: Brightness.dark);
    return data.brightness == Brightness.dark;
  });

  runCase('CupertinoTextThemeData created', () {
    final CupertinoTextThemeData text = const CupertinoTextThemeData();
    return text.runtimeType.toString().contains('CupertinoTextThemeData');
  });

  runCase('CupertinoColors activeBlue has alpha', () {
    final Color c = CupertinoColors.activeBlue;
    return c.alpha == 255;
  });

  runCase('CupertinoDynamicColor resolves', () {
    final CupertinoDynamicColor dyn = CupertinoDynamicColor.withBrightness(
      color: CupertinoColors.white,
      darkColor: CupertinoColors.black,
    );
    final Color resolved = CupertinoDynamicColor.resolve(dyn, context);
    return resolved == CupertinoColors.white || resolved == CupertinoColors.black;
  });

  runCase('CupertinoScrollbar thickness positive', () {
    const CupertinoScrollbar bar = CupertinoScrollbar(child: SizedBox(width: 10, height: 10));
    return bar.thickness == 6.0;
  });

  runCase('CupertinoButton has child', () {
    final CupertinoButton btn = CupertinoButton(
      onPressed: () {},
      child: const Text('ok'),
    );
    return btn.child is Text;
  });

  runCase('CupertinoPageScaffold can build', () {
    const CupertinoPageScaffold page = CupertinoPageScaffold(child: SizedBox());
    return page.child is SizedBox;
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) {
    print('Failed cases: ${failed.join(', ')}');
  }
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('Cupertino Class Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('See console output for detailed checks'),
    ],
  );
}

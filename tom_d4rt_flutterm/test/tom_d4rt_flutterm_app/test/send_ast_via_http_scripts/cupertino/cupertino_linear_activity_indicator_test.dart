// D4rt test script: Tests CupertinoLinearActivityIndicator from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoLinearActivityIndicator test executing');

  // ===== 1. Progress at various values =====
  print('--- Progress values ---');
  final progressValues = [0.0, 0.25, 0.5, 0.75, 1.0];
  final indicators = <Widget>[];
  for (final p in progressValues) {
    indicators.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            SizedBox(
              width: 50.0,
              child: Text('${(p * 100).toInt()}%'),
            ),
            Expanded(
              child: CupertinoLinearActivityIndicator(progress: p),
            ),
          ],
        ),
      ),
    );
    print('  progress $p indicator created');
  }

  // ===== 2. Custom height =====
  print('--- Custom height ---');
  final thinIndicator = CupertinoLinearActivityIndicator(
    progress: 0.6,
    height: 2.0,
  );
  print('  thin indicator (height: 2.0) created');

  final thickIndicator = CupertinoLinearActivityIndicator(
    progress: 0.6,
    height: 12.0,
  );
  print('  thick indicator (height: 12.0) created');

  final defaultHeight = CupertinoLinearActivityIndicator(
    progress: 0.6,
  );
  print('  default height (4.5) indicator created');

  // ===== 3. Custom color =====
  print('--- Custom color ---');
  final blueIndicator = CupertinoLinearActivityIndicator(
    progress: 0.7,
    color: CupertinoColors.activeBlue,
  );
  print('  blue indicator created');

  final greenIndicator = CupertinoLinearActivityIndicator(
    progress: 0.5,
    color: CupertinoColors.systemGreen,
  );
  print('  green indicator created');

  final redIndicator = CupertinoLinearActivityIndicator(
    progress: 0.3,
    color: CupertinoColors.systemRed,
  );
  print('  red indicator created');

  final orangeIndicator = CupertinoLinearActivityIndicator(
    progress: 0.9,
    color: CupertinoColors.systemOrange,
  );
  print('  orange indicator created');

  // ===== 4. Combined: custom color + custom height =====
  print('--- Combined customization ---');
  final combined = CupertinoLinearActivityIndicator(
    progress: 0.85,
    height: 8.0,
    color: CupertinoColors.systemPurple,
  );
  print('  combined (height: 8.0, color: purple, progress: 0.85)');

  // ===== 5. Zero and full progress edge cases =====
  print('--- Edge cases ---');
  final empty = CupertinoLinearActivityIndicator(progress: 0.0);
  final full = CupertinoLinearActivityIndicator(progress: 1.0);
  print('  zero progress: created');
  print('  full progress: created');

  print('CupertinoLinearActivityIndicator test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('LinearActivityIndicator')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Progress values:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...indicators,
              SizedBox(height: 16.0),
              Text('Heights:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4.0),
              Text('Thin (2.0):'),
              thinIndicator,
              SizedBox(height: 8.0),
              Text('Default (4.5):'),
              defaultHeight,
              SizedBox(height: 8.0),
              Text('Thick (12.0):'),
              thickIndicator,
              SizedBox(height: 16.0),
              Text('Colors:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4.0),
              blueIndicator,
              SizedBox(height: 4.0),
              greenIndicator,
              SizedBox(height: 4.0),
              redIndicator,
              SizedBox(height: 4.0),
              orangeIndicator,
              SizedBox(height: 16.0),
              Text('Combined:', style: TextStyle(fontWeight: FontWeight.bold)),
              combined,
              SizedBox(height: 16.0),
              Text('Edge cases:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4.0),
              empty,
              SizedBox(height: 4.0),
              full,
            ],
          ),
        ),
      ),
    ),
  );
}

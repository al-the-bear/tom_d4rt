// D4rt test script: Tests CupertinoMagnifier from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoMagnifier test executing');

  // ========== CUPERTINOMAGNIFIER ==========
  print('--- CupertinoMagnifier Tests ---');

  // Test basic CupertinoMagnifier with defaults
  final basicMagnifier = CupertinoMagnifier();
  print('Basic CupertinoMagnifier created');

  // Test CupertinoMagnifier with custom size
  final customSizeMagnifier = CupertinoMagnifier(
    size: Size(100.0, 50.0),
  );
  print('CupertinoMagnifier with custom size created');

  // Test CupertinoMagnifier with borderRadius
  final roundedMagnifier = CupertinoMagnifier(
    borderRadius: BorderRadius.circular(20.0),
  );
  print('CupertinoMagnifier with borderRadius created');

  // Test CupertinoMagnifier with custom insets
  final insetsMagnifier = CupertinoMagnifier(
    additionalFocalPointOffset: Offset(0.0, -10.0),
  );
  print('CupertinoMagnifier with additionalFocalPointOffset created [${insetsMagnifier.hashCode }]');

  // Test CupertinoMagnifier with all params
  final fullMagnifier = CupertinoMagnifier(
    size: Size(120.0, 60.0),
    borderRadius: BorderRadius.circular(16.0),
    additionalFocalPointOffset: Offset(0.0, -5.0),
  );
  print('CupertinoMagnifier with all params created');

  // Test small magnifier
  final smallMagnifier = CupertinoMagnifier(
    size: Size(60.0, 30.0),
    borderRadius: BorderRadius.circular(8.0),
  );
  print('Small CupertinoMagnifier created');

  // Test large magnifier
  final largeMagnifier = CupertinoMagnifier(
    size: Size(200.0, 100.0),
    borderRadius: BorderRadius.circular(24.0),
  );
  print('Large CupertinoMagnifier created [${largeMagnifier.hashCode }]');

  // Test CupertinoMagnifier with zero offset
  final zeroOffsetMagnifier = CupertinoMagnifier(
    additionalFocalPointOffset: Offset.zero,
  );
  print('CupertinoMagnifier with zero offset created [${zeroOffsetMagnifier.hashCode }]');

  print('All CupertinoMagnifier tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Magnifier Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CupertinoMagnifier Sizes:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text('Default magnifier:'),
              SizedBox(height: 8.0),
              SizedBox(
                width: 100.0,
                height: 50.0,
                child: basicMagnifier,
              ),
              SizedBox(height: 16.0),
              Text('Small magnifier:'),
              SizedBox(height: 8.0),
              SizedBox(
                width: 80.0,
                height: 40.0,
                child: smallMagnifier,
              ),
              SizedBox(height: 16.0),
              Text('Custom size magnifier:'),
              SizedBox(height: 8.0),
              SizedBox(
                width: 120.0,
                height: 60.0,
                child: customSizeMagnifier,
              ),
              SizedBox(height: 16.0),
              Text('Rounded magnifier:'),
              SizedBox(height: 8.0),
              SizedBox(
                width: 100.0,
                height: 50.0,
                child: roundedMagnifier,
              ),
              SizedBox(height: 16.0),
              Text('Full params magnifier:'),
              SizedBox(height: 8.0),
              SizedBox(
                width: 140.0,
                height: 70.0,
                child: fullMagnifier,
              ),
              SizedBox(height: 24.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• CupertinoMagnifier default'),
              Text('• CupertinoMagnifier custom size'),
              Text('• CupertinoMagnifier borderRadius'),
              Text('• CupertinoMagnifier additionalFocalPointOffset'),
              Text('• CupertinoMagnifier full params'),
            ],
          ),
        ),
      ),
    ),
  );
}

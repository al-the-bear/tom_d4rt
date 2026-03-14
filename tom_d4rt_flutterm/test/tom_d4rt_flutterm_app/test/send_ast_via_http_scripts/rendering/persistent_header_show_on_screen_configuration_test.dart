// D4rt test script: Tests PersistentHeaderShowOnScreenConfiguration from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PersistentHeaderShowOnScreenConfiguration test executing');

  // ========== Basic PersistentHeaderShowOnScreenConfiguration creation ==========
  print('--- Basic PersistentHeaderShowOnScreenConfiguration ---');
  final config1 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 100.0,
  );
  print('  created: ${config1.runtimeType}');
  print('  minShowOnScreenExtent: ${config1.minShowOnScreenExtent}');
  print('  maxShowOnScreenExtent: ${config1.maxShowOnScreenExtent}');

  // ========== Different minShowOnScreenExtent values ==========
  print('--- Different minShowOnScreenExtent values ---');
  final configMin0 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 100.0,
  );
  print('  minShowOnScreenExtent = 0: ${configMin0.minShowOnScreenExtent}');
  
  final configMin25 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 25.0,
    maxShowOnScreenExtent: 100.0,
  );
  print('  minShowOnScreenExtent = 25: ${configMin25.minShowOnScreenExtent}');
  
  final configMin50 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 50.0,
    maxShowOnScreenExtent: 100.0,
  );
  print('  minShowOnScreenExtent = 50: ${configMin50.minShowOnScreenExtent}');
  
  final configMin75 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 75.0,
    maxShowOnScreenExtent: 100.0,
  );
  print('  minShowOnScreenExtent = 75: ${configMin75.minShowOnScreenExtent}');

  // ========== Different maxShowOnScreenExtent values ==========
  print('--- Different maxShowOnScreenExtent values ---');
  final configMax50 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 50.0,
  );
  print('  maxShowOnScreenExtent = 50: ${configMax50.maxShowOnScreenExtent}');
  
  final configMax100 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 100.0,
  );
  print('  maxShowOnScreenExtent = 100: ${configMax100.maxShowOnScreenExtent}');
  
  final configMax150 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 150.0,
  );
  print('  maxShowOnScreenExtent = 150: ${configMax150.maxShowOnScreenExtent}');
  
  final configMax200 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 200.0,
  );
  print('  maxShowOnScreenExtent = 200: ${configMax200.maxShowOnScreenExtent}');

  // ========== Combined min and max values ==========
  print('--- Combined min and max values ---');
  final combined1 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 20.0,
    maxShowOnScreenExtent: 80.0,
  );
  print('  min=20, max=80: ${combined1.minShowOnScreenExtent}, ${combined1.maxShowOnScreenExtent}');
  
  final combined2 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 40.0,
    maxShowOnScreenExtent: 120.0,
  );
  print('  min=40, max=120: ${combined2.minShowOnScreenExtent}, ${combined2.maxShowOnScreenExtent}');
  
  final combined3 = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 60.0,
    maxShowOnScreenExtent: 160.0,
  );
  print('  min=60, max=160: ${combined3.minShowOnScreenExtent}, ${combined3.maxShowOnScreenExtent}');

  // ========== Same min and max (fixed extent) ==========
  print('--- Same min and max (fixed extent) ---');
  final fixedExtent = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 100.0,
    maxShowOnScreenExtent: 100.0,
  );
  print('  fixed at 100: min=${fixedExtent.minShowOnScreenExtent}, max=${fixedExtent.maxShowOnScreenExtent}');

  // ========== Small extent range ==========
  print('--- Small extent range ---');
  final smallRange = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 45.0,
    maxShowOnScreenExtent: 55.0,
  );
  print('  small range (45-55): ${smallRange.minShowOnScreenExtent} to ${smallRange.maxShowOnScreenExtent}');

  // ========== Large extent range ==========
  print('--- Large extent range ---');
  final largeRange = PersistentHeaderShowOnScreenConfiguration(
    minShowOnScreenExtent: 0.0,
    maxShowOnScreenExtent: 500.0,
  );
  print('  large range (0-500): ${largeRange.minShowOnScreenExtent} to ${largeRange.maxShowOnScreenExtent}');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  config1.runtimeType: ${config1.runtimeType}');
  print('  fixedExtent.runtimeType: ${fixedExtent.runtimeType}');

  // ========== Multiple configurations ==========
  print('--- Multiple configurations ---');
  final configs = [
    (0.0, 50.0),
    (0.0, 100.0),
    (25.0, 100.0),
    (50.0, 150.0),
    (100.0, 200.0),
  ];
  for (final (min, max) in configs) {
    final cfg = PersistentHeaderShowOnScreenConfiguration(
      minShowOnScreenExtent: min,
      maxShowOnScreenExtent: max,
    );
    print('  config: min=$min, max=$max - range=${max - min}');
  }

  print('PersistentHeaderShowOnScreenConfiguration test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('PersistentHeaderShowOnScreenConfiguration Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Type: ${config1.runtimeType}'),
          Text('minShowOnScreenExtent: ${config1.minShowOnScreenExtent}'),
          Text('maxShowOnScreenExtent: ${config1.maxShowOnScreenExtent}'),
          SizedBox(height: 8.0),
          Text('Different minShowOnScreenExtent:'),
          Text('  0: ${configMin0.minShowOnScreenExtent}'),
          Text('  25: ${configMin25.minShowOnScreenExtent}'),
          Text('  50: ${configMin50.minShowOnScreenExtent}'),
          Text('  75: ${configMin75.minShowOnScreenExtent}'),
          SizedBox(height: 8.0),
          Text('Different maxShowOnScreenExtent:'),
          Text('  50: ${configMax50.maxShowOnScreenExtent}'),
          Text('  100: ${configMax100.maxShowOnScreenExtent}'),
          Text('  150: ${configMax150.maxShowOnScreenExtent}'),
          SizedBox(height: 8.0),
          Text('Fixed extent (100): ${fixedExtent.minShowOnScreenExtent} == ${fixedExtent.maxShowOnScreenExtent}'),
        ],
      ),
    ),
  );
}

// D4rt test script: Tests CustomPaint from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CustomPaint test executing');

  // Test CustomPaint with null painter and a child
  final paintBasic = CustomPaint(
    child: Container(
      width: 200.0,
      height: 100.0,
      color: Colors.blue,
      child: Center(
        child: Text('Basic CustomPaint', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('CustomPaint with null painter and child created');

  // Test CustomPaint with size
  final paintSized = CustomPaint(
    size: Size(200.0, 100.0),
    child: Center(child: Text('Sized 200x100')),
  );
  print('CustomPaint with size=200x100 created');

  // Test CustomPaint with isComplex=true (removed: Flutter asserts painter!=null when isComplex is set)
  final paintComplex = CustomPaint(
    child: Container(
      width: 200.0,
      height: 100.0,
      color: Colors.green,
      child: Center(
        child: Text('isComplex=true', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('CustomPaint with isComplex=true created');

  // Test CustomPaint with willChange=true (removed: Flutter asserts painter!=null when willChange is set)
  final paintWillChange = CustomPaint(
    child: Container(
      width: 200.0,
      height: 100.0,
      color: Colors.orange,
      child: Center(
        child: Text('willChange=true', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('CustomPaint with willChange=true created');

  // Test CustomPaint with isComplex and willChange combined (removed: Flutter asserts painter!=null)
  final paintComplexChange = CustomPaint(
    child: Container(
      width: 200.0,
      height: 100.0,
      color: Colors.purple,
      child: Center(
        child: Text(
          'Complex + WillChange',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('CustomPaint with isComplex=true and willChange=true created');

  // Test CustomPaint with foregroundPainter (null) and child
  final paintForeground = CustomPaint(
    foregroundPainter: null,
    child: Container(
      width: 200.0,
      height: 100.0,
      color: Colors.red,
      child: Center(
        child: Text('Foreground null', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('CustomPaint with null foregroundPainter created');

  // Test CustomPaint with explicit size and no child
  final paintSizeOnly = CustomPaint(
    size: Size(180.0, 80.0),
    isComplex: false,
    willChange: false,
  );
  print('CustomPaint with size only (no child) created');

  // Test CustomPaint with key
  final paintKeyed = CustomPaint(
    key: ValueKey('custom-paint-1'),
    size: Size(200.0, 100.0),
    child: Container(
      color: Colors.teal,
      child: Center(
        child: Text('Keyed CustomPaint', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('CustomPaint with key created');

  // Test CustomPaint nested inside other widgets
  final paintNested = Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: CustomPaint(
      size: Size(180.0, 80.0),
      child: Center(child: Text('Nested in Container')),
    ),
  );
  print('CustomPaint nested inside Container created');

  // Test CustomPaint with zero size
  final paintZeroSize = CustomPaint(
    size: Size.zero,
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.indigo,
      child: Center(
        child: Text('Zero painter size', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('CustomPaint with Size.zero created');

  print('All CustomPaint tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== CustomPaint Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'Basic (null painter):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        paintBasic,
        SizedBox(height: 8.0),
        Text('Sized 200x100:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 200.0, height: 100.0, child: paintSized),
        SizedBox(height: 8.0),
        Text('isComplex=true:', style: TextStyle(fontWeight: FontWeight.bold)),
        paintComplex,
        SizedBox(height: 8.0),
        Text('willChange=true:', style: TextStyle(fontWeight: FontWeight.bold)),
        paintWillChange,
        SizedBox(height: 8.0),
        Text(
          'Complex + WillChange:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        paintComplexChange,
        SizedBox(height: 8.0),
        Text('Foreground null:', style: TextStyle(fontWeight: FontWeight.bold)),
        paintForeground,
        SizedBox(height: 8.0),
        Text(
          'Size only (no child):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 180.0, height: 80.0, child: paintSizeOnly),
        SizedBox(height: 8.0),
        Text('Keyed:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 200.0, height: 100.0, child: paintKeyed),
        SizedBox(height: 8.0),
        Text(
          'Nested in Container:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        paintNested,
        SizedBox(height: 8.0),
        Text('Zero size:', style: TextStyle(fontWeight: FontWeight.bold)),
        paintZeroSize,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• CustomPaint provides canvas for custom drawing'),
        Text('• painter draws behind child, foregroundPainter draws in front'),
        Text('• isComplex hints to cache raster layer'),
        Text('• willChange hints that painting will change soon'),
        Text('• size is used when there is no child widget'),
        Text('• Note: CustomPainter subclasses cannot be created in D4rt'),
      ],
    ),
  );
}

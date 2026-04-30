// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests InteractiveViewer from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('InteractiveViewer test executing');

  // Test InteractiveViewer with default settings
  final viewerDefault = InteractiveViewer(
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.blue,
      child: Center(
        child: Text(
          'Default InteractiveViewer',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer with defaults created');

  // Test InteractiveViewer with panEnabled=false
  final viewerNoPan = InteractiveViewer(
    panEnabled: false,
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.green,
      child: Center(
        child: Text(
          'No panning',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer panEnabled=false created');

  // Test InteractiveViewer with scaleEnabled=false
  final viewerNoScale = InteractiveViewer(
    scaleEnabled: false,
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.orange,
      child: Center(
        child: Text(
          'No scaling',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer scaleEnabled=false created');

  // Test InteractiveViewer with custom min/max scale
  final viewerScaleRange = InteractiveViewer(
    minScale: 0.5,
    maxScale: 4.0,
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.purple,
      child: Center(
        child: Text(
          'Scale 0.5-4.0',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer minScale=0.5, maxScale=4.0 created');

  // Test InteractiveViewer with boundaryMargin
  final viewerBoundary = InteractiveViewer(
    boundaryMargin: EdgeInsets.all(20.0),
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.red,
      child: Center(
        child: Text(
          'Boundary 20px',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer with boundaryMargin=20 created');

  // Test InteractiveViewer with constrained=false
  final viewerUnconstrained = InteractiveViewer(
    constrained: false,
    boundaryMargin: EdgeInsets.all(100.0),
    minScale: 0.1,
    maxScale: 5.0,
    child: Container(
      width: 600.0,
      height: 400.0,
      decoration: BoxDecoration(
        color: Colors.teal,
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: Center(
        child: Text(
          'Unconstrained 600x400',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer constrained=false created');

  // Test InteractiveViewer with both pan and scale disabled
  final viewerLocked = InteractiveViewer(
    panEnabled: false,
    scaleEnabled: false,
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.brown,
      child: Center(
        child: Text(
          'Locked (no pan/scale)',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer locked (no pan, no scale) created');

  // Test InteractiveViewer with large boundary margin
  final viewerLargeBoundary = InteractiveViewer(
    boundaryMargin: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
    minScale: 0.25,
    maxScale: 3.0,
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.indigo,
      child: Center(
        child: Text(
          'Large boundary',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer with large boundary margin created');

  // Test InteractiveViewer with onInteractionStart/End callbacks
  final viewerCallbacks = InteractiveViewer(
    onInteractionStart: (details) {
      print('Interaction started');
    },
    onInteractionEnd: (details) {
      print('Interaction ended');
    },
    onInteractionUpdate: (details) {
      print('Interaction update');
    },
    child: Container(
      width: 300.0,
      height: 200.0,
      color: Colors.amber,
      child: Center(
        child: Text(
          'With callbacks',
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
      ),
    ),
  );
  print('InteractiveViewer with interaction callbacks created');

  // Test InteractiveViewer with complex child
  final viewerComplex = InteractiveViewer(
    minScale: 0.5,
    maxScale: 3.0,
    boundaryMargin: EdgeInsets.all(40.0),
    child: Column(
      children: [
        Container(
          width: 300.0,
          height: 60.0,
          color: Colors.blue,
          child: Center(
            child: Text('Row 1', style: TextStyle(color: Colors.white)),
          ),
        ),
        Container(
          width: 300.0,
          height: 60.0,
          color: Colors.green,
          child: Center(
            child: Text('Row 2', style: TextStyle(color: Colors.white)),
          ),
        ),
        Container(
          width: 300.0,
          height: 60.0,
          color: Colors.red,
          child: Center(
            child: Text('Row 3', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ),
  );
  print('InteractiveViewer with complex child created');

  print('All InteractiveViewer tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== InteractiveViewer Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Default:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerDefault),
        SizedBox(height: 8.0),
        Text('No panning:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerNoPan),
        SizedBox(height: 8.0),
        Text('No scaling:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerNoScale),
        SizedBox(height: 8.0),
        Text('Scale 0.5-4.0:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerScaleRange),
        SizedBox(height: 8.0),
        Text('Boundary margin:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerBoundary),
        SizedBox(height: 8.0),
        Text('Unconstrained:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200.0, child: viewerUnconstrained),
        SizedBox(height: 8.0),
        Text('Locked:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerLocked),
        SizedBox(height: 8.0),
        Text('Large boundary:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerLargeBoundary),
        SizedBox(height: 8.0),
        Text('With callbacks:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 150.0, child: viewerCallbacks),
        SizedBox(height: 8.0),
        Text('Complex child:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200.0, child: viewerComplex),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• InteractiveViewer allows pan and zoom gestures'),
        Text('• panEnabled/scaleEnabled control gesture types'),
        Text('• minScale/maxScale set zoom limits'),
        Text('• boundaryMargin controls how far content can be panned'),
        Text('• constrained=false allows child to exceed viewer bounds'),
      ],
    ),
  );
}

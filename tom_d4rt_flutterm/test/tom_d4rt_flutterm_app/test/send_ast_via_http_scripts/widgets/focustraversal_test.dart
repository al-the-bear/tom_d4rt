// ignore_for_file: avoid_print
// D4rt test script: Tests FocusTraversalGroup and FocusManager from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FocusTraversal test executing');

  // Test FocusManager.instance
  final focusManager = FocusManager.instance;
  print('FocusManager.instance accessed');
  print('FocusManager runtimeType: ${focusManager.runtimeType}');
  print('FocusManager primaryFocus: ${focusManager.primaryFocus}');

  // Test FocusTraversalGroup with default policy
  final group1 = FocusTraversalGroup(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          child: Text('Button 1'),
          onPressed: () => print('Button 1 pressed'),
        ),
        ElevatedButton(
          child: Text('Button 2'),
          onPressed: () => print('Button 2 pressed'),
        ),
        ElevatedButton(
          child: Text('Button 3'),
          onPressed: () => print('Button 3 pressed'),
        ),
      ],
    ),
  );
  print('FocusTraversalGroup with default policy created');

  // Test FocusTraversalGroup with ReadingOrderTraversalPolicy
  final group2 = FocusTraversalGroup(
    policy: ReadingOrderTraversalPolicy(),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 80.0,
          child: ElevatedButton(
            child: Text('A'),
            onPressed: () => print('A pressed'),
          ),
        ),
        SizedBox(width: 8.0),
        SizedBox(
          width: 80.0,
          child: ElevatedButton(
            child: Text('B'),
            onPressed: () => print('B pressed'),
          ),
        ),
        SizedBox(width: 8.0),
        SizedBox(
          width: 80.0,
          child: ElevatedButton(
            child: Text('C'),
            onPressed: () => print('C pressed'),
          ),
        ),
      ],
    ),
  );
  print('FocusTraversalGroup with ReadingOrderTraversalPolicy created');

  // Test FocusTraversalGroup with OrderedTraversalPolicy
  final group3 = FocusTraversalGroup(
    policy: OrderedTraversalPolicy(),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FocusTraversalOrder(
          order: NumericFocusOrder(3.0),
          child: ElevatedButton(
            child: Text('Third'),
            onPressed: () => print('Third pressed'),
          ),
        ),
        FocusTraversalOrder(
          order: NumericFocusOrder(1.0),
          child: ElevatedButton(
            child: Text('First'),
            onPressed: () => print('First pressed'),
          ),
        ),
        FocusTraversalOrder(
          order: NumericFocusOrder(2.0),
          child: ElevatedButton(
            child: Text('Second'),
            onPressed: () => print('Second pressed'),
          ),
        ),
      ],
    ),
  );
  print('FocusTraversalGroup with OrderedTraversalPolicy created');
  print('NumericFocusOrder used to set traversal order: 3, 1, 2');

  // Test nested FocusTraversalGroups
  final nestedGroups = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      FocusTraversalGroup(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text('Group1-A'),
              onPressed: () => print('Group1-A'),
            ),
            SizedBox(width: 4.0),
            ElevatedButton(
              child: Text('Group1-B'),
              onPressed: () => print('Group1-B'),
            ),
          ],
        ),
      ),
      SizedBox(height: 8.0),
      FocusTraversalGroup(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text('Group2-A'),
              onPressed: () => print('Group2-A'),
            ),
            SizedBox(width: 4.0),
            ElevatedButton(
              child: Text('Group2-B'),
              onPressed: () => print('Group2-B'),
            ),
          ],
        ),
      ),
    ],
  );
  print('Nested FocusTraversalGroups created');

  print('FocusTraversal test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FocusTraversalGroup / FocusManager Tests'),
      SizedBox(height: 8.0),
      group1,
      SizedBox(height: 8.0),
      group2,
      SizedBox(height: 8.0),
      group3,
      SizedBox(height: 8.0),
      nestedGroups,
    ],
  );
}

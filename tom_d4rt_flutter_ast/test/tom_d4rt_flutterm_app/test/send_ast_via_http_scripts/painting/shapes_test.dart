// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RoundedRectangleBorder, CircleBorder, StadiumBorder, BeveledRectangleBorder, ContinuousRectangleBorder, OvalBorder
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ShapesTest test executing');

  // RoundedRectangleBorder
  final roundedRect = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
    side: BorderSide(color: Colors.blue, width: 2.0),
  );
  print('RoundedRectangleBorder borderRadius: ${roundedRect.borderRadius}');
  print('RoundedRectangleBorder side: ${roundedRect.side}');

  // CircleBorder
  final circle = CircleBorder(side: BorderSide(color: Colors.red, width: 1.5));
  print('CircleBorder side: ${circle.side}');

  // StadiumBorder
  final stadium = StadiumBorder(
    side: BorderSide(color: Colors.green, width: 2.0),
  );
  print('StadiumBorder side: ${stadium.side}');

  // BeveledRectangleBorder
  final beveled = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
    side: BorderSide(color: Colors.orange, width: 1.0),
  );
  print('BeveledRectangleBorder borderRadius: ${beveled.borderRadius}');
  print('BeveledRectangleBorder side: ${beveled.side}');

  // ContinuousRectangleBorder
  final continuous = ContinuousRectangleBorder(
    borderRadius: BorderRadius.circular(16.0),
    side: BorderSide(color: Colors.purple, width: 1.0),
  );
  print('ContinuousRectangleBorder borderRadius: ${continuous.borderRadius}');
  print('ContinuousRectangleBorder side: ${continuous.side}');

  // OvalBorder
  final oval = OvalBorder(side: BorderSide(color: Colors.teal, width: 2.0));
  print('OvalBorder side: ${oval.side}');

  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          shape: roundedRect,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('RoundedRectangleBorder'),
          ),
        ),
        SizedBox(height: 8.0),
        Material(
          shape: circle,
          color: Colors.blue.shade50,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('CircleBorder'),
          ),
        ),
        SizedBox(height: 8.0),
        Card(
          shape: stadium,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('StadiumBorder'),
          ),
        ),
        SizedBox(height: 8.0),
        Card(
          shape: beveled,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('BeveledRectangleBorder'),
          ),
        ),
        SizedBox(height: 8.0),
        Card(
          shape: continuous,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('ContinuousRectangleBorder'),
          ),
        ),
        SizedBox(height: 8.0),
        Material(
          shape: oval,
          color: Colors.teal.shade50,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('OvalBorder'),
          ),
        ),
      ],
    ),
  );
}

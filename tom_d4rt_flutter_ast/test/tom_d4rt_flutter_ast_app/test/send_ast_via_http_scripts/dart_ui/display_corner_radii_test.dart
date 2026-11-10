// ignore_for_file: avoid_print
// D4rt test script: DisplayCornerRadii (dart:ui, Flutter 3.47).
//
// DisplayCornerRadii are the radii of a display's rounded corners, which a
// FlutterView reports through `displayCornerRadii` (null where the platform
// does not say). The script reads the current view's value, builds radii of
// its own, compares them, and draws a frame with those corners.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== DisplayCornerRadii ===');
  final reported = View.of(context).displayCornerRadii;
  print('view reports radii: ${reported != null}');

  const phone = ui.DisplayCornerRadii(
    topLeft: 39,
    topRight: 39,
    bottomRight: 39,
    bottomLeft: 39,
  );
  const phoneAgain = ui.DisplayCornerRadii(
    topLeft: 39,
    topRight: 39,
    bottomRight: 39,
    bottomLeft: 39,
  );
  const tablet = ui.DisplayCornerRadii(
    topLeft: 18,
    topRight: 18,
    bottomRight: 12,
    bottomLeft: 12,
  );
  print('phone topLeft: ${phone.topLeft}');
  print('tablet bottomRight: ${tablet.bottomRight}');
  print('phone == phoneAgain: ${phone == phoneAgain}');
  print('hashCodes match: ${phone.hashCode == phoneAgain.hashCode}');
  print('phone == tablet: ${phone == tablet}');
  print('tablet: $tablet');

  final shown = reported ?? tablet;
  return Center(
    child: Container(
      width: 220,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo, width: 3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(shown.topLeft),
          topRight: Radius.circular(shown.topRight),
          bottomRight: Radius.circular(shown.bottomRight),
          bottomLeft: Radius.circular(shown.bottomLeft),
        ),
      ),
      alignment: Alignment.center,
      child: Text(reported == null ? 'no radii reported' : 'reported radii'),
    ),
  );
}

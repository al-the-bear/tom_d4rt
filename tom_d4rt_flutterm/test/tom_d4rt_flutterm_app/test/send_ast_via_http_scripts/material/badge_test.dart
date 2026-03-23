// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Badge and FlutterLogo from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Badge and FlutterLogo test executing');

  // ========== BADGE ==========
  print('--- Badge Tests ---');

  // Variation 1: Basic Badge (dot indicator)
  final widget1 = Badge(child: Icon(Icons.mail, size: 32));
  print('Badge(dot, child: Icon) created');

  // Variation 2: Badge with label
  final widget2 = Badge(
    label: Text('5'),
    child: Icon(Icons.notifications, size: 32),
  );
  print('Badge(label: 5) created');

  // Variation 3: Badge with large count
  final widget3 = Badge(
    label: Text('99+'),
    child: Icon(Icons.shopping_cart, size: 32),
  );
  print('Badge(label: 99+) created');

  // Variation 4: Badge with backgroundColor
  final widget4 = Badge(
    label: Text('3'),
    backgroundColor: Colors.green,
    child: Icon(Icons.message, size: 32),
  );
  print('Badge(backgroundColor: green) created');

  // Variation 5: Badge with textColor
  final widget5 = Badge(
    label: Text('7'),
    backgroundColor: Colors.blue,
    textColor: Colors.yellow,
    child: Icon(Icons.inbox, size: 32),
  );
  print('Badge(textColor: yellow) created');

  // Variation 6: Badge with isLabelVisible false
  final widget6 = Badge(
    label: Text('0'),
    isLabelVisible: false,
    child: Icon(Icons.chat, size: 32),
  );
  print('Badge(isLabelVisible: false) created');

  // Variation 7: Badge with offset
  final widget7 = Badge(
    label: Text('2'),
    offset: Offset(4, -4),
    child: Icon(Icons.favorite, size: 32),
  );
  print('Badge(offset) created');

  // Variation 8: Badge with alignment
  final widget8 = Badge(
    label: Text('1'),
    alignment: AlignmentDirectional.bottomEnd,
    child: Icon(Icons.star, size: 32),
  );
  print('Badge(alignment: bottomEnd) created');

  // Variation 9: Badge with textStyle
  final widget9 = Badge(
    label: Text('NEW'),
    textStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
    child: Icon(Icons.local_offer, size: 32),
  );
  print('Badge(textStyle) created');

  // Variation 10: Badge with padding
  final widget10 = Badge(
    label: Text('Hi'),
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    child: Icon(Icons.person, size: 32),
  );
  print('Badge(padding) created');

  // ========== FLUTTERLOGO ==========
  print('--- FlutterLogo Tests ---');

  // Variation 11: Basic FlutterLogo
  final widget11 = FlutterLogo();
  print('FlutterLogo() created');

  // Variation 12: FlutterLogo with size
  final widget12 = FlutterLogo(size: 80);
  print('FlutterLogo(size: 80) created');

  // Variation 13: FlutterLogo with textColor
  final widget13 = FlutterLogo(size: 60, textColor: Colors.blue);
  print('FlutterLogo(textColor: blue) created');

  // Variation 14: FlutterLogo with style markOnly
  final widget14 = FlutterLogo(size: 100, style: FlutterLogoStyle.markOnly);
  print('FlutterLogo(style: markOnly) created');

  // Variation 15: FlutterLogo with style horizontal
  final widget15 = FlutterLogo(size: 120, style: FlutterLogoStyle.horizontal);
  print('FlutterLogo(style: horizontal) created');

  // Variation 16: FlutterLogo with style stacked
  final widget16 = FlutterLogo(size: 100, style: FlutterLogoStyle.stacked);
  print('FlutterLogo(style: stacked) created');

  // Variation 17: FlutterLogo with duration and curve
  final widget17 = FlutterLogo(
    size: 64,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );
  print('FlutterLogo(duration, curve) created');

  print('Badge and FlutterLogo test completed');
  return SingleChildScrollView(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [widget1, widget2, widget3, widget4, widget5],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [widget6, widget7, widget8, widget9, widget10],
        ),
        SizedBox(height: 24),
        widget11,
        SizedBox(height: 8),
        widget12,
        SizedBox(height: 8),
        widget14,
        SizedBox(height: 8),
        widget15,
        SizedBox(height: 8),
        widget16,
        SizedBox(height: 8),
        widget17,
      ],
    ),
  );
}

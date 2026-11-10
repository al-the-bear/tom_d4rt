// ignore_for_file: avoid_print
// D4rt test script: TextInputStyle (services, Flutter 3.47).
//
// TextInputStyle is the style a text input connection reports to the
// platform's input method. The script builds two styles, reads every field,
// compares them with `==`, and shows the diagnostics they describe.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget styleCard(String title, TextInputStyle style) {
  return Card(
    margin: const EdgeInsets.all(8),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('fontFamily: ${style.fontFamily}'),
          Text('fontSize: ${style.fontSize}'),
          Text('fontWeight: ${style.fontWeight}'),
          Text('textDirection: ${style.textDirection.name}'),
          Text('textAlign: ${style.textAlign.name}'),
          Text('letterSpacing: ${style.letterSpacing}'),
          Text('wordSpacing: ${style.wordSpacing}'),
          Text('lineHeight: ${style.lineHeight}'),
        ],
      ),
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== TextInputStyle ===');
  const minimal = TextInputStyle(
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.start,
  );
  const full = TextInputStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    textDirection: TextDirection.rtl,
    textAlign: TextAlign.end,
    letterSpacing: 0.5,
    wordSpacing: 2,
    lineHeight: 1.4,
  );
  const fullAgain = TextInputStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    textDirection: TextDirection.rtl,
    textAlign: TextAlign.end,
    letterSpacing: 0.5,
    wordSpacing: 2,
    lineHeight: 1.4,
  );
  print('minimal fontSize: ${minimal.fontSize}');
  print('full fontFamily: ${full.fontFamily}');
  print('full == fullAgain: ${full == fullAgain}');
  print('hashCodes match: ${full.hashCode == fullAgain.hashCode}');
  print('minimal == full: ${minimal == full}');
  print('toStringShort: ${full.toStringShort()}');

  return SingleChildScrollView(
    child: Column(
      children: [
        styleCard('Minimal', minimal),
        styleCard('Full', full),
        Text('full == fullAgain: ${full == fullAgain}'),
      ],
    ),
  );
}

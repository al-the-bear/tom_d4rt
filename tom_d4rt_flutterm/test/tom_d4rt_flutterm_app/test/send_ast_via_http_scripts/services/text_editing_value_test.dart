// ignore_for_file: avoid_print
// D4rt test script: Tests TextEditingValue, TextSelection, TextRange,
// ClipboardData, FilteringTextInputFormatter, LengthLimitingTextInputFormatter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Text editing value tests executing');

  // ========== TextEditingValue ==========
  print('--- TextEditingValue Tests ---');

  final tev1 = TextEditingValue(
    text: 'Hello World',
    selection: TextSelection.collapsed(offset: 5),
  );
  print('TextEditingValue text: ${tev1.text}');
  print('TextEditingValue selection: ${tev1.selection}');
  print('TextEditingValue composing: ${tev1.composing}');

  final tev2 = TextEditingValue.empty;
  print('TextEditingValue.empty text: "${tev2.text}"');
  print('TextEditingValue.empty selection: ${tev2.selection}');

  final tev3 = tev1.copyWith(text: 'Hello Dart');
  print('TextEditingValue copyWith text: ${tev3.text}');

  final replaced = tev1.replaced(TextRange(start: 6, end: 11), 'Flutter');
  print('TextEditingValue replaced: ${replaced.text}');

  // ========== TextSelection ==========
  print('--- TextSelection Tests ---');

  final sel1 = TextSelection(baseOffset: 2, extentOffset: 7);
  print('TextSelection base: ${sel1.baseOffset}, extent: ${sel1.extentOffset}');
  print('TextSelection isCollapsed: ${sel1.isCollapsed}');
  print('TextSelection isDirectional: ${sel1.isDirectional}');

  final sel2 = TextSelection.collapsed(offset: 3);
  print('TextSelection.collapsed offset: ${sel2.baseOffset}');
  print('TextSelection.collapsed isCollapsed: ${sel2.isCollapsed}');

  final sel3 = TextSelection.fromPosition(TextPosition(offset: 5));
  print('TextSelection.fromPosition: ${sel3.baseOffset}');

  // ========== TextRange ==========
  print('--- TextRange Tests ---');

  final range1 = TextRange(start: 2, end: 8);
  print('TextRange start: ${range1.start}, end: ${range1.end}');
  print('TextRange isValid: ${range1.isValid}');
  print('TextRange isCollapsed: ${range1.isCollapsed}');
  print('TextRange isNormalized: ${range1.isNormalized}');

  final rangeEmpty = TextRange.empty;
  print('TextRange.empty: start=${rangeEmpty.start}, end=${rangeEmpty.end}');

  final text = 'Hello World';
  print('TextRange textBefore: ${range1.textBefore(text)}');
  print('TextRange textInside: ${range1.textInside(text)}');
  print('TextRange textAfter: ${range1.textAfter(text)}');

  // ========== ClipboardData ==========
  print('--- ClipboardData Tests ---');

  final clipData = ClipboardData(text: 'copied text');
  print('ClipboardData text: ${clipData.text}');

  // ========== FilteringTextInputFormatter ==========
  print('--- FilteringTextInputFormatter Tests ---');

  final digitsOnly = FilteringTextInputFormatter.digitsOnly;
  print('digitsOnly: $digitsOnly');

  final allowFilter = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));
  print('allow letters filter: $allowFilter');

  final denyFilter = FilteringTextInputFormatter.deny(RegExp(r'[0-9]'));
  print('deny digits filter: $denyFilter');

  final singleLineFormatter = FilteringTextInputFormatter.singleLineFormatter;
  print('singleLineFormatter: $singleLineFormatter');

  // ========== LengthLimitingTextInputFormatter ==========
  print('--- LengthLimitingTextInputFormatter Tests ---');

  final lengthLimit = LengthLimitingTextInputFormatter(100);
  print('LengthLimitingTextInputFormatter maxLength: ${lengthLimit.maxLength}');

  final lengthLimitTruncate = LengthLimitingTextInputFormatter(
    50,
    maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
  );
  print(
    'LengthLimitingTextInputFormatter with enforcement: ${lengthLimitTruncate.maxLength}',
  );

  print('All text editing value tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Text Editing Value Tests',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('TEV text: ${tev1.text}'),
            Text('Selection: ${sel1.baseOffset}-${sel1.extentOffset}'),
            Text('Range: ${range1.start}-${range1.end}'),
            Text('ClipboardData text: ${clipData.text}'),
            SizedBox(height: 12.0),
            TextField(
              controller: TextEditingController(text: 'Formatted'),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                LengthLimitingTextInputFormatter(20),
              ],
              decoration: InputDecoration(labelText: 'Letters only (max 20)'),
            ),
          ],
        ),
      ),
    ),
  );
}

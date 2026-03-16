// D4rt test script: Tests SystemUiOverlayStyle, TextEditingDelta concepts from services
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Services text boundary / overlay style test executing');

  // ========== SYSTEMUIOVERLAYSTYLE ==========
  print('--- SystemUiOverlayStyle Tests ---');

  final style1 = SystemUiOverlayStyle(
    statusBarColor: Color(0xFF000000),
    statusBarBrightness: Brightness.dark,
  );
  print('SystemUiOverlayStyle created');
  print('  statusBarColor: ${style1.statusBarColor}');
  print('  statusBarBrightness: ${style1.statusBarBrightness}');
  print('  runtimeType: ${style1.runtimeType}');

  final style2 = SystemUiOverlayStyle(
    statusBarColor: Color(0xFFFFFFFF),
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Color(0xFF000000),
    systemNavigationBarDividerColor: Color(0xFF333333),
    systemNavigationBarIconBrightness: Brightness.light,
  );
  print('Full SystemUiOverlayStyle:');
  print('  statusBarColor: ${style2.statusBarColor}');
  print('  statusBarBrightness: ${style2.statusBarBrightness}');
  print('  statusBarIconBrightness: ${style2.statusBarIconBrightness}');
  print('  systemNavigationBarColor: ${style2.systemNavigationBarColor}');
  print(
    '  systemNavigationBarDividerColor: ${style2.systemNavigationBarDividerColor}',
  );
  print(
    '  systemNavigationBarIconBrightness: ${style2.systemNavigationBarIconBrightness}',
  );

  // Predefined styles
  final light = SystemUiOverlayStyle.light;
  print('SystemUiOverlayStyle.light:');
  print('  statusBarBrightness: ${light.statusBarBrightness}');
  print('  statusBarIconBrightness: ${light.statusBarIconBrightness}');

  final dark = SystemUiOverlayStyle.dark;
  print('SystemUiOverlayStyle.dark:');
  print('  statusBarBrightness: ${dark.statusBarBrightness}');
  print('  statusBarIconBrightness: ${dark.statusBarIconBrightness}');

  // copyWith
  final modified = light.copyWith(statusBarColor: Color(0xFF4CAF50));
  print('light.copyWith(statusBarColor: green):');
  print('  statusBarColor: ${modified.statusBarColor}');
  print('  statusBarBrightness: ${modified.statusBarBrightness}');

  // ========== TEXTEDITINGDELTA ==========
  print('--- TextEditingDelta Tests ---');

  // TextEditingDeltaInsertion
  final insertion = TextEditingDeltaInsertion(
    oldText: 'Hello',
    textInserted: ' World',
    insertionOffset: 5,
    selection: TextSelection.collapsed(offset: 11),
    composing: TextRange.empty,
  );
  print('TextEditingDeltaInsertion:');
  print('  oldText: "${insertion.oldText}"');
  print('  textInserted: "${insertion.textInserted}"');
  print('  insertionOffset: ${insertion.insertionOffset}');
  print('  runtimeType: ${insertion.runtimeType}');

  // TextEditingDeltaDeletion
  final deletion = TextEditingDeltaDeletion(
    oldText: 'Hello World',
    deletedRange: TextRange(start: 5, end: 11),
    selection: TextSelection.collapsed(offset: 5),
    composing: TextRange.empty,
  );
  print('TextEditingDeltaDeletion:');
  print('  oldText: "${deletion.oldText}"');
  print('  deletedRange: ${deletion.deletedRange}');
  print('  runtimeType: ${deletion.runtimeType}');

  // TextEditingDeltaReplacement
  final replacement = TextEditingDeltaReplacement(
    oldText: 'Hello World',
    replacementText: 'Dart',
    replacedRange: TextRange(start: 6, end: 11),
    selection: TextSelection.collapsed(offset: 10),
    composing: TextRange.empty,
  );
  print('TextEditingDeltaReplacement:');
  print('  oldText: "${replacement.oldText}"');
  print('  replacementText: "${replacement.replacementText}"');
  print('  replacedRange: ${replacement.replacedRange}');
  print('  runtimeType: ${replacement.runtimeType}');

  // TextEditingDeltaNonTextUpdate
  final nonTextUpdate = TextEditingDeltaNonTextUpdate(
    oldText: 'Hello',
    selection: TextSelection(baseOffset: 0, extentOffset: 5),
    composing: TextRange.empty,
  );
  print('TextEditingDeltaNonTextUpdate:');
  print('  oldText: "${nonTextUpdate.oldText}"');
  print('  runtimeType: ${nonTextUpdate.runtimeType}');

  // ========== TEXTSELECTION ==========
  print('--- TextSelection Tests ---');

  final sel1 = TextSelection(baseOffset: 0, extentOffset: 5);
  print('TextSelection(0, 5):');
  print('  baseOffset: ${sel1.baseOffset}');
  print('  extentOffset: ${sel1.extentOffset}');
  print('  isCollapsed: ${sel1.isCollapsed}');
  print('  isDirectional: ${sel1.isDirectional}');

  final collapsed = TextSelection.collapsed(offset: 3);
  print('TextSelection.collapsed(3):');
  print('  baseOffset: ${collapsed.baseOffset}');
  print('  isCollapsed: ${collapsed.isCollapsed}');

  final fromPosition = TextSelection.fromPosition(TextPosition(offset: 7));
  print('TextSelection.fromPosition(7): offset=${fromPosition.baseOffset}');

  // ========== RETURN WIDGET ==========
  print('Services text boundary / overlay style test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services Text Boundary Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• SystemUiOverlayStyle - status/nav bar style'),
          Text('• TextEditingDeltaInsertion - text insert delta'),
          Text('• TextEditingDeltaDeletion - text delete delta'),
          Text('• TextEditingDeltaReplacement - text replace delta'),
          Text('• TextEditingDeltaNonTextUpdate - selection delta'),
          Text('• TextSelection - text selection range'),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFE8F5E9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Overlay Styles:'),
                Text('  light brightness: ${light.statusBarBrightness}'),
                Text('  dark brightness: ${dark.statusBarBrightness}'),
                SizedBox(height: 8.0),
                Text('TextSelection(0,5) collapsed: ${sel1.isCollapsed}'),
                Text('TextSelection.collapsed(3): ${collapsed.isCollapsed}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// D4rt test script: Tests VerticalCaretMovementRun from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('VerticalCaretMovementRun test executing');

  // ========== VerticalCaretMovementRun Overview ==========
  print('--- VerticalCaretMovementRun Overview ---');
  print('  VerticalCaretMovementRun is an Iterator<TextPosition>');
  print('  Used for vertical caret movement in text editing');
  print('  Tracks caret position during up/down arrow key navigation');

  // ========== VerticalCaretMovementRun Creation via RenderEditable ==========
  print('--- VerticalCaretMovementRun Creation Context ---');
  // VerticalCaretMovementRun is typically created via RenderEditable.startVerticalCaretMovement
  print('  Created via: RenderEditable.startVerticalCaretMovement()');
  print('  Iterator type: Iterator<TextPosition>');
  print('  Maintains horizontal position preference during vertical movement');

  // ========== TextPosition Related Tests ==========
  print('--- TextPosition Related Tests ---');
  final position1 = TextPosition(offset: 0);
  print('  TextPosition(offset: 0): $position1');
  print('    offset: ${position1.offset}');
  print('    affinity: ${position1.affinity}');

  final position2 = TextPosition(offset: 10, affinity: TextAffinity.downstream);
  print('  TextPosition(offset: 10, downstream): $position2');
  print('    offset: ${position2.offset}');
  print('    affinity: ${position2.affinity}');

  final position3 = TextPosition(offset: 20, affinity: TextAffinity.upstream);
  print('  TextPosition(offset: 20, upstream): $position3');
  print('    offset: ${position3.offset}');
  print('    affinity: ${position3.affinity}');

  // ========== TextPosition Equality ==========
  print('--- TextPosition Equality ---');
  final posA = TextPosition(offset: 5);
  final posB = TextPosition(offset: 5);
  final posC = TextPosition(offset: 10);
  print('  position(5) == position(5): ${posA == posB}');
  print('  position(5) == position(10): ${posA == posC}');

  final posUp = TextPosition(offset: 5, affinity: TextAffinity.upstream);
  final posDown = TextPosition(offset: 5, affinity: TextAffinity.downstream);
  print('  pos(5, upstream) == pos(5, downstream): ${posUp == posDown}');

  // ========== TextAffinity Values ==========
  print('--- TextAffinity Values ---');
  for (final affinity in TextAffinity.values) {
    print('  ${affinity.name}: index=${affinity.index}');
  }
  print('  TextAffinity.values.length: ${TextAffinity.values.length}');

  // ========== TextSelection for Context ==========
  print('--- TextSelection for Context ---');
  final selection1 = TextSelection.collapsed(offset: 0);
  print('  collapsed(offset: 0): $selection1');
  print('    isCollapsed: ${selection1.isCollapsed}');
  print('    baseOffset: ${selection1.baseOffset}');
  print('    extentOffset: ${selection1.extentOffset}');

  final selection2 = TextSelection(baseOffset: 0, extentOffset: 10);
  print('  selection(0, 10): $selection2');
  print('    isCollapsed: ${selection2.isCollapsed}');
  print('    start: ${selection2.start}');
  print('    end: ${selection2.end}');

  // ========== TextRange Tests ==========
  print('--- TextRange Tests ---');
  final range1 = TextRange(start: 0, end: 10);
  print('  TextRange(0, 10): $range1');
  print('    start: ${range1.start}');
  print('    end: ${range1.end}');
  print('    isValid: ${range1.isValid}');
  print('    isCollapsed: ${range1.isCollapsed}');
  print('    isNormalized: ${range1.isNormalized}');

  final range2 = TextRange.collapsed(5);
  print('  TextRange.collapsed(5): $range2');
  print('    isCollapsed: ${range2.isCollapsed}');

  final emptyRange = TextRange.empty;
  print('  TextRange.empty: $emptyRange');
  print('    isValid: ${emptyRange.isValid}');

  // ========== Iterator Protocol ==========
  print('--- Iterator Protocol for VerticalCaretMovementRun ---');
  print('  moveNext(): advances to next position');
  print('  current: returns current TextPosition');
  print('  Returns false when no more positions');

  // ========== TextPainter Simulated Usage Context ==========
  print('--- TextPainter Simulated Usage Context ---');
  final textSpan = TextSpan(
    text: 'Hello World\nSecond Line\nThird Line',
    style: TextStyle(fontSize: 16.0),
  );
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(maxWidth: 200.0);
  print('  TextPainter created with multi-line text');
  print('  width: ${textPainter.width}');
  print('  height: ${textPainter.height}');
  print('  minIntrinsicWidth: ${textPainter.minIntrinsicWidth}');
  print('  maxIntrinsicWidth: ${textPainter.maxIntrinsicWidth}');

  // ========== Caret Position Calculation ==========
  print('--- Caret Position Calculation ---');
  final caretOffset1 = textPainter.getOffsetForCaret(TextPosition(offset: 0), Rect.zero);
  print('  caret at offset 0: $caretOffset1');

  final caretOffset2 = textPainter.getOffsetForCaret(TextPosition(offset: 5), Rect.zero);
  print('  caret at offset 5: $caretOffset2');

  final caretOffset3 = textPainter.getOffsetForCaret(TextPosition(offset: 12), Rect.zero);
  print('  caret at offset 12 (newline): $caretOffset3');

  print('VerticalCaretMovementRun test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('VerticalCaretMovementRun Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Type: Iterator<TextPosition>'),
          Text('Created via: RenderEditable.startVerticalCaretMovement'),
          Text('TextPosition tests: offset, affinity'),
          Text('TextSelection tests: collapsed, range'),
          Text('TextRange tests: start, end, validity'),
          Text('TextPainter caret position calculation tested'),
        ],
      ),
    ),
  );
}

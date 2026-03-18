// D4rt test script: Tests TextLayoutMetrics from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextLayoutMetrics test executing');
  print('=' * 50);

  // TextLayoutMetrics is an abstract interface
  print('\nTextLayoutMetrics:');
  print('Abstract interface for text layout queries');
  print('Implemented by RenderEditable, RenderParagraph');

  // Interface methods
  print('\nTextLayoutMetrics methods:');
  print('getLineAtOffset(position): TextSelection');
  print('getTextPositionAbove(position): TextPosition');
  print('getTextPositionBelow(position): TextPosition');
  print('getWordBoundary(position): TextRange');

  // Line selection
  print('\ngetLineAtOffset:');
  print('- Returns selection for entire line');
  print('- Used for triple-click select line');
  print('- Input: TextPosition');
  print('- Output: TextSelection spanning line');

  // Vertical navigation
  print('\ngetTextPositionAbove/Below:');
  print('- Navigate cursor vertically');
  print('- Used for up/down arrow keys');
  print('- Maintains horizontal position');
  print('- Handles line wrapping');

  // Word boundaries
  print('\ngetWordBoundary:');
  print('- Returns word at position');
  print('- Used for double-click select word');
  print('- Used for Ctrl+Left/Right navigation');
  print('- Input: TextPosition');
  print('- Output: TextRange for word');

  // Implementation in widgets
  print('\nImplementing widgets:');
  print('- RenderEditable (TextField)');
  print('- RenderParagraph (Text)');
  print('- EditableText uses this interface');

  // Usage example
  print('\nUsage example:');
  print('// In text action shortcuts:');
  print('final line = metrics.getLineAtOffset(position);');
  print('final word = metrics.getWordBoundary(position);');
  print('final above = metrics.getTextPositionAbove(position);');

  // Platform text actions
  print('\nPlatform text actions using metrics:');
  print('- Cmd+Up: Move to text start');
  print('- Cmd+Down: Move to text end');
  print('- Opt+Up: Move to paragraph start');
  print('- Opt+Down: Move to paragraph end');

  // Type hierarchy
  print('\nType hierarchy:');
  print('TextLayoutMetrics (abstract interface)');
  print('  Implemented by text render objects');

  // Explain purpose
  print('\nTextLayoutMetrics purpose:');
  print('- Query text layout information');
  print('- Find line/word boundaries');
  print('- Navigate text vertically');
  print('- Support text selection gestures');
  print('- Enable keyboard navigation');

  print('\n' + '=' * 50);
  print('TextLayoutMetrics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextLayoutMetrics Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract interface'),
      Text('Methods: getLineAtOffset, getWordBoundary'),
      Text('getTextPositionAbove/Below'),
      Text('Purpose: Text layout queries'),
    ],
  );
}

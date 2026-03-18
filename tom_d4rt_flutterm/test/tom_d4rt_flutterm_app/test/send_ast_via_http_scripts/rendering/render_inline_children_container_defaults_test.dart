// D4rt test script: Tests RenderInlineChildrenContainerDefaults from rendering
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderInlineChildrenContainerDefaults test executing');
  print('=' * 50);

  // RenderInlineChildrenContainerDefaults mixin
  print('\nRenderInlineChildrenContainerDefaults:');
  print('Mixin providing defaults for inline children');
  print('Used by RenderParagraph for embedded widgets');

  // Purpose
  print('\nPurpose:');
  print('- Default implementations for inline children');
  print('- WidgetSpan support in RenderParagraph');
  print('- Child management for inline elements');

  // Mixin provides
  print('\nMixin provides:');
  print('- setInlineChild() default');
  print('- moveInlineChild() default');
  print('- removeInlineChild() default');
  print('- Child iteration helpers');

  // InlineSpan types
  print('\nInlineSpan types:');
  print('');
  print('TextSpan:');
  print('  - Text content');
  print('  - No inline children');
  print('');
  print('WidgetSpan:');
  print('  - Embedded widget');
  print('  - Needs inline child handling');

  // Usage with RenderParagraph
  print('\nUsage with RenderParagraph:');
  print('RichText(');
  print('  text: TextSpan(');
  print('    children: [');
  print('      TextSpan(text: "Hello "),');
  print('      WidgetSpan(child: Icon(Icons.star)),');
  print('      TextSpan(text: " World"),');
  print('    ],');
  print('  ),');
  print(');');

  // Default behavior
  print('\nDefault behavior:');
  print('- Provides no-op implementations');
  print('- Override for custom handling');
  print('- Simplifies mixin usage');

  // Type hierarchy
  print('\nType hierarchy:');
  print('RenderInlineChildrenContainerDefaults (mixin)');
  print('  \u2514\u2500 Mixed into RenderParagraph');

  // Explain purpose
  print('\nRenderInlineChildrenContainerDefaults purpose:');
  print('- Mixin for inline children');
  print('- Default implementations');
  print('- WidgetSpan support');
  print('- Used by RenderParagraph');
  print('- Simplifies inline handling');

  print('\n${'=' * 50}');
  print('RenderInlineChildrenContainerDefaults test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderInlineChildrenContainerDefaults Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: mixin'),
      Text('For: RenderParagraph'),
      Text('Supports: WidgetSpan'),
      Text('Purpose: Inline children'),
    ],
  );
}

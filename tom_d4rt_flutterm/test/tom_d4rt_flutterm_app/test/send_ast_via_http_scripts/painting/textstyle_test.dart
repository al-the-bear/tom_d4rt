// ignore_for_file: avoid_print
// D4rt test script: Tests TextStyle, TextSpan from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Painting textstyle test executing');

  // ========== TEXTSTYLE ==========
  print('--- TextStyle Tests ---');

  // Test basic TextStyle
  final basicStyle = TextStyle();
  print('TextStyle() default: $basicStyle');

  // Test TextStyle with color
  final colorStyle = TextStyle(color: Color(0xFF2196F3));
  print('TextStyle(color: blue): color=${colorStyle.color}');

  // Test TextStyle with fontSize
  final sizeStyle = TextStyle(fontSize: 24.0);
  print('TextStyle(fontSize: 24.0): fontSize=${sizeStyle.fontSize}');

  // Test TextStyle with fontWeight
  final boldStyle = TextStyle(fontWeight: FontWeight.bold);
  print('TextStyle(fontWeight: bold): fontWeight=${boldStyle.fontWeight}');

  final lightStyle = TextStyle(fontWeight: FontWeight.w300);
  print('TextStyle(fontWeight: w300): fontWeight=${lightStyle.fontWeight}');

  // Test all FontWeight values
  print('FontWeight.w100: ${FontWeight.w100}');
  print('FontWeight.w200: ${FontWeight.w200}');
  print('FontWeight.w300: ${FontWeight.w300}');
  print('FontWeight.w400: ${FontWeight.w400}');
  print('FontWeight.w500: ${FontWeight.w500}');
  print('FontWeight.w600: ${FontWeight.w600}');
  print('FontWeight.w700: ${FontWeight.w700}');
  print('FontWeight.w800: ${FontWeight.w800}');
  print('FontWeight.w900: ${FontWeight.w900}');

  // Test TextStyle with fontStyle
  final italicStyle = TextStyle(fontStyle: FontStyle.italic);
  print('TextStyle(fontStyle: italic): fontStyle=${italicStyle.fontStyle}');

  final normalItalicStyle = TextStyle(fontStyle: FontStyle.normal);
  print(
    'TextStyle(fontStyle: normal): fontStyle=${normalItalicStyle.fontStyle}',
  );

  // Test TextStyle with letterSpacing
  final letterSpacingStyle = TextStyle(letterSpacing: 2.0);
  print(
    'TextStyle(letterSpacing: 2.0): letterSpacing=${letterSpacingStyle.letterSpacing}',
  );

  // Test TextStyle with wordSpacing
  final wordSpacingStyle = TextStyle(wordSpacing: 4.0);
  print(
    'TextStyle(wordSpacing: 4.0): wordSpacing=${wordSpacingStyle.wordSpacing}',
  );

  // Test TextStyle with height
  final heightStyle = TextStyle(height: 1.5);
  print('TextStyle(height: 1.5): height=${heightStyle.height}');

  // Test TextStyle with fontFamily
  final fontFamilyStyle = TextStyle(fontFamily: 'Roboto');
  print(
    'TextStyle(fontFamily: Roboto): fontFamily=${fontFamilyStyle.fontFamily}',
  );

  // Test TextStyle with decoration
  final underlineStyle = TextStyle(decoration: TextDecoration.underline);
  print(
    'TextStyle(decoration: underline): decoration=${underlineStyle.decoration}',
  );

  final lineThroughStyle = TextStyle(decoration: TextDecoration.lineThrough);
  print(
    'TextStyle(decoration: lineThrough): decoration=${lineThroughStyle.decoration}',
  );

  final overlineStyle = TextStyle(decoration: TextDecoration.overline);
  print(
    'TextStyle(decoration: overline): decoration=${overlineStyle.decoration}',
  );

  final noneDecorationStyle = TextStyle(decoration: TextDecoration.none);
  print(
    'TextStyle(decoration: none): decoration=${noneDecorationStyle.decoration}',
  );

  // Test TextStyle with decorationColor
  final decorationColorStyle = TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: Color(0xFFE53935),
  );
  print(
    'TextStyle with decorationColor: decorationColor=${decorationColorStyle.decorationColor}',
  );

  // Test TextStyle with decorationStyle
  final solidDecorationStyle = TextStyle(
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.solid,
  );
  print(
    'TextStyle(decorationStyle: solid): ${solidDecorationStyle.decorationStyle}',
  );

  final doubleDecorationStyle = TextStyle(
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.double,
  );
  print(
    'TextStyle(decorationStyle: double): ${doubleDecorationStyle.decorationStyle}',
  );

  final dashedDecorationStyle = TextStyle(
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dashed,
  );
  print(
    'TextStyle(decorationStyle: dashed): ${dashedDecorationStyle.decorationStyle}',
  );

  final dottedDecorationStyle = TextStyle(
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dotted,
  );
  print(
    'TextStyle(decorationStyle: dotted): ${dottedDecorationStyle.decorationStyle}',
  );

  final wavyDecorationStyle = TextStyle(
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.wavy,
  );
  print(
    'TextStyle(decorationStyle: wavy): ${wavyDecorationStyle.decorationStyle}',
  );

  // Test TextStyle with decorationThickness
  final thickDecorationStyle = TextStyle(
    decoration: TextDecoration.underline,
    decorationThickness: 2.0,
  );
  print(
    'TextStyle(decorationThickness: 2.0): ${thickDecorationStyle.decorationThickness}',
  );

  // Test TextStyle with backgroundColor
  final backgroundColorStyle = TextStyle(backgroundColor: Color(0xFFFFEB3B));
  print(
    'TextStyle(backgroundColor: yellow): backgroundColor=${backgroundColorStyle.backgroundColor}',
  );

  // Test TextStyle with shadows
  final shadowStyle = TextStyle(
    shadows: [
      Shadow(
        color: Color(0x80000000),
        offset: Offset(2.0, 2.0),
        blurRadius: 4.0,
      ),
    ],
  );
  print('TextStyle with shadow: shadows=${shadowStyle.shadows}');

  // Test TextStyle with multiple shadows
  final multiShadowStyle = TextStyle(
    shadows: [
      Shadow(
        color: Color(0xFFE53935),
        offset: Offset(1.0, 1.0),
        blurRadius: 2.0,
      ),
      Shadow(
        color: Color(0xFF2196F3),
        offset: Offset(-1.0, -1.0),
        blurRadius: 2.0,
      ),
    ],
  );
  print(
    'TextStyle with multiple shadows: ${multiShadowStyle.shadows?.length} shadows',
  );

  // Test TextStyle with overflow
  final overflowStyle = TextStyle(overflow: TextOverflow.ellipsis);
  print('TextStyle(overflow: ellipsis): overflow=${overflowStyle.overflow}');

  // Test TextStyle.copyWith
  final originalStyle = TextStyle(fontSize: 16.0, color: Color(0xFF2196F3));
  final copiedStyle = originalStyle.copyWith(fontWeight: FontWeight.bold);
  print(
    'TextStyle.copyWith: original color=${originalStyle.color}, copied fontWeight=${copiedStyle.fontWeight}',
  );

  // Test TextStyle.apply
  final appliedStyle = originalStyle.apply(fontSizeFactor: 1.5);
  print(
    'TextStyle.apply(fontSizeFactor: 1.5): fontSize=${appliedStyle.fontSize}',
  );

  // Test TextStyle.merge
  final mergedStyle = originalStyle.merge(
    TextStyle(fontStyle: FontStyle.italic),
  );
  print('TextStyle.merge: fontStyle=${mergedStyle.fontStyle}');

  // Test TextStyle.lerp
  final lerpedStyle = TextStyle.lerp(
    TextStyle(fontSize: 12.0, color: Color(0xFF2196F3)),
    TextStyle(fontSize: 24.0, color: Color(0xFFE53935)),
    0.5,
  );
  print('TextStyle.lerp at 0.5: fontSize=${lerpedStyle?.fontSize}');

  // Test complete TextStyle
  final completeStyle = TextStyle(
    color: Color(0xFF2196F3),
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.5,
    wordSpacing: 1.0,
    height: 1.4,
    decoration: TextDecoration.none,
  );
  print(
    'Complete TextStyle: color=${completeStyle.color}, fontSize=${completeStyle.fontSize}',
  );

  // ========== TEXTSPAN ==========
  print('--- TextSpan Tests ---');

  // Test basic TextSpan
  final basicSpan = TextSpan(text: 'Hello World');
  print('TextSpan(text: "Hello World"): text=${basicSpan.text}');

  // Test TextSpan with style
  final styledSpan = TextSpan(
    text: 'Styled Text',
    style: TextStyle(color: Color(0xFF2196F3), fontSize: 20.0),
  );
  print(
    'TextSpan with style: text=${styledSpan.text}, style=${styledSpan.style}',
  );

  // Test TextSpan with children
  final parentSpan = TextSpan(
    text: 'Parent ',
    children: [
      TextSpan(text: 'Child 1 '),
      TextSpan(text: 'Child 2'),
    ],
  );
  print('TextSpan with children: ${parentSpan.children?.length} children');

  // Test nested TextSpan with styles
  final nestedSpan = TextSpan(
    text: 'Normal ',
    style: TextStyle(color: Color(0xFF000000)),
    children: [
      TextSpan(
        text: 'Bold ',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      TextSpan(
        text: 'Italic ',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      TextSpan(
        text: 'Colored',
        style: TextStyle(color: Color(0xFFE53935)),
      ),
    ],
  );
  print('Nested TextSpan created');

  // Test TextSpan.toPlainText
  final plainText = nestedSpan.toPlainText();
  print('TextSpan.toPlainText: "$plainText"');

  // Test TextSpan with recognizer (for taps)
  // Note: GestureRecognizer is complex, just showing structure
  final recognizerSpan = TextSpan(
    text: 'Tap me',
    style: TextStyle(
      color: Color(0xFF2196F3),
      decoration: TextDecoration.underline,
    ),
    // recognizer would be set here
  );
  print('TextSpan for tap: text=${recognizerSpan.text}');

  // Test TextSpan.visitChildren
  var visitCount = 0;
  nestedSpan.visitChildren((span) {
    visitCount++;
    return true;
  });
  print('TextSpan.visitChildren visited $visitCount spans');

  // Test TextSpan with semanticsLabel
  final semanticsSpan = TextSpan(
    text: '100%',
    semanticsLabel: 'one hundred percent',
  );
  print('TextSpan with semanticsLabel: ${semanticsSpan.semanticsLabel}');

  // Test TextSpan.toStringShort
  print('TextSpan.toStringShort: ${basicSpan.toStringShort()}');

  // Test TextSpan.codeUnitAt
  final codeUnit = basicSpan.codeUnitAt(0);
  print('TextSpan.codeUnitAt(0): $codeUnit (H)');

  // Test TextSpan comparison
  final span1 = TextSpan(text: 'Test');
  final span2 = TextSpan(text: 'Test');
  print('TextSpan equality: ${span1 == span2}');

  print('Painting textstyle test completed');

  // Return a visual representation
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TextStyle Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            // Font sizes
            Text('Font Sizes:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('12px', style: TextStyle(fontSize: 12.0)),
            Text('16px', style: TextStyle(fontSize: 16.0)),
            Text('20px', style: TextStyle(fontSize: 20.0)),
            Text('24px', style: TextStyle(fontSize: 24.0)),
            SizedBox(height: 16.0),

            // Font weights
            Text(
              'Font Weights:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('w100 Thin', style: TextStyle(fontWeight: FontWeight.w100)),
            Text('w300 Light', style: TextStyle(fontWeight: FontWeight.w300)),
            Text('w400 Normal', style: TextStyle(fontWeight: FontWeight.w400)),
            Text('w500 Medium', style: TextStyle(fontWeight: FontWeight.w500)),
            Text('w700 Bold', style: TextStyle(fontWeight: FontWeight.w700)),
            Text('w900 Black', style: TextStyle(fontWeight: FontWeight.w900)),
            SizedBox(height: 16.0),

            // Font styles
            Text('Font Styles:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Normal style', style: TextStyle(fontStyle: FontStyle.normal)),
            Text('Italic style', style: TextStyle(fontStyle: FontStyle.italic)),
            SizedBox(height: 16.0),

            // Decorations
            Text('Decorations:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              'Underline',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            Text(
              'Line through',
              style: TextStyle(decoration: TextDecoration.lineThrough),
            ),
            Text(
              'Overline',
              style: TextStyle(decoration: TextDecoration.overline),
            ),
            SizedBox(height: 16.0),

            // Decoration styles
            Text(
              'Decoration Styles:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Solid',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
            Text(
              'Double',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.double,
              ),
            ),
            Text(
              'Dotted',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dotted,
              ),
            ),
            Text(
              'Dashed',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
              ),
            ),
            Text(
              'Wavy',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.wavy,
              ),
            ),
            SizedBox(height: 16.0),

            // Colors
            Text('Colors:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Blue text', style: TextStyle(color: Color(0xFF2196F3))),
            Text('Red text', style: TextStyle(color: Color(0xFFE53935))),
            Text('Green text', style: TextStyle(color: Color(0xFF4CAF50))),
            SizedBox(height: 16.0),

            // RichText with TextSpan
            Text(
              'TextSpan (RichText):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Color(0xFF000000), fontSize: 16.0),
                children: [
                  TextSpan(text: 'Normal '),
                  TextSpan(
                    text: 'Bold ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Italic ',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  TextSpan(
                    text: 'Blue',
                    style: TextStyle(color: Color(0xFF2196F3)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Color(0xFF000000), fontSize: 16.0),
                children: [
                  TextSpan(text: 'Click '),
                  TextSpan(
                    text: 'here',
                    style: TextStyle(
                      color: Color(0xFF2196F3),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(text: ' for more info'),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

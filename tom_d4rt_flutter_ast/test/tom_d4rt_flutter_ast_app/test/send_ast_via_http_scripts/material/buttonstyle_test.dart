// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ButtonStyle from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ButtonStyle test executing');

  // ========== BUTTONSTYLE ==========
  print('--- ButtonStyle Tests ---');

  // Test basic ButtonStyle
  final basicStyle = ButtonStyle();
  print('Basic ButtonStyle created');

  // Test ButtonStyle with textStyle
  final textStyleButton = ButtonStyle(
    textStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    ),
  );
  print('ButtonStyle with textStyle created: $textStyleButton');

  // Test ButtonStyle with backgroundColor
  final backgroundStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.blue),
  );
  print('ButtonStyle with backgroundColor created: $backgroundStyle');

  // Test ButtonStyle with foregroundColor
  final foregroundStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.white),
    backgroundColor: WidgetStateProperty.all(Colors.purple),
  );
  print('ButtonStyle with foregroundColor created');

  // Test ButtonStyle with overlayColor
  final overlayStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(Colors.yellow.withOpacity(0.3)),
  );
  print('ButtonStyle with overlayColor created: $overlayStyle');

  // Test ButtonStyle with shadowColor
  final shadowStyle = ButtonStyle(
    shadowColor: WidgetStateProperty.all(Colors.black),
    elevation: WidgetStateProperty.all(8.0),
  );
  print('ButtonStyle with shadowColor created');

  // Test ButtonStyle with surfaceTintColor
  final surfaceTintStyle = ButtonStyle(
    surfaceTintColor: WidgetStateProperty.all(Colors.blue.shade100),
  );
  print('ButtonStyle with surfaceTintColor created: $surfaceTintStyle');

  // Test ButtonStyle with elevation
  final elevationStyle = ButtonStyle(elevation: WidgetStateProperty.all(12.0));
  print('ButtonStyle with elevation created: $elevationStyle');

  // Test ButtonStyle with padding
  final paddingStyle = ButtonStyle(
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
    ),
  );
  print('ButtonStyle with padding created');

  // Test ButtonStyle with minimumSize
  final minimumSizeStyle = ButtonStyle(
    minimumSize: WidgetStateProperty.all(Size(200.0, 60.0)),
  );
  print('ButtonStyle with minimumSize created: $minimumSizeStyle');

  // Test ButtonStyle with fixedSize
  final fixedSizeStyle = ButtonStyle(
    fixedSize: WidgetStateProperty.all(Size(150.0, 50.0)),
  );
  print('ButtonStyle with fixedSize created');

  // Test ButtonStyle with maximumSize
  final maximumSizeStyle = ButtonStyle(
    maximumSize: WidgetStateProperty.all(Size(300.0, 80.0)),
  );
  print('ButtonStyle with maximumSize created: $maximumSizeStyle');

  // Test ButtonStyle with iconColor
  final iconColorStyle = ButtonStyle(
    iconColor: WidgetStateProperty.all(Colors.orange),
  );
  print('ButtonStyle with iconColor created: $iconColorStyle');

  // Test ButtonStyle with iconSize
  final iconSizeStyle = ButtonStyle(iconSize: WidgetStateProperty.all(28.0));
  print('ButtonStyle with iconSize created: $iconSizeStyle');

  // Test ButtonStyle with side (border)
  final sideStyle = ButtonStyle(
    side: WidgetStateProperty.all(BorderSide(color: Colors.green, width: 2.0)),
  );
  print('ButtonStyle with side created');

  // Test ButtonStyle with shape
  final shapeStyle = ButtonStyle(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
  );
  print('ButtonStyle with shape created');

  // Test ButtonStyle with stadium shape
  final stadiumStyle = ButtonStyle(
    shape: WidgetStateProperty.all(StadiumBorder()),
  );
  print('ButtonStyle with StadiumBorder shape created');

  // Test ButtonStyle with mouseCursor
  final cursorStyle = ButtonStyle(
    mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
  );
  print('ButtonStyle with mouseCursor created: $cursorStyle');

  // Test ButtonStyle with visualDensity
  final densityStyle = ButtonStyle(visualDensity: VisualDensity.compact);
  print('ButtonStyle with visualDensity created: $densityStyle');

  // Test ButtonStyle with tapTargetSize
  final tapTargetStyle = ButtonStyle(
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
  print('ButtonStyle with tapTargetSize created: $tapTargetStyle');

  // Test ButtonStyle with animationDuration
  final animationStyle = ButtonStyle(
    animationDuration: Duration(milliseconds: 300),
  );
  print('ButtonStyle with animationDuration created: $animationStyle');

  // Test ButtonStyle with enableFeedback
  final feedbackStyle = ButtonStyle(enableFeedback: true);
  print('ButtonStyle with enableFeedback created: $feedbackStyle');

  // Test ButtonStyle with alignment
  final alignmentStyle = ButtonStyle(alignment: Alignment.centerLeft);
  print('ButtonStyle with alignment created: $alignmentStyle');

  // Test ButtonStyle with splashFactory
  final splashStyle = ButtonStyle(splashFactory: InkRipple.splashFactory);
  print('ButtonStyle with splashFactory created: $splashStyle');

  // Test ButtonStyle with state-dependent properties
  final statefulStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.green.shade700;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.green.shade400;
      }
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey;
      }
      return Colors.green;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey.shade400;
      }
      return Colors.white;
    }),
  );
  print('ButtonStyle with state-dependent properties created');

  // Test ButtonStyle copyWith
  final baseStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.blue),
    foregroundColor: WidgetStateProperty.all(Colors.white),
  );
  final copiedStyle = baseStyle.copyWith(
    backgroundColor: WidgetStateProperty.all(Colors.red),
  );
  print('ButtonStyle copyWith created: $copiedStyle');

  // Test ButtonStyle merge
  final style1 = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.blue),
    padding: WidgetStateProperty.all(EdgeInsets.all(16.0)),
  );
  final style2 = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.white),
    elevation: WidgetStateProperty.all(4.0),
  );
  final mergedStyle = style1.merge(style2);
  print('ButtonStyle merge created');

  // Test ButtonStyle with all properties
  final fullStyle = ButtonStyle(
    textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16.0)),
    backgroundColor: WidgetStateProperty.all(Colors.indigo),
    foregroundColor: WidgetStateProperty.all(Colors.white),
    overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
    shadowColor: WidgetStateProperty.all(Colors.indigo.shade900),
    surfaceTintColor: WidgetStateProperty.all(Colors.indigo.shade100),
    elevation: WidgetStateProperty.all(6.0),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    ),
    minimumSize: WidgetStateProperty.all(Size(120.0, 48.0)),
    side: WidgetStateProperty.all(BorderSide.none),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
    visualDensity: VisualDensity.standard,
    tapTargetSize: MaterialTapTargetSize.padded,
    animationDuration: Duration(milliseconds: 200),
    enableFeedback: true,
    alignment: Alignment.center,
    splashFactory: InkRipple.splashFactory,
  );
  print('ButtonStyle with all properties created');

  print('ButtonStyle test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ButtonStyle Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'Basic Styled Button:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        ElevatedButton(
          style: basicStyle,
          onPressed: () {},
          child: Text('Basic'),
        ),

        SizedBox(height: 16.0),
        Text(
          'Custom Background & Foreground:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        ElevatedButton(
          style: foregroundStyle,
          onPressed: () {},
          child: Text('Purple Button'),
        ),

        SizedBox(height: 16.0),
        Text(
          'With Elevation & Shadow:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        ElevatedButton(
          style: shadowStyle,
          onPressed: () {},
          child: Text('Elevated'),
        ),

        SizedBox(height: 16.0),
        Text('Custom Padding:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        ElevatedButton(
          style: paddingStyle,
          onPressed: () {},
          child: Text('Wide Padding'),
        ),

        SizedBox(height: 16.0),
        Text('Border Style:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        ElevatedButton(
          style: sideStyle,
          onPressed: () {},
          child: Text('Border'),
        ),

        SizedBox(height: 16.0),
        Text('Rounded Shape:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        ElevatedButton(
          style: shapeStyle,
          onPressed: () {},
          child: Text('Rounded'),
        ),

        SizedBox(height: 16.0),
        Text('Stadium Shape:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        ElevatedButton(
          style: stadiumStyle.copyWith(
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            ),
          ),
          onPressed: () {},
          child: Text('Stadium'),
        ),

        SizedBox(height: 16.0),
        Text('Fixed Size:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        ElevatedButton(
          style: fixedSizeStyle,
          onPressed: () {},
          child: Text('Fixed'),
        ),

        SizedBox(height: 16.0),
        Text('Stateful Style:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        Row(
          children: [
            ElevatedButton(
              style: statefulStyle,
              onPressed: () {},
              child: Text('Enabled'),
            ),
            SizedBox(width: 16.0),
            ElevatedButton(
              style: statefulStyle,
              onPressed: null,
              child: Text('Disabled'),
            ),
          ],
        ),

        SizedBox(height: 16.0),
        Text(
          'Full Style Button:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        ElevatedButton(
          style: fullStyle,
          onPressed: () {},
          child: Text('Full Style'),
        ),

        SizedBox(height: 16.0),
        Text('Merged Styles:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        ElevatedButton(
          style: mergedStyle,
          onPressed: () {},
          child: Text('Merged'),
        ),

        SizedBox(height: 16.0),
        Text(
          'Various Button Types with Style:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            TextButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.orange),
              ),
              onPressed: () {},
              child: Text('TextButton'),
            ),
            OutlinedButton(
              style: ButtonStyle(
                side: WidgetStateProperty.all(
                  BorderSide(color: Colors.teal, width: 2.0),
                ),
              ),
              onPressed: () {},
              child: Text('OutlinedButton'),
            ),
            FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
              ),
              onPressed: () {},
              child: Text('FilledButton'),
            ),
          ],
        ),
      ],
    ),
  );
}

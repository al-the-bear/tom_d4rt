// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests OutlinedButtonThemeData from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildDescriptionBox(String text) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 14, color: Colors.teal.shade900),
    ),
  );
}

Widget buildOverviewSection() {
  print('Building overview section for OutlinedButtonThemeData');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.crop_square_outlined, color: Colors.teal, size: 28),
            SizedBox(width: 12),
            Text(
              'OutlinedButtonThemeData',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildDescriptionBox(
          'OutlinedButtonThemeData defines the visual properties for OutlinedButton widgets. '
          'It provides consistent theming of outlined buttons including border color, width, '
          'foreground color, padding, shape, text style, and state-based styling.',
        ),
        SizedBox(height: 12),
        buildInfoCard('Widget', 'OutlinedButton'),
        buildInfoCard('Theme Wrapper', 'OutlinedButtonTheme'),
        buildInfoCard('Purpose', 'Consistent outlined button styling'),
        buildInfoCard(
          'Usage',
          'ThemeData.outlinedButtonTheme or OutlinedButtonTheme',
        ),
        buildInfoCard('Key Properties', 'style (ButtonStyle)'),
      ],
    ),
  );
}

Widget buildDefaultOutlinedButton() {
  print('Building default OutlinedButton appearance');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Default OutlinedButton Appearance',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'OutlinedButton with default theme settings',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            OutlinedButton(
              onPressed: () {
                print('Default outlined button pressed');
              },
              child: Text('Default'),
            ),
            OutlinedButton.icon(
              onPressed: () {
                print('Default icon button pressed');
              },
              icon: Icon(Icons.send),
              label: Text('Send'),
            ),
            OutlinedButton(onPressed: null, child: Text('Disabled')),
          ],
        ),
        SizedBox(height: 16),
        buildInfoCard('Border', 'Default primary color border'),
        buildInfoCard('Background', 'Transparent'),
        buildInfoCard('Text Color', 'Primary color'),
      ],
    ),
  );
}

Widget buildBorderColorWidthTheming() {
  print('Building border color and width theming section');

  List<Color> borderColors = [
    Colors.red.shade600,
    Colors.green.shade600,
    Colors.blue.shade600,
    Colors.orange.shade600,
    Colors.purple.shade600,
  ];
  List<double> borderWidths = [1.0, 2.0, 3.0, 2.5, 1.5];
  List<String> labels = ['Error', 'Success', 'Info', 'Warning', 'Special'];

  List<Widget> buttons = [];
  int i = 0;
  for (i = 0; i < borderColors.length; i = i + 1) {
    Color borderColor = borderColors[i];
    double borderWidth = borderWidths[i];
    String label = labels[i];

    ButtonStyle borderStyle = ButtonStyle(
      side: WidgetStateProperty.all(
        BorderSide(color: borderColor, width: borderWidth),
      ),
      foregroundColor: WidgetStateProperty.all(borderColor),
    );

    OutlinedButtonThemeData themeData = OutlinedButtonThemeData(
      style: borderStyle,
    );

    buttons.add(
      OutlinedButtonTheme(
        data: themeData,
        child: OutlinedButton(
          onPressed: () {
            print('Border themed: $label');
          },
          child: Text(label),
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Themed Border Color and Width',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'OutlinedButtons with custom border colors and widths',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Wrap(spacing: 12, runSpacing: 12, children: buttons),
        SizedBox(height: 16),
        buildInfoCard('Property', 'side in ButtonStyle'),
        buildInfoCard('BorderSide', 'color, width configuration'),
      ],
    ),
  );
}

Widget buildForegroundColorTheming() {
  print('Building foreground color theming section');

  List<Color> fgColors = [
    Colors.teal.shade700,
    Colors.pink.shade700,
    Colors.indigo.shade700,
    Colors.amber.shade800,
  ];
  List<String> labels = ['Teal', 'Pink', 'Indigo', 'Amber'];
  List<IconData> icons = [Icons.eco, Icons.favorite, Icons.science, Icons.star];

  List<Widget> buttons = [];
  int j = 0;
  for (j = 0; j < fgColors.length; j = j + 1) {
    Color fg = fgColors[j];
    String lbl = labels[j];
    IconData ico = icons[j];

    ButtonStyle fgStyle = ButtonStyle(
      foregroundColor: WidgetStateProperty.all(fg),
      side: WidgetStateProperty.all(BorderSide(color: fg, width: 1.5)),
      iconColor: WidgetStateProperty.all(fg),
    );

    OutlinedButtonThemeData themeData = OutlinedButtonThemeData(style: fgStyle);

    buttons.add(
      OutlinedButtonTheme(
        data: themeData,
        child: OutlinedButton.icon(
          onPressed: () {
            print('Foreground themed: $lbl');
          },
          icon: Icon(ico),
          label: Text(lbl),
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Themed Foreground Color',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'OutlinedButtons with custom foreground and icon colors',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Wrap(spacing: 12, runSpacing: 12, children: buttons),
        SizedBox(height: 16),
        buildInfoCard('Property', 'foregroundColor, iconColor in ButtonStyle'),
        buildInfoCard('Effect', 'Text and icon take the configured color'),
      ],
    ),
  );
}

Widget buildPaddingTheming() {
  print('Building padding theming section');

  List<EdgeInsets> paddings = [
    EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    EdgeInsets.all(20),
  ];
  List<String> labels = ['Compact', 'Normal', 'Large', 'Square'];

  List<Widget> buttons = [];
  int k = 0;
  for (k = 0; k < paddings.length; k = k + 1) {
    EdgeInsets padding = paddings[k];
    String label = labels[k];

    ButtonStyle paddingStyle = ButtonStyle(
      padding: WidgetStateProperty.all(padding),
      foregroundColor: WidgetStateProperty.all(Colors.teal.shade700),
      side: WidgetStateProperty.all(
        BorderSide(color: Colors.teal.shade400, width: 1.5),
      ),
    );

    OutlinedButtonThemeData themeData = OutlinedButtonThemeData(
      style: paddingStyle,
    );

    buttons.add(
      OutlinedButtonTheme(
        data: themeData,
        child: OutlinedButton(
          onPressed: () {
            print('Padding themed: $label');
          },
          child: Text(label),
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Themed Padding',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'OutlinedButtons with different internal padding',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Wrap(spacing: 12, runSpacing: 12, children: buttons),
        SizedBox(height: 16),
        buildInfoCard('Property', 'padding in ButtonStyle'),
        buildInfoCard('Effect', 'Controls internal spacing around content'),
      ],
    ),
  );
}

Widget buildShapeBorderRadiusTheming() {
  print('Building shape and borderRadius theming section');

  List<OutlinedBorder> shapes = [
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    StadiumBorder(),
    BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ];
  List<String> shapeLabels = [
    'Square',
    'Rounded 8',
    'Rounded 20',
    'Stadium',
    'Beveled',
  ];

  List<Widget> buttons = [];
  int m = 0;
  for (m = 0; m < shapes.length; m = m + 1) {
    OutlinedBorder shape = shapes[m];
    String label = shapeLabels[m];

    ButtonStyle shapeStyle = ButtonStyle(
      shape: WidgetStateProperty.all(shape),
      foregroundColor: WidgetStateProperty.all(Colors.deepPurple.shade700),
      side: WidgetStateProperty.all(
        BorderSide(color: Colors.deepPurple.shade400, width: 2),
      ),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );

    OutlinedButtonThemeData themeData = OutlinedButtonThemeData(
      style: shapeStyle,
    );

    buttons.add(
      OutlinedButtonTheme(
        data: themeData,
        child: OutlinedButton(
          onPressed: () {
            print('Shape themed: $label');
          },
          child: Text(label),
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Themed Shape and BorderRadius',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'OutlinedButtons with various shape configurations',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Wrap(spacing: 12, runSpacing: 12, children: buttons),
        SizedBox(height: 16),
        buildInfoCard('Property', 'shape in ButtonStyle'),
        buildInfoCard(
          'Options',
          'RoundedRectangleBorder, StadiumBorder, BeveledRectangleBorder',
        ),
      ],
    ),
  );
}

Widget buildTextStyleTheming() {
  print('Building text style theming section');

  List<TextStyle> textStyles = [
    TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1.5),
    TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.italic,
    ),
  ];
  List<String> labels = ['Small', 'Bold', 'Spaced', 'Italic'];
  List<Color> colors = [
    Colors.grey.shade700,
    Colors.blue.shade700,
    Colors.green.shade700,
    Colors.red.shade700,
  ];

  List<Widget> buttons = [];
  int n = 0;
  for (n = 0; n < textStyles.length; n = n + 1) {
    TextStyle ts = textStyles[n];
    String label = labels[n];
    Color color = colors[n];

    ButtonStyle textThemeStyle = ButtonStyle(
      textStyle: WidgetStateProperty.all(ts),
      foregroundColor: WidgetStateProperty.all(color),
      side: WidgetStateProperty.all(BorderSide(color: color, width: 1.5)),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );

    OutlinedButtonThemeData themeData = OutlinedButtonThemeData(
      style: textThemeStyle,
    );

    buttons.add(
      OutlinedButtonTheme(
        data: themeData,
        child: OutlinedButton(
          onPressed: () {
            print('Text style themed: $label');
          },
          child: Text(label),
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Themed Text Style',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'OutlinedButtons with custom text style configurations',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Wrap(spacing: 12, runSpacing: 12, children: buttons),
        SizedBox(height: 16),
        buildInfoCard('Property', 'textStyle in ButtonStyle'),
        buildInfoCard(
          'Options',
          'fontSize, fontWeight, letterSpacing, fontStyle',
        ),
      ],
    ),
  );
}

Widget buildStateBasedStyling() {
  print('Building state-based styling section');

  ButtonStyle stateStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey.shade400;
      }
      if (states.contains(WidgetState.pressed)) {
        return Colors.teal.shade900;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.teal.shade600;
      }
      return Colors.teal.shade700;
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.teal.shade100;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.teal.shade50;
      }
      return Colors.transparent;
    }),
    side: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return BorderSide(color: Colors.grey.shade300, width: 1);
      }
      if (states.contains(WidgetState.pressed)) {
        return BorderSide(color: Colors.teal.shade800, width: 2.5);
      }
      if (states.contains(WidgetState.hovered)) {
        return BorderSide(color: Colors.teal.shade500, width: 2);
      }
      return BorderSide(color: Colors.teal.shade400, width: 1.5);
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.teal.withAlpha(30);
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.teal.withAlpha(15);
      }
      return Colors.transparent;
    }),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );

  OutlinedButtonThemeData themeData = OutlinedButtonThemeData(
    style: stateStyle,
  );

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'State-Based Styling',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'OutlinedButtons responding to hover, pressed, and disabled states',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        OutlinedButtonTheme(
          data: themeData,
          child: Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              OutlinedButton(
                onPressed: () {
                  print('State button 1 pressed');
                },
                child: Text('Hover Me'),
              ),
              OutlinedButton(
                onPressed: () {
                  print('State button 2 pressed');
                },
                child: Text('Press Me'),
              ),
              OutlinedButton(onPressed: null, child: Text('Disabled')),
            ],
          ),
        ),
        SizedBox(height: 16),
        buildInfoCard('Hovered', 'Lighter background, medium border'),
        buildInfoCard('Pressed', 'Teal background, thick border'),
        buildInfoCard('Disabled', 'Gray text and border'),
      ],
    ),
  );
}

Widget buildMultipleThemedButtonsComparison() {
  print('Building multiple themed buttons comparison');

  ButtonStyle primaryStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.blue.shade700),
    side: WidgetStateProperty.all(
      BorderSide(color: Colors.blue.shade400, width: 2),
    ),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  ButtonStyle secondaryStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.grey.shade700),
    side: WidgetStateProperty.all(
      BorderSide(color: Colors.grey.shade400, width: 1.5),
    ),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  ButtonStyle dangerStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.red.shade700),
    side: WidgetStateProperty.all(
      BorderSide(color: Colors.red.shade400, width: 2),
    ),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  ButtonStyle successStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.green.shade700),
    side: WidgetStateProperty.all(
      BorderSide(color: Colors.green.shade400, width: 2),
    ),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Multiple Themed Buttons Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Side-by-side comparison of different button themes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                children: [
                  OutlinedButtonTheme(
                    data: OutlinedButtonThemeData(style: primaryStyle),
                    child: OutlinedButton(
                      onPressed: () {
                        print('Primary action');
                      },
                      child: Text('Primary'),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Primary',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  OutlinedButtonTheme(
                    data: OutlinedButtonThemeData(style: secondaryStyle),
                    child: OutlinedButton(
                      onPressed: () {
                        print('Secondary action');
                      },
                      child: Text('Secondary'),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Secondary',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                children: [
                  OutlinedButtonTheme(
                    data: OutlinedButtonThemeData(style: dangerStyle),
                    child: OutlinedButton(
                      onPressed: () {
                        print('Danger action');
                      },
                      child: Text('Danger'),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Danger',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  OutlinedButtonTheme(
                    data: OutlinedButtonThemeData(style: successStyle),
                    child: OutlinedButton(
                      onPressed: () {
                        print('Success action');
                      },
                      child: Text('Success'),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Success',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        buildInfoCard('Usage', 'Different button themes for different actions'),
        buildInfoCard('Pattern', 'Semantic color coding for user guidance'),
      ],
    ),
  );
}

Widget buildOutlinedButtonThemeWrapping() {
  print('Building OutlinedButtonTheme wrapping demonstration');

  ButtonStyle wrappedStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.indigo.shade700),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return Colors.indigo.shade50;
      }
      return Colors.transparent;
    }),
    side: WidgetStateProperty.all(
      BorderSide(color: Colors.indigo.shade400, width: 2),
    ),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
    elevation: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return 2.0;
      }
      return 0.0;
    }),
  );

  OutlinedButtonThemeData wrappedThemeData = OutlinedButtonThemeData(
    style: wrappedStyle,
  );

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'OutlinedButtonTheme Wrapping Demonstration',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'All child OutlinedButtons inherit the theme',
          style: TextStyle(fontSize: 12, color: Colors.indigo.shade600),
        ),
        SizedBox(height: 16),
        OutlinedButtonTheme(
          data: wrappedThemeData,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.indigo.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Themed Button Group',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    print('Dashboard button pressed');
                  },
                  icon: Icon(Icons.dashboard),
                  label: Text('Dashboard'),
                ),
                SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () {
                    print('Reports button pressed');
                  },
                  icon: Icon(Icons.analytics),
                  label: Text('Reports'),
                ),
                SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () {
                    print('Settings button pressed');
                  },
                  icon: Icon(Icons.settings),
                  label: Text('Settings'),
                ),
                SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () {
                    print('Help button pressed');
                  },
                  icon: Icon(Icons.help_outline),
                  label: Text('Help Center'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        buildInfoCard('Wrapper', 'OutlinedButtonTheme widget'),
        buildInfoCard('Benefit', 'Consistent styling without repetition'),
        buildInfoCard('Scope', 'All descendant OutlinedButtons'),
      ],
    ),
  );
}

Widget buildAdvancedCombinedTheming() {
  print('Building advanced combined theming section');

  ButtonStyle advancedStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey.shade400;
      }
      if (states.contains(WidgetState.pressed)) {
        return Colors.deepOrange.shade800;
      }
      return Colors.deepOrange.shade600;
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.orange.shade100;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.orange.shade50;
      }
      return Colors.transparent;
    }),
    side: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return BorderSide(color: Colors.deepOrange.shade700, width: 3);
      }
      if (states.contains(WidgetState.hovered)) {
        return BorderSide(color: Colors.orange.shade600, width: 2.5);
      }
      return BorderSide(color: Colors.orange.shade400, width: 2);
    }),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 28, vertical: 16),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    textStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
    ),
    animationDuration: Duration(milliseconds: 200),
  );

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.orange.shade100, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.orange.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.deepOrange.shade600),
            SizedBox(width: 8),
            Text(
              'Advanced Combined Theming',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Combining multiple style properties for rich button experiences',
          style: TextStyle(fontSize: 12, color: Colors.deepOrange.shade600),
        ),
        SizedBox(height: 16),
        OutlinedButtonTheme(
          data: OutlinedButtonThemeData(style: advancedStyle),
          child: Center(
            child: Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    print('Subscribe pressed');
                  },
                  icon: Icon(Icons.notifications_active),
                  label: Text('Subscribe'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    print('Upgrade pressed');
                  },
                  icon: Icon(Icons.rocket_launch),
                  label: Text('Upgrade Now'),
                ),
                OutlinedButton.icon(
                  onPressed: null,
                  icon: Icon(Icons.lock),
                  label: Text('Premium'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        buildInfoCard(
          'Combined Properties',
          'foreground, background, side, padding, shape, textStyle',
        ),
        buildInfoCard('Animation', '200ms transition for smooth effects'),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('OutlinedButtonThemeData deep demo test executing');
  print('Testing all aspects of OutlinedButtonThemeData');

  return Scaffold(
    backgroundColor: Colors.grey.shade200,
    appBar: AppBar(
      title: Text('OutlinedButtonThemeData Demo'),
      backgroundColor: Colors.teal.shade700,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader('1. Overview'),
          buildOverviewSection(),
          buildSectionHeader('2. Default Appearance'),
          buildDefaultOutlinedButton(),
          buildSectionHeader('3. Border Color & Width'),
          buildBorderColorWidthTheming(),
          buildSectionHeader('4. Foreground Color'),
          buildForegroundColorTheming(),
          buildSectionHeader('5. Padding'),
          buildPaddingTheming(),
          buildSectionHeader('6. Shape & BorderRadius'),
          buildShapeBorderRadiusTheming(),
          buildSectionHeader('7. Text Style'),
          buildTextStyleTheming(),
          buildSectionHeader('8. State-Based Styling'),
          buildStateBasedStyling(),
          buildSectionHeader('9. Multiple Themes Comparison'),
          buildMultipleThemedButtonsComparison(),
          buildSectionHeader('10. Theme Wrapping'),
          buildOutlinedButtonThemeWrapping(),
          buildSectionHeader('11. Advanced Combined Theming'),
          buildAdvancedCombinedTheming(),
          SizedBox(height: 32),
          Center(
            child: Text(
              'OutlinedButtonThemeData Demo Complete',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

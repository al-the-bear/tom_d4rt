// D4rt test script: Tests FilledButtonThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FilledButtonThemeData Visual Demo ===');
  print('Demonstrating FilledButtonThemeData customization and theming');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('FilledButtonThemeData Demo'),
        backgroundColor: Color(0xFF0D47A1),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('Default FilledButton'),
            SizedBox(height: 8),
            _buildDefaultFilledButton(),
            SizedBox(height: 24),
            buildSectionHeader('Custom Background Colors'),
            SizedBox(height: 8),
            _buildCustomBackgroundColors(),
            SizedBox(height: 24),
            buildSectionHeader('Custom Text Styles'),
            SizedBox(height: 8),
            _buildCustomTextStyles(),
            SizedBox(height: 24),
            buildSectionHeader('Custom Shapes'),
            SizedBox(height: 8),
            _buildCustomShapes(),
            SizedBox(height: 24),
            buildSectionHeader('Custom Padding'),
            SizedBox(height: 8),
            _buildCustomPadding(),
            SizedBox(height: 24),
            buildSectionHeader('Custom Elevation'),
            SizedBox(height: 8),
            _buildCustomElevation(),
            SizedBox(height: 24),
            buildSectionHeader('Themed vs Unthemed Comparison'),
            SizedBox(height: 8),
            _buildThemedVsUnthemed(),
            SizedBox(height: 24),
            buildSectionHeader('FilledButton.tonal Theming'),
            SizedBox(height: 8),
            _buildTonalTheming(),
            SizedBox(height: 24),
            buildSectionHeader('Button Size Configurations'),
            SizedBox(height: 8),
            _buildButtonSizeConfigs(),
            SizedBox(height: 24),
            buildSectionHeader('Theme Data Properties'),
            SizedBox(height: 8),
            _buildThemeDataProperties(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Color(0xFF0D47A1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
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
    child: Row(children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      SizedBox(width: 8),
      Expanded(child: Text(value, style: TextStyle(fontSize: 14, color: Colors.grey.shade700))),
    ]),
  );
}

Widget _buildDefaultFilledButton() {
  print('Building default FilledButton display');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF90CAF9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Default FilledButton without custom theme data',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 16),
        Center(
          child: FilledButton(
            onPressed: () { print('Default FilledButton pressed'); },
            child: Text('Default FilledButton'),
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: FilledButton(
            onPressed: null,
            child: Text('Disabled FilledButton'),
          ),
        ),
        SizedBox(height: 16),
        buildInfoCard('Background:', 'Uses ColorScheme.primary'),
        buildInfoCard('Foreground:', 'Uses ColorScheme.onPrimary'),
        buildInfoCard('Shape:', 'StadiumBorder (fully rounded)'),
        buildInfoCard('Elevation:', '1.0 default, 0.0 disabled'),
      ],
    ),
  );
}

Widget _buildCustomBackgroundColors() {
  print('Building custom background colors section');
  List<Widget> buttons = [];

  List<Color> bgColors = [
    Color(0xFFD32F2F),
    Color(0xFF388E3C),
    Color(0xFF1565C0),
    Color(0xFFFF6F00),
    Color(0xFF6A1B9A),
    Color(0xFF00838F),
  ];
  List<String> colorNames = ['Red', 'Green', 'Blue', 'Orange', 'Purple', 'Cyan'];

  int i = 0;
  for (; i < 6; i = i + 1) {
    Color bg = bgColors[i];
    String colorName = colorNames[i];
    print('  Building button with $colorName background');

    buttons.add(Container(
      margin: EdgeInsets.only(bottom: 8),
      child: FilledButtonTheme(
        data: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(bg),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
          ),
        ),
        child: FilledButton(
          onPressed: () { print('$colorName button pressed'); },
          child: Text('$colorName Button'),
        ),
      ),
    ));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFCC80)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Each button uses FilledButtonThemeData with custom backgroundColor',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: buttons),
        SizedBox(height: 8),
        buildInfoCard('Property:', 'ButtonStyle.backgroundColor via WidgetStatePropertyAll'),
      ],
    ),
  );
}

Widget _buildCustomTextStyles() {
  print('Building custom text styles section');
  List<Widget> items = [];

  items.add(_buildStyledButton('Bold 18px', TextStyle(fontSize: 18, fontWeight: FontWeight.bold), Color(0xFF1565C0)));
  items.add(SizedBox(height: 8));
  items.add(_buildStyledButton('Italic 14px', TextStyle(fontSize: 14, fontStyle: FontStyle.italic), Color(0xFF2E7D32)));
  items.add(SizedBox(height: 8));
  items.add(_buildStyledButton('Letter Spacing 3', TextStyle(fontSize: 14, letterSpacing: 3), Color(0xFFEF6C00)));
  items.add(SizedBox(height: 8));
  items.add(_buildStyledButton('UPPERCASE 12px', TextStyle(fontSize: 12, fontWeight: FontWeight.w900), Color(0xFF6A1B9A)));
  items.add(SizedBox(height: 8));
  items.add(_buildStyledButton('Light Weight 20px', TextStyle(fontSize: 20, fontWeight: FontWeight.w300), Color(0xFF00838F)));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFA5D6A7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Custom textStyle in ButtonStyle via FilledButtonThemeData',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 8),
        buildInfoCard('Property:', 'ButtonStyle.textStyle via WidgetStatePropertyAll'),
      ],
    ),
  );
}

Widget _buildStyledButton(String label, TextStyle textStyle, Color bgColor) {
  return FilledButtonTheme(
    data: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(bgColor),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
        textStyle: WidgetStatePropertyAll(textStyle),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: () { print('Styled button pressed: $label'); },
            child: Text(label),
          ),
        ),
        SizedBox(width: 12),
        Text(label, style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
      ],
    ),
  );
}

Widget _buildCustomShapes() {
  print('Building custom shapes section');
  List<Widget> items = [];

  items.add(_buildShapedButton('Stadium (Default)', StadiumBorder(), Color(0xFF1565C0)));
  items.add(SizedBox(height: 8));
  items.add(_buildShapedButton('Rounded Rect 8', RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), Color(0xFFD32F2F)));
  items.add(SizedBox(height: 8));
  items.add(_buildShapedButton('Rounded Rect 0', RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)), Color(0xFF2E7D32)));
  items.add(SizedBox(height: 8));
  items.add(_buildShapedButton('Rounded Rect 20', RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), Color(0xFFEF6C00)));
  items.add(SizedBox(height: 8));
  items.add(_buildShapedButton('Beveled Rect 8', BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)), Color(0xFF6A1B9A)));
  items.add(SizedBox(height: 8));
  items.add(_buildShapedButton('Circle Border', CircleBorder(), Color(0xFF00838F)));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFCE4EC),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFF48FB1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Custom shape in ButtonStyle via FilledButtonThemeData',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 8),
        buildInfoCard('Property:', 'ButtonStyle.shape via WidgetStatePropertyAll'),
      ],
    ),
  );
}

Widget _buildShapedButton(String label, OutlinedBorder shape, Color bgColor) {
  return Row(
    children: [
      Expanded(
        child: FilledButtonTheme(
          data: FilledButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(bgColor),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(shape),
            ),
          ),
          child: FilledButton(
            onPressed: () { print('Shape button pressed: $label'); },
            child: Text(label),
          ),
        ),
      ),
      SizedBox(width: 8),
      SizedBox(
        width: 100,
        child: Text(label, style: TextStyle(fontSize: 10, color: Color(0xFF757575))),
      ),
    ],
  );
}

Widget _buildCustomPadding() {
  print('Building custom padding section');
  List<Widget> items = [];

  List<String> paddingLabels = ['Tiny (4,2)', 'Small (8,4)', 'Default (24,12)', 'Large (32,20)', 'Wide (48,8)'];
  List<EdgeInsets> paddings = [
    EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    EdgeInsets.symmetric(horizontal: 32, vertical: 20),
    EdgeInsets.symmetric(horizontal: 48, vertical: 8),
  ];
  List<Color> padColors = [
    Color(0xFF00695C),
    Color(0xFF1565C0),
    Color(0xFF4A148C),
    Color(0xFFC62828),
    Color(0xFFE65100),
  ];

  int i = 0;
  for (; i < 5; i = i + 1) {
    String paddingLabel = paddingLabels[i];
    EdgeInsets padding = paddings[i];
    Color padColor = padColors[i];

    print('  Building button with padding: $paddingLabel');

    items.add(Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          FilledButtonTheme(
            data: FilledButtonThemeData(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(padColor),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                padding: WidgetStatePropertyAll(padding),
              ),
            ),
            child: FilledButton(
              onPressed: () { print('Padding button: $paddingLabel'); },
              child: Text('Button'),
            ),
          ),
          SizedBox(width: 12),
          Text(paddingLabel, style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
        ],
      ),
    ));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF80CBC4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Custom padding changes the interior spacing of the button',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 8),
        buildInfoCard('Property:', 'ButtonStyle.padding via WidgetStatePropertyAll'),
      ],
    ),
  );
}

Widget _buildCustomElevation() {
  print('Building custom elevation section');
  List<Widget> items = [];

  List<double> elevations = [0.0, 2.0, 4.0, 8.0, 16.0];
  List<String> elevLabels = ['0 (flat)', '2 (subtle)', '4 (default)', '8 (raised)', '16 (floating)'];

  int i = 0;
  for (; i < 5; i = i + 1) {
    double elev = elevations[i];
    String elevLabel = elevLabels[i];

    print('  Building button with elevation: $elevLabel');

    items.add(Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          FilledButtonTheme(
            data: FilledButtonThemeData(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0xFF1565C0)),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                elevation: WidgetStatePropertyAll(elev),
              ),
            ),
            child: FilledButton(
              onPressed: () { print('Elevation button: $elevLabel'); },
              child: Text('Elevation ${elev.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(width: 16),
          Text(elevLabel, style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
        ],
      ),
    ));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB39DDB)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Elevation controls the shadow depth beneath the button',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 8),
        buildInfoCard('Property:', 'ButtonStyle.elevation via WidgetStatePropertyAll'),
      ],
    ),
  );
}

Widget _buildThemedVsUnthemed() {
  print('Building themed vs unthemed comparison');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Side-by-side: Default theme vs Custom FilledButtonThemeData',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Column(
                  children: [
                    Text('Unthemed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    SizedBox(height: 12),
                    FilledButton(
                      onPressed: () { print('Unthemed pressed'); },
                      child: Text('Default'),
                    ),
                    SizedBox(height: 8),
                    Text('Uses app default', style: TextStyle(fontSize: 10, color: Color(0xFF757575))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFCE93D8)),
                ),
                child: Column(
                  children: [
                    Text('Themed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF6A1B9A))),
                    SizedBox(height: 12),
                    FilledButtonTheme(
                      data: FilledButtonThemeData(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Color(0xFF6A1B9A)),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
                          elevation: WidgetStatePropertyAll(8.0),
                          textStyle: WidgetStatePropertyAll(TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                      child: FilledButton(
                        onPressed: () { print('Themed pressed'); },
                        child: Text('Custom'),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Custom theme data', style: TextStyle(fontSize: 10, color: Color(0xFF6A1B9A))),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Theme Hierarchy:', 'Widget style > Theme data > Defaults'),
        buildInfoCard('Application:', 'Wrap subtree with FilledButtonTheme widget'),
      ],
    ),
  );
}

Widget _buildTonalTheming() {
  print('Building FilledButton.tonal theming section');
  List<Widget> items = [];

  items.add(Text('FilledButton.tonal uses secondaryContainer colors by default.',
      style: TextStyle(fontSize: 13, color: Color(0xFF424242))));
  items.add(SizedBox(height: 12));

  items.add(Row(
    children: [
      Expanded(
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Column(
            children: [
              Text('FilledButton', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              SizedBox(height: 8),
              FilledButton(
                onPressed: () { print('Filled pressed'); },
                child: Text('Filled'),
              ),
              SizedBox(height: 4),
              Text('primary color', style: TextStyle(fontSize: 9, color: Color(0xFF757575))),
            ],
          ),
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Column(
            children: [
              Text('FilledButton.tonal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              SizedBox(height: 8),
              FilledButton.tonal(
                onPressed: () { print('Tonal pressed'); },
                child: Text('Tonal'),
              ),
              SizedBox(height: 4),
              Text('secondaryContainer', style: TextStyle(fontSize: 9, color: Color(0xFF757575))),
            ],
          ),
        ),
      ),
    ],
  ));

  items.add(SizedBox(height: 12));
  items.add(buildInfoCard('Tonal Usage:', 'Lower emphasis than primary filled button'));
  items.add(buildInfoCard('Theme Scope:', 'FilledButtonThemeData applies to both variants'));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    ),
  );
}

Widget _buildButtonSizeConfigs() {
  print('Building button size configurations');
  List<Widget> items = [];

  List<String> sizeLabels = ['Compact', 'Normal', 'Large', 'Extra Large'];
  List<double> heights = [32.0, 40.0, 52.0, 64.0];
  List<double> fontSizes = [11.0, 14.0, 18.0, 22.0];
  List<Color> sizeColors = [
    Color(0xFF00695C),
    Color(0xFF1565C0),
    Color(0xFFD32F2F),
    Color(0xFF4A148C),
  ];

  int i = 0;
  for (; i < 4; i = i + 1) {
    String sizeLabel = sizeLabels[i];
    double height = heights[i];
    double fontSize = fontSizes[i];
    Color sizeColor = sizeColors[i];

    print('  Building size config: $sizeLabel');

    items.add(Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sizeColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          FilledButtonTheme(
            data: FilledButtonThemeData(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(sizeColor),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                minimumSize: WidgetStatePropertyAll(Size(0, height)),
                textStyle: WidgetStatePropertyAll(TextStyle(fontSize: fontSize)),
              ),
            ),
            child: FilledButton(
              onPressed: () { print('Size button: $sizeLabel'); },
              child: Text(sizeLabel),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Height: ${height.toStringAsFixed(0)}px',
                  style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
              Text('Font: ${fontSize.toStringAsFixed(0)}px',
                  style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
            ],
          ),
        ],
      ),
    ));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFA5D6A7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Custom minimumSize and textStyle for different button sizes',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 8),
        buildInfoCard('Property:', 'ButtonStyle.minimumSize for height control'),
      ],
    ),
  );
}

Widget _buildThemeDataProperties() {
  print('Building theme data properties summary');
  List<Widget> items = [];

  items.add(buildInfoCard('style:', 'ButtonStyle - the core configuration object'));
  items.add(buildInfoCard('backgroundColor:', 'WidgetStateProperty<Color> - button fill color'));
  items.add(buildInfoCard('foregroundColor:', 'WidgetStateProperty<Color> - text and icon color'));
  items.add(buildInfoCard('overlayColor:', 'WidgetStateProperty<Color> - press/hover overlay'));
  items.add(buildInfoCard('shadowColor:', 'WidgetStateProperty<Color> - shadow color'));
  items.add(buildInfoCard('surfaceTintColor:', 'WidgetStateProperty<Color> - surface tint'));
  items.add(buildInfoCard('elevation:', 'WidgetStateProperty<double> - shadow depth'));
  items.add(buildInfoCard('padding:', 'WidgetStateProperty<EdgeInsetsGeometry>'));
  items.add(buildInfoCard('minimumSize:', 'WidgetStateProperty<Size> - min button size'));
  items.add(buildInfoCard('maximumSize:', 'WidgetStateProperty<Size> - max button size'));
  items.add(buildInfoCard('shape:', 'WidgetStateProperty<OutlinedBorder>'));
  items.add(buildInfoCard('textStyle:', 'WidgetStateProperty<TextStyle>'));
  items.add(buildInfoCard('side:', 'WidgetStateProperty<BorderSide> - border'));
  items.add(buildInfoCard('alignment:', 'AlignmentGeometry - child alignment'));
  items.add(buildInfoCard('animationDuration:', 'Duration - transition speed'));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFE082)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('All configurable properties in FilledButtonThemeData via ButtonStyle',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

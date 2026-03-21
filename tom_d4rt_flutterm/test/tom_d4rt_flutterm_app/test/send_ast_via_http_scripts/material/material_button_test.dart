// D4rt test script: Tests MaterialButton from material
import 'package:flutter/material.dart';

Widget _buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Color(0x551565C0),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget _buildInfoCard(String label, String description) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFF90CAF9), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0D47A1),
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF1565C0),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSubHeader(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 12, bottom: 6),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: Color(0xFF42A5F5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1565C0),
          ),
        ),
      ],
    ),
  );
}

Widget _buildButtonLabel(String label) {
  return Padding(
    padding: EdgeInsets.only(top: 6, bottom: 4),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color(0xFF546E7A),
      ),
    ),
  );
}

Widget _buildDemoRow(String label, Widget child) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF37474F),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(child: child),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('MaterialButton deep demo test executing');

  // ============================================================
  // Section 1: Basic MaterialButton
  // ============================================================
  print('--- Section 1: Basic MaterialButton ---');

  final basicButton = MaterialButton(
    onPressed: () {
      print('Basic MaterialButton pressed');
    },
    child: Text('Press Me'),
  );
  print('Basic MaterialButton created');

  final basicButtonWithLongPress = MaterialButton(
    onPressed: () {
      print('Button onPressed triggered');
    },
    onLongPress: () {
      print('Button onLongPress triggered');
    },
    child: Text('Tap or Long Press'),
  );
  print('MaterialButton with onLongPress created');

  // ============================================================
  // Section 2: Color Variations
  // ============================================================
  print('--- Section 2: Color Variations ---');

  final coloredButton = MaterialButton(
    onPressed: () {
      print('Colored button pressed');
    },
    color: Color(0xFF1565C0),
    textColor: Colors.white,
    child: Text('Blue Button'),
  );

  final greenButton = MaterialButton(
    onPressed: () {
      print('Green button pressed');
    },
    color: Color(0xFF2E7D32),
    textColor: Colors.white,
    child: Text('Green Button'),
  );

  final redButton = MaterialButton(
    onPressed: () {
      print('Red button pressed');
    },
    color: Color(0xFFC62828),
    textColor: Colors.white,
    child: Text('Red Button'),
  );

  final orangeButton = MaterialButton(
    onPressed: () {
      print('Orange button pressed');
    },
    color: Color(0xFFEF6C00),
    textColor: Colors.white,
    child: Text('Orange Button'),
  );

  final disabledColorButton = MaterialButton(
    onPressed: null,
    color: Color(0xFF1565C0),
    textColor: Colors.white,
    disabledColor: Color(0xFFBDBDBD),
    disabledTextColor: Color(0xFF757575),
    child: Text('Disabled Colors'),
  );
  print('Color variation buttons created');

  // ============================================================
  // Section 3: Elevation Levels
  // ============================================================
  print('--- Section 3: Elevation Levels ---');

  final elevationZero = MaterialButton(
    onPressed: () {
      print('Elevation 0 pressed');
    },
    elevation: 0,
    color: Color(0xFFE3F2FD),
    child: Text('Elev 0'),
  );

  final elevationTwo = MaterialButton(
    onPressed: () {
      print('Elevation 2 pressed');
    },
    elevation: 2,
    color: Color(0xFFBBDEFB),
    child: Text('Elev 2'),
  );

  final elevationEight = MaterialButton(
    onPressed: () {
      print('Elevation 8 pressed');
    },
    elevation: 8,
    color: Color(0xFF90CAF9),
    child: Text('Elev 8'),
  );

  final elevationSixteen = MaterialButton(
    onPressed: () {
      print('Elevation 16 pressed');
    },
    elevation: 16,
    color: Color(0xFF64B5F6),
    child: Text('Elev 16'),
  );

  final highlightElevButton = MaterialButton(
    onPressed: () {
      print('Highlight elevation pressed');
    },
    elevation: 2,
    highlightElevation: 12,
    hoverElevation: 6,
    focusElevation: 4,
    disabledElevation: 0,
    color: Color(0xFF42A5F5),
    textColor: Colors.white,
    child: Text('Highlight Elev 12'),
  );
  print('Elevation buttons created');

  // ============================================================
  // Section 4: Shape Variations
  // ============================================================
  print('--- Section 4: Shape Variations ---');

  final roundedRectButton = MaterialButton(
    onPressed: () {
      print('RoundedRect pressed');
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    color: Color(0xFF7B1FA2),
    textColor: Colors.white,
    child: Text('Rounded Rect'),
  );

  final stadiumButton = MaterialButton(
    onPressed: () {
      print('Stadium pressed');
    },
    shape: StadiumBorder(),
    color: Color(0xFF00838F),
    textColor: Colors.white,
    child: Text('Stadium Shape'),
  );

  final circleButton = MaterialButton(
    onPressed: () {
      print('Circle pressed');
    },
    shape: CircleBorder(),
    color: Color(0xFFE65100),
    textColor: Colors.white,
    minWidth: 64,
    height: 64,
    padding: EdgeInsets.all(0),
    child: Icon(Icons.add, color: Colors.white),
  );

  final beveledButton = MaterialButton(
    onPressed: () {
      print('Beveled pressed');
    },
    shape: BeveledRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: Color(0xFF558B2F),
    textColor: Colors.white,
    child: Text('Beveled'),
  );

  final outlinedShapeButton = MaterialButton(
    onPressed: () {
      print('Outlined shape pressed');
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: Color(0xFF1565C0), width: 2),
    ),
    color: Colors.transparent,
    textColor: Color(0xFF1565C0),
    elevation: 0,
    child: Text('Outlined Shape'),
  );

  final continuousRectButton = MaterialButton(
    onPressed: () {
      print('ContinuousRect pressed');
    },
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(28),
    ),
    color: Color(0xFF4E342E),
    textColor: Colors.white,
    child: Text('Continuous Rect'),
  );
  print('Shape variation buttons created');

  // ============================================================
  // Section 5: Disabled vs Enabled
  // ============================================================
  print('--- Section 5: Disabled vs Enabled ---');

  final enabledButton = MaterialButton(
    onPressed: () {
      print('Enabled button pressed');
    },
    color: Color(0xFF1565C0),
    textColor: Colors.white,
    child: Text('Enabled'),
  );

  final disabledButton = MaterialButton(
    onPressed: null,
    color: Color(0xFF1565C0),
    textColor: Colors.white,
    child: Text('Disabled (null)'),
  );

  final disabledWithCustomColors = MaterialButton(
    onPressed: null,
    color: Color(0xFF1565C0),
    textColor: Colors.white,
    disabledColor: Color(0xFFE0E0E0),
    disabledTextColor: Color(0xFF9E9E9E),
    child: Text('Custom Disabled'),
  );

  final disabledElevatedButton = MaterialButton(
    onPressed: null,
    elevation: 8,
    disabledElevation: 0,
    color: Color(0xFF42A5F5),
    disabledColor: Color(0xFFCFD8DC),
    child: Text('No Shadow When Disabled'),
  );
  print('Disabled vs enabled buttons created');

  // ============================================================
  // Section 6: Padding and MinWidth / Height
  // ============================================================
  print('--- Section 6: Padding and MinWidth / Height ---');

  final noPaddingButton = MaterialButton(
    onPressed: () {
      print('No padding pressed');
    },
    padding: EdgeInsets.zero,
    color: Color(0xFFFF6F00),
    textColor: Colors.white,
    child: Text('No Padding'),
  );

  final largePaddingButton = MaterialButton(
    onPressed: () {
      print('Large padding pressed');
    },
    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
    color: Color(0xFFFF6F00),
    textColor: Colors.white,
    child: Text('Large Padding'),
  );

  final asymmetricPaddingButton = MaterialButton(
    onPressed: () {
      print('Asymmetric padding pressed');
    },
    padding: EdgeInsets.only(left: 32, right: 8, top: 4, bottom: 16),
    color: Color(0xFFFF6F00),
    textColor: Colors.white,
    child: Text('Asymmetric'),
  );

  final smallMinWidthButton = MaterialButton(
    onPressed: () {
      print('Small minWidth pressed');
    },
    minWidth: 40,
    height: 30,
    color: Color(0xFF00897B),
    textColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Text('S'),
  );

  final largeMinWidthButton = MaterialButton(
    onPressed: () {
      print('Large minWidth pressed');
    },
    minWidth: 280,
    height: 56,
    color: Color(0xFF00897B),
    textColor: Colors.white,
    child: Text('Wide Button (minWidth: 280)'),
  );

  final tallButton = MaterialButton(
    onPressed: () {
      print('Tall button pressed');
    },
    minWidth: 100,
    height: 80,
    color: Color(0xFF00897B),
    textColor: Colors.white,
    child: Text('Tall (h:80)'),
  );
  print('Padding and size buttons created');

  // ============================================================
  // Section 7: Splash and Highlight Colors
  // ============================================================
  print('--- Section 7: Splash and Highlight Colors ---');

  final redSplashButton = MaterialButton(
    onPressed: () {
      print('Red splash pressed');
    },
    splashColor: Color(0xFFEF5350),
    highlightColor: Color(0x44EF5350),
    color: Color(0xFFFFCDD2),
    child: Text('Red Splash'),
  );

  final greenSplashButton = MaterialButton(
    onPressed: () {
      print('Green splash pressed');
    },
    splashColor: Color(0xFF66BB6A),
    highlightColor: Color(0x4466BB6A),
    color: Color(0xFFC8E6C9),
    child: Text('Green Splash'),
  );

  final purpleSplashButton = MaterialButton(
    onPressed: () {
      print('Purple splash pressed');
    },
    splashColor: Color(0xFFAB47BC),
    highlightColor: Color(0x44AB47BC),
    color: Color(0xFFE1BEE7),
    child: Text('Purple Splash'),
  );

  final focusHoverButton = MaterialButton(
    onPressed: () {
      print('Focus/hover pressed');
    },
    focusColor: Color(0x440D47A1),
    hoverColor: Color(0x220D47A1),
    splashColor: Color(0xFF1565C0),
    color: Color(0xFFE3F2FD),
    child: Text('Focus + Hover Colors'),
  );

  final noFeedbackButton = MaterialButton(
    onPressed: () {
      print('No feedback pressed');
    },
    enableFeedback: false,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    color: Color(0xFFECEFF1),
    child: Text('No Feedback'),
  );
  print('Splash and highlight buttons created');

  // ============================================================
  // Section 8: Visual Density
  // ============================================================
  print('--- Section 8: Visual Density ---');

  final standardDensityButton = MaterialButton(
    onPressed: () {
      print('Standard density pressed');
    },
    visualDensity: VisualDensity.standard,
    color: Color(0xFF5C6BC0),
    textColor: Colors.white,
    child: Text('Standard Density'),
  );

  final comfortableDensityButton = MaterialButton(
    onPressed: () {
      print('Comfortable density pressed');
    },
    visualDensity: VisualDensity.comfortable,
    color: Color(0xFF5C6BC0),
    textColor: Colors.white,
    child: Text('Comfortable'),
  );

  final compactDensityButton = MaterialButton(
    onPressed: () {
      print('Compact density pressed');
    },
    visualDensity: VisualDensity.compact,
    color: Color(0xFF5C6BC0),
    textColor: Colors.white,
    child: Text('Compact'),
  );

  final customDensityButton = MaterialButton(
    onPressed: () {
      print('Custom density pressed');
    },
    visualDensity: VisualDensity(horizontal: 4.0, vertical: 4.0),
    color: Color(0xFF5C6BC0),
    textColor: Colors.white,
    child: Text('Custom (4.0, 4.0)'),
  );

  final negativeDensityButton = MaterialButton(
    onPressed: () {
      print('Negative density pressed');
    },
    visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
    color: Color(0xFF5C6BC0),
    textColor: Colors.white,
    child: Text('Negative (-4, -4)'),
  );
  print('Visual density buttons created');

  // ============================================================
  // Section 9: Material Tap Target Size
  // ============================================================
  print('--- Section 9: Material Tap Target Size ---');

  final paddedTapTarget = MaterialButton(
    onPressed: () {
      print('Padded tap target pressed');
    },
    materialTapTargetSize: MaterialTapTargetSize.padded,
    color: Color(0xFF00695C),
    textColor: Colors.white,
    child: Text('Padded'),
  );

  final shrinkWrapTapTarget = MaterialButton(
    onPressed: () {
      print('ShrinkWrap tap target pressed');
    },
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    color: Color(0xFF00695C),
    textColor: Colors.white,
    child: Text('Shrink Wrap'),
  );

  final paddedSmallButton = MaterialButton(
    onPressed: () {
      print('Padded small pressed');
    },
    materialTapTargetSize: MaterialTapTargetSize.padded,
    color: Color(0xFF26A69A),
    textColor: Colors.white,
    minWidth: 40,
    height: 28,
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Text('P', style: TextStyle(fontSize: 12)),
  );

  final shrinkSmallButton = MaterialButton(
    onPressed: () {
      print('ShrinkWrap small pressed');
    },
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    color: Color(0xFF26A69A),
    textColor: Colors.white,
    minWidth: 40,
    height: 28,
    padding: EdgeInsets.symmetric(horizontal: 8),
    child: Text('S', style: TextStyle(fontSize: 12)),
  );
  print('Tap target size buttons created');

  // ============================================================
  // Section 10: Color Brightness
  // ============================================================
  print('--- Section 10: Color Brightness ---');

  final lightBrightnessButton = MaterialButton(
    onPressed: () {
      print('Light brightness pressed');
    },
    colorBrightness: Brightness.light,
    color: Color(0xFFFFF9C4),
    child: Text('Light Brightness'),
  );

  final darkBrightnessButton = MaterialButton(
    onPressed: () {
      print('Dark brightness pressed');
    },
    colorBrightness: Brightness.dark,
    color: Color(0xFF263238),
    child: Text('Dark Brightness'),
  );

  final lightWithTextColor = MaterialButton(
    onPressed: () {
      print('Light with text color pressed');
    },
    colorBrightness: Brightness.light,
    color: Color(0xFFE8EAF6),
    textColor: Color(0xFF283593),
    child: Text('Light + Custom Text'),
  );

  final darkWithTextColor = MaterialButton(
    onPressed: () {
      print('Dark with text color pressed');
    },
    colorBrightness: Brightness.dark,
    color: Color(0xFF1A237E),
    textColor: Color(0xFFFFD54F),
    child: Text('Dark + Custom Text'),
  );
  print('Color brightness buttons created');

  // ============================================================
  // Section 11: Rich Child Widgets
  // ============================================================
  print('--- Section 11: Rich Child Widgets ---');

  final iconTextButton = MaterialButton(
    onPressed: () {
      print('Icon+Text pressed');
    },
    color: Color(0xFF1565C0),
    textColor: Colors.white,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.send, color: Colors.white, size: 18),
        SizedBox(width: 8),
        Text('Send'),
      ],
    ),
  );

  final downloadButton = MaterialButton(
    onPressed: () {
      print('Download pressed');
    },
    color: Color(0xFF2E7D32),
    textColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.download, color: Colors.white, size: 20),
        SizedBox(width: 10),
        Text('Download', style: TextStyle(fontSize: 16)),
      ],
    ),
  );

  final deleteButton = MaterialButton(
    onPressed: () {
      print('Delete pressed');
    },
    color: Color(0xFFC62828),
    textColor: Colors.white,
    shape: StadiumBorder(),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.delete_forever, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Text('Delete', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );

  final settingsButton = MaterialButton(
    onPressed: () {
      print('Settings pressed');
    },
    color: Color(0xFF455A64),
    textColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.settings, color: Colors.white, size: 18),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Settings',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text('Configure app',
                style: TextStyle(fontSize: 10, color: Color(0xAAFFFFFF))),
          ],
        ),
      ],
    ),
  );

  final counterBadgeButton = MaterialButton(
    onPressed: () {
      print('Counter badge pressed');
    },
    color: Color(0xFF7B1FA2),
    textColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.notifications, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Text('Alerts'),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Color(0xFFFF5722),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text('5',
              style: TextStyle(fontSize: 12, color: Colors.white)),
        ),
      ],
    ),
  );

  final gradientChildButton = MaterialButton(
    onPressed: () {
      print('Gradient child pressed');
    },
    color: Colors.transparent,
    elevation: 0,
    padding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Gradient Background',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
  print('Rich child widget buttons created');

  // ============================================================
  // Section 12: Clip Behavior and Animation Duration
  // ============================================================
  print('--- Section 12: Clip Behavior and Animation Duration ---');

  final clipNoneButton = MaterialButton(
    onPressed: () {
      print('Clip none pressed');
    },
    clipBehavior: Clip.none,
    color: Color(0xFF0277BD),
    textColor: Colors.white,
    child: Text('Clip.none'),
  );

  final clipHardEdgeButton = MaterialButton(
    onPressed: () {
      print('Clip hardEdge pressed');
    },
    clipBehavior: Clip.hardEdge,
    color: Color(0xFF0277BD),
    textColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text('Clip.hardEdge'),
  );

  final clipAntiAliasButton = MaterialButton(
    onPressed: () {
      print('Clip antiAlias pressed');
    },
    clipBehavior: Clip.antiAlias,
    color: Color(0xFF0277BD),
    textColor: Colors.white,
    shape: StadiumBorder(),
    child: Text('Clip.antiAlias'),
  );

  final shortAnimButton = MaterialButton(
    onPressed: () {
      print('Short animation pressed');
    },
    animationDuration: Duration(milliseconds: 50),
    color: Color(0xFF4DB6AC),
    textColor: Colors.white,
    child: Text('Anim: 50ms'),
  );

  final longAnimButton = MaterialButton(
    onPressed: () {
      print('Long animation pressed');
    },
    animationDuration: Duration(milliseconds: 500),
    color: Color(0xFF4DB6AC),
    textColor: Colors.white,
    child: Text('Anim: 500ms'),
  );
  print('Clip and animation buttons created');

  // ============================================================
  // Section 13: Summary
  // ============================================================
  print('--- Section 13: Summary ---');
  print('All MaterialButton demo sections complete');

  // Build the full scrollable demo layout
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0D47A1),
                Color(0xFF1565C0),
                Color(0xFF42A5F5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Color(0x550D47A1),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MaterialButton Deep Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Comprehensive visual demos of MaterialButton properties',
                style: TextStyle(fontSize: 14, color: Color(0xCCFFFFFF)),
              ),
            ],
          ),
        ),

        // Section 1: Basic MaterialButton
        _buildSectionHeader('1. Basic MaterialButton'),
        _buildInfoCard(
          'MaterialButton',
          'A utility class for building Material Design buttons. '
          'Provides onPressed and onLongPress callbacks.',
        ),
        _buildSubHeader('Default Button'),
        basicButton,
        SizedBox(height: 8),
        _buildSubHeader('With onLongPress'),
        basicButtonWithLongPress,
        SizedBox(height: 16),

        // Section 2: Color Variations
        _buildSectionHeader('2. Color Variations'),
        _buildInfoCard(
          'Color Properties',
          'MaterialButton supports color, textColor, disabledColor, '
          'and disabledTextColor for full color customization.',
        ),
        _buildDemoRow('Blue', coloredButton),
        _buildDemoRow('Green', greenButton),
        _buildDemoRow('Red', redButton),
        _buildDemoRow('Orange', orangeButton),
        _buildDemoRow('Disabled Colors', disabledColorButton),
        SizedBox(height: 16),

        // Section 3: Elevation Levels
        _buildSectionHeader('3. Elevation Levels'),
        _buildInfoCard(
          'Elevation',
          'Control shadow depth with elevation, highlightElevation, '
          'hoverElevation, focusElevation, and disabledElevation.',
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            Column(
              children: [
                elevationZero,
                _buildButtonLabel('elevation: 0'),
              ],
            ),
            Column(
              children: [
                elevationTwo,
                _buildButtonLabel('elevation: 2'),
              ],
            ),
            Column(
              children: [
                elevationEight,
                _buildButtonLabel('elevation: 8'),
              ],
            ),
            Column(
              children: [
                elevationSixteen,
                _buildButtonLabel('elevation: 16'),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        _buildSubHeader('Highlight Elevation'),
        highlightElevButton,
        SizedBox(height: 16),

        // Section 4: Shape Variations
        _buildSectionHeader('4. Shape Variations'),
        _buildInfoCard(
          'Shape Property',
          'Use shape to set RoundedRectangleBorder, StadiumBorder, '
          'CircleBorder, BeveledRectangleBorder, or ContinuousRectangleBorder.',
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            Column(
              children: [
                roundedRectButton,
                _buildButtonLabel('RoundedRect'),
              ],
            ),
            Column(
              children: [
                stadiumButton,
                _buildButtonLabel('Stadium'),
              ],
            ),
            Column(
              children: [
                circleButton,
                _buildButtonLabel('Circle'),
              ],
            ),
            Column(
              children: [
                beveledButton,
                _buildButtonLabel('Beveled'),
              ],
            ),
            Column(
              children: [
                outlinedShapeButton,
                _buildButtonLabel('Outlined'),
              ],
            ),
            Column(
              children: [
                continuousRectButton,
                _buildButtonLabel('Continuous'),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),

        // Section 5: Disabled vs Enabled
        _buildSectionHeader('5. Disabled vs Enabled'),
        _buildInfoCard(
          'Disabled State',
          'Setting onPressed to null disables the button. '
          'Use disabledColor and disabledTextColor for custom disabled look.',
        ),
        _buildDemoRow('Enabled', enabledButton),
        _buildDemoRow('Disabled', disabledButton),
        _buildDemoRow('Custom Disabled', disabledWithCustomColors),
        _buildDemoRow('No Shadow Disabled', disabledElevatedButton),
        SizedBox(height: 16),

        // Section 6: Padding and MinWidth / Height
        _buildSectionHeader('6. Padding and MinWidth / Height'),
        _buildInfoCard(
          'Sizing',
          'Control internal spacing with padding, and minimum dimensions '
          'with minWidth and height properties.',
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            Column(
              children: [
                noPaddingButton,
                _buildButtonLabel('No Padding'),
              ],
            ),
            Column(
              children: [
                largePaddingButton,
                _buildButtonLabel('Large Padding'),
              ],
            ),
            Column(
              children: [
                asymmetricPaddingButton,
                _buildButtonLabel('Asymmetric'),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        _buildSubHeader('MinWidth and Height'),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            Column(
              children: [
                smallMinWidthButton,
                _buildButtonLabel('minW:40 h:30'),
              ],
            ),
            Column(
              children: [
                tallButton,
                _buildButtonLabel('minW:100 h:80'),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        largeMinWidthButton,
        _buildButtonLabel('minWidth: 280, height: 56'),
        SizedBox(height: 16),

        // Section 7: Splash and Highlight Colors
        _buildSectionHeader('7. Splash and Highlight Colors'),
        _buildInfoCard(
          'Interaction Colors',
          'Customize splashColor, highlightColor, focusColor, and hoverColor '
          'for rich tap and interaction feedback.',
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            Column(
              children: [
                redSplashButton,
                _buildButtonLabel('Red Splash'),
              ],
            ),
            Column(
              children: [
                greenSplashButton,
                _buildButtonLabel('Green Splash'),
              ],
            ),
            Column(
              children: [
                purpleSplashButton,
                _buildButtonLabel('Purple Splash'),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        _buildDemoRow('Focus + Hover', focusHoverButton),
        _buildDemoRow('No Feedback', noFeedbackButton),
        SizedBox(height: 16),

        // Section 8: Visual Density
        _buildSectionHeader('8. Visual Density'),
        _buildInfoCard(
          'VisualDensity',
          'Adjusts the compactness of the button. '
          'Values: standard, comfortable, compact, or custom.',
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            Column(
              children: [
                standardDensityButton,
                _buildButtonLabel('Standard'),
              ],
            ),
            Column(
              children: [
                comfortableDensityButton,
                _buildButtonLabel('Comfortable'),
              ],
            ),
            Column(
              children: [
                compactDensityButton,
                _buildButtonLabel('Compact'),
              ],
            ),
            Column(
              children: [
                customDensityButton,
                _buildButtonLabel('Custom +4'),
              ],
            ),
            Column(
              children: [
                negativeDensityButton,
                _buildButtonLabel('Custom -4'),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),

        // Section 9: Tap Target Size
        _buildSectionHeader('9. Material Tap Target Size'),
        _buildInfoCard(
          'MaterialTapTargetSize',
          'padded ensures minimum 48px hit area. '
          'shrinkWrap removes extra padding around the button.',
        ),
        Row(
          children: [
            Column(
              children: [
                paddedTapTarget,
                _buildButtonLabel('Padded'),
              ],
            ),
            SizedBox(width: 16),
            Column(
              children: [
                shrinkWrapTapTarget,
                _buildButtonLabel('Shrink Wrap'),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        _buildSubHeader('Small Buttons Comparison'),
        Row(
          children: [
            Column(
              children: [
                paddedSmallButton,
                _buildButtonLabel('Padded (small)'),
              ],
            ),
            SizedBox(width: 16),
            Column(
              children: [
                shrinkSmallButton,
                _buildButtonLabel('ShrinkWrap (small)'),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),

        // Section 10: Color Brightness
        _buildSectionHeader('10. Color Brightness'),
        _buildInfoCard(
          'ColorBrightness',
          'Determines the default text color based on brightness. '
          'Light uses dark text, dark uses light text.',
        ),
        _buildDemoRow('Light', lightBrightnessButton),
        _buildDemoRow('Dark', darkBrightnessButton),
        _buildDemoRow('Light + Custom', lightWithTextColor),
        _buildDemoRow('Dark + Custom', darkWithTextColor),
        SizedBox(height: 16),

        // Section 11: Rich Child Widgets
        _buildSectionHeader('11. Rich Child Widgets'),
        _buildInfoCard(
          'Custom Children',
          'MaterialButton child can be any widget. Use Row with Icon and Text, '
          'badges, multi-line layouts, or gradient containers.',
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            iconTextButton,
            downloadButton,
            deleteButton,
          ],
        ),
        SizedBox(height: 10),
        _buildSubHeader('Complex Children'),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            settingsButton,
            counterBadgeButton,
          ],
        ),
        SizedBox(height: 10),
        _buildSubHeader('Gradient Background'),
        gradientChildButton,
        SizedBox(height: 16),

        // Section 12: Clip Behavior and Animation Duration
        _buildSectionHeader('12. Clip Behavior & Animation'),
        _buildInfoCard(
          'ClipBehavior & AnimationDuration',
          'clipBehavior controls how overflow is handled. '
          'animationDuration controls elevation transition speed.',
        ),
        _buildSubHeader('Clip Behaviors'),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            Column(
              children: [
                clipNoneButton,
                _buildButtonLabel('Clip.none'),
              ],
            ),
            Column(
              children: [
                clipHardEdgeButton,
                _buildButtonLabel('Clip.hardEdge'),
              ],
            ),
            Column(
              children: [
                clipAntiAliasButton,
                _buildButtonLabel('Clip.antiAlias'),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        _buildSubHeader('Animation Duration'),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            Column(
              children: [
                shortAnimButton,
                _buildButtonLabel('50ms'),
              ],
            ),
            Column(
              children: [
                longAnimButton,
                _buildButtonLabel('500ms'),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),

        // Section 13: Summary
        _buildSectionHeader('13. Summary'),
        _buildInfoCard(
          'MaterialButton Properties Covered',
          'onPressed, onLongPress, color, textColor, disabledColor, '
          'disabledTextColor, elevation, highlightElevation, hoverElevation, '
          'focusElevation, disabledElevation, shape, padding, minWidth, '
          'height, splashColor, highlightColor, focusColor, hoverColor, '
          'visualDensity, materialTapTargetSize, colorBrightness, '
          'clipBehavior, animationDuration, enableFeedback, child.',
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Demo Statistics',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF37474F),
                ),
              ),
              SizedBox(height: 8),
              Text('Total sections: 13',
                  style: TextStyle(fontSize: 13)),
              Text('Properties demonstrated: 26',
                  style: TextStyle(fontSize: 13)),
              Text('Button variations: 40+',
                  style: TextStyle(fontSize: 13)),
              Text('Shape types: 6',
                  style: TextStyle(fontSize: 13)),
              Text('Rich child patterns: 6',
                  style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    ),
  );
}

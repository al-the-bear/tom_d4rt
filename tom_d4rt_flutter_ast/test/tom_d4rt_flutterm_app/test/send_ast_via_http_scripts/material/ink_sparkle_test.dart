// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests InkSparkle and ink effects from material
import 'package:flutter/material.dart';

Widget _buildSectionHeader(String title) {
  print('Section: $title');
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 24, bottom: 12),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Color(0xFF6200EA),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Color(0x406200EA),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget _buildSubSectionHeader(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 16, bottom: 8, left: 4),
    child: Text(
      title,
      style: TextStyle(
        color: Color(0xFF6200EA),
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _buildInfoCard(String title, String description) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121),
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Color(0xFF616161), height: 1.4),
        ),
      ],
    ),
  );
}

Widget _buildPropertyRow(String property, String type, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            property,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6200EA),
            ),
          ),
        ),
        SizedBox(
          width: 90,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF7B1FA2),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildNoteBox(String text) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFCE93D8), width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, size: 18, color: Color(0xFF7B1FA2)),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF4A148C),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLabeledDemo(String label, Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF757575),
            ),
          ),
        ),
        child,
      ],
    ),
  );
}

Widget _buildTapIndicator(String label, Color bgColor, Color textColor) {
  return Container(
    width: double.infinity,
    height: 56,
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Widget _buildDefaultSplash() {
  print('  Building default InkSplash demo');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'InkSplash - Default Splash',
        'InkSplash is the default splash factory used by InkWell. '
            'It creates a spreading circular ink splash animation when '
            'the user taps on the widget. This is the classic Material '
            'Design splash effect.',
      ),
      _buildLabeledDemo(
        'Default InkSplash (tap to see effect)',
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              print('Default InkSplash tapped');
            },
            child: _buildTapIndicator(
              'Tap me - Default InkSplash',
              Color(0xFFE8EAF6),
              Color(0xFF283593),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'InkSplash with explicit splashFactory',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkSplash.splashFactory,
            onTap: () {
              print('Explicit InkSplash.splashFactory tapped');
            },
            child: _buildTapIndicator(
              'InkSplash.splashFactory',
              Color(0xFFE0F2F1),
              Color(0xFF00695C),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'InkSplash with custom splash color',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkSplash.splashFactory,
            splashColor: Color(0x44FF5722),
            onTap: () {
              print('Custom color InkSplash tapped');
            },
            child: _buildTapIndicator(
              'Custom Orange Splash',
              Color(0xFFFBE9E7),
              Color(0xFFBF360C),
            ),
          ),
        ),
      ),
      _buildNoteBox(
        'InkSplash is the default when no splashFactory is specified. '
        'It creates a circular splash that expands from the tap point.',
      ),
    ],
  );
}

Widget _buildRippleSplash() {
  print('  Building InkRipple demo');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'InkRipple - Ripple Effect',
        'InkRipple creates a ripple animation that spreads outward from '
            'the tap point. It is similar to InkSplash but with a different '
            'animation curve, producing a more fluid ripple motion. Often used '
            'as an alternative Material Design splash.',
      ),
      _buildLabeledDemo(
        'InkRipple splash (tap to see ripple)',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkRipple.splashFactory,
            onTap: () {
              print('InkRipple tapped');
            },
            child: _buildTapIndicator(
              'Tap me - InkRipple',
              Color(0xFFE3F2FD),
              Color(0xFF1565C0),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'InkRipple with highlight color',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkRipple.splashFactory,
            highlightColor: Color(0x22E91E63),
            onTap: () {
              print('InkRipple with highlight tapped');
            },
            child: _buildTapIndicator(
              'InkRipple + Highlight',
              Color(0xFFFCE4EC),
              Color(0xFF880E4F),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'InkRipple with thick splash',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkRipple.splashFactory,
            splashColor: Color(0x664CAF50),
            onTap: () {
              print('Thick InkRipple tapped');
            },
            child: _buildTapIndicator(
              'Thick Green Ripple',
              Color(0xFFE8F5E9),
              Color(0xFF2E7D32),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildSparkleSplash() {
  print('  Building InkSparkle demo (Material 3)');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'InkSparkle - Material 3 Sparkle',
        'InkSparkle is the Material 3 splash effect that creates a sparkle '
            'animation radiating from the tap point. It uses a custom shader to '
            'produce a glittering, particle-like effect. This is the recommended '
            'splash for Material 3 designs.',
      ),
      _buildNoteBox(
        'InkSparkle requires GPU shader support. It produces a visually '
        'distinct sparkle/shimmer animation compared to InkSplash or '
        'InkRipple. Set via InkSparkle.splashFactory on InkWell or '
        'via ThemeData.splashFactory.',
      ),
      _buildLabeledDemo(
        'InkSparkle splash (Material 3 style)',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkSparkle.splashFactory,
            onTap: () {
              print('InkSparkle tapped - sparkle effect!');
            },
            child: _buildTapIndicator(
              'Tap me - InkSparkle (M3)',
              Color(0xFFEDE7F6),
              Color(0xFF4527A0),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'InkSparkle with custom splash color',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkSparkle.splashFactory,
            splashColor: Color(0x44E91E63),
            onTap: () {
              print('Custom color InkSparkle tapped');
            },
            child: _buildTapIndicator(
              'Pink Sparkle Effect',
              Color(0xFFFCE4EC),
              Color(0xFFC2185B),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'InkSparkle with highlight',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkSparkle.splashFactory,
            highlightColor: Color(0x22FF6F00),
            splashColor: Color(0x44FF6F00),
            onTap: () {
              print('InkSparkle with highlight tapped');
            },
            child: _buildTapIndicator(
              'Sparkle + Orange Highlight',
              Color(0xFFFFF3E0),
              Color(0xFFE65100),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'InkSparkle on dark background',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkSparkle.splashFactory,
            splashColor: Color(0x44FFFFFF),
            onTap: () {
              print('Dark background InkSparkle tapped');
            },
            child: _buildTapIndicator(
              'Dark Sparkle Effect',
              Color(0xFF1A237E),
              Color(0xFFE8EAF6),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildSplashComparisonCard(
  String title,
  String description,
  InteractiveInkFeatureFactory factory,
  Color bgColor,
  Color textColor,
  Color splashColor,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF424242),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: factory,
            splashColor: splashColor,
            onTap: () {
              print('Comparison tap: $title');
            },
            child: Container(
              width: double.infinity,
              height: 64,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      color: textColor.withValues(alpha: 0.7),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSplashComparison() {
  print('  Building splash type comparison');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'Splash Type Comparison',
        'Flutter provides three built-in splash factories. Each produces a '
            'different visual effect when the user taps. InkSplash is the classic '
            'Material 2 default, InkRipple is a smoother alternative, and '
            'InkSparkle is the Material 3 sparkle.',
      ),
      _buildSubSectionHeader('Side-by-Side Comparison'),
      _buildSplashComparisonCard(
        'InkSplash (Classic)',
        'Expanding circle from tap point',
        InkSplash.splashFactory,
        Color(0xFFE8F5E9),
        Color(0xFF1B5E20),
        Color(0x444CAF50),
      ),
      _buildSplashComparisonCard(
        'InkRipple (Smooth)',
        'Fluid ripple spreading outward',
        InkRipple.splashFactory,
        Color(0xFFE3F2FD),
        Color(0xFF0D47A1),
        Color(0x442196F3),
      ),
      _buildSplashComparisonCard(
        'InkSparkle (Material 3)',
        'Sparkle and shimmer particles',
        InkSparkle.splashFactory,
        Color(0xFFEDE7F6),
        Color(0xFF311B92),
        Color(0x44673AB7),
      ),
      _buildNoteBox(
        'InkSparkle uses a fragment shader for its sparkle animation. '
        'It may not be supported on all platforms. InkSplash and InkRipple '
        'use standard canvas operations and work everywhere.',
      ),
      _buildSubSectionHeader('With Same Color Theme'),
      _buildSplashComparisonCard(
        'InkSplash - Teal',
        'Classic circular expansion',
        InkSplash.splashFactory,
        Color(0xFFE0F2F1),
        Color(0xFF004D40),
        Color(0x44009688),
      ),
      _buildSplashComparisonCard(
        'InkRipple - Teal',
        'Smooth fluid ripple',
        InkRipple.splashFactory,
        Color(0xFFE0F2F1),
        Color(0xFF004D40),
        Color(0x44009688),
      ),
      _buildSplashComparisonCard(
        'InkSparkle - Teal',
        'Sparkling particle shimmer',
        InkSparkle.splashFactory,
        Color(0xFFE0F2F1),
        Color(0xFF004D40),
        Color(0x44009688),
      ),
    ],
  );
}

Widget _buildCustomSplashColors() {
  print('  Building custom splash color demos');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'Custom Splash Colors',
        'InkWell allows customization of splashColor and highlightColor. '
            'The splashColor controls the color of the expanding splash animation '
            'and highlightColor controls the solid overlay during long press.',
      ),
      _buildLabeledDemo(
        'Red splash on white background',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Color(0x66F44336),
            onTap: () {
              print('Red splash tapped');
            },
            child: _buildTapIndicator(
              'Red Splash',
              Color(0xFFFFFFFF),
              Color(0xFFD32F2F),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'Blue splash with blue highlight',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Color(0x662196F3),
            highlightColor: Color(0x222196F3),
            onTap: () {
              print('Blue splash+highlight tapped');
            },
            child: _buildTapIndicator(
              'Blue Splash + Highlight',
              Color(0xFFE3F2FD),
              Color(0xFF1565C0),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'Purple sparkle with amber highlight',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkSparkle.splashFactory,
            splashColor: Color(0x66673AB7),
            highlightColor: Color(0x22FFC107),
            onTap: () {
              print('Purple sparkle + amber highlight tapped');
            },
            child: _buildTapIndicator(
              'Purple Sparkle + Amber Highlight',
              Color(0xFFF3E5F5),
              Color(0xFF4A148C),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'Green ripple with green highlight',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkRipple.splashFactory,
            splashColor: Color(0x664CAF50),
            highlightColor: Color(0x224CAF50),
            onTap: () {
              print('Green ripple+highlight tapped');
            },
            child: _buildTapIndicator(
              'Green Ripple + Highlight',
              Color(0xFFE8F5E9),
              Color(0xFF2E7D32),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'White splash on dark surface',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Color(0x33FFFFFF),
            highlightColor: Color(0x11FFFFFF),
            onTap: () {
              print('White splash on dark tapped');
            },
            child: _buildTapIndicator(
              'White on Dark',
              Color(0xFF212121),
              Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildHighlightAndSplash() {
  print('  Building highlight and splash customization');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'Highlight vs Splash',
        'highlightColor is the solid overlay that appears on long press. '
            'splashColor is the expanding circular animation on tap. Both can '
            'be customized independently for different visual feedback.',
      ),
      _buildLabeledDemo(
        'Strong highlight, subtle splash',
        Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Color(0x44E91E63),
            splashColor: Color(0x22E91E63),
            onTap: () {
              print('Strong highlight, subtle splash tapped');
            },
            onLongPress: () {
              print('Long pressed - see highlight!');
            },
            child: _buildTapIndicator(
              'Strong Highlight / Subtle Splash',
              Color(0xFFFCE4EC),
              Color(0xFF880E4F),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'No highlight, only splash',
        Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Color(0x00000000),
            splashColor: Color(0x664CAF50),
            onTap: () {
              print('No highlight, only splash tapped');
            },
            child: _buildTapIndicator(
              'Splash Only (No Highlight)',
              Color(0xFFE8F5E9),
              Color(0xFF2E7D32),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'No splash, only highlight',
        Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: Color(0x44FF9800),
            splashColor: Color(0x00000000),
            onTap: () {
              print('No splash, only highlight tapped');
            },
            onLongPress: () {
              print('Long pressed - highlight only!');
            },
            child: _buildTapIndicator(
              'Highlight Only (No Splash)',
              Color(0xFFFFF3E0),
              Color(0xFFE65100),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'InkSparkle with transparent highlight',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkSparkle.splashFactory,
            highlightColor: Color(0x00000000),
            splashColor: Color(0x669C27B0),
            onTap: () {
              print('InkSparkle with no highlight tapped');
            },
            child: _buildTapIndicator(
              'Sparkle Only (No Highlight)',
              Color(0xFFF3E5F5),
              Color(0xFF6A1B9A),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildInkResponseComparison() {
  print('  Building InkResponse vs InkWell comparison');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'InkResponse vs InkWell',
        'InkWell is a rectangular area that responds to touch with ink splash. '
            'InkResponse is its parent class with more flexibility - it can have '
            'a non-rectangular splash, highlight shape, and containedInkWell control. '
            'InkWell is essentially an InkResponse with rectangular defaults.',
      ),
      _buildSubSectionHeader('InkWell (Rectangular Splash)'),
      _buildLabeledDemo(
        'InkWell - splash fills rectangle',
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              print('InkWell rectangular tapped');
            },
            child: _buildTapIndicator(
              'InkWell - Rectangular',
              Color(0xFFE3F2FD),
              Color(0xFF1565C0),
            ),
          ),
        ),
      ),
      _buildSubSectionHeader('InkResponse (Unbounded Splash)'),
      _buildLabeledDemo(
        'InkResponse - splash extends beyond bounds',
        Material(
          color: Colors.transparent,
          child: InkResponse(
            onTap: () {
              print('InkResponse unbounded tapped');
            },
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'InkResponse - Unbounded Splash',
                  style: TextStyle(
                    color: Color(0xFFE65100),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      _buildSubSectionHeader('InkResponse with containedInkWell'),
      _buildLabeledDemo(
        'InkResponse containedInkWell: true (like InkWell)',
        Material(
          color: Colors.transparent,
          child: InkResponse(
            containedInkWell: true,
            onTap: () {
              print('Contained InkResponse tapped');
            },
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'InkResponse - Contained',
                  style: TextStyle(
                    color: Color(0xFF2E7D32),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'InkResponse with InkSparkle factory',
        Material(
          color: Colors.transparent,
          child: InkResponse(
            splashFactory: InkSparkle.splashFactory,
            containedInkWell: true,
            onTap: () {
              print('InkResponse + InkSparkle tapped');
            },
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xFFEDE7F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'InkResponse + Sparkle',
                  style: TextStyle(
                    color: Color(0xFF4527A0),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      _buildNoteBox(
        'InkWell is a convenience widget that wraps InkResponse with '
        'containedInkWell: true, highlightShape: BoxShape.rectangle. '
        'Use InkResponse directly when you need unbounded or circular splashes.',
      ),
    ],
  );
}

Widget _buildThemedInkEffects() {
  print('  Building themed ink effects');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'ThemeData.splashFactory',
        'Instead of setting splashFactory on each InkWell individually, '
            'you can configure it globally via ThemeData.splashFactory. All '
            'InkWell and InkResponse widgets will use the theme factory unless '
            'they override it locally.',
      ),
      _buildSubSectionHeader('Theme with InkSparkle (Material 3)'),
      Theme(
        data: ThemeData(
          splashFactory: InkSparkle.splashFactory,
          splashColor: Color(0x446200EA),
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              _buildLabeledDemo(
                'Button using theme sparkle',
                InkWell(
                  onTap: () {
                    print('Themed InkSparkle button tapped');
                  },
                  child: _buildTapIndicator(
                    'Themed Sparkle Button',
                    Color(0xFFEDE7F6),
                    Color(0xFF4527A0),
                  ),
                ),
              ),
              _buildLabeledDemo(
                'Another button using same theme',
                InkWell(
                  onTap: () {
                    print('Second themed button tapped');
                  },
                  child: _buildTapIndicator(
                    'Also Themed Sparkle',
                    Color(0xFFE8EAF6),
                    Color(0xFF283593),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      _buildSubSectionHeader('Theme with InkRipple'),
      Theme(
        data: ThemeData(
          splashFactory: InkRipple.splashFactory,
          splashColor: Color(0x44009688),
        ),
        child: Material(
          color: Colors.transparent,
          child: _buildLabeledDemo(
            'Button using theme ripple',
            InkWell(
              onTap: () {
                print('Themed InkRipple button tapped');
              },
              child: _buildTapIndicator(
                'Themed Ripple Button',
                Color(0xFFE0F2F1),
                Color(0xFF00695C),
              ),
            ),
          ),
        ),
      ),
      _buildSubSectionHeader('Theme with InkSplash'),
      Theme(
        data: ThemeData(
          splashFactory: InkSplash.splashFactory,
          splashColor: Color(0x44F44336),
        ),
        child: Material(
          color: Colors.transparent,
          child: _buildLabeledDemo(
            'Button using theme splash',
            InkWell(
              onTap: () {
                print('Themed InkSplash button tapped');
              },
              child: _buildTapIndicator(
                'Themed Classic Splash',
                Color(0xFFFFEBEE),
                Color(0xFFC62828),
              ),
            ),
          ),
        ),
      ),
      _buildSubSectionHeader('Local Override of Theme'),
      Theme(
        data: ThemeData(
          splashFactory: InkSplash.splashFactory,
          splashColor: Color(0x44000000),
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              _buildLabeledDemo(
                'Uses theme InkSplash (no override)',
                InkWell(
                  onTap: () {
                    print('Theme default tapped');
                  },
                  child: _buildTapIndicator(
                    'From Theme: InkSplash',
                    Color(0xFFF5F5F5),
                    Color(0xFF424242),
                  ),
                ),
              ),
              _buildLabeledDemo(
                'Overrides theme to InkSparkle locally',
                InkWell(
                  splashFactory: InkSparkle.splashFactory,
                  splashColor: Color(0x66673AB7),
                  onTap: () {
                    print('Local override InkSparkle tapped');
                  },
                  child: _buildTapIndicator(
                    'Local Override: InkSparkle',
                    Color(0xFFEDE7F6),
                    Color(0xFF4527A0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildCircleInkButton(IconData icon, Color color, String label) {
  return Column(
    children: [
      Material(
        color: Colors.transparent,
        child: InkWell(
          splashFactory: InkSparkle.splashFactory,
          customBorder: CircleBorder(),
          splashColor: color.withValues(alpha: 0.3),
          onTap: () {
            print('Circle button tapped: $label');
          },
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Center(child: Icon(icon, color: color, size: 24)),
          ),
        ),
      ),
      SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
    ],
  );
}

Widget _buildInkWellShapes() {
  print('  Building InkWell shapes');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'InkWell with Various Shapes',
        'InkWell clips its splash to the widget shape using customBorder '
            'or borderRadius. This enables circular, rounded, stadium, and '
            'other shaped splash areas.',
      ),
      _buildSubSectionHeader('Circle Shape'),
      _buildLabeledDemo(
        'Circular InkWell with InkSparkle',
        Center(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashFactory: InkSparkle.splashFactory,
              customBorder: CircleBorder(),
              onTap: () {
                print('Circle InkWell tapped');
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFFEDE7F6),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.auto_awesome,
                    color: Color(0xFF6200EA),
                    size: 36,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'Circular InkWell with InkRipple',
        Center(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashFactory: InkRipple.splashFactory,
              customBorder: CircleBorder(),
              onTap: () {
                print('Circle InkRipple tapped');
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFFE3F2FD),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.waves, color: Color(0xFF1565C0), size: 36),
                ),
              ),
            ),
          ),
        ),
      ),
      _buildSubSectionHeader('Rounded Rectangle'),
      _buildLabeledDemo(
        'Rounded rectangle (borderRadius: 24)',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkSparkle.splashFactory,
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              print('Rounded rect InkWell tapped');
            },
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xFFE0F7FA),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(
                child: Text(
                  'Rounded Rectangle Sparkle',
                  style: TextStyle(
                    color: Color(0xFF006064),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'Stadium shape (borderRadius: 28 on pill)',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkSparkle.splashFactory,
            borderRadius: BorderRadius.circular(28),
            onTap: () {
              print('Stadium shape tapped');
            },
            child: Container(
              width: 200,
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xFFFCE4EC),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                child: Text(
                  'Stadium Sparkle',
                  style: TextStyle(
                    color: Color(0xFFC2185B),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      _buildSubSectionHeader('Custom Border Shape'),
      _buildLabeledDemo(
        'StadiumBorder via customBorder',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkSparkle.splashFactory,
            customBorder: StadiumBorder(),
            onTap: () {
              print('StadiumBorder customBorder tapped');
            },
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xFFF1F8E9),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                child: Text(
                  'StadiumBorder via customBorder',
                  style: TextStyle(
                    color: Color(0xFF33691E),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledDemo(
        'RoundedRectangleBorder via customBorder (radius: 16)',
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashFactory: InkRipple.splashFactory,
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onTap: () {
              print('RoundedRectangleBorder customBorder tapped');
            },
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xFFFFF8E1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'RoundedRectangleBorder Ripple',
                  style: TextStyle(
                    color: Color(0xFFF57F17),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      _buildSubSectionHeader('Small Circular Buttons'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCircleInkButton(Icons.add, Color(0xFF4CAF50), 'Add'),
          _buildCircleInkButton(Icons.edit, Color(0xFF2196F3), 'Edit'),
          _buildCircleInkButton(Icons.delete, Color(0xFFF44336), 'Delete'),
          _buildCircleInkButton(Icons.share, Color(0xFF9C27B0), 'Share'),
        ],
      ),
    ],
  );
}

Widget _buildPropertyReference() {
  print('  Building property reference');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'InkWell Properties',
        'Key properties of InkWell that control ink effects. '
            'All splash factories (InkSplash, InkRipple, InkSparkle) '
            'respond to these properties.',
      ),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPropertyRow(
              'splashFactory',
              'InkFeatureFactory',
              'Factory for creating splash effects',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'splashColor',
              'Color',
              'Color of the splash animation',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'highlightColor',
              'Color',
              'Color of the highlight overlay on press',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'hoverColor',
              'Color',
              'Color overlay when pointer hovers',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'focusColor',
              'Color',
              'Color overlay when focused via keyboard',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'borderRadius',
              'BorderRadius',
              'Clips splash to rounded rectangle',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'customBorder',
              'ShapeBorder',
              'Clips splash to arbitrary shape',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow('onTap', 'VoidCallback', 'Called when tapped'),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'onLongPress',
              'VoidCallback',
              'Called on long press',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'onDoubleTap',
              'VoidCallback',
              'Called on double tap',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'enableFeedback',
              'bool',
              'Whether to play sound/haptic on tap',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'excludeFromSemantics',
              'bool',
              'Whether to exclude from accessibility',
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      _buildInfoCard(
        'Splash Factory Reference',
        'Built-in splash factories available in Flutter Material library.',
      ),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPropertyRow(
              'InkSplash.splashFactory',
              'Factory',
              'Classic circular splash (Material 2 default)',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'InkRipple.splashFactory',
              'Factory',
              'Smooth ripple spreading outward',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'InkSparkle.splashFactory',
              'Factory',
              'Sparkle/shimmer effect (Material 3)',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'NoSplash.splashFactory',
              'Factory',
              'Disables splash entirely',
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      _buildInfoCard(
        'InkResponse Additional Properties',
        'InkResponse (parent of InkWell) has these extra properties.',
      ),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPropertyRow(
              'containedInkWell',
              'bool',
              'Whether splash is clipped to bounds',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'highlightShape',
              'BoxShape',
              'Shape of the highlight overlay',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'radius',
              'double',
              'Radius of the unbounded splash',
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildPropertyRow(
              'splashFactory',
              'Factory',
              'Override per-widget splash factory',
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildDebugSection() {
  print('  Building debug output section');
  print('  === InkSparkle Test Debug Summary ===');
  print('  Splash factories tested:');
  print('    - InkSplash.splashFactory (classic circular)');
  print('    - InkRipple.splashFactory (smooth ripple)');
  print('    - InkSparkle.splashFactory (Material 3 sparkle)');
  print('  Features covered:');
  print('    - Custom splash and highlight colors');
  print('    - Circle, rounded rectangle, stadium shapes');
  print('    - InkResponse vs InkWell comparison');
  print('    - ThemeData.splashFactory global configuration');
  print('    - Local override of theme splash factory');
  print('  InkSparkle notes:');
  print('    - Uses fragment shader for sparkle animation');
  print('    - Recommended for Material 3 designs');
  print('    - May require GPU shader compilation on first use');
  print('  === End Debug Summary ===');

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Debug Output Summary',
          style: TextStyle(
            color: Color(0xFF80CBC4),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Divider(color: Color(0xFF455A64)),
        SizedBox(height: 8),
        Text(
          'Expected print output:',
          style: TextStyle(
            color: Color(0xFFFFCC80),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6),
        Text(
          '> === InkSparkle Visual Demo ===\n'
          '> Section: 1. Default InkSplash\n'
          '> Section: 2. InkRipple\n'
          '> Section: 3. InkSparkle (Material 3)\n'
          '> Section: 4. Splash Comparison\n'
          '> Section: 5. Custom Splash Colors\n'
          '> Section: 6. Highlight and Splash\n'
          '> Section: 7. InkResponse vs InkWell\n'
          '> Section: 8. Themed Ink Effects\n'
          '> Section: 9. InkWell Shapes\n'
          '> Section: 10. Property Reference\n'
          '> Section: 11. Debug Output\n'
          '> InkSparkle Test completed',
          style: TextStyle(color: Color(0xFF80CBC4), fontSize: 11, height: 1.5),
        ),
        SizedBox(height: 10),
        Divider(color: Color(0xFF455A64)),
        SizedBox(height: 6),
        Text(
          'InkSparkle key facts:',
          style: TextStyle(
            color: Color(0xFFFFCC80),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '- InkSparkle is the Material 3 splash factory\n'
          '- Uses custom fragment shader for sparkle animation\n'
          '- Set globally via ThemeData.splashFactory\n'
          '- Set locally on InkWell or InkResponse via splashFactory\n'
          '- InkSplash is the default (Material 2) splash\n'
          '- InkRipple provides a smoother alternative\n'
          '- InkWell wraps InkResponse with rectangular defaults\n'
          '- InkResponse allows unbounded and custom-shaped splashes\n'
          '- splashColor controls the expanding animation color\n'
          '- highlightColor controls the solid overlay during press\n'
          '- customBorder clips splash to CircleBorder, StadiumBorder, etc.\n'
          '- borderRadius clips splash to rounded rectangle',
          style: TextStyle(color: Color(0xFFB0BEC5), fontSize: 11, height: 1.5),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== InkSparkle Visual Demo ===');
  print('Testing InkSparkle, InkSplash, InkRipple, and ink effects');
  print('InkSparkle is the Material 3 sparkle splash factory');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('InkSparkle Demo'),
        backgroundColor: Color(0xFF6200EA),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(
              'InkSparkle Overview',
              'InkSparkle is the Material 3 splash effect for InkWell and '
                  'InkResponse. It creates a sparkle/shimmer animation using a '
                  'custom fragment shader. Compared to InkSplash (classic circular) '
                  'and InkRipple (smooth ripple), InkSparkle produces a glittering '
                  'particle effect that is the recommended choice for Material 3.',
            ),
            _buildNoteBox(
              'InkSparkle requires GPU shader support. Set it via '
              'InkSparkle.splashFactory on individual InkWell widgets, or '
              'globally via ThemeData(splashFactory: InkSparkle.splashFactory). '
              'Related classes: InkSplash, InkRipple, InkHighlight.',
            ),
            _buildSectionHeader('1. Default InkSplash'),
            _buildDefaultSplash(),
            _buildSectionHeader('2. InkRipple'),
            _buildRippleSplash(),
            _buildSectionHeader('3. InkSparkle (Material 3)'),
            _buildSparkleSplash(),
            _buildSectionHeader('4. Splash Comparison'),
            _buildSplashComparison(),
            _buildSectionHeader('5. Custom Splash Colors'),
            _buildCustomSplashColors(),
            _buildSectionHeader('6. Highlight and Splash'),
            _buildHighlightAndSplash(),
            _buildSectionHeader('7. InkResponse vs InkWell'),
            _buildInkResponseComparison(),
            _buildSectionHeader('8. Themed Ink Effects'),
            _buildThemedInkEffects(),
            _buildSectionHeader('9. InkWell Shapes'),
            _buildInkWellShapes(),
            _buildSectionHeader('10. Property Reference'),
            _buildPropertyReference(),
            _buildSectionHeader('11. Debug Output'),
            _buildDebugSection(),
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

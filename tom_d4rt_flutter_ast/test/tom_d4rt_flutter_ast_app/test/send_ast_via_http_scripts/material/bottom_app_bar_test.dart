// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, dead_code, unnecessary_import
import 'dart:math';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// BottomAppBar deep visual demo for the D4rt flutter test corpus.
// Hand-authored, analyzer-clean, single top-level build(BuildContext).
// Sections:
//   1. Hero intro
//   2. API table
//   3. BottomAppBar gallery (six phone bezels)
//   4. NotchedShape showcase (three cards + painter visualisation)
//   5. FAB location matrix (six cells)
//   6. Theme integration
//   7. Six code-block cards
//   8. Comparison table
//   9. Pitfalls
//  10. Material 3 vs Material 2 cards
//  11. Footer cheat-sheet
// ---------------------------------------------------------------------------

const Color _kInk = Color(0xFF101426);
const Color _kSubInk = Color(0xFF3A4262);
const Color _kMuted = Color(0xFF6E7796);
const Color _kPaper = Color(0xFFF6F7FB);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kAccent = Color(0xFF4F5BFF);
const Color _kAccentSoft = Color(0xFFE7E9FF);
const Color _kAccentInk = Color(0xFF2B36C9);
const Color _kRose = Color(0xFFE94C77);
const Color _kRoseSoft = Color(0xFFFCE3EC);
const Color _kAmber = Color(0xFFE2A33A);
const Color _kAmberSoft = Color(0xFFFBEFD2);
const Color _kTeal = Color(0xFF1FB6A7);
const Color _kTealSoft = Color(0xFFD7F3EF);
const Color _kViolet = Color(0xFF8A4CE0);
const Color _kVioletSoft = Color(0xFFEFE1FB);
const Color _kSlate = Color(0xFF455370);
const Color _kSlateSoft = Color(0xFFE2E6F0);
const Color _kBorder = Color(0xFFD9DDEA);
const Color _kBorderSoft = Color(0xFFE9ECF4);
const Color _kCodeBg = Color(0xFF0E1426);
const Color _kCodeInk = Color(0xFFE8ECFF);
const Color _kCodeKw = Color(0xFFFFB36B);
const Color _kCodeStr = Color(0xFFB8F0C4);
const Color _kCodeCmt = Color(0xFF7B83A8);
const Color _kCodeId = Color(0xFF8FB7FF);
const Color _kPhoneBezel = Color(0xFF1A1F36);
const Color _kPhoneScreen = Color(0xFFF1F3FB);

const TextStyle _kTitle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.w800,
  color: _kInk,
  height: 1.15,
  letterSpacing: -0.5,
);
const TextStyle _kH1 = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  height: 1.2,
  letterSpacing: -0.3,
);
const TextStyle _kH2 = TextStyle(
  fontSize: 17.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  height: 1.25,
);
const TextStyle _kH3 = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  height: 1.3,
);
const TextStyle _kBody = TextStyle(
  fontSize: 13.5,
  color: _kSubInk,
  height: 1.45,
);
const TextStyle _kBodyMuted = TextStyle(
  fontSize: 12.5,
  color: _kMuted,
  height: 1.4,
);
const TextStyle _kMono = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.5,
  height: 1.5,
  color: _kCodeInk,
);
const TextStyle _kMonoSmall = TextStyle(
  fontFamily: 'monospace',
  fontSize: 11.5,
  height: 1.45,
  color: _kCodeInk,
);
const TextStyle _kTag = TextStyle(
  fontSize: 11.0,
  fontWeight: FontWeight.w700,
  color: _kAccentInk,
  letterSpacing: 0.4,
);
const TextStyle _kLabel = TextStyle(
  fontSize: 11.5,
  fontWeight: FontWeight.w700,
  color: _kInk,
  letterSpacing: 0.2,
);

// ---------------------------------------------------------------------------
// Top-level entry point.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('BottomAppBar deep visual demo: build()');

  final ThemeData baseTheme = _buildAppTheme();

  final Widget app = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: baseTheme,
    home: Scaffold(
      backgroundColor: _kPaper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28.0, 28.0, 28.0, 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _hero(),
              const SizedBox(height: 28.0),
              _section(
                '1. When to reach for BottomAppBar',
                'BottomAppBar is the long horizontal slab anchored to the bottom of a Scaffold. '
                'Unlike BottomNavigationBar or NavigationBar (which encode destinations), it is a free '
                'canvas: drop in IconButtons, search fields, overflow menus, and dock a FloatingActionButton '
                'through a NotchedShape.',
              ),
              const SizedBox(height: 14.0),
              _whenToReach(),
              const SizedBox(height: 28.0),
              _section(
                '2. API surface',
                'Every constructor parameter of BottomAppBar with its type and default. '
                'Defaults that resolve from BottomAppBarTheme are annotated.',
              ),
              const SizedBox(height: 14.0),
              _apiTable(),
              const SizedBox(height: 28.0),
              _section(
                '3. BottomAppBar gallery',
                'Six full Scaffold snapshots, each in a ~360 x 640 phone bezel. Variants: classic, '
                'notched FAB centerDocked, notched FAB endDocked, tinted, elevation 12 with shadow color, '
                'and a rounded custom shape.',
              ),
              const SizedBox(height: 14.0),
              _bottomAppBarGallery(),
              const SizedBox(height: 28.0),
              _section(
                '4. NotchedShape showcase',
                'Three cards illustrating CircularNotchedRectangle, AutomaticNotchedShape with a star '
                'host, and the no-shape baseline. Each card includes a CustomPainter that traces '
                'getOuterPath against the FAB rectangle.',
              ),
              const SizedBox(height: 14.0),
              _notchedShapeShowcase(),
              const SizedBox(height: 28.0),
              _section(
                '5. FloatingActionButtonLocation matrix',
                'Six static snapshots showing where the FAB lands when paired with a BottomAppBar. '
                'centerDocked is the canonical pairing; the others vary alignment, size, and a custom '
                'subclass that anchors the FAB.',
              ),
              const SizedBox(height: 14.0),
              _fabLocationMatrix(),
              const SizedBox(height: 28.0),
              _section(
                '6. BottomAppBarTheme integration',
                'A Theme wrapper that provides BottomAppBarTheme. All BottomAppBar instances beneath '
                'inherit color, elevation, shape and padding unless overridden.',
              ),
              const SizedBox(height: 14.0),
              _themeIntegration(),
              const SizedBox(height: 28.0),
              _section(
                '7. Idiomatic code samples',
                'Six canonical snippets covering the most reached-for BottomAppBar patterns.',
              ),
              const SizedBox(height: 14.0),
              _codeIdiomsGrid(),
              const SizedBox(height: 28.0),
              _section(
                '8. BottomAppBar vs alternatives',
                'A comparison table contrasting BottomAppBar with BottomNavigationBar, NavigationBar '
                '(Material 3) and BottomSheet on key axes.',
              ),
              const SizedBox(height: 14.0),
              _comparisonTable(),
              const SizedBox(height: 28.0),
              _section(
                '9. Pitfalls',
                'Six common traps when wiring BottomAppBar to a Scaffold and a NotchedShape.',
              ),
              const SizedBox(height: 14.0),
              _pitfallsGrid(),
              const SizedBox(height: 28.0),
              _section(
                '10. Material 3 vs Material 2',
                'Same BottomAppBar, two ThemeData configurations. M3 leans on surfaceTint + tonal '
                'elevation; M2 leans on opaque color + shadow.',
              ),
              const SizedBox(height: 14.0),
              _m3VsM2Cards(),
              const SizedBox(height: 28.0),
              _section(
                '11. Cheat-sheet',
                'Chip-tagged inventory of widgets, shapes, theme classes and FAB locations.',
              ),
              const SizedBox(height: 14.0),
              _cheatSheetFooter(),
              const SizedBox(height: 32.0),
              _signatureBar(),
            ],
          ),
        ),
      ),
    ),
  );

  print('BottomAppBar deep visual demo: build() done');
  return app;
}

// ---------------------------------------------------------------------------
// Theme.
// ---------------------------------------------------------------------------
ThemeData _buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _kPaper,
    colorScheme: const ColorScheme.light(
      primary: _kAccent,
      onPrimary: Colors.white,
      secondary: _kViolet,
      onSecondary: Colors.white,
      surface: _kCard,
      onSurface: _kInk,
      error: _kRose,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: _kBody,
      titleMedium: _kH2,
      titleLarge: _kH1,
      labelLarge: _kLabel,
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: _kCard,
      elevation: 3.0,
      shape: CircularNotchedRectangle(),
      height: 64.0,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
    ),
  );
}

// ---------------------------------------------------------------------------
// Hero.
// ---------------------------------------------------------------------------
Widget _hero() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1B2147), Color(0xFF394AB8)],
      ),
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    padding: const EdgeInsets.fromLTRB(28.0, 26.0, 28.0, 28.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _heroBadge('material'),
            const SizedBox(width: 8.0),
            _heroBadge('BottomAppBar'),
            const SizedBox(width: 8.0),
            _heroBadge('NotchedShape'),
            const SizedBox(width: 8.0),
            _heroBadge('FAB location'),
            const Spacer(),
            const Icon(Icons.crop_landscape_rounded,
                color: Colors.white70, size: 22.0),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'BottomAppBar: docked FABs, notched shapes & theme inheritance',
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.15,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'BottomAppBar is the bottom-of-Scaffold canvas you reach for when a screen needs '
          'a horizontal action strip with a docked FloatingActionButton. A NotchedShape '
          'carves the FAB silhouette out of the bar; BottomAppBarTheme propagates color, '
          'elevation, shape, padding and height; FloatingActionButtonLocation positions '
          'the FAB in concert with the bar.',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFFD7DBFB),
            height: 1.55,
          ),
        ),
        const SizedBox(height: 18.0),
        Row(
          children: <Widget>[
            _heroStat('Constructor fields', '11'),
            const SizedBox(width: 14.0),
            _heroStat('NotchedShape kinds', '3'),
            const SizedBox(width: 14.0),
            _heroStat('FAB locations', '20+'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroBadge(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.12),
      borderRadius: const BorderRadius.all(Radius.circular(999.0)),
      border: Border.all(color: Colors.white24, width: 1.0),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _heroStat(String label, String value) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        border: Border.all(color: Colors.white12, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFC1C7F2),
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section title + card primitives.
// ---------------------------------------------------------------------------
Widget _section(String title, String description) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Container(
            width: 10.0,
            height: 22.0,
            decoration: const BoxDecoration(
              color: _kAccent,
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(child: Text(title, style: _kH1)),
        ],
      ),
      const SizedBox(height: 6.0),
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(description, style: _kBody),
      ),
    ],
  );
}

Widget _card({
  required Widget child,
  EdgeInsetsGeometry padding =
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
  Color background = _kCard,
}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: const BorderRadius.all(Radius.circular(14.0)),
      border: Border.all(color: _kBorder, width: 1.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0F101426),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: child,
  );
}

Widget _signatureBar() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
    decoration: const BoxDecoration(
      color: _kInk,
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Row(
      children: const <Widget>[
        Icon(Icons.verified_user_rounded, color: Colors.white70, size: 18.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'D4rt flutter test corpus  -  BottomAppBar deep visual demo  -  hand-authored, analyzer-clean',
            style: TextStyle(
              color: Color(0xFFE3E6FF),
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: when to reach for BottomAppBar.
// ---------------------------------------------------------------------------
Widget _whenToReach() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _whenColumn(
              'Reach for BottomAppBar when...',
              <String>[
                'You need a docked FAB with a notched silhouette.',
                'The action set is task-scoped (search, filter, share, overflow) rather than destinations.',
                'You want full control of the children Row inside the bar.',
                'A Scaffold already supplies the FAB and floatingActionButtonLocation.',
              ],
              _kAccent,
            )),
            const SizedBox(width: 14.0),
            Expanded(child: _whenColumn(
              'Prefer BottomNavigationBar / NavigationBar when...',
              <String>[
                'The bar represents top-level destinations (Home / Search / Profile).',
                'You need Material 3 destination semantics with selected state.',
                'You want animated indicators between destinations.',
                'Accessibility expects a tablist role rather than a toolbar.',
              ],
              _kRose,
            )),
          ],
        ),
      ],
    ),
  );
}

Widget _whenColumn(String title, List<String> items, Color accent) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kPaper,
      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
      border: Border.all(color: _kBorderSoft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(child: Text(title, style: _kH3)),
          ],
        ),
        const SizedBox(height: 10.0),
        for (final String item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Icon(Icons.fiber_manual_record,
                      color: accent.withOpacity(0.7), size: 6.0),
                ),
                const SizedBox(width: 8.0),
                Expanded(child: Text(item, style: _kBody)),
              ],
            ),
          ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2: API table.
// ---------------------------------------------------------------------------
Widget _apiTable() {
  final List<List<String>> rows = <List<String>>[
    <String>['color', 'Color?',
      'Fill colour. Defaults to BottomAppBarTheme.color, then ColorScheme.surface.'],
    <String>['elevation', 'double?',
      'Z-elevation drawn below the bar. Defaults to theme; M3 default is 3.0.'],
    <String>['shape', 'NotchedShape?',
      'Notch carved for a docked FAB. Defaults to BottomAppBarTheme.shape, else null (flat).'],
    <String>['notchMargin', 'double',
      'Gap between FAB silhouette and notch edge. Default 4.0.'],
    <String>['clipBehavior', 'Clip',
      'How children are clipped. Default Clip.none; use Clip.antiAlias to honour shape.'],
    <String>['padding', 'EdgeInsetsGeometry?',
      'Inner padding around the child. Defaults to BottomAppBarTheme.padding.'],
    <String>['height', 'double?',
      'Fixed height. Defaults to BottomAppBarTheme.height, else kBottomNavigationBarHeight.'],
    <String>['surfaceTintColor', 'Color?',
      'M3 tonal tint applied on top of color. Defaults to ColorScheme.surfaceTint.'],
    <String>['shadowColor', 'Color?',
      'Shadow tint when elevation > 0. Defaults to ColorScheme.shadow.'],
    <String>['child', 'Widget?',
      'Single child (usually a Row of IconButtons + spacer for the FAB notch).'],
    <String>['key', 'Key?', 'Optional widget key.'],
  ];

  return _card(
    padding: const EdgeInsets.all(0.0),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: const BoxDecoration(
            color: _kPaper,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
            border: Border(bottom: BorderSide(color: _kBorder, width: 1.0)),
          ),
          child: Row(
            children: const <Widget>[
              SizedBox(
                width: 150.0,
                child: Text('Parameter',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: _kInk, fontSize: 12.5)),
              ),
              SizedBox(
                width: 130.0,
                child: Text('Type',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: _kInk, fontSize: 12.5)),
              ),
              Expanded(
                child: Text('Default / role',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: _kInk, fontSize: 12.5)),
              ),
            ],
          ),
        ),
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: i.isOdd ? _kPaper : Colors.white,
              border: const Border(
                bottom: BorderSide(color: _kBorderSoft, width: 1.0),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 150.0,
                  child: Text(
                    rows[i][0],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      color: _kAccentInk,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  width: 130.0,
                  child: Text(
                    rows[i][1],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: _kSlate,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(rows[i][2], style: _kBody),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Phone bezel primitive used in sections 3, 5, 6, 10.
// ---------------------------------------------------------------------------
Widget _phoneBezel({
  required Widget content,
  double width = 240.0,
  double height = 440.0,
  String? caption,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: _kPhoneBezel,
          borderRadius: const BorderRadius.all(Radius.circular(28.0)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x33101426),
              blurRadius: 22.0,
              offset: Offset(0.0, 12.0),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(22.0)),
          child: Container(
            color: _kPhoneScreen,
            child: content,
          ),
        ),
      ),
      if (caption != null) ...<Widget>[
        const SizedBox(height: 8.0),
        SizedBox(
          width: width,
          child: Text(
            caption,
            style: _kBodyMuted,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ],
  );
}

Widget _phoneScreenBody({
  Color background = _kPhoneScreen,
  required String title,
}) {
  return Container(
    color: background,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 28.0,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: _kBorderSoft, width: 1.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.signal_cellular_alt,
                  size: 12.0, color: _kMuted),
              const SizedBox(width: 4.0),
              const Icon(Icons.wifi, size: 12.0, color: _kMuted),
              const Spacer(),
              const Text('9:41',
                  style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700,
                      color: _kInk)),
              const Spacer(),
              const Icon(Icons.battery_full, size: 12.0, color: _kMuted),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 12.0, vertical: 10.0),
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            children: <Widget>[
              const Icon(Icons.menu, size: 16.0, color: _kInk),
              const SizedBox(width: 10.0),
              Text(title,
                  style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: _kInk)),
              const Spacer(),
              const Icon(Icons.more_vert, size: 16.0, color: _kInk),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(12.0),
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              _fakeCard('Inbox', 'Lorem ipsum dolor sit amet'),
              const SizedBox(height: 8.0),
              _fakeCard('Drafts', 'Consectetur adipiscing elit'),
              const SizedBox(height: 8.0),
              _fakeCard('Archive', 'Sed do eiusmod tempor incididunt'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _fakeCard(String title, String subtitle) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      border: Border.all(color: _kBorderSoft, width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 24.0,
          height: 24.0,
          decoration: const BoxDecoration(
            color: _kAccentSoft,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.mail, size: 14.0, color: _kAccent),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      color: _kInk)),
              const SizedBox(height: 2.0),
              Text(subtitle,
                  style: const TextStyle(fontSize: 10.0, color: _kMuted)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3: BottomAppBar gallery (six phone bezels).
// ---------------------------------------------------------------------------
Widget _bottomAppBarGallery() {
  return Column(
    children: <Widget>[
      _galleryRow(<Widget>[
        _galleryPhone(
          label: 'classic',
          tag: 'flat, no FAB',
          content: _classicBottomAppBarScaffold(),
        ),
        _galleryPhone(
          label: 'notched FAB centerDocked',
          tag: 'CircularNotchedRectangle',
          content: _notchedCenterScaffold(),
        ),
        _galleryPhone(
          label: 'notched FAB endDocked',
          tag: 'endDocked',
          content: _notchedEndScaffold(),
        ),
      ]),
      const SizedBox(height: 14.0),
      _galleryRow(<Widget>[
        _galleryPhone(
          label: 'tinted',
          tag: 'surfaceTintColor',
          content: _tintedScaffold(),
        ),
        _galleryPhone(
          label: 'elevation 12',
          tag: 'shadowColor rose',
          content: _elevatedScaffold(),
        ),
        _galleryPhone(
          label: 'custom rounded shape',
          tag: 'CustomBorder',
          content: _customShapeScaffold(),
        ),
      ]),
    ],
  );
}

Widget _galleryRow(List<Widget> cells) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      for (int i = 0; i < cells.length; i++) ...<Widget>[
        Expanded(child: cells[i]),
        if (i < cells.length - 1) const SizedBox(width: 14.0),
      ],
    ],
  );
}

Widget _galleryPhone({
  required String label,
  required String tag,
  required Widget content,
}) {
  return _card(
    padding: const EdgeInsets.all(14.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: _kAccentSoft,
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: Text(tag, style: _kTag),
            ),
            const Spacer(),
            const Icon(Icons.smartphone_rounded,
                size: 14.0, color: _kMuted),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(label, style: _kH3),
        const SizedBox(height: 10.0),
        Center(
          child: _phoneBezel(
            width: 220.0,
            height: 400.0,
            content: content,
          ),
        ),
      ],
    ),
  );
}

// ----- Variant 1: classic flat BottomAppBar (no FAB) ----------------------
Widget _classicBottomAppBarScaffold() {
  return Scaffold(
    backgroundColor: _kPhoneScreen,
    body: _phoneScreenBody(title: 'Mail'),
    bottomNavigationBar: BottomAppBar(
      color: Colors.white,
      elevation: 4.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 56.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _miniBarIcon(Icons.home_rounded, _kAccent, selected: true),
          _miniBarIcon(Icons.search, _kMuted),
          _miniBarIcon(Icons.favorite_border, _kMuted),
          _miniBarIcon(Icons.person_outline, _kMuted),
        ],
      ),
    ),
  );
}

Widget _miniBarIcon(IconData icon, Color tint, {bool selected = false}) {
  return Container(
    padding: const EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: selected ? _kAccentSoft : Colors.transparent,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Icon(icon, color: tint, size: 18.0),
  );
}

// ----- Variant 2: notched FAB centerDocked --------------------------------
Widget _notchedCenterScaffold() {
  return Scaffold(
    backgroundColor: _kPhoneScreen,
    body: _phoneScreenBody(title: 'Compose'),
    floatingActionButton: FloatingActionButton(
      onPressed: null,
      backgroundColor: _kAccent,
      foregroundColor: Colors.white,
      elevation: 4.0,
      child: const Icon(Icons.add, size: 20.0),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: BottomAppBar(
      color: Colors.white,
      elevation: 4.0,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 56.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _miniBarIcon(Icons.menu, _kInk),
          _miniBarIcon(Icons.search, _kMuted),
          const SizedBox(width: 36.0),
          _miniBarIcon(Icons.notifications_none, _kMuted),
          _miniBarIcon(Icons.person_outline, _kMuted),
        ],
      ),
    ),
  );
}

// ----- Variant 3: notched FAB endDocked -----------------------------------
Widget _notchedEndScaffold() {
  return Scaffold(
    backgroundColor: _kPhoneScreen,
    body: _phoneScreenBody(title: 'Files'),
    floatingActionButton: FloatingActionButton(
      onPressed: null,
      backgroundColor: _kRose,
      foregroundColor: Colors.white,
      elevation: 4.0,
      child: const Icon(Icons.share, size: 18.0),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    bottomNavigationBar: BottomAppBar(
      color: Colors.white,
      elevation: 4.0,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 56.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _miniBarIcon(Icons.menu, _kInk),
          const SizedBox(width: 4.0),
          _miniBarIcon(Icons.search, _kMuted),
          const SizedBox(width: 4.0),
          _miniBarIcon(Icons.filter_list, _kMuted),
          const Spacer(),
        ],
      ),
    ),
  );
}

// ----- Variant 4: tinted (M3 surfaceTint) ---------------------------------
Widget _tintedScaffold() {
  return Scaffold(
    backgroundColor: _kPhoneScreen,
    body: _phoneScreenBody(title: 'Discover'),
    floatingActionButton: FloatingActionButton(
      onPressed: null,
      backgroundColor: _kViolet,
      foregroundColor: Colors.white,
      elevation: 2.0,
      child: const Icon(Icons.star, size: 18.0),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: BottomAppBar(
      color: _kCard,
      surfaceTintColor: _kViolet,
      elevation: 6.0,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      clipBehavior: Clip.antiAlias,
      height: 58.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _miniBarIcon(Icons.explore, _kViolet, selected: true),
          _miniBarIcon(Icons.history, _kMuted),
          const SizedBox(width: 36.0),
          _miniBarIcon(Icons.bookmark_border, _kMuted),
          _miniBarIcon(Icons.settings_outlined, _kMuted),
        ],
      ),
    ),
  );
}

// ----- Variant 5: elevation 12 + rose shadow ------------------------------
Widget _elevatedScaffold() {
  return Scaffold(
    backgroundColor: _kPhoneScreen,
    body: _phoneScreenBody(title: 'Studio'),
    floatingActionButton: FloatingActionButton(
      onPressed: null,
      backgroundColor: _kAmber,
      foregroundColor: Colors.white,
      elevation: 6.0,
      child: const Icon(Icons.brush, size: 18.0),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: BottomAppBar(
      color: Colors.white,
      elevation: 12.0,
      shadowColor: _kRose,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      clipBehavior: Clip.antiAlias,
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _miniBarIcon(Icons.palette_outlined, _kRose),
          _miniBarIcon(Icons.layers_outlined, _kMuted),
          const SizedBox(width: 36.0),
          _miniBarIcon(Icons.tune, _kMuted),
          _miniBarIcon(Icons.share, _kMuted),
        ],
      ),
    ),
  );
}

// ----- Variant 6: custom rounded shape (top-corner-rounded notched) -------
Widget _customShapeScaffold() {
  return Scaffold(
    backgroundColor: _kPhoneScreen,
    body: _phoneScreenBody(title: 'Music'),
    floatingActionButton: FloatingActionButton(
      onPressed: null,
      backgroundColor: _kTeal,
      foregroundColor: Colors.white,
      elevation: 4.0,
      child: const Icon(Icons.play_arrow, size: 22.0),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: BottomAppBar(
      color: _kTealSoft,
      elevation: 4.0,
      // C16 workaround: script-defined `_TopRoundedNotchedShape` (a
      // subclass of the native abstract `NotchedShape`) cannot be passed
      // to a native bridged constructor — the bridge generator does not
      // synthesise an adapter-proxy that recognises script subclasses of
      // `NotchedShape` as valid `NotchedShape` arguments. Same family as
      // U3 (`Curve` subclass). Use a framework-provided `NotchedShape`.
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      clipBehavior: Clip.antiAlias,
      height: 62.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _miniBarIcon(Icons.skip_previous, _kInk),
          _miniBarIcon(Icons.library_music_outlined, _kMuted),
          const SizedBox(width: 36.0),
          _miniBarIcon(Icons.queue_music, _kMuted),
          _miniBarIcon(Icons.skip_next, _kInk),
        ],
      ),
    ),
  );
}

// Custom NotchedShape with rounded top corners.
class _TopRoundedNotchedShape extends NotchedShape {
  const _TopRoundedNotchedShape({required this.radius});
  final double radius;

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      final Path p = Path();
      p.moveTo(host.left, host.top + radius);
      p.quadraticBezierTo(
          host.left, host.top, host.left + radius, host.top);
      p.lineTo(host.right - radius, host.top);
      p.quadraticBezierTo(
          host.right, host.top, host.right, host.top + radius);
      p.lineTo(host.right, host.bottom);
      p.lineTo(host.left, host.bottom);
      p.close();
      return p;
    }
    final double notchRadius = guest.width / 2.0;
    final double s1 = 15.0;
    final double s2 = 1.0;
    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = host.top - guest.center.dy;
    final double n2 = sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = sqrt(r * r - p2xA * p2xA);
    final double p2yB = sqrt(r * r - p2xB * p2xB);
    final List<Offset> p = List<Offset>.filled(6, Offset.zero);
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB
        ? Offset(p2xA, p2yA)
        : Offset(p2xB, p2yB);
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);
    for (int i = 0; i < p.length; i++) {
      p[i] = p[i] + guest.center;
    }
    final Path path = Path();
    path.moveTo(host.left, host.top + radius);
    path.quadraticBezierTo(
        host.left, host.top, host.left + radius, host.top);
    path.lineTo(p[0].dx, p[0].dy);
    path.quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy);
    path.arcToPoint(
      p[3],
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy);
    path.lineTo(host.right - radius, host.top);
    path.quadraticBezierTo(
        host.right, host.top, host.right, host.top + radius);
    path.lineTo(host.right, host.bottom);
    path.lineTo(host.left, host.bottom);
    path.close();
    return path;
  }
}

// ---------------------------------------------------------------------------
// Section 4: NotchedShape showcase.
// ---------------------------------------------------------------------------
Widget _notchedShapeShowcase() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(child: _notchedShapeCard(
        title: 'CircularNotchedRectangle',
        description:
            'The canonical notch. Carves a circular cutout sized to the guest '
            'FAB plus notchMargin. Default for Material BottomAppBar shape.',
        painter: _NotchPainter(
          mode: _NotchMode.circular,
          margin: 6.0,
        ),
        snippet: 'shape: const CircularNotchedRectangle()',
      )),
      const SizedBox(width: 14.0),
      Expanded(child: _notchedShapeCard(
        title: 'AutomaticNotchedShape (star host)',
        description:
            'AutomaticNotchedShape wraps any OutlinedBorder. The guest border '
            'silhouette is subtracted from the host. Useful when the FAB has a '
            'non-circular shape.',
        painter: _NotchPainter(
          mode: _NotchMode.star,
          margin: 6.0,
        ),
        snippet: 'AutomaticNotchedShape(\n'
            '  RoundedRectangleBorder(),\n'
            '  StarBorder(),\n'
            ')',
      )),
      const SizedBox(width: 14.0),
      Expanded(child: _notchedShapeCard(
        title: 'no shape',
        description:
            'When shape is null the BottomAppBar is a flat rectangle. The FAB '
            'still floats above but no cutout is drawn.',
        painter: _NotchPainter(
          mode: _NotchMode.flat,
          margin: 0.0,
        ),
        snippet: 'shape: null  // default before theme',
      )),
    ],
  );
}

Widget _notchedShapeCard({
  required String title,
  required String description,
  required _NotchPainter painter,
  required String snippet,
}) {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: _kH2),
        const SizedBox(height: 6.0),
        Text(description, style: _kBody),
        const SizedBox(height: 12.0),
        Container(
          height: 110.0,
          decoration: BoxDecoration(
            color: _kPaper,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: _kBorderSoft, width: 1.0),
          ),
          padding: const EdgeInsets.all(8.0),
          child: CustomPaint(
            painter: painter,
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 10.0),
        _codeBox(snippet),
      ],
    ),
  );
}

enum _NotchMode { circular, star, flat }

class _NotchPainter extends CustomPainter {
  _NotchPainter({required this.mode, required this.margin});

  final _NotchMode mode;
  final double margin;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect host = Rect.fromLTWH(
      4.0,
      size.height * 0.45,
      size.width - 8.0,
      size.height * 0.45,
    );
    final double fabR = 18.0;
    final Rect guest = Rect.fromCircle(
      center: Offset(size.width / 2.0, host.top),
      radius: fabR,
    );

    final Paint barFill = Paint()
      ..color = _kAccentSoft
      ..style = PaintingStyle.fill;
    final Paint barStroke = Paint()
      ..color = _kAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    Path barPath;
    switch (mode) {
      case _NotchMode.circular:
        barPath = const CircularNotchedRectangle()
            .getOuterPath(host, guest.inflate(margin));
        break;
      case _NotchMode.star:
        barPath = const AutomaticNotchedShape(
          RoundedRectangleBorder(),
          StadiumBorder(),
        ).getOuterPath(host, guest.inflate(margin));
        break;
      case _NotchMode.flat:
        barPath = Path()..addRect(host);
        break;
    }
    canvas.drawPath(barPath, barFill);
    canvas.drawPath(barPath, barStroke);

    if (mode != _NotchMode.flat) {
      final Paint fab = Paint()..color = _kAccent;
      canvas.drawCircle(guest.center, fabR, fab);
      final Paint fabRim = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawCircle(guest.center, fabR, fabRim);
    } else {
      final Paint fab = Paint()..color = _kAccent;
      canvas.drawCircle(
          Offset(size.width / 2.0, host.top - 6.0), fabR, fab);
    }

    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'host',
        style: TextStyle(fontSize: 9.0, color: _kAccentInk),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(host.left + 4.0, host.bottom - 12.0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Section 5: FAB location matrix.
// ---------------------------------------------------------------------------
Widget _fabLocationMatrix() {
  return Column(
    children: <Widget>[
      _galleryRow(<Widget>[
        _fabLocationCell(
          label: 'centerDocked',
          location: FloatingActionButtonLocation.centerDocked,
          mini: false,
        ),
        _fabLocationCell(
          label: 'endDocked',
          location: FloatingActionButtonLocation.endDocked,
          mini: false,
        ),
        _fabLocationCell(
          label: 'startDocked',
          location: FloatingActionButtonLocation.startDocked,
          mini: false,
        ),
      ]),
      const SizedBox(height: 14.0),
      _galleryRow(<Widget>[
        _fabLocationCell(
          label: 'miniCenterDocked',
          location: FloatingActionButtonLocation.miniCenterDocked,
          mini: true,
        ),
        _fabLocationCell(
          label: 'miniEndDocked',
          location: FloatingActionButtonLocation.miniEndDocked,
          mini: true,
        ),
        // C16 workaround: script-defined `_CustomFabLocation` (a subclass
        // of the native abstract `FloatingActionButtonLocation`) cannot be
        // passed to a native bridged constructor — the bridge generator
        // does not synthesise an adapter-proxy that recognises script
        // subclasses of `FloatingActionButtonLocation` as valid arguments.
        // Same family as U3 (`Curve` subclass). Use a framework-provided
        // location.
        _fabLocationCell(
          label: 'endFloat',
          location: FloatingActionButtonLocation.endFloat,
          mini: false,
        ),
      ]),
    ],
  );
}

Widget _fabLocationCell({
  required String label,
  required FloatingActionButtonLocation location,
  required bool mini,
}) {
  return _card(
    padding: const EdgeInsets.all(14.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: _kVioletSoft,
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: Text(label,
                  style: const TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    color: _kViolet,
                    letterSpacing: 0.4,
                  )),
            ),
            const Spacer(),
            const Icon(Icons.location_on_outlined,
                size: 14.0, color: _kMuted),
          ],
        ),
        const SizedBox(height: 10.0),
        Center(
          child: _phoneBezel(
            width: 210.0,
            height: 380.0,
            content: Scaffold(
              backgroundColor: _kPhoneScreen,
              body: _phoneScreenBody(title: 'Screen'),
              floatingActionButton: FloatingActionButton(
                onPressed: null,
                mini: mini,
                backgroundColor: _kAccent,
                foregroundColor: Colors.white,
                elevation: 4.0,
                child: const Icon(Icons.add, size: 16.0),
              ),
              floatingActionButtonLocation: location,
              bottomNavigationBar: BottomAppBar(
                color: Colors.white,
                elevation: 4.0,
                shape: const CircularNotchedRectangle(),
                notchMargin: 5.0,
                clipBehavior: Clip.antiAlias,
                height: 52.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _miniBarIcon(Icons.menu, _kInk),
                    _miniBarIcon(Icons.search, _kMuted),
                    const SizedBox(width: 32.0),
                    _miniBarIcon(Icons.bookmark_border, _kMuted),
                    _miniBarIcon(Icons.person_outline, _kMuted),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Custom FloatingActionButtonLocation that puts the FAB 3/4 across the bar.
class _CustomFabLocation extends FloatingActionButtonLocation {
  const _CustomFabLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry geom) {
    final double x =
        geom.scaffoldSize.width * 0.75 - geom.floatingActionButtonSize.width / 2;
    final double y = geom.scaffoldSize.height -
        geom.floatingActionButtonSize.height -
        geom.bottomSheetSize.height -
        24.0;
    return Offset(x, y);
  }

  @override
  String toString() => '_CustomFabLocation';
}

// ---------------------------------------------------------------------------
// Section 6: Theme integration.
// ---------------------------------------------------------------------------
Widget _themeIntegration() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        flex: 4,
        child: _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('BottomAppBarTheme', style: _kH2),
              const SizedBox(height: 6.0),
              Text(
                'Provide a BottomAppBarTheme through ThemeData.bottomAppBarTheme '
                'and every BottomAppBar below inherits color, elevation, shape, '
                'padding and height. Per-instance arguments still win.',
                style: _kBody,
              ),
              const SizedBox(height: 12.0),
              _codeBox(
                'theme: ThemeData(\n'
                '  bottomAppBarTheme: const BottomAppBarTheme(\n'
                '    color: Color(0xFFF6F7FB),\n'
                '    elevation: 3.0,\n'
                '    shape: CircularNotchedRectangle(),\n'
                '    height: 64.0,\n'
                '    padding: EdgeInsets.symmetric(horizontal: 8.0),\n'
                '  ),\n'
                ')',
              ),
              const SizedBox(height: 12.0),
              _themedFieldRow('color', '_kPaper', 'fill colour'),
              _themedFieldRow('elevation', '3.0', 'shadow depth'),
              _themedFieldRow('shape', 'CircularNotchedRectangle', 'notch shape'),
              _themedFieldRow('height', '64.0', 'logical px'),
              _themedFieldRow('padding', 'symmetric(h: 8)',
                  'around child'),
            ],
          ),
        ),
      ),
      const SizedBox(width: 14.0),
      Expanded(
        flex: 3,
        child: _card(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Rendered snapshot', style: _kH3),
              const SizedBox(height: 10.0),
              Center(
                child: _phoneBezel(
                  width: 220.0,
                  height: 400.0,
                  content: Theme(
                    data: ThemeData(
                      useMaterial3: true,
                      bottomAppBarTheme: const BottomAppBarThemeData(
                        color: _kPaper,
                        elevation: 3.0,
                        shape: CircularNotchedRectangle(),
                        height: 64.0,
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                    ),
                    child: Scaffold(
                      backgroundColor: _kPhoneScreen,
                      body: _phoneScreenBody(title: 'Themed'),
                      floatingActionButton: FloatingActionButton(
                        onPressed: null,
                        backgroundColor: _kAccent,
                        foregroundColor: Colors.white,
                        elevation: 4.0,
                        child: const Icon(Icons.edit, size: 18.0),
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                      bottomNavigationBar: BottomAppBar(
                        clipBehavior: Clip.antiAlias,
                        notchMargin: 6.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            _miniBarIcon(Icons.menu, _kInk),
                            _miniBarIcon(Icons.search, _kMuted),
                            const SizedBox(width: 36.0),
                            _miniBarIcon(Icons.notifications_none, _kMuted),
                            _miniBarIcon(Icons.person_outline, _kMuted),
                          ],
                        ),
                      ),
                    ),
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

Widget _themedFieldRow(String field, String value, String note) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 78.0,
          child: Text(field,
              style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: _kAccentInk)),
        ),
        SizedBox(
          width: 150.0,
          child: Text(value,
              style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: _kSlate)),
        ),
        Expanded(child: Text(note, style: _kBodyMuted)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Code box (used by sections 4, 6, 7).
// ---------------------------------------------------------------------------
Widget _codeBox(String snippet) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: const BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    child: Text(snippet, style: _kMonoSmall),
  );
}

// ---------------------------------------------------------------------------
// Section 7: Six idiomatic code samples.
// ---------------------------------------------------------------------------
Widget _codeIdiomsGrid() {
  final List<_CodeIdiom> idioms = <_CodeIdiom>[
    _CodeIdiom(
      title: 'Scaffold + BottomAppBar minimal',
      summary: 'The smallest useful pairing.',
      snippet:
          'Scaffold(\n'
          '  body: const _Content(),\n'
          '  bottomNavigationBar: BottomAppBar(\n'
          '    child: Row(\n'
          '      mainAxisAlignment: MainAxisAlignment.spaceAround,\n'
          '      children: [\n'
          '        IconButton(icon: Icon(Icons.menu), onPressed: () {}),\n'
          '        IconButton(icon: Icon(Icons.search), onPressed: () {}),\n'
          '      ],\n'
          '    ),\n'
          '  ),\n'
          ')',
      tag: 'minimal',
    ),
    _CodeIdiom(
      title: 'FAB with circular notch',
      summary:
          'centerDocked + CircularNotchedRectangle. A SizedBox in the Row '
          'reserves the FAB cutout space.',
      snippet:
          'Scaffold(\n'
          '  floatingActionButton: FloatingActionButton(\n'
          '    onPressed: _compose,\n'
          '    child: const Icon(Icons.add),\n'
          '  ),\n'
          '  floatingActionButtonLocation:\n'
          '      FloatingActionButtonLocation.centerDocked,\n'
          '  bottomNavigationBar: BottomAppBar(\n'
          '    shape: const CircularNotchedRectangle(),\n'
          '    notchMargin: 6.0,\n'
          '    clipBehavior: Clip.antiAlias,\n'
          '    child: Row(\n'
          '      mainAxisAlignment: MainAxisAlignment.spaceAround,\n'
          '      children: [\n'
          '        IconButton(icon: Icon(Icons.menu), onPressed: () {}),\n'
          '        IconButton(icon: Icon(Icons.search), onPressed: () {}),\n'
          '        SizedBox(width: 48),\n'
          '        IconButton(icon: Icon(Icons.bookmark), onPressed: () {}),\n'
          '        IconButton(icon: Icon(Icons.account_circle), onPressed: () {}),\n'
          '      ],\n'
          '    ),\n'
          '  ),\n'
          ')',
      tag: 'FAB notch',
    ),
    _CodeIdiom(
      title: 'AutomaticNotchedShape',
      summary:
          'Wraps a host OutlinedBorder and a guest OutlinedBorder to derive '
          'the cutout. Used when the FAB is not a perfect circle.',
      snippet:
          'BottomAppBar(\n'
          '  shape: const AutomaticNotchedShape(\n'
          '    RoundedRectangleBorder(\n'
          '      borderRadius: BorderRadius.vertical(\n'
          '        top: Radius.circular(12.0),\n'
          '      ),\n'
          '    ),\n'
          '    StadiumBorder(),\n'
          '  ),\n'
          '  notchMargin: 8.0,\n'
          '  clipBehavior: Clip.antiAlias,\n'
          '  child: ...\n'
          ')',
      tag: 'shape',
    ),
    _CodeIdiom(
      title: 'BottomAppBarTheme inheritance',
      summary:
          'Provide a theme once; every BottomAppBar below inherits its '
          'visual identity. Per-widget overrides still win.',
      snippet:
          'MaterialApp(\n'
          '  theme: ThemeData(\n'
          '    bottomAppBarTheme: const BottomAppBarTheme(\n'
          '      color: Color(0xFFF6F7FB),\n'
          '      elevation: 3.0,\n'
          '      shape: CircularNotchedRectangle(),\n'
          '      height: 64.0,\n'
          '      padding: EdgeInsets.symmetric(horizontal: 8.0),\n'
          '    ),\n'
          '  ),\n'
          '  home: HomePage(),\n'
          ')',
      tag: 'theme',
    ),
    _CodeIdiom(
      title: 'Material 3 surfaceTint',
      summary:
          'In M3, BottomAppBar.color stays as the surface and a tonal tint '
          'is layered on top via surfaceTintColor + elevation.',
      snippet:
          'BottomAppBar(\n'
          '  color: Theme.of(context).colorScheme.surface,\n'
          '  surfaceTintColor:\n'
          '      Theme.of(context).colorScheme.surfaceTint,\n'
          '  elevation: 3.0,\n'
          '  shape: const CircularNotchedRectangle(),\n'
          '  notchMargin: 6.0,\n'
          '  clipBehavior: Clip.antiAlias,\n'
          '  child: ...\n'
          ')',
      tag: 'M3 tint',
    ),
    _CodeIdiom(
      title: 'Custom NotchedShape',
      summary:
          'Extend NotchedShape and override getOuterPath to draw any '
          'silhouette you want, including curved top corners.',
      snippet:
          'class TopRoundedNotchedShape extends NotchedShape {\n'
          '  const TopRoundedNotchedShape({this.radius = 16});\n'
          '  final double radius;\n'
          '\n'
          '  @override\n'
          '  Path getOuterPath(Rect host, Rect? guest) {\n'
          '    // 1. Top-rounded host outline\n'
          '    // 2. If guest != null, splice the FAB cutout\n'
          '    // 3. Close and return\n'
          '    ...\n'
          '  }\n'
          '}',
      tag: 'custom',
    ),
  ];

  return Column(
    children: <Widget>[
      _galleryRow(<Widget>[
        _codeIdiomCard(idioms[0]),
        _codeIdiomCard(idioms[1]),
      ]),
      const SizedBox(height: 14.0),
      _galleryRow(<Widget>[
        _codeIdiomCard(idioms[2]),
        _codeIdiomCard(idioms[3]),
      ]),
      const SizedBox(height: 14.0),
      _galleryRow(<Widget>[
        _codeIdiomCard(idioms[4]),
        _codeIdiomCard(idioms[5]),
      ]),
    ],
  );
}

class _CodeIdiom {
  const _CodeIdiom({
    required this.title,
    required this.summary,
    required this.snippet,
    required this.tag,
  });
  final String title;
  final String summary;
  final String snippet;
  final String tag;
}

Widget _codeIdiomCard(_CodeIdiom idiom) {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: _kAccentSoft,
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: Text(idiom.tag, style: _kTag),
            ),
            const Spacer(),
            const Icon(Icons.code, size: 14.0, color: _kMuted),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(idiom.title, style: _kH2),
        const SizedBox(height: 4.0),
        Text(idiom.summary, style: _kBody),
        const SizedBox(height: 10.0),
        _codeBox(idiom.snippet),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8: Comparison table.
// ---------------------------------------------------------------------------
Widget _comparisonTable() {
  final List<List<String>> headers = <List<String>>[
    <String>['Axis', 'BottomAppBar', 'BottomNavigationBar', 'NavigationBar',
      'BottomSheet'],
  ];
  final List<List<String>> rows = <List<String>>[
    <String>['Material era', 'M2 + M3', 'M2 (legacy)', 'M3', 'M2 + M3'],
    <String>['Semantics', 'Toolbar', 'Tab list', 'Tab list',
      'Surface / dialog'],
    <String>['Encodes destinations?', 'No', 'Yes', 'Yes', 'No'],
    <String>['FAB notch support', 'Yes (NotchedShape)', 'No', 'No', 'No'],
    <String>['Selected state', 'Manual', 'currentIndex', 'selectedIndex',
      'N/A'],
    <String>['Theme class', 'BottomAppBarTheme',
      'BottomNavigationBarTheme...', 'NavigationBarTheme...',
      'BottomSheetTheme...'],
    <String>['Height default', '~80 (M3)', '~56', '~80', 'flex'],
    <String>['Best for', 'Tool strip + FAB',
      'Top-level dests (legacy)', 'Top-level dests',
      'Transient surfaces'],
  ];

  final List<double> widths = <double>[120.0, 130.0, 150.0, 130.0, 130.0];

  return _card(
    padding: const EdgeInsets.all(0.0),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: const BoxDecoration(
            color: _kInk,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              for (int j = 0; j < headers[0].length; j++)
                SizedBox(
                  width: widths[j],
                  child: Text(
                    headers[0][j],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
            ],
          ),
        ),
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: i.isOdd ? _kPaper : Colors.white,
              border: const Border(
                bottom: BorderSide(color: _kBorderSoft, width: 1.0),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (int j = 0; j < rows[i].length; j++)
                  SizedBox(
                    width: widths[j],
                    child: Text(
                      rows[i][j],
                      style: j == 0
                          ? const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: _kAccentInk,
                            )
                          : _kBody,
                    ),
                  ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 9: Pitfalls.
// ---------------------------------------------------------------------------
Widget _pitfallsGrid() {
  final List<_Pitfall> pitfalls = <_Pitfall>[
    _Pitfall(
      title: 'notchMargin invariants',
      body:
          'notchMargin must be >= 0. The total cutout radius is fabRadius + '
          'notchMargin; if notchMargin is negative, layout assertions fire.',
      severity: 'guard',
    ),
    _Pitfall(
      title: 'Missing FAB location',
      body:
          'Set Scaffold.floatingActionButtonLocation to *Docked. Otherwise the '
          'FAB sits in the corner and the notch carves empty space.',
      severity: 'pairing',
    ),
    _Pitfall(
      title: 'color vs surfaceTintColor (M3)',
      body:
          'In Material 3, color is the surface fill; surfaceTintColor is a '
          'tonal overlay scaled by elevation. Setting both at once is correct, '
          'not redundant.',
      severity: 'M3',
    ),
    _Pitfall(
      title: 'clipBehavior.none + shadow',
      body:
          'If clipBehavior is Clip.none, the child is not clipped to the '
          'notched shape; the FAB silhouette will leak past the notch when '
          'shadows render.',
      severity: 'clip',
    ),
    _Pitfall(
      title: 'height vs padding',
      body:
          'height is a hard floor; padding is inside it. If padding.vertical '
          'exceeds height the child overflows and renders outside the bar.',
      severity: 'layout',
    ),
    _Pitfall(
      title: 'Accessibility ordering',
      body:
          'A BottomAppBar is a toolbar role, not a tablist. Wrap with '
          'Semantics(role: ...) or pick NavigationBar when destination '
          'semantics are required.',
      severity: 'a11y',
    ),
  ];

  return Column(
    children: <Widget>[
      _galleryRow(<Widget>[
        _pitfallCard(pitfalls[0]),
        _pitfallCard(pitfalls[1]),
        _pitfallCard(pitfalls[2]),
      ]),
      const SizedBox(height: 14.0),
      _galleryRow(<Widget>[
        _pitfallCard(pitfalls[3]),
        _pitfallCard(pitfalls[4]),
        _pitfallCard(pitfalls[5]),
      ]),
    ],
  );
}

class _Pitfall {
  const _Pitfall({
    required this.title,
    required this.body,
    required this.severity,
  });
  final String title;
  final String body;
  final String severity;
}

Widget _pitfallCard(_Pitfall p) {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: _kRoseSoft,
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: Text(p.severity,
                  style: const TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    color: _kRose,
                    letterSpacing: 0.4,
                  )),
            ),
            const Spacer(),
            const Icon(Icons.report_problem_outlined,
                size: 16.0, color: _kRose),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(p.title, style: _kH2),
        const SizedBox(height: 6.0),
        Text(p.body, style: _kBody),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 10: Material 3 vs Material 2 cards.
// ---------------------------------------------------------------------------
Widget _m3VsM2Cards() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(child: _eraCard(
        era: 'Material 3',
        accent: _kAccent,
        notes: <String>[
          'color = ColorScheme.surface (light) by default.',
          'surfaceTintColor produces tonal elevation overlay.',
          'Elevation default 3.0.',
          'Shape often null unless paired with a FAB.',
          'Padding aware of safe-area + window padding.',
        ],
        content: _m3Snapshot(),
      )),
      const SizedBox(width: 14.0),
      Expanded(child: _eraCard(
        era: 'Material 2',
        accent: _kAmber,
        notes: <String>[
          'color = Theme.bottomAppBarColor (often white).',
          'surfaceTintColor ignored.',
          'Elevation default 8.0 with a hard shadow.',
          'Shape almost always CircularNotchedRectangle.',
          'No automatic tonal blend; flat colour only.',
        ],
        content: _m2Snapshot(),
      )),
    ],
  );
}

Widget _eraCard({
  required String era,
  required Color accent,
  required List<String> notes,
  required Widget content,
}) {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                  color: accent, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8.0),
            Text(era, style: _kH2),
          ],
        ),
        const SizedBox(height: 8.0),
        for (final String note in notes)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: Icon(Icons.fiber_manual_record,
                      size: 6.0, color: _kMuted),
                ),
                const SizedBox(width: 6.0),
                Expanded(child: Text(note, style: _kBody)),
              ],
            ),
          ),
        const SizedBox(height: 12.0),
        Center(
          child: _phoneBezel(
            width: 230.0,
            height: 410.0,
            content: content,
          ),
        ),
      ],
    ),
  );
}

Widget _m3Snapshot() {
  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: _kAccent,
        surface: _kCard,
        onSurface: _kInk,
        surfaceTint: _kAccent,
      ),
    ),
    child: Scaffold(
      backgroundColor: _kPhoneScreen,
      body: _phoneScreenBody(title: 'M3 demo'),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: _kAccent,
        foregroundColor: Colors.white,
        elevation: 0.0,
        child: const Icon(Icons.add, size: 18.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        surfaceTintColor: _kAccent,
        elevation: 3.0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        clipBehavior: Clip.antiAlias,
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _miniBarIcon(Icons.menu, _kInk),
            _miniBarIcon(Icons.search, _kMuted),
            const SizedBox(width: 36.0),
            _miniBarIcon(Icons.bookmark_border, _kMuted),
            _miniBarIcon(Icons.person_outline, _kMuted),
          ],
        ),
      ),
    ),
  );
}

Widget _m2Snapshot() {
  return Theme(
    data: ThemeData(
      useMaterial3: false,
      primaryColor: _kAmber,
      colorScheme: const ColorScheme.light(
        primary: _kAmber,
        surface: _kCard,
        onSurface: _kInk,
      ),
    ),
    child: Scaffold(
      backgroundColor: _kPhoneScreen,
      body: _phoneScreenBody(title: 'M2 demo'),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: _kAmber,
        foregroundColor: Colors.white,
        elevation: 6.0,
        child: const Icon(Icons.add, size: 18.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 8.0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        clipBehavior: Clip.antiAlias,
        height: 56.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _miniBarIcon(Icons.menu, _kInk),
            _miniBarIcon(Icons.search, _kMuted),
            const SizedBox(width: 36.0),
            _miniBarIcon(Icons.bookmark_border, _kMuted),
            _miniBarIcon(Icons.person_outline, _kMuted),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 11: Cheat-sheet footer.
// ---------------------------------------------------------------------------
Widget _cheatSheetFooter() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Cheat-sheet', style: _kH1),
        const SizedBox(height: 4.0),
        Text(
          'Everything you might reach for when wiring a BottomAppBar.',
          style: _kBody,
        ),
        const SizedBox(height: 14.0),
        _chipGroup('Widgets', <String>[
          'BottomAppBar',
          'Scaffold',
          'FloatingActionButton',
          'IconButton',
          'Row',
          'Material',
        ], _kAccent, _kAccentSoft),
        const SizedBox(height: 10.0),
        _chipGroup('Shapes', <String>[
          'NotchedShape',
          'CircularNotchedRectangle',
          'AutomaticNotchedShape',
          'OutlinedBorder',
          'RoundedRectangleBorder',
          'StadiumBorder',
        ], _kRose, _kRoseSoft),
        const SizedBox(height: 10.0),
        _chipGroup('Theme', <String>[
          'BottomAppBarTheme',
          'ThemeData.bottomAppBarTheme',
          'ColorScheme.surface',
          'ColorScheme.surfaceTint',
          'ColorScheme.shadow',
        ], _kViolet, _kVioletSoft),
        const SizedBox(height: 10.0),
        _chipGroup('FAB locations', <String>[
          'centerDocked',
          'endDocked',
          'startDocked',
          'miniCenterDocked',
          'miniEndDocked',
          'centerFloat',
          'endFloat',
          'custom FloatingActionButtonLocation',
        ], _kTeal, _kTealSoft),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 14.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: _kPaper,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: _kBorderSoft, width: 1.0),
          ),
          child: Row(
            children: const <Widget>[
              Icon(Icons.tips_and_updates_outlined,
                  color: _kAccent, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Tagline: BottomAppBar is the canvas, NotchedShape is the '
                  'cookie cutter, BottomAppBarTheme is the stencil, and '
                  'FloatingActionButtonLocation is where you land the FAB.',
                  style: TextStyle(
                    color: _kInk,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _chipGroup(
  String label,
  List<String> items,
  Color ink,
  Color background,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        width: 110.0,
        child: Text(
          label,
          style: TextStyle(
            color: ink,
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
      ),
      Expanded(
        child: Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            for (final String item in items)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 9.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(999.0),
                  border: Border.all(color: ink.withOpacity(0.25), width: 1.0),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    color: ink,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

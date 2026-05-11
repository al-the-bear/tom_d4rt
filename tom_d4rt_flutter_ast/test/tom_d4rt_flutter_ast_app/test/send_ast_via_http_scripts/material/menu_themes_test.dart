// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, dead_code, unnecessary_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

// ---------------------------------------------------------------------------
// Menu theming deep visual demo for the D4rt flutter test corpus.
//
// Targets: MenuThemeData / MenuTheme, MenuBarThemeData / MenuBarTheme,
// MenuButtonThemeData / MenuButtonTheme, SubmenuButtonThemeData /
// SubmenuButtonTheme, PopupMenuThemeData / PopupMenuTheme.
//
// One top-level `dynamic build(BuildContext)` returning a MaterialApp; every
// helper is private and const-friendly. No setState / Timer / Future /
// AnimationController anywhere; the document renders deterministically.
// ---------------------------------------------------------------------------

const Color _kInk = Color(0xFF0F1530);
const Color _kSubInk = Color(0xFF333D60);
const Color _kMuted = Color(0xFF6A7392);
const Color _kPaper = Color(0xFFF5F6FC);
const Color _kCard = Color(0xFFFFFFFF);
const Color _kAccent = Color(0xFF4C5BFF);
const Color _kAccentSoft = Color(0xFFE5E8FF);
const Color _kAccentInk = Color(0xFF2A36C9);
const Color _kRose = Color(0xFFE94C7E);
const Color _kRoseSoft = Color(0xFFFCE0EB);
const Color _kAmber = Color(0xFFDF9F2E);
const Color _kAmberSoft = Color(0xFFFBEFD0);
const Color _kTeal = Color(0xFF1FB4A5);
const Color _kTealSoft = Color(0xFFD6F3EE);
const Color _kViolet = Color(0xFF8C4CE0);
const Color _kVioletSoft = Color(0xFFEEE0FB);
const Color _kSlate = Color(0xFF455370);
const Color _kSlateSoft = Color(0xFFE1E6F0);
const Color _kBorder = Color(0xFFD8DCEA);
const Color _kBorderSoft = Color(0xFFE8EBF4);
const Color _kCodeBg = Color(0xFF0D1326);
const Color _kCodeInk = Color(0xFFE7ECFF);

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
  print('Menu themes deep visual demo: build()');

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
                  '1. Material menu theming overview',
                  'Five theme datas drive every menu surface in flutter/material. '
                      'They live on ThemeData and on dedicated InheritedTheme widgets. '
                      'This document walks through each, then composes them.'),
              const SizedBox(height: 14.0),
              _overviewPanel(),
              const SizedBox(height: 28.0),
              _section(
                  '2. MenuThemeData anatomy',
                  'MenuThemeData has exactly one constructor parameter: `style`, '
                      'a nullable MenuStyle. MenuStyle itself is a bag of '
                      'WidgetStateProperty<T> fields plus a couple of scalars.'),
              const SizedBox(height: 14.0),
              _anatomyTable(),
              const SizedBox(height: 28.0),
              _section(
                  '3. MenuStyle showcase',
                  'Six distinct MenuStyle configurations, each previewed alongside '
                      'a PopupMenuButton<int> that uses it as menuStyle. The render '
                      'is static; the visual chrome is reproduced by hand.'),
              const SizedBox(height: 14.0),
              _menuStyleShowcase(),
              const SizedBox(height: 28.0),
              _section(
                  '4. MenuBarThemeData + MenuBar',
                  'Wrap a tiny Theme(data: ThemeData(menuBarTheme: ...)) around a '
                      'MenuBar with three SubmenuButton entries. Below it, the '
                      'static replica shows the exact rendered chrome.'),
              const SizedBox(height: 14.0),
              _menuBarThemeShowcase(),
              const SizedBox(height: 28.0),
              _section(
                  '5. MenuButtonThemeData showcase',
                  'Wrap a Theme(data: ThemeData(menuButtonTheme: ...)) over four '
                      'MenuItemButton variants. The theme uniformly styles padding, '
                      'shape, colors and text style; per-item overrides win.'),
              const SizedBox(height: 14.0),
              _menuButtonThemeShowcase(),
              const SizedBox(height: 28.0),
              _section(
                  '6. SubmenuButton theming showcase',
                  'SubmenuButton inherits ButtonStyle from MenuButtonTheme in this '
                      'Flutter channel; later channels expose a dedicated '
                      'SubmenuButtonThemeData. Both follow the same shape: a '
                      'single nullable ButtonStyle `style` field.'),
              const SizedBox(height: 14.0),
              _submenuButtonThemeShowcase(),
              const SizedBox(height: 28.0),
              _section(
                  '7. PopupMenuThemeData showcase',
                  'PopupMenuThemeData is the legacy popup-menu surface theme: '
                      'color, shape, elevation, textStyle, labelTextStyle, '
                      'iconColor, position, mouseCursor and surfaceTintColor.'),
              const SizedBox(height: 14.0),
              _popupMenuThemeShowcase(),
              const SizedBox(height: 28.0),
              _section(
                  '8. Theme cascading flow',
                  'A CustomPainter draws the inheritance chain: ThemeData.menuBarTheme '
                      'flows into MenuBarTheme.of(context), which the MenuBar widget '
                      'reads at build time. Same pattern for the four siblings.'),
              const SizedBox(height: 14.0),
              _cascadingFlow(),
              const SizedBox(height: 28.0),
              _section(
                  '9. Comparison table',
                  'MenuTheme vs MenuBarTheme vs MenuButtonTheme vs SubmenuButtonTheme '
                      'vs PopupMenuTheme. Each row: theme name, scope, who reads it, '
                      'underlying data type, and a remark on idiomatic use.'),
              const SizedBox(height: 14.0),
              _comparisonTable(),
              const SizedBox(height: 28.0),
              _section(
                  '10. Pitfalls',
                  'Six callouts on subtle behaviour: WidgetStateProperty wrapping, '
                      'DropdownButtonFormField nesting, Theme.of vs MenuTheme.of, '
                      'zero padding side effects, override precedence, dispose.'),
              const SizedBox(height: 14.0),
              _pitfallsGrid(),
              const SizedBox(height: 28.0),
              _section(
                  '11. Cheat-sheet',
                  'Chip groups: theme data types, widget consumers, MenuStyle fields, '
                      'WidgetStateProperty constructors. Tagline at the bottom.'),
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

  print('Menu themes deep visual demo: build() done');
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
    menuTheme: const MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(_kCard),
        elevation: WidgetStatePropertyAll<double>(6.0),
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(vertical: 6.0),
        ),
      ),
    ),
    menuBarTheme: const MenuBarThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(_kCard),
        elevation: WidgetStatePropertyAll<double>(0.0),
        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 6.0),
        ),
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            side: BorderSide(color: _kBorder),
          ),
        ),
      ),
    ),
    menuButtonTheme: const MenuButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Colors.transparent),
        foregroundColor: WidgetStatePropertyAll<Color>(_kInk),
        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        ),
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        textStyle: WidgetStatePropertyAll<TextStyle>(
          TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
        ),
      ),
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: _kCard,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      textStyle: TextStyle(fontSize: 13.0, color: _kInk),
    ),
  );
}

// ---------------------------------------------------------------------------
// Hero / intro panel.
// ---------------------------------------------------------------------------
Widget _hero() {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF161F4B), Color(0xFF3548B8)],
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
            _heroBadge('MenuTheme'),
            const SizedBox(width: 8.0),
            _heroBadge('MenuBarTheme'),
            const SizedBox(width: 8.0),
            _heroBadge('PopupMenuTheme'),
            const Spacer(),
            const Icon(Icons.menu_open_rounded,
                color: Colors.white70, size: 22.0),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Theming the menu surface stack',
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
          'Flutter ships five menu-related theme data types. Three drive the '
          'modern Menu*Button family (MenuTheme, MenuBarTheme, MenuButtonTheme, '
          'SubmenuButtonTheme); PopupMenuTheme drives the legacy PopupMenuButton. '
          'Each is read once at the point of widget construction; styles compose '
          'via WidgetStateProperty<T> resolvers.',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFFD6DAFB),
            height: 1.55,
          ),
        ),
        const SizedBox(height: 18.0),
        Row(
          children: <Widget>[
            _heroStat('Theme data types', '5'),
            const SizedBox(width: 14.0),
            _heroStat('Inherited widgets', '5'),
            const SizedBox(width: 14.0),
            _heroStat('MenuStyle fields', '9+'),
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
// Section heading.
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
            'D4rt flutter test corpus  -  menu theming deep visual demo  -  hand-authored, analyzer-clean',
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

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    decoration: const BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    child: Text(code, style: _kMono),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Overview panel.
// ---------------------------------------------------------------------------
Widget _overviewPanel() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Five theme datas, one mental model', style: _kH3),
        const SizedBox(height: 6.0),
        const Text(
          'Each theme data is a small descriptor that ends up on ThemeData. '
          'The corresponding InheritedTheme widget exists for ad-hoc, scoped '
          'overrides without rebuilding the whole ThemeData. Widgets read the '
          'nearest available data using <ThemeName>.of(context).',
          style: _kBody,
        ),
        const SizedBox(height: 14.0),
        _overviewRow(
          'MenuTheme',
          'MenuThemeData',
          'Wraps menus opened from MenuAnchor, SubmenuButton, MenuBar.',
          _kAccent,
          _kAccentSoft,
        ),
        const SizedBox(height: 8.0),
        _overviewRow(
          'MenuBarTheme',
          'MenuBarThemeData',
          'Styles the MenuBar container itself (the strip, not the popups).',
          _kAmber,
          _kAmberSoft,
        ),
        const SizedBox(height: 8.0),
        _overviewRow(
          'MenuButtonTheme',
          'MenuButtonThemeData',
          'Styles MenuItemButton instances inside a menu.',
          _kViolet,
          _kVioletSoft,
        ),
        const SizedBox(height: 8.0),
        _overviewRow(
          'SubmenuButtonTheme',
          'SubmenuButtonThemeData',
          'Styles SubmenuButton (the row that opens a child menu).',
          _kTeal,
          _kTealSoft,
        ),
        const SizedBox(height: 8.0),
        _overviewRow(
          'PopupMenuTheme',
          'PopupMenuThemeData',
          'Legacy PopupMenuButton + PopupMenuItem surface theme.',
          _kRose,
          _kRoseSoft,
        ),
      ],
    ),
  );
}

Widget _overviewRow(String widget, String data, String scope, Color accent,
    Color accentSoft) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: _kPaper,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      border: Border.all(color: _kBorderSoft, width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: accentSoft,
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          ),
          child: Text(
            widget,
            style: TextStyle(
              fontSize: 11.5,
              color: accent,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        SizedBox(
          width: 200.0,
          child: Text(
            data,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: _kInk,
            ),
          ),
        ),
        Expanded(child: Text(scope, style: _kBody)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2: Anatomy table.
// ---------------------------------------------------------------------------
Widget _anatomyTable() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('MenuThemeData constructor', style: _kH3),
        const SizedBox(height: 6.0),
        _codeBlock(
          'const MenuThemeData({\n'
          '  this.style,  // MenuStyle?  -- default null\n'
          '});',
        ),
        const SizedBox(height: 14.0),
        const Text('MenuStyle constructor fields', style: _kH3),
        const SizedBox(height: 6.0),
        _anatomyHeader(),
        const SizedBox(height: 6.0),
        _anatomyRow('backgroundColor', 'WidgetStateProperty<Color?>?',
            'Surface fill of the menu container.'),
        _anatomyRow('shadowColor', 'WidgetStateProperty<Color?>?',
            'Color of the menu drop shadow.'),
        _anatomyRow('surfaceTintColor', 'WidgetStateProperty<Color?>?',
            'M3 elevation tint applied on top of background.'),
        _anatomyRow('elevation', 'WidgetStateProperty<double?>?',
            'Drop-shadow z-axis depth.'),
        _anatomyRow('padding', 'WidgetStateProperty<EdgeInsetsGeometry?>?',
            'Inset between menu border and its children list.'),
        _anatomyRow('minimumSize', 'WidgetStateProperty<Size?>?',
            'Lower bound for the menu surface size.'),
        _anatomyRow('fixedSize', 'WidgetStateProperty<Size?>?',
            'Locks both axes; null axis means unconstrained.'),
        _anatomyRow('maximumSize', 'WidgetStateProperty<Size?>?',
            'Upper bound; menu scrolls if children exceed it.'),
        _anatomyRow('side', 'WidgetStateProperty<BorderSide?>?',
            'Border drawn around the menu surface.'),
        _anatomyRow('shape', 'WidgetStateProperty<OutlinedBorder?>?',
            'Outline shape, usually RoundedRectangleBorder.'),
        _anatomyRow('mouseCursor', 'WidgetStateProperty<MouseCursor?>?',
            'Cursor when hovering the menu container.'),
        _anatomyRow('visualDensity', 'VisualDensity?',
            'Scalar density (NOT a WidgetStateProperty).'),
        _anatomyRow('alignment', 'AlignmentGeometry?',
            'How the menu aligns to its anchor (NOT a WidgetStateProperty).'),
        const SizedBox(height: 12.0),
        const Text(
          'Note: MenuBarThemeData and SubmenuButtonThemeData both have only a '
          '`style` field; SubmenuButtonThemeData uses ButtonStyle, while '
          'MenuBarThemeData uses MenuStyle. MenuButtonThemeData uses ButtonStyle.',
          style: _kBodyMuted,
        ),
      ],
    ),
  );
}

Widget _anatomyHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: _kSlateSoft.withOpacity(0.6),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    ),
    child: Row(
      children: const <Widget>[
        SizedBox(width: 160.0, child: Text('field', style: _kLabel)),
        SizedBox(width: 260.0, child: Text('type', style: _kLabel)),
        Expanded(child: Text('purpose', style: _kLabel)),
      ],
    ),
  );
}

Widget _anatomyRow(String field, String type, String purpose) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: _kBorderSoft, width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 160.0,
            child: Text(
              field,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: _kInk,
              ),
            ),
          ),
          SizedBox(
            width: 260.0,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: _kSubInk,
              ),
            ),
          ),
          Expanded(child: Text(purpose, style: _kBody)),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3: MenuStyle showcase.
// ---------------------------------------------------------------------------
Widget _menuStyleShowcase() {
  final List<_StyleSpec> specs = _menuStyleSpecs();
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Six MenuStyle configurations', style: _kH3),
        const SizedBox(height: 6.0),
        const Text(
          'Each card shows the MenuStyle code, then a PopupMenuButton<int> as '
          'a real trigger, then a static replica of how the menu surface looks '
          'when opened. The replica reproduces background, padding, shape, side, '
          'minimumSize and maximumSize.',
          style: _kBody,
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final _StyleSpec spec in specs) _styleCard(spec),
          ],
        ),
      ],
    ),
  );
}

class _StyleSpec {
  const _StyleSpec({
    required this.name,
    required this.code,
    required this.bg,
    required this.elevation,
    required this.padding,
    required this.minSize,
    required this.maxSize,
    required this.borderRadius,
    required this.side,
    required this.density,
    required this.alignment,
    required this.accent,
    required this.accentSoft,
    required this.items,
  });

  final String name;
  final String code;
  final Color bg;
  final double elevation;
  final EdgeInsets padding;
  final Size minSize;
  final Size maxSize;
  final double borderRadius;
  final BorderSide side;
  final VisualDensity density;
  final Alignment alignment;
  final Color accent;
  final Color accentSoft;
  final List<String> items;
}

List<_StyleSpec> _menuStyleSpecs() {
  return <_StyleSpec>[
    const _StyleSpec(
      name: 'classic',
      code: 'MenuStyle(\n'
          '  backgroundColor: WidgetStatePropertyAll(white),\n'
          '  elevation: WidgetStatePropertyAll(6),\n'
          '  padding: WidgetStatePropertyAll(\n'
          '    EdgeInsets.symmetric(vertical: 6)),\n'
          '  minimumSize: WidgetStatePropertyAll(Size(160, 48)),\n'
          '  maximumSize: WidgetStatePropertyAll(Size(320, 600)),\n'
          '  shape: WidgetStatePropertyAll(\n'
          '    RoundedRectangleBorder(radius: 10)),\n'
          '  side: WidgetStatePropertyAll(BorderSide.none),\n'
          '  visualDensity: VisualDensity.standard,\n'
          '  alignment: Alignment.topLeft,\n'
          ');',
      bg: _kCard,
      elevation: 6.0,
      padding: EdgeInsets.symmetric(vertical: 6.0),
      minSize: Size(180.0, 48.0),
      maxSize: Size(320.0, 600.0),
      borderRadius: 10.0,
      side: BorderSide.none,
      density: VisualDensity.standard,
      alignment: Alignment.topLeft,
      accent: _kAccent,
      accentSoft: _kAccentSoft,
      items: <String>['Edit', 'Duplicate', 'Delete'],
    ),
    const _StyleSpec(
      name: 'tinted',
      code: 'MenuStyle(\n'
          '  backgroundColor: WidgetStatePropertyAll(roseSoft),\n'
          '  elevation: WidgetStatePropertyAll(2),\n'
          '  padding: WidgetStatePropertyAll(\n'
          '    EdgeInsets.symmetric(vertical: 4)),\n'
          '  shape: WidgetStatePropertyAll(\n'
          '    RoundedRectangleBorder(radius: 14,\n'
          '      side: BorderSide(color: rose, width: 1.2))),\n'
          '  side: WidgetStatePropertyAll(\n'
          '    BorderSide(color: rose, width: 1.2)),\n'
          ');',
      bg: _kRoseSoft,
      elevation: 2.0,
      padding: EdgeInsets.symmetric(vertical: 4.0),
      minSize: Size(180.0, 40.0),
      maxSize: Size(320.0, 480.0),
      borderRadius: 14.0,
      side: BorderSide(color: _kRose, width: 1.2),
      density: VisualDensity.standard,
      alignment: Alignment.topLeft,
      accent: _kRose,
      accentSoft: _kRoseSoft,
      items: <String>['Highlight', 'Annotate', 'Quote'],
    ),
    const _StyleSpec(
      name: 'compact',
      code: 'MenuStyle(\n'
          '  backgroundColor: WidgetStatePropertyAll(white),\n'
          '  elevation: WidgetStatePropertyAll(4),\n'
          '  padding: WidgetStatePropertyAll(EdgeInsets.zero),\n'
          '  minimumSize: WidgetStatePropertyAll(Size(120, 32)),\n'
          '  maximumSize: WidgetStatePropertyAll(Size(220, 400)),\n'
          '  shape: WidgetStatePropertyAll(\n'
          '    RoundedRectangleBorder(radius: 6)),\n'
          '  visualDensity: VisualDensity.compact,\n'
          ');',
      bg: _kCard,
      elevation: 4.0,
      padding: EdgeInsets.zero,
      minSize: Size(150.0, 32.0),
      maxSize: Size(220.0, 400.0),
      borderRadius: 6.0,
      side: BorderSide(color: _kBorderSoft),
      density: VisualDensity.compact,
      alignment: Alignment.topLeft,
      accent: _kSlate,
      accentSoft: _kSlateSoft,
      items: <String>['Cut', 'Copy', 'Paste'],
    ),
    const _StyleSpec(
      name: 'large',
      code: 'MenuStyle(\n'
          '  backgroundColor: WidgetStatePropertyAll(white),\n'
          '  elevation: WidgetStatePropertyAll(10),\n'
          '  padding: WidgetStatePropertyAll(\n'
          '    EdgeInsets.symmetric(vertical: 12)),\n'
          '  minimumSize: WidgetStatePropertyAll(Size(280, 64)),\n'
          '  maximumSize: WidgetStatePropertyAll(Size(420, 720)),\n'
          '  shape: WidgetStatePropertyAll(\n'
          '    RoundedRectangleBorder(radius: 16)),\n'
          '  alignment: Alignment.centerLeft,\n'
          ');',
      bg: _kCard,
      elevation: 10.0,
      padding: EdgeInsets.symmetric(vertical: 12.0),
      minSize: Size(280.0, 64.0),
      maxSize: Size(420.0, 720.0),
      borderRadius: 16.0,
      side: BorderSide.none,
      density: VisualDensity.standard,
      alignment: Alignment.centerLeft,
      accent: _kViolet,
      accentSoft: _kVioletSoft,
      items: <String>['Project', 'Document', 'Collection', 'Workspace'],
    ),
    const _StyleSpec(
      name: 'outlined',
      code: 'MenuStyle(\n'
          '  backgroundColor: WidgetStatePropertyAll(white),\n'
          '  elevation: WidgetStatePropertyAll(0),\n'
          '  padding: WidgetStatePropertyAll(\n'
          '    EdgeInsets.symmetric(vertical: 4)),\n'
          '  side: WidgetStatePropertyAll(\n'
          '    BorderSide(color: teal, width: 1.5)),\n'
          '  shape: WidgetStatePropertyAll(\n'
          '    RoundedRectangleBorder(radius: 12,\n'
          '      side: BorderSide(color: teal, width: 1.5))),\n'
          ');',
      bg: _kCard,
      elevation: 0.0,
      padding: EdgeInsets.symmetric(vertical: 4.0),
      minSize: Size(180.0, 40.0),
      maxSize: Size(280.0, 480.0),
      borderRadius: 12.0,
      side: BorderSide(color: _kTeal, width: 1.5),
      density: VisualDensity.standard,
      alignment: Alignment.topLeft,
      accent: _kTeal,
      accentSoft: _kTealSoft,
      items: <String>['Sync', 'Refresh', 'Reload'],
    ),
    const _StyleSpec(
      name: 'dense-pill',
      code: 'MenuStyle(\n'
          '  backgroundColor: WidgetStatePropertyAll(amberSoft),\n'
          '  elevation: WidgetStatePropertyAll(3),\n'
          '  padding: WidgetStatePropertyAll(\n'
          '    EdgeInsets.symmetric(horizontal: 4, vertical: 4)),\n'
          '  minimumSize: WidgetStatePropertyAll(Size(140, 36)),\n'
          '  maximumSize: WidgetStatePropertyAll(Size(240, 400)),\n'
          '  shape: WidgetStatePropertyAll(StadiumBorder()),\n'
          '  visualDensity: VisualDensity.compact,\n'
          ');',
      bg: _kAmberSoft,
      elevation: 3.0,
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      minSize: Size(140.0, 36.0),
      maxSize: Size(240.0, 400.0),
      borderRadius: 999.0,
      side: BorderSide(color: _kAmber),
      density: VisualDensity.compact,
      alignment: Alignment.topLeft,
      accent: _kAmber,
      accentSoft: _kAmberSoft,
      items: <String>['Apply', 'Reset'],
    ),
  ];
}

Widget _styleCard(_StyleSpec spec) {
  return SizedBox(
    width: 360.0,
    child: Container(
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: spec.accentSoft,
                  borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                ),
                child: Text(
                  spec.name,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w800,
                    color: spec.accent,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'elev ${spec.elevation.toStringAsFixed(0)}',
                style: _kBodyMuted,
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          _codeBlock(spec.code),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              PopupMenuButton<int>(
                tooltip: spec.name,
                onSelected: (int _) {},
                itemBuilder: (BuildContext _) => <PopupMenuEntry<int>>[
                  for (int i = 0; i < spec.items.length; i++)
                    PopupMenuItem<int>(
                      value: i,
                      child: Text(spec.items[i],
                          style: const TextStyle(fontSize: 13.0)),
                    ),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: spec.accent,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Icons.expand_more_rounded,
                          color: Colors.white, size: 16.0),
                      const SizedBox(width: 4.0),
                      Text(
                        spec.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(child: _styledMenuPreview(spec)),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _styledMenuPreview(_StyleSpec spec) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      minWidth: spec.minSize.width.clamp(80.0, 260.0),
      maxWidth: spec.maxSize.width.clamp(120.0, 260.0),
      minHeight: spec.minSize.height,
    ),
    child: Container(
      padding: spec.padding,
      decoration: BoxDecoration(
        color: spec.bg,
        borderRadius: BorderRadius.all(Radius.circular(spec.borderRadius)),
        border: Border.all(
          color: spec.side.color == const Color(0x00000000)
              ? _kBorder
              : spec.side.color,
          width: math.max(spec.side.width, 1.0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0x14101426),
            blurRadius: 4.0 + spec.elevation * 1.5,
            offset: Offset(0.0, 2.0 + spec.elevation * 0.6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final String item in spec.items)
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 6.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 6.0,
                    decoration: BoxDecoration(
                      color: spec.accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 12.5, color: _kInk),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4: MenuBarThemeData + MenuBar.
// ---------------------------------------------------------------------------
Widget _menuBarThemeShowcase() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Live MenuBar under MenuBarThemeData', style: _kH3),
        const SizedBox(height: 6.0),
        const Text(
          'A nested Theme provides menuBarTheme; the MenuBar inside reads it. '
          'Three SubmenuButton entries are wired but the popups remain closed '
          'so the render stays deterministic for tests.',
          style: _kBody,
        ),
        const SizedBox(height: 14.0),
        Theme(
          data: ThemeData(
            useMaterial3: true,
            menuBarTheme: const MenuBarThemeData(
              style: MenuStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(_kCard),
                elevation: WidgetStatePropertyAll<double>(0.0),
                padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 6.0),
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    side: BorderSide(color: _kBorder),
                  ),
                ),
                minimumSize: WidgetStatePropertyAll<Size>(Size(0.0, 44.0)),
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: _kPaper,
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              border: Border.all(color: _kBorderSoft, width: 1.0),
            ),
            child: SizedBox(
              height: 44.0,
              child: MenuBar(
                children: <Widget>[
                  SubmenuButton(
                    menuChildren: <Widget>[
                      MenuItemButton(
                        onPressed: () {},
                        leadingIcon:
                            const Icon(Icons.note_add_rounded, size: 16.0),
                        shortcut: const SingleActivator(
                            LogicalKeyboardKey.keyN,
                            control: true),
                        child: const Text('New'),
                      ),
                      MenuItemButton(
                        onPressed: () {},
                        leadingIcon:
                            const Icon(Icons.save_rounded, size: 16.0),
                        shortcut: const SingleActivator(
                            LogicalKeyboardKey.keyS,
                            control: true),
                        child: const Text('Save'),
                      ),
                    ],
                    child: const Text('File'),
                  ),
                  SubmenuButton(
                    menuChildren: <Widget>[
                      MenuItemButton(
                        onPressed: () {},
                        leadingIcon: const Icon(Icons.undo_rounded, size: 16.0),
                        child: const Text('Undo'),
                      ),
                      MenuItemButton(
                        onPressed: () {},
                        leadingIcon: const Icon(Icons.redo_rounded, size: 16.0),
                        child: const Text('Redo'),
                      ),
                    ],
                    child: const Text('Edit'),
                  ),
                  SubmenuButton(
                    menuChildren: <Widget>[
                      MenuItemButton(
                        onPressed: () {},
                        leadingIcon: const Icon(Icons.help_rounded, size: 16.0),
                        child: const Text('About'),
                      ),
                    ],
                    child: const Text('Help'),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        _codeBlock(
          'Theme(\n'
          '  data: ThemeData(menuBarTheme: MenuBarThemeData(\n'
          '    style: MenuStyle(\n'
          '      backgroundColor: WidgetStatePropertyAll(white),\n'
          '      elevation: WidgetStatePropertyAll(0),\n'
          '      shape: WidgetStatePropertyAll(\n'
          '        RoundedRectangleBorder(radius: 10,\n'
          '          side: BorderSide(color: border))),\n'
          '    ),\n'
          '  )),\n'
          '  child: MenuBar(children: <Widget>[ ... ]),\n'
          ');',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5: MenuButtonThemeData showcase.
// ---------------------------------------------------------------------------
Widget _menuButtonThemeShowcase() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Four MenuItemButton variants under one theme',
            style: _kH3),
        const SizedBox(height: 6.0),
        const Text(
          'menuButtonTheme provides a ButtonStyle that applies to every '
          'MenuItemButton in scope. Each row below is a real MenuItemButton; '
          'they share padding, shape and text style.',
          style: _kBody,
        ),
        const SizedBox(height: 14.0),
        Theme(
          data: ThemeData(
            useMaterial3: true,
            menuButtonTheme: const MenuButtonThemeData(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll<Color>(Colors.transparent),
                foregroundColor: WidgetStatePropertyAll<Color>(_kInk),
                padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                ),
                textStyle: WidgetStatePropertyAll<TextStyle>(
                  TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                minimumSize: WidgetStatePropertyAll<Size>(Size(260.0, 40.0)),
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: _kPaper,
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              border: Border.all(color: _kBorderSoft, width: 1.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MenuItemButton(
                  onPressed: () {},
                  leadingIcon: const Icon(Icons.edit_rounded, size: 16.0),
                  trailingIcon: const Text('Ctrl+E',
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          color: _kMuted)),
                  child: const Text('Edit selection'),
                ),
                MenuItemButton(
                  onPressed: () {},
                  leadingIcon: const Icon(Icons.copy_rounded, size: 16.0),
                  trailingIcon: const Text('Ctrl+C',
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          color: _kMuted)),
                  child: const Text('Copy selection'),
                ),
                MenuItemButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll<Color>(_kRose),
                  ),
                  leadingIcon: const Icon(Icons.delete_rounded,
                      size: 16.0, color: _kRose),
                  child: const Text('Delete selection'),
                ),
                MenuItemButton(
                  onPressed: null, // disabled
                  leadingIcon: const Icon(Icons.lock_rounded,
                      size: 16.0, color: _kMuted),
                  child: const Text('Archive (locked)',
                      style: TextStyle(color: _kMuted)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        _codeBlock(
          'Theme(\n'
          '  data: ThemeData(menuButtonTheme: MenuButtonThemeData(\n'
          '    style: ButtonStyle(\n'
          '      padding: WidgetStatePropertyAll(\n'
          '        EdgeInsets.symmetric(h: 14, v: 10)),\n'
          '      textStyle: WidgetStatePropertyAll(\n'
          '        TextStyle(fontSize: 13.5, w600)),\n'
          '      shape: WidgetStatePropertyAll(\n'
          '        RoundedRectangleBorder(radius: 8)),\n'
          '    ),\n'
          '  )),\n'
          '  child: Column(children: <Widget>[ MenuItemButton(...) ]),\n'
          ');',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6: SubmenuButtonThemeData showcase.
// ---------------------------------------------------------------------------
Widget _submenuButtonThemeShowcase() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('SubmenuButton + expanded preview', style: _kH3),
        const SizedBox(height: 6.0),
        const Text(
          'menuButtonTheme styles SubmenuButton (the row that opens a child '
          'menu) in this Flutter channel. The actual menuChildren popup is '
          'rendered by the framework via MenuTheme; this preview reproduces '
          'it statically.',
          style: _kBody,
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Theme(
                data: ThemeData(
                  useMaterial3: true,
                  menuButtonTheme: const MenuButtonThemeData(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll<Color>(_kViolet),
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          _kVioletSoft),
                      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                      ),
                      shape: WidgetStatePropertyAll<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: _kPaper,
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    border: Border.all(color: _kBorderSoft, width: 1.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SubmenuButton(
                        leadingIcon: const Icon(Icons.share_rounded, size: 16.0),
                        menuChildren: <Widget>[
                          MenuItemButton(
                            onPressed: () {},
                            child: const Text('Email link'),
                          ),
                          MenuItemButton(
                            onPressed: () {},
                            child: const Text('Copy link'),
                          ),
                          MenuItemButton(
                            onPressed: () {},
                            child: const Text('Embed code'),
                          ),
                        ],
                        child: const Text('Share with'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(child: _submenuExpandedPreview()),
          ],
        ),
        const SizedBox(height: 14.0),
        _codeBlock(
          'Theme(\n'
          '  data: ThemeData(menuButtonTheme: MenuButtonThemeData(\n'
          '    style: ButtonStyle(\n'
          '      foregroundColor: WidgetStatePropertyAll(violet),\n'
          '      backgroundColor: WidgetStatePropertyAll(violetSoft),\n'
          '      padding: WidgetStatePropertyAll(\n'
          '        EdgeInsets.symmetric(h: 14, v: 10)),\n'
          '    ),\n'
          '  )),\n'
          '  child: SubmenuButton(\n'
          '    menuChildren: <Widget>[ MenuItemButton(...) ],\n'
          '    child: Text("Share with"),\n'
          '  ),\n'
          ');',
        ),
      ],
    ),
  );
}

Widget _submenuExpandedPreview() {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      border: Border.all(color: _kBorder, width: 1.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x1A101426),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _submenuPreviewRow(Icons.share_rounded, 'Share with',
            isParent: true),
        const Divider(color: _kBorderSoft, height: 1.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _submenuPreviewRow(Icons.email_rounded, 'Email link'),
              _submenuPreviewRow(Icons.link_rounded, 'Copy link'),
              _submenuPreviewRow(Icons.code_rounded, 'Embed code'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _submenuPreviewRow(IconData icon, String label,
    {bool isParent = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    child: Row(
      children: <Widget>[
        Icon(icon, size: 14.0, color: isParent ? _kViolet : _kSubInk),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              color: _kInk,
              fontWeight: isParent ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
        if (isParent)
          const Icon(Icons.chevron_right_rounded,
              size: 14.0, color: _kMuted),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7: PopupMenuThemeData showcase.
// ---------------------------------------------------------------------------
Widget _popupMenuThemeShowcase() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('PopupMenuButton<int> under PopupMenuTheme', style: _kH3),
        const SizedBox(height: 6.0),
        const Text(
          'PopupMenuThemeData drives color, shape, elevation, textStyle, '
          'labelTextStyle, iconColor, position and mouseCursor for the legacy '
          'popup-menu surface. The PopupMenuButton<int> below uses five '
          'PopupMenuItem<int> children.',
          style: _kBody,
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Theme(
                data: ThemeData(
                  useMaterial3: true,
                  popupMenuTheme: const PopupMenuThemeData(
                    color: _kCard,
                    elevation: 8.0,
                    surfaceTintColor: _kAccentSoft,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      side: BorderSide(color: _kAccent, width: 1.0),
                    ),
                    textStyle: TextStyle(
                        fontSize: 13.0,
                        color: _kInk,
                        fontWeight: FontWeight.w600),
                    labelTextStyle: WidgetStatePropertyAll<TextStyle>(
                      TextStyle(
                          fontSize: 13.0,
                          color: _kInk,
                          fontWeight: FontWeight.w600),
                    ),
                    iconColor: _kAccent,
                    position: PopupMenuPosition.under,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: _kPaper,
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    border: Border.all(color: _kBorderSoft, width: 1.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      PopupMenuButton<int>(
                        tooltip: 'Themed popup',
                        onSelected: (int _) {},
                        itemBuilder: (BuildContext _) =>
                            <PopupMenuEntry<int>>[
                          const PopupMenuItem<int>(
                              value: 1, child: Text('Rename')),
                          const PopupMenuItem<int>(
                              value: 2, child: Text('Move to...')),
                          const PopupMenuItem<int>(
                              value: 3, child: Text('Pin')),
                          const PopupMenuItem<int>(
                              value: 4, child: Text('Archive')),
                          const PopupMenuItem<int>(
                              value: 5, child: Text('Delete')),
                        ],
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: _kAccent,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(8.0)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.more_vert_rounded,
                                  color: Colors.white, size: 16.0),
                              SizedBox(width: 6.0),
                              Text(
                                'Open',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      const Text('PopupMenuButton<int>', style: _kBody),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(child: _popupExpandedPreview()),
          ],
        ),
        const SizedBox(height: 14.0),
        _codeBlock(
          'Theme(\n'
          '  data: ThemeData(popupMenuTheme: PopupMenuThemeData(\n'
          '    color: white,\n'
          '    elevation: 8,\n'
          '    surfaceTintColor: accentSoft,\n'
          '    shape: RoundedRectangleBorder(radius: 14,\n'
          '      side: BorderSide(color: accent)),\n'
          '    textStyle: TextStyle(fontSize: 13, w600),\n'
          '    labelTextStyle: WidgetStatePropertyAll(...),\n'
          '    iconColor: accent,\n'
          '    position: PopupMenuPosition.under,\n'
          '  )),\n'
          '  child: PopupMenuButton<int>(itemBuilder: (_) => [...]),\n'
          ');',
        ),
      ],
    ),
  );
}

Widget _popupExpandedPreview() {
  return Container(
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: const BorderRadius.all(Radius.circular(14.0)),
      border: Border.all(color: _kAccent, width: 1.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x1A101426),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (final String entry in const <String>[
          'Rename',
          'Move to...',
          'Pin',
          'Archive',
          'Delete',
        ])
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 14.0, vertical: 7.0),
            child: Row(
              children: <Widget>[
                const Icon(Icons.circle, size: 6.0, color: _kAccent),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    entry,
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: _kInk,
                      fontWeight: FontWeight.w600,
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

// ---------------------------------------------------------------------------
// Section 8: Theme cascading flow.
// ---------------------------------------------------------------------------
Widget _cascadingFlow() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Inheritance chain (CustomPainter)', style: _kH3),
        const SizedBox(height: 6.0),
        const Text(
          'ThemeData.menuBarTheme is the root source. MenuBarTheme InheritedTheme '
          'sits between the Theme widget and the MenuBar. When MenuBar.build '
          'runs, MenuBarTheme.of(context) walks up and returns the nearest data; '
          'the diagram below draws that exact chain.',
          style: _kBody,
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 280.0,
          child: CustomPaint(
            painter: _CascadePainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 12.0),
        _codeBlock(
          'MaterialApp(\n'
          '  theme: ThemeData(menuBarTheme: MenuBarThemeData(style: ...)),\n'
          '  home: MenuBarTheme(\n'
          '    data: MenuBarThemeData(...),  // optional local override\n'
          '    child: MenuBar(children: <Widget>[ ... ]),\n'
          '  ),\n'
          ');',
        ),
      ],
    ),
  );
}

class _CascadePainter extends CustomPainter {
  const _CascadePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _kPaper;
    final RRect outer = RRect.fromRectAndRadius(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      const Radius.circular(12.0),
    );
    canvas.drawRRect(outer, bg);

    final List<_Node> nodes = <_Node>[
      _Node('ThemeData', '.menuBarTheme = MenuBarThemeData(style)', _kAccent,
          _kAccentSoft),
      _Node('Theme', 'InheritedWidget over the subtree', _kViolet,
          _kVioletSoft),
      _Node('MenuBarTheme', 'InheritedTheme of MenuBarThemeData', _kAmber,
          _kAmberSoft),
      _Node('MenuBar', 'reads MenuBarTheme.of(context)', _kTeal, _kTealSoft),
      _Node('SubmenuButton', 'reads MenuTheme.of(context) for popup',
          _kRose, _kRoseSoft),
    ];

    const double pad = 18.0;
    final double w = (size.width - 2 * pad) / nodes.length;

    final TextPainter tp = TextPainter(textDirection: TextDirection.ltr);
    for (int i = 0; i < nodes.length; i++) {
      final _Node n = nodes[i];
      final Rect r = Rect.fromLTWH(
          pad + i * w + 6.0, 28.0, w - 12.0, size.height - 90.0);
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(10.0));
      canvas.drawRRect(rr, Paint()..color = n.soft);
      canvas.drawRRect(
        rr,
        Paint()
          ..color = n.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );

      // Index circle
      final Offset cIdx = Offset(r.left + 16.0, r.top + 18.0);
      canvas.drawCircle(cIdx, 11.0, Paint()..color = n.color);
      tp.text = TextSpan(
        text: '${i + 1}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.0,
          fontWeight: FontWeight.w800,
        ),
      );
      tp.layout();
      tp.paint(canvas,
          cIdx.translate(-tp.width / 2.0, -tp.height / 2.0));

      // Title
      tp.text = TextSpan(
        text: n.title,
        style: TextStyle(
          color: n.color,
          fontSize: 13.0,
          fontWeight: FontWeight.w800,
        ),
      );
      tp.layout(maxWidth: r.width - 16.0);
      tp.paint(canvas, Offset(r.left + 34.0, r.top + 10.0));

      // Description
      tp.text = TextSpan(
        text: n.desc,
        style: const TextStyle(
          color: _kSubInk,
          fontSize: 11.0,
          height: 1.3,
        ),
      );
      tp.layout(maxWidth: r.width - 20.0);
      tp.paint(canvas, Offset(r.left + 10.0, r.top + 46.0));

      // Arrow to next node.
      if (i < nodes.length - 1) {
        final Offset start =
            Offset(r.right - 4.0, r.top + r.height / 2.0);
        final Offset end =
            Offset(r.right + 8.0, r.top + r.height / 2.0);
        final Paint arrow = Paint()
          ..color = _kMuted
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke;
        canvas.drawLine(start, end, arrow);
        final Path head = Path()
          ..moveTo(end.dx, end.dy)
          ..lineTo(end.dx - 5.0, end.dy - 4.0)
          ..lineTo(end.dx - 5.0, end.dy + 4.0)
          ..close();
        canvas.drawPath(head, Paint()..color = _kMuted);
      }
    }

    // Bottom legend.
    tp.text = const TextSpan(
      text: 'lookup direction:  Theme  =>  InheritedTheme  =>  widget',
      style: TextStyle(
        color: _kMuted,
        fontSize: 11.5,
        fontFamily: 'monospace',
      ),
    );
    tp.layout(maxWidth: size.width - 36.0);
    tp.paint(canvas,
        Offset((size.width - tp.width) / 2.0, size.height - 38.0));

    // Title row.
    tp.text = const TextSpan(
      text: 'MenuBar inheritance: ThemeData -> MenuBarTheme -> MenuBar',
      style: TextStyle(
        color: _kInk,
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
      ),
    );
    tp.layout(maxWidth: size.width - 36.0);
    tp.paint(canvas, const Offset(16.0, 6.0));
  }

  @override
  bool shouldRepaint(covariant _CascadePainter oldDelegate) => false;
}

class _Node {
  const _Node(this.title, this.desc, this.color, this.soft);
  final String title;
  final String desc;
  final Color color;
  final Color soft;
}

// ---------------------------------------------------------------------------
// Section 9: Comparison table.
// ---------------------------------------------------------------------------
Widget _comparisonTable() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Five themes side by side', style: _kH3),
        const SizedBox(height: 10.0),
        _comparisonHeader(),
        const SizedBox(height: 4.0),
        _comparisonRow(
          'MenuTheme',
          'MenuThemeData',
          'MenuStyle',
          'menus opened via MenuAnchor / SubmenuButton',
          _kAccent,
          _kAccentSoft,
        ),
        _comparisonRow(
          'MenuBarTheme',
          'MenuBarThemeData',
          'MenuStyle',
          'the MenuBar container itself',
          _kAmber,
          _kAmberSoft,
        ),
        _comparisonRow(
          'MenuButtonTheme',
          'MenuButtonThemeData',
          'ButtonStyle',
          'MenuItemButton rows inside menus',
          _kViolet,
          _kVioletSoft,
        ),
        _comparisonRow(
          'SubmenuButton via MenuButtonTheme',
          'MenuButtonThemeData *',
          'ButtonStyle',
          'SubmenuButton anchor rows (dedicated theme on newer channels)',
          _kTeal,
          _kTealSoft,
        ),
        _comparisonRow(
          'PopupMenuTheme',
          'PopupMenuThemeData',
          'flat fields',
          'legacy PopupMenuButton + PopupMenuItem',
          _kRose,
          _kRoseSoft,
        ),
        const SizedBox(height: 10.0),
        const Text(
          'MenuStyle (used by MenuTheme + MenuBarTheme) treats most fields as '
          'WidgetStateProperty<T>. ButtonStyle (used by MenuButtonTheme + '
          'SubmenuButtonTheme) does too. PopupMenuThemeData is older and '
          'exposes plain scalars (Color color, ShapeBorder shape, double '
          'elevation, TextStyle textStyle, etc.).',
          style: _kBodyMuted,
        ),
      ],
    ),
  );
}

Widget _comparisonHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: _kSlateSoft.withOpacity(0.6),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    ),
    child: Row(
      children: const <Widget>[
        SizedBox(width: 170.0, child: Text('widget', style: _kLabel)),
        SizedBox(width: 200.0, child: Text('data type', style: _kLabel)),
        SizedBox(width: 130.0, child: Text('style shape', style: _kLabel)),
        Expanded(child: Text('scope', style: _kLabel)),
      ],
    ),
  );
}

Widget _comparisonRow(String widget, String data, String style, String scope,
    Color accent, Color accentSoft) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: _kBorderSoft, width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 170.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: accentSoft,
                borderRadius: const BorderRadius.all(Radius.circular(6.0)),
              ),
              child: Text(
                widget,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: accent,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 200.0,
            child: Text(
              data,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: _kInk,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 130.0,
            child: Text(
              style,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: _kSubInk,
              ),
            ),
          ),
          Expanded(child: Text(scope, style: _kBody)),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 10: Pitfalls grid.
// ---------------------------------------------------------------------------
Widget _pitfallsGrid() {
  return _card(
    child: Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        _pitfall(
          'Wrap scalar values in WidgetStateProperty',
          'MenuStyle.backgroundColor takes a WidgetStateProperty<Color?>?, not a '
              'Color. Use WidgetStatePropertyAll(myColor) for constant values, '
              'or WidgetStateProperty.resolveWith for state-aware ones.',
          _kAccent,
        ),
        _pitfall(
          'DropdownButtonFormField nested popups',
          'A DropdownButtonFormField opens its own popup via DropdownMenu / '
              'DropdownMenuTheme - NOT MenuTheme. Setting menuTheme on its '
              'parent has no effect on the dropdown items.',
          _kRose,
        ),
        _pitfall(
          'Theme.of vs MenuTheme.of',
          'Theme.of(context).menuTheme returns ThemeData.menuTheme (the '
              'inherited default). MenuTheme.of(context) walks for the nearest '
              'MenuTheme widget. They can disagree if a local MenuTheme is in '
              'scope; widgets read MenuTheme.of.',
          _kAmber,
        ),
        _pitfall(
          'Zero padding hides ripples',
          'Setting MenuStyle.padding to EdgeInsets.zero collapses the menu '
              'surface around its children. InkWell ripples on MenuItemButton '
              'may clip on the surface edge. Keep at least 4 px of vertical '
              'padding.',
          _kTeal,
        ),
        _pitfall(
          'MaterialApp.theme.menuTheme vs nested overrides',
          'A nested Theme(data: ThemeData(menuTheme: ...)) does NOT inherit '
              'sibling fields from the parent ThemeData; ThemeData.copyWith '
              'is the safe pattern. Use Theme.of(context).copyWith(...) to '
              'preserve everything except the override.',
          _kViolet,
        ),
        _pitfall(
          'No dispose - these themes are value objects',
          'MenuThemeData, MenuBarThemeData, MenuButtonThemeData, '
              'SubmenuButtonThemeData and PopupMenuThemeData are immutable '
              'value objects. They do not own controllers or streams, so there '
              'is nothing to dispose - just rebuild with a new instance.',
          _kSlate,
        ),
      ],
    ),
  );
}

Widget _pitfall(String title, String description, Color accent) {
  return SizedBox(
    width: 320.0,
    child: Container(
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
                width: 6.0,
                height: 18.0,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(child: Text(title, style: _kH3)),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(description, style: _kBody),
        ],
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
        const Text('Menu theming surface inventory', style: _kH3),
        const SizedBox(height: 6.0),
        const Text(
          'Chip groups by category. Use the colors as a mnemonic: blue for '
          'theme data types, violet for widget consumers, amber for MenuStyle '
          'fields, teal for WidgetStateProperty machinery.',
          style: _kBody,
        ),
        const SizedBox(height: 12.0),
        _chipGroup('Theme data types', _kAccent, _kAccentSoft, const <String>[
          'MenuThemeData',
          'MenuBarThemeData',
          'MenuButtonThemeData',
          'SubmenuButtonThemeData',
          'PopupMenuThemeData',
          'MenuStyle',
          'ButtonStyle',
        ]),
        const SizedBox(height: 10.0),
        _chipGroup('Widget consumers', _kViolet, _kVioletSoft, const <String>[
          'MenuTheme',
          'MenuBarTheme',
          'MenuButtonTheme',
          'SubmenuButtonTheme',
          'PopupMenuTheme',
          'MenuAnchor',
          'MenuBar',
          'SubmenuButton',
          'MenuItemButton',
          'PopupMenuButton<T>',
          'PopupMenuItem<T>',
          'CheckedPopupMenuItem<T>',
          'PopupMenuDivider',
        ]),
        const SizedBox(height: 10.0),
        _chipGroup('MenuStyle fields', _kAmber, _kAmberSoft, const <String>[
          'backgroundColor',
          'shadowColor',
          'surfaceTintColor',
          'elevation',
          'padding',
          'minimumSize',
          'fixedSize',
          'maximumSize',
          'side',
          'shape',
          'mouseCursor',
          'visualDensity',
          'alignment',
        ]),
        const SizedBox(height: 10.0),
        _chipGroup(
            'WidgetStateProperty', _kTeal, _kTealSoft, const <String>[
          'WidgetState',
          'WidgetStateProperty',
          'WidgetStatePropertyAll',
          'WidgetStateProperty.all',
          'WidgetStateProperty.resolveWith',
          'WidgetState.hovered',
          'WidgetState.focused',
          'WidgetState.pressed',
          'WidgetState.disabled',
          'WidgetState.selected',
        ]),
        const SizedBox(height: 10.0),
        _chipGroup('ThemeData hooks', _kRose, _kRoseSoft, const <String>[
          'ThemeData.menuTheme',
          'ThemeData.menuBarTheme',
          'ThemeData.menuButtonTheme',
          'ThemeData.submenuButtonTheme',
          'ThemeData.popupMenuTheme',
          'ThemeData.copyWith',
          'PopupMenuPosition.under',
          'PopupMenuPosition.over',
        ]),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: _kAccent.withOpacity(0.4), width: 1.0),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.menu_book_rounded,
                  color: _kAccentInk, size: 18.0),
              const SizedBox(width: 10.0),
              const Expanded(
                child: Text(
                  'tagline: one ThemeData per app, five menu themes per app, '
                  'and a WidgetStateProperty for every paint-time decision.',
                  style: TextStyle(
                    color: _kAccentInk,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
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

Widget _chipGroup(String label, Color accent, Color accentSoft,
    List<String> entries) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
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
                borderRadius: const BorderRadius.all(Radius.circular(2.0)),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
                color: accent,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final String entry in entries)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: accentSoft,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(999.0)),
                  border:
                      Border.all(color: accent.withOpacity(0.3), width: 1.0),
                ),
                child: Text(
                  entry,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: accent,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

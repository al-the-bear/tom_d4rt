// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, dead_code, unnecessary_import
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

// ---------------------------------------------------------------------------
// ButtonStyle x PopupMenu / Menu deep visual demo for the D4rt flutter test
// corpus. One top-level `dynamic build(BuildContext)` returning a Widget. All
// helpers are private const constructors and pure functions of context.
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
  print('ButtonStyle x PopupMenu deep visual demo: build()');

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
              _section('1. ButtonStyle field gallery',
                  'Ten ElevatedButton variants, each overriding a different ButtonStyle field. Hover-aware variants use WidgetStateProperty.resolveWith.'),
              const SizedBox(height: 14.0),
              _buttonStyleGallery(),
              const SizedBox(height: 28.0),
              _section('2. WidgetStateProperty resolution diagram',
                  'How resolveWith picks a value from the active state-set. Each row is a hypothetical state-set, each column a resolved property.'),
              const SizedBox(height: 14.0),
              _stateResolutionDiagram(),
              const SizedBox(height: 28.0),
              _section('3. PopupMenuButton<int> playbook',
                  'Four styled PopupMenuButton<int> instances with PopupMenuItem<int>, PopupMenuDivider and CheckedPopupMenuItem<int>.'),
              const SizedBox(height: 14.0),
              _popupMenuShowcase(),
              const SizedBox(height: 28.0),
              _section('4. MenuBar + MenuItemButton',
                  'A MenuBar with three top-level menus. menuButtonTheme drives uniform child styling; per-item ButtonStyle.styleFrom overrides accents.'),
              const SizedBox(height: 14.0),
              _menuBarShowcase(),
              const SizedBox(height: 28.0),
              _section('5. ButtonStyle.lerp + copyWith',
                  'A base ButtonStyle plus four derivations: copyWith only-shape, copyWith only-color, lerp 50/50 with the rose style, and merge with elevation override.'),
              const SizedBox(height: 14.0),
              _lerpCopyWithShowcase(),
              const SizedBox(height: 28.0),
              _section('6. WidgetStateProperty: .all vs .resolveWith vs lerp',
                  'Three code-block cards explaining the three primary constructors and how they collapse to a value at paint time.'),
              const SizedBox(height: 14.0),
              _stateConstructorsShowcase(),
              const SizedBox(height: 28.0),
              _section('7. PopupMenuTheme + MenuTheme integration',
                  'A wrapping Theme provides menuButtonTheme + popupMenuTheme. All children inherit visual identity unless overridden.'),
              const SizedBox(height: 14.0),
              _themeIntegrationShowcase(),
              const SizedBox(height: 28.0),
              _section('8. Pitfalls',
                  'Six common traps when mixing ButtonStyle with PopupMenu / Menu surfaces.'),
              const SizedBox(height: 14.0),
              _pitfallsGrid(),
              const SizedBox(height: 28.0),
              _section('9. Idiomatic code samples',
                  'Six canonical snippets you will reach for again and again.'),
              const SizedBox(height: 14.0),
              _codeIdiomsGrid(),
              const SizedBox(height: 28.0),
              _section('10. API surface cheat-sheet',
                  'Chip-tagged inventory of the relevant API symbols, grouped by capability.'),
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

  print('ButtonStyle x PopupMenu deep visual demo: build() done');
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
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(_kAccent),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        elevation: WidgetStateProperty.all(0.0),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _kAccent,
        side: const BorderSide(color: _kAccent, width: 1.2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _kAccent,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        textStyle: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _kViolet,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
    menuButtonTheme: MenuButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) return _kAccentSoft;
          if (states.contains(WidgetState.focused)) return _kAccentSoft;
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) return _kMuted;
          return _kInk;
        }),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
        ),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
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
            _heroBadge('ButtonStyle'),
            const SizedBox(width: 8.0),
            _heroBadge('PopupMenu'),
            const SizedBox(width: 8.0),
            _heroBadge('MenuBar'),
            const Spacer(),
            const Icon(Icons.bolt_rounded, color: Colors.white70, size: 22.0),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'ButtonStyle in concert with PopupMenu & Menu APIs',
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
          'A button\'s visual identity flows from ButtonStyle. Each property is a '
          'WidgetStateProperty<T> that resolves against the active material '
          'state-set. PopupMenuButton and MenuItemButton expose the same surface '
          'via their own theme objects, which means a single ButtonStyle pattern '
          'can drive triggers, menu items, and submenu chrome alike.',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFFD7DBFB),
            height: 1.55,
          ),
        ),
        const SizedBox(height: 18.0),
        Row(
          children: <Widget>[
            _heroStat('ButtonStyle fields', '20+'),
            const SizedBox(width: 14.0),
            _heroStat('WidgetState values', '8'),
            const SizedBox(width: 14.0),
            _heroStat('Menu APIs touched', '6'),
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
            'D4rt flutter test corpus  -  ButtonStyle x PopupMenu deep visual demo  -  hand-authored, analyzer-clean',
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
// Section 1: ButtonStyle field gallery.
// ---------------------------------------------------------------------------
Widget _buttonStyleGallery() {
  final List<Widget> rows = <Widget>[
    _galleryRow(<Widget>[
      _galleryCell(
        'backgroundColor',
        'Solid + state-aware',
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: _kAccent,
            foregroundColor: Colors.white,
          ),
          child: const Text('Save changes'),
        ),
        'WidgetStateProperty.all(_kAccent)',
      ),
      _galleryCell(
        'foregroundColor',
        'Resolves on text + icon',
        ElevatedButton.icon(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: _kAmberSoft,
            foregroundColor: _kAmber,
          ),
          icon: const Icon(Icons.bolt_rounded, size: 16.0),
          label: const Text('Trigger'),
        ),
        'foregroundColor: _kAmber',
      ),
      _galleryCell(
        'padding',
        'EdgeInsets shorthand',
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: _kTealSoft,
            foregroundColor: _kTeal,
            padding: const EdgeInsets.symmetric(
              horizontal: 22.0,
              vertical: 16.0,
            ),
          ),
          child: const Text('Generous'),
        ),
        'padding: symmetric(22,16)',
      ),
    ]),
    const SizedBox(height: 10.0),
    _galleryRow(<Widget>[
      _galleryCell(
        'shape',
        'StadiumBorder (rounded pill)',
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: _kViolet,
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
          ),
          child: const Text('Pill'),
        ),
        'shape: StadiumBorder()',
      ),
      _galleryCell(
        'side',
        'BorderSide on outlined',
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: _kRose,
            side: const BorderSide(color: _kRose, width: 1.5),
          ),
          child: const Text('Outlined'),
        ),
        'side: BorderSide(width: 1.5)',
      ),
      _galleryCell(
        'elevation',
        'Drop-shadow z-axis',
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: _kInk,
            elevation: 6.0,
          ),
          child: const Text('Lifted'),
        ),
        'elevation: 6.0',
      ),
    ]),
    const SizedBox(height: 10.0),
    _galleryRow(<Widget>[
      _galleryCell(
        'textStyle',
        'Weight + letterSpacing',
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: _kInk,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              fontSize: 12.0,
            ),
          ),
          child: const Text('ENGAGE'),
        ),
        'textStyle: w900, ls 1.2',
      ),
      _galleryCell(
        'animationDuration',
        'Hover-to-press lerp',
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: _kAccentSoft,
            foregroundColor: _kAccentInk,
            animationDuration: const Duration(milliseconds: 320),
          ),
          child: const Text('Tweened'),
        ),
        'duration: 320ms',
      ),
      _galleryCell(
        'iconColor',
        'Decouples from foreground',
        ElevatedButton.icon(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: _kSlate,
            iconColor: _kRose,
          ),
          icon: const Icon(Icons.favorite_rounded, size: 16.0),
          label: const Text('Like'),
        ),
        'iconColor: _kRose',
      ),
    ]),
    const SizedBox(height: 10.0),
    _galleryRow(<Widget>[
      _galleryCell(
        'fixedSize',
        'Locks exact dimensions',
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: _kTeal,
            foregroundColor: Colors.white,
            fixedSize: const Size(160.0, 44.0),
          ),
          child: const Text('160 x 44'),
        ),
        'fixedSize: Size(160, 44)',
      ),
      _galleryCell(
        'visualDensity',
        'Compact density',
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: _kSlateSoft,
            foregroundColor: _kSlate,
            visualDensity: VisualDensity.compact,
          ),
          child: const Text('Compact'),
        ),
        'visualDensity: compact',
      ),
      _galleryCell(
        'overlayColor (filled)',
        'FilledButton resolveWith',
        FilledButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(_kAccent),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.pressed)) {
                return _kAccentInk.withOpacity(0.4);
              }
              if (states.contains(WidgetState.hovered)) {
                return Colors.white.withOpacity(0.16);
              }
              return Colors.transparent;
            }),
          ),
          child: const Text('Filled'),
        ),
        'overlayColor: resolveWith',
      ),
    ]),
  ];
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    ),
  );
}

Widget _galleryRow(List<Widget> cells) {
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(child: cells[0]),
        const SizedBox(width: 10.0),
        Expanded(child: cells[1]),
        const SizedBox(width: 10.0),
        Expanded(child: cells[2]),
      ],
    ),
  );
}

Widget _galleryCell(String field, String caption, Widget demo, String code) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: _kPaper,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      border: Border.all(color: _kBorderSoft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: _kAccentSoft,
                borderRadius: const BorderRadius.all(Radius.circular(6.0)),
              ),
              child: Text(field, style: _kTag),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(caption, style: _kBodyMuted),
        const SizedBox(height: 10.0),
        Align(alignment: Alignment.centerLeft, child: demo),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: const BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          child: Text(code, style: _kMonoSmall),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 2: WidgetStateProperty resolution diagram.
// ---------------------------------------------------------------------------
Widget _stateResolutionDiagram() {
  const List<String> states = <String>[
    'normal',
    'hovered',
    'focused',
    'pressed',
    'disabled',
    'dragged',
    'selected',
    'error',
  ];

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('resolveWith<Color> example trace', style: _kH3),
        const SizedBox(height: 6.0),
        const Text(
          'For each row, the painter calls property.resolve(states). Cells show '
          'which branch of the resolver fires and the final color it returns.',
          style: _kBody,
        ),
        const SizedBox(height: 14.0),
        _resolutionHeader(),
        const SizedBox(height: 6.0),
        for (final String s in states) ...<Widget>[
          _resolutionRow(s),
          const SizedBox(height: 4.0),
        ],
        const SizedBox(height: 12.0),
        _resolutionLegend(),
      ],
    ),
  );
}

Widget _resolutionHeader() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: _kSlateSoft.withOpacity(0.6),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    ),
    child: Row(
      children: const <Widget>[
        SizedBox(
          width: 120.0,
          child: Text('state-set', style: _kLabel),
        ),
        SizedBox(
          width: 200.0,
          child: Text('branch fired', style: _kLabel),
        ),
        Expanded(child: Text('resolved value', style: _kLabel)),
      ],
    ),
  );
}

Widget _resolutionRow(String state) {
  final String branch;
  final Color swatch;
  final String hex;
  switch (state) {
    case 'pressed':
      branch = 'contains(pressed)';
      swatch = _kAccentInk;
      hex = '#2B36C9';
      break;
    case 'hovered':
      branch = 'contains(hovered)';
      swatch = _kAccent;
      hex = '#4F5BFF';
      break;
    case 'focused':
      branch = 'contains(focused)';
      swatch = _kViolet;
      hex = '#8A4CE0';
      break;
    case 'disabled':
      branch = 'contains(disabled)';
      swatch = _kMuted;
      hex = '#6E7796';
      break;
    case 'dragged':
      branch = 'contains(dragged)';
      swatch = _kRose;
      hex = '#E94C77';
      break;
    case 'selected':
      branch = 'contains(selected)';
      swatch = _kTeal;
      hex = '#1FB6A7';
      break;
    case 'error':
      branch = 'contains(error)';
      swatch = _kRose;
      hex = '#E94C77';
      break;
    default:
      branch = 'fallback (return)';
      swatch = _kAccentSoft;
      hex = '#E7E9FF';
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: _kPaper,
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      border: Border.all(color: _kBorderSoft, width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 120.0,
          child: Text(
            '{ $state }',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _kInk,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 200.0,
          child: Text(
            branch,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _kSubInk,
            ),
          ),
        ),
        Container(
          width: 18.0,
          height: 18.0,
          margin: const EdgeInsets.only(right: 8.0),
          decoration: BoxDecoration(
            color: swatch,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            border: Border.all(color: _kBorder, width: 1.0),
          ),
        ),
        Text(
          hex,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: _kInk,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _resolutionLegend() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: const BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    child: const Text(
      'WidgetStateProperty.resolveWith<Color>((states) {\n'
      '  if (states.contains(WidgetState.pressed))  return accentInk;\n'
      '  if (states.contains(WidgetState.hovered))  return accent;\n'
      '  if (states.contains(WidgetState.focused))  return violet;\n'
      '  if (states.contains(WidgetState.disabled)) return muted;\n'
      '  return accentSoft; // fallback\n'
      '});',
      style: _kMono,
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3: PopupMenuButton<int> showcase.
// ---------------------------------------------------------------------------
Widget _popupMenuShowcase() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            _popupCard(
              title: 'Trigger: ElevatedButton',
              accent: _kAccent,
              accentSoft: _kAccentSoft,
              trigger: PopupMenuButton<int>(
                tooltip: 'Open',
                onSelected: (int v) {},
                offset: const Offset(0.0, 42.0),
                itemBuilder: (BuildContext _) => _firstMenuItems(),
                child: ElevatedButton.icon(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kAccent,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: _kAccent,
                    disabledForegroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.tune_rounded, size: 16.0),
                  label: const Text('Options'),
                ),
              ),
              previewItems: _firstMenuItems(),
            ),
            _popupCard(
              title: 'Trigger: OutlinedButton',
              accent: _kRose,
              accentSoft: _kRoseSoft,
              trigger: PopupMenuButton<int>(
                tooltip: 'Sort',
                onSelected: (int v) {},
                offset: const Offset(0.0, 42.0),
                itemBuilder: (BuildContext _) => _secondMenuItems(),
                child: OutlinedButton.icon(
                  onPressed: null,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _kRose,
                    disabledForegroundColor: _kRose,
                    side: const BorderSide(color: _kRose, width: 1.2),
                  ),
                  icon: const Icon(Icons.sort_rounded, size: 16.0),
                  label: const Text('Sort by'),
                ),
              ),
              previewItems: _secondMenuItems(),
            ),
            _popupCard(
              title: 'Trigger: TextButton',
              accent: _kViolet,
              accentSoft: _kVioletSoft,
              trigger: PopupMenuButton<int>(
                tooltip: 'More',
                onSelected: (int v) {},
                offset: const Offset(0.0, 42.0),
                itemBuilder: (BuildContext _) => _thirdMenuItems(),
                child: TextButton.icon(
                  onPressed: null,
                  style: TextButton.styleFrom(
                    foregroundColor: _kViolet,
                    disabledForegroundColor: _kViolet,
                  ),
                  icon: const Icon(Icons.more_horiz_rounded, size: 16.0),
                  label: const Text('More'),
                ),
              ),
              previewItems: _thirdMenuItems(),
            ),
            _popupCard(
              title: 'Trigger: IconButton',
              accent: _kTeal,
              accentSoft: _kTealSoft,
              trigger: PopupMenuButton<int>(
                tooltip: 'Layout',
                onSelected: (int v) {},
                offset: const Offset(0.0, 42.0),
                itemBuilder: (BuildContext _) => _fourthMenuItems(),
                icon: const Icon(Icons.view_quilt_rounded, color: _kTeal),
              ),
              previewItems: _fourthMenuItems(),
            ),
          ],
        ),
      ],
    ),
  );
}

List<PopupMenuEntry<int>> _firstMenuItems() {
  return <PopupMenuEntry<int>>[
    const PopupMenuItem<int>(
      value: 1,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(Icons.edit_rounded, size: 18.0, color: _kAccent),
        title: Text('Edit', style: TextStyle(fontSize: 13.0)),
        dense: true,
      ),
    ),
    const PopupMenuItem<int>(
      value: 2,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(Icons.copy_rounded, size: 18.0, color: _kAccent),
        title: Text('Duplicate', style: TextStyle(fontSize: 13.0)),
        dense: true,
      ),
    ),
    const PopupMenuDivider(),
    const PopupMenuItem<int>(
      value: 3,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(Icons.delete_rounded, size: 18.0, color: _kRose),
        title: Text(
          'Delete',
          style: TextStyle(fontSize: 13.0, color: _kRose),
        ),
        dense: true,
      ),
    ),
  ];
}

List<PopupMenuEntry<int>> _secondMenuItems() {
  return <PopupMenuEntry<int>>[
    const CheckedPopupMenuItem<int>(
      value: 10,
      checked: true,
      child: Text('Name (A-Z)', style: TextStyle(fontSize: 13.0)),
    ),
    const CheckedPopupMenuItem<int>(
      value: 11,
      checked: false,
      child: Text('Date modified', style: TextStyle(fontSize: 13.0)),
    ),
    const CheckedPopupMenuItem<int>(
      value: 12,
      checked: false,
      child: Text('Size', style: TextStyle(fontSize: 13.0)),
    ),
    const PopupMenuDivider(),
    const PopupMenuItem<int>(
      value: 13,
      child: Text('Customize...', style: TextStyle(fontSize: 13.0)),
    ),
  ];
}

List<PopupMenuEntry<int>> _thirdMenuItems() {
  return <PopupMenuEntry<int>>[
    PopupMenuItem<int>(
      value: 20,
      child: Row(
        children: const <Widget>[
          Icon(Icons.share_rounded, size: 18.0, color: _kViolet),
          SizedBox(width: 10.0),
          Text('Share', style: TextStyle(fontSize: 13.0)),
        ],
      ),
    ),
    PopupMenuItem<int>(
      value: 21,
      child: Row(
        children: const <Widget>[
          Icon(Icons.download_rounded, size: 18.0, color: _kViolet),
          SizedBox(width: 10.0),
          Text('Download', style: TextStyle(fontSize: 13.0)),
          Spacer(),
          Text('Ctrl+D',
              style: TextStyle(
                fontSize: 11.0,
                color: _kMuted,
                fontFamily: 'monospace',
              )),
        ],
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem<int>(
      enabled: false,
      value: 22,
      child: Row(
        children: const <Widget>[
          Icon(Icons.lock_rounded, size: 18.0, color: _kMuted),
          SizedBox(width: 10.0),
          Text('Archive (locked)',
              style: TextStyle(fontSize: 13.0, color: _kMuted)),
        ],
      ),
    ),
  ];
}

List<PopupMenuEntry<int>> _fourthMenuItems() {
  return <PopupMenuEntry<int>>[
    const PopupMenuItem<int>(
      value: 30,
      child: Text('Grid view', style: TextStyle(fontSize: 13.0)),
    ),
    const PopupMenuItem<int>(
      value: 31,
      child: Text('List view', style: TextStyle(fontSize: 13.0)),
    ),
    const PopupMenuItem<int>(
      value: 32,
      child: Text('Column view', style: TextStyle(fontSize: 13.0)),
    ),
  ];
}

Widget _popupCard({
  required String title,
  required Color accent,
  required Color accentSoft,
  required Widget trigger,
  required List<PopupMenuEntry<int>> previewItems,
}) {
  return SizedBox(
    width: 280.0,
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
                    horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: accentSoft,
                  borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    color: accent,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Align(alignment: Alignment.centerLeft, child: trigger),
          const SizedBox(height: 12.0),
          _menuPreview(previewItems, accent),
        ],
      ),
    ),
  );
}

Widget _menuPreview(List<PopupMenuEntry<int>> items, Color accent) {
  return Container(
    decoration: BoxDecoration(
      color: _kCard,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      border: Border.all(color: _kBorder, width: 1.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x1A101426),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final PopupMenuEntry<int> entry in items)
          _previewEntry(entry, accent),
      ],
    ),
  );
}

Widget _previewEntry(PopupMenuEntry<int> entry, Color accent) {
  if (entry is PopupMenuDivider) {
    return const Divider(height: 6.0, color: _kBorderSoft, thickness: 1.0);
  }
  if (entry is CheckedPopupMenuItem<int>) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          Icon(
            entry.checked ? Icons.check_rounded : Icons.check_box_outline_blank,
            size: 16.0,
            color: entry.checked ? accent : _kMuted,
          ),
          const SizedBox(width: 10.0),
          DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 13.0, color: _kInk),
            child: entry.child ?? const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
  if (entry is PopupMenuItem<int>) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      child: DefaultTextStyle.merge(
        style: const TextStyle(fontSize: 13.0, color: _kInk),
        child: entry.child ?? const SizedBox.shrink(),
      ),
    );
  }
  return const SizedBox.shrink();
}

// ---------------------------------------------------------------------------
// Section 4: MenuBar + MenuItemButton.
// ---------------------------------------------------------------------------
Widget _menuBarShowcase() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('MenuBar (live)', style: _kH3),
        const SizedBox(height: 10.0),
        MenuBar(
          children: <Widget>[
            SubmenuButton(
              menuChildren: <Widget>[
                MenuItemButton(
                  onPressed: () {},
                  leadingIcon: const Icon(Icons.note_add_rounded, size: 16.0),
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.keyN,
                    control: true,
                  ),
                  child: const Text('New'),
                ),
                MenuItemButton(
                  onPressed: () {},
                  leadingIcon: const Icon(Icons.folder_open_rounded, size: 16.0),
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.keyO,
                    control: true,
                  ),
                  child: const Text('Open...'),
                ),
                MenuItemButton(
                  onPressed: () {},
                  leadingIcon: const Icon(Icons.save_rounded, size: 16.0),
                  shortcut: const SingleActivator(
                    LogicalKeyboardKey.keyS,
                    control: true,
                  ),
                  child: const Text('Save'),
                ),
                const Divider(height: 8.0, color: _kBorderSoft),
                MenuItemButton(
                  onPressed: () {},
                  style: MenuItemButton.styleFrom(foregroundColor: _kRose),
                  leadingIcon:
                      const Icon(Icons.logout_rounded, size: 16.0, color: _kRose),
                  child: const Text('Quit'),
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
                const Divider(height: 8.0, color: _kBorderSoft),
                MenuItemButton(
                  onPressed: () {},
                  leadingIcon: const Icon(Icons.cut_rounded, size: 16.0),
                  child: const Text('Cut'),
                ),
                MenuItemButton(
                  onPressed: () {},
                  leadingIcon: const Icon(Icons.copy_rounded, size: 16.0),
                  child: const Text('Copy'),
                ),
                MenuItemButton(
                  onPressed: () {},
                  leadingIcon: const Icon(Icons.paste_rounded, size: 16.0),
                  child: const Text('Paste'),
                ),
              ],
              child: const Text('Edit'),
            ),
            SubmenuButton(
              menuChildren: <Widget>[
                MenuItemButton(
                  onPressed: () {},
                  leadingIcon: const Icon(Icons.zoom_in_rounded, size: 16.0),
                  child: const Text('Zoom in'),
                ),
                MenuItemButton(
                  onPressed: () {},
                  leadingIcon: const Icon(Icons.zoom_out_rounded, size: 16.0),
                  child: const Text('Zoom out'),
                ),
                MenuItemButton(
                  onPressed: () {},
                  leadingIcon:
                      const Icon(Icons.fullscreen_rounded, size: 16.0),
                  child: const Text('Full screen'),
                ),
              ],
              child: const Text('View'),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        const Text('Submenu visual (expanded preview)', style: _kH3),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: <Widget>[
            _submenuPreview('File', _fileSubmenuRows(), _kAccent, _kAccentSoft),
            _submenuPreview('Edit', _editSubmenuRows(), _kViolet, _kVioletSoft),
            _submenuPreview('View', _viewSubmenuRows(), _kTeal, _kTealSoft),
          ],
        ),
      ],
    ),
  );
}

List<_SubmenuRow> _fileSubmenuRows() {
  return const <_SubmenuRow>[
    _SubmenuRow(icon: Icons.note_add_rounded, label: 'New', shortcut: 'Ctrl+N'),
    _SubmenuRow(
        icon: Icons.folder_open_rounded, label: 'Open...', shortcut: 'Ctrl+O'),
    _SubmenuRow(icon: Icons.save_rounded, label: 'Save', shortcut: 'Ctrl+S'),
    _SubmenuRow.divider(),
    _SubmenuRow(
      icon: Icons.logout_rounded,
      label: 'Quit',
      shortcut: 'Ctrl+Q',
      accent: _kRose,
    ),
  ];
}

List<_SubmenuRow> _editSubmenuRows() {
  return const <_SubmenuRow>[
    _SubmenuRow(icon: Icons.undo_rounded, label: 'Undo', shortcut: 'Ctrl+Z'),
    _SubmenuRow(icon: Icons.redo_rounded, label: 'Redo', shortcut: 'Ctrl+Y'),
    _SubmenuRow.divider(),
    _SubmenuRow(icon: Icons.cut_rounded, label: 'Cut', shortcut: 'Ctrl+X'),
    _SubmenuRow(icon: Icons.copy_rounded, label: 'Copy', shortcut: 'Ctrl+C'),
    _SubmenuRow(icon: Icons.paste_rounded, label: 'Paste', shortcut: 'Ctrl+V'),
  ];
}

List<_SubmenuRow> _viewSubmenuRows() {
  return const <_SubmenuRow>[
    _SubmenuRow(
        icon: Icons.zoom_in_rounded, label: 'Zoom in', shortcut: 'Ctrl++'),
    _SubmenuRow(
        icon: Icons.zoom_out_rounded, label: 'Zoom out', shortcut: 'Ctrl+-'),
    _SubmenuRow(
        icon: Icons.fullscreen_rounded,
        label: 'Full screen',
        shortcut: 'F11'),
  ];
}

class _SubmenuRow {
  const _SubmenuRow({
    required this.icon,
    required this.label,
    required this.shortcut,
    this.accent = _kInk,
  }) : isDivider = false;

  const _SubmenuRow.divider()
      : icon = Icons.remove,
        label = '',
        shortcut = '',
        accent = _kInk,
        isDivider = true;

  final IconData icon;
  final String label;
  final String shortcut;
  final Color accent;
  final bool isDivider;
}

Widget _submenuPreview(
    String title, List<_SubmenuRow> rows, Color accent, Color accentSoft) {
  return SizedBox(
    width: 260.0,
    child: Container(
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        border: Border.all(color: _kBorder, width: 1.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: accentSoft,
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                  ),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      color: accent,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4.0),
          for (final _SubmenuRow row in rows) _submenuRow(row, accent),
        ],
      ),
    ),
  );
}

Widget _submenuRow(_SubmenuRow row, Color accent) {
  if (row.isDivider) {
    return const Divider(height: 6.0, color: _kBorderSoft, thickness: 1.0);
  }
  final Color labelColor = row.accent == _kInk ? _kInk : row.accent;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
    child: Row(
      children: <Widget>[
        Icon(row.icon, size: 16.0, color: labelColor),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            row.label,
            style: TextStyle(
              fontSize: 13.0,
              color: labelColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          row.shortcut,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: _kMuted,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5: ButtonStyle.lerp + copyWith.
// ---------------------------------------------------------------------------
Widget _lerpCopyWithShowcase() {
  final ButtonStyle base = ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(_kAccent),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    elevation: WidgetStateProperty.all<double>(0.0),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),
  );

  final ButtonStyle copyShape = base.copyWith(
    shape: WidgetStateProperty.all<OutlinedBorder>(const StadiumBorder()),
  );
  final ButtonStyle copyColor = base.copyWith(
    backgroundColor: WidgetStateProperty.all<Color>(_kViolet),
  );
  final ButtonStyle lerped =
      ButtonStyle.lerp(base, _roseStyle(), 0.5) ?? base;
  final ButtonStyle merged =
      base.merge(ButtonStyle(elevation: WidgetStateProperty.all<double>(8.0)));

  return _card(
    child: Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        _lerpCell('base', base, 'ButtonStyle(...)'),
        _lerpCell('copyWith(shape)', copyShape, 'shape: StadiumBorder()'),
        _lerpCell('copyWith(color)', copyColor, 'backgroundColor: violet'),
        _lerpCell('lerp(base, rose, .5)', lerped, 'ButtonStyle.lerp(...)'),
        _lerpCell('merge(elev: 8)', merged, 'base.merge(...)'),
      ],
    ),
  );
}

ButtonStyle _roseStyle() {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(_kRose),
    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    elevation: WidgetStateProperty.all<double>(4.0),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
      const EdgeInsets.symmetric(horizontal: 22.0, vertical: 14.0),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(const StadiumBorder()),
  );
}

Widget _lerpCell(String label, ButtonStyle style, String summary) {
  return SizedBox(
    width: 240.0,
    child: Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _kPaper,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: _kBorderSoft, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: _kLabel),
          const SizedBox(height: 8.0),
          ElevatedButton(
            style: style,
            onPressed: () {},
            child: const Text('Sample'),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            decoration: const BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            child: Text(summary, style: _kMonoSmall),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6: WidgetStateProperty constructors.
// ---------------------------------------------------------------------------
Widget _stateConstructorsShowcase() {
  return _card(
    child: Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        _codeCard(
          '.all<T>(value)',
          'Returns the same value regardless of states. Cheap. Use when the field is genuinely state-independent.',
          'final bg = WidgetStateProperty.all<Color>(\n'
              '  Colors.indigo,\n'
              ');\n\n'
              '// Or the concise alias:\n'
              'const bg2 = WidgetStatePropertyAll<Color>(Colors.indigo);',
        ),
        _codeCard(
          '.resolveWith<T>((states) {...})',
          'Inspect the active state-set and branch. Order of branches matters: pressed beats hovered beats focused beats fallback.',
          'final fg = WidgetStateProperty.resolveWith<Color>((states) {\n'
              '  if (states.contains(WidgetState.disabled)) return Colors.grey;\n'
              '  if (states.contains(WidgetState.pressed))  return Colors.white;\n'
              '  if (states.contains(WidgetState.hovered))  return Colors.amber;\n'
              '  return Colors.indigoAccent;\n'
              '});',
        ),
        _codeCard(
          'ButtonStyle.lerp(a, b, t)',
          'Per-field interpolation between two ButtonStyles. Useful for theming transitions and motion. lerp(null, null) returns null.',
          'final blended = ButtonStyle.lerp(\n'
              '  primaryStyle,\n'
              '  dangerStyle,\n'
              '  animation.value, // 0.0 .. 1.0\n'
              ') ?? primaryStyle;',
        ),
      ],
    ),
  );
}

Widget _codeCard(String title, String description, String code) {
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
          Text(title, style: _kH3),
          const SizedBox(height: 6.0),
          Text(description, style: _kBody),
          const SizedBox(height: 10.0),
          _codeBlock(code),
        ],
      ),
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
// Section 7: PopupMenuTheme + MenuTheme integration.
// ---------------------------------------------------------------------------
Widget _themeIntegrationShowcase() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Theme-driven uniform styling', style: _kH3),
        const SizedBox(height: 6.0),
        const Text(
          'Wrapping a subtree in Theme(data: ...) lets PopupMenuTheme, MenuTheme '
          'and MenuButtonTheme drive every menu surface below without per-widget '
          'styling. The trigger button still uses its own *ButtonTheme.',
          style: _kBody,
        ),
        const SizedBox(height: 14.0),
        Theme(
          data: ThemeData(
            useMaterial3: true,
            colorScheme: const ColorScheme.light(
              primary: _kRose,
              onPrimary: Colors.white,
              surface: _kCard,
              onSurface: _kInk,
              error: _kRose,
              onError: Colors.white,
            ),
            popupMenuTheme: const PopupMenuThemeData(
              color: _kCard,
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14.0)),
                side: BorderSide(color: _kRose),
              ),
              textStyle: TextStyle(
                fontSize: 13.0,
                color: _kInk,
                fontWeight: FontWeight.w600,
              ),
            ),
            menuButtonTheme: MenuButtonThemeData(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(_kRose),
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(WidgetState.hovered)) {
                      return _kRoseSoft;
                    }
                    return Colors.transparent;
                  },
                ),
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: _kRoseSoft.withOpacity(0.35),
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
              border: Border.all(color: _kRose.withOpacity(0.4), width: 1.0),
            ),
            child: Row(
              children: <Widget>[
                PopupMenuButton<int>(
                  onSelected: (int v) {},
                  itemBuilder: (BuildContext _) => _firstMenuItems(),
                  child: const _ThemedTriggerLabel(label: 'Themed trigger'),
                ),
                const SizedBox(width: 18.0),
                Expanded(
                  child: _menuPreview(_firstMenuItems(), _kRose),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _ThemedTriggerLabel extends StatelessWidget {
  const _ThemedTriggerLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: _kRose,
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.tune_rounded, color: Colors.white, size: 16.0),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 8: Pitfalls.
// ---------------------------------------------------------------------------
Widget _pitfallsGrid() {
  return _card(
    child: Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        _pitfall(
          'MaterialStateProperty was renamed',
          'WidgetStateProperty is the new name. The Material* aliases still exist but are deprecated. Prefer the Widget* prefix in new code.',
          _kAccent,
        ),
        _pitfall(
          'PopupMenuButton.style affects trigger only',
          'PopupMenuButton.style decorates the *trigger*. To restyle items, use PopupMenuItem.child or PopupMenuTheme.',
          _kRose,
        ),
        _pitfall(
          'Material ancestor required',
          'PopupMenuItem and MenuItemButton paint InkWell ripples, which need an enclosing Material widget. MaterialApp/Scaffold supply one automatically.',
          _kAmber,
        ),
        _pitfall(
          'ButtonStyle.lerp(null, null) == null',
          'If both styles are null, lerp returns null. Always fall back to a known-good base ButtonStyle to avoid losing all theming mid-animation.',
          _kTeal,
        ),
        _pitfall(
          'merge precedence: this wins',
          'a.merge(b) keeps fields from a where set; b only fills holes. The opposite of copyWith. Pick the constructor that matches your intent.',
          _kViolet,
        ),
        _pitfall(
          'styleFrom is not exhaustive',
          'ElevatedButton.styleFrom is a convenience that maps colors to WidgetStateProperty.all under the hood. For state-aware values, write a full ButtonStyle with resolveWith.',
          _kSlate,
        ),
      ],
    ),
  );
}

Widget _pitfall(String title, String description, Color accent) {
  return SizedBox(
    width: 300.0,
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
// Section 9: Code idioms.
// ---------------------------------------------------------------------------
Widget _codeIdiomsGrid() {
  return _card(
    child: Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        _idiom(
          'styleFrom shortcut',
          'ElevatedButton(\n'
              '  style: ElevatedButton.styleFrom(\n'
              '    backgroundColor: Colors.indigo,\n'
              '    foregroundColor: Colors.white,\n'
              '    padding: EdgeInsets.symmetric(h: 20, v: 12),\n'
              '    shape: StadiumBorder(),\n'
              '  ),\n'
              '  onPressed: () {},\n'
              '  child: const Text("Save"),\n'
              ');',
        ),
        _idiom(
          'Full ButtonStyle + WidgetStateProperty',
          'final style = ButtonStyle(\n'
              '  backgroundColor: WidgetStateProperty.resolveWith<Color>((s) {\n'
              '    if (s.contains(WidgetState.pressed))  return indigo700;\n'
              '    if (s.contains(WidgetState.hovered))  return indigo400;\n'
              '    if (s.contains(WidgetState.disabled)) return grey;\n'
              '    return indigo500;\n'
              '  }),\n'
              '  foregroundColor: const WidgetStatePropertyAll(Colors.white),\n'
              '  shape: const WidgetStatePropertyAll(StadiumBorder()),\n'
              ');',
        ),
        _idiom(
          'Themed override',
          'Theme(\n'
              '  data: Theme.of(context).copyWith(\n'
              '    elevatedButtonTheme: ElevatedButtonThemeData(\n'
              '      style: ButtonStyle(\n'
              '        backgroundColor: WidgetStatePropertyAll(rose),\n'
              '        foregroundColor: WidgetStatePropertyAll(white),\n'
              '      ),\n'
              '    ),\n'
              '  ),\n'
              '  child: child,\n'
              ');',
        ),
        _idiom(
          'PopupMenuButton with styled trigger',
          'PopupMenuButton<int>(\n'
              '  onSelected: (int v) => handle(v),\n'
              '  itemBuilder: (_) => <PopupMenuEntry<int>>[\n'
              '    const PopupMenuItem<int>(value: 1, child: Text("Edit")),\n'
              '    const PopupMenuDivider(),\n'
              '    const CheckedPopupMenuItem<int>(\n'
              '      value: 2, checked: true, child: Text("Done"),\n'
              '    ),\n'
              '  ],\n'
              '  child: const TriggerChip(),\n'
              ');',
        ),
        _idiom(
          'MenuBar + MenuItemButton',
          'MenuBar(\n'
              '  children: <Widget>[\n'
              '    SubmenuButton(\n'
              '      menuChildren: <Widget>[\n'
              '        MenuItemButton(\n'
              '          onPressed: () => save(),\n'
              '          shortcut: SingleActivator(\n'
              '            LogicalKeyboardKey.keyS, control: true,\n'
              '          ),\n'
              '          child: const Text("Save"),\n'
              '        ),\n'
              '      ],\n'
              '      child: const Text("File"),\n'
              '    ),\n'
              '  ],\n'
              ');',
        ),
        _idiom(
          'Animated style swap',
          'AnimatedTheme(\n'
              '  data: Theme.of(context).copyWith(\n'
              '    elevatedButtonTheme: ElevatedButtonThemeData(\n'
              '      style: highlighted ? danger : primary,\n'
              '    ),\n'
              '  ),\n'
              '  duration: const Duration(milliseconds: 240),\n'
              '  child: child,\n'
              ');',
        ),
      ],
    ),
  );
}

Widget _idiom(String title, String code) {
  return SizedBox(
    width: 380.0,
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
          Text(title, style: _kH3),
          const SizedBox(height: 8.0),
          _codeBlock(code),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 10: API surface cheat-sheet.
// ---------------------------------------------------------------------------
Widget _cheatSheetFooter() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('API surface inventory', style: _kH3),
        const SizedBox(height: 6.0),
        const Text(
          'Every symbol referenced in this demo, grouped by capability. Use the '
          'chip colors as a mnemonic: blue = button styling, violet = state '
          'machinery, rose = popup, amber = menu bar, teal = themes.',
          style: _kBody,
        ),
        const SizedBox(height: 12.0),
        _chipGroup('Button styling', _kAccent, _kAccentSoft, const <String>[
          'ButtonStyle',
          'ButtonStyle.copyWith',
          'ButtonStyle.merge',
          'ButtonStyle.lerp',
          'ElevatedButton.styleFrom',
          'OutlinedButton.styleFrom',
          'TextButton.styleFrom',
          'FilledButton.styleFrom',
          'IconButton.styleFrom',
        ]),
        const SizedBox(height: 10.0),
        _chipGroup(
            'State machinery', _kViolet, _kVioletSoft, const <String>[
          'WidgetState',
          'WidgetStateProperty',
          'WidgetStateProperty.all',
          'WidgetStatePropertyAll',
          'WidgetStateProperty.resolveWith',
          'WidgetState.pressed',
          'WidgetState.hovered',
          'WidgetState.focused',
          'WidgetState.disabled',
          'WidgetState.dragged',
          'WidgetState.selected',
          'WidgetState.scrolledUnder',
          'WidgetState.error',
        ]),
        const SizedBox(height: 10.0),
        _chipGroup('Popup menu', _kRose, _kRoseSoft, const <String>[
          'PopupMenuButton<T>',
          'PopupMenuItem<T>',
          'CheckedPopupMenuItem<T>',
          'PopupMenuDivider',
          'PopupMenuEntry<T>',
          'PopupMenuTheme',
          'PopupMenuThemeData',
        ]),
        const SizedBox(height: 10.0),
        _chipGroup('Menu bar', _kAmber, _kAmberSoft, const <String>[
          'MenuBar',
          'MenuBarTheme',
          'MenuBarThemeData',
          'SubmenuButton',
          'MenuItemButton',
          'MenuItemButton.styleFrom',
          'MenuStyle',
          'MenuTheme',
          'MenuThemeData',
          'SingleActivator',
        ]),
        const SizedBox(height: 10.0),
        _chipGroup('Themes', _kTeal, _kTealSoft, const <String>[
          'ElevatedButtonThemeData',
          'OutlinedButtonThemeData',
          'TextButtonThemeData',
          'FilledButtonThemeData',
          'MenuButtonThemeData',
          'ThemeData.menuButtonTheme',
          'ThemeData.popupMenuTheme',
          'ThemeData.menuTheme',
          'ThemeData.menuBarTheme',
        ]),
      ],
    ),
  );
}

Widget _chipGroup(
    String label, Color accent, Color accentSoft, List<String> entries) {
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
                  border: Border.all(color: accent.withOpacity(0.3), width: 1.0),
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

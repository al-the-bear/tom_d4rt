// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables
// D4rt test script: Deep visual demo of the Cupertino class family.
//
// This script is part of the D4rt flutter-test corpus. It runs inside a
// sandboxed, analyzer-free Dart interpreter and exposes a single
// top-level entry point - `dynamic build(BuildContext context)` - which
// is invoked once and returns a Widget tree.
//
// The rendered output is a long, static poster that walks through the
// canonical Cupertino class family:
//
//   * App / Scaffold      - CupertinoApp, CupertinoPageScaffold, CupertinoTabScaffold
//   * Navigation          - CupertinoNavigationBar, CupertinoTabBar, CupertinoTabView
//   * Controls            - CupertinoButton, CupertinoSwitch, CupertinoSlider,
//                           CupertinoSegmentedControl, CupertinoSlidingSegmentedControl
//   * Pickers             - CupertinoPicker, CupertinoDatePicker, CupertinoTimerPicker
//   * Dialogs / Sheets    - CupertinoAlertDialog, CupertinoActionSheet
//   * Indicators          - CupertinoActivityIndicator
//   * Lists / Forms       - CupertinoListSection, CupertinoListTile,
//                           CupertinoFormSection, CupertinoFormRow
//   * Text Input          - CupertinoTextField, CupertinoTextFormFieldRow,
//                           CupertinoSearchTextField
//   * Theming             - CupertinoTheme, CupertinoThemeData, CupertinoColors,
//                           CupertinoIcons
//
// Each section is followed by code snippets that illustrate idiomatic
// composition, a class-hierarchy diagram drawn with a CustomPainter, a
// comparison matrix that pairs Cupertino classes with their Material
// analogues, a naming-conventions panel, and a pitfalls panel.  Because
// the script runs in a static, no-interaction environment, every
// callback is either `null` (disabled state) or `(_) {}` (a no-op
// consumer).  No `setState`, `Timer`, `Future` or `AnimationController`
// are used anywhere in this file.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// Stylistic constants share the same iOS-leaning palette used by the rest
// of the cupertino/* test corpus.  Chrome colors are kept as `const Color`
// literals so the helpers below can be `const`-built without depending on
// a live `CupertinoTheme`.  Anywhere we want to *demonstrate* a Cupertino
// class, we instantiate the real class with no-op callbacks.
const Color _kCanvas = Color(0xFFF2F2F7);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardDark = Color(0xFF1C1C1E);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1C1C1E);
const Color _kInkSecondary = Color(0xFF3C3C43);
const Color _kInkTertiary = Color(0xFF8E8E93);
const Color _kInkOnDark = Color(0xFFEDEDF0);
const Color _kInkOnDarkSecondary = Color(0xFFA1A1A6);
const Color _kAccent = Color(0xFF007AFF);
const Color _kAccentGreen = Color(0xFF34C759);
const Color _kAccentOrange = Color(0xFFFF9500);
const Color _kAccentRed = Color(0xFFFF3B30);
const Color _kAccentIndigo = Color(0xFF5856D6);
const Color _kAccentPink = Color(0xFFFF2D55);
const Color _kAccentTeal = Color(0xFF30B0C7);
const Color _kAccentYellow = Color(0xFFFFCC00);
const Color _kAccentPurple = Color(0xFFAF52DE);
const Color _kAccentBrown = Color(0xFFA2845E);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);
const Color _kCodeType = Color(0xFFF9C8C2);

// Category swatch palette.  One distinct hue per category, used as the
// header strip color on category panels and as the box fill in the
// class-hierarchy diagram.  Hues lifted from `CupertinoColors.system*`.
const Color _kCatAppScaffold = Color(0xFF0A84FF);
const Color _kCatNavigation = Color(0xFF5E5CE6);
const Color _kCatControls = Color(0xFF34C759);
const Color _kCatPickers = Color(0xFFFF9500);
const Color _kCatDialogs = Color(0xFFFF3B30);
const Color _kCatIndicators = Color(0xFF30B0C7);
const Color _kCatListsForms = Color(0xFFAF52DE);
const Color _kCatTextInput = Color(0xFFFF2D55);
const Color _kCatTheming = Color(0xFFA2845E);

const TextStyle _kTitleStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  letterSpacing: -0.4,
);
const TextStyle _kSubtitleStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: _kInkSecondary,
);
const TextStyle _kCaptionStyle = TextStyle(
  fontSize: 12.0,
  color: _kInkTertiary,
  fontWeight: FontWeight.w500,
);
const TextStyle _kBodyStyle = TextStyle(
  fontSize: 14.0,
  height: 1.45,
  color: _kInk,
);
const TextStyle _kSwatchNameStyle = TextStyle(
  fontSize: 11.0,
  fontWeight: FontWeight.w600,
  color: _kInk,
  letterSpacing: -0.1,
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.4,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);
const EdgeInsets _kSectionPadding = EdgeInsets.symmetric(horizontal: 18.0);

// ---------------------------------------------------------------------------
// PRIVATE HELPERS
// ---------------------------------------------------------------------------

Color _contrastingFor(Color c) {
  final double r = c.red / 255.0;
  final double g = c.green / 255.0;
  final double b = c.blue / 255.0;
  final double l = 0.2126 * r + 0.7152 * g + 0.0722 * b;
  return l > 0.55 ? _kInk : const Color(0xFFFFFFFF);
}

Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(top: 28.0, bottom: 12.0, left: 18.0, right: 18.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _kAccent,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _kTitleStyle),
              const SizedBox(height: 2.0),
              Text(tagline, style: _kSubtitleStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _sectionDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
    child: Container(
      height: 1.0,
      color: _kHairline,
    ),
  );
}

Widget _card({
  required Widget child,
  Color background = _kCardBg,
  EdgeInsets padding = _kCardPadding,
  EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairline),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0D000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 3.0,
        ),
      ],
    ),
    child: child,
  );
}

Widget _cardTitle(String title, {String? subtitle, Color titleColor = _kInk, Color subtitleColor = _kInkSecondary}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: titleColor,
          letterSpacing: -0.2,
        ),
      ),
      if (subtitle != null) ...<Widget>[
        const SizedBox(height: 2.0),
        Text(subtitle, style: TextStyle(fontSize: 12.5, color: subtitleColor)),
      ],
    ],
  );
}

Widget _pill(String label, {Color colour = _kAccent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.3)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: colour,
      ),
    ),
  );
}

Widget _codeLine(List<_Tok> tokens) {
  return RichText(
    text: TextSpan(
      style: _kCodeStyle,
      children: <InlineSpan>[
        for (final _Tok t in tokens)
          TextSpan(
            text: t.text,
            style: TextStyle(color: t.color),
          ),
      ],
    ),
  );
}

class _Tok {
  final String text;
  final Color color;
  const _Tok(this.text, this.color);
  const _Tok.plain(this.text) : color = _kCodeText;
  const _Tok.keyword(this.text) : color = _kCodeKeyword;
  const _Tok.string(this.text) : color = _kCodeString;
  const _Tok.comment(this.text) : color = _kCodeComment;
  const _Tok.accent(this.text) : color = _kCodeAccent;
  const _Tok.type(this.text) : color = _kCodeType;
}

// A categorised "class entry" used by the index card, the swatch grid,
// and the hierarchy diagram.  We keep this as a plain data class so it
// is trivial for the D4rt interpreter to materialise.
class _ClassEntry {
  final String name;
  final String oneLiner;
  final String role;
  const _ClassEntry(this.name, this.oneLiner, this.role);
}

class _Category {
  final String name;
  final String description;
  final Color color;
  final IconData icon;
  final List<_ClassEntry> classes;
  const _Category({
    required this.name,
    required this.description,
    required this.color,
    required this.icon,
    required this.classes,
  });
}

// Authoritative list of categories.  Used everywhere a category appears
// (index, swatch grid, hierarchy diagram, comparison matrix).
const List<_Category> _kCategories = <_Category>[
  _Category(
    name: 'App / Scaffold',
    description: 'Top-level app shell and per-route scaffolding.',
    color: _kCatAppScaffold,
    icon: CupertinoIcons.square_stack_3d_up_fill,
    classes: <_ClassEntry>[
      _ClassEntry('CupertinoApp', 'Root widget; wires Localizations, MediaQuery, Navigator.', 'root'),
      _ClassEntry('CupertinoPageScaffold', 'Single-page scaffold with optional navigation bar.', 'page'),
      _ClassEntry('CupertinoTabScaffold', 'Tabbed shell containing a CupertinoTabBar at the bottom.', 'shell'),
    ],
  ),
  _Category(
    name: 'Navigation',
    description: 'Bars, tabs, and per-tab navigators.',
    color: _kCatNavigation,
    icon: CupertinoIcons.arrow_turn_up_right,
    classes: <_ClassEntry>[
      _ClassEntry('CupertinoNavigationBar', 'Static iOS-style top bar with leading/middle/trailing slots.', 'chrome'),
      _ClassEntry('CupertinoSliverNavigationBar', 'Large-title nav bar that collapses when scrolled.', 'chrome'),
      _ClassEntry('CupertinoTabBar', 'Bottom bar that lights an active tab among its items.', 'chrome'),
      _ClassEntry('CupertinoTabView', 'Per-tab Navigator host inside a CupertinoTabScaffold.', 'navigator'),
    ],
  ),
  _Category(
    name: 'Controls',
    description: 'Buttons, switches, sliders, segmented selectors.',
    color: _kCatControls,
    icon: CupertinoIcons.slider_horizontal_3,
    classes: <_ClassEntry>[
      _ClassEntry('CupertinoButton', 'Filled or borderless tap target with iOS press feedback.', 'tap'),
      _ClassEntry('CupertinoSwitch', 'Two-state toggle bound to a bool.', 'toggle'),
      _ClassEntry('CupertinoSlider', 'Continuous numeric scrubber.', 'scrubber'),
      _ClassEntry('CupertinoSegmentedControl', 'Fixed-width segment row with one active segment.', 'choice'),
      _ClassEntry('CupertinoSlidingSegmentedControl', 'Animated, pill-shaped segmented control.', 'choice'),
    ],
  ),
  _Category(
    name: 'Pickers',
    description: 'Wheel-style pickers for values, dates, and timers.',
    color: _kCatPickers,
    icon: CupertinoIcons.calendar_today,
    classes: <_ClassEntry>[
      _ClassEntry('CupertinoPicker', 'Generic wheel picker over a children list.', 'wheel'),
      _ClassEntry('CupertinoDatePicker', 'Specialised date/time wheel with multiple modes.', 'wheel'),
      _ClassEntry('CupertinoTimerPicker', 'Hours/minutes/seconds duration wheel.', 'wheel'),
    ],
  ),
  _Category(
    name: 'Dialogs / Sheets',
    description: 'Modal dialogs and action sheets.',
    color: _kCatDialogs,
    icon: CupertinoIcons.exclamationmark_bubble,
    classes: <_ClassEntry>[
      _ClassEntry('CupertinoAlertDialog', 'Centered confirmation dialog with stacked actions.', 'modal'),
      _ClassEntry('CupertinoActionSheet', 'Bottom action sheet with destructive/default emphasis.', 'sheet'),
      _ClassEntry('CupertinoDialogAction', 'Single action button inside a CupertinoAlertDialog.', 'action'),
      _ClassEntry('CupertinoActionSheetAction', 'Single action button inside a CupertinoActionSheet.', 'action'),
    ],
  ),
  _Category(
    name: 'Indicators',
    description: 'Progress and activity indicators.',
    color: _kCatIndicators,
    icon: CupertinoIcons.refresh_thick,
    classes: <_ClassEntry>[
      _ClassEntry('CupertinoActivityIndicator', 'Spoked spinner used while content loads.', 'spinner'),
    ],
  ),
  _Category(
    name: 'Lists / Forms',
    description: 'Grouped/inset list sections and form rows.',
    color: _kCatListsForms,
    icon: CupertinoIcons.list_bullet_below_rectangle,
    classes: <_ClassEntry>[
      _ClassEntry('CupertinoListSection', 'Grouped or inset section that wraps CupertinoListTiles.', 'group'),
      _ClassEntry('CupertinoListTile', 'Single list row with leading/title/subtitle/trailing.', 'row'),
      _ClassEntry('CupertinoFormSection', 'Grouped form section with a header and rows.', 'group'),
      _ClassEntry('CupertinoFormRow', 'Single labelled form field row.', 'row'),
    ],
  ),
  _Category(
    name: 'Text Input',
    description: 'Editable text fields and search input.',
    color: _kCatTextInput,
    icon: CupertinoIcons.textformat,
    classes: <_ClassEntry>[
      _ClassEntry('CupertinoTextField', 'Single-line iOS-style text input.', 'input'),
      _ClassEntry('CupertinoTextFormFieldRow', 'TextField wrapped as a FormField inside a form section.', 'input'),
      _ClassEntry('CupertinoSearchTextField', 'Magnifier-prefixed search field with clear button.', 'search'),
    ],
  ),
  _Category(
    name: 'Theming',
    description: 'Theme propagation, palette, and icon set.',
    color: _kCatTheming,
    icon: CupertinoIcons.paintbrush,
    classes: <_ClassEntry>[
      _ClassEntry('CupertinoTheme', 'InheritedWidget that exposes a CupertinoThemeData.', 'theme'),
      _ClassEntry('CupertinoThemeData', 'Bundle of brightness, primary color, text theme.', 'theme'),
      _ClassEntry('CupertinoColors', 'Static palette of iOS system colors.', 'palette'),
      _ClassEntry('CupertinoIcons', 'Static catalog of SF Symbol-style icons.', 'icons'),
    ],
  ),
];

// ===========================================================================
// CATEGORY INDEX CARD
// ===========================================================================
// A two-column grid summarising the nine categories.  Each tile shows the
// category color, icon, the contained class count, and a one-line role.
Widget _categoryIndexCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Cupertino class categories',
          subtitle: 'Nine families of widgets cover the iOS surface area.',
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            for (final _Category cat in _kCategories) _categoryIndexTile(cat),
          ],
        ),
      ],
    ),
  );
}

Widget _categoryIndexTile(_Category cat) {
  return Container(
    width: 230.0,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: cat.color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: cat.color.withOpacity(0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 30.0,
              height: 30.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cat.color,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(cat.icon, size: 16.0, color: const Color(0xFFFFFFFF)),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                cat.name,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: cat.color,
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: Text(
                '${cat.classes.length}',
                style: const TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          cat.description,
          style: const TextStyle(fontSize: 11.5, color: _kInkSecondary, height: 1.35),
        ),
      ],
    ),
  );
}

// ===========================================================================
// CLASS HIERARCHY DIAGRAM
// ===========================================================================
// A CustomPainter draws boxes for the most important Cupertino classes and
// connects them with arrows.  Solid arrows mean "is a" (inheritance) and
// dashed arrows mean "contains" (composition).
//
// The diagram is deliberately information-dense rather than pretty -- the
// goal is to encode the actual structural relationships of the family.
class _HierarchyPainter extends CustomPainter {
  final List<_HierBox> boxes;
  final List<_HierArrow> arrows;
  const _HierarchyPainter({required this.boxes, required this.arrows});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = const Color(0xFF3C3C43)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    final Paint dashedPaint = Paint()
      ..color = const Color(0xFF8E8E93)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (final _HierArrow a in arrows) {
      final _HierBox from = boxes[a.fromIndex];
      final _HierBox to = boxes[a.toIndex];
      final Offset start = Offset(from.x + from.width / 2.0, from.y + from.height);
      final Offset end = Offset(to.x + to.width / 2.0, to.y);
      if (a.dashed) {
        _drawDashedLine(canvas, start, end, dashedPaint);
      } else {
        canvas.drawLine(start, end, linePaint);
      }
      _drawArrowhead(canvas, start, end, a.dashed ? dashedPaint : linePaint);
    }

    for (final _HierBox b in boxes) {
      final Rect rect = Rect.fromLTWH(b.x, b.y, b.width, b.height);
      final RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(8.0));
      final Paint fill = Paint()..color = b.color;
      canvas.drawRRect(rrect, fill);
      final Paint border = Paint()
        ..color = const Color(0x33000000)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawRRect(rrect, border);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: b.label,
          style: TextStyle(
            fontSize: 11.0,
            color: _contrastingFor(b.color),
            fontWeight: FontWeight.w700,
            letterSpacing: -0.1,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
        maxLines: 2,
      );
      tp.layout(maxWidth: b.width - 8.0);
      tp.paint(
        canvas,
        Offset(b.x + (b.width - tp.width) / 2.0, b.y + (b.height - tp.height) / 2.0),
      );
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const double dashLength = 4.0;
    const double gapLength = 3.0;
    final double dx = end.dx - start.dx;
    final double dy = end.dy - start.dy;
    final double dist = math.sqrt(dx * dx + dy * dy);
    if (dist < 0.001) {
      return;
    }
    final double nx = dx / dist;
    final double ny = dy / dist;
    double covered = 0.0;
    while (covered < dist) {
      final double segEnd = math.min(covered + dashLength, dist);
      final Offset a = Offset(start.dx + nx * covered, start.dy + ny * covered);
      final Offset b = Offset(start.dx + nx * segEnd, start.dy + ny * segEnd);
      canvas.drawLine(a, b, paint);
      covered = segEnd + gapLength;
    }
  }

  void _drawArrowhead(Canvas canvas, Offset start, Offset end, Paint paint) {
    final double dx = end.dx - start.dx;
    final double dy = end.dy - start.dy;
    final double angle = math.atan2(dy, dx);
    const double size = 6.0;
    final Offset p1 = Offset(
      end.dx - size * math.cos(angle - math.pi / 6.0),
      end.dy - size * math.sin(angle - math.pi / 6.0),
    );
    final Offset p2 = Offset(
      end.dx - size * math.cos(angle + math.pi / 6.0),
      end.dy - size * math.sin(angle + math.pi / 6.0),
    );
    final Path path = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..close();
    final Paint fill = Paint()..color = paint.color;
    canvas.drawPath(path, fill);
  }

  @override
  bool shouldRepaint(covariant _HierarchyPainter oldDelegate) {
    return oldDelegate.boxes != boxes || oldDelegate.arrows != arrows;
  }
}

class _HierBox {
  final String label;
  final double x;
  final double y;
  final double width;
  final double height;
  final Color color;
  const _HierBox({
    required this.label,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.color,
  });
}

class _HierArrow {
  final int fromIndex;
  final int toIndex;
  final bool dashed;
  const _HierArrow({
    required this.fromIndex,
    required this.toIndex,
    this.dashed = false,
  });
}

Widget _hierarchyDiagramCard() {
  // Layout in a 900x540 conceptual frame.  X coordinates are anchored to
  // category lanes spaced roughly 100px apart.  Y coordinates encode the
  // ownership level: 0 - app root, 1 - shell, 2 - chrome / content,
  // 3 - leaf widgets.
  const List<_HierBox> boxes = <_HierBox>[
    // 0: CupertinoApp (root)
    _HierBox(label: 'CupertinoApp', x: 360.0, y: 10.0, width: 160.0, height: 36.0, color: _kCatAppScaffold),
    // 1-2: shells
    _HierBox(label: 'CupertinoPageScaffold', x: 130.0, y: 90.0, width: 170.0, height: 36.0, color: _kCatAppScaffold),
    _HierBox(label: 'CupertinoTabScaffold', x: 580.0, y: 90.0, width: 170.0, height: 36.0, color: _kCatAppScaffold),
    // 3-6: navigation chrome
    _HierBox(label: 'CupertinoNavigationBar', x: 20.0, y: 170.0, width: 180.0, height: 36.0, color: _kCatNavigation),
    _HierBox(label: 'CupertinoSliverNavBar', x: 220.0, y: 170.0, width: 170.0, height: 36.0, color: _kCatNavigation),
    _HierBox(label: 'CupertinoTabBar', x: 480.0, y: 170.0, width: 150.0, height: 36.0, color: _kCatNavigation),
    _HierBox(label: 'CupertinoTabView', x: 650.0, y: 170.0, width: 150.0, height: 36.0, color: _kCatNavigation),
    // 7-10: controls
    _HierBox(label: 'CupertinoButton', x: 20.0, y: 260.0, width: 130.0, height: 32.0, color: _kCatControls),
    _HierBox(label: 'CupertinoSwitch', x: 170.0, y: 260.0, width: 130.0, height: 32.0, color: _kCatControls),
    _HierBox(label: 'CupertinoSlider', x: 320.0, y: 260.0, width: 130.0, height: 32.0, color: _kCatControls),
    _HierBox(label: 'CupertinoSegmented', x: 470.0, y: 260.0, width: 150.0, height: 32.0, color: _kCatControls),
    // 11-13: pickers
    _HierBox(label: 'CupertinoPicker', x: 20.0, y: 320.0, width: 130.0, height: 32.0, color: _kCatPickers),
    _HierBox(label: 'CupertinoDatePicker', x: 170.0, y: 320.0, width: 150.0, height: 32.0, color: _kCatPickers),
    _HierBox(label: 'CupertinoTimerPicker', x: 340.0, y: 320.0, width: 150.0, height: 32.0, color: _kCatPickers),
    // 14-15: dialogs/sheets
    _HierBox(label: 'CupertinoAlertDialog', x: 510.0, y: 320.0, width: 150.0, height: 32.0, color: _kCatDialogs),
    _HierBox(label: 'CupertinoActionSheet', x: 670.0, y: 320.0, width: 150.0, height: 32.0, color: _kCatDialogs),
    // 16: indicator
    _HierBox(label: 'CupertinoActivityIndicator', x: 20.0, y: 380.0, width: 200.0, height: 32.0, color: _kCatIndicators),
    // 17-20: lists/forms
    _HierBox(label: 'CupertinoListSection', x: 240.0, y: 380.0, width: 150.0, height: 32.0, color: _kCatListsForms),
    _HierBox(label: 'CupertinoListTile', x: 400.0, y: 380.0, width: 130.0, height: 32.0, color: _kCatListsForms),
    _HierBox(label: 'CupertinoFormSection', x: 540.0, y: 380.0, width: 150.0, height: 32.0, color: _kCatListsForms),
    _HierBox(label: 'CupertinoFormRow', x: 700.0, y: 380.0, width: 130.0, height: 32.0, color: _kCatListsForms),
    // 21-23: text input
    _HierBox(label: 'CupertinoTextField', x: 20.0, y: 440.0, width: 150.0, height: 32.0, color: _kCatTextInput),
    _HierBox(label: 'CupertinoTextFormFieldRow', x: 185.0, y: 440.0, width: 210.0, height: 32.0, color: _kCatTextInput),
    _HierBox(label: 'CupertinoSearchTextField', x: 410.0, y: 440.0, width: 200.0, height: 32.0, color: _kCatTextInput),
    // 24-27: theming
    _HierBox(label: 'CupertinoTheme', x: 30.0, y: 500.0, width: 130.0, height: 32.0, color: _kCatTheming),
    _HierBox(label: 'CupertinoThemeData', x: 170.0, y: 500.0, width: 160.0, height: 32.0, color: _kCatTheming),
    _HierBox(label: 'CupertinoColors', x: 340.0, y: 500.0, width: 130.0, height: 32.0, color: _kCatTheming),
    _HierBox(label: 'CupertinoIcons', x: 480.0, y: 500.0, width: 130.0, height: 32.0, color: _kCatTheming),
  ];

  const List<_HierArrow> arrows = <_HierArrow>[
    // CupertinoApp contains both scaffolds
    _HierArrow(fromIndex: 0, toIndex: 1, dashed: true),
    _HierArrow(fromIndex: 0, toIndex: 2, dashed: true),
    // PageScaffold contains nav bar variants
    _HierArrow(fromIndex: 1, toIndex: 3, dashed: true),
    _HierArrow(fromIndex: 1, toIndex: 4, dashed: true),
    // TabScaffold contains TabBar + TabView
    _HierArrow(fromIndex: 2, toIndex: 5, dashed: true),
    _HierArrow(fromIndex: 2, toIndex: 6, dashed: true),
    // PageScaffold body usually holds controls and lists
    _HierArrow(fromIndex: 1, toIndex: 7, dashed: true),
    _HierArrow(fromIndex: 1, toIndex: 17, dashed: true),
    _HierArrow(fromIndex: 1, toIndex: 19, dashed: true),
    // Dialogs/sheets are surfaced via showCupertinoDialog/showCupertinoModalPopup
    _HierArrow(fromIndex: 0, toIndex: 14, dashed: true),
    _HierArrow(fromIndex: 0, toIndex: 15, dashed: true),
    // Theming applies to everything; show one canonical arrow
    _HierArrow(fromIndex: 24, toIndex: 25),
    _HierArrow(fromIndex: 25, toIndex: 26),
    _HierArrow(fromIndex: 25, toIndex: 27),
    // List/form composition
    _HierArrow(fromIndex: 17, toIndex: 18, dashed: true),
    _HierArrow(fromIndex: 19, toIndex: 20, dashed: true),
    _HierArrow(fromIndex: 20, toIndex: 21, dashed: true),
    _HierArrow(fromIndex: 20, toIndex: 22, dashed: true),
  ];

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Class hierarchy & composition',
          subtitle: 'Solid arrows = "is a" / "configures". Dashed = "contains" / "spawns".',
        ),
        const SizedBox(height: 14.0),
        Container(
          height: 560.0,
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFC),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          padding: const EdgeInsets.all(8.0),
          child: ClipRect(
            child: CustomPaint(
              size: const Size(860.0, 545.0),
              painter: _HierarchyPainter(boxes: boxes, arrows: arrows),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            for (final _Category cat in _kCategories)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: cat.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(999.0),
                  border: Border.all(color: cat.color.withOpacity(0.35)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        color: cat.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      cat.name,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: cat.color,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// CATEGORISED CLASS GRID
// ===========================================================================
// Per category we render a coloured panel that contains:
//   * Header strip (color + icon + name + class count)
//   * Description
//   * A list of class tiles (name + role badge + one-liner)
Widget _categoryPanel(_Category cat) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: cat.color.withOpacity(0.35)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0D000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 3.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: cat.color.withOpacity(0.12),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 36.0,
                height: 36.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: cat.color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(cat.icon, size: 20.0, color: const Color(0xFFFFFFFF)),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cat.name,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: _kInk,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      cat.description,
                      style: const TextStyle(fontSize: 12.0, color: _kInkSecondary),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: cat.color,
                  borderRadius: BorderRadius.circular(999.0),
                ),
                child: Text(
                  '${cat.classes.length} classes',
                  style: const TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final _ClassEntry e in cat.classes) _classTile(e, cat.color),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _classTile(_ClassEntry entry, Color accent) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 6.0,
          height: 6.0,
          margin: const EdgeInsets.only(top: 7.0),
          decoration: BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      entry.name,
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: _kInk,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      entry.role,
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: accent,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2.0),
              Text(
                entry.oneLiner,
                style: const TextStyle(fontSize: 12.0, color: _kInkSecondary, height: 1.35),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// CODE-SNIPPET RECIPE CARDS
// ===========================================================================
// Four idiomatic Cupertino composition recipes, rendered as syntax-highlighted
// dark code panels.  The intent is to *show* how the classes fit together,
// not to compile.  Tokens are picked from the _Tok helper.
Widget _recipeCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color accent,
  required List<List<_Tok>> lines,
}) {
  return _card(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 30.0,
                height: 30.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(icon, size: 16.0, color: const Color(0xFFFFFFFF)),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: _kInk,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 12.0, color: _kInkSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFF2A2A2E)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final List<_Tok> line in lines) _codeLine(line),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// CUPERTINO vs MATERIAL COMPARISON MATRIX
// ===========================================================================
class _PairRow {
  final String cupertino;
  final String material;
  final String note;
  const _PairRow(this.cupertino, this.material, this.note);
}

Widget _comparisonMatrixCard() {
  const List<_PairRow> rows = <_PairRow>[
    _PairRow('CupertinoApp', 'MaterialApp', 'Root widget; both register Localizations, Navigator, MediaQuery.'),
    _PairRow('CupertinoPageScaffold', 'Scaffold', 'Cupertino lacks Drawer/FAB slots by design.'),
    _PairRow('CupertinoNavigationBar', 'AppBar', 'Static height; iOS preferredSize is ~44 logical pixels.'),
    _PairRow('CupertinoTabScaffold + CupertinoTabBar', 'BottomNavigationBar + Scaffold', 'iOS tabs each own a Navigator via CupertinoTabView.'),
    _PairRow('CupertinoButton', 'TextButton / ElevatedButton', 'Cupertino exposes .filled() and a borderless default.'),
    _PairRow('CupertinoSwitch', 'Switch', 'CupertinoSwitch ignores Material themes by design.'),
    _PairRow('CupertinoSlider', 'Slider', 'No discrete divisions widget; emulate via onChanged rounding.'),
    _PairRow('CupertinoSegmentedControl', 'ToggleButtons', 'CupertinoSlidingSegmentedControl is the pill-shaped variant.'),
    _PairRow('CupertinoAlertDialog', 'AlertDialog', 'Stacked action buttons; CupertinoDialogAction handles destructive.'),
    _PairRow('CupertinoActionSheet', 'BottomSheet / showModalBottomSheet', 'Bottom sheet with destructive/cancel emphasis.'),
    _PairRow('CupertinoActivityIndicator', 'CircularProgressIndicator', 'Spoked wheel; no determinate variant.'),
    _PairRow('CupertinoTextField', 'TextField', 'Defaults differ (border, padding, cursor color).'),
    _PairRow('CupertinoSearchTextField', 'SearchBar', 'iOS magnifier-prefixed pill with clear button.'),
    _PairRow('CupertinoListSection', 'ListTile + Card/Material', 'Grouped (.insetGrouped) or plain section header.'),
    _PairRow('CupertinoFormSection', 'Form + Card', 'Form rows are CupertinoFormRow; no FormField wrapper required.'),
    _PairRow('CupertinoPicker', 'DropdownButton', 'Picker is a wheel, not a popup menu.'),
    _PairRow('CupertinoDatePicker', 'showDatePicker', 'Date/time wheel rather than a calendar grid.'),
    _PairRow('CupertinoTimerPicker', '(no direct equivalent)', 'Hours/minutes/seconds wheel for durations.'),
    _PairRow('CupertinoTheme / CupertinoThemeData', 'Theme / ThemeData', 'Smaller surface area; brightness + primary + textTheme.'),
    _PairRow('CupertinoColors / CupertinoDynamicColor', 'Colors / ColorScheme', 'Dynamic colors resolve against context, not theme.'),
    _PairRow('CupertinoIcons', 'Icons (Material)', 'SF Symbol-style glyphs distinct from Material icons.'),
  ];

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Cupertino vs Material analogues',
          subtitle: 'Pick the platform pair when designing cross-platform widgets.',
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F6F8),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline),
          ),
          child: Row(
            children: const <Widget>[
              Expanded(flex: 4, child: Text('Cupertino', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: _kInk))),
              SizedBox(width: 10.0),
              Expanded(flex: 4, child: Text('Material', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: _kInk))),
              SizedBox(width: 10.0),
              Expanded(flex: 6, child: Text('Notes', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: _kInk))),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: i.isEven ? const Color(0xFFFCFCFD) : const Color(0xFFFFFFFF),
              border: const Border(bottom: BorderSide(color: _kHairline)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Text(
                    rows[i].cupertino,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: _kAccent,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  flex: 4,
                  child: Text(
                    rows[i].material,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: _kAccentPurple,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  flex: 6,
                  child: Text(
                    rows[i].note,
                    style: const TextStyle(fontSize: 11.5, color: _kInkSecondary, height: 1.35),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ===========================================================================
// NAMING CONVENTIONS PANEL
// ===========================================================================
Widget _namingConventionsCard() {
  const List<List<String>> rules = <List<String>>[
    <String>['Cupertino prefix', 'Every iOS-styled widget begins with "Cupertino" so it is grep-friendly and never collides with the Material twin.'],
    <String>['ObjC heritage', 'Names mirror UIKit (UINavigationBar -> CupertinoNavigationBar, UIActivityIndicatorView -> CupertinoActivityIndicator).'],
    <String>['Singular nouns', 'Widgets are singular (CupertinoButton, not CupertinoButtons). Plural names are reserved for static collections (CupertinoColors, CupertinoIcons).'],
    <String>['Suffix denotes form', 'Section/Tile/Row/Action suffixes describe layout role; FieldRow indicates "Field wrapped as Row" for forms.'],
    <String>['*Action subclasses', 'CupertinoDialogAction and CupertinoActionSheetAction are stamped buttons; they only make sense inside their parent.'],
    <String>['*Data classes', 'Pure-data bundles end in "Data" (CupertinoThemeData). They never extend Widget.'],
    <String>['Static catalogs', 'CupertinoColors and CupertinoIcons are abstract classes with only static const members.'],
    <String>['"Sliding" prefix', 'CupertinoSlidingSegmentedControl is the animated pill variant; the older fixed variant keeps the unprefixed name.'],
    <String>['Picker family', 'Wheel widgets share the "Picker" suffix; CupertinoDatePicker and CupertinoTimerPicker are specialised pickers.'],
  ];

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Naming conventions',
          subtitle: 'The "Cupertino*" namespace is a thin Dart projection of UIKit.',
        ),
        const SizedBox(height: 12.0),
        for (final List<String> r in rules)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 110.0,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: _kAccent.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: _kAccent.withOpacity(0.35)),
                  ),
                  child: Text(
                    r[0],
                    style: const TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      color: _kAccent,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    r[1],
                    style: const TextStyle(fontSize: 12.5, color: _kInk, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ===========================================================================
// PITFALLS PANEL
// ===========================================================================
Widget _pitfallsCard() {
  const List<List<String>> items = <List<String>>[
    <String>[
      'Use CupertinoApp, not MaterialApp wrapping Cupertino widgets.',
      'A Material ancestor still works (CupertinoTextField builds a Material under the hood for selection toolbar), but a CupertinoApp registers correct cursor color, scrollbars, and overscroll behaviour.',
    ],
    <String>[
      'Theme.of(context) returns ThemeData, not CupertinoThemeData.',
      'Reach for CupertinoTheme.of(context) when inside a CupertinoApp. The two theme systems do not auto-bridge except via MaterialBasedCupertinoThemeData.',
    ],
    <String>[
      'Do not rely on platform-aware switching without checking Theme.of.',
      'Patterns such as `Platform.isIOS ? CupertinoButton : ElevatedButton` are fine, but PlatformWidget helpers should be wrapped so design tokens flow through.',
    ],
    <String>[
      'CupertinoTabView is the per-tab Navigator host, not just a container.',
      'Wrapping every tab body in CupertinoTabView is what gives each tab its own back stack. Skip it and back button behaviour collapses to a single root navigator.',
    ],
    <String>[
      'CupertinoActionSheet and CupertinoAlertDialog are content widgets, not routes.',
      'They must be surfaced via showCupertinoModalPopup / showCupertinoDialog. Building them inside a normal subtree renders them inline.',
    ],
    <String>[
      'CupertinoSegmentedControl rebuilds its child map on every value change.',
      'Pre-compute the children Map<int, Widget> in build (or in a const) so the map is identity-stable across rebuilds.',
    ],
    <String>[
      'CupertinoListSection.insetGrouped expects a grouped background.',
      'Place it on top of CupertinoColors.systemGroupedBackground or a similar tinted canvas; on a plain white scaffold the grouping disappears visually.',
    ],
    <String>[
      'CupertinoTextField does not auto-validate.',
      'Use CupertinoTextFormFieldRow inside a CupertinoFormSection / Form for validator hooks. The bare CupertinoTextField only emits onChanged.',
    ],
    <String>[
      'CupertinoColors.* are mostly CupertinoDynamicColor.',
      'Always resolve via CupertinoDynamicColor.resolve(color, context). A raw `.value` lookup picks the light/base/default slot regardless of appearance.',
    ],
  ];

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Pitfalls & platform-aware switching',
          subtitle: 'Patterns that bite when you mix Cupertino with Material.',
        ),
        const SizedBox(height: 10.0),
        for (final List<String> p in items)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5F2),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: _kAccentOrange.withOpacity(0.35)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(
                  CupertinoIcons.exclamationmark_triangle_fill,
                  size: 18.0,
                  color: _kAccentOrange,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        p[0],
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                          color: _kInk,
                          letterSpacing: -0.1,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        p[1],
                        style: const TextStyle(fontSize: 12.0, color: _kInkSecondary, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// ===========================================================================
// LIVE PREVIEW STRIP
// ===========================================================================
// A small horizontal preview that instantiates a handful of Cupertino
// widgets with disabled callbacks so we have actual class instances in
// the tree, not just text.
Widget _livePreviewCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Inline previews',
          subtitle: 'A few Cupertino widgets rendered with disabled callbacks.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            const CupertinoActivityIndicator(radius: 14.0),
            CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: _kAccent,
              onPressed: null,
              child: const Text('CupertinoButton'),
            ),
            CupertinoButton(
              onPressed: null,
              child: const Text('Borderless button'),
            ),
            const CupertinoSwitch(value: true, onChanged: null),
            const CupertinoSwitch(value: false, onChanged: null),
            SizedBox(
              width: 180.0,
              child: const CupertinoSlider(
                value: 0.5,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            SizedBox(
              width: 200.0,
              child: const CupertinoSearchTextField(
                placeholder: 'Search Cupertino',
                enabled: false,
              ),
            ),
            SizedBox(
              width: 220.0,
              child: const CupertinoTextField(
                placeholder: 'CupertinoTextField',
                enabled: false,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// FOOTER
// ===========================================================================
Widget _footer() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(18.0, 24.0, 18.0, 36.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'End of Cupertino class tour',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            color: _kInkSecondary,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'flutter/cupertino exposes ~30 first-class widgets across 9 categories. '
          'Every Material counterpart has a Cupertino twin except for a few shells '
          '(no Drawer, no FloatingActionButton) and a few indicators.',
          style: const TextStyle(fontSize: 12.0, color: _kInkTertiary, height: 1.45),
        ),
      ],
    ),
  );
}

// ===========================================================================
// ENTRY POINT
// ===========================================================================
// `build(BuildContext context)` is the single function the D4rt runner
// invokes.  It assembles the full poster as a vertical ListView so the
// content is scrollable in the test harness.
dynamic build(BuildContext context) {
  print('Cupertino class tour deep visual demo executing');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  print('  building section 1 - hero intro');
  final Widget heroIntro = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 24.0, 18.0, 8.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF0A84FF), Color(0xFF5E5CE6), Color(0xFFAF52DE)],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          offset: Offset(0.0, 8.0),
          blurRadius: 24.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(CupertinoIcons.square_grid_2x2_fill, color: Color(0xFFFFFFFF), size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'A tour of Cupertino classes',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFFFFF),
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Nine categories, ~30 first-class widgets. Built to feel native on iOS.',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xCCFFFFFF),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final _Category cat in _kCategories)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(999.0),
                  border: Border.all(color: const Color(0x55FFFFFF)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(cat.icon, size: 12.0, color: const Color(0xFFFFFFFF)),
                    const SizedBox(width: 6.0),
                    Text(
                      cat.name,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'This poster groups every top-level Cupertino class into nine families and '
          'shows how they fit together. Section 2 lists the families. Section 3 draws '
          'the inheritance and composition graph. Sections 4-8 zoom into recipes, '
          'comparison with Material, naming conventions and pitfalls.',
          style: TextStyle(
            fontSize: 13.0,
            color: Color(0xE6FFFFFF),
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 - CATEGORY INDEX
  // -------------------------------------------------------------------------
  print('  building section 2 - category index');
  final Widget section2Header = _sectionHeader(
    1,
    'Category index',
    'Nine families, ${_kCategories.fold<int>(0, (int a, _Category c) => a + c.classes.length)} classes covered.',
  );
  final Widget categoryIndex = _categoryIndexCard();

  // -------------------------------------------------------------------------
  // SECTION 3 - HIERARCHY DIAGRAM
  // -------------------------------------------------------------------------
  print('  building section 3 - hierarchy diagram');
  final Widget section3Header = _sectionHeader(
    2,
    'Class hierarchy diagram',
    'Boxes coloured by category. Arrows encode "is a" and "contains".',
  );
  final Widget hierarchy = _hierarchyDiagramCard();

  // -------------------------------------------------------------------------
  // SECTION 4 - CATEGORISED CLASS GRID
  // -------------------------------------------------------------------------
  print('  building section 4 - categorised class grid');
  final Widget section4Header = _sectionHeader(
    3,
    'Categorised class grid',
    'One panel per family, with tinted header and a list of classes.',
  );
  final List<Widget> categoryPanels = <Widget>[
    for (final _Category cat in _kCategories) _categoryPanel(cat),
  ];

  // -------------------------------------------------------------------------
  // SECTION 5 - RECIPE CARDS
  // -------------------------------------------------------------------------
  print('  building section 5 - recipe cards');
  final Widget section5Header = _sectionHeader(
    4,
    'Composition recipes',
    'Four idiomatic ways to wire Cupertino classes together.',
  );

  final Widget recipeApp = _recipeCard(
    title: 'CupertinoApp + CupertinoPageScaffold',
    subtitle: 'The minimal iOS shell. Most apps start here.',
    icon: CupertinoIcons.square_stack_3d_up_fill,
    accent: _kCatAppScaffold,
    lines: const <List<_Tok>>[
      <_Tok>[_Tok.keyword('return '), _Tok.type('CupertinoApp'), _Tok.plain('(')],
      <_Tok>[_Tok.plain('  home: '), _Tok.type('CupertinoPageScaffold'), _Tok.plain('(')],
      <_Tok>[_Tok.plain('    navigationBar: '), _Tok.type('CupertinoNavigationBar'), _Tok.plain('(')],
      <_Tok>[_Tok.plain('      middle: '), _Tok.type('Text'), _Tok.plain('('), _Tok.string("'Home'"), _Tok.plain('),')],
      <_Tok>[_Tok.plain('    ),')],
      <_Tok>[_Tok.plain('    child: '), _Tok.type('SafeArea'), _Tok.plain('(child: '), _Tok.type('Center'), _Tok.plain('(child: '), _Tok.type('Text'), _Tok.plain('('), _Tok.string("'Hello iOS'"), _Tok.plain('))),')],
      <_Tok>[_Tok.plain('  ),')],
      <_Tok>[_Tok.plain(');')],
    ],
  );

  final Widget recipeTabs = _recipeCard(
    title: 'CupertinoTabScaffold + CupertinoTabBar + CupertinoTabView',
    subtitle: 'Tabbed shell where each tab owns its own Navigator.',
    icon: CupertinoIcons.rectangle_3_offgrid_fill,
    accent: _kCatNavigation,
    lines: const <List<_Tok>>[
      <_Tok>[_Tok.type('CupertinoTabScaffold'), _Tok.plain('(')],
      <_Tok>[_Tok.plain('  tabBar: '), _Tok.type('CupertinoTabBar'), _Tok.plain('(')],
      <_Tok>[_Tok.plain('    items: '), _Tok.keyword('const '), _Tok.plain('<'), _Tok.type('BottomNavigationBarItem'), _Tok.plain('>[')],
      <_Tok>[_Tok.plain('      '), _Tok.type('BottomNavigationBarItem'), _Tok.plain('(icon: '), _Tok.type('Icon'), _Tok.plain('('), _Tok.accent('CupertinoIcons.home'), _Tok.plain('), label: '), _Tok.string("'Home'"), _Tok.plain('),')],
      <_Tok>[_Tok.plain('      '), _Tok.type('BottomNavigationBarItem'), _Tok.plain('(icon: '), _Tok.type('Icon'), _Tok.plain('('), _Tok.accent('CupertinoIcons.gear'), _Tok.plain('), label: '), _Tok.string("'Settings'"), _Tok.plain('),')],
      <_Tok>[_Tok.plain('    ],')],
      <_Tok>[_Tok.plain('  ),')],
      <_Tok>[_Tok.plain('  tabBuilder: ('), _Tok.type('BuildContext'), _Tok.plain(' c, '), _Tok.type('int'), _Tok.plain(' i) {')],
      <_Tok>[_Tok.plain('    '), _Tok.keyword('return '), _Tok.type('CupertinoTabView'), _Tok.plain('(builder: (c) => '), _Tok.type('Center'), _Tok.plain('(child: '), _Tok.type('Text'), _Tok.plain('('), _Tok.string("'tab '"), _Tok.plain(' + i.toString()))),')],
      <_Tok>[_Tok.plain('  },')],
      <_Tok>[_Tok.plain(');')],
    ],
  );

  final Widget recipeSheet = _recipeCard(
    title: 'CupertinoActionSheet + CupertinoActionSheetAction',
    subtitle: 'A bottom action sheet surfaced via showCupertinoModalPopup.',
    icon: CupertinoIcons.square_arrow_up,
    accent: _kCatDialogs,
    lines: const <List<_Tok>>[
      <_Tok>[_Tok.comment('// In a button onPressed:')],
      <_Tok>[_Tok.type('showCupertinoModalPopup'), _Tok.plain('<'), _Tok.type('void'), _Tok.plain('>(')],
      <_Tok>[_Tok.plain('  context: context,')],
      <_Tok>[_Tok.plain('  builder: ('), _Tok.type('BuildContext'), _Tok.plain(' c) => '), _Tok.type('CupertinoActionSheet'), _Tok.plain('(')],
      <_Tok>[_Tok.plain('    title: '), _Tok.type('Text'), _Tok.plain('('), _Tok.string("'Pick an option'"), _Tok.plain('),')],
      <_Tok>[_Tok.plain('    actions: <'), _Tok.type('Widget'), _Tok.plain('>[')],
      <_Tok>[_Tok.plain('      '), _Tok.type('CupertinoActionSheetAction'), _Tok.plain('(onPressed: () {}, child: '), _Tok.type('Text'), _Tok.plain('('), _Tok.string("'Save'"), _Tok.plain('))')],
      <_Tok>[_Tok.plain('      '), _Tok.type('CupertinoActionSheetAction'), _Tok.plain('(isDestructiveAction: '), _Tok.keyword('true'), _Tok.plain(', onPressed: () {}, child: '), _Tok.type('Text'), _Tok.plain('('), _Tok.string("'Delete'"), _Tok.plain('))')],
      <_Tok>[_Tok.plain('    ],')],
      <_Tok>[_Tok.plain('    cancelButton: '), _Tok.type('CupertinoActionSheetAction'), _Tok.plain('(onPressed: () {}, child: '), _Tok.type('Text'), _Tok.plain('('), _Tok.string("'Cancel'"), _Tok.plain('))')],
      <_Tok>[_Tok.plain('  ),')],
      <_Tok>[_Tok.plain(');')],
    ],
  );

  final Widget recipeForm = _recipeCard(
    title: 'CupertinoListSection + CupertinoFormSection + Rows',
    subtitle: 'Grouped settings list backed by a form section with form rows.',
    icon: CupertinoIcons.list_bullet_below_rectangle,
    accent: _kCatListsForms,
    lines: const <List<_Tok>>[
      <_Tok>[_Tok.type('CupertinoListSection'), _Tok.plain('.insetGrouped(')],
      <_Tok>[_Tok.plain('  header: '), _Tok.type('Text'), _Tok.plain('('), _Tok.string("'Profile'"), _Tok.plain('),')],
      <_Tok>[_Tok.plain('  children: <'), _Tok.type('Widget'), _Tok.plain('>[')],
      <_Tok>[_Tok.plain('    '), _Tok.type('CupertinoListTile'), _Tok.plain('(title: '), _Tok.type('Text'), _Tok.plain('('), _Tok.string("'Name'"), _Tok.plain('), additionalInfo: '), _Tok.type('Text'), _Tok.plain('('), _Tok.string("'Alex'"), _Tok.plain(')),')],
      <_Tok>[_Tok.plain('    '), _Tok.type('CupertinoFormRow'), _Tok.plain('(prefix: '), _Tok.type('Text'), _Tok.plain('('), _Tok.string("'Email'"), _Tok.plain('), child: '), _Tok.type('CupertinoTextField'), _Tok.plain('(placeholder: '), _Tok.string("'name@host'"), _Tok.plain(')),')],
      <_Tok>[_Tok.plain('    '), _Tok.type('CupertinoFormRow'), _Tok.plain('(prefix: '), _Tok.type('Text'), _Tok.plain('('), _Tok.string("'Notify'"), _Tok.plain('), child: '), _Tok.type('CupertinoSwitch'), _Tok.plain('(value: '), _Tok.keyword('true'), _Tok.plain(', onChanged: (_) {})),')],
      <_Tok>[_Tok.plain('  ],')],
      <_Tok>[_Tok.plain(');')],
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 6 - COMPARISON MATRIX
  // -------------------------------------------------------------------------
  print('  building section 6 - comparison matrix');
  final Widget section6Header = _sectionHeader(
    5,
    'Cupertino vs Material',
    'Cross-platform pairs for design-token mapping.',
  );
  final Widget comparison = _comparisonMatrixCard();

  // -------------------------------------------------------------------------
  // SECTION 7 - NAMING CONVENTIONS
  // -------------------------------------------------------------------------
  print('  building section 7 - naming conventions');
  final Widget section7Header = _sectionHeader(
    6,
    'Naming conventions',
    'Cupertino is a thin Dart projection of UIKit.',
  );
  final Widget naming = _namingConventionsCard();

  // -------------------------------------------------------------------------
  // SECTION 8 - PITFALLS
  // -------------------------------------------------------------------------
  print('  building section 8 - pitfalls');
  final Widget section8Header = _sectionHeader(
    7,
    'Pitfalls',
    'Patterns that bite when you mix Cupertino with Material.',
  );
  final Widget pitfalls = _pitfallsCard();

  // -------------------------------------------------------------------------
  // SECTION 9 - LIVE PREVIEW
  // -------------------------------------------------------------------------
  print('  building section 9 - live preview');
  final Widget section9Header = _sectionHeader(
    8,
    'Inline previews',
    'A handful of Cupertino widgets instantiated with disabled callbacks.',
  );
  final Widget livePreview = _livePreviewCard();

  // -------------------------------------------------------------------------
  // ROOT
  // -------------------------------------------------------------------------
  print('  assembling root container');
  final Widget body = Container(
    color: _kCanvas,
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        heroIntro,
        section2Header,
        categoryIndex,
        _sectionDivider(),
        section3Header,
        hierarchy,
        _sectionDivider(),
        section4Header,
        ...categoryPanels,
        _sectionDivider(),
        section5Header,
        recipeApp,
        recipeTabs,
        recipeSheet,
        recipeForm,
        _sectionDivider(),
        section6Header,
        comparison,
        _sectionDivider(),
        section7Header,
        naming,
        _sectionDivider(),
        section8Header,
        pitfalls,
        _sectionDivider(),
        section9Header,
        livePreview,
        _footer(),
      ],
    ),
  );

  print('Cupertino class tour deep visual demo build complete');
  return Directionality(
    textDirection: TextDirection.ltr,
    child: MediaQuery(
      data: const MediaQueryData(),
      child: body,
    ),
  );
}


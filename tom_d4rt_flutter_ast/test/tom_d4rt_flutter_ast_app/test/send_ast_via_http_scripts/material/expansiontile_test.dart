// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of the Flutter material/ExpansionTile family.
//
// This file is part of the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exports exactly one
// top-level entry point - `dynamic build(BuildContext)` - which the runtime
// invokes a single time. The returned widget tree is then handed straight
// to the host app's renderer.
//
// The rendered output is a long, static gallery that documents Flutter's
// expanding-disclosure widgets in Material design. Seven thematic sections
// cover:
//
//   1. Hero intro - what ExpansionTile is, where it lives, M2 vs M3 styling.
//   2. Parameter anatomy table - every public parameter on ExpansionTile,
//      its type, default, and a short prose explanation.
//   3. Expanded/collapsed states side-by-side - the same tile rendered twice
//      with `initiallyExpanded: false` and `initiallyExpanded: true` to make
//      the visual delta between the two states obvious without runtime
//      toggling.
//   4. M3 theming panel - `ExpansionTileTheme` wrapping a stack of tiles
//      using a shared `ExpansionTileThemeData` (backgroundColor,
//      collapsedBackgroundColor, textColor, collapsedTextColor, iconColor,
//      collapsedIconColor, shape, collapsedShape, tilePadding,
//      expandedAlignment, expandedCrossAxisAlignment, childrenPadding,
//      clipBehavior).
//   5. ExpansionTile vs ExpansionPanelList comparison - a two-column table
//      laying out every observable difference (parent widget, list model,
//      radio mode, icon position, control affinity, theming surface,
//      animation control, controller availability).
//   6. Recipe cards - six idiomatic recipes drawn from the framework's
//      own samples (settings group, FAQ list, nested forms, attached
//      ExpansionTileController, controlAffinity flip, radio panel list).
//   7. Pitfalls panel - six callouts (maintainState memory cost, controller
//      lifecycle, radio + maintainState interaction, shape vs collapsedShape
//      missing, children's padding double-up, controlAffinity vs leading).
//
// Build-time discipline: no `setState`, no `Timer`, no `Future`, no
// `AnimationController`, no `Stream`. Tiles are constructed with
// `initiallyExpanded: true` or `false` and never toggled at build time.
// `ExpansionTileController` is constructed but never has `expand()` or
// `collapse()` invoked because `build` runs exactly once and there is no
// live element tree that would safely accept the imperative call.
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// We pick literal ARGB values so the demo is theme-independent. The palette
// borrows from Material's "indigo on porcelain" mood since ExpansionTile is
// part of the cross-platform Material layer.
const Color _kCanvas = Color(0xFFF4F5F8);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardSoft = Color(0xFFF8F9FC);
const Color _kCardDark = Color(0xFF1B1D2A);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1A1C25);
const Color _kInkSecondary = Color(0xFF424657);
const Color _kInkTertiary = Color(0xFF8C90A1);
const Color _kInkOnDark = Color(0xFFEDEEF5);
const Color _kInkOnDarkSecondary = Color(0xFFA3A6B8);
const Color _kAccent = Color(0xFF4F46E5); // indigo
const Color _kAccentSoft = Color(0xFFEEF2FF);
const Color _kAccentBlue = Color(0xFF2563EB);
const Color _kAccentBlueSoft = Color(0xFFDBEAFE);
const Color _kAccentTeal = Color(0xFF14B8A6);
const Color _kAccentTealSoft = Color(0xFFCCFBF1);
const Color _kAccentGreen = Color(0xFF22C55E);
const Color _kAccentGreenSoft = Color(0xFFDCFCE7);
const Color _kAccentAmber = Color(0xFFF59E0B);
const Color _kAccentAmberSoft = Color(0xFFFEF3C7);
const Color _kAccentRose = Color(0xFFE11D48);
const Color _kAccentRoseSoft = Color(0xFFFFE4E6);
const Color _kAccentViolet = Color(0xFF8B5CF6);
const Color _kAccentVioletSoft = Color(0xFFEDE9FE);
const Color _kAccentOrange = Color(0xFFF97316);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);

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
const TextStyle _kBodySoftStyle = TextStyle(
  fontSize: 13.0,
  height: 1.4,
  color: _kInkSecondary,
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.45,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const TextStyle _kMonoInlineStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kInk,
  height: 1.3,
);
const TextStyle _kPillStyle = TextStyle(
  fontSize: 11.5,
  fontWeight: FontWeight.w600,
  color: _kAccent,
  letterSpacing: 0.2,
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);

// ---------------------------------------------------------------------------
// PRIVATE BUILDER HELPERS
// ---------------------------------------------------------------------------
// Helpers are top-level private functions returning Widgets. They are kept
// out of StatelessWidget subclasses so the file can be read top-to-bottom.

Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 30.0,
      bottom: 12.0,
      left: 18.0,
      right: 18.0,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38.0,
          height: 38.0,
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

Widget _card({
  required Widget child,
  Color background = _kCardBg,
  EdgeInsets padding = _kCardPadding,
  EdgeInsets margin = const EdgeInsets.symmetric(
    horizontal: 18.0,
    vertical: 6.0,
  ),
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

Widget _darkCard({required Widget child, EdgeInsets padding = _kCardPadding}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
    padding: padding,
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: child,
  );
}

Widget _pill(String label, {Color color = _kAccent, Color? bg}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg ?? _kAccentSoft,
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: color.withOpacity(0.18)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.2,
      ),
    ),
  );
}

Widget _kvRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 150.0,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              color: _kInkTertiary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              color: valueColor ?? _kInk,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bullet(String text, {Color dot = _kAccent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 6.0, right: 10.0),
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
        ),
        Expanded(child: Text(text, style: _kBodyStyle)),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(code, style: _kCodeStyle),
  );
}

Widget _label(String text, {Color color = _kInkTertiary}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.1,
      color: color,
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 - HERO INTRO
// ---------------------------------------------------------------------------

Widget _heroSection() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 6.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF4F46E5), Color(0xFF7C3AED)],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          offset: Offset(0.0, 4.0),
          blurRadius: 16.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'material',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                  fontSize: 11.0,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'disclosure',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                  fontSize: 11.0,
                  letterSpacing: 1.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'ExpansionTile family',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'A single-tile disclosure widget plus its panel-list cousin. '
          'ExpansionTile exposes 24+ parameters and is themed through '
          'ExpansionTileTheme/ExpansionTileThemeData. ExpansionPanelList '
          'offers the same idea as a controlled accordion, with a radio '
          'mode (ExpansionPanelList.radio) that enforces "one open at a '
          'time" semantics.',
          style: TextStyle(
            color: Color(0xFFEDEEFF),
            fontSize: 14.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(0x22FFFFFF),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'parameters covered',
                      style: TextStyle(
                        color: Color(0xFFEDEEFF),
                        fontSize: 11.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '24',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 28.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(0x22FFFFFF),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'related classes',
                      style: TextStyle(
                        color: Color(0xFFEDEEFF),
                        fontSize: 11.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '7',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 28.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: const Color(0x22FFFFFF),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'sections',
                      style: TextStyle(
                        color: Color(0xFFEDEEFF),
                        fontSize: 11.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '7',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 28.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 - PARAMETER ANATOMY TABLE
// ---------------------------------------------------------------------------

Widget _parameterRow(
  String name,
  String type,
  String defaultValue,
  String description, {
  Color accent = _kAccent,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: _kHairline)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontSize: 13.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                type,
                style: const TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: _kInkTertiary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            defaultValue,
            style: const TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 12.5,
              color: _kInk,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _parameterAnatomy() {
  return _card(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 6.0),
          child: Row(
            children: <Widget>[
              const Expanded(
                flex: 3,
                child: Text(
                  'parameter',
                  style: TextStyle(
                    fontSize: 11.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                    color: _kInkTertiary,
                  ),
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  'default',
                  style: TextStyle(
                    fontSize: 11.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                    color: _kInkTertiary,
                  ),
                ),
              ),
              const Expanded(
                flex: 6,
                child: Text(
                  'role',
                  style: TextStyle(
                    fontSize: 11.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                    color: _kInkTertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
        _parameterRow(
          'title',
          'Widget',
          'required',
          'Primary content of the closed header. Rendered as the ListTile '
              'title slot. Wrap in DefaultTextStyle if you need custom typography.',
        ),
        _parameterRow(
          'subtitle',
          'Widget?',
          'null',
          'Secondary text shown below the title. Forwarded to ListTile.subtitle.',
          accent: _kAccentBlue,
        ),
        _parameterRow(
          'leading',
          'Widget?',
          'null',
          'Optional widget shown before the title. Mutually paired with '
              'controlAffinity to decide where the disclosure chevron lives.',
          accent: _kAccentTeal,
        ),
        _parameterRow(
          'trailing',
          'Widget?',
          'rotating chevron',
          'Defaults to a rotating expand_more icon. Supplying a custom widget '
              'replaces the chevron and disables its built-in rotation tween.',
          accent: _kAccentTeal,
        ),
        _parameterRow(
          'children',
          'List<Widget>',
          'const <Widget>[]',
          'Widgets revealed when the tile expands. They live inside a Column '
              'whose alignment is controlled by expandedCrossAxisAlignment.',
          accent: _kAccentGreen,
        ),
        _parameterRow(
          'initiallyExpanded',
          'bool',
          'false',
          'Sets the starting expansion state for the first frame. Subsequent '
              'changes are owned by the tile (or its controller).',
          accent: _kAccentAmber,
        ),
        _parameterRow(
          'maintainState',
          'bool',
          'false',
          'When true, children stay in the tree (Offstage-style) when '
              'collapsed so their State and scroll positions survive.',
          accent: _kAccentAmber,
        ),
        _parameterRow(
          'tilePadding',
          'EdgeInsetsGeometry?',
          'null (= ListTile default)',
          'Inset around the closed header row. Falls through to theme value '
              'then to a 16px horizontal default.',
        ),
        _parameterRow(
          'expandedCrossAxisAlignment',
          'CrossAxisAlignment?',
          'CrossAxisAlignment.center',
          'How children are aligned on the cross axis once the body is open. '
              'Used by the Column that hosts children.',
        ),
        _parameterRow(
          'expandedAlignment',
          'AlignmentGeometry?',
          'Alignment.center',
          'Where the body Column sits inside the available width. Pairs with '
              'expandedCrossAxisAlignment which controls child cross-axis.',
        ),
        _parameterRow(
          'childrenPadding',
          'EdgeInsetsGeometry?',
          'null',
          'Padding applied around the expanded children Column. Easier than '
              'wrapping each child in Padding individually.',
        ),
        _parameterRow(
          'backgroundColor',
          'Color?',
          'null',
          'Background colour used in the expanded state. Animated to/from '
              'collapsedBackgroundColor during the open/close transition.',
          accent: _kAccentViolet,
        ),
        _parameterRow(
          'collapsedBackgroundColor',
          'Color?',
          'null',
          'Background colour used in the collapsed state. Falls through to '
              'theme then to transparent.',
          accent: _kAccentViolet,
        ),
        _parameterRow(
          'textColor',
          'Color?',
          'null',
          'Text colour for title/subtitle while expanded. Theme uses M3 '
              'colorScheme.primary by default.',
          accent: _kAccentRose,
        ),
        _parameterRow(
          'collapsedTextColor',
          'Color?',
          'null',
          'Text colour for title/subtitle while collapsed.',
          accent: _kAccentRose,
        ),
        _parameterRow(
          'iconColor',
          'Color?',
          'null',
          'Colour of the expand chevron and any leading icon while expanded.',
          accent: _kAccentRose,
        ),
        _parameterRow(
          'collapsedIconColor',
          'Color?',
          'null',
          'Colour of the expand chevron and any leading icon while collapsed.',
          accent: _kAccentRose,
        ),
        _parameterRow(
          'shape',
          'ShapeBorder?',
          'rectangle, no border',
          'Outer shape while expanded. Animated with the open/close tween.',
        ),
        _parameterRow(
          'collapsedShape',
          'ShapeBorder?',
          'rectangle, no border',
          'Outer shape while collapsed. Often set together with shape so the '
              'tile can morph between rounded and flat.',
        ),
        _parameterRow(
          'clipBehavior',
          'Clip?',
          'Clip.none',
          'Forwarded to the Material whose decoration draws shape/background.',
        ),
        _parameterRow(
          'controlAffinity',
          'ListTileControlAffinity?',
          'platform',
          'Where the disclosure chevron lives: leading, trailing, or platform '
              'default. Flipping to leading swaps places with the leading widget.',
          accent: _kAccentOrange,
        ),
        _parameterRow(
          'controller',
          'ExpansionTileController?',
          'null (internal)',
          'Imperative handle that lets callers expand/collapse and read the '
              'open state from outside the tile.',
          accent: _kAccentOrange,
        ),
        _parameterRow(
          'onExpansionChanged',
          'ValueChanged<bool>?',
          'null',
          'Called with the new expansion state after each toggle. Use to '
              'persist the open state to a controller or storage.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 - EXPANDED / COLLAPSED SIDE-BY-SIDE
// ---------------------------------------------------------------------------

Widget _sideBySideTile({
  required String label,
  required bool expanded,
  required Color accent,
}) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: _kCardSoft,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kHairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(label, style: _kCaptionStyle),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: _kHairline),
            ),
            child: Theme(
              data: ThemeData(
                useMaterial3: true,
                dividerColor: const Color(0x00000000),
                colorScheme: ColorScheme.fromSeed(
                  seedColor: accent,
                  brightness: Brightness.light,
                ),
              ),
              child: Material(
              type: MaterialType.transparency,
              child: ExpansionTile(
                key: ValueKey<String>('demo3-$label'),
                initiallyExpanded: expanded,
                title: const Text(
                  'Notifications',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: const Text('Frequency, channels, quiet hours'),
                leading: const Icon(Icons.notifications_active_outlined),
                tilePadding: const EdgeInsets.symmetric(horizontal: 14.0),
                childrenPadding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 4.0,
                ),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                expandedAlignment: Alignment.centerLeft,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                collapsedShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                children: <Widget>[
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.email_outlined, size: 18.0),
                    title: const Text('Email digests'),
                    trailing: Switch(value: true, onChanged: (bool _) {}),
                  ),
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.push_pin_outlined, size: 18.0),
                    title: const Text('Push notifications'),
                    trailing: Switch(value: false, onChanged: (bool _) {}),
                  ),
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.nights_stay_outlined, size: 18.0),
                    title: const Text('Quiet hours 22:00–07:00'),
                    trailing: Switch(value: true, onChanged: (bool _) {}),
                  ),
                ],
              ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _sideBySideStates() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('static state comparison', style: _kPillStyle),
        const SizedBox(height: 4.0),
        const Text(
          'Same parameter set, two values of initiallyExpanded',
          style: _kSubtitleStyle,
        ),
        const SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _sideBySideTile(
              label: 'initiallyExpanded: false',
              expanded: false,
              accent: _kAccentBlue,
            ),
            const SizedBox(width: 12.0),
            _sideBySideTile(
              label: 'initiallyExpanded: true',
              expanded: true,
              accent: _kAccentGreen,
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Notes: the only difference between the two tiles is the value '
            'of initiallyExpanded. Background, text colour and icon colour '
            'are theme-driven via colorScheme.primary, which is why the '
            'expanded tile picks up the accent tint on its header. Because '
            'build() runs exactly once, neither tile will animate at runtime.',
            style: _kBodySoftStyle,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 - M3 THEMING PANEL
// ---------------------------------------------------------------------------

Widget _themedRow({
  required String label,
  required ExpansionTileThemeData themeData,
  required bool expanded,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 6.0),
          child: Text(label, style: _kCaptionStyle),
        ),
        ExpansionTileTheme(
          data: themeData,
          child: Material(
          type: MaterialType.transparency,
          child: ExpansionTile(
            key: ValueKey<String>('demo4-$label'),
            initiallyExpanded: expanded,
            title: const Text(
              'Storage usage',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text('48.2 GB of 64 GB used'),
            leading: const Icon(Icons.sd_storage_outlined),
            children: const <Widget>[
              ListTile(
                dense: true,
                leading: Icon(Icons.photo_library_outlined, size: 18.0),
                title: Text('Photos & Video'),
                trailing: Text('21.4 GB'),
              ),
              ListTile(
                dense: true,
                leading: Icon(Icons.music_note_outlined, size: 18.0),
                title: Text('Music'),
                trailing: Text('14.2 GB'),
              ),
              ListTile(
                dense: true,
                leading: Icon(Icons.apps_outlined, size: 18.0),
                title: Text('Applications'),
                trailing: Text('8.6 GB'),
              ),
            ],
          ),
          ),
        ),
      ],
    ),
  );
}

Widget _themingPanel() {
  // Theme A - soft indigo wash with rounded corners.
  final ExpansionTileThemeData softIndigo = ExpansionTileThemeData(
    backgroundColor: _kAccentSoft,
    collapsedBackgroundColor: _kCardBg,
    textColor: _kAccent,
    collapsedTextColor: _kInk,
    iconColor: _kAccent,
    collapsedIconColor: _kInkTertiary,
    tilePadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    childrenPadding: const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 6.0,
    ),
    expandedAlignment: Alignment.centerLeft,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
      side: BorderSide(color: Color(0xFFC7D2FE)),
    ),
    collapsedShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
      side: BorderSide(color: _kHairline),
    ),
    clipBehavior: Clip.antiAlias,
  );

  // Theme B - flat outlined card with no rounding.
  final ExpansionTileThemeData flatOutline = ExpansionTileThemeData(
    backgroundColor: _kCardSoft,
    collapsedBackgroundColor: _kCardBg,
    textColor: _kAccentTeal,
    collapsedTextColor: _kInkSecondary,
    iconColor: _kAccentTeal,
    collapsedIconColor: _kInkTertiary,
    tilePadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
    childrenPadding: const EdgeInsets.symmetric(
      horizontal: 18.0,
      vertical: 10.0,
    ),
    expandedAlignment: Alignment.centerLeft,
    shape: const RoundedRectangleBorder(
      side: BorderSide(color: _kAccentTeal),
    ),
    collapsedShape: const RoundedRectangleBorder(
      side: BorderSide(color: _kHairline),
    ),
    clipBehavior: Clip.hardEdge,
  );

  // Theme C - high contrast filled tile with explicit dividers off.
  final ExpansionTileThemeData filledCardish = ExpansionTileThemeData(
    backgroundColor: const Color(0xFFFFF7ED),
    collapsedBackgroundColor: const Color(0xFFFFF7ED),
    textColor: _kAccentOrange,
    collapsedTextColor: _kAccentOrange,
    iconColor: _kAccentOrange,
    collapsedIconColor: _kAccentOrange,
    tilePadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    childrenPadding: const EdgeInsets.all(14.0),
    expandedAlignment: Alignment.centerLeft,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      side: BorderSide(color: Color(0xFFFED7AA)),
    ),
    collapsedShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      side: BorderSide(color: Color(0xFFFED7AA)),
    ),
    clipBehavior: Clip.antiAlias,
  );

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('ExpansionTileTheme / ThemeData', style: _kPillStyle),
        const SizedBox(height: 4.0),
        const Text(
          'Three flavours of the same tile, themed externally',
          style: _kSubtitleStyle,
        ),
        const SizedBox(height: 14.0),
        Theme(
          data: ThemeData(
            useMaterial3: true,
            dividerColor: const Color(0x00000000),
          ),
          child: Column(
            children: <Widget>[
              _themedRow(
                label: 'soft indigo (expanded)',
                themeData: softIndigo,
                expanded: true,
              ),
              _themedRow(
                label: 'flat outline (collapsed)',
                themeData: flatOutline,
                expanded: false,
              ),
              _themedRow(
                label: 'filled cardish (expanded)',
                themeData: filledCardish,
                expanded: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kAccentTealSoft,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'ExpansionTileThemeData carries 12 paint-related fields plus '
            'layout fields. When a tile reads a value (say textColor), the '
            'lookup walks: explicit parameter → nearest ExpansionTileTheme → '
            'global ExpansionTileTheme on ThemeData → tile default. This '
            'lets you swap an entire visual treatment in one place.',
            style: _kBodySoftStyle,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 - EXPANSIONTILE VS EXPANSIONPANELLIST COMPARISON
// ---------------------------------------------------------------------------

Widget _compareRow(String axis, String tile, String panelList) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: _kHairline)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            axis,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(tile, style: _kBodyStyle),
        ),
        Expanded(
          flex: 5,
          child: Text(
            panelList,
            style: _kBodyStyle,
          ),
        ),
      ],
    ),
  );
}

Widget _comparePanel() {
  return _card(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
          child: Text('ExpansionTile vs ExpansionPanelList', style: _kPillStyle),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 10.0),
          child: Text(
            'A side-by-side table of every observable difference',
            style: _kSubtitleStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: _kHairline)),
          ),
          child: Row(
            children: const <Widget>[
              Expanded(
                flex: 3,
                child: Text(
                  'axis',
                  style: TextStyle(
                    fontSize: 11.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                    color: _kInkTertiary,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  'ExpansionTile',
                  style: TextStyle(
                    fontSize: 11.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                    color: _kAccent,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  'ExpansionPanelList',
                  style: TextStyle(
                    fontSize: 11.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                    color: _kAccentRose,
                  ),
                ),
              ),
            ],
          ),
        ),
        _compareRow(
          'unit of work',
          'A single tile widget. Lots of these can be stacked in a Column.',
          'A list-shaped panel container holding many ExpansionPanel models.',
        ),
        _compareRow(
          'children type',
          'List<Widget> children — built ahead of time, owned by the tile.',
          'List<ExpansionPanel> children — body builders are deferred.',
        ),
        _compareRow(
          'expansion model',
          'Owned by the tile itself (or by an external ExpansionTileController).',
          'Owned by the caller via ExpansionPanel.isExpanded fields; the list '
              'fires expansionCallback on toggle.',
        ),
        _compareRow(
          'one-open-at-a-time',
          'Not built in. You implement it manually by managing controllers.',
          'Use ExpansionPanelList.radio so the list enforces the single-open '
              'invariant for you.',
        ),
        _compareRow(
          'header builder',
          'Single title widget per tile, plus optional subtitle/leading/trailing.',
          'Per-panel headerBuilder(BuildContext, bool isExpanded) callback.',
        ),
        _compareRow(
          'icon position',
          'Configurable via controlAffinity (leading/trailing/platform).',
          'Always trailing — the disclosure icon is the panel list\'s own widget.',
        ),
        _compareRow(
          'theming surface',
          'ExpansionTileTheme + ExpansionTileThemeData (M3 style).',
          'Direct parameters on ExpansionPanelList (elevation, dividerColor, '
              'expandIconColor, expandedHeaderPadding, materialGapSize).',
        ),
        _compareRow(
          'shape control',
          'shape + collapsedShape (animated).',
          'Each ExpansionPanel can carry a backgroundColor; shape is fixed.',
        ),
        _compareRow(
          'animation',
          'Built-in 200ms expand tween with rotating chevron.',
          '200ms tween per panel with a Material elevation pulse on open.',
        ),
        _compareRow(
          'controller',
          'ExpansionTileController for imperative expand/collapse.',
          'No controller — callers mutate isExpanded on the model directly.',
        ),
        _compareRow(
          'typical use',
          'Settings groups, FAQ rows, nested forms, single disclosure.',
          'Accordion menus, "details sections" with one open at a time.',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 - RECIPE CARDS
// ---------------------------------------------------------------------------

Widget _recipeShell({
  required String tag,
  required String title,
  required String description,
  required Widget preview,
  required String code,
  Color accent = _kAccent,
}) {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.10),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                tag,
                style: TextStyle(
                  fontSize: 10.5,
                  letterSpacing: 1.2,
                  color: accent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(description, style: _kBodyStyle),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: preview,
        ),
        const SizedBox(height: 14.0),
        _codeBlock(code),
      ],
    ),
  );
}

Widget _recipeSettingsGroup() {
  final Widget preview = Theme(
    data: ThemeData(
      useMaterial3: true,
      dividerColor: const Color(0x00000000),
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccent),
    ),
    child: Material(
    type: MaterialType.transparency,
    child: ExpansionTile(
      key: const ValueKey<String>('recipe-settings'),
      initiallyExpanded: true,
      title: const Text(
        'Account',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: const Text('Signed in as alex@example.com'),
      leading: const Icon(Icons.person_outline),
      trailing: const Icon(Icons.keyboard_arrow_down),
      childrenPadding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 4.0,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      collapsedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      children: const <Widget>[
        ListTile(
          dense: true,
          leading: Icon(Icons.email_outlined),
          title: Text('Change email'),
          trailing: Icon(Icons.chevron_right, size: 18.0),
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.lock_outline),
          title: Text('Change password'),
          trailing: Icon(Icons.chevron_right, size: 18.0),
        ),
        ListTile(
          dense: true,
          leading: Icon(Icons.logout),
          title: Text('Sign out'),
          trailing: Icon(Icons.chevron_right, size: 18.0),
        ),
      ],
    ),
    ),
  );
  return _recipeShell(
    tag: 'RECIPE 01',
    title: 'Settings group',
    description:
        'Group a handful of related ListTile rows under one disclosure. '
        'initiallyExpanded keeps the most-used group open by default.',
    preview: preview,
    accent: _kAccent,
    code: 'ExpansionTile(\n'
        '  initiallyExpanded: true,\n'
        '  leading: const Icon(Icons.person_outline),\n'
        "  title: const Text('Account'),\n"
        "  subtitle: const Text('Signed in as alex@example.com'),\n"
        '  childrenPadding: const EdgeInsets.symmetric(\n'
        '    horizontal: 14, vertical: 4,\n'
        '  ),\n'
        '  shape: const RoundedRectangleBorder(\n'
        '    borderRadius: BorderRadius.all(Radius.circular(12)),\n'
        '  ),\n'
        '  collapsedShape: const RoundedRectangleBorder(\n'
        '    borderRadius: BorderRadius.all(Radius.circular(12)),\n'
        '  ),\n'
        '  children: <Widget>[ ...ListTile rows... ],\n'
        ');',
  );
}

Widget _recipeFaqList() {
  final Widget preview = Theme(
    data: ThemeData(
      useMaterial3: true,
      dividerColor: const Color(0x00000000),
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccentTeal),
    ),
    child: Column(
      children: const <Widget>[
        Material(
          type: MaterialType.transparency,
          child: ExpansionTile(
          key: ValueKey<String>('recipe-faq-1'),
          initiallyExpanded: false,
          tilePadding: EdgeInsets.symmetric(horizontal: 14.0),
          title: Text(
            'How do I reset my password?',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 14.0),
              child: Text(
                'Tap "Sign in", then "Forgot password" on the email screen. '
                'A one-time reset link will be sent to your verified email.',
              ),
            ),
          ],
        ),
        ),
        Divider(height: 0.0),
        Material(
          type: MaterialType.transparency,
          child: ExpansionTile(
          key: ValueKey<String>('recipe-faq-2'),
          initiallyExpanded: true,
          tilePadding: EdgeInsets.symmetric(horizontal: 14.0),
          title: Text(
            'Can I use the app offline?',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 14.0),
              child: Text(
                'Yes. The most recently opened entries are cached locally. '
                'New writes are queued and synced as soon as connectivity '
                'returns.',
              ),
            ),
          ],
        ),
        ),
      ],
    ),
  );
  return _recipeShell(
    tag: 'RECIPE 02',
    title: 'FAQ list',
    description:
        'A vertical stack of independent tiles. Each tile owns its own '
        'expansion state — no coordination between them.',
    preview: preview,
    accent: _kAccentTeal,
    code: 'Column(\n'
        '  children: <Widget>[\n'
        '    for (final QuestionAnswer qa in items)\n'
        '      ExpansionTile(\n'
        '        title: Text(qa.question),\n'
        '        initiallyExpanded: qa.expanded,\n'
        '        children: <Widget>[\n'
        '          Padding(\n'
        '            padding: const EdgeInsets.all(14),\n'
        '            child: Text(qa.answer),\n'
        '          ),\n'
        '        ],\n'
        '      ),\n'
        '  ],\n'
        ');',
  );
}

Widget _recipeNestedForm() {
  final Widget preview = Theme(
    data: ThemeData(
      useMaterial3: true,
      dividerColor: const Color(0x00000000),
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccentGreen),
    ),
    child: Material(
    type: MaterialType.transparency,
    child: ExpansionTile(
      key: const ValueKey<String>('recipe-form'),
      initiallyExpanded: true,
      title: const Text(
        'Shipping address',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      leading: const Icon(Icons.local_shipping_outlined),
      childrenPadding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 14.0),
      maintainState: true,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        side: BorderSide(color: _kHairline),
      ),
      collapsedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        side: BorderSide(color: _kHairline),
      ),
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: 'Recipient',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            isDense: true,
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          decoration: InputDecoration(
            labelText: 'Street',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            isDense: true,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Zip',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    ),
  );
  return _recipeShell(
    tag: 'RECIPE 03',
    title: 'Nested form with maintainState',
    description:
        'A multi-field form lives inside the tile. Setting maintainState: '
        'true keeps the text field State alive when the tile is closed, so '
        'half-typed input survives collapse.',
    preview: preview,
    accent: _kAccentGreen,
    code: 'ExpansionTile(\n'
        '  initiallyExpanded: true,\n'
        '  maintainState: true,  // keep TextField state alive\n'
        '  leading: const Icon(Icons.local_shipping_outlined),\n'
        "  title: const Text('Shipping address'),\n"
        '  expandedCrossAxisAlignment: CrossAxisAlignment.start,\n'
        '  childrenPadding: const EdgeInsets.all(14),\n'
        '  children: <Widget>[\n'
        '    TextField(decoration: InputDecoration(labelText: ...)),\n'
        '    TextField(decoration: InputDecoration(labelText: ...)),\n'
        '    Row(children: <Widget>[ Expanded(...), Expanded(...) ]),\n'
        '  ],\n'
        ');',
  );
}

Widget _recipeController() {
  // Construct a controller but never call expand()/collapse() at build time.
  final ExpansionTileController controller = ExpansionTileController();
  final Widget preview = Theme(
    data: ThemeData(
      useMaterial3: true,
      dividerColor: const Color(0x00000000),
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccentViolet),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Material(
          type: MaterialType.transparency,
          child: ExpansionTile(
          key: const ValueKey<String>('recipe-controller'),
          controller: controller,
          initiallyExpanded: true,
          title: const Text(
            'Advanced search',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: const Icon(Icons.tune_outlined),
          children: const <Widget>[
            ListTile(
              dense: true,
              leading: Icon(Icons.calendar_today_outlined, size: 18.0),
              title: Text('Date range'),
              trailing: Text('Last 30 days'),
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.label_outline, size: 18.0),
              title: Text('Tags'),
              trailing: Text('billing, urgent'),
            ),
            ListTile(
              dense: true,
              leading: Icon(Icons.attach_money_outlined, size: 18.0),
              title: Text('Amount'),
              trailing: Text('> 100'),
            ),
          ],
        ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.expand_more),
                label: const Text('expand()'),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.expand_less),
                label: const Text('collapse()'),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  return _recipeShell(
    tag: 'RECIPE 04',
    title: 'ExpansionTileController',
    description:
        'Attach an ExpansionTileController to drive the tile from outside. '
        'controller.expand(), controller.collapse() and controller.isExpanded '
        'are the three public surface methods.',
    preview: preview,
    accent: _kAccentViolet,
    code: 'final ExpansionTileController controller =\n'
        '    ExpansionTileController();\n'
        '\n'
        'ExpansionTile(\n'
        '  controller: controller,\n'
        '  initiallyExpanded: true,\n'
        '  leading: const Icon(Icons.tune_outlined),\n'
        "  title: const Text('Advanced search'),\n"
        '  children: <Widget>[ ... ],\n'
        ');\n'
        '\n'
        '// Later, from outside the tile:\n'
        'controller.collapse();\n'
        'final bool open = controller.isExpanded;\n'
        'controller.expand();',
  );
}

Widget _recipeControlAffinity() {
  final Widget preview = Theme(
    data: ThemeData(
      useMaterial3: true,
      dividerColor: const Color(0x00000000),
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccentAmber),
    ),
    child: Column(
      children: const <Widget>[
        Material(
          type: MaterialType.transparency,
          child: ExpansionTile(
          key: ValueKey<String>('recipe-affinity-trailing'),
          initiallyExpanded: false,
          controlAffinity: ListTileControlAffinity.trailing,
          leading: Icon(Icons.folder_outlined),
          title: Text(
            'controlAffinity: trailing (default)',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text('Chevron sits on the right, leading is the folder.'),
          children: <Widget>[
            ListTile(dense: true, title: Text('drafts/')),
            ListTile(dense: true, title: Text('archived/')),
          ],
        ),
        ),
        Divider(height: 1.0),
        Material(
          type: MaterialType.transparency,
          child: ExpansionTile(
          key: ValueKey<String>('recipe-affinity-leading'),
          initiallyExpanded: true,
          controlAffinity: ListTileControlAffinity.leading,
          leading: Icon(Icons.folder_outlined),
          title: Text(
            'controlAffinity: leading',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text('Chevron jumps to the left, leading is ignored.'),
          children: <Widget>[
            ListTile(dense: true, title: Text('drafts/')),
            ListTile(dense: true, title: Text('archived/')),
          ],
        ),
        ),
      ],
    ),
  );
  return _recipeShell(
    tag: 'RECIPE 05',
    title: 'controlAffinity flip',
    description:
        'controlAffinity decides where the rotating chevron sits. Setting '
        'leading replaces the slot otherwise used by your leading widget — '
        'be aware: leading is silently dropped in that case.',
    preview: preview,
    accent: _kAccentAmber,
    code: '// Default — chevron on the right, leading folder icon on the left:\n'
        'ExpansionTile(\n'
        '  controlAffinity: ListTileControlAffinity.trailing,\n'
        '  leading: const Icon(Icons.folder_outlined),\n'
        "  title: const Text('Folders'),\n"
        '  children: <Widget>[ ... ],\n'
        ');\n'
        '\n'
        '// Chevron on the left — folder icon is no longer rendered:\n'
        'ExpansionTile(\n'
        '  controlAffinity: ListTileControlAffinity.leading,\n'
        '  leading: const Icon(Icons.folder_outlined),  // unused now\n'
        "  title: const Text('Folders'),\n"
        '  children: <Widget>[ ... ],\n'
        ');',
  );
}

Widget _recipePanelList() {
  final List<bool> stateA = <bool>[true, false, false];
  final List<bool> stateB = <bool>[false, true, false];

  final Widget normalPanelList = ExpansionPanelList(
    expansionCallback: (int i, bool open) {},
    elevation: 1.0,
    expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 6.0),
    materialGapSize: 8.0,
    dividerColor: _kHairline,
    children: <ExpansionPanel>[
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: stateA[0],
        backgroundColor: _kCardBg,
        headerBuilder: (BuildContext _, bool isOpen) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 12.0,
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.payment_outlined, size: 18.0),
              const SizedBox(width: 10.0),
              Text(
                'Payment method',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isOpen ? _kAccent : _kInk,
                ),
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: ListTile(
            dense: true,
            leading: Icon(Icons.credit_card_outlined),
            title: Text('Visa •••• 4242'),
            subtitle: Text('Expires 09/27'),
          ),
        ),
      ),
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: stateA[1],
        backgroundColor: _kCardBg,
        headerBuilder: (BuildContext _, bool isOpen) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 12.0,
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.local_shipping_outlined, size: 18.0),
              const SizedBox(width: 10.0),
              Text(
                'Shipping',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isOpen ? _kAccent : _kInk,
                ),
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: ListTile(
            dense: true,
            leading: Icon(Icons.location_on_outlined),
            title: Text('221B Baker Street'),
            subtitle: Text('London, UK'),
          ),
        ),
      ),
      ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: stateA[2],
        backgroundColor: _kCardBg,
        headerBuilder: (BuildContext _, bool isOpen) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 12.0,
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.receipt_long_outlined, size: 18.0),
              const SizedBox(width: 10.0),
              Text(
                'Review',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isOpen ? _kAccent : _kInk,
                ),
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: ListTile(
            dense: true,
            leading: Icon(Icons.shopping_bag_outlined),
            title: Text('Cart total'),
            trailing: Text(
              r'$48.92',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    ],
  );

  final Widget radioPanelList = ExpansionPanelList.radio(
    expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 6.0),
    elevation: 1.0,
    dividerColor: _kHairline,
    initialOpenPanelValue: 'shipping',
    children: <ExpansionPanelRadio>[
      ExpansionPanelRadio(
        value: 'payment',
        canTapOnHeader: true,
        backgroundColor: _kCardBg,
        headerBuilder: (BuildContext _, bool isOpen) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 12.0,
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.payment_outlined, size: 18.0),
              const SizedBox(width: 10.0),
              Text(
                'Payment',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isOpen ? _kAccentRose : _kInk,
                ),
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: Text(
            'Closed because shipping is the open panel.',
            style: _kBodySoftStyle,
          ),
        ),
      ),
      ExpansionPanelRadio(
        value: 'shipping',
        canTapOnHeader: true,
        backgroundColor: _kCardBg,
        headerBuilder: (BuildContext _, bool isOpen) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 12.0,
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.local_shipping_outlined, size: 18.0),
              const SizedBox(width: 10.0),
              Text(
                'Shipping',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isOpen ? _kAccentRose : _kInk,
                ),
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: Text(
            'Open. Tapping any other header would auto-close this one.',
            style: _kBodySoftStyle,
          ),
        ),
      ),
      ExpansionPanelRadio(
        value: 'review',
        canTapOnHeader: true,
        backgroundColor: _kCardBg,
        headerBuilder: (BuildContext _, bool isOpen) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 12.0,
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.receipt_long_outlined, size: 18.0),
              const SizedBox(width: 10.0),
              Text(
                'Review',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isOpen ? _kAccentRose : _kInk,
                ),
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: Text(
            'Closed because shipping is the open panel.',
            style: _kBodySoftStyle,
          ),
        ),
      ),
    ],
  );

  final Widget preview = Theme(
    data: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccentRose),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            'ExpansionPanelList (multiple panels independent)',
            style: _kCaptionStyle,
          ),
        ),
        normalPanelList,
        const SizedBox(height: 14.0),
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            'ExpansionPanelList.radio (single open at a time)',
            style: _kCaptionStyle,
          ),
        ),
        radioPanelList,
      ],
    ),
  );

  return _recipeShell(
    tag: 'RECIPE 06',
    title: 'ExpansionPanelList vs .radio',
    description:
        'ExpansionPanelList holds a list of ExpansionPanel models. Each '
        'caller owns its isExpanded bool. The .radio variant swaps in '
        'ExpansionPanelRadio with a value key and enforces "only one open '
        'at a time" internally.',
    preview: preview,
    accent: _kAccentRose,
    code: '// Plain panel list — caller manages booleans:\n'
        'ExpansionPanelList(\n'
        '  expansionCallback: (int index, bool open) =>\n'
        '      setState(() => state[index] = !open),\n'
        '  children: <ExpansionPanel>[\n'
        '    ExpansionPanel(\n'
        '      isExpanded: state[0],\n'
        '      headerBuilder: (ctx, open) => Text(...),\n'
        '      body: ...,\n'
        '    ),\n'
        '    ...,\n'
        '  ],\n'
        ');\n'
        '\n'
        '// Radio variant — only one open at a time, automatic:\n'
        'ExpansionPanelList.radio(\n'
        "  initialOpenPanelValue: 'shipping',\n"
        '  children: <ExpansionPanelRadio>[\n'
        '    ExpansionPanelRadio(\n'
        "      value: 'payment',\n"
        '      headerBuilder: (ctx, open) => Text(...),\n'
        '      body: ...,\n'
        '    ),\n'
        '    ...,\n'
        '  ],\n'
        ');',
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 - PITFALLS PANEL
// ---------------------------------------------------------------------------

Widget _pitfallCard({
  required String title,
  required String body,
  required IconData icon,
  required Color accent,
  required Color soft,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 34.0,
          height: 34.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: soft,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: accent, size: 18.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(body, style: _kBodySoftStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallsList() {
  return Column(
    children: <Widget>[
      _pitfallCard(
        icon: Icons.memory_outlined,
        accent: _kAccentAmber,
        soft: _kAccentAmberSoft,
        title: 'maintainState has a memory cost',
        body: 'maintainState: true keeps every closed child in the element '
            'tree. It is the right call for inputs and scroll positions, '
            'but the wrong call for heavy media or long lists — those should '
            'rebuild on expand to avoid carrying their layout cost when '
            'invisible.',
      ),
      _pitfallCard(
        icon: Icons.cable_outlined,
        accent: _kAccentRose,
        soft: _kAccentRoseSoft,
        title: 'Controller lifecycle ≠ widget lifecycle',
        body: 'ExpansionTileController is a plain Listenable-like handle. It '
            'has no dispose() and must outlive the tile it drives; allocate '
            'it in initState of the surrounding StatefulWidget, not inside '
            'build, so a rebuild does not detach the controller mid-flight.',
      ),
      _pitfallCard(
        icon: Icons.radio_button_checked,
        accent: _kAccentBlue,
        soft: _kAccentBlueSoft,
        title: 'Radio + maintainState is moot',
        body: 'ExpansionPanelList.radio implicitly closes all other panels. '
            'There is no maintainState on ExpansionPanelRadio because closed '
            'panels never render their body — if you need persistence, you '
            'have to push state outwards yourself.',
      ),
      _pitfallCard(
        icon: Icons.rounded_corner_outlined,
        accent: _kAccentTeal,
        soft: _kAccentTealSoft,
        title: 'shape without collapsedShape',
        body: 'Set both shape and collapsedShape together. If you only set '
            'shape, the closed tile reverts to the rectangle default and '
            'the corners "snap" in the second half of the open animation.',
      ),
      _pitfallCard(
        icon: Icons.space_bar_outlined,
        accent: _kAccentViolet,
        soft: _kAccentVioletSoft,
        title: 'childrenPadding doubles up',
        body: 'If you already wrap every child in Padding, do not also set '
            'childrenPadding — the two stack and the indentation looks '
            'inconsistent across rows. Pick one source of truth.',
      ),
      _pitfallCard(
        icon: Icons.swap_horiz_outlined,
        accent: _kAccentOrange,
        soft: _kAccentAmberSoft,
        title: 'controlAffinity.leading silently drops `leading`',
        body: 'Switching controlAffinity to leading puts the chevron in the '
            'leading slot of the underlying ListTile. Any widget you passed '
            'to `leading:` will no longer be rendered — move it into the '
            'title row or use controlAffinity.trailing.',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// FOOTER
// ---------------------------------------------------------------------------

Widget _cheatSheetFooter() {
  return _darkCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Cheat-sheet',
          style: TextStyle(
            color: _kInkOnDark,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Quick-reference chips grouped by surface',
          style: TextStyle(color: _kInkOnDarkSecondary, fontSize: 13.0),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _darkChip('title', 'required'),
            _darkChip('subtitle', '?Widget'),
            _darkChip('leading', '?Widget'),
            _darkChip('trailing', 'rotating chevron'),
            _darkChip('children', 'List<Widget>'),
            _darkChip('initiallyExpanded', 'bool, default false'),
            _darkChip('maintainState', 'bool, default false'),
            _darkChip('tilePadding', 'EdgeInsetsGeometry?'),
            _darkChip('expandedAlignment', 'AlignmentGeometry?'),
            _darkChip('expandedCrossAxisAlignment', 'CrossAxisAlignment?'),
            _darkChip('childrenPadding', 'EdgeInsetsGeometry?'),
            _darkChip('backgroundColor', 'Color?'),
            _darkChip('collapsedBackgroundColor', 'Color?'),
            _darkChip('textColor', 'Color?'),
            _darkChip('collapsedTextColor', 'Color?'),
            _darkChip('iconColor', 'Color?'),
            _darkChip('collapsedIconColor', 'Color?'),
            _darkChip('shape', 'ShapeBorder?'),
            _darkChip('collapsedShape', 'ShapeBorder?'),
            _darkChip('clipBehavior', 'Clip?'),
            _darkChip('controlAffinity', 'ListTileControlAffinity?'),
            _darkChip('controller', 'ExpansionTileController?'),
            _darkChip('onExpansionChanged', 'ValueChanged<bool>?'),
          ],
        ),
        const SizedBox(height: 14.0),
        const Divider(color: _kHairlineDark, height: 1.0),
        const SizedBox(height: 14.0),
        const Text(
          'Related types',
          style: TextStyle(
            color: _kInkOnDark,
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _darkChip('ExpansionTileTheme', 'InheritedTheme'),
            _darkChip('ExpansionTileThemeData', 'Diagnosticable'),
            _darkChip('ExpansionTileController', 'Imperative handle'),
            _darkChip('ExpansionPanelList', 'panel list widget'),
            _darkChip('ExpansionPanelList.radio', 'single open at a time'),
            _darkChip('ExpansionPanel', 'model object'),
            _darkChip('ExpansionPanelRadio', 'panel + value key'),
            _darkChip('ListTileControlAffinity', 'enum'),
          ],
        ),
      ],
    ),
  );
}

Widget _darkChip(String name, String type) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: const Color(0x22FFFFFF),
      borderRadius: BorderRadius.circular(999.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          name,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          type,
          style: const TextStyle(
            color: Color(0xFFB7BAD0),
            fontSize: 11.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// ENTRY POINT
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('ExpansionTile deep visual demo executing');

  // Constructed for introspection only; never toggled during build().
  final ExpansionTileController _unboundController = ExpansionTileController();

  final Widget header2 = _sectionHeader(
    2,
    'Parameter anatomy',
    'Every public ExpansionTile parameter, type, default, and role.',
  );
  final Widget header3 = _sectionHeader(
    3,
    'Expanded vs collapsed',
    'Static snapshot of both states, side by side.',
  );
  final Widget header4 = _sectionHeader(
    4,
    'M3 theming surface',
    'ExpansionTileTheme + ExpansionTileThemeData walkthrough.',
  );
  final Widget header5 = _sectionHeader(
    5,
    'Tile vs PanelList',
    'Comparison table — when to pick which family member.',
  );
  final Widget header6 = _sectionHeader(
    6,
    'Recipe cards',
    'Six idiomatic, copy-pasteable shapes.',
  );
  final Widget header7 = _sectionHeader(
    7,
    'Pitfalls',
    'Six callouts for the gotchas that actually bite in practice.',
  );

  final Widget tree = Theme(
    data: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccent),
      scaffoldBackgroundColor: _kCanvas,
      textTheme: const TextTheme(),
      dividerColor: const Color(0x00000000),
    ),
    child: Scaffold(
      backgroundColor: _kCanvas,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _heroSection(),
              header2,
              _parameterAnatomy(),
              header3,
              _sideBySideStates(),
              header4,
              _themingPanel(),
              header5,
              _comparePanel(),
              header6,
              _recipeSettingsGroup(),
              _recipeFaqList(),
              _recipeNestedForm(),
              _recipeController(),
              _recipeControlAffinity(),
              _recipePanelList(),
              header7,
              _pitfallsList(),
              const SizedBox(height: 24.0),
              _cheatSheetFooter(),
              const SizedBox(height: 18.0),
            ],
          ),
        ),
      ),
    ),
  );

  print('ExpansionTile demo tree assembled');
  return tree;
}

// D4rt test script: Deep visual demo of BottomNavigationBar (Material).
// Demonstrates BottomNavigationBarItem, BottomNavigationBarType, theme data,
// icon/label/active/inactive colour combinations, fixed vs shifting layouts,
// landscape arrangement, badge decoration, font-size tuning, and cursor.
//
// Entry point: dynamic build(BuildContext context) — returns a Scaffold.
// No main(), no runApp, no Navigator.push. Embedded MaterialApp mini-frames
// are used to render fully self-contained BottomNavigationBar previews.
import 'package:flutter/material.dart';

// ============================================================================
// PALETTE — a hand-tuned set of named colours referenced throughout the demo.
// Using a small palette keeps swatches consistent and analyser-clean.
// ============================================================================

const Color kInkDeep = Color(0xFF0F172A);
const Color kInkSoft = Color(0xFF334155);
const Color kInkMuted = Color(0xFF64748B);
const Color kPaperBase = Color(0xFFF8FAFC);
const Color kPaperLift = Color(0xFFFFFFFF);
const Color kAccentCoral = Color(0xFFFB7185);
const Color kAccentSky = Color(0xFF38BDF8);
const Color kAccentMint = Color(0xFF34D399);
const Color kAccentSun = Color(0xFFFBBF24);
const Color kAccentPlum = Color(0xFFA78BFA);
const Color kAccentRose = Color(0xFFE11D48);
const Color kBezelDark = Color(0xFF111827);
const Color kBezelChrome = Color(0xFF1F2937);
const Color kScrim = Color(0xFF94A3B8);

// ============================================================================
// SmallChip — a self-contained label used in section heads and legends.
// ============================================================================

class SmallChip extends StatelessWidget {
  const SmallChip({
    super.key,
    required this.label,
    required this.tint,
  });

  final String label;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: tint.withValues(alpha: 0.6), width: 1.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
          color: tint,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ============================================================================
// SectionHeader — a styled section opener with index, title, subtitle, tint.
// ============================================================================

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.glyph,
  });

  final int index;
  final String title;
  final String subtitle;
  final Color tint;
  final IconData glyph;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 28.0, bottom: 16.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            tint.withValues(alpha: 0.92),
            tint.withValues(alpha: 0.55),
          ],
        ),
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tint.withValues(alpha: 0.32),
            blurRadius: 14.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 56.0,
            height: 56.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kPaperLift.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(
                color: kPaperLift.withValues(alpha: 0.6),
                width: 1.4,
              ),
            ),
            child: Icon(glyph, color: kPaperLift, size: 30.0),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'SECTION ${index.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0,
                    color: kPaperLift.withValues(alpha: 0.78),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                    color: kPaperLift,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.0,
                    height: 1.35,
                    color: kPaperLift.withValues(alpha: 0.88),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// NarrativeBlurb — long-form paragraph card used between visual sections.
// ============================================================================

class NarrativeBlurb extends StatelessWidget {
  const NarrativeBlurb({
    super.key,
    required this.heading,
    required this.lines,
    required this.tint,
  });

  final String heading;
  final List<String> lines;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: kPaperLift,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: tint.withValues(alpha: 0.32), width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInkDeep.withValues(alpha: 0.05),
            blurRadius: 8.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: tint,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  heading,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    color: kInkDeep,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ...List<Widget>.generate(lines.length, (int i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 6.0, right: 10.0),
                    width: 6.0,
                    height: 6.0,
                    decoration: BoxDecoration(
                      color: tint.withValues(alpha: 0.75),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      lines[i],
                      style: const TextStyle(
                        fontSize: 13.0,
                        height: 1.45,
                        color: kInkSoft,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ============================================================================
// ColourSwatch — a single colour tile with hex label.
// ============================================================================

class ColourSwatch extends StatelessWidget {
  const ColourSwatch({
    super.key,
    required this.name,
    required this.color,
  });

  final String name;
  final Color color;

  String get _hex {
    final int v = color.toARGB32();
    final String r = ((v >> 16) & 0xFF).toRadixString(16).padLeft(2, '0');
    final String g = ((v >> 8) & 0xFF).toRadixString(16).padLeft(2, '0');
    final String b = (v & 0xFF).toRadixString(16).padLeft(2, '0');
    return '#${r.toUpperCase()}${g.toUpperCase()}${b.toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.0,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: kPaperLift,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: kScrim.withValues(alpha: 0.35), width: 1.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(height: 56.0, color: color),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    color: kInkDeep,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  _hex,
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: kInkMuted,
                    fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// PhoneFrame — an embedded mini "device" that hosts a MaterialApp / Scaffold
// so each BottomNavigationBar variant can be previewed in isolation.
// ============================================================================

class PhoneFrame extends StatelessWidget {
  const PhoneFrame({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.width = 280.0,
    this.height = 540.0,
    this.statusTint = kAccentSky,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final double width;
  final double height;
  final Color statusTint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: kInkDeep,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
            child: Text(
              subtitle,
              style: const TextStyle(fontSize: 11.0, color: kInkMuted),
            ),
          ),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: kBezelDark,
              borderRadius: BorderRadius.circular(36.0),
              border: Border.all(color: kBezelChrome, width: 4.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: kInkDeep.withValues(alpha: 0.4),
                  blurRadius: 18.0,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            padding: const EdgeInsets.all(6.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(child: child),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 22.0,
                      color: statusTint.withValues(alpha: 0.18),
                      alignment: Alignment.center,
                      child: Text(
                        ' \u2022 \u2022 \u2022 ',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: statusTint,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// _miniBody — a generic body for the embedded scaffolds. Avoids depending on
// MediaQuery in field initialisers (per the D4rt rule about top-level state).
// ============================================================================

Widget _miniBody({
  required IconData glyph,
  required String headline,
  required String body,
  required Color tint,
}) {
  return Container(
    color: kPaperBase,
    padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 78.0,
          height: 78.0,
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(glyph, color: tint, size: 38.0),
        ),
        const SizedBox(height: 14.0),
        Text(
          headline,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: kInkDeep,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          body,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12.0,
            height: 1.4,
            color: kInkMuted,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// _BottomNavPreview — STATEFUL: a tappable, embedded BottomNavigationBar.
// All callbacks use the per-instance state's currentIndex, never a for-loop
// variable, so closure capture is safe under D4rt.
// ============================================================================

class _BottomNavPreview extends StatefulWidget {
  const _BottomNavPreview({
    required this.items,
    required this.bodies,
    required this.type,
    required this.background,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.selectedFontSize,
    required this.unselectedFontSize,
    required this.showSelectedLabels,
    required this.showUnselectedLabels,
    required this.elevation,
    required this.startIndex,
    this.iconSize = 24.0,
    this.useThemeData = false,
    this.cursorIsClick = true,
    this.landscapeLayout =
        BottomNavigationBarLandscapeLayout.centered,
  });

  final List<BottomNavigationBarItem> items;
  final List<Widget> bodies;
  final BottomNavigationBarType type;
  final Color background;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double selectedFontSize;
  final double unselectedFontSize;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final double elevation;
  final int startIndex;
  final double iconSize;
  final bool useThemeData;
  final bool cursorIsClick;
  final BottomNavigationBarLandscapeLayout landscapeLayout;

  @override
  State<_BottomNavPreview> createState() => _BottomNavPreviewState();
}

class _BottomNavPreviewState extends State<_BottomNavPreview> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.startIndex.clamp(0, widget.items.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar bar = BottomNavigationBar(
      items: widget.items,
      currentIndex: _index,
      type: widget.type,
      backgroundColor: widget.background,
      selectedItemColor: widget.selectedItemColor,
      unselectedItemColor: widget.unselectedItemColor,
      selectedFontSize: widget.selectedFontSize,
      unselectedFontSize: widget.unselectedFontSize,
      showSelectedLabels: widget.showSelectedLabels,
      showUnselectedLabels: widget.showUnselectedLabels,
      elevation: widget.elevation,
      iconSize: widget.iconSize,
      landscapeLayout: widget.landscapeLayout,
      mouseCursor: widget.cursorIsClick
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onTap: (int i) {
        setState(() {
          _index = i;
        });
      },
    );

    final Widget scaffold = Scaffold(
      backgroundColor: kPaperBase,
      body: widget.bodies[_index],
      bottomNavigationBar: bar,
    );

    if (widget.useThemeData) {
      return Theme(
        data: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: widget.background,
            selectedItemColor: widget.selectedItemColor,
            unselectedItemColor: widget.unselectedItemColor,
            selectedIconTheme: IconThemeData(
              color: widget.selectedItemColor,
              size: widget.iconSize + 2.0,
            ),
            unselectedIconTheme: IconThemeData(
              color: widget.unselectedItemColor,
              size: widget.iconSize,
            ),
            selectedLabelStyle: TextStyle(
              fontSize: widget.selectedFontSize,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: widget.unselectedFontSize,
              fontWeight: FontWeight.w500,
            ),
            type: widget.type,
            elevation: widget.elevation,
            showSelectedLabels: widget.showSelectedLabels,
            showUnselectedLabels: widget.showUnselectedLabels,
            mouseCursor: WidgetStateProperty.all<MouseCursor>(
              widget.cursorIsClick
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
            ),
            landscapeLayout: widget.landscapeLayout,
          ),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: scaffold,
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: scaffold,
    );
  }
}

// ============================================================================
// _BadgedIcon — composes an icon with a small badge dot/count overlay.
// Used to demonstrate badge-like decoration on BottomNavigationBarItem.icon.
// ============================================================================

class _BadgedIcon extends StatelessWidget {
  const _BadgedIcon({
    required this.glyph,
    required this.badge,
    this.color,
    this.dotColor = kAccentRose,
  });

  final IconData glyph;
  final String badge;
  final Color? color;
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.0,
      height: 30.0,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            left: 3.0,
            top: 3.0,
            child: Icon(glyph, color: color, size: 24.0),
          ),
          Positioned(
            right: -2.0,
            top: -2.0,
            child: Container(
              constraints: const BoxConstraints(
                minWidth: 16.0,
                minHeight: 16.0,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 1.0,
              ),
              decoration: BoxDecoration(
                color: dotColor,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: kPaperLift, width: 1.5),
              ),
              alignment: Alignment.center,
              child: Text(
                badge,
                style: const TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.w800,
                  color: kPaperLift,
                  height: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// build(BuildContext context) — D4rt entry point. Returns a Scaffold.
// ============================================================================

dynamic build(BuildContext context) {
  // --------------------------------------------------------------------------
  // Pre-compute item sets used throughout the demo. List.generate / .map are
  // used to keep callbacks closure-safe (no for-loop variable capture).
  // --------------------------------------------------------------------------

  final List<BottomNavigationBarItem> coreItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
      tooltip: 'Open home feed',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search_outlined),
      activeIcon: Icon(Icons.search),
      label: 'Search',
      tooltip: 'Search the catalogue',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.library_books_outlined),
      activeIcon: Icon(Icons.library_books),
      label: 'Library',
      tooltip: 'Browse saved items',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profile',
      tooltip: 'Account & settings',
    ),
  ];

  final List<Widget> coreBodies = <Widget>[
    _miniBody(
      glyph: Icons.home,
      headline: 'Home',
      body: 'Curated stories tuned to recent activity.',
      tint: kAccentSky,
    ),
    _miniBody(
      glyph: Icons.search,
      headline: 'Search',
      body: 'Full-text query with semantic ranking.',
      tint: kAccentMint,
    ),
    _miniBody(
      glyph: Icons.library_books,
      headline: 'Library',
      body: 'Saved articles, offline copies, highlights.',
      tint: kAccentSun,
    ),
    _miniBody(
      glyph: Icons.person,
      headline: 'Profile',
      body: 'Settings, identity, and subscription.',
      tint: kAccentPlum,
    ),
  ];

  // --------------------------------------------------------------------------
  // SECTION 1 — Title card and table of contents
  // --------------------------------------------------------------------------

  final Widget titleCard = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 18.0),
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kInkDeep, Color(0xFF1E293B)],
      ),
      borderRadius: BorderRadius.circular(22.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(
              Icons.dashboard_customize_outlined,
              color: kAccentSky,
              size: 36.0,
            ),
            SizedBox(width: 12.0),
            SmallChip(label: 'MATERIAL', tint: kAccentSky),
            SizedBox(width: 8.0),
            SmallChip(label: 'NAVIGATION', tint: kAccentMint),
            SizedBox(width: 8.0),
            SmallChip(label: 'DEEP DEMO', tint: kAccentSun),
          ],
        ),
        const SizedBox(height: 16.0),
        const Text(
          'BottomNavigationBar',
          style: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.w900,
            color: kPaperLift,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'A taxonomy of the Material BottomNavigationBar widget — items, '
          'types, themes, decoration, sizing, cursor behaviour and the '
          'landscape layout enum, rendered in self-contained device frames.',
          style: TextStyle(
            fontSize: 14.0,
            height: 1.5,
            color: Color(0xFFCBD5E1),
          ),
        ),
        const SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: const <Widget>[
            SmallChip(label: '01  Anatomy', tint: kAccentSky),
            SmallChip(label: '02  Item Variants', tint: kAccentMint),
            SmallChip(label: '03  Fixed vs Shifting', tint: kAccentCoral),
            SmallChip(label: '04  Theme Data', tint: kAccentPlum),
            SmallChip(label: '05  Font Sizing', tint: kAccentSun),
            SmallChip(label: '06  Badges', tint: kAccentRose),
            SmallChip(label: '07  Landscape', tint: kAccentSky),
            SmallChip(label: '08  Cursor & Tooltip', tint: kAccentMint),
            SmallChip(label: '09  Label Visibility', tint: kAccentCoral),
            SmallChip(label: '10  Gallery', tint: kAccentPlum),
          ],
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 2 — Anatomy diagram (annotated stack)
  // --------------------------------------------------------------------------

  final Widget anatomy = Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kPaperLift,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: kScrim.withValues(alpha: 0.35), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Anatomy of a BottomNavigationBar',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w800,
            color: kInkDeep,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          height: 86.0,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: kInkDeep,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List<Widget>.generate(4, (int i) {
              const List<IconData> glyphs = <IconData>[
                Icons.home,
                Icons.explore,
                Icons.notifications,
                Icons.person,
              ];
              const List<String> labels = <String>[
                'Home',
                'Explore',
                'Inbox',
                'Profile',
              ];
              final bool selected = i == 1;
              final Color tint = selected ? kAccentSky : kScrim;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(glyphs[i], color: tint, size: 26.0),
                  const SizedBox(height: 4.0),
                  Text(
                    labels[i],
                    style: TextStyle(
                      color: tint,
                      fontSize: selected ? 13.0 : 11.0,
                      fontWeight:
                          selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 6.0,
          children: const <Widget>[
            SmallChip(label: 'items[]', tint: kAccentSky),
            SmallChip(label: 'currentIndex', tint: kAccentMint),
            SmallChip(label: 'onTap', tint: kAccentSun),
            SmallChip(label: 'type', tint: kAccentPlum),
            SmallChip(label: 'selectedItemColor', tint: kAccentCoral),
            SmallChip(label: 'unselectedItemColor', tint: kInkMuted),
            SmallChip(label: 'iconSize', tint: kAccentRose),
            SmallChip(label: 'elevation', tint: kAccentMint),
          ],
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 3 — Palette swatches
  // --------------------------------------------------------------------------

  final List<Map<String, Object>> swatchSpec = <Map<String, Object>>[
    <String, Object>{'name': 'Ink Deep', 'color': kInkDeep},
    <String, Object>{'name': 'Ink Soft', 'color': kInkSoft},
    <String, Object>{'name': 'Coral', 'color': kAccentCoral},
    <String, Object>{'name': 'Sky', 'color': kAccentSky},
    <String, Object>{'name': 'Mint', 'color': kAccentMint},
    <String, Object>{'name': 'Sun', 'color': kAccentSun},
    <String, Object>{'name': 'Plum', 'color': kAccentPlum},
    <String, Object>{'name': 'Rose', 'color': kAccentRose},
  ];

  final Widget palette = Wrap(
    children: List<Widget>.generate(swatchSpec.length, (int i) {
      final Map<String, Object> s = swatchSpec[i];
      return ColourSwatch(
        name: s['name'] as String,
        color: s['color'] as Color,
      );
    }),
  );

  // --------------------------------------------------------------------------
  // SECTION 4 — Item variants table (icon-only, label-only, both, active diff)
  // --------------------------------------------------------------------------

  final List<Map<String, Object?>> itemSpec = <Map<String, Object?>>[
    <String, Object?>{
      'title': 'Icon + Label',
      'desc': 'The classic configuration. Active icon optional.',
      'icon': const Icon(Icons.bookmark_border),
      'active': const Icon(Icons.bookmark),
      'label': 'Saved',
    },
    <String, Object?>{
      'title': 'Distinct active icon',
      'desc': 'Outlined when idle, filled when active.',
      'icon': const Icon(Icons.favorite_border),
      'active': const Icon(Icons.favorite),
      'label': 'Likes',
    },
    <String, Object?>{
      'title': 'Tinted active icon',
      'desc': 'activeIcon can be any Widget — even a colored Container.',
      'icon': const Icon(Icons.shopping_bag_outlined),
      'active': Container(
        padding: const EdgeInsets.all(2.0),
        decoration: const BoxDecoration(
          color: kAccentSun,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.shopping_bag, color: kInkDeep, size: 20.0),
      ),
      'label': 'Bag',
    },
    <String, Object?>{
      'title': 'Long label',
      'desc': 'Labels truncate gracefully; keep them under ~10 chars.',
      'icon': const Icon(Icons.notifications_none),
      'active': const Icon(Icons.notifications_active),
      'label': 'Notifications',
    },
    <String, Object?>{
      'title': 'Custom widget as icon',
      'desc': 'Any Widget can stand in for the icon slot.',
      'icon': Container(
        width: 22.0,
        height: 22.0,
        decoration: const BoxDecoration(
          color: kAccentPlum,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Text(
          'A',
          style: TextStyle(
            color: kPaperLift,
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      'active': Container(
        width: 22.0,
        height: 22.0,
        decoration: const BoxDecoration(
          color: kAccentRose,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Text(
          'A',
          style: TextStyle(
            color: kPaperLift,
            fontSize: 12.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      'label': 'Avatar',
    },
  ];

  final Widget itemVariants = Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kPaperLift,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kScrim.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Column(
      children: List<Widget>.generate(itemSpec.length, (int i) {
        final Map<String, Object?> s = itemSpec[i];
        final bool last = i == itemSpec.length - 1;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: last
                    ? Colors.transparent
                    : kScrim.withValues(alpha: 0.25),
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 80.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: kInkDeep,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: IconTheme(
                        data: const IconThemeData(
                          color: kScrim,
                          size: 22.0,
                        ),
                        child: s['icon'] as Widget,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'idle',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: kInkMuted,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 80.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: kAccentSky.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: IconTheme(
                        data: const IconThemeData(
                          color: kAccentSky,
                          size: 22.0,
                        ),
                        child: s['active'] as Widget,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'active',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: kAccentSky,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      s['title'] as String,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: kInkDeep,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      s['desc'] as String,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: kInkSoft,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: kAccentMint.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        'label: "${s['label'] as String}"',
                        style: const TextStyle(
                          fontSize: 11.0,
                          color: kAccentMint,
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
      }),
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 5 — Fixed vs Shifting previews
  // --------------------------------------------------------------------------

  final Widget fixedPreview = PhoneFrame(
    title: 'Fixed type',
    subtitle: 'BottomNavigationBarType.fixed — equal slots',
    statusTint: kAccentSky,
    child: _BottomNavPreview(
      items: coreItems,
      bodies: coreBodies,
      type: BottomNavigationBarType.fixed,
      background: kPaperLift,
      selectedItemColor: kAccentSky,
      unselectedItemColor: kInkMuted,
      selectedFontSize: 13.0,
      unselectedFontSize: 12.0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 8.0,
      startIndex: 0,
    ),
  );

  final Widget shiftingPreview = PhoneFrame(
    title: 'Shifting type',
    subtitle: 'BottomNavigationBarType.shifting — animated emphasis',
    statusTint: kAccentCoral,
    child: _BottomNavPreview(
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard),
          label: 'Board',
          backgroundColor: Color(0xFF0EA5E9),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.travel_explore_outlined),
          activeIcon: Icon(Icons.travel_explore),
          label: 'Travel',
          backgroundColor: Color(0xFF22C55E),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.local_florist_outlined),
          activeIcon: Icon(Icons.local_florist),
          label: 'Flora',
          backgroundColor: Color(0xFFD946EF),
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.local_cafe_outlined),
          activeIcon: Icon(Icons.local_cafe),
          label: 'Cafe',
          backgroundColor: Color(0xFFF59E0B),
        ),
      ],
      bodies: <Widget>[
        _miniBody(
          glyph: Icons.dashboard,
          headline: 'Board',
          body: 'Dashboards tinted by selected slot.',
          tint: const Color(0xFF0EA5E9),
        ),
        _miniBody(
          glyph: Icons.travel_explore,
          headline: 'Travel',
          body: 'Background color follows item.backgroundColor.',
          tint: const Color(0xFF22C55E),
        ),
        _miniBody(
          glyph: Icons.local_florist,
          headline: 'Flora',
          body: 'Each tap animates the bar background.',
          tint: const Color(0xFFD946EF),
        ),
        _miniBody(
          glyph: Icons.local_cafe,
          headline: 'Cafe',
          body: 'Active slot expands; idle ones shrink.',
          tint: const Color(0xFFF59E0B),
        ),
      ],
      type: BottomNavigationBarType.shifting,
      background: const Color(0xFF0EA5E9),
      selectedItemColor: kPaperLift,
      unselectedItemColor: const Color(0xFFE2E8F0),
      selectedFontSize: 13.0,
      unselectedFontSize: 11.0,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      elevation: 12.0,
      startIndex: 1,
    ),
  );

  final Widget fixedVsShifting = Wrap(
    alignment: WrapAlignment.start,
    children: <Widget>[fixedPreview, shiftingPreview],
  );

  // --------------------------------------------------------------------------
  // SECTION 6 — Theme data driven previews
  // --------------------------------------------------------------------------

  final Widget themedPreviewSoft = PhoneFrame(
    title: 'Themed (soft)',
    subtitle: 'via BottomNavigationBarThemeData',
    statusTint: kAccentMint,
    child: _BottomNavPreview(
      items: coreItems,
      bodies: coreBodies,
      type: BottomNavigationBarType.fixed,
      background: kPaperLift,
      selectedItemColor: kAccentMint,
      unselectedItemColor: kInkMuted,
      selectedFontSize: 13.0,
      unselectedFontSize: 12.0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 4.0,
      startIndex: 2,
      useThemeData: true,
    ),
  );

  final Widget themedPreviewDark = PhoneFrame(
    title: 'Themed (dark)',
    subtitle: 'background ink, mint accent',
    statusTint: kAccentMint,
    child: _BottomNavPreview(
      items: coreItems,
      bodies: coreBodies,
      type: BottomNavigationBarType.fixed,
      background: kInkDeep,
      selectedItemColor: kAccentMint,
      unselectedItemColor: kScrim,
      selectedFontSize: 13.0,
      unselectedFontSize: 12.0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 16.0,
      startIndex: 3,
      useThemeData: true,
      iconSize: 26.0,
    ),
  );

  final Widget themedRow = Wrap(
    children: <Widget>[themedPreviewSoft, themedPreviewDark],
  );

  // --------------------------------------------------------------------------
  // SECTION 7 — Font-size matrix preview
  // --------------------------------------------------------------------------

  final List<Map<String, Object>> sizeSpec = <Map<String, Object>>[
    <String, Object>{
      'title': 'Compact',
      'sel': 11.0,
      'uns': 10.0,
      'tint': kAccentCoral,
    },
    <String, Object>{
      'title': 'Default',
      'sel': 14.0,
      'uns': 12.0,
      'tint': kAccentSky,
    },
    <String, Object>{
      'title': 'Spacious',
      'sel': 17.0,
      'uns': 14.0,
      'tint': kAccentPlum,
    },
  ];

  final Widget sizeMatrix = Wrap(
    children: List<Widget>.generate(sizeSpec.length, (int i) {
      final Map<String, Object> s = sizeSpec[i];
      return PhoneFrame(
        title: s['title'] as String,
        subtitle:
            'sel ${(s['sel'] as double).toStringAsFixed(0)} / '
            'uns ${(s['uns'] as double).toStringAsFixed(0)}',
        statusTint: s['tint'] as Color,
        width: 240.0,
        height: 460.0,
        child: _BottomNavPreview(
          items: coreItems.sublist(0, 3),
          bodies: coreBodies.sublist(0, 3),
          type: BottomNavigationBarType.fixed,
          background: kPaperLift,
          selectedItemColor: s['tint'] as Color,
          unselectedItemColor: kInkMuted,
          selectedFontSize: s['sel'] as double,
          unselectedFontSize: s['uns'] as double,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 6.0,
          startIndex: 1,
        ),
      );
    }),
  );

  // --------------------------------------------------------------------------
  // SECTION 8 — Badged items preview
  // --------------------------------------------------------------------------

  final List<BottomNavigationBarItem> badgedItems =
      <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: _BadgedIcon(
            glyph: Icons.mail_outline,
            badge: '12',
            color: kInkMuted,
          ),
          activeIcon: _BadgedIcon(
            glyph: Icons.mail,
            badge: '12',
            color: kAccentRose,
          ),
          label: 'Inbox',
        ),
        const BottomNavigationBarItem(
          icon: _BadgedIcon(
            glyph: Icons.notifications_none,
            badge: '3',
            color: kInkMuted,
            dotColor: kAccentSun,
          ),
          activeIcon: _BadgedIcon(
            glyph: Icons.notifications,
            badge: '3',
            color: kAccentRose,
            dotColor: kAccentSun,
          ),
          label: 'Alerts',
        ),
        const BottomNavigationBarItem(
          icon: _BadgedIcon(
            glyph: Icons.shopping_cart_outlined,
            badge: '99+',
            color: kInkMuted,
            dotColor: kAccentMint,
          ),
          activeIcon: _BadgedIcon(
            glyph: Icons.shopping_cart,
            badge: '99+',
            color: kAccentRose,
            dotColor: kAccentMint,
          ),
          label: 'Cart',
        ),
      ];

  final List<Widget> badgedBodies = <Widget>[
    _miniBody(
      glyph: Icons.home,
      headline: 'Home',
      body: 'No new items.',
      tint: kAccentSky,
    ),
    _miniBody(
      glyph: Icons.mail,
      headline: 'Inbox (12)',
      body: 'Twelve unread messages await triage.',
      tint: kAccentRose,
    ),
    _miniBody(
      glyph: Icons.notifications_active,
      headline: 'Alerts (3)',
      body: 'Three critical alerts surfaced today.',
      tint: kAccentSun,
    ),
    _miniBody(
      glyph: Icons.shopping_cart,
      headline: 'Cart (99+)',
      body: 'You hoarded just a few too many items.',
      tint: kAccentMint,
    ),
  ];

  final Widget badgedPreview = PhoneFrame(
    title: 'Badged decoration',
    subtitle: 'badge stack on each icon slot',
    statusTint: kAccentRose,
    child: _BottomNavPreview(
      items: badgedItems,
      bodies: badgedBodies,
      type: BottomNavigationBarType.fixed,
      background: kPaperLift,
      selectedItemColor: kAccentRose,
      unselectedItemColor: kInkMuted,
      selectedFontSize: 12.0,
      unselectedFontSize: 11.0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 10.0,
      startIndex: 1,
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 9 — Landscape layout variants
  // --------------------------------------------------------------------------

  final List<Map<String, Object>> landscapeSpec = <Map<String, Object>>[
    <String, Object>{
      'title': 'centered',
      'value': BottomNavigationBarLandscapeLayout.centered,
      'tint': kAccentSky,
      'desc': 'Items hug the center, even when the bar is wide.',
    },
    <String, Object>{
      'title': 'linear',
      'value': BottomNavigationBarLandscapeLayout.linear,
      'tint': kAccentMint,
      'desc': 'Items distribute evenly across the full bar width.',
    },
    <String, Object>{
      'title': 'spread',
      'value': BottomNavigationBarLandscapeLayout.spread,
      'tint': kAccentPlum,
      'desc': 'Icon and label sit side-by-side; bar is shorter.',
    },
  ];

  final Widget landscapeRow = Wrap(
    children: List<Widget>.generate(landscapeSpec.length, (int i) {
      final Map<String, Object> s = landscapeSpec[i];
      return PhoneFrame(
        title: 'landscape.${s['title'] as String}',
        subtitle: s['desc'] as String,
        statusTint: s['tint'] as Color,
        width: 460.0,
        height: 240.0,
        child: _BottomNavPreview(
          items: coreItems,
          bodies: coreBodies,
          type: BottomNavigationBarType.fixed,
          background: kPaperLift,
          selectedItemColor: s['tint'] as Color,
          unselectedItemColor: kInkMuted,
          selectedFontSize: 13.0,
          unselectedFontSize: 12.0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 4.0,
          startIndex: 0,
          landscapeLayout:
              s['value'] as BottomNavigationBarLandscapeLayout,
        ),
      );
    }),
  );

  // --------------------------------------------------------------------------
  // SECTION 10 — Cursor / Tooltip preview
  // --------------------------------------------------------------------------

  final Widget cursorClick = PhoneFrame(
    title: 'mouseCursor: click',
    subtitle: 'SystemMouseCursors.click on hover',
    statusTint: kAccentSky,
    child: _BottomNavPreview(
      items: coreItems,
      bodies: coreBodies,
      type: BottomNavigationBarType.fixed,
      background: kPaperLift,
      selectedItemColor: kAccentSky,
      unselectedItemColor: kInkMuted,
      selectedFontSize: 12.0,
      unselectedFontSize: 11.0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 6.0,
      startIndex: 0,
    ),
  );

  final Widget cursorBasic = PhoneFrame(
    title: 'mouseCursor: basic',
    subtitle: 'default arrow on hover',
    statusTint: kAccentMint,
    child: _BottomNavPreview(
      items: coreItems,
      bodies: coreBodies,
      type: BottomNavigationBarType.fixed,
      background: kPaperLift,
      selectedItemColor: kAccentMint,
      unselectedItemColor: kInkMuted,
      selectedFontSize: 12.0,
      unselectedFontSize: 11.0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 6.0,
      startIndex: 0,
      cursorIsClick: false,
    ),
  );

  final Widget cursorRow = Wrap(
    children: <Widget>[cursorClick, cursorBasic],
  );

  // --------------------------------------------------------------------------
  // SECTION 11 — Label visibility matrix
  // --------------------------------------------------------------------------

  final List<Map<String, Object>> labelSpec = <Map<String, Object>>[
    <String, Object>{
      'title': 'Both labels',
      'sel': true,
      'uns': true,
      'tint': kAccentSky,
    },
    <String, Object>{
      'title': 'Selected only',
      'sel': true,
      'uns': false,
      'tint': kAccentSun,
    },
    <String, Object>{
      'title': 'Unselected only',
      'sel': false,
      'uns': true,
      'tint': kAccentPlum,
    },
    <String, Object>{
      'title': 'No labels',
      'sel': false,
      'uns': false,
      'tint': kAccentCoral,
    },
  ];

  final Widget labelMatrix = Wrap(
    children: List<Widget>.generate(labelSpec.length, (int i) {
      final Map<String, Object> s = labelSpec[i];
      return PhoneFrame(
        title: s['title'] as String,
        subtitle:
            'sel=${s['sel']} / uns=${s['uns']}',
        statusTint: s['tint'] as Color,
        width: 230.0,
        height: 430.0,
        child: _BottomNavPreview(
          items: coreItems.sublist(0, 3),
          bodies: coreBodies.sublist(0, 3),
          type: BottomNavigationBarType.fixed,
          background: kPaperLift,
          selectedItemColor: s['tint'] as Color,
          unselectedItemColor: kInkMuted,
          selectedFontSize: 13.0,
          unselectedFontSize: 12.0,
          showSelectedLabels: s['sel'] as bool,
          showUnselectedLabels: s['uns'] as bool,
          elevation: 6.0,
          startIndex: 1,
        ),
      );
    }),
  );

  // --------------------------------------------------------------------------
  // SECTION 12 — Gallery of styled BottomNavigationBars (varied palettes)
  // --------------------------------------------------------------------------

  final List<Map<String, Object>> gallerySpec = <Map<String, Object>>[
    <String, Object>{
      'title': 'Sunset gallery',
      'subtitle': 'warm tones, dark background',
      'bg': const Color(0xFF7C2D12),
      'sel': const Color(0xFFFDE68A),
      'uns': const Color(0xFFFCA5A5),
      'icons': <IconData>[
        Icons.collections,
        Icons.camera_alt,
        Icons.movie,
        Icons.audiotrack,
      ],
      'labels': <String>['Photos', 'Camera', 'Reels', 'Audio'],
      'tint': kAccentSun,
    },
    <String, Object>{
      'title': 'Forest journal',
      'subtitle': 'green grading, calm contrast',
      'bg': const Color(0xFF064E3B),
      'sel': const Color(0xFFA7F3D0),
      'uns': const Color(0xFF6EE7B7),
      'icons': <IconData>[
        Icons.eco,
        Icons.park,
        Icons.terrain,
        Icons.water_drop,
      ],
      'labels': <String>['Garden', 'Park', 'Trails', 'Water'],
      'tint': kAccentMint,
    },
    <String, Object>{
      'title': 'Lavender studio',
      'subtitle': 'subtle purple palette',
      'bg': const Color(0xFF3B0764),
      'sel': const Color(0xFFE9D5FF),
      'uns': const Color(0xFFC4B5FD),
      'icons': <IconData>[
        Icons.draw,
        Icons.palette,
        Icons.layers,
        Icons.brush,
      ],
      'labels': <String>['Draw', 'Color', 'Layers', 'Brush'],
      'tint': kAccentPlum,
    },
    <String, Object>{
      'title': 'Arctic blueprint',
      'subtitle': 'cold whites, hairline accents',
      'bg': const Color(0xFFE0F2FE),
      'sel': const Color(0xFF0C4A6E),
      'uns': const Color(0xFF38BDF8),
      'icons': <IconData>[
        Icons.architecture,
        Icons.straighten,
        Icons.grid_view,
        Icons.engineering,
      ],
      'labels': <String>['Plans', 'Measure', 'Grid', 'Crew'],
      'tint': kAccentSky,
    },
    <String, Object>{
      'title': 'Coral festival',
      'subtitle': 'high-energy reds and pinks',
      'bg': const Color(0xFFBE123C),
      'sel': const Color(0xFFFFE4E6),
      'uns': const Color(0xFFFDA4AF),
      'icons': <IconData>[
        Icons.local_fire_department,
        Icons.celebration,
        Icons.theater_comedy,
        Icons.music_note,
      ],
      'labels': <String>['Fire', 'Party', 'Show', 'Beat'],
      'tint': kAccentRose,
    },
    <String, Object>{
      'title': 'Mocha desk',
      'subtitle': 'warm neutrals, focused workspace',
      'bg': const Color(0xFF44403C),
      'sel': const Color(0xFFFEF3C7),
      'uns': const Color(0xFFD6D3D1),
      'icons': <IconData>[
        Icons.coffee,
        Icons.book,
        Icons.edit_note,
        Icons.timer,
      ],
      'labels': <String>['Brew', 'Read', 'Notes', 'Focus'],
      'tint': kAccentCoral,
    },
  ];

  final Widget gallery = Wrap(
    children: List<Widget>.generate(gallerySpec.length, (int i) {
      final Map<String, Object> s = gallerySpec[i];
      final List<IconData> icons = s['icons'] as List<IconData>;
      final List<String> labels = s['labels'] as List<String>;
      final List<BottomNavigationBarItem> gItems =
          List<BottomNavigationBarItem>.generate(icons.length, (int j) {
        return BottomNavigationBarItem(
          icon: Icon(icons[j]),
          label: labels[j],
        );
      });
      final List<Widget> gBodies =
          List<Widget>.generate(icons.length, (int j) {
        return _miniBody(
          glyph: icons[j],
          headline: labels[j],
          body: 'Gallery body for ${labels[j]}.',
          tint: s['tint'] as Color,
        );
      });
      return PhoneFrame(
        title: s['title'] as String,
        subtitle: s['subtitle'] as String,
        statusTint: s['tint'] as Color,
        width: 250.0,
        height: 470.0,
        child: _BottomNavPreview(
          items: gItems,
          bodies: gBodies,
          type: BottomNavigationBarType.fixed,
          background: s['bg'] as Color,
          selectedItemColor: s['sel'] as Color,
          unselectedItemColor: s['uns'] as Color,
          selectedFontSize: 13.0,
          unselectedFontSize: 11.0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 8.0,
          startIndex: 0,
          iconSize: 24.0,
        ),
      );
    }),
  );

  // --------------------------------------------------------------------------
  // SECTION 13 — Property reference table
  // --------------------------------------------------------------------------

  final List<Map<String, String>> propRef = <Map<String, String>>[
    <String, String>{
      'name': 'items',
      'type': 'List<BottomNavigationBarItem>',
      'desc': 'Required. 2 to many slots. Each holds icon, label, tooltip.',
    },
    <String, String>{
      'name': 'currentIndex',
      'type': 'int',
      'desc': 'Index of the active item. Defaults to 0.',
    },
    <String, String>{
      'name': 'onTap',
      'type': 'ValueChanged<int>?',
      'desc': 'Fires with the tapped index. Pair with setState.',
    },
    <String, String>{
      'name': 'type',
      'type': 'BottomNavigationBarType?',
      'desc': 'fixed | shifting. Defaults depend on item count.',
    },
    <String, String>{
      'name': 'backgroundColor',
      'type': 'Color?',
      'desc': 'Bar background. Overrides theme.',
    },
    <String, String>{
      'name': 'selectedItemColor',
      'type': 'Color?',
      'desc': 'Tint of icon + label for the active slot.',
    },
    <String, String>{
      'name': 'unselectedItemColor',
      'type': 'Color?',
      'desc': 'Tint of inactive slots.',
    },
    <String, String>{
      'name': 'selectedIconTheme',
      'type': 'IconThemeData?',
      'desc': 'Icon theme just for the active item.',
    },
    <String, String>{
      'name': 'unselectedIconTheme',
      'type': 'IconThemeData?',
      'desc': 'Icon theme for inactive items.',
    },
    <String, String>{
      'name': 'selectedLabelStyle',
      'type': 'TextStyle?',
      'desc': 'TextStyle merged with selected label.',
    },
    <String, String>{
      'name': 'unselectedLabelStyle',
      'type': 'TextStyle?',
      'desc': 'TextStyle merged with inactive label.',
    },
    <String, String>{
      'name': 'selectedFontSize',
      'type': 'double',
      'desc': 'Label font size when active. Default 14.0.',
    },
    <String, String>{
      'name': 'unselectedFontSize',
      'type': 'double',
      'desc': 'Label font size when idle. Default 12.0.',
    },
    <String, String>{
      'name': 'iconSize',
      'type': 'double',
      'desc': 'Icon size for all items. Default 24.0.',
    },
    <String, String>{
      'name': 'elevation',
      'type': 'double?',
      'desc': 'Shadow depth. Defaults to 8.0.',
    },
    <String, String>{
      'name': 'showSelectedLabels',
      'type': 'bool?',
      'desc': 'Hide labels of the active item when false.',
    },
    <String, String>{
      'name': 'showUnselectedLabels',
      'type': 'bool?',
      'desc': 'Hide labels of inactive items when false.',
    },
    <String, String>{
      'name': 'mouseCursor',
      'type': 'MouseCursor?',
      'desc': 'Cursor on hover (web/desktop).',
    },
    <String, String>{
      'name': 'enableFeedback',
      'type': 'bool?',
      'desc': 'Whether to play platform feedback on tap.',
    },
    <String, String>{
      'name': 'landscapeLayout',
      'type': 'BottomNavigationBarLandscapeLayout?',
      'desc': 'centered | linear | spread — affects landscape only.',
    },
  ];

  final Widget propTable = Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    decoration: BoxDecoration(
      color: kPaperLift,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kScrim.withValues(alpha: 0.32), width: 1.0),
    ),
    child: Column(
      children: List<Widget>.generate(propRef.length, (int i) {
        final Map<String, String> p = propRef[i];
        final bool last = i == propRef.length - 1;
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 12.0,
          ),
          decoration: BoxDecoration(
            color: i.isEven
                ? kPaperBase.withValues(alpha: 0.55)
                : kPaperLift,
            borderRadius: i == 0
                ? const BorderRadius.vertical(top: Radius.circular(15.0))
                : (last
                    ? const BorderRadius.vertical(
                        bottom: Radius.circular(15.0),
                      )
                    : BorderRadius.zero),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 150.0,
                child: Text(
                  p['name'] ?? '',
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    color: kInkDeep,
                    fontFeatures: <FontFeature>[
                      FontFeature.tabularFigures(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 200.0,
                child: Text(
                  p['type'] ?? '',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: kAccentPlum,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  p['desc'] ?? '',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: kInkSoft,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 14 — Type enum reference
  // --------------------------------------------------------------------------

  final List<BottomNavigationBarType> typeValues =
      BottomNavigationBarType.values;

  final Widget typeEnumCard = Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kInkDeep,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.fork_right, color: kAccentSky, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'BottomNavigationBarType enum',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: kPaperLift,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        ...List<Widget>.generate(typeValues.length, (int i) {
          final BottomNavigationBarType v = typeValues[i];
          final bool isFixed = v == BottomNavigationBarType.fixed;
          return Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: kBezelChrome,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: (isFixed ? kAccentSky : kAccentCoral)
                    .withValues(alpha: 0.6),
                width: 1.0,
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 36.0,
                  height: 36.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: (isFixed ? kAccentSky : kAccentCoral)
                        .withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    isFixed
                        ? Icons.view_column_outlined
                        : Icons.swap_horiz,
                    color: isFixed ? kAccentSky : kAccentCoral,
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        v.name,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: kPaperLift,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        isFixed
                            ? 'Items occupy equal width; labels always shown '
                                'by default. Use for 3-4 stable destinations.'
                            : 'Active slot grows; idle ones shrink. '
                                'item.backgroundColor takes over the bar '
                                'when an item is selected.',
                        style: const TextStyle(
                          fontSize: 11.0,
                          color: Color(0xFFCBD5E1),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 15 — Landscape layout enum reference
  // --------------------------------------------------------------------------

  final List<BottomNavigationBarLandscapeLayout> landscapeValues =
      BottomNavigationBarLandscapeLayout.values;

  final Widget landscapeEnumCard = Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kPaperLift,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kScrim.withValues(alpha: 0.32), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'BottomNavigationBarLandscapeLayout',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w800,
            color: kInkDeep,
          ),
        ),
        const SizedBox(height: 10.0),
        ...List<Widget>.generate(landscapeValues.length, (int i) {
          final BottomNavigationBarLandscapeLayout v = landscapeValues[i];
          const List<Color> tints = <Color>[
            kAccentSky,
            kAccentMint,
            kAccentPlum,
          ];
          const List<String> descs = <String>[
            'Hug the center. Bar leaves blank space on the sides.',
            'Distribute items evenly across the entire bar width.',
            'Lay icon next to label, shrinking total bar height.',
          ];
          final Color tint = tints[i % tints.length];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                    color: tint,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                const SizedBox(width: 10.0),
                SizedBox(
                  width: 100.0,
                  child: Text(
                    v.name,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: tint,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    descs[i % descs.length],
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: kInkSoft,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // SECTION 16 — Closing notes
  // --------------------------------------------------------------------------

  final Widget closing = Container(
    margin: const EdgeInsets.only(top: 18.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kInkDeep, Color(0xFF312E81)],
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.flag_outlined, color: kAccentSun, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Takeaways',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: kPaperLift,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Use BottomNavigationBar for 3-5 stable, equal-rank destinations. '
          'Pair fixed type with a calm palette for utility apps, and shifting '
          'type with bold per-item colours for branded experiences. Reach for '
          'BottomNavigationBarThemeData when you want a single source of '
          'truth across many screens. Provide tooltip strings for '
          'accessibility, set mouseCursor for web/desktop, and avoid '
          'cluttering icons with badges unless they are actionable.',
          style: TextStyle(
            fontSize: 13.0,
            height: 1.6,
            color: Color(0xFFE0E7FF),
          ),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // Compose the final scrollable scaffold.
  // --------------------------------------------------------------------------

  final Widget content = Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        titleCard,
        const SectionHeader(
          index: 1,
          title: 'Anatomy',
          subtitle:
              'The minimum surface area of a BottomNavigationBar — items, '
              'selection index, callbacks, and visual properties.',
          tint: kAccentSky,
          glyph: Icons.account_tree_outlined,
        ),
        const NarrativeBlurb(
          heading: 'Why a bottom bar at all?',
          tint: kAccentSky,
          lines: <String>[
            'It anchors top-level destinations within reach of the thumb.',
            'It survives navigation between screens — the active index is '
                'persistent across rebuilds when state is owned correctly.',
            'It is a fixed, predictable surface — never use it for actions, '
                'only for destinations.',
          ],
        ),
        anatomy,
        const SectionHeader(
          index: 2,
          title: 'Palette',
          subtitle:
              'The hand-tuned colours referenced throughout the demo. '
              'Names map to constants at the top of this script.',
          tint: kAccentMint,
          glyph: Icons.palette_outlined,
        ),
        palette,
        const SectionHeader(
          index: 3,
          title: 'BottomNavigationBarItem variants',
          subtitle:
              'Each item slot accepts an icon, an optional activeIcon, a '
              'label, and a tooltip. The active icon can be any Widget.',
          tint: kAccentCoral,
          glyph: Icons.widgets_outlined,
        ),
        const NarrativeBlurb(
          heading: 'Active icon swaps',
          tint: kAccentCoral,
          lines: <String>[
            'Pair outlined icons (idle) with filled icons (active) for a '
                'clear hover-free affordance.',
            'You can put a coloured Container, a Stack with a badge, or even '
                'a tiny custom widget into the icon and activeIcon slots.',
            'Labels are best kept short — they truncate by default and look '
                'awkward beyond about ten characters.',
          ],
        ),
        itemVariants,
        const SectionHeader(
          index: 4,
          title: 'Fixed vs Shifting',
          subtitle:
              'Two foundational layouts. Fixed distributes evenly; shifting '
              'animates the active slot and adopts the item background.',
          tint: kAccentPlum,
          glyph: Icons.swap_horiz,
        ),
        const NarrativeBlurb(
          heading: 'Choosing a type',
          tint: kAccentPlum,
          lines: <String>[
            'Fixed: predictable, perfect for 3-4 utility destinations.',
            'Shifting: dramatic, suits branded media or social experiences.',
            'Shifting requires a backgroundColor on each item to look right.',
          ],
        ),
        fixedVsShifting,
        typeEnumCard,
        const SectionHeader(
          index: 5,
          title: 'Theming',
          subtitle:
              'BottomNavigationBarThemeData centralises tint, fonts, icon '
              'sizes, and the cursor across an entire screen tree.',
          tint: kAccentSun,
          glyph: Icons.format_paint_outlined,
        ),
        const NarrativeBlurb(
          heading: 'Theme data wins',
          tint: kAccentSun,
          lines: <String>[
            'Set selectedIconTheme / unselectedIconTheme for per-state icons.',
            'selectedLabelStyle and unselectedLabelStyle let you set weight, '
                'spacing, and font features in one place.',
            'mouseCursor uses WidgetStateProperty when sourced from theme.',
          ],
        ),
        themedRow,
        const SectionHeader(
          index: 6,
          title: 'Font sizing',
          subtitle:
              'selectedFontSize and unselectedFontSize tune the label '
              'typography. Defaults are 14.0 and 12.0.',
          tint: kAccentRose,
          glyph: Icons.text_fields_outlined,
        ),
        sizeMatrix,
        const SectionHeader(
          index: 7,
          title: 'Badge decoration',
          subtitle:
              'There is no built-in badge — compose a Stack inside icon. The '
              '_BadgedIcon helper here demonstrates a reusable pattern.',
          tint: kAccentRose,
          glyph: Icons.notifications_active_outlined,
        ),
        const NarrativeBlurb(
          heading: 'Anatomy of a badge',
          tint: kAccentRose,
          lines: <String>[
            'A SizedBox with a Stack — icon centred, badge in the top-right.',
            'Clip behaviour set to none so the badge can overhang.',
            'A subtle white border separates the badge from the bar.',
          ],
        ),
        badgedPreview,
        const SectionHeader(
          index: 8,
          title: 'Landscape layout',
          subtitle:
              'Three landscape arrangements — centered, linear, spread. '
              'Affects only landscape orientations.',
          tint: kAccentSky,
          glyph: Icons.stay_current_landscape,
        ),
        landscapeRow,
        landscapeEnumCard,
        const SectionHeader(
          index: 9,
          title: 'Cursor & tooltip',
          subtitle:
              'mouseCursor controls the hover pointer on web and desktop. '
              'Each item carries an optional tooltip string.',
          tint: kAccentMint,
          glyph: Icons.mouse_outlined,
        ),
        cursorRow,
        const SectionHeader(
          index: 10,
          title: 'Label visibility',
          subtitle:
              'showSelectedLabels and showUnselectedLabels can be combined '
              'four ways. Each has a distinct visual rhythm.',
          tint: kAccentCoral,
          glyph: Icons.label_outlined,
        ),
        labelMatrix,
        const SectionHeader(
          index: 11,
          title: 'Gallery',
          subtitle:
              'Six end-to-end stylings showcasing how palette choices and '
              'icon families combine into very different brand voices.',
          tint: kAccentPlum,
          glyph: Icons.collections_outlined,
        ),
        gallery,
        const SectionHeader(
          index: 12,
          title: 'Property reference',
          subtitle:
              'Every public property on BottomNavigationBar in one table.',
          tint: kAccentSky,
          glyph: Icons.list_alt,
        ),
        propTable,
        closing,
      ],
    ),
  );

  return Scaffold(
    backgroundColor: kPaperBase,
    body: SafeArea(
      child: SingleChildScrollView(
        child: content,
      ),
    ),
  );
}

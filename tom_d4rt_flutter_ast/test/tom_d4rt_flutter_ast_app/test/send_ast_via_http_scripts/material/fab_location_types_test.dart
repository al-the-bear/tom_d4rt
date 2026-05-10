// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
// FloatingActionButtonLocation — Hand-Authored Visual Deep Demo
// =====================================================================
//
// This file is a one-off visual demo for the D4rt analyzer-free interpreter
// test corpus. It walks through every standard FloatingActionButtonLocation,
// the mini-variants, the docked notch interaction with BottomAppBar, and a
// short tour of the FloatingActionButtonAnimator concept.
//
// All "phones" in this demo are MOCK Scaffolds: styled containers that mimic
// the look of a Scaffold so we can hand-place a tiny FAB silhouette at the
// exact geometry that each location constant would yield in the real layout.
//
// =====================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Palette and design constants used throughout the demo.
// ---------------------------------------------------------------------
const Color _kBackdrop = Color(0xFFF5F1EA);
const Color _kSurface = Color(0xFFFFFFFF);
const Color _kSurfaceAlt = Color(0xFFFBF5E8);
const Color _kInk = Color(0xFF1F2933);
const Color _kInkSoft = Color(0xFF52606D);
const Color _kAccent = Color(0xFF2962FF);
const Color _kAccentDeep = Color(0xFF0039CB);
const Color _kPositive = Color(0xFF1B998B);
const Color _kWarn = Color(0xFFE07A5F);
const Color _kHairline = Color(0xFFE3DDD0);
const Color _kPhoneShell = Color(0xFF2B2D34);
const Color _kPhoneScreen = Color(0xFFFAFAFA);
const Color _kAppBarBand = Color(0xFF3D5AFE);

// Mock phone metrics — we render these as simple rounded containers.
const double _kPhoneWidth = 134.0;
const double _kPhoneHeight = 240.0;
const double _kPhoneRadius = 18.0;
const double _kAppBarHeight = 24.0;
const double _kBottomBarHeight = 28.0;
const double _kFabSize = 26.0;
const double _kMiniFabSize = 18.0;

// ---------------------------------------------------------------------
// Public entry point for the D4rt visual harness.
// ---------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'FAB Location Visual Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _kBackdrop,
      primaryColor: _kAccent,
      fontFamily: 'Roboto',
    ),
    home: Scaffold(
      backgroundColor: _kBackdrop,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PrivateHeroCard(),
              SizedBox(height: 28.0),
              _PrivateSectionTitle(
                index: '01',
                title: 'Standard FAB Locations',
                subtitle:
                    'A guided tour of the eighteen built-in FloatingActionButtonLocation constants.',
              ),
              SizedBox(height: 16.0),
              _PrivateStandardLocationsGrid(),
              SizedBox(height: 28.0),
              _PrivateSectionTitle(
                index: '02',
                title: 'Mini Variants',
                subtitle:
                    'The mini* family is identical in geometry but tuned for FloatingActionButton.small (40dp).',
              ),
              SizedBox(height: 16.0),
              _PrivateMiniLocationsGrid(),
              SizedBox(height: 28.0),
              _PrivateSectionTitle(
                index: '03',
                title: 'Anatomy of a Scaffold',
                subtitle:
                    'How the Scaffold composes its slots and where the FAB lives in that layered cake.',
              ),
              SizedBox(height: 16.0),
              _PrivateAnatomyCard(),
              SizedBox(height: 28.0),
              _PrivateSectionTitle(
                index: '04',
                title: 'Comparison Table',
                subtitle:
                    'A sortable-looking matrix of every location with edge, dock, mini, and top properties.',
              ),
              SizedBox(height: 16.0),
              _PrivateComparisonTable(),
              SizedBox(height: 28.0),
              _PrivateSectionTitle(
                index: '05',
                title: 'BottomAppBar + Docked FAB Notch',
                subtitle:
                    'The classic Material 2 silhouette: a bottom bar with a circular cut-out and a docked FAB.',
              ),
              SizedBox(height: 16.0),
              _PrivateNotchDemo(),
              SizedBox(height: 28.0),
              _PrivateSectionTitle(
                index: '06',
                title: 'Realistic Code Listing',
                subtitle:
                    'A complete, idiomatic Scaffold using endDocked plus a notched BottomAppBar.',
              ),
              SizedBox(height: 16.0),
              _PrivateCodeListingCard(),
              SizedBox(height: 28.0),
              _PrivateSectionTitle(
                index: '07',
                title: 'Animator Tour',
                subtitle:
                    'A quick description of FloatingActionButtonAnimator — no real animation, just shape.',
              ),
              SizedBox(height: 16.0),
              _PrivateAnimatorCard(),
              SizedBox(height: 28.0),
              _PrivateSectionTitle(
                index: '08',
                title: 'Pitfalls and Gotchas',
                subtitle:
                    'Hard-won knowledge: where the FAB collides with the AppBar, where mini matters, and how to subclass.',
              ),
              SizedBox(height: 16.0),
              _PrivatePitfallsCard(),
              SizedBox(height: 28.0),
              _PrivateSectionTitle(
                index: '09',
                title: 'Palette and Footer',
                subtitle: 'Demo palette, version banner, and acknowledgements.',
              ),
              SizedBox(height: 16.0),
              _PrivateFooter(),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
// HERO CARD
// =====================================================================
class _PrivateHeroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A237E), Color(0xFF3949AB), Color(0xFF5C6BC0)],
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF1A237E).withValues(alpha: 0.25),
            blurRadius: 22.0,
            offset: Offset(0.0, 12.0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    'flutter / material / FloatingActionButtonLocation',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 11.0,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'FAB Locations,\nfrom edge to dock.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 14.0),
                Text(
                  'Eighteen named positions, three vertical bands (top, float, docked), '
                  'three horizontal alignments (start, center, end), all available in '
                  'standard and mini sizing — and one extra: endContained.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13.0,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    _PrivateHeroChip(label: '18 constants', icon: Icons.tag),
                    SizedBox(width: 8.0),
                    _PrivateHeroChip(label: '6 mini', icon: Icons.bubble_chart),
                    SizedBox(width: 8.0),
                    _PrivateHeroChip(
                        label: '3 docked', icon: Icons.vertical_align_bottom),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 20.0),
          _PrivateHeroSilhouette(),
        ],
      ),
    );
  }
}

class _PrivateHeroChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _PrivateHeroChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.0, color: Colors.white),
          SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateHeroSilhouette extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140.0,
      height: 140.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 130.0,
            height: 130.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 96.0,
            height: 96.0,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFF59D), Color(0xFFFFD54F)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 14.0,
                  offset: Offset(0.0, 6.0),
                ),
              ],
            ),
            child: Icon(Icons.add, color: _kInk, size: 30.0),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION TITLE
// =====================================================================
class _PrivateSectionTitle extends StatelessWidget {
  final String index;
  final String title;
  final String subtitle;

  const _PrivateSectionTitle({
    required this.index,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kAccent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withValues(alpha: 0.3)),
          ),
          child: Text(
            index,
            style: TextStyle(
              color: _kAccentDeep,
              fontWeight: FontWeight.w700,
              fontSize: 13.0,
            ),
          ),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: _kInk,
                  fontWeight: FontWeight.w800,
                  fontSize: 19.0,
                  letterSpacing: -0.3,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: _kInkSoft,
                  fontSize: 13.0,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION 1 — STANDARD LOCATIONS GRID
// =====================================================================
class _PrivateStandardLocationsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locations = <_PrivateLocationSpec>[
      _PrivateLocationSpec('startTop', _PrivateBand.top, _PrivateAlign.start),
      _PrivateLocationSpec('centerTop', _PrivateBand.top, _PrivateAlign.center),
      _PrivateLocationSpec('endTop', _PrivateBand.top, _PrivateAlign.end),
      _PrivateLocationSpec(
          'startFloat', _PrivateBand.floatBand, _PrivateAlign.start),
      _PrivateLocationSpec(
          'centerFloat', _PrivateBand.floatBand, _PrivateAlign.center),
      _PrivateLocationSpec(
          'endFloat', _PrivateBand.floatBand, _PrivateAlign.end),
      _PrivateLocationSpec(
          'startDocked', _PrivateBand.docked, _PrivateAlign.start),
      _PrivateLocationSpec(
          'centerDocked', _PrivateBand.docked, _PrivateAlign.center),
      _PrivateLocationSpec(
          'endDocked', _PrivateBand.docked, _PrivateAlign.end),
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14.0,
            offset: Offset(0.0, 6.0),
          ),
        ],
      ),
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.grid_view_rounded, size: 16.0, color: _kAccentDeep),
              SizedBox(width: 8.0),
              Text(
                'Nine standard placements (3 bands × 3 alignments)',
                style: TextStyle(
                  color: _kInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          Wrap(
            spacing: 14.0,
            runSpacing: 14.0,
            children: locations
                .map((spec) => _PrivatePhoneMockup(spec: spec, mini: false))
                .toList(),
          ),
          SizedBox(height: 14.0),
          _PrivateLegend(),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 2 — MINI LOCATIONS GRID
// =====================================================================
class _PrivateMiniLocationsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locations = <_PrivateLocationSpec>[
      _PrivateLocationSpec(
          'miniStartTop', _PrivateBand.top, _PrivateAlign.start),
      _PrivateLocationSpec(
          'miniCenterTop', _PrivateBand.top, _PrivateAlign.center),
      _PrivateLocationSpec('miniEndTop', _PrivateBand.top, _PrivateAlign.end),
      _PrivateLocationSpec(
          'miniStartFloat', _PrivateBand.floatBand, _PrivateAlign.start),
      _PrivateLocationSpec(
          'miniCenterFloat', _PrivateBand.floatBand, _PrivateAlign.center),
      _PrivateLocationSpec(
          'miniEndFloat', _PrivateBand.floatBand, _PrivateAlign.end),
      _PrivateLocationSpec(
          'miniStartDocked', _PrivateBand.docked, _PrivateAlign.start),
      _PrivateLocationSpec(
          'miniCenterDocked', _PrivateBand.docked, _PrivateAlign.center),
      _PrivateLocationSpec(
          'miniEndDocked', _PrivateBand.docked, _PrivateAlign.end),
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: _kHairline),
      ),
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bubble_chart, size: 16.0, color: _kPositive),
              SizedBox(width: 8.0),
              Text(
                'Mini variants — pair with FloatingActionButton.small',
                style: TextStyle(
                  color: _kInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'A standard FAB is 56dp; a mini FAB is 40dp. The mini* locations '
            'shift the FAB closer to the edge to compensate for the smaller '
            'visual mass — the offset rules are encoded in the location, not '
            'the button.',
            style: TextStyle(
              color: _kInkSoft,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
          SizedBox(height: 14.0),
          Wrap(
            spacing: 14.0,
            runSpacing: 14.0,
            children: locations
                .map((spec) => _PrivatePhoneMockup(spec: spec, mini: true))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// PHONE MOCKUP
// =====================================================================
enum _PrivateBand { top, floatBand, docked }

enum _PrivateAlign { start, center, end }

class _PrivateLocationSpec {
  final String name;
  final _PrivateBand band;
  final _PrivateAlign align;
  const _PrivateLocationSpec(this.name, this.band, this.align);
}

class _PrivatePhoneMockup extends StatelessWidget {
  final _PrivateLocationSpec spec;
  final bool mini;

  const _PrivatePhoneMockup({required this.spec, required this.mini});

  Offset _resolveFabOffset() {
    final fab = mini ? _kMiniFabSize : _kFabSize;
    const double inset = 8.0;
    double dx;
    switch (spec.align) {
      case _PrivateAlign.start:
        dx = inset;
        break;
      case _PrivateAlign.center:
        dx = (_kPhoneWidth - fab) / 2.0;
        break;
      case _PrivateAlign.end:
        dx = _kPhoneWidth - fab - inset;
        break;
    }
    double dy;
    switch (spec.band) {
      case _PrivateBand.top:
        // Hanging off the AppBar's lower edge.
        dy = _kAppBarHeight - fab / 2.0;
        break;
      case _PrivateBand.floatBand:
        // Floating above the bottom bar / page bottom.
        dy = _kPhoneHeight - _kBottomBarHeight - fab - 6.0;
        break;
      case _PrivateBand.docked:
        // Straddling the bottom bar's top edge.
        dy = _kPhoneHeight - _kBottomBarHeight - fab / 2.0;
        break;
    }
    return Offset(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    final fab = mini ? _kMiniFabSize : _kFabSize;
    final offset = _resolveFabOffset();
    return Column(
      children: [
        Container(
          width: _kPhoneWidth + 8.0,
          height: _kPhoneHeight + 8.0,
          decoration: BoxDecoration(
            color: _kPhoneShell,
            borderRadius: BorderRadius.circular(_kPhoneRadius + 4.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 10.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          padding: EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_kPhoneRadius),
            child: Container(
              width: _kPhoneWidth,
              height: _kPhoneHeight,
              color: _kPhoneScreen,
              child: Stack(
                children: [
                  // AppBar band
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: 0.0,
                    height: _kAppBarHeight,
                    child: Container(
                      color: _kAppBarBand,
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 50.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                  ),
                  // Body (faint placeholder lines)
                  Positioned(
                    left: 8.0,
                    right: 8.0,
                    top: _kAppBarHeight + 10.0,
                    bottom: _kBottomBarHeight + 10.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _PrivateBodyLine(width: 0.85),
                        SizedBox(height: 4.0),
                        _PrivateBodyLine(width: 0.7),
                        SizedBox(height: 4.0),
                        _PrivateBodyLine(width: 0.9),
                        SizedBox(height: 4.0),
                        _PrivateBodyLine(width: 0.6),
                        SizedBox(height: 4.0),
                        _PrivateBodyLine(width: 0.8),
                        SizedBox(height: 4.0),
                        _PrivateBodyLine(width: 0.55),
                      ],
                    ),
                  ),
                  // Bottom bar
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    height: _kBottomBarHeight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFECEFF1),
                        border: Border(
                          top: BorderSide(color: _kHairline),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.home, size: 12.0, color: _kInkSoft),
                          Icon(Icons.search, size: 12.0, color: _kInkSoft),
                          Icon(Icons.notifications,
                              size: 12.0, color: _kInkSoft),
                          Icon(Icons.person, size: 12.0, color: _kInkSoft),
                        ],
                      ),
                    ),
                  ),
                  // FAB silhouette positioned per spec.
                  Positioned(
                    left: offset.dx,
                    top: offset.dy,
                    width: fab,
                    height: fab,
                    child: _PrivateFakeFab(size: fab),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          width: _kPhoneWidth + 8.0,
          alignment: Alignment.center,
          child: Text(
            spec.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _kInk,
              fontWeight: FontWeight.w600,
              fontSize: 11.5,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }
}

class _PrivateBodyLine extends StatelessWidget {
  final double width;
  const _PrivateBodyLine({required this.width});
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: width,
      child: Container(
        height: 4.0,
        decoration: BoxDecoration(
          color: _kHairline,
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
    );
  }
}

class _PrivateFakeFab extends StatelessWidget {
  final double size;
  const _PrivateFakeFab({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _kAccent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: _kAccent.withValues(alpha: 0.4),
            blurRadius: 6.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: size * 0.55,
      ),
    );
  }
}

class _PrivateLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14.0,
      runSpacing: 8.0,
      children: [
        _PrivateLegendChip(color: _kAccent, label: 'FAB silhouette'),
        _PrivateLegendChip(color: _kAppBarBand, label: 'AppBar band'),
        _PrivateLegendChip(color: Color(0xFFECEFF1), label: 'BottomAppBar'),
        _PrivateLegendChip(color: _kHairline, label: 'Body lines (filler)'),
      ],
    );
  }
}

class _PrivateLegendChip extends StatelessWidget {
  final Color color;
  final String label;
  const _PrivateLegendChip({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.0,
          height: 12.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3.0),
            border: Border.all(color: _kHairline),
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(color: _kInkSoft, fontSize: 11.5),
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION 3 — ANATOMY OF A SCAFFOLD
// =====================================================================
class _PrivateAnatomyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: _kHairline),
      ),
      padding: EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PrivateAnatomyDiagram(),
          SizedBox(width: 22.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Slot map',
                  style: TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 10.0),
                _PrivateAnatomyRow(
                  swatch: _kAppBarBand,
                  title: 'appBar',
                  desc: 'PreferredSizeWidget at the top — typically AppBar.',
                ),
                _PrivateAnatomyRow(
                  swatch: Color(0xFFFFF59D),
                  title: 'body',
                  desc:
                      'The primary content. Sized below appBar and above the bottom slot.',
                ),
                _PrivateAnatomyRow(
                  swatch: Color(0xFFECEFF1),
                  title: 'bottomNavigationBar / BottomAppBar',
                  desc:
                      'A docked widget at the bottom; the FAB notch lives here.',
                ),
                _PrivateAnatomyRow(
                  swatch: _kAccent,
                  title: 'floatingActionButton',
                  desc: 'A persistent, prominent action for the screen.',
                ),
                _PrivateAnatomyRow(
                  swatch: _kPositive,
                  title: 'floatingActionButtonLocation',
                  desc:
                      'A FloatingActionButtonLocation that resolves a coordinate from layout geometry.',
                ),
                _PrivateAnatomyRow(
                  swatch: _kWarn,
                  title: 'floatingActionButtonAnimator',
                  desc:
                      'Drives the entry/exit/move animation of the FAB. Defaults to scaling.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateAnatomyRow extends StatelessWidget {
  final Color swatch;
  final String title;
  final String desc;
  const _PrivateAnatomyRow({
    required this.swatch,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12.0,
            height: 12.0,
            margin: EdgeInsets.only(top: 3.0),
            decoration: BoxDecoration(
              color: swatch,
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(color: _kHairline),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: _kInkSoft,
                  fontSize: 12.5,
                  height: 1.4,
                ),
                children: [
                  TextSpan(
                    text: '$title — ',
                    style: TextStyle(
                      color: _kInk,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                    ),
                  ),
                  TextSpan(text: desc),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateAnatomyDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.0,
      height: 270.0,
      decoration: BoxDecoration(
        color: _kPhoneShell,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          color: _kPhoneScreen,
          child: Stack(
            children: [
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 0.0,
                height: 38.0,
                child: Container(
                  color: _kAppBarBand,
                  alignment: Alignment.center,
                  child: Text(
                    'appBar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 38.0,
                bottom: 38.0,
                child: Container(
                  color: Color(0xFFFFF59D).withValues(alpha: 0.4),
                  alignment: Alignment.center,
                  child: Text(
                    'body',
                    style: TextStyle(
                      color: _kInk,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                height: 38.0,
                child: Container(
                  color: Color(0xFFECEFF1),
                  alignment: Alignment.center,
                  child: Text(
                    'BottomAppBar',
                    style: TextStyle(
                      color: _kInkSoft,
                      fontSize: 10.0,
                      letterSpacing: 0.4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 14.0,
                bottom: 22.0,
                width: 32.0,
                height: 32.0,
                child: _PrivateFakeFab(size: 32.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 4 — COMPARISON TABLE
// =====================================================================
class _PrivateComparisonTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rows = <_PrivateTableRow>[
      _PrivateTableRow('startTop', 'start', false, false, true),
      _PrivateTableRow('centerTop', 'center', false, false, true),
      _PrivateTableRow('endTop', 'end', false, false, true),
      _PrivateTableRow('startFloat', 'start', false, false, false),
      _PrivateTableRow('centerFloat', 'center', false, false, false),
      _PrivateTableRow('endFloat', 'end', false, false, false),
      _PrivateTableRow('startDocked', 'start', true, false, false),
      _PrivateTableRow('centerDocked', 'center', true, false, false),
      _PrivateTableRow('endDocked', 'end', true, false, false),
      _PrivateTableRow('miniStartTop', 'start', false, true, true),
      _PrivateTableRow('miniCenterTop', 'center', false, true, true),
      _PrivateTableRow('miniEndTop', 'end', false, true, true),
      _PrivateTableRow('miniStartFloat', 'start', false, true, false),
      _PrivateTableRow('miniCenterFloat', 'center', false, true, false),
      _PrivateTableRow('miniEndFloat', 'end', false, true, false),
      _PrivateTableRow('miniStartDocked', 'start', true, true, false),
      _PrivateTableRow('miniCenterDocked', 'center', true, true, false),
      _PrivateTableRow('miniEndDocked', 'end', true, true, false),
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: _kHairline),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PrivateComparisonHeader(),
          Container(height: 1.0, color: _kHairline),
          for (int i = 0; i < rows.length; i++)
            _PrivateComparisonDataRow(
              row: rows[i],
              alt: i.isOdd,
            ),
        ],
      ),
    );
  }
}

class _PrivateTableRow {
  final String name;
  final String edge;
  final bool docked;
  final bool mini;
  final bool top;
  const _PrivateTableRow(
      this.name, this.edge, this.docked, this.mini, this.top);
}

class _PrivateComparisonHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: _PrivateColumnHeader(label: 'name', sortable: true),
          ),
          Expanded(flex: 2, child: _PrivateColumnHeader(label: 'edge')),
          Expanded(flex: 2, child: _PrivateColumnHeader(label: 'docked?')),
          Expanded(flex: 2, child: _PrivateColumnHeader(label: 'mini?')),
          Expanded(flex: 2, child: _PrivateColumnHeader(label: 'top?')),
        ],
      ),
    );
  }
}

class _PrivateColumnHeader extends StatelessWidget {
  final String label;
  final bool sortable;
  const _PrivateColumnHeader({required this.label, this.sortable = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: _kInk,
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
            letterSpacing: 0.5,
          ),
        ),
        if (sortable) ...[
          SizedBox(width: 4.0),
          Icon(Icons.arrow_drop_down, size: 14.0, color: _kInkSoft),
        ],
      ],
    );
  }
}

class _PrivateComparisonDataRow extends StatelessWidget {
  final _PrivateTableRow row;
  final bool alt;
  const _PrivateComparisonDataRow({required this.row, required this.alt});

  Widget _yes(bool v) {
    return Row(
      children: [
        Icon(
          v ? Icons.check_circle : Icons.remove_circle_outline,
          size: 14.0,
          color: v ? _kPositive : _kInkSoft.withValues(alpha: 0.5),
        ),
        SizedBox(width: 4.0),
        Text(
          v ? 'yes' : 'no',
          style: TextStyle(
            color: v ? _kPositive : _kInkSoft,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: alt ? _kSurfaceAlt : Colors.transparent,
      ),
      padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              row.name,
              style: TextStyle(
                color: _kInk,
                fontFamily: 'monospace',
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              row.edge,
              style: TextStyle(color: _kInkSoft, fontSize: 11.5),
            ),
          ),
          Expanded(flex: 2, child: _yes(row.docked)),
          Expanded(flex: 2, child: _yes(row.mini)),
          Expanded(flex: 2, child: _yes(row.top)),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 5 — NOTCH DEMO
// =====================================================================
class _PrivateNotchDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: _kHairline),
      ),
      padding: EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PrivateNotchedDevice(),
          SizedBox(width: 22.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BottomAppBar.shape + notchMargin',
                  style: TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w800,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'When the FAB is docked into a BottomAppBar, the bar can clip '
                  'a circular notch around the FAB. Set the BottomAppBar.shape '
                  'to a CircularNotchedRectangle and configure notchMargin '
                  '(default 4.0) to control the breathing room between the FAB '
                  'and the notch edge.',
                  style: TextStyle(
                    color: _kInkSoft,
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 14.0),
                _PrivateBulletPoint(
                    'shape: CircularNotchedRectangle() — cuts a circle.'),
                _PrivateBulletPoint(
                    'shape: AutomaticNotchedShape(...) — composes two ShapeBorders.'),
                _PrivateBulletPoint(
                    'notchMargin: 4.0 (default) — space between FAB and bar.'),
                _PrivateBulletPoint(
                    'Pair docked locations only: endDocked, centerDocked, etc.'),
                _PrivateBulletPoint(
                    'On Material 3, BottomAppBar prefers no notch by default.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateBulletPoint extends StatelessWidget {
  final String text;
  const _PrivateBulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6.0,
            height: 6.0,
            margin: EdgeInsets.only(top: 6.0, right: 8.0),
            decoration: BoxDecoration(
              color: _kAccent,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: _kInkSoft,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateNotchedDevice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 320.0,
      decoration: BoxDecoration(
        color: _kPhoneShell,
        borderRadius: BorderRadius.circular(22.0),
      ),
      padding: EdgeInsets.all(6.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          color: _kPhoneScreen,
          child: Stack(
            children: [
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 0.0,
                height: 36.0,
                child: Container(
                  color: _kAccent,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(Icons.menu, color: Colors.white, size: 16.0),
                      SizedBox(width: 8.0),
                      Text(
                        'Inbox',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.search, color: Colors.white, size: 16.0),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                top: 36.0,
                bottom: 56.0,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _PrivateMailRow(),
                      SizedBox(height: 6.0),
                      _PrivateMailRow(),
                      SizedBox(height: 6.0),
                      _PrivateMailRow(),
                      SizedBox(height: 6.0),
                      _PrivateMailRow(),
                      SizedBox(height: 6.0),
                      _PrivateMailRow(),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                height: 56.0,
                child: CustomPaint(
                  painter: _PrivateNotchPainter(),
                  child: SizedBox.expand(),
                ),
              ),
              // The docked endDocked FAB itself.
              Positioned(
                right: 18.0,
                bottom: 32.0,
                width: 44.0,
                height: 44.0,
                child: _PrivateFakeFab(size: 44.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrivateMailRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: _kHairline),
      ),
      child: Row(
        children: [
          Container(
            width: 18.0,
            height: 18.0,
            decoration: BoxDecoration(
              color: _kAccent.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 4.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    color: _kInkSoft.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                SizedBox(height: 3.0),
                Container(
                  height: 3.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    color: _kHairline,
                    borderRadius: BorderRadius.circular(2.0),
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

class _PrivateNotchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFECEFF1)
      ..style = PaintingStyle.fill;

    // Notch geometry: a half-circle on the top edge, slightly right of center.
    const double notchRadius = 28.0;
    final double centerX = size.width - 18.0 - 22.0; // align to FAB right=18, fab=44
    final double topY = 0.0;

    final Path path = Path();
    path.moveTo(0.0, topY);
    path.lineTo(centerX - notchRadius, topY);
    // Curve up over the FAB:
    path.arcToPoint(
      Offset(centerX + notchRadius, topY),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(size.width, topY);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Top hairline border.
    final border = Paint()
      ..color = _kHairline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final Path borderPath = Path();
    borderPath.moveTo(0.0, topY);
    borderPath.lineTo(centerX - notchRadius, topY);
    borderPath.arcToPoint(
      Offset(centerX + notchRadius, topY),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    borderPath.lineTo(size.width, topY);
    canvas.drawPath(borderPath, border);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// SECTION 6 — CODE LISTING CARD
// =====================================================================
class _PrivateCodeListingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lines = <_PrivateCodeLine>[
      _PrivateCodeLine('Scaffold(', _PrivateTokenKind.keyword),
      _PrivateCodeLine('  appBar: AppBar(', _PrivateTokenKind.normal),
      _PrivateCodeLine(
          "    title: const Text('Compose'),", _PrivateTokenKind.string),
      _PrivateCodeLine('  ),', _PrivateTokenKind.normal),
      _PrivateCodeLine('  body: const _MessageList(),', _PrivateTokenKind.normal),
      _PrivateCodeLine('  bottomNavigationBar: BottomAppBar(',
          _PrivateTokenKind.normal),
      _PrivateCodeLine(
          '    shape: const CircularNotchedRectangle(),',
          _PrivateTokenKind.normal),
      _PrivateCodeLine('    notchMargin: 6.0,', _PrivateTokenKind.number),
      _PrivateCodeLine('    child: Row(', _PrivateTokenKind.normal),
      _PrivateCodeLine(
          '      mainAxisAlignment: MainAxisAlignment.spaceAround,',
          _PrivateTokenKind.normal),
      _PrivateCodeLine('      children: const [', _PrivateTokenKind.normal),
      _PrivateCodeLine(
          '        Icon(Icons.menu),', _PrivateTokenKind.normal),
      _PrivateCodeLine(
          '        Icon(Icons.search),', _PrivateTokenKind.normal),
      _PrivateCodeLine(
          '        Icon(Icons.notifications),', _PrivateTokenKind.normal),
      _PrivateCodeLine('      ],', _PrivateTokenKind.normal),
      _PrivateCodeLine('    ),', _PrivateTokenKind.normal),
      _PrivateCodeLine('  ),', _PrivateTokenKind.normal),
      _PrivateCodeLine('  floatingActionButton: FloatingActionButton(',
          _PrivateTokenKind.normal),
      _PrivateCodeLine('    onPressed: _onCompose,', _PrivateTokenKind.normal),
      _PrivateCodeLine(
          "    tooltip: 'Compose',", _PrivateTokenKind.string),
      _PrivateCodeLine(
          '    child: const Icon(Icons.add),', _PrivateTokenKind.normal),
      _PrivateCodeLine('  ),', _PrivateTokenKind.normal),
      _PrivateCodeLine(
          '  floatingActionButtonLocation:', _PrivateTokenKind.normal),
      _PrivateCodeLine(
          '      FloatingActionButtonLocation.endDocked,',
          _PrivateTokenKind.highlight),
      _PrivateCodeLine(
          '  floatingActionButtonAnimator:', _PrivateTokenKind.normal),
      _PrivateCodeLine(
          '      FloatingActionButtonAnimator.scaling,',
          _PrivateTokenKind.normal),
      _PrivateCodeLine('),', _PrivateTokenKind.normal),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF20232A),
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFF5F56),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFFBD2E),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: Color(0xFF27C93F),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 14.0),
              Text(
                'compose_screen.dart',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Container(height: 1.0, color: Colors.white.withValues(alpha: 0.1)),
          SizedBox(height: 8.0),
          for (int i = 0; i < lines.length; i++)
            _PrivateCodeRow(line: lines[i], lineNumber: i + 1),
        ],
      ),
    );
  }
}

enum _PrivateTokenKind { normal, keyword, string, number, highlight }

class _PrivateCodeLine {
  final String text;
  final _PrivateTokenKind kind;
  const _PrivateCodeLine(this.text, this.kind);
}

class _PrivateCodeRow extends StatelessWidget {
  final _PrivateCodeLine line;
  final int lineNumber;
  const _PrivateCodeRow({required this.line, required this.lineNumber});

  Color _color() {
    switch (line.kind) {
      case _PrivateTokenKind.keyword:
        return Color(0xFFC678DD);
      case _PrivateTokenKind.string:
        return Color(0xFF98C379);
      case _PrivateTokenKind.number:
        return Color(0xFFD19A66);
      case _PrivateTokenKind.highlight:
        return Color(0xFFE5C07B);
      case _PrivateTokenKind.normal:
        return Color(0xFFABB2BF);
    }
  }

  @override
  Widget build(BuildContext context) {
    final highlight = line.kind == _PrivateTokenKind.highlight;
    return Container(
      decoration: BoxDecoration(
        color: highlight
            ? Color(0xFFE5C07B).withValues(alpha: 0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 28.0,
            child: Text(
              '$lineNumber',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.3),
                fontSize: 11.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Text(
              line.text,
              style: TextStyle(
                color: _color(),
                fontSize: 12.0,
                fontFamily: 'monospace',
                height: 1.45,
                fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 7 — ANIMATOR CARD
// =====================================================================
class _PrivateAnimatorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: _kHairline),
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FloatingActionButtonAnimator',
            style: TextStyle(
              color: _kInk,
              fontWeight: FontWeight.w800,
              fontSize: 15.5,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'When the FAB enters, exits, or moves between locations, the Scaffold '
            'consults its floatingActionButtonAnimator to compute the geometry. '
            'Two static animators are bundled with the framework:',
            style: TextStyle(
              color: _kInkSoft,
              fontSize: 13.0,
              height: 1.5,
            ),
          ),
          SizedBox(height: 14.0),
          Row(
            children: [
              Expanded(
                child: _PrivateAnimatorTile(
                  name: 'scaling',
                  desc:
                      'The default. Shrinks/grows from a central point and fades. '
                      'On a move, the FAB shrinks to nothing at the old position '
                      'and grows back at the new one.',
                  badge: 'default',
                ),
              ),
              SizedBox(width: 14.0),
              Expanded(
                child: _PrivateAnimatorTile(
                  name: 'noAnimation',
                  desc:
                      'Snaps the FAB to its target position without scaling. '
                      'Useful when you want a hard cut between locations or are '
                      'driving your own motion.',
                  badge: 'instant',
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: _kSurfaceAlt,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: _kHairline),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline,
                    size: 16.0, color: _kAccentDeep),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'You can subclass FloatingActionButtonAnimator to author your '
                    'own. Override getOffset, getAnimationRestart, and the various '
                    'Animatables to drive entry/exit/move curves. Most apps stay on '
                    'scaling.',
                    style: TextStyle(
                      color: _kInkSoft,
                      fontSize: 12.0,
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
}

class _PrivateAnimatorTile extends StatelessWidget {
  final String name;
  final String desc;
  final String badge;
  const _PrivateAnimatorTile({
    required this.name,
    required this.desc,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kHairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(
                  color: _kInk,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 13.0,
                ),
              ),
              SizedBox(width: 8.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: _kAccent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: _kAccentDeep,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            desc,
            style: TextStyle(
              color: _kInkSoft,
              fontSize: 12.0,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 8 — PITFALLS
// =====================================================================
class _PrivatePitfallsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: _kHairline),
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PrivatePitfallRow(
            icon: Icons.warning_amber_rounded,
            color: _kWarn,
            title: 'top variants overlap with AppBar on small screens',
            desc:
                'startTop / centerTop / endTop dock the FAB on the AppBar boundary. '
                'When AppBar.toolbarHeight is reduced or the AppBar is null, the '
                'FAB can clip the body. Plan for either a tall AppBar or use float.',
          ),
          _PrivateDivider(),
          _PrivatePitfallRow(
            icon: Icons.straighten,
            color: _kAccent,
            title: 'standard FAB is 56dp; mini is 40dp',
            desc:
                'Using a FloatingActionButton.small with a non-mini location is '
                'visually offset from the edge. Use a mini* location alongside '
                'mini buttons; otherwise the spacing looks wrong.',
          ),
          _PrivateDivider(),
          _PrivatePitfallRow(
            icon: Icons.extension,
            color: _kPositive,
            title: 'subclass FloatingActionButtonLocation for custom rules',
            desc:
                'The base class is abstract: override getOffset(scaffoldGeometry) '
                'and return an Offset relative to the Scaffold. Use this for '
                'headquartered placements, bespoke side panels, or layouts with '
                'unusual safe-area constraints.',
          ),
          _PrivateDivider(),
          _PrivatePitfallRow(
            icon: Icons.directions,
            color: _kAccentDeep,
            title: 'directionality flips start/end',
            desc:
                'In an RTL locale, startFloat appears on the right and endFloat on '
                'the left. Locations resolve via the ambient TextDirection — your '
                'layout will mirror automatically, which is usually what you want.',
          ),
          _PrivateDivider(),
          _PrivatePitfallRow(
            icon: Icons.layers,
            color: _kWarn,
            title: 'docked needs a bottom widget',
            desc:
                'Docked locations measure against either bottomNavigationBar or '
                'persistentFooterButtons or BottomAppBar. Without one, "docked" '
                'falls through to a floor-aligned position that may collide with '
                'the system gesture area.',
          ),
          _PrivateDivider(),
          _PrivatePitfallRow(
            icon: Icons.style,
            color: _kAccentDeep,
            title: 'endContained — Material 3 specialty',
            desc:
                'endContained anchors the FAB inside the BottomAppBar, hugging the '
                'end edge. Good for M3 apps that want a contained look without a '
                'notch. Pair with BottomAppBar that has no shape.',
          ),
        ],
      ),
    );
  }
}

class _PrivatePitfallRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String desc;
  const _PrivatePitfallRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: color, size: 18.0),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  desc,
                  style: TextStyle(
                    color: _kInkSoft,
                    fontSize: 12.5,
                    height: 1.5,
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

class _PrivateDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0,
      color: _kHairline,
      margin: EdgeInsets.symmetric(vertical: 2.0),
    );
  }
}

// =====================================================================
// SECTION 9 — FOOTER
// =====================================================================
class _PrivateFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatches = <_PrivateSwatch>[
      _PrivateSwatch('Backdrop', _kBackdrop),
      _PrivateSwatch('Surface', _kSurface),
      _PrivateSwatch('Surface alt', _kSurfaceAlt),
      _PrivateSwatch('Ink', _kInk),
      _PrivateSwatch('Ink soft', _kInkSoft),
      _PrivateSwatch('Accent', _kAccent),
      _PrivateSwatch('Accent deep', _kAccentDeep),
      _PrivateSwatch('Positive', _kPositive),
      _PrivateSwatch('Warn', _kWarn),
      _PrivateSwatch('Hairline', _kHairline),
    ];
    return Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: _kHairline),
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Demo palette',
            style: TextStyle(
              color: _kInk,
              fontWeight: FontWeight.w800,
              fontSize: 14.5,
            ),
          ),
          SizedBox(height: 12.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: swatches.map((s) => _PrivateSwatchTile(swatch: s)).toList(),
          ),
          SizedBox(height: 18.0),
          Container(height: 1.0, color: _kHairline),
          SizedBox(height: 12.0),
          Row(
            children: [
              Icon(Icons.copyright, size: 14.0, color: _kInkSoft),
              SizedBox(width: 6.0),
              Text(
                'Tom AI · D4rt visual demo · FAB locations',
                style: TextStyle(color: _kInkSoft, fontSize: 12.0),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: _kAccent.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'v1.0.0',
                  style: TextStyle(
                    color: _kAccentDeep,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
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
}

class _PrivateSwatch {
  final String label;
  final Color color;
  const _PrivateSwatch(this.label, this.color);
}

class _PrivateHex {
  static String format(Color c) {
    int channel(double v) {
      final int n = (v * 255.0).round();
      if (n < 0) return 0;
      if (n > 255) return 255;
      return n;
    }

    final int r = channel(c.r);
    final int g = channel(c.g);
    final int b = channel(c.b);
    final int packed = (r << 16) | (g << 8) | b;
    return '#${packed.toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }
}

class _PrivateSwatchTile extends StatelessWidget {
  final _PrivateSwatch swatch;
  const _PrivateSwatchTile({required this.swatch});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kHairline),
      ),
      child: Row(
        children: [
          Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
              color: swatch.color,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: _kHairline),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  swatch.label,
                  style: TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.5,
                  ),
                ),
                Text(
                  _PrivateHex.format(swatch.color),
                  style: TextStyle(
                    color: _kInkSoft,
                    fontSize: 10.0,
                    fontFamily: 'monospace',
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

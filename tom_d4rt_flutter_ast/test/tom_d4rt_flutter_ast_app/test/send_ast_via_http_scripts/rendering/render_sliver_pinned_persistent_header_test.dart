// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: RenderSliverPinnedPersistentHeader deep demo
import 'package:flutter/material.dart';

// ===========================================================================
// DEEP DEMO: RenderSliverPinnedPersistentHeader
//
// RenderSliverPinnedPersistentHeader is the render object behind every
// `SliverPersistentHeader(pinned: true)` and `SliverAppBar(pinned: true)`.
// "Pinned" means: while the rest of the scroll content slides past, the
// header stays glued to the leading edge of the viewport. As the user
// scrolls, the render object collapses the header from `maxExtent` down to
// `minExtent` and then keeps it stuck at `minExtent` for the rest of the
// scroll range.
//
// This file is a hand-authored, visual demo of how pinned persistent
// headers feel and how they relate to (and differ from) `floating`,
// `pinned + floating`, and `pinned + stretch`. Every sliver demo is a real
// CustomScrollView nested inside a bounded SizedBox so the user can see
// the render object actually animate as they scroll.
// ===========================================================================

// ---------------------------------------------------------------------------
// Top-level entry point — required shape:
//   MaterialApp → Scaffold → SafeArea → SingleChildScrollView → Column
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('=== RenderSliverPinnedPersistentHeader Deep Demo ===');
  print('  composing 10 sections with live pinned headers');
  return MaterialApp(
    title: 'Pinned Persistent Header Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E88E5)),
      useMaterial3: true,
    ),
    home: const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _HeroMasthead(),
              SizedBox(height: 18),
              _Section1Intro(),
              SizedBox(height: 24),
              _Section2BehaviorMatrix(),
              SizedBox(height: 24),
              _Section3LiveSliverAppBar(),
              SizedBox(height: 24),
              _Section4CustomDelegate(),
              SizedBox(height: 24),
              _Section5FloatingContrast(),
              SizedBox(height: 24),
              _Section6ApiSurfaceCards(),
              SizedBox(height: 24),
              _Section7LifecycleDiagram(),
              SizedBox(height: 24),
              _Section8PitfallsPanel(),
              SizedBox(height: 24),
              _Section9StickyAppShell(),
              SizedBox(height: 24),
              _Section10SeeAlso(),
              SizedBox(height: 28),
              _PageFooter(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// HERO MASTHEAD
// ===========================================================================
class _HeroMasthead extends StatelessWidget {
  const _HeroMasthead();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF0D47A1),
            Color(0xFF1976D2),
            Color(0xFF42A5F5),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x44000000),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0x33FFFFFF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0x66FFFFFF), width: 1.4),
            ),
            child: const Icon(Icons.push_pin, color: Colors.white, size: 36),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'RenderSliverPinnedPersistentHeader',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Headers that stay glued to the viewport edge.',
                  style: TextStyle(
                    color: Color(0xFFE3F2FD),
                    fontSize: 13.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFC107),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: const Text(
              'PINNED',
              style: TextStyle(
                color: Color(0xFF263238),
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 1: INTRO
// ===========================================================================
class _Section1Intro extends StatelessWidget {
  const _Section1Intro();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      accent: const Color(0xFF1E88E5),
      icon: Icons.info_outline,
      title: '1. What does "pinned" actually mean?',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'A pinned persistent header is a sliver that always keeps at '
            'least minExtent of itself painted at the leading edge of the '
            'viewport. As the user scrolls, the header collapses from '
            'maxExtent down to minExtent and then refuses to scroll any '
            'further; the rest of the slivers slide past it.',
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
          SizedBox(height: 10),
          Text(
            'In Flutter, this behaviour is implemented by '
            'RenderSliverPinnedPersistentHeader. Its companion classes are '
            'RenderSliverFloatingPersistentHeader (header pops back on '
            'reverse scroll), RenderSliverFloatingPinnedPersistentHeader '
            '(both at once), and RenderSliverScrollingPersistentHeader '
            '(the unpinned default).',
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
          SizedBox(height: 10),
          Text(
            'The widget surface is SliverPersistentHeader(pinned: true) and '
            'SliverAppBar(pinned: true). Throughout this demo we drive the '
            'render object via those public widgets so behaviour is exactly '
            'what an application developer would observe.',
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 2: BEHAVIOR MATRIX (2x3 grid)
// ===========================================================================
class _Section2BehaviorMatrix extends StatelessWidget {
  const _Section2BehaviorMatrix();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      accent: const Color(0xFF8E24AA),
      icon: Icons.grid_view,
      title: '2. Pinned vs floating vs sticky behaviour matrix',
      child: Column(
        children: const <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _BehaviorCell(
                  title: 'Scrolling (default)',
                  subtitle: 'pinned: false, floating: false',
                  bullet: 'Header scrolls completely off as content moves.',
                  example: 'SliverAppBar()',
                  color: Color(0xFFB0BEC5),
                  diagram: _BehaviorDiagram.scrolling,
                  icon: Icons.swap_vert,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _BehaviorCell(
                  title: 'Pinned',
                  subtitle: 'pinned: true',
                  bullet: 'Header collapses to minExtent and stays glued.',
                  example: 'SliverAppBar(pinned: true)',
                  color: Color(0xFF1E88E5),
                  diagram: _BehaviorDiagram.pinned,
                  icon: Icons.push_pin,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _BehaviorCell(
                  title: 'Floating',
                  subtitle: 'floating: true',
                  bullet: 'Header re-appears on any reverse-scroll gesture.',
                  example: 'SliverAppBar(floating: true)',
                  color: Color(0xFF00897B),
                  diagram: _BehaviorDiagram.floating,
                  icon: Icons.cloud,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _BehaviorCell(
                  title: 'Pinned + Floating',
                  subtitle: 'pinned: true, floating: true',
                  bullet:
                      'Always visible at minExtent AND grows on reverse scroll.',
                  example: 'SliverAppBar(pinned: true, floating: true)',
                  color: Color(0xFFAD1457),
                  diagram: _BehaviorDiagram.pinnedFloating,
                  icon: Icons.layers,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _BehaviorCell(
                  title: 'Pinned + Stretch',
                  subtitle: 'pinned: true, stretch: true',
                  bullet: 'Pinned, but overscroll inflates beyond maxExtent.',
                  example: 'SliverAppBar(pinned: true, stretch: true)',
                  color: Color(0xFFEF6C00),
                  diagram: _BehaviorDiagram.pinnedStretch,
                  icon: Icons.open_in_full,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _BehaviorCell(
                  title: 'Snap',
                  subtitle: 'floating: true, snap: true',
                  bullet:
                      'Floating header animates fully open or fully closed.',
                  example: 'SliverAppBar(floating: true, snap: true)',
                  color: Color(0xFF6A1B9A),
                  diagram: _BehaviorDiagram.snap,
                  icon: Icons.bolt,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _BehaviorDiagram {
  scrolling,
  pinned,
  floating,
  pinnedFloating,
  pinnedStretch,
  snap,
}

class _BehaviorCell extends StatelessWidget {
  const _BehaviorCell({
    required this.title,
    required this.subtitle,
    required this.bullet,
    required this.example,
    required this.color,
    required this.diagram,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String bullet;
  final String example;
  final Color color;
  final _BehaviorDiagram diagram;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.18),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10.5,
              fontFamily: 'monospace',
              color: Color(0xFF455A64),
            ),
          ),
          const SizedBox(height: 8),
          _MiniDiagram(diagram: diagram, color: color),
          const SizedBox(height: 8),
          Text(
            bullet,
            style: const TextStyle(fontSize: 11.5, height: 1.35),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF263238),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              example,
              style: const TextStyle(
                color: Color(0xFFB2EBF2),
                fontSize: 10.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniDiagram extends StatelessWidget {
  const _MiniDiagram({required this.diagram, required this.color});

  final _BehaviorDiagram diagram;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFECEFF1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFCFD8DC)),
      ),
      padding: const EdgeInsets.all(4),
      child: _diagramBody(),
    );
  }

  Widget _diagramBody() {
    switch (diagram) {
      case _BehaviorDiagram.scrolling:
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _bar(width: 60, color: color, opacity: 0.4),
            const SizedBox(height: 2),
            _bar(width: 50, color: Colors.grey, opacity: 0.7),
            const SizedBox(height: 2),
            _bar(width: 50, color: Colors.grey, opacity: 0.7),
          ],
        );
      case _BehaviorDiagram.pinned:
        return Column(
          children: <Widget>[
            _bar(width: 60, color: color, opacity: 1),
            const SizedBox(height: 2),
            _bar(width: 50, color: Colors.grey, opacity: 0.7),
            const SizedBox(height: 2),
            _bar(width: 50, color: Colors.grey, opacity: 0.7),
          ],
        );
      case _BehaviorDiagram.floating:
        return Column(
          children: <Widget>[
            _bar(width: 50, color: Colors.grey, opacity: 0.7),
            const SizedBox(height: 2),
            _bar(width: 60, color: color, opacity: 1),
            const SizedBox(height: 2),
            _bar(width: 50, color: Colors.grey, opacity: 0.7),
          ],
        );
      case _BehaviorDiagram.pinnedFloating:
        return Column(
          children: <Widget>[
            _bar(width: 60, color: color, opacity: 1),
            const SizedBox(height: 2),
            _bar(width: 60, color: color, opacity: 0.6),
            const SizedBox(height: 2),
            _bar(width: 50, color: Colors.grey, opacity: 0.7),
          ],
        );
      case _BehaviorDiagram.pinnedStretch:
        return Column(
          children: <Widget>[
            _bar(width: 70, color: color, opacity: 1),
            const SizedBox(height: 2),
            _bar(width: 60, color: color, opacity: 0.7),
            const SizedBox(height: 2),
            _bar(width: 50, color: Colors.grey, opacity: 0.7),
          ],
        );
      case _BehaviorDiagram.snap:
        return Column(
          children: <Widget>[
            _bar(width: 60, color: color, opacity: 1),
            const SizedBox(height: 2),
            _bar(width: 50, color: Colors.grey, opacity: 0.7),
            const SizedBox(height: 2),
            _bar(width: 60, color: color, opacity: 0.5),
          ],
        );
    }
  }

  Widget _bar({
    required double width,
    required Color color,
    required double opacity,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 12,
        width: width,
        decoration: BoxDecoration(
          color: color.withOpacity(opacity),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 3: LIVE PINNED SLIVERAPPBAR
// ===========================================================================
class _Section3LiveSliverAppBar extends StatelessWidget {
  const _Section3LiveSliverAppBar();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      accent: const Color(0xFF00897B),
      icon: Icons.dashboard,
      title: '3. Live pinned SliverAppBar with FlexibleSpaceBar',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Drag the inner scroll view: the gradient masthead collapses '
            'from expandedHeight (200) down to the toolbar height and then '
            'stays pinned. The expanded space includes a Stack with a '
            'gradient backdrop and titled badge.',
            style: TextStyle(fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 360,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE0F2F1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFB2DFDB)),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x22004D40),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: const _LiveSliverAppBarBody(),
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveSliverAppBarBody extends StatelessWidget {
  const _LiveSliverAppBarBody();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 200,
          backgroundColor: const Color(0xFF00695C),
          foregroundColor: Colors.white,
          title: const Text('Pinned SliverAppBar'),
          actions: const <Widget>[
            Icon(Icons.search),
            SizedBox(width: 12),
            Icon(Icons.more_vert),
            SizedBox(width: 8),
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            title: const Text(
              'Galaxy Field Notes',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color(0xFF004D40),
                        Color(0xFF00897B),
                        Color(0xFF26A69A),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 36,
                  right: 24,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x44000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Text(
                      'PINNED',
                      style: TextStyle(
                        color: Color(0xFF263238),
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60,
                  left: 16,
                  child: Row(
                    children: const <Widget>[
                      Icon(Icons.star, color: Color(0xFFFFE082), size: 16),
                      SizedBox(width: 4),
                      Icon(Icons.star, color: Color(0xFFFFE082), size: 16),
                      SizedBox(width: 4),
                      Icon(Icons.star, color: Color(0xFFFFE082), size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) =>
                _ColoredCard(index: index, total: 12),
            childCount: 12,
          ),
        ),
      ],
    );
  }
}

class _ColoredCard extends StatelessWidget {
  const _ColoredCard({required this.index, required this.total});

  final int index;
  final int total;

  static const List<Color> _palette = <Color>[
    Color(0xFF1565C0),
    Color(0xFF2E7D32),
    Color(0xFFEF6C00),
    Color(0xFFAD1457),
    Color(0xFF6A1B9A),
    Color(0xFF00838F),
    Color(0xFFC62828),
    Color(0xFF4527A0),
    Color(0xFF558B2F),
    Color(0xFFD84315),
    Color(0xFF00695C),
    Color(0xFF283593),
  ];

  static const List<IconData> _icons = <IconData>[
    Icons.public,
    Icons.terrain,
    Icons.science,
    Icons.bolt,
    Icons.eco,
    Icons.flight,
    Icons.diamond,
    Icons.brightness_5,
    Icons.local_fire_department,
    Icons.water_drop,
    Icons.spa,
    Icons.star,
  ];

  @override
  Widget build(BuildContext context) {
    final Color color = _palette[index % _palette.length];
    final IconData icon = _icons[index % _icons.length];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.35)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[color, color.withOpacity(0.6)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Field note ${index + 1} of $total',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: color,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Scroll the inner viewport — watch the pinned header collapse.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF455A64)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 4: CUSTOM DELEGATE
// ===========================================================================
class _Section4CustomDelegate extends StatelessWidget {
  const _Section4CustomDelegate();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      accent: const Color(0xFFEF6C00),
      icon: Icons.architecture,
      title: '4. Custom SliverPersistentHeader(pinned: true, delegate: ...)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'A custom delegate gives you full control over the header content '
            'and lets you observe shrinkOffset directly. The strip below '
            'visualises the clamped progress of the collapse.',
            style: TextStyle(fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 320,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFFFCC80)),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x22BF360C),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SimplePinnedDelegate(
                      minExtent: 56,
                      maxExtent: 120,
                      title: 'Custom Pinned Delegate',
                      icon: Icons.flag,
                      startColor: const Color(0xFFEF6C00),
                      endColor: const Color(0xFFFF8A65),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) =>
                          _CustomDelegateRow(index: index),
                      childCount: 14,
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

class _CustomDelegateRow extends StatelessWidget {
  const _CustomDelegateRow({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFE0B2)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFFEF6C00),
              shape: BoxShape.circle,
            ),
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Item ${index + 1} - beneath the pinned custom header',
              style: const TextStyle(fontSize: 12.5),
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFFEF6C00)),
        ],
      ),
    );
  }
}

class _SimplePinnedDelegate extends SliverPersistentHeaderDelegate {
  const _SimplePinnedDelegate({
    required this.minExtent,
    required this.maxExtent,
    required this.title,
    required this.icon,
    required this.startColor,
    required this.endColor,
  });

  @override
  final double minExtent;
  @override
  final double maxExtent;
  final String title;
  final IconData icon;
  final Color startColor;
  final Color endColor;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double range = (maxExtent - minExtent).clamp(1.0, 10000.0);
    final double progress = (shrinkOffset / range).clamp(0.0, 1.0);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[startColor, endColor],
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0x33FFFFFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF263238),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'shrink ${(progress * 100).round()}%',
                      style: const TextStyle(
                        color: Color(0xFFFFE0B2),
                        fontFamily: 'monospace',
                        fontSize: 10.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Progress strip
          Container(
            height: 4,
            color: const Color(0x44FFFFFF),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(color: const Color(0xFFFFEB3B)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SimplePinnedDelegate oldDelegate) {
    return oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent ||
        oldDelegate.title != title ||
        oldDelegate.icon != icon ||
        oldDelegate.startColor != startColor ||
        oldDelegate.endColor != endColor;
  }
}

// ===========================================================================
// SECTION 5: FLOATING CONTRAST
// ===========================================================================
class _Section5FloatingContrast extends StatelessWidget {
  const _Section5FloatingContrast();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      accent: const Color(0xFF6A1B9A),
      icon: Icons.cloud_queue,
      title: '5. Floating header (contrast)',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'A floating header is the natural foil to a pinned one. With '
            'pinned: false, floating: true, snap: true the header scrolls '
            'completely off but pops back the moment the user reverses '
            'direction. Compare to section 3 - there the header NEVER '
            'leaves the viewport.',
            style: TextStyle(fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5F5),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFCE93D8)),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x224A148C),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    pinned: false,
                    backgroundColor: const Color(0xFF6A1B9A),
                    foregroundColor: Colors.white,
                    title: const Text('Floating + Snap'),
                    actions: const <Widget>[
                      Icon(Icons.cloud_done),
                      SizedBox(width: 12),
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) => Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: const Color(0xFFE1BEE7)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              index.isEven
                                  ? Icons.cloud_outlined
                                  : Icons.cloud,
                              color: const Color(0xFF6A1B9A),
                            ),
                            const SizedBox(width: 10),
                            Text('Floating list row ${index + 1}'),
                          ],
                        ),
                      ),
                      childCount: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFFFE0B2)),
            ),
            child: Row(
              children: const <Widget>[
                Icon(Icons.lightbulb, color: Color(0xFFEF6C00)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Pinned headers stay visible (good for primary nav). '
                    'Floating headers prioritise content (good for reading).',
                    style: TextStyle(fontSize: 12),
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

// ===========================================================================
// SECTION 6: API SURFACE CARDS
// ===========================================================================
class _Section6ApiSurfaceCards extends StatelessWidget {
  const _Section6ApiSurfaceCards();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      accent: const Color(0xFF455A64),
      icon: Icons.api,
      title: '6. API surface cards',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: const <Widget>[
          _ApiCard(
            name: 'pinned',
            blurb: 'Stick to leading edge at minExtent.',
            snippet: 'SliverAppBar(pinned: true)',
            icon: Icons.push_pin,
            color: Color(0xFF1E88E5),
          ),
          _ApiCard(
            name: 'floating',
            blurb: 'Pop back on reverse scroll.',
            snippet: 'SliverAppBar(floating: true)',
            icon: Icons.cloud,
            color: Color(0xFF00897B),
          ),
          _ApiCard(
            name: 'stretch',
            blurb: 'Allow header to grow past maxExtent on overscroll.',
            snippet: 'SliverAppBar(pinned: true, stretch: true)',
            icon: Icons.open_in_full,
            color: Color(0xFFEF6C00),
          ),
          _ApiCard(
            name: 'snap',
            blurb: 'Animate fully open / fully closed (with floating).',
            snippet: 'SliverAppBar(floating: true, snap: true)',
            icon: Icons.bolt,
            color: Color(0xFF6A1B9A),
          ),
          _ApiCard(
            name: 'expandedHeight',
            blurb: 'Height when fully expanded (= maxExtent).',
            snippet: 'SliverAppBar(expandedHeight: 200)',
            icon: Icons.height,
            color: Color(0xFF8E24AA),
          ),
          _ApiCard(
            name: 'collapsedHeight',
            blurb: 'Height when fully collapsed (overrides default).',
            snippet: 'SliverAppBar(collapsedHeight: 64)',
            icon: Icons.compress,
            color: Color(0xFFAD1457),
          ),
          _ApiCard(
            name: 'flexibleSpace',
            blurb: 'Widget shown in the expanded area.',
            snippet: 'flexibleSpace: FlexibleSpaceBar(...)',
            icon: Icons.layers,
            color: Color(0xFF1565C0),
          ),
          _ApiCard(
            name: 'delegate',
            blurb: 'Build the header for SliverPersistentHeader.',
            snippet: 'SliverPersistentHeader(delegate: my)',
            icon: Icons.architecture,
            color: Color(0xFF2E7D32),
          ),
          _ApiCard(
            name: 'shouldRebuild',
            blurb: 'Decide if the delegate must rebuild the header.',
            snippet: 'bool shouldRebuild(old) => ...',
            icon: Icons.refresh,
            color: Color(0xFF00838F),
          ),
          _ApiCard(
            name: 'minExtent',
            blurb: 'Minimum height while pinned (collapsed size).',
            snippet: 'double get minExtent => 56;',
            icon: Icons.vertical_align_bottom,
            color: Color(0xFF558B2F),
          ),
          _ApiCard(
            name: 'maxExtent',
            blurb: 'Maximum height when fully expanded.',
            snippet: 'double get maxExtent => 200;',
            icon: Icons.vertical_align_top,
            color: Color(0xFFC62828),
          ),
          _ApiCard(
            name: 'shrinkOffset',
            blurb: 'How much the header has been shrunk so far.',
            snippet: 'build(ctx, shrinkOffset, overlaps) => ...',
            icon: Icons.compress,
            color: Color(0xFF4527A0),
          ),
        ],
      ),
    );
  }
}

class _ApiCard extends StatelessWidget {
  const _ApiCard({
    required this.name,
    required this.blurb,
    required this.snippet,
    required this.icon,
    required this.color,
  });

  final String name;
  final String blurb;
  final String snippet;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.18),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            blurb,
            style: const TextStyle(fontSize: 11.5, height: 1.35),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF263238),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              snippet,
              style: const TextStyle(
                color: Color(0xFFB2EBF2),
                fontFamily: 'monospace',
                fontSize: 10.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 7: LIFECYCLE DIAGRAM
// ===========================================================================
class _Section7LifecycleDiagram extends StatelessWidget {
  const _Section7LifecycleDiagram();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      accent: const Color(0xFF1565C0),
      icon: Icons.account_tree,
      title: '7. Lifecycle: how the render object computes geometry',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _LifecycleStep(
            number: 1,
            color: Color(0xFF1565C0),
            title: 'Resolve maxExtent / minExtent',
            text:
                'The delegate is queried for its min/max extents. They MUST '
                'satisfy minExtent <= maxExtent. For SliverAppBar, '
                'expandedHeight maps to maxExtent.',
            icon: Icons.straighten,
          ),
          _LifecycleStep(
            number: 2,
            color: Color(0xFF2E7D32),
            title: 'Compute scrollExtent',
            text:
                'scrollExtent = maxExtent so the header occupies that much '
                'of the viewport before pinning takes over.',
            icon: Icons.swap_vert,
          ),
          _LifecycleStep(
            number: 3,
            color: Color(0xFFEF6C00),
            title: 'Compute paintExtent',
            text:
                'paintExtent = max(minExtent, maxExtent - scrollOffset). The '
                'header keeps painting at least minExtent of itself.',
            icon: Icons.brush,
          ),
          _LifecycleStep(
            number: 4,
            color: Color(0xFFAD1457),
            title: 'Compute layoutExtent',
            text:
                'layoutExtent = clamp(maxExtent - scrollOffset, 0, paintExtent). '
                'This is how much the header pushes following slivers down.',
            icon: Icons.view_agenda,
          ),
          _LifecycleStep(
            number: 5,
            color: Color(0xFF6A1B9A),
            title: 'Pinned paint offset',
            text:
                'When scrollOffset > maxExtent - minExtent, the render object '
                'paints the header at the leading edge with a fixed paint '
                'origin so it never visually scrolls away.',
            icon: Icons.push_pin,
          ),
          _LifecycleStep(
            number: 6,
            color: Color(0xFF00838F),
            title: 'Build delegate.build(shrinkOffset)',
            text:
                'shrinkOffset = clamp(scrollOffset, 0, maxExtent - minExtent). '
                'The delegate uses it to interpolate text size, opacity, etc.',
            icon: Icons.handyman,
          ),
        ],
      ),
    );
  }
}

class _LifecycleStep extends StatelessWidget {
  const _LifecycleStep({
    required this.number,
    required this.color,
    required this.title,
    required this.text,
    required this.icon,
  });

  final int number;
  final Color color;
  final String title;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.35)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[color, color.withOpacity(0.7)],
              ),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: color,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 8: PITFALLS PANEL
// ===========================================================================
class _Section8PitfallsPanel extends StatelessWidget {
  const _Section8PitfallsPanel();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      accent: const Color(0xFFC62828),
      icon: Icons.warning_amber,
      title: '8. Pitfalls and gotchas',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _PitfallRow(
            color: Color(0xFFC62828),
            icon: Icons.straighten,
            title: 'minExtent and maxExtent must be sane',
            text:
                'minExtent <= maxExtent is required; SliverAppBar(pinned) '
                'asserts this at runtime. Keep maxExtent bounded - infinite '
                'flexible space causes layout assertions.',
          ),
          _PitfallRow(
            color: Color(0xFFEF6C00),
            icon: Icons.refresh,
            title: 'Avoid shouldRebuild returning true unconditionally',
            text:
                'Each true forces the header subtree to rebuild on every '
                'scroll tick. Compare delegate fields explicitly so the '
                'render object can short-circuit.',
          ),
          _PitfallRow(
            color: Color(0xFF6A1B9A),
            icon: Icons.layers_clear,
            title: 'Mixing pinned + floating semantics',
            text:
                'pinned: true, floating: true is its own render object '
                '(RenderSliverFloatingPinnedPersistentHeader). Be explicit '
                'about whether you want re-snap behaviour.',
          ),
          _PitfallRow(
            color: Color(0xFF00838F),
            icon: Icons.account_tree,
            title: 'NestedScrollView integration',
            text:
                'When a SliverAppBar lives in headerSliverBuilder, '
                'NestedScrollView coordinates outer/inner scrolling. Pinned '
                'works correctly; pinned + stretch needs notificationPredicate '
                'tuning.',
          ),
          _PitfallRow(
            color: Color(0xFF1565C0),
            icon: Icons.bug_report,
            title: 'flexibleSpace overdraw',
            text:
                'Heavy widgets in flexibleSpace cost on every scroll frame. '
                'Prefer images and gradients; avoid full Stacks of complex '
                'widgets if you can.',
          ),
        ],
      ),
    );
  }
}

class _PitfallRow extends StatelessWidget {
  const _PitfallRow({
    required this.color,
    required this.icon,
    required this.title,
    required this.text,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.35)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.10),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: color,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 9: STICKY APP SHELL (table-of-contents UX)
// ===========================================================================
class _Section9StickyAppShell extends StatelessWidget {
  const _Section9StickyAppShell();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      accent: const Color(0xFF2E7D32),
      icon: Icons.menu_book,
      title: '9. Sticky-section app shell mock-up',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'A real app pattern: every category gets its own pinned '
            'persistent header. As you scroll, the active category header '
            'pushes the previous one out of the viewport - exactly the same '
            'feel as a sticky table of contents.',
            style: TextStyle(fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 380,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFA5D6A7)),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x221B5E20),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomScrollView(
                slivers: <Widget>[
                  _stickyCategoryHeader(
                    title: 'Inbox',
                    icon: Icons.inbox,
                    color: const Color(0xFF2E7D32),
                  ),
                  _stickyCategoryItems(
                    color: const Color(0xFF2E7D32),
                    items: const <String>[
                      'Welcome to your sticky inbox',
                      'A note from product',
                      'Friendly weekly digest',
                      'Your invoice for April',
                    ],
                  ),
                  _stickyCategoryHeader(
                    title: 'Projects',
                    icon: Icons.work_outline,
                    color: const Color(0xFF1565C0),
                  ),
                  _stickyCategoryItems(
                    color: const Color(0xFF1565C0),
                    items: const <String>[
                      'Quest: pinned header demo',
                      'Quest: tom_forge core',
                      'Quest: tom_assistant',
                      'Quest: doc scanner v2',
                      'Quest: workspace setup',
                    ],
                  ),
                  _stickyCategoryHeader(
                    title: 'Calendar',
                    icon: Icons.calendar_today,
                    color: const Color(0xFFEF6C00),
                  ),
                  _stickyCategoryItems(
                    color: const Color(0xFFEF6C00),
                    items: const <String>[
                      'Standup at 09:30',
                      'Design review at 11:00',
                      'Lunch with mentor',
                      'Focus block 14:00-17:00',
                    ],
                  ),
                  _stickyCategoryHeader(
                    title: 'Notes',
                    icon: Icons.sticky_note_2,
                    color: const Color(0xFF6A1B9A),
                  ),
                  _stickyCategoryItems(
                    color: const Color(0xFF6A1B9A),
                    items: const <String>[
                      'Idea: pinned header benchmark suite',
                      'Idea: NestedScrollView snap recipe',
                      'Idea: minimal SliverPersistentHeader package',
                    ],
                  ),
                  _stickyCategoryHeader(
                    title: 'Archive',
                    icon: Icons.archive,
                    color: const Color(0xFFAD1457),
                  ),
                  _stickyCategoryItems(
                    color: const Color(0xFFAD1457),
                    items: const <String>[
                      '2024 retrospective',
                      'Old mailing list digest',
                      'Resolved bugs 2024 Q4',
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stickyCategoryHeader({
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SimplePinnedDelegate(
        minExtent: 44,
        maxExtent: 44,
        title: title,
        icon: icon,
        startColor: color,
        endColor: color.withOpacity(0.78),
      ),
    );
  }

  Widget _stickyCategoryItems({
    required Color color,
    required List<String> items,
  }) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) => Container(
          margin:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.25)),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  items[index],
                  style: const TextStyle(fontSize: 12.5),
                ),
              ),
              Icon(Icons.chevron_right, color: color, size: 18),
            ],
          ),
        ),
        childCount: items.length,
      ),
    );
  }
}

// ===========================================================================
// SECTION 10: SEE ALSO
// ===========================================================================
class _Section10SeeAlso extends StatelessWidget {
  const _Section10SeeAlso();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      accent: const Color(0xFF455A64),
      icon: Icons.bookmark,
      title: '10. See also',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _SeeAlsoRow(
            icon: Icons.architecture,
            color: Color(0xFF1565C0),
            name: 'SliverPersistentHeaderDelegate',
            description:
                'The contract that drives every persistent header. Override '
                'minExtent, maxExtent, build, and shouldRebuild.',
          ),
          _SeeAlsoRow(
            icon: Icons.account_tree,
            color: Color(0xFF2E7D32),
            name: 'NestedScrollView',
            description:
                'Coordinates a single outer scroll with multiple inner '
                'scrollables. Used in tabbed app bars with pinned headers.',
          ),
          _SeeAlsoRow(
            icon: Icons.layers,
            color: Color(0xFFEF6C00),
            name: 'FlexibleSpaceBar',
            description:
                'The standard widget used inside SliverAppBar.flexibleSpace '
                'to render a collapsible title and background.',
          ),
          _SeeAlsoRow(
            icon: Icons.cloud,
            color: Color(0xFF6A1B9A),
            name: 'RenderSliverFloatingPersistentHeader',
            description:
                'The non-pinned counterpart - header pops back on reverse '
                'scroll but does not stay glued.',
          ),
          _SeeAlsoRow(
            icon: Icons.layers_outlined,
            color: Color(0xFFAD1457),
            name: 'RenderSliverFloatingPinnedPersistentHeader',
            description:
                'Both behaviours combined - always visible AND eagerly '
                'expanding on reverse scroll.',
          ),
        ],
      ),
    );
  }
}

class _SeeAlsoRow extends StatelessWidget {
  const _SeeAlsoRow({
    required this.icon,
    required this.color,
    required this.name,
    required this.description,
  });

  final IconData icon;
  final Color color;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: color,
                    fontSize: 13,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SHARED SHELLS
// ===========================================================================
class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.accent,
    required this.icon,
    required this.title,
    required this.child,
  });

  final Color accent;
  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withOpacity(0.25)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[accent, accent.withOpacity(0.7)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _PageFooter extends StatelessWidget {
  const _PageFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF263238),
            Color(0xFF37474F),
            Color(0xFF455A64),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x44000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: const <Widget>[
          Icon(Icons.push_pin, color: Color(0xFFFFC107), size: 22),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'RenderSliverPinnedPersistentHeader - pinned headers, end to end. '
              'Built from the public widget surface.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

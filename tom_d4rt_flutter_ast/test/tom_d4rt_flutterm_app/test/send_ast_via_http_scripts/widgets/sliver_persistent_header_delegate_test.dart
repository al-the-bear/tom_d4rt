// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show FloatingHeaderSnapConfiguration;

/// Deep visual demo — SliverPersistentHeaderDelegate
///
/// SliverPersistentHeaderDelegate is the abstract class you subclass to
/// configure a SliverPersistentHeader — a sliver that stays visible at the
/// top of the viewport as the user scrolls. It controls the header's size
/// range and rebuild behavior, and optionally enables snapping and
/// floating animations.
///
/// Sections
/// ─────────
/// 1. Delegate anatomy — minExtent, maxExtent, build, shouldRebuild
/// 2. Pinned vs floating vs pinned+floating
/// 3. shrinkOffset mechanics
/// 4. overlapsContent parameter
/// 5. Snap configuration
/// 6. Live pinned header demo
/// 7. Live floating header demo
/// 8. Implementing shouldRebuild correctly

// ─── palette ───────────────────────────────────────────────
const _kOrange       = Color(0xFFFF9800);
const _kOrangeLight  = Color(0xFFFFE0B2);
const _kOrangeDark   = Color(0xFFE65100);
const _kBlue         = Color(0xFF2196F3);
const _kBlueLight    = Color(0xFFBBDEFB);
const _kBlueDark     = Color(0xFF0D47A1);
const _kSurface      = Color(0xFFFFFBF5);
const _kDivider      = Color(0xFFE0E0E0);
const _kTextDark     = Color(0xFF212121);
const _kTextMuted    = Color(0xFF757575);

// ─── 1. Delegate anatomy ───────────────────────────────────
class _DelegateProperty {
  const _DelegateProperty(this.name, this.signature, this.description);
  final String name;
  final String signature;
  final String description;
}

const _kDelegateProperties = <_DelegateProperty>[
  _DelegateProperty('minExtent', 'double get minExtent',
      'The smallest size (height for vertical scroll) the header can shrink '
      'to. When the header is fully collapsed, its extent equals minExtent.'),
  _DelegateProperty('maxExtent', 'double get maxExtent',
      'The largest size the header occupies when it has not been scrolled at '
      'all. Must be ≥ minExtent. The difference (maxExtent − minExtent) is '
      'the total shrinkable range.'),
  _DelegateProperty('build', 'Widget build(BuildContext, double shrinkOffset, bool overlapsContent)',
      'Called every time the header needs to rebuild its content. '
      'shrinkOffset goes from 0 (fully expanded) to maxExtent − minExtent '
      '(fully collapsed). overlapsContent indicates whether slivers below '
      'are rendering beneath this header.'),
  _DelegateProperty('shouldRebuild', 'bool shouldRebuild(covariant oldDelegate)',
      'Return true if the new delegate would produce a different build() '
      'result than oldDelegate. If false, the framework skips the rebuild — '
      'an important performance optimization.'),
  _DelegateProperty('vsync', 'TickerProvider? get vsync',
      'Required when snapConfiguration or showOnScreenConfiguration is non-null. '
      'Usually provided by TickerProviderStateMixin on the State object.'),
  _DelegateProperty('snapConfiguration', 'PersistentHeaderSnapConfiguration?',
      'When set, the header snaps to either minExtent or maxExtent after the '
      'user lifts their finger. The configuration includes snap animation curve '
      'and duration.'),
  _DelegateProperty('showOnScreenConfiguration', 'PersistentHeaderShowOnScreenConfiguration?',
      'Controls behavior when a child of the header calls Scrollable.ensureVisible. '
      'Determines the min/max extent to use when showing content on screen.'),
];

// ─── 2. Pinned vs floating ─────────────────────────────────
class _HeaderMode {
  const _HeaderMode(this.name, this.pinned, this.floating, this.behavior, this.useCase);
  final String name;
  final bool pinned;
  final bool floating;
  final String behavior;
  final String useCase;
}

const _kHeaderModes = <_HeaderMode>[
  _HeaderMode('Scrolling (default)', false, false,
      'Scrolls off the top entirely. Occupies space only while visible.',
      'Large hero headers, parallax banners'),
  _HeaderMode('Pinned', true, false,
      'Shrinks from maxExtent to minExtent, then stays pinned at minExtent.',
      'App bars, persistent navigation'),
  _HeaderMode('Floating', false, true,
      'Scrolls away but immediately reappears when user scrolls back. '
      'Does NOT stay at minExtent while scrolling down.',
      'Quick-access toolbars'),
  _HeaderMode('Pinned + Floating', true, true,
      'Stays at minExtent while scrolling down, and snaps back to maxExtent '
      'when user scrolls up. Combines both behaviors.',
      'SliverAppBar with both pinned and floating'),
];

// ─── 3. shrinkOffset mechanics ─────────────────────────────
const _kShrinkOffsetExplanation =
    'shrinkOffset is the distance the header has been scrolled past its '
    'maxExtent position. It ranges from 0.0 (fully expanded at the top) '
    'to maxExtent − minExtent (fully collapsed). You can compute a '
    'normalized "collapse fraction" as:\n\n'
    '  double t = shrinkOffset / (maxExtent - minExtent)\n\n'
    'where t goes from 0.0 → 1.0. This fraction drives size interpolation, '
    'opacity transitions, and layout changes inside the header.';

// ─── helpers ───────────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [_kOrangeDark, _kBlueDark]),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.4)),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDivider),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: child,
  );
}

Widget _label(String text) {
  return Text(text, style: TextStyle(fontSize: 11, color: _kTextMuted, fontWeight: FontWeight.w600, letterSpacing: 0.6));
}

Widget _mono(String text, {Color? color}) {
  return Text(text,
      style: TextStyle(fontFamily: 'monospace', fontSize: 12.5, color: color ?? _kTextDark, height: 1.45));
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 8, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(top: 7), width: 5, height: 5,
            decoration: BoxDecoration(color: _kOrange, shape: BoxShape.circle)),
        SizedBox(width: 10),
        Expanded(child: Text(text, style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ─── delegates ─────────────────────────────────────────────
class _DemoPinnedDelegate extends SliverPersistentHeaderDelegate {
  _DemoPinnedDelegate({required this.label});
  final String label;

  @override
  double get minExtent => 48;
  @override
  double get maxExtent => 120;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final bgColor = Color.lerp(_kOrangeLight, _kOrangeDark, t)!;
    final titleSize = 20.0 - (6.0 * t);
    print('[PinnedDelegate] shrinkOffset=${shrinkOffset.toStringAsFixed(1)}, t=${t.toStringAsFixed(2)}, overlaps=$overlapsContent');

    return Container(
      color: bgColor,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.push_pin, color: Colors.white, size: 18 + (4 * (1 - t))),
          SizedBox(width: 10),
          Text(label,
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              )),
          Spacer(),
          Text('${(t * 100).toStringAsFixed(0)}%',
              style: TextStyle(fontSize: 12, color: Colors.white70, fontFamily: 'monospace')),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _DemoPinnedDelegate oldDelegate) {
    return oldDelegate.label != label;
  }
}

class _DemoFloatingDelegate extends SliverPersistentHeaderDelegate {
  _DemoFloatingDelegate({required this.label, required this.vsyncProvider});
  final String label;
  final TickerProvider vsyncProvider;

  @override
  double get minExtent => 44;
  @override
  double get maxExtent => 100;

  @override
  TickerProvider? get vsync => vsyncProvider;

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final bgColor = Color.lerp(_kBlueLight, _kBlueDark, t)!;
    print('[FloatingDelegate] shrinkOffset=${shrinkOffset.toStringAsFixed(1)}, t=${t.toStringAsFixed(2)}');

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: overlapsContent
            ? [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))]
            : null,
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.vertical_align_top, color: Colors.white, size: 18),
          SizedBox(width: 10),
          Text(label,
              style: TextStyle(
                fontSize: 16 - (3 * t),
                fontWeight: FontWeight.w700,
                color: Colors.white,
              )),
          Spacer(),
          if (overlapsContent)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('overlaps', style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _DemoFloatingDelegate oldDelegate) {
    return oldDelegate.label != label;
  }
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('SliverPersistentHeaderDelegate deep visual demo');
  print('─' * 48);
  print('Sections: anatomy, pinned vs floating, shrinkOffset,');
  print('overlapsContent, snap, live pinned, live floating, shouldRebuild.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kOrange, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
    ),
    home: _DemoHome(),
  );
}

class _DemoHome extends StatefulWidget {
  @override
  State<_DemoHome> createState() => _DemoHomeState();
}

class _DemoHomeState extends State<_DemoHome> with TickerProviderStateMixin {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverPersistentHeaderDelegate'),
        backgroundColor: _kOrangeDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: [
          _TheoryTab(),
          _PinnedDemoTab(),
          _FloatingDemoTab(vsync: this),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        selectedItemColor: _kOrangeDark,
        unselectedItemColor: _kTextMuted,
        onTap: (i) => setState(() => _tabIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.article_outlined), label: 'Theory'),
          BottomNavigationBarItem(icon: Icon(Icons.push_pin_outlined), label: 'Pinned'),
          BottomNavigationBarItem(icon: Icon(Icons.vertical_align_top), label: 'Floating'),
        ],
      ),
    );
  }
}

// ─── Theory tab ────────────────────────────────────────────
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 40),
      children: [
        // ── Section 1 ──
        _sectionHeader('1 · Delegate Anatomy', Icons.build_outlined),
        SizedBox(height: 8),
        ..._kDelegateProperties.map((p) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _kOrangeLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(p.name,
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _kOrangeDark)),
                  ),
                ],
              ),
              SizedBox(height: 6),
              _mono(p.signature, color: _kBlueDark),
              SizedBox(height: 6),
              Text(p.description, style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 2 ──
        _sectionHeader('2 · Pinned vs Floating vs Pinned+Floating', Icons.compare_arrows),
        SizedBox(height: 8),
        ..._kHeaderModes.map((m) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(m.name,
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: _kTextDark)),
                  SizedBox(width: 10),
                  if (m.pinned)
                    _badge('pinned', _kOrangeDark),
                  if (m.floating) ...[
                    SizedBox(width: 4),
                    _badge('floating', _kBlueDark),
                  ],
                ],
              ),
              SizedBox(height: 6),
              Text(m.behavior, style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
              SizedBox(height: 4),
              Text('Use case: ${m.useCase}',
                  style: TextStyle(fontSize: 12, color: _kTextMuted, fontStyle: FontStyle.italic)),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 3 ──
        _sectionHeader('3 · shrinkOffset Mechanics', Icons.compress),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_kShrinkOffsetExplanation,
                  style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4)),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('COLLAPSE FRACTION USAGE'),
              SizedBox(height: 8),
              _bullet('Interpolate font size: 24 − (8 × t) → from 24pt to 16pt'),
              _bullet('Fade subtitle: Opacity(opacity: 1 − t)'),
              _bullet('Slide avatar: Transform.translate(offset: Offset(0, −40 × t))'),
              _bullet('Change background: Color.lerp(expanded, collapsed, t)'),
              _bullet('Collapse flex layout: switch from Column to Row at t > 0.5'),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('shrinkOffset TIMELINE'),
              SizedBox(height: 10),
              _buildShrinkDiagram(),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 4 ──
        _sectionHeader('4 · overlapsContent Parameter', Icons.layers_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The overlapsContent flag is true when at least one sliver below '
                'this header has been scrolled beneath it. This is useful for '
                'conditionally showing a shadow or elevation on the header to '
                'indicate that content is behind it.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 10),
              _mono('if (overlapsContent) {'),
              _mono('  // Add elevation shadow'),
              _mono('  decoration = BoxDecoration('),
              _mono('    boxShadow: [BoxShadow(...)],'),
              _mono('  );'),
              _mono('}'),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('WHEN overlapsContent IS TRUE'),
              SizedBox(height: 8),
              _bullet('Pinned header: always true once scrolled past maxExtent'),
              _bullet('Floating header: true when header overlaps list content'),
              _bullet('Non-pinned non-floating: always false (it scrolls away)'),
              _bullet('Useful for material elevation effect on app bars'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 5 ──
        _sectionHeader('5 · Snap Configuration', Icons.bolt),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When snapConfiguration is provided, the header will animate to '
                'either its fully expanded or fully collapsed state after the user '
                'stops scrolling. This prevents the header from resting in a '
                'partially collapsed state.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 10),
              _mono('FloatingHeaderSnapConfiguration('),
              _mono('  // curve defaults to Curves.ease'),
              _mono('  // duration defaults to 300ms'),
              _mono(')'),
              SizedBox(height: 10),
              _bullet('Requires vsync to be non-null (needs TickerProvider)'),
              _bullet('Only meaningful for floating headers'),
              _bullet('Snap direction determined by current shrinkOffset vs midpoint'),
              _bullet('If shrinkOffset < (maxExtent−minExtent)/2 → snap to expanded'),
              _bullet('If shrinkOffset ≥ (maxExtent−minExtent)/2 → snap to collapsed'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 8 ──
        _sectionHeader('8 · Implementing shouldRebuild Correctly', Icons.check_circle_outline),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'shouldRebuild is a performance gate. The framework calls it with '
                'the previous delegate instance. If you return false, the header '
                'keeps its existing build() output until the scroll position changes. '
                'Returning true unconditionally wastes frames.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
              SizedBox(height: 10),
              _label('GOOD: COMPARE FIELDS'),
              SizedBox(height: 6),
              _mono('@override'),
              _mono('bool shouldRebuild(_MyDelegate old) {'),
              _mono('  return old.title != title'),
              _mono('      || old.maxExtent != maxExtent'),
              _mono('      || old.minExtent != minExtent;'),
              _mono('}'),
              SizedBox(height: 12),
              _label('BAD: ALWAYS TRUE'),
              SizedBox(height: 6),
              _mono('@override', color: Colors.red.shade700),
              _mono('bool shouldRebuild(_) => true; // wasteful', color: Colors.red.shade700),
              SizedBox(height: 10),
              Text(
                'Note that shouldRebuild only controls rebuilds triggered by '
                'delegate replacement. Scroll-driven rebuilds (where shrinkOffset '
                'changes) always call build() regardless of shouldRebuild.',
                style: TextStyle(fontSize: 12.5, color: _kBlueDark, fontStyle: FontStyle.italic, height: 1.35),
              ),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('KEY TAKEAWAY'),
              SizedBox(height: 6),
              Text(
                'SliverPersistentHeaderDelegate gives you full control over '
                'collapsible headers in scrollable views. By returning different '
                'widgets from build() based on shrinkOffset and overlapsContent, '
                'you can create rich, animated app-bar experiences. The framework '
                'handles layout, clipping, and z-ordering — you just describe the '
                'visual at each collapse fraction.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShrinkDiagram() {
    return Column(
      children: [
        _diagramRow('shrinkOffset = 0', 'Fully expanded', _kOrangeLight, 1.0),
        SizedBox(height: 4),
        _diagramRow('shrinkOffset = (max−min)/4', '25% collapsed', _kOrangeLight, 0.75),
        SizedBox(height: 4),
        _diagramRow('shrinkOffset = (max−min)/2', '50% collapsed', Color.lerp(_kOrangeLight, _kOrangeDark, 0.5)!, 0.5),
        SizedBox(height: 4),
        _diagramRow('shrinkOffset = 3(max−min)/4', '75% collapsed', Color.lerp(_kOrangeLight, _kOrangeDark, 0.75)!, 0.25),
        SizedBox(height: 4),
        _diagramRow('shrinkOffset = max−min', 'Fully collapsed', _kOrangeDark, 0.0),
      ],
    );
  }

  Widget _diagramRow(String offset, String label, Color color, double widthFraction) {
    return Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(offset,
              style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: _kTextMuted)),
        ),
        Expanded(
          child: SizedBox(
            height: 22,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.3 + (0.7 * widthFraction),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _kOrangeDark.withOpacity(0.3)),
                ),
                alignment: Alignment.center,
                child: Text(label,
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: _kOrangeDark)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _badge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Text(text,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color)),
  );
}

// ─── Pinned demo tab ───────────────────────────────────────
class _PinnedDemoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _DemoPinnedDelegate(label: 'Pinned Header'),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('SCROLL DOWN TO SEE THE HEADER COLLAPSE'),
                SizedBox(height: 8),
                Text(
                  'This header uses pinned: true. It shrinks from 120 px (maxExtent) '
                  'to 48 px (minExtent) and stays visible. The background color '
                  'interpolates from light orange to dark orange as the collapse '
                  'fraction increases. The font size also decreases.',
                  style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, i) {
              final colors = [_kOrangeLight.withOpacity(0.3), Colors.white];
              return Container(
                height: 52,
                color: colors[i % 2],
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 28, height: 28,
                      decoration: BoxDecoration(
                        color: _kOrange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text('${i + 1}',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _kOrangeDark)),
                    ),
                    SizedBox(width: 12),
                    Text('List item ${i + 1}',
                        style: TextStyle(fontSize: 14, color: _kTextDark)),
                  ],
                ),
              );
            },
            childCount: 30,
          ),
        ),
      ],
    );
  }
}

// ─── Floating demo tab ─────────────────────────────────────
class _FloatingDemoTab extends StatelessWidget {
  const _FloatingDemoTab({required this.vsync});
  final TickerProvider vsync;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          floating: true,
          delegate: _DemoFloatingDelegate(label: 'Floating + Snap', vsyncProvider: vsync),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('SCROLL PAST THE HEADER, THEN SCROLL BACK UP'),
                SizedBox(height: 8),
                Text(
                  'This header uses floating: true with snap enabled. When you '
                  'scroll down, it disappears. When you scroll up even slightly, '
                  'it pops back in and snaps to its full extent. The shadow '
                  'appears only when overlapsContent is true.',
                  style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, i) {
              final colors = [_kBlueLight.withOpacity(0.3), Colors.white];
              return Container(
                height: 52,
                color: colors[i % 2],
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 28, height: 28,
                      decoration: BoxDecoration(
                        color: _kBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text('${i + 1}',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _kBlueDark)),
                    ),
                    SizedBox(width: 12),
                    Text('List item ${i + 1}',
                        style: TextStyle(fontSize: 14, color: _kTextDark)),
                  ],
                ),
              );
            },
            childCount: 30,
          ),
        ),
      ],
    );
  }
}

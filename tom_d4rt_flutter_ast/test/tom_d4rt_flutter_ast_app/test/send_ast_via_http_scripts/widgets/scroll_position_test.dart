// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

/// Deep visual demo — ScrollPosition
///
/// ScrollPosition is the core abstraction that tracks where a scrollable view
/// is currently positioned. It stores the pixel offset, the scroll extent
/// boundaries, the viewport dimension, and orchestrates scroll activities
/// (idle, drag, ballistic, driven). Every ScrollController exposes one or more
/// ScrollPosition instances.
///
/// Sections
/// ─────────
/// 1. ScrollPosition anatomy — pixels, extents, viewport
/// 2. ScrollMetrics mixin — extentBefore, extentInside, extentAfter
/// 3. Scroll activities — idle, drag, ballistic, driven
/// 4. Edge detection — atEdge, outOfRange
/// 5. ScrollPhysics interplay
/// 6. Live scroll-position monitor
/// 7. Programmatic scroll — jumpTo, animateTo
/// 8. ScrollPositionWithSingleContext internals

// ─── palette ───────────────────────────────────────────────
const _kGreen       = Color(0xFF4CAF50);
const _kGreenLight  = Color(0xFFC8E6C9);
const _kGreenDark   = Color(0xFF2E7D32);
const _kBrown       = Color(0xFF795548);
const _kBrownLight  = Color(0xFFD7CCC8);
const _kBrownDark   = Color(0xFF4E342E);
const _kSurface     = Color(0xFFFCFCFA);
const _kDivider     = Color(0xFFE0E0E0);
const _kTextDark    = Color(0xFF212121);
const _kTextMuted   = Color(0xFF757575);

// ─── 1. Anatomy entries ────────────────────────────────────
class _AnatomyEntry {
  const _AnatomyEntry(this.property, this.type, this.description);
  final String property;
  final String type;
  final String description;
}

const _kAnatomyEntries = <_AnatomyEntry>[
  _AnatomyEntry('pixels', 'double',
      'The current scroll offset in logical pixels. Zero is the start; '
      'increases as the user scrolls down (or right for horizontal).'),
  _AnatomyEntry('minScrollExtent', 'double',
      'The minimum value pixels can have. Usually 0.0 for standard lists. '
      'Can be double.negativeInfinity for unbounded scrolling.'),
  _AnatomyEntry('maxScrollExtent', 'double',
      'The maximum value pixels can have. Equals total content height minus '
      'viewport height. If content fits, equals 0.0.'),
  _AnatomyEntry('viewportDimension', 'double',
      'The extent of the viewport along the scroll axis. For vertical scrolling, '
      'this is the visible height.'),
  _AnatomyEntry('physics', 'ScrollPhysics',
      'Determines how the position responds to user input — bouncing, clamping, '
      'never-scrollable, or custom behavior.'),
  _AnatomyEntry('context', 'ScrollContext',
      'The Scrollable that owns this position. Provides vsync for animations '
      'and the build context.'),
  _AnatomyEntry('keepScrollOffset', 'bool',
      'Whether to save and restore the scroll offset using PageStorage. '
      'Defaults to true.'),
];

// ─── 2. ScrollMetrics ──────────────────────────────────────
const _kMetricsFormulas = <String, String>{
  'extentBefore':
      'pixels - minScrollExtent\n'
      'Amount of content scrolled off the top.',
  'extentInside':
      'min(pixels, maxScrollExtent) - max(pixels - viewportDimension, minScrollExtent)\n'
      'Simplifies to viewportDimension when fully in range.',
  'extentAfter':
      'maxScrollExtent - pixels\n'
      'Amount of content remaining below the viewport.',
  'extentTotal':
      'extentBefore + extentInside + extentAfter\n'
      'Total content extent (may differ from actual content if unbounded).',
};

// ─── 3. Activities ─────────────────────────────────────────
class _ActivityInfo {
  const _ActivityInfo(this.name, this.cls, this.description, this.icon);
  final String name;
  final String cls;
  final String description;
  final IconData icon;
}

const _kActivities = <_ActivityInfo>[
  _ActivityInfo('Idle', 'IdleScrollActivity',
      'No movement. Installed after a fling or jump completes. '
      'Applies a hold function to resist further implicit scrolling.',
      Icons.pause_circle_outline),
  _ActivityInfo('Drag', 'DragScrollActivity',
      'User is touching and moving. Updated frame-by-frame from '
      'pointer delta. Converts pointer movement to pixel offset.',
      Icons.touch_app),
  _ActivityInfo('Ballistic', 'BallisticScrollActivity',
      'Post-fling deceleration. Uses a Simulation (typically '
      'ClampingScrollSimulation or BouncingScrollSimulation) driven '
      'by the AnimationController at screen refresh rate.',
      Icons.speed),
  _ActivityInfo('Driven', 'DrivenScrollActivity',
      'Programmatic animation via animateTo(). Uses an '
      'AnimationController with a specified curve and duration.',
      Icons.animation),
];

// ─── 5. Physics comparison ─────────────────────────────────
class _PhysicsRow {
  const _PhysicsRow(this.name, this.platform, this.behavior, this.overscroll);
  final String name;
  final String platform;
  final String behavior;
  final String overscroll;
}

const _kPhysicsRows = <_PhysicsRow>[
  _PhysicsRow('ClampingScrollPhysics', 'Android', 'Stops at edge', 'Glow effect'),
  _PhysicsRow('BouncingScrollPhysics', 'iOS', 'Bounces past edge', 'Rubber-band'),
  _PhysicsRow('NeverScrollableScrollPhysics', 'Any', 'Disables scroll', 'None'),
  _PhysicsRow('AlwaysScrollableScrollPhysics', 'Any', 'Always scrollable', 'Inherits parent'),
  _PhysicsRow('PageScrollPhysics', 'Any', 'Snaps to page', 'Inherits parent'),
  _PhysicsRow('RangeMaintainingScrollPhysics', 'Any', 'Corrects out-of-range', 'Clamps'),
];

// ─── helpers ───────────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [_kGreenDark, _kBrownDark]),
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
            decoration: BoxDecoration(color: _kGreen, shape: BoxShape.circle)),
        SizedBox(width: 10),
        Expanded(child: Text(text, style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('ScrollPosition deep visual demo');
  print('─' * 48);
  print('Sections: anatomy, metrics, activities, edge detection,');
  print('physics, live monitor, programmatic scroll, internals.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kGreen, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('ScrollPosition'),
        backgroundColor: _kGreenDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _Body(),
    ),
  );
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final ScrollController _mainController = ScrollController();
  final ScrollController _demoController = ScrollController();

  double _pixels = 0;
  double _maxExtent = 0;
  double _viewportDim = 0;

  @override
  void initState() {
    super.initState();
    _mainController.addListener(_onMainScroll);
    _demoController.addListener(_onDemoScroll);
  }

  void _onMainScroll() {
    // Not used for display but shows that listener is active
  }

  void _onDemoScroll() {
    if (!mounted) return;
    final pos = _demoController.position;
    setState(() {
      _pixels = pos.pixels;
      _maxExtent = pos.maxScrollExtent;
      _viewportDim = pos.viewportDimension;
    });
  }

  @override
  void dispose() {
    _mainController.removeListener(_onMainScroll);
    _mainController.dispose();
    _demoController.removeListener(_onDemoScroll);
    _demoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _mainController,
      padding: EdgeInsets.only(bottom: 40),
      children: [
        // ── Section 1: Anatomy ──
        _sectionHeader('1 · ScrollPosition Anatomy', Icons.straighten),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('CLASS HIERARCHY'),
              SizedBox(height: 8),
              _mono('abstract class ScrollPosition'),
              _mono('  extends ViewportOffset'),
              _mono('  with ScrollMetrics'),
              SizedBox(height: 10),
              Text(
                'ScrollPosition is abstract — you cannot instantiate it directly. '
                'The most common concrete subclass is ScrollPositionWithSingleContext, '
                'used by all standard scrollable widgets. PageView uses a specialized '
                'PagePosition subclass.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
        ..._kAnatomyEntries.map((e) => _card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: _kGreenLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.property,
                        style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700, fontSize: 12, color: _kGreenDark)),
                    Text(e.type, style: TextStyle(fontSize: 10, color: _kTextMuted)),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(e.description, style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
              ),
            ],
          ),
        )),

        SizedBox(height: 12),

        // ── Section 2: ScrollMetrics ──
        _sectionHeader('2 · ScrollMetrics Mixin', Icons.analytics_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ScrollMetrics is a mixin on ScrollPosition that provides computed '
                'properties describing how much content is before, inside, and after '
                'the viewport. These are the numbers scrollbars use to size and '
                'position the thumb.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
        ..._kMetricsFormulas.entries.map((e) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kBrownLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(e.key,
                    style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w700, fontSize: 13, color: _kBrownDark)),
              ),
              SizedBox(height: 8),
              _mono(e.value, color: _kGreenDark),
            ],
          ),
        )),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('VISUAL: EXTENT REGIONS'),
              SizedBox(height: 10),
              _buildExtentDiagram(),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 3: Activities ──
        _sectionHeader('3 · Scroll Activities', Icons.swap_vert),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A ScrollPosition always has exactly one active ScrollActivity '
                'governing its behavior. The activity changes as the user interacts: '
                'idle → drag → ballistic → idle. Each activity can call applyUserOffset '
                'or applyNewDimensions on the position.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
        ..._kActivities.map((a) => _card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: _kGreenLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(a.icon, color: _kGreenDark, size: 22),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(a.name,
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: _kTextDark)),
                        SizedBox(width: 8),
                        Text(a.cls,
                            style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: _kBrown)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(a.description, style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
                  ],
                ),
              ),
            ],
          ),
        )),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('ACTIVITY LIFECYCLE'),
              SizedBox(height: 8),
              _buildActivityFlow(),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 4: Edge detection ──
        _sectionHeader('4 · Edge Detection', Icons.vertical_align_top),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('atEdge AND outOfRange'),
              SizedBox(height: 8),
              _mono('bool get atEdge =>'),
              _mono('    pixels == minScrollExtent ||'),
              _mono('    pixels == maxScrollExtent;'),
              SizedBox(height: 12),
              _mono('bool get outOfRange =>'),
              _mono('    pixels < minScrollExtent ||'),
              _mono('    pixels > maxScrollExtent;'),
              SizedBox(height: 12),
              Text(
                'atEdge is true when the position is exactly at either boundary. '
                'outOfRange is true when the position has overscrolled past a '
                'boundary (only possible with BouncingScrollPhysics). Both can be '
                'true simultaneously if the content exactly fills the viewport.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('SCROLL DIRECTION'),
              SizedBox(height: 8),
              _bullet('userScrollDirection — the direction the user is actively scrolling'),
              _bullet('ScrollDirection.forward — content moving down (user scrolling up)'),
              _bullet('ScrollDirection.reverse — content moving up (user scrolling down)'),
              _bullet('ScrollDirection.idle — no active scroll input'),
              SizedBox(height: 6),
              Text(
                'Note the counter-intuitive naming: "forward" means the content '
                'is going toward the start, not toward the end.',
                style: TextStyle(fontSize: 12, color: _kBrown, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 5: Physics ──
        _sectionHeader('5 · ScrollPhysics Interplay', Icons.science_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ScrollPhysics determines how the position responds to user input '
                'and what happens at the boundaries. Physics objects chain via the '
                'parent property — applyTo(parent) builds the chain.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('PHYSICS COMPARISON'),
              SizedBox(height: 8),
              _buildPhysicsTable(),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('KEY PHYSICS METHODS'),
              SizedBox(height: 8),
              _bullet('applyPhysicsToUserOffset — transforms raw drag delta'),
              _bullet('applyBoundaryConditions — enforces edge behavior'),
              _bullet('createBallisticSimulation — creates the fling deceleration curve'),
              _bullet('adjustPositionForNewDimensions — handles viewport resize'),
              _bullet('toleranceFor — defines when a simulation is "close enough" to stop'),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 6: Live monitor ──
        _sectionHeader('6 · Live Scroll-Position Monitor', Icons.monitor_heart_outlined),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('SCROLL THE LIST BELOW TO SEE LIVE VALUES'),
              SizedBox(height: 12),
              _buildMetricRow('pixels', _pixels.toStringAsFixed(1)),
              _buildMetricRow('maxScrollExtent', _maxExtent.toStringAsFixed(1)),
              _buildMetricRow('viewportDimension', _viewportDim.toStringAsFixed(1)),
              _buildMetricRow('extentBefore', (_pixels).clamp(0, double.infinity).toStringAsFixed(1)),
              _buildMetricRow('extentAfter', (_maxExtent - _pixels).clamp(0, double.infinity).toStringAsFixed(1)),
              _buildMetricRow('atEdge', (_pixels <= 0 || _pixels >= _maxExtent) ? 'true' : 'false'),
              SizedBox(height: 6),
              if (_maxExtent > 0)
                _buildScrollBar(_pixels, _maxExtent, _viewportDim),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          height: 160,
          decoration: BoxDecoration(
            border: Border.all(color: _kGreen, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: ListView.builder(
            controller: _demoController,
            itemCount: 40,
            itemBuilder: (ctx, i) {
              final isEven = i.isEven;
              return Container(
                height: 36,
                color: isEven ? _kGreenLight.withOpacity(0.3) : Colors.white,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Text('Item $i',
                    style: TextStyle(fontSize: 13, color: isEven ? _kGreenDark : _kBrownDark)),
              );
            },
          ),
        ),

        SizedBox(height: 16),

        // ── Section 7: Programmatic scroll ──
        _sectionHeader('7 · Programmatic Scroll — jumpTo / animateTo', Icons.open_with),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('jumpTo vs animateTo'),
              SizedBox(height: 8),
              _mono('position.jumpTo(200.0)'),
              Text('Instantly sets pixels to 200. No animation, no notifications during the jump.',
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
              SizedBox(height: 10),
              _mono('position.animateTo(200.0,'),
              _mono('    duration: Duration(ms: 300),'),
              _mono('    curve: Curves.easeOut)'),
              Text('Creates a DrivenScrollActivity that smoothly interpolates to 200.',
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        ),
        _card(
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _demoController.jumpTo(0);
                    print('[ScrollPosition] jumpTo(0)');
                  },
                  icon: Icon(Icons.arrow_upward, size: 16),
                  label: Text('Jump to top'),
                  style: ElevatedButton.styleFrom(backgroundColor: _kGreenDark, foregroundColor: Colors.white),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _demoController.animateTo(
                      _demoController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeInOut,
                    );
                    print('[ScrollPosition] animateTo(maxScrollExtent)');
                  },
                  icon: Icon(Icons.arrow_downward, size: 16),
                  label: Text('Animate to end'),
                  style: ElevatedButton.styleFrom(backgroundColor: _kBrownDark, foregroundColor: Colors.white),
                ),
              ),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('ensureVisible'),
              SizedBox(height: 8),
              _mono('ScrollPosition.ensureVisible('),
              _mono('  renderObject,'),
              _mono('  alignment: 0.5,  // center in viewport'),
              _mono('  duration: Duration(ms: 300),'),
              _mono(')'),
              SizedBox(height: 6),
              Text(
                'Scrolls the minimum amount necessary to make the given RenderObject '
                'visible within the viewport. The alignment parameter controls where '
                'the object should appear: 0.0 = leading edge, 0.5 = center, 1.0 = trailing.',
                style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35),
              ),
            ],
          ),
        ),

        SizedBox(height: 12),

        // ── Section 8: Internals ──
        _sectionHeader('8 · ScrollPositionWithSingleContext Internals', Icons.memory),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ScrollPositionWithSingleContext is the concrete implementation used '
                'by almost every scrollable widget. "SingleContext" means it is owned '
                'by exactly one ScrollContext (one Scrollable widget).',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('KEY OVERRIDES'),
              SizedBox(height: 8),
              _buildInternalRow('applyUserOffset(delta)',
                  'Called by DragScrollActivity on each frame. Transforms delta through '
                  'physics.applyPhysicsToUserOffset, then calls setPixels.'),
              _buildInternalRow('applyNewDimensions()',
                  'Called when viewport layout changes. Involves correctPixels if out '
                  'of range, notifies activity, fires ScrollMetricsNotification.'),
              _buildInternalRow('setPixels(newPixels)',
                  'The central mutation method. Applies boundary conditions from physics, '
                  'fires scroll notification, returns overscroll amount.'),
              _buildInternalRow('goBallistic(velocity)',
                  'Asks physics for a BallisticSimulation and starts a '
                  'BallisticScrollActivity with it. Called when user lifts finger.'),
              _buildInternalRow('goIdle()',
                  'Transitions to IdleScrollActivity. Called when a ballistic simulation '
                  'reaches tolerance or a driven animation completes.'),
              _buildInternalRow('absorb(otherPosition)',
                  'Takes velocity and pixels from another ScrollPosition. Used when '
                  'a Scrollable is replaced but wants to continue the scroll.'),
            ],
          ),
        ),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('NOTIFICATION FLOW'),
              SizedBox(height: 8),
              _bullet('ScrollStartNotification — drag begins or animateTo starts'),
              _bullet('ScrollUpdateNotification — pixels change (every frame during scroll)'),
              _bullet('OverscrollNotification — physics reports overscroll amount'),
              _bullet('ScrollEndNotification — activity becomes idle'),
              _bullet('UserScrollNotification — userScrollDirection changes'),
              SizedBox(height: 8),
              Text(
                'Notifications bubble up through the widget tree via '
                'NotificationListener<ScrollNotification>. They carry the '
                'ScrollMetrics snapshot at the time of the event.',
                style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35),
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
                'ScrollPosition is the single source of truth for scroll state. '
                'Every ScrollController, every Scrollable, and every Scrollbar '
                'reads from and writes to ScrollPosition. Understanding pixels, '
                'extent boundaries, activities, and the setPixels → notification '
                'pipeline is essential for building custom scrollable UIs and '
                'debugging scroll behavior.',
                style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── extent diagram ──
  Widget _buildExtentDiagram() {
    return Column(
      children: [
        Row(
          children: [
            _buildExtentBlock('extentBefore', _kBrownLight, _kBrownDark, 1),
            SizedBox(width: 2),
            _buildExtentBlock('extentInside\n(viewport)', _kGreenLight, _kGreenDark, 1.5),
            SizedBox(width: 2),
            _buildExtentBlock('extentAfter', _kBrownLight, _kBrownDark, 1),
          ],
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Expanded(child: Center(child: Text('↑ minScrollExtent',
                style: TextStyle(fontSize: 10, color: _kTextMuted)))),
            Expanded(child: Center(child: Text('pixels →',
                style: TextStyle(fontSize: 10, color: _kGreenDark, fontWeight: FontWeight.w700)))),
            Expanded(child: Center(child: Text('maxScrollExtent ↑',
                style: TextStyle(fontSize: 10, color: _kTextMuted)))),
          ],
        ),
      ],
    );
  }

  Widget _buildExtentBlock(String label, Color bg, Color fg, double flex) {
    return Expanded(
      flex: (flex * 10).toInt(),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: fg.withOpacity(0.4)),
        ),
        alignment: Alignment.center,
        child: Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: fg)),
      ),
    );
  }

  // ── activity flow ──
  Widget _buildActivityFlow() {
    final steps = <MapEntry<String, Color>>[
      MapEntry('Touch down → HoldScrollActivity', _kGreen),
      MapEntry('Pointer moves → DragScrollActivity', _kGreen),
      MapEntry('Lift finger → BallisticScrollActivity', _kBrown),
      MapEntry('Simulation done → IdleScrollActivity', _kGreenDark),
    ];

    return Column(
      children: steps.asMap().entries.map((e) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: e.value.value.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: e.value.value.withOpacity(0.3)),
              ),
              child: Text(e.value.key,
                  style: TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.w600,
                      color: e.value.value)),
            ),
            if (e.key < steps.length - 1)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Icon(Icons.arrow_downward, size: 14, color: _kTextMuted),
              ),
          ],
        );
      }).toList(),
    );
  }

  // ── physics table ──
  Widget _buildPhysicsTable() {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(2.4),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1.3),
        3: FlexColumnWidth(1.2),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      border: TableBorder.all(color: _kDivider, width: 0.5),
      children: [
        TableRow(
          decoration: BoxDecoration(color: _kGreenLight.withOpacity(0.4)),
          children: ['Physics', 'Platform', 'Behavior', 'Overscroll'].map((h) => Padding(
            padding: EdgeInsets.all(5),
            child: Text(h, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.5, color: _kGreenDark)),
          )).toList(),
        ),
        ..._kPhysicsRows.map((r) => TableRow(
          children: [r.name, r.platform, r.behavior, r.overscroll].map((c) => Padding(
            padding: EdgeInsets.all(5),
            child: Text(c, style: TextStyle(fontSize: 10.5, color: _kTextDark)),
          )).toList(),
        )),
      ],
    );
  }

  // ── live metrics ──
  Widget _buildMetricRow(String name, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: _kGreenDark, fontWeight: FontWeight.w600)),
          ),
          Text(value, style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: _kBrownDark)),
        ],
      ),
    );
  }

  Widget _buildScrollBar(double pixels, double max, double viewport) {
    if (max <= 0) return SizedBox.shrink();
    final total = max + viewport;
    final thumbFraction = viewport / total;
    final thumbPosition = pixels / max;

    return Container(
      height: 16,
      decoration: BoxDecoration(
        color: _kGreenLight.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          final trackWidth = constraints.maxWidth;
          final thumbWidth = (thumbFraction * trackWidth).clamp(20.0, trackWidth);
          final maxOffset = trackWidth - thumbWidth;
          final offset = thumbPosition * maxOffset;

          return Stack(
            children: [
              Positioned(
                left: offset.clamp(0.0, maxOffset),
                top: 2,
                child: Container(
                  width: thumbWidth,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _kGreenDark,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── internals row ──
  Widget _buildInternalRow(String method, String desc) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _mono(method, color: _kGreenDark),
          SizedBox(height: 2),
          Text(desc, style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
        ],
      ),
    );
  }
}

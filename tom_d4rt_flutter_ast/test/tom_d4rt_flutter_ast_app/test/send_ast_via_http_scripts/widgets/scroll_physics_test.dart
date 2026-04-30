// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ScrollPhysics
// Demonstrates ScrollPhysics — the base class that governs scroll
// behavior including friction, spring dynamics, boundary conditions,
// overscroll, and momentum. Covers the built-in subclasses, the
// physics chain (parent delegation), and how to select physics
// for different scroll containers.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScrollPhysics Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ScrollPhysics?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.speed,
      'title': 'Scroll Behavior Engine',
      'body': 'ScrollPhysics determines how a scrollable responds to user '
          'input: how quickly it decelerates after a fling, whether it '
          'allows overscroll, and how it springs back to boundaries.',
      'accent': Colors.indigo[800]!,
    },
    {
      'icon': Icons.link,
      'title': 'Parent Chain Delegation',
      'body': 'Every ScrollPhysics has an optional parent. When a method '
          'like applyPhysicsToUserOffset is called, the physics can '
          'delegate to its parent, forming a composable chain of behaviors.',
      'accent': Colors.orange[700]!,
    },
    {
      'icon': Icons.phone_android,
      'title': 'Platform Defaults',
      'body': 'Flutter automatically selects platform-appropriate physics: '
          'BouncingScrollPhysics on iOS (overscroll glow-free) and '
          'ClampingScrollPhysics on Android (overscroll clamped with '
          'an edge glow effect).',
      'accent': Colors.indigo[700]!,
    },
    {
      'icon': Icons.tune,
      'title': 'Customizable at Every Level',
      'body': 'You can set physics on ListView, GridView, CustomScrollView, '
          'or any Scrollable. Custom subclasses can override individual '
          'methods while delegating the rest to the parent chain.',
      'accent': Colors.orange[600]!,
    },
  ];

  print('  Concept cards: ${conceptCards.length}');

  // ============================================================
  // SECTION 2: Built-in Physics Subclasses
  // ============================================================
  print('=== Section 2: Subclasses ===');

  final subclasses = <Map<String, dynamic>>[
    {
      'name': 'BouncingScrollPhysics',
      'platform': 'iOS',
      'icon': Icons.apple,
      'description': 'Allows overscroll beyond boundaries with a '
          'rubber-band effect. Content springs back when released. '
          'Used by default on iOS and macOS.',
      'behavior': 'Overscroll + bounce-back',
      'color': Colors.indigo[800]!,
    },
    {
      'name': 'ClampingScrollPhysics',
      'platform': 'Android',
      'icon': Icons.android,
      'description': 'Stops scrolling at the boundary with no overscroll. '
          'The OverscrollIndicator (edge glow) provides visual '
          'feedback. Used by default on Android and Fuchsia.',
      'behavior': 'Clamped at edges + glow',
      'color': Colors.orange[700]!,
    },
    {
      'name': 'NeverScrollableScrollPhysics',
      'platform': 'Any',
      'icon': Icons.block,
      'description': 'Prevents the user from scrolling entirely. Useful '
          'for disabling scroll in a PageView or nested scrollable '
          'that should not respond to gestures.',
      'behavior': 'Scroll disabled',
      'color': Colors.indigo[700]!,
    },
    {
      'name': 'AlwaysScrollableScrollPhysics',
      'platform': 'Any',
      'icon': Icons.all_inclusive,
      'description': 'Ensures the scrollable is always scrollable, even '
          'if the content doesn\'t exceed the viewport. Makes '
          'RefreshIndicator work on short lists.',
      'behavior': 'Always scrollable',
      'color': Colors.orange[600]!,
    },
    {
      'name': 'PageScrollPhysics',
      'platform': 'Any',
      'icon': Icons.pages,
      'description': 'Snaps to page boundaries after a fling. Content '
          'settles on whole-page positions. Used automatically '
          'by PageView.',
      'behavior': 'Page snapping',
      'color': Colors.indigo[600]!,
    },
    {
      'name': 'FixedExtentScrollPhysics',
      'platform': 'Any',
      'icon': Icons.straighten,
      'description': 'Snaps to item boundaries at a fixed item extent. '
          'Used by ListWheelScrollView (CupertinoPicker). Content '
          'always settles on an item center.',
      'behavior': 'Item snapping',
      'color': Colors.orange[800]!,
    },
    {
      'name': 'RangeMaintainingScrollPhysics',
      'platform': 'Any',
      'icon': Icons.vertical_align_center,
      'description': 'Keeps scroll position within content range when '
          'content size changes. Prevents the viewport from '
          'showing empty space after a resize.',
      'behavior': 'Range-maintaining',
      'color': Colors.indigo[500]!,
    },
  ];

  print('  Subclasses: ${subclasses.length}');

  // ============================================================
  // SECTION 3: Side-by-Side Physics Comparison
  // ============================================================
  print('=== Section 3: Visual Comparison ===');

  final comparisonItems = List.generate(20, (i) => 'Item ${i + 1}');

  final physicsPairs = <Map<String, dynamic>>[
    {
      'name': 'Bouncing (iOS)',
      'physics': BouncingScrollPhysics(),
      'color': Colors.indigo[800]!,
    },
    {
      'name': 'Clamping (Android)',
      'physics': ClampingScrollPhysics(),
      'color': Colors.orange[700]!,
    },
  ];

  print('  Comparison items: ${comparisonItems.length}');

  // ============================================================
  // SECTION 4: Key Overridable Methods
  // ============================================================
  print('=== Section 4: Key Methods ===');

  final methods = <Map<String, dynamic>>[
    {
      'name': 'applyPhysicsToUserOffset',
      'signature': 'double applyPhysicsToUserOffset(\n'
          '  ScrollMetrics position,\n'
          '  double offset,\n'
          ')',
      'description': 'Transforms the raw pixel offset from the user\'s '
          'gesture into the actual scroll delta. Bouncing physics '
          'reduces the offset near boundaries for a rubber-band feel.',
      'color': Colors.indigo[800]!,
    },
    {
      'name': 'applyBoundaryConditions',
      'signature': 'double applyBoundaryConditions(\n'
          '  ScrollMetrics position,\n'
          '  double value,\n'
          ')',
      'description': 'Returns the overscroll amount that should NOT be '
          'applied. Clamping returns the excess; bouncing returns 0 '
          'to allow the overscroll to occur.',
      'color': Colors.orange[700]!,
    },
    {
      'name': 'createBallisticSimulation',
      'signature': 'Simulation? createBallisticSimulation(\n'
          '  ScrollMetrics position,\n'
          '  double velocity,\n'
          ')',
      'description': 'Creates the physics simulation for fling animations. '
          'Returns a ClampingScrollSimulation (friction) or '
          'BouncingScrollSimulation (spring + friction).',
      'color': Colors.indigo[700]!,
    },
    {
      'name': 'shouldAcceptUserOffset',
      'signature': 'bool shouldAcceptUserOffset(\n'
          '  ScrollMetrics position,\n'
          ')',
      'description': 'Whether the scrollable should respond to user gestures '
          'at all. NeverScrollableScrollPhysics returns false here.',
      'color': Colors.orange[600]!,
    },
    {
      'name': 'toleranceFor',
      'signature': 'Tolerance toleranceFor(\n'
          '  ScrollMetrics position,\n'
          ')',
      'description': 'Returns the velocity and distance thresholds below '
          'which the scroll is considered to have stopped. Affects '
          'when ballistic simulations settle.',
      'color': Colors.indigo[600]!,
    },
  ];

  print('  Methods: ${methods.length}');

  // ============================================================
  // SECTION 5: Physics Parent Chain
  // ============================================================
  print('=== Section 5: Parent Chain ===');

  final chainExample = <Map<String, dynamic>>[
    {
      'layer': 1,
      'name': 'AlwaysScrollable',
      'role': 'Ensures scrollable even if content fits',
      'color': Colors.indigo[800]!,
    },
    {
      'layer': 2,
      'name': 'BouncingScrollPhysics',
      'role': 'Overscroll + spring simulation',
      'color': Colors.orange[700]!,
    },
    {
      'layer': 3,
      'name': 'ScrollPhysics (base)',
      'role': 'Default implementations',
      'color': Colors.indigo[700]!,
    },
  ];

  final chainCode = 'AlwaysScrollableScrollPhysics(\n'
      '  parent: BouncingScrollPhysics(),\n'
      ')';

  print('  Chain layers: ${chainExample.length}');

  // ============================================================
  // SECTION 6: Platform Selection Logic
  // ============================================================
  print('=== Section 6: Platform Selection ===');

  final platformRules = <Map<String, dynamic>>[
    {
      'platform': 'iOS / macOS',
      'physics': 'BouncingScrollPhysics',
      'overscroll': 'Yes (rubber-band)',
      'indicator': 'None',
      'color': Colors.indigo[800]!,
    },
    {
      'platform': 'Android / Fuchsia',
      'physics': 'ClampingScrollPhysics',
      'overscroll': 'No (clamped)',
      'indicator': 'OverscrollIndicator glow',
      'color': Colors.orange[700]!,
    },
    {
      'platform': 'Web / Desktop',
      'physics': 'ClampingScrollPhysics',
      'overscroll': 'No (clamped)',
      'indicator': 'StretchingOverscrollIndicator',
      'color': Colors.indigo[700]!,
    },
  ];

  print('  Platform rules: ${platformRules.length}');

  // ============================================================
  // SECTION 7: Custom ScrollPhysics Example
  // ============================================================
  print('=== Section 7: Custom Physics ===');

  final customCode = '''class SlowScrollPhysics extends ScrollPhysics {
  const SlowScrollPhysics({super.parent});

  @override
  SlowScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SlowScrollPhysics(
      parent: buildParent(ancestor),
    );
  }

  @override
  double applyPhysicsToUserOffset(
    ScrollMetrics position,
    double offset,
  ) {
    // Reduce scroll speed by half
    return super.applyPhysicsToUserOffset(
      position, offset * 0.5,
    );
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    // Halve fling velocity for slower momentum
    return super.createBallisticSimulation(
      position, velocity * 0.5,
    );
  }
}''';

  print('  Custom physics code rendered');

  // ============================================================
  // SECTION 8: Best Practices
  // ============================================================
  print('=== Section 8: Best Practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'title': 'Always Override applyTo',
      'detail': 'Custom physics subclasses must override applyTo to '
          'preserve the parent chain. Without it, your custom physics '
          'loses delegation behavior in certain scroll contexts.',
      'icon': Icons.warning_amber,
      'color': Colors.indigo[800]!,
    },
    {
      'title': 'Test on Both Platforms',
      'detail': 'Scroll feel differs between iOS and Android. Test custom '
          'physics on both to ensure natural behavior. Consider using '
          'platform-specific parents.',
      'icon': Icons.devices,
      'color': Colors.orange[700]!,
    },
    {
      'title': 'Use AlwaysScrollable for RefreshIndicator',
      'detail': 'If your list has fewer items than the viewport, wrap '
          'physics in AlwaysScrollableScrollPhysics so the user can '
          'still pull-to-refresh.',
      'icon': Icons.refresh,
      'color': Colors.indigo[700]!,
    },
    {
      'title': 'NeverScrollable for Nested Lists',
      'detail': 'Inner scrollables of constrained height benefit from '
          'NeverScrollableScrollPhysics + shrinkWrap: true to avoid '
          'gesture conflicts with the outer scrollable.',
      'icon': Icons.layers,
      'color': Colors.orange[600]!,
    },
    {
      'title': 'Delegate to Parent, Don\'t Replace',
      'detail': 'In custom physics, call super.methodName instead of '
          'reimplementing from scratch. This preserves the parent '
          'chain and platform-specific behaviors.',
      'icon': Icons.account_tree,
      'color': Colors.indigo[600]!,
    },
  ];

  print('  Best practices: ${practices.length}');

  // ============================================================
  // BUILD THE UI
  // ============================================================
  print('=== Building UI ===');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---- Title Banner ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo[800]!, Colors.orange[600]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.speed, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text(
                'ScrollPhysics',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'The base class that governs how scrollables respond to '
                'gestures — friction, springs, boundaries, and momentum.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.indigo[800]!),
        SizedBox(height: 10),
        ...conceptCards.map((c) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (c['accent'] as Color).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: c['accent'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(c['icon'] as IconData, color: c['accent'] as Color, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(c['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: c['accent'] as Color)),
                          SizedBox(height: 4),
                          Text(c['body'] as String, style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 2: Built-in Subclasses ----
        _sectionHeader('2. Built-in Subclasses', Icons.account_tree, Colors.orange[700]!),
        SizedBox(height: 10),
        ...subclasses.map((s) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (s['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(s['icon'] as IconData, color: s['color'] as Color, size: 22),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(s['name'] as String,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'monospace', color: s['color'] as Color)),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (s['color'] as Color).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(s['platform'] as String,
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: s['color'] as Color)),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(s['description'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(s['behavior'] as String,
                                style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: Colors.grey[700])),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 3: Side-by-Side Physics ----
        _sectionHeader('3. Bouncing vs Clamping', Icons.compare, Colors.indigo[800]!),
        SizedBox(height: 10),
        Text(
          'Two identical lists with different physics. Scroll each to '
          'see how they handle overscroll at the boundaries:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 280,
          child: Row(
            children: physicsPairs.map((pp) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: pp['color'] as Color,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Text(pp['name'] as String,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: (pp['color'] as Color).withValues(alpha: 0.3)),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ListView.builder(
                            physics: pp['physics'] as ScrollPhysics,
                            itemCount: comparisonItems.length,
                            itemBuilder: (ctx, i) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: i.isEven
                                      ? (pp['color'] as Color).withValues(alpha: 0.06)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(comparisonItems[i],
                                    style: TextStyle(fontSize: 12)),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 4: Key Methods ----
        _sectionHeader('4. Key Overridable Methods', Icons.code, Colors.orange[700]!),
        SizedBox(height: 10),
        ...methods.map((m) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (m['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: m['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m['name'] as String,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace', color: m['color'] as Color)),
                    SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(m['signature'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
                    ),
                    SizedBox(height: 6),
                    Text(m['description'] as String, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 5: Parent Chain ----
        _sectionHeader('5. Parent Chain Composition', Icons.link, Colors.indigo[800]!),
        SizedBox(height: 10),
        Text(
          'Physics compose via parent chains. Each layer delegates '
          'unhandled behavior to its parent:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(chainCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.greenAccent[200])),
        ),
        SizedBox(height: 10),
        ...chainExample.map((layer) => Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: layer['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text('${layer['layer']}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (layer['color'] as Color).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(layer['name'] as String,
                        style: TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold, color: layer['color'] as Color)),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(layer['role'] as String,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ),
                  if (layer['layer'] as int < 3)
                    Icon(Icons.arrow_downward, size: 14, color: Colors.grey[400]),
                ],
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 6: Platform Selection ----
        _sectionHeader('6. Platform Selection', Icons.phone_android, Colors.orange[700]!),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                color: Colors.orange[700],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text('Platform', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 4, child: Text('Default Physics', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('Overscroll', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ],
                ),
              ),
              ...List.generate(platformRules.length, (i) {
                final r = platformRules[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.orange[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(r['platform'] as String,
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(r['physics'] as String,
                            style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(r['overscroll'] as String, style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 7: Custom ScrollPhysics ----
        _sectionHeader('7. Custom ScrollPhysics', Icons.build, Colors.indigo[800]!),
        SizedBox(height: 10),
        Text(
          'A custom ScrollPhysics that halves scroll speed and fling '
          'velocity — demonstrating the override pattern:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(customCode,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.indigo[700], size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Always override applyTo() in custom physics to ensure '
                  'the parent chain is preserved when the framework calls '
                  'ScrollPhysics.applyTo during scroll view construction.',
                  style: TextStyle(fontSize: 12, color: Colors.indigo[800]),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 8: Best Practices ----
        _sectionHeader('8. Best Practices', Icons.tips_and_updates, Colors.orange[700]!),
        SizedBox(height: 10),
        ...practices.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: (p['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(p['icon'] as IconData, color: p['color'] as Color, size: 18),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          SizedBox(height: 4),
                          Text(p['detail'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 24),

        // ---- Footer ----
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.speed, color: Colors.indigo[600], size: 28),
              SizedBox(height: 6),
              Text(
                'ScrollPhysics: the invisible engine that makes every '
                'scrollable feel native, responsive, and delightful.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}

// ── Helpers ──────────────────────────────────────────────────────

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 22),
      SizedBox(width: 8),
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
    ],
  );
}

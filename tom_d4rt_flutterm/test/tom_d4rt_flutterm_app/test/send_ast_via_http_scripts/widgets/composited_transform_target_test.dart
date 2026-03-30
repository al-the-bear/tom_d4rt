// ignore_for_file: avoid_print
// D4rt test script: Tests CompositedTransformTarget from widgets/basic.dart
// Deep Demo: Visual exploration of CompositedTransformTarget — the ANCHOR side
// of Flutter's composited-transform positioning system.
//
// CompositedTransformTarget (also known as the "leader") establishes a
// reference point in the compositing layer tree. One or more
// CompositedTransformFollower widgets can then track this position through
// transforms, scrolling, and layout changes via a shared LayerLink.
//
// While the Follower demo (its companion) focuses on anchor math and offsets,
// THIS demo focuses on what makes a good Target: placement strategies, the
// LayerLink lifecycle, multiple followers per target, multiple independent
// targets, and real-world anchor patterns.
//
// Scene 1 — The Three-Part System: Target, LayerLink, Follower architecture
// Scene 2 — Target Placement Gallery: positioning in various layout contexts
// Scene 3 — One Target, Many Followers: shared LayerLink radiating pattern
// Scene 4 — Multiple Independent Targets: isolated link channels
// Scene 5 — Target in Transformed & Nested Contexts
// Scene 6 — Real-World Anchor Patterns
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CompositedTransformTarget Deep Demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────────────────
  // Color palette — coral/navy/cream anchor theme
  // ──────────────────────────────────────────────────────────
  const cCoral = Color(0xFFE65100);       // deep coral/orange
  const cNavy = Color(0xFF1A237E);        // deep navy
  const cCream = Color(0xFFFFF8E1);       // warm cream surface
  const cTeal = Color(0xFF00796B);        // teal accent
  const cMagenta = Color(0xFFC2185B);     // magenta highlight
  const cSlate = Color(0xFF455A64);       // blue-grey slate
  const cSuccess = Color(0xFF2E7D32);     // green
  const cSky = Color(0xFF0288D1);         // sky blue

  // ──────────────────────────────────────────────────────────
  // Helper builders
  // ──────────────────────────────────────────────────────────

  Widget sceneHeader(String title, String subtitle, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 32.0, bottom: 14.0),
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.03)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 26.0, color: color),
          ),
          SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: color)),
                SizedBox(height: 2.0),
                Text(subtitle, style: TextStyle(fontSize: 10.5, color: color.withValues(alpha: 0.6))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoPanel(String text, {Color color = const Color(0xFF37474F)}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10.0),
        border: Border(left: BorderSide(color: color.withValues(alpha: 0.4), width: 3.0)),
      ),
      child: Text(text, style: TextStyle(fontSize: 12.0, height: 1.5, color: color.withValues(alpha: 0.85))),
    );
  }

  /// Builds a visual "target anchor" widget — the distinctive visual marker
  /// used throughout this demo to represent CompositedTransformTarget.
  Widget targetMarker(String label, Color color, {double size = 44.0}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2.5),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 8.0)],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.my_location, size: size * 0.38, color: color),
            if (label.isNotEmpty)
              Text(label, style: TextStyle(fontSize: 7.0, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  /// Builds a visual "follower" widget — a tag that visually follows the target.
  Widget followerTag(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 4.0, offset: Offset(0.0, 2.0))],
      ),
      child: Text(label, style: TextStyle(fontSize: 10.0, color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }

  // ============================================================
  // SCENE 1: The Three-Part System
  // ============================================================
  print('\n=== Scene 1: The Three-Part System ===');

  // Demonstrate the wiring: Target → LayerLink → Follower(s)
  final link1 = LayerLink();
  print('  Created LayerLink instance: $link1');

  // Live target + follower pair
  final liveTarget = CompositedTransformTarget(
    link: link1,
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: cCoral.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: cCoral, width: 2.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.my_location, size: 32.0, color: cCoral),
          SizedBox(height: 4.0),
          Text('TARGET', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cCoral, letterSpacing: 1.0)),
          Text('(Leader)', style: TextStyle(fontSize: 9.0, color: cCoral.withValues(alpha: 0.6))),
        ],
      ),
    ),
  );

  final liveFollower = CompositedTransformFollower(
    link: link1,
    targetAnchor: Alignment.topRight,
    followerAnchor: Alignment.topLeft,
    offset: Offset(8.0, 0.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: cNavy,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [BoxShadow(color: cNavy.withValues(alpha: 0.3), blurRadius: 6.0)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.near_me, size: 14.0, color: Colors.white),
          SizedBox(width: 4.0),
          Text('Follower', style: TextStyle(fontSize: 11.0, color: Colors.white, fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
  print('  Wired CompositedTransformTarget → LayerLink → CompositedTransformFollower');

  // Architecture diagram
  Widget archBlock(String title, String subtitle, IconData icon, Color bg, Color fg) {
    return Container(
      width: 100.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: fg.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24.0, color: fg),
          SizedBox(height: 4.0),
          Text(title, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: fg), textAlign: TextAlign.center),
          Text(subtitle, style: TextStyle(fontSize: 7.5, color: fg.withValues(alpha: 0.6)), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget arrowConnector(Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 20.0, height: 2.0, color: color.withValues(alpha: 0.4)),
        Icon(Icons.arrow_forward, size: 14.0, color: color.withValues(alpha: 0.6)),
        Container(width: 20.0, height: 2.0, color: color.withValues(alpha: 0.4)),
      ],
    );
  }

  final scene1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 1 — The Three-Part System',
        'Target (leader) → LayerLink (wire) → Follower(s)',
        Icons.hub,
        cCoral,
      ),
      infoPanel(
        'CompositedTransformTarget is one half of a two-widget positioning system. '
        'It wraps a child and registers a RenderLeaderLayer in the compositing tree. '
        'A CompositedTransformFollower reads this leader layer\'s position through the '
        'shared LayerLink to position itself relative to the target.\n\n'
        'The Target is the ANCHOR — it determines WHERE followers appear.\n'
        'The Follower is the SATELLITE — it determines HOW it aligns to the anchor.\n'
        'The LayerLink is the invisible WIRE connecting them across the widget tree.',
        color: cCoral,
      ),

      // Architecture diagram
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: cCoral.withValues(alpha: 0.15)),
          boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.06), blurRadius: 8.0)],
        ),
        child: Column(
          children: [
            Text('Architecture', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: cSlate)),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                archBlock('Target', 'RenderLeaderLayer', Icons.my_location, cCoral.withValues(alpha: 0.08), cCoral),
                arrowConnector(cCoral),
                archBlock('LayerLink', 'Position wire', Icons.link, cSlate.withValues(alpha: 0.06), cSlate),
                arrowConnector(cNavy),
                archBlock('Follower', 'RenderFollowerLayer', Icons.near_me, cNavy.withValues(alpha: 0.08), cNavy),
              ],
            ),
            SizedBox(height: 14.0),
            // Highlights for each role
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: cCoral.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                      children: [
                        Text('Leader Role', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: cCoral)),
                        Text('Publishes position', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600)),
                        Text('in compositing layer', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 6.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: cSlate.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                      children: [
                        Text('Bridge Role', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: cSlate)),
                        Text('Carries position data', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600)),
                        Text('between layers', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 6.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: cNavy.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                      children: [
                        Text('Follower Role', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: cNavy)),
                        Text('Reads & aligns to', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600)),
                        Text('leader position', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      SizedBox(height: 14.0),

      // Live demonstration: Target with a follower attached
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: cCoral.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Live Pair', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: cSlate)),
            SizedBox(height: 4.0),
            Text('A CompositedTransformTarget with a Follower attached via LayerLink',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
            SizedBox(height: 12.0),
            // Must use Stack for the follower to overlay
            SizedBox(
              height: 90.0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(left: 40.0, top: 10.0, child: liveTarget),
                  Positioned(left: 40.0, top: 10.0, child: liveFollower),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: cCoral.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'The Follower sits to the right of the Target, '
                'positioned via targetAnchor: topRight, followerAnchor: topLeft, offset: (8, 0).',
                style: TextStyle(fontSize: 9.5, fontFamily: 'monospace', color: cCoral),
              ),
            ),
          ],
        ),
      ),

      SizedBox(height: 12.0),

      // Constructor breakdown
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: cCoral.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: cCoral.withValues(alpha: 0.12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Constructor', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cCoral)),
            SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'CompositedTransformTarget(\n'
                '  link: LayerLink(),  // REQUIRED\n'
                '  child: Widget,      // the anchor widget\n'
                ')',
                style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: cCoral.withValues(alpha: 0.9), height: 1.5),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Only two parameters: the LayerLink and the child. The simplicity is intentional — '
              'all the logic lives in the compositing layer, not in widget properties.',
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600, height: 1.3),
            ),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 2: Target Placement Gallery
  // ============================================================
  print('\n=== Scene 2: Target Placement Gallery ===');

  // Each placement shows a Target in a different layout context
  // and a Follower tracking it — proving the Target's position drives everything.

  final linkCenter = LayerLink();
  final linkTopLeft = LayerLink();
  final linkBottomRight = LayerLink();
  final linkInRow = LayerLink();
  print('  Created 4 independent LayerLinks for placement demos');

  Widget placementCard(String title, String desc, Widget content, Color color) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.05), blurRadius: 6.0)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              SizedBox(width: 8.0),
              Text(title, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          SizedBox(height: 4.0),
          Text(desc, style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
          SizedBox(height: 10.0),
          content,
        ],
      ),
    );
  }

  // Placement 1: Center-aligned target
  final centerPlacement = SizedBox(
    height: 100.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: CompositedTransformTarget(
            link: linkCenter,
            child: targetMarker('CTR', cCoral),
          ),
        ),
        Center(
          child: CompositedTransformFollower(
            link: linkCenter,
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            offset: Offset(0.0, 6.0),
            child: followerTag('Below center', cNavy),
          ),
        ),
      ],
    ),
  );
  print('  Center placement: target centered, follower below');

  // Placement 2: Top-left corner target
  final topLeftPlacement = SizedBox(
    height: 80.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 0.0,
          top: 0.0,
          child: CompositedTransformTarget(
            link: linkTopLeft,
            child: targetMarker('TL', cTeal, size: 36.0),
          ),
        ),
        Positioned(
          left: 0.0,
          top: 0.0,
          child: CompositedTransformFollower(
            link: linkTopLeft,
            targetAnchor: Alignment.centerRight,
            followerAnchor: Alignment.centerLeft,
            offset: Offset(6.0, 0.0),
            child: followerTag('Right of TL', cTeal),
          ),
        ),
      ],
    ),
  );
  print('  Top-left placement: follower to the right');

  // Placement 3: Bottom-right corner target
  final bottomRightPlacement = SizedBox(
    height: 80.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 0.0,
          bottom: 0.0,
          child: CompositedTransformTarget(
            link: linkBottomRight,
            child: targetMarker('BR', cMagenta, size: 36.0),
          ),
        ),
        Positioned(
          right: 0.0,
          bottom: 0.0,
          child: CompositedTransformFollower(
            link: linkBottomRight,
            targetAnchor: Alignment.topCenter,
            followerAnchor: Alignment.bottomCenter,
            offset: Offset(0.0, -6.0),
            child: followerTag('Above BR', cMagenta),
          ),
        ),
      ],
    ),
  );
  print('  Bottom-right placement: follower above');

  // Placement 4: Inline in a Row
  final inRowPlacement = SizedBox(
    height: 80.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8.0)),
              child: Text('Item A', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
            ),
            CompositedTransformTarget(
              link: linkInRow,
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: cSky.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: cSky, width: 1.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.my_location, size: 14.0, color: cSky),
                    SizedBox(width: 4.0),
                    Text('Target B', style: TextStyle(fontSize: 11.0, color: cSky, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8.0)),
              child: Text('Item C', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
            ),
          ],
        ),
        CompositedTransformFollower(
          link: linkInRow,
          targetAnchor: Alignment.bottomCenter,
          followerAnchor: Alignment.topCenter,
          offset: Offset(0.0, 8.0),
          child: followerTag('Attached to B', cSky),
        ),
      ],
    ),
  );
  print('  In-Row placement: target is middle item in row, follower below');

  final scene2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 2 — Target Placement Gallery',
        'CompositedTransformTarget in different layout positions',
        Icons.grid_view,
        cNavy,
      ),
      infoPanel(
        'The Target can live ANYWHERE in the widget tree — centered, corner-pinned, '
        'inline in a Row, nested inside padding. The compositing layer tracks its '
        'absolute position regardless of layout ancestry. Wherever you put the Target, '
        'its Followers will find it through the LayerLink.',
        color: cNavy,
      ),

      placementCard('Center Aligned', 'Target centered in container, follower below', centerPlacement, cCoral),
      placementCard('Top-Left Corner', 'Target at (0,0), follower extends rightward', topLeftPlacement, cTeal),
      placementCard('Bottom-Right Corner', 'Target at bottom-right, follower above', bottomRightPlacement, cMagenta),
      placementCard('Inline in Row', 'Target is the middle item in a horizontal row', inRowPlacement, cSky),

      // Placement tip
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: cNavy.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: cNavy.withValues(alpha: 0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lightbulb, size: 16.0, color: cNavy),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'Tip: The Target wraps the widget that serves as the visual anchor. '
                'The Follower does NOT need to be a sibling — it can be anywhere in the '
                'widget tree as long as it shares the same LayerLink and both are in the '
                'same Overlay or Stack.',
                style: TextStyle(fontSize: 10.0, color: cNavy.withValues(alpha: 0.7), height: 1.3),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 3: One Target, Many Followers
  // ============================================================
  print('\n=== Scene 3: One Target, Many Followers ===');

  final sharedLink = LayerLink();
  print('  Single LayerLink shared by 1 target and 4 followers');

  // One target, four followers at different anchor points
  final singleTarget = CompositedTransformTarget(
    link: sharedLink,
    child: Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [cCoral.withValues(alpha: 0.2), cCoral.withValues(alpha: 0.05)],
        ),
        shape: BoxShape.circle,
        border: Border.all(color: cCoral, width: 2.5),
        boxShadow: [BoxShadow(color: cCoral.withValues(alpha: 0.15), blurRadius: 12.0)],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.my_location, size: 20.0, color: cCoral),
            Text('HUB', style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: cCoral, letterSpacing: 1.0)),
          ],
        ),
      ),
    ),
  );

  // Follower: top
  final followerTop = CompositedTransformFollower(
    link: sharedLink,
    targetAnchor: Alignment.topCenter,
    followerAnchor: Alignment.bottomCenter,
    offset: Offset(0.0, -10.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: cTeal,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [BoxShadow(color: cTeal.withValues(alpha: 0.3), blurRadius: 4.0)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Tooltip', style: TextStyle(fontSize: 9.0, color: Colors.white, fontWeight: FontWeight.bold)),
          Text('topCenter', style: TextStyle(fontSize: 7.0, color: Colors.white70)),
        ],
      ),
    ),
  );

  // Follower: right 
  final followerRight = CompositedTransformFollower(
    link: sharedLink,
    targetAnchor: Alignment.centerRight,
    followerAnchor: Alignment.centerLeft,
    offset: Offset(10.0, 0.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: cNavy,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [BoxShadow(color: cNavy.withValues(alpha: 0.3), blurRadius: 4.0)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Badge', style: TextStyle(fontSize: 9.0, color: Colors.white, fontWeight: FontWeight.bold)),
          Text('centerRight', style: TextStyle(fontSize: 7.0, color: Colors.white70)),
        ],
      ),
    ),
  );

  // Follower: bottom
  final followerBottom = CompositedTransformFollower(
    link: sharedLink,
    targetAnchor: Alignment.bottomCenter,
    followerAnchor: Alignment.topCenter,
    offset: Offset(0.0, 10.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: cMagenta,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [BoxShadow(color: cMagenta.withValues(alpha: 0.3), blurRadius: 4.0)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Label', style: TextStyle(fontSize: 9.0, color: Colors.white, fontWeight: FontWeight.bold)),
          Text('bottomCenter', style: TextStyle(fontSize: 7.0, color: Colors.white70)),
        ],
      ),
    ),
  );

  // Follower: left
  final followerLeft = CompositedTransformFollower(
    link: sharedLink,
    targetAnchor: Alignment.centerLeft,
    followerAnchor: Alignment.centerRight,
    offset: Offset(-10.0, 0.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: cSuccess,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [BoxShadow(color: cSuccess.withValues(alpha: 0.3), blurRadius: 4.0)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Menu', style: TextStyle(fontSize: 9.0, color: Colors.white, fontWeight: FontWeight.bold)),
          Text('centerLeft', style: TextStyle(fontSize: 7.0, color: Colors.white70)),
        ],
      ),
    ),
  );

  print('  4 followers: Tooltip(top), Badge(right), Label(bottom), Menu(left)');

  final scene3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 3 — One Target, Many Followers',
        'A single anchor hub radiating multiple attached elements',
        Icons.hub,
        cTeal,
      ),
      infoPanel(
        'A LayerLink can be shared by ONE target and MULTIPLE followers. This is '
        'the typical pattern for coach marks, contextual menus, badges, and tooltip '
        'clusters that all radiate from a single anchor point.\n\n'
        'Each follower independently chooses its targetAnchor, followerAnchor, and '
        'offset — so they can surround the target without interfering.',
        color: cTeal,
      ),

      // Hub visualization
      Container(
        width: double.infinity,
        height: 180.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: cTeal.withValues(alpha: 0.15)),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Place target at center
            Positioned(
              left: 0.0,
              right: 0.0,
              top: 50.0,
              child: Center(child: singleTarget),
            ),
            // All four followers track the same target
            Positioned(left: 0.0, right: 0.0, top: 50.0, child: Center(child: followerTop)),
            Positioned(left: 0.0, right: 0.0, top: 50.0, child: Center(child: followerRight)),
            Positioned(left: 0.0, right: 0.0, top: 50.0, child: Center(child: followerBottom)),
            Positioned(left: 0.0, right: 0.0, top: 50.0, child: Center(child: followerLeft)),
          ],
        ),
      ),

      SizedBox(height: 10.0),

      // Color legend
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: [
            _legendDot('Target (hub)', cCoral),
            _legendDot('Tooltip (top)', cTeal),
            _legendDot('Badge (right)', cNavy),
            _legendDot('Label (bottom)', cMagenta),
            _legendDot('Menu (left)', cSuccess),
          ],
        ),
      ),

      SizedBox(height: 10.0),

      // Detail table
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: cTeal.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cTeal.withValues(alpha: 0.12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Follower Anchoring Details', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cTeal)),
            SizedBox(height: 8.0),
            _anchorRow('Tooltip', 'topCenter', 'bottomCenter', '(0, -10)', cTeal),
            _anchorRow('Badge', 'centerRight', 'centerLeft', '(10, 0)', cNavy),
            _anchorRow('Label', 'bottomCenter', 'topCenter', '(0, 10)', cMagenta),
            _anchorRow('Menu', 'centerLeft', 'centerRight', '(-10, 0)', cSuccess),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 4: Multiple Independent Targets
  // ============================================================
  print('\n=== Scene 4: Multiple Independent Targets ===');

  final linkA = LayerLink();
  final linkB = LayerLink();
  final linkC = LayerLink();
  print('  3 independent LayerLinks for 3 separate target-follower pairs');

  Widget independentPair(String name, LayerLink link, Color color, Alignment tAnchor, Alignment fAnchor, Offset offset) {
    return SizedBox(
      width: 110.0,
      height: 110.0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // The target
          Center(
            child: CompositedTransformTarget(
              link: link,
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2.0),
                ),
                child: Center(
                  child: Text(name, style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: color)),
                ),
              ),
            ),
          ),
          // The matched follower
          Center(
            child: CompositedTransformFollower(
              link: link,
              targetAnchor: tAnchor,
              followerAnchor: fAnchor,
              offset: offset,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text('F-$name', style: TextStyle(fontSize: 8.0, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final scene4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 4 — Multiple Independent Targets',
        'Separate LayerLinks isolate each target-follower channel',
        Icons.device_hub,
        cMagenta,
      ),
      infoPanel(
        'Each LayerLink is an isolated communication channel. Target-A\'s followers '
        'cannot accidentally track Target-B. This is how dropdown menus, autocomplete '
        'suggestions, and multi-tooltip UIs avoid cross-contamination.\n\n'
        'Rule: one LayerLink = one target + zero or more followers.\n'
        'A LayerLink with no target causes followers to either hide (showWhenUnlinked: false) '
        'or paint at the origin (showWhenUnlinked: true).',
        color: cMagenta,
      ),

      // Three independent pairs side by side
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: cMagenta.withValues(alpha: 0.15)),
        ),
        child: Column(
          children: [
            Text('3 Independent Target-Follower Pairs', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cSlate)),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                independentPair('A', linkA, cCoral, Alignment.bottomCenter, Alignment.topCenter, Offset(0.0, 6.0)),
                independentPair('B', linkB, cTeal, Alignment.topCenter, Alignment.bottomCenter, Offset(0.0, -6.0)),
                independentPair('C', linkC, cNavy, Alignment.centerRight, Alignment.centerLeft, Offset(6.0, 0.0)),
              ],
            ),
            SizedBox(height: 10.0),
            // Isolation diagram
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _linkLabel('LinkA', cCoral),
                _linkLabel('LinkB', cTeal),
                _linkLabel('LinkC', cNavy),
              ],
            ),
          ],
        ),
      ),

      SizedBox(height: 10.0),

      // Contrast explanation
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Scene 3 vs Scene 4 Comparison', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cSlate)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: cTeal.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: cTeal.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.hub, size: 24.0, color: cTeal),
                        SizedBox(height: 4.0),
                        Text('1 Target → N Followers', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: cTeal), textAlign: TextAlign.center),
                        Text('Shared LayerLink', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600), textAlign: TextAlign.center),
                        Text('Hub-and-spoke pattern', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: cMagenta.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: cMagenta.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.device_hub, size: 24.0, color: cMagenta),
                        SizedBox(height: 4.0),
                        Text('N Targets → N Followers', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: cMagenta), textAlign: TextAlign.center),
                        Text('Separate LayerLinks', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600), textAlign: TextAlign.center),
                        Text('Isolated channels', style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 5: Target in Transformed & Nested Contexts
  // ============================================================
  print('\n=== Scene 5: Transformed & Nested Targets ===');

  final linkRotated = LayerLink();
  final linkScaled = LayerLink();
  final linkPadded = LayerLink();
  final linkNested = LayerLink();
  print('  4 LayerLinks for transform/nesting demos');

  // Rotated target
  final rotatedDemo = SizedBox(
    height: 110.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Transform.rotate(
            angle: 0.3,
            child: CompositedTransformTarget(
              link: linkRotated,
              child: Container(
                width: 70.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: cCoral.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: cCoral, width: 1.5),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.rotate_right, size: 14.0, color: cCoral),
                      SizedBox(width: 4.0),
                      Text('0.3 rad', style: TextStyle(fontSize: 9.0, color: cCoral, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: CompositedTransformFollower(
            link: linkRotated,
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            offset: Offset(0.0, 8.0),
            child: followerTag('Tracks rotated target', cNavy),
          ),
        ),
      ],
    ),
  );
  print('  Rotated target: Transform.rotate(angle: 0.3)');

  // Scaled target
  final scaledDemo = SizedBox(
    height: 110.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Transform.scale(
            scale: 1.4,
            child: CompositedTransformTarget(
              link: linkScaled,
              child: Container(
                width: 50.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: cTeal.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: cTeal, width: 1.5),
                ),
                child: Center(
                  child: Text('1.4×', style: TextStyle(fontSize: 10.0, color: cTeal, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: CompositedTransformFollower(
            link: linkScaled,
            targetAnchor: Alignment.topCenter,
            followerAnchor: Alignment.bottomCenter,
            offset: Offset(0.0, -8.0),
            child: followerTag('Tracks scaled target', cTeal),
          ),
        ),
      ],
    ),
  );
  print('  Scaled target: Transform.scale(scale: 1.4)');

  // Deeply padded target
  final paddedDemo = SizedBox(
    height: 100.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: CompositedTransformTarget(
                link: linkPadded,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: cMagenta.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: cMagenta),
                  ),
                  child: Text('Deep', style: TextStyle(fontSize: 10.0, color: cMagenta, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: CompositedTransformFollower(
            link: linkPadded,
            targetAnchor: Alignment.centerRight,
            followerAnchor: Alignment.centerLeft,
            offset: Offset(6.0, 0.0),
            child: followerTag('Found through nesting', cMagenta),
          ),
        ),
      ],
    ),
  );
  print('  Deeply padded target: nested inside multiple containers');

  // Nested inside a Card-like structure
  final nestedDemo = SizedBox(
    height: 100.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.15), blurRadius: 8.0)],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person, size: 28.0, color: cSlate),
                SizedBox(width: 10.0),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('John Doe', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold)),
                    CompositedTransformTarget(
                      link: linkNested,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: cSky.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text('@johndoe', style: TextStyle(fontSize: 10.0, color: cSky)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Center(
          child: CompositedTransformFollower(
            link: linkNested,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            offset: Offset(0.0, 4.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: cSky,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text('View profile', style: TextStyle(fontSize: 9.0, color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ],
    ),
  );
  print('  Nested target: @username inside a card, follower tracks the tag');

  Widget transformCard(String name, String description, Widget demo, Color color) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: color)),
          SizedBox(height: 3.0),
          Text(description, style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
          SizedBox(height: 8.0),
          demo,
        ],
      ),
    );
  }

  final scene5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 5 — Transformed & Nested Targets',
        'Targets remain trackable through rotations, scales, and deep nesting',
        Icons.transform,
        cSlate,
      ),
      infoPanel(
        'The compositing layer tracks position AFTER all transforms are applied. '
        'If a Target is inside a Transform.rotate, the follower positions itself '
        'relative to the target\'s final composited (screen-space) position — not '
        'its local-coordinate position.\n\n'
        'This is the key advantage over manual Offset calculations: the system works '
        'through any number of ancestor transforms automatically.',
        color: cSlate,
      ),

      transformCard('Rotated Target', 'Target inside Transform.rotate(angle: 0.3 rad). Follower tracks the rotated position.', rotatedDemo, cCoral),
      transformCard('Scaled Target', 'Target inside Transform.scale(scale: 1.4×). Follower aligns to the enlarged boundary.', scaledDemo, cTeal),
      transformCard('Deeply Padded Target', 'Target nested 2 levels deep in padding containers. LayerLink pierces through.', paddedDemo, cMagenta),
      transformCard('Nested in Card', 'Target wraps @username text inside a profile card. Follower attaches to just that element.', nestedDemo, cSky),

      SizedBox(height: 8.0),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: cSlate.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(left: BorderSide(color: cSlate, width: 3.0)),
        ),
        child: Text(
          'Key insight: CompositedTransformTarget works at the COMPOSITING layer — '
          'below the widget tree, below the render tree. This is why it survives transforms, '
          'scrolling, and complex nesting. It operates on final, composited coordinates.',
          style: TextStyle(fontSize: 10.5, color: cSlate, height: 1.4),
        ),
      ),
    ],
  );

  // ============================================================
  // SCENE 6: Real-World Anchor Patterns
  // ============================================================
  print('\n=== Scene 6: Real-World Anchor Patterns ===');

  // Pattern 1: Dropdown trigger button
  final linkDropdown = LayerLink();
  final dropdownPattern = SizedBox(
    height: 120.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 20.0,
          top: 10.0,
          child: CompositedTransformTarget(
            link: linkDropdown,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cSlate.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Select country', style: TextStyle(fontSize: 12.0, color: cSlate)),
                  SizedBox(width: 8.0),
                  Icon(Icons.arrow_drop_down, color: cSlate, size: 20.0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          top: 10.0,
          child: CompositedTransformFollower(
            link: linkDropdown,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            offset: Offset(0.0, 4.0),
            child: Container(
              width: 160.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.12), blurRadius: 12.0)],
                border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _dropdownItem('United States', true, cCoral),
                  _dropdownItem('Canada', false, cCoral),
                  _dropdownItem('United Kingdom', false, cCoral),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
  print('  Pattern 1: Dropdown trigger — follower as menu beneath button');

  // Pattern 2: Tooltip anchor for icon
  final linkTooltip = LayerLink();
  final tooltipPattern = SizedBox(
    height: 80.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Encryption ', style: TextStyle(fontSize: 12.0, color: cSlate)),
              CompositedTransformTarget(
                link: linkTooltip,
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: cSky.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.help_outline, size: 16.0, color: cSky),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: CompositedTransformFollower(
            link: linkTooltip,
            targetAnchor: Alignment.topCenter,
            followerAnchor: Alignment.bottomCenter,
            offset: Offset(0.0, -6.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text('AES-256 encryption protects\nyour data at rest',
                  style: TextStyle(fontSize: 10.0, color: Colors.white, height: 1.3)),
            ),
          ),
        ),
      ],
    ),
  );
  print('  Pattern 2: Tooltip — hovering explanation above help icon');

  // Pattern 3: Coach mark / onboarding spotlight
  final linkCoach = LayerLink();
  final coachPattern = SizedBox(
    height: 120.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: CompositedTransformTarget(
            link: linkCoach,
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: cSuccess.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: cSuccess, width: 2.0),
                boxShadow: [BoxShadow(color: cSuccess.withValues(alpha: 0.15), blurRadius: 16.0, spreadRadius: 4.0)],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_circle_outline, color: cSuccess, size: 22.0),
                  SizedBox(width: 8.0),
                  Text('New Project', style: TextStyle(fontSize: 12.0, color: cSuccess, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: CompositedTransformFollower(
            link: linkCoach,
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            offset: Offset(0.0, 14.0),
            child: Container(
              width: 200.0,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: cSuccess,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [BoxShadow(color: cSuccess.withValues(alpha: 0.3), blurRadius: 8.0)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Step 1 of 3', style: TextStyle(fontSize: 9.0, color: Colors.white70)),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text('Skip', style: TextStyle(fontSize: 8.0, color: Colors.white)),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text('Tap here to create your first project!',
                      style: TextStyle(fontSize: 11.0, color: Colors.white, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
  print('  Pattern 3: Coach mark — spotlight + instruction card');

  // Pattern 4: Badge anchor on avatar
  final linkBadge = LayerLink();
  final badgePattern = SizedBox(
    height: 80.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: CompositedTransformTarget(
            link: linkBadge,
            child: Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cNavy.withValues(alpha: 0.1),
                border: Border.all(color: cNavy.withValues(alpha: 0.3), width: 2.0),
              ),
              child: Center(
                child: Text('JD', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: cNavy)),
              ),
            ),
          ),
        ),
        Center(
          child: CompositedTransformFollower(
            link: linkBadge,
            targetAnchor: Alignment.topRight,
            followerAnchor: Alignment.center,
            offset: Offset(-2.0, 2.0),
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: cSuccess,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.0),
              ),
            ),
          ),
        ),
      ],
    ),
  );
  print('  Pattern 4: Status badge on avatar — green dot top-right');

  // Pattern 5: Connected callout / annotation line
  final linkAnnotation = LayerLink();
  final annotationPattern = SizedBox(
    height: 100.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 30.0,
          top: 20.0,
          child: CompositedTransformTarget(
            link: linkAnnotation,
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: cMagenta.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: cMagenta.withValues(alpha: 0.3)),
              ),
              child: Text('revenue_q4', style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: cMagenta)),
            ),
          ),
        ),
        Positioned(
          left: 30.0,
          top: 20.0,
          child: CompositedTransformFollower(
            link: linkAnnotation,
            targetAnchor: Alignment.centerRight,
            followerAnchor: Alignment.centerLeft,
            offset: Offset(12.0, 0.0),
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: cMagenta.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cMagenta.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.trending_up, size: 16.0, color: cMagenta),
                  SizedBox(width: 6.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\$2.4M', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cMagenta)),
                      Text('+18% YoY', style: TextStyle(fontSize: 9.0, color: cSuccess)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
  print('  Pattern 5: Annotation callout — data popup attached to code');

  // Pattern 6: Autocomplete suggestion anchor
  final linkAutocomplete = LayerLink();
  final autocompletePattern = SizedBox(
    height: 140.0,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 20.0,
          top: 10.0,
          child: CompositedTransformTarget(
            link: linkAutocomplete,
            child: Container(
              width: 220.0,
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cSky.withValues(alpha: 0.4)),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 18.0, color: Colors.grey.shade400),
                  SizedBox(width: 8.0),
                  Text('Flut', style: TextStyle(fontSize: 12.0, color: cSlate)),
                  Container(width: 1.0, height: 16.0, color: cSky),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          top: 10.0,
          child: CompositedTransformFollower(
            link: linkAutocomplete,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            offset: Offset(0.0, 2.0),
            child: Container(
              width: 220.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10.0)],
                border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _autoCompleteItem('Flutter', 'framework', true, cSky),
                  _autoCompleteItem('Flutter Web', 'platform', false, cSky),
                  _autoCompleteItem('FlutterFire', 'plugin', false, cSky),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
  print('  Pattern 6: Autocomplete — suggestion list anchored to search field');

  Widget patternCard(String name, String desc, Widget visual, Color color, String setup) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.04), blurRadius: 8.0, offset: Offset(0.0, 3.0))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: color)),
          SizedBox(height: 3.0),
          Text(desc, style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
          SizedBox(height: 10.0),
          visual,
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(6.0),
              border: Border(left: BorderSide(color: color.withValues(alpha: 0.3), width: 2.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.my_location, size: 13.0, color: color),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(setup, style: TextStyle(fontSize: 9.5, color: color.withValues(alpha: 0.8), height: 1.3)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final scene6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 6 — Real-World Anchor Patterns',
        'Six production patterns where CompositedTransformTarget is the anchor',
        Icons.architecture,
        Colors.brown,
      ),
      infoPanel(
        'In production Flutter apps, CompositedTransformTarget appears whenever '
        'you need a stable reference point that floating UI can track. Here are '
        'six common patterns — from the target\'s perspective, showing how the '
        'anchor is set up and what kind of follower it supports.',
        color: Colors.brown,
      ),

      patternCard(
        'Dropdown Trigger',
        'Button that anchors a floating menu below itself',
        dropdownPattern,
        cCoral,
        'Target wraps the button. Follower opens below via targetAnchor: bottomLeft. '
        'This is how DropdownButton, PopupMenuButton, and Autocomplete work internally.',
      ),

      patternCard(
        'Tooltip Anchor',
        'Help icon that anchors an explanatory popup above',
        tooltipPattern,
        cSky,
        'Target wraps the tiny help icon. Follower appears above via targetAnchor: topCenter. '
        'The target is small but precisely positioned.',
      ),

      patternCard(
        'Coach Mark / Onboarding Spotlight',
        'Highlighted button with instructional overlay attached',
        coachPattern,
        cSuccess,
        'Target wraps the UI element being spotlighted. The coach mark follower floats '
        'below with step counter and instructional text.',
      ),

      patternCard(
        'Status Badge',
        'User avatar with online indicator anchored at top-right corner',
        badgePattern,
        cNavy,
        'Target wraps the avatar circle. A tiny follower (green dot) anchors at topRight, '
        'centered on itself, creating the classic status badge offset.',
      ),

      patternCard(
        'Annotation / Callout',
        'Code element with data popup anchored to its right edge',
        annotationPattern,
        cMagenta,
        'Target wraps the annotated text span (variable name). Follower presents rich '
        'data alongside it — used in IDEs, analytics dashboards, and document annotations.',
      ),

      patternCard(
        'Autocomplete Suggestions',
        'Search field with floating suggestion list below',
        autocompletePattern,
        cSky,
        'Target wraps the entire text input. Follower suggestion list matches left edge and '
        'width via targetAnchor: bottomLeft. This is how Flutter\'s Autocomplete widget works.',
      ),
    ],
  );

  // ============================================================
  // BUILD SUMMARY
  // ============================================================
  print('\n=== Build Summary ===');
  print('Scene 1: Three-Part System — architecture diagram + live pair');
  print('Scene 2: Target Placement Gallery — 4 layout positions');
  print('Scene 3: One Target, Many Followers — hub-and-spoke pattern');
  print('Scene 4: Multiple Independent Targets — 3 isolated channels');
  print('Scene 5: Transformed & Nested Targets — rotation, scale, deep nesting');
  print('Scene 6: Real-World Anchor Patterns — 6 production patterns');
  print('CompositedTransformTarget Deep Demo completed');

  // ============================================================
  // FINAL ASSEMBLY
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: cCoral,
      scaffoldBackgroundColor: cCream,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('CompositedTransformTarget Deep Demo'),
        centerTitle: true,
        backgroundColor: cCoral,
        foregroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cCoral.withValues(alpha: 0.12), cNavy.withValues(alpha: 0.06)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: cCoral.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: cCoral.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.my_location, size: 34.0, color: cCoral),
                      ),
                      SizedBox(width: 14.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CompositedTransformTarget', style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold, color: cCoral)),
                            Text('The Anchor Widget', style: TextStyle(fontSize: 12.0, color: cNavy.withValues(alpha: 0.6))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    'CompositedTransformTarget is the LEADER half of Flutter\'s transform-linked '
                    'positioning system. It wraps any widget and publishes that widget\'s composited '
                    'position through a shared LayerLink. One or more CompositedTransformFollower '
                    'widgets then read this position to place themselves relative to the target — '
                    'through transforms, scrolling, and complex nesting — without manual coordinate math.\n\n'
                    'If CompositedTransformFollower is the satellite, this widget is the ground station.',
                    style: TextStyle(fontSize: 12.0, height: 1.5, color: Colors.grey.shade800),
                  ),
                  SizedBox(height: 10.0),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 4.0,
                    children: [
                      Chip(label: Text('widgets/basic.dart'), backgroundColor: cCoral.withValues(alpha: 0.08)),
                      Chip(label: Text('RenderLeaderLayer'), backgroundColor: cNavy.withValues(alpha: 0.08)),
                      Chip(label: Text('LayerLink'), backgroundColor: cTeal.withValues(alpha: 0.08)),
                      Chip(label: Text('Compositing'), backgroundColor: cSlate.withValues(alpha: 0.08)),
                    ],
                  ),
                ],
              ),
            ),

            scene1,
            scene2,
            scene3,
            scene4,
            scene5,
            scene6,

            // Footer
            SizedBox(height: 24.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: cCoral.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: cCoral.withValues(alpha: 0.15)),
              ),
              child: Column(
                children: [
                  Text('End of CompositedTransformTarget Deep Demo',
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cCoral)),
                  SizedBox(height: 4.0),
                  Text(
                    '6 scenes · Architecture diagram · 4 layout placements · 1-to-N followers · '
                    'N independent targets · 4 transform contexts · 6 real-world patterns',
                    style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Top-level helper widgets (outside build to avoid local-function nesting)
// ──────────────────────────────────────────────────────────

Widget _legendDot(String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      SizedBox(width: 4.0),
      Text(label, style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600)),
    ],
  );
}

Widget _anchorRow(String name, String target, String follower, String offset, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.0),
        SizedBox(width: 50.0, child: Text(name, style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: color))),
        Expanded(
          child: Text(
            'target: $target → follower: $follower, offset: $offset',
            style: TextStyle(fontSize: 8.0, fontFamily: 'monospace', color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}

Widget _linkLabel(String name, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.link, size: 10.0, color: color),
        SizedBox(width: 3.0),
        Text(name, style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: color)),
      ],
    ),
  );
}

Widget _dropdownItem(String text, bool selected, Color color) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: selected ? color.withValues(alpha: 0.06) : Colors.transparent,
    ),
    child: Row(
      children: [
        Text(text, style: TextStyle(
          fontSize: 11.0,
          color: selected ? color : Colors.grey.shade700,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        )),
        if (selected) ...[
          Spacer(),
          Icon(Icons.check, size: 14.0, color: color),
        ],
      ],
    ),
  );
}

Widget _autoCompleteItem(String text, String type, bool highlighted, Color color) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: highlighted ? color.withValues(alpha: 0.06) : Colors.transparent,
    ),
    child: Row(
      children: [
        Icon(Icons.search, size: 14.0, color: highlighted ? color : Colors.grey.shade400),
        SizedBox(width: 8.0),
        Expanded(child: Text(text, style: TextStyle(fontSize: 11.0, color: highlighted ? color : Colors.grey.shade700))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(type, style: TextStyle(fontSize: 8.0, color: Colors.grey.shade500)),
        ),
      ],
    ),
  );
}

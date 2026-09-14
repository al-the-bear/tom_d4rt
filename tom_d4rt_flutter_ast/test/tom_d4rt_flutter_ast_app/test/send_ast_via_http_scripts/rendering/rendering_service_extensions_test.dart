// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt deep-visual demo: RenderingServiceExtensions enum from package:flutter/rendering.dart
// Each enum value gets a distinct visual treatment showing what the debug toggle reveals.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Hero header gradient palette
  // ============================================================
  final heroGradient = LinearGradient(
    colors: [
      Color(0xFF0F2027),
      Color(0xFF203A43),
      Color(0xFF2C5364),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  final heroShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.45),
    blurRadius: 28.0,
    spreadRadius: 2.0,
    offset: Offset(0.0, 14.0),
  );

  final hero = Container(
    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: heroGradient,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [heroShadow],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.cyanAccent.shade400, Colors.tealAccent.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withValues(alpha: 0.6),
                    blurRadius: 16.0,
                    offset: Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: Icon(Icons.layers_outlined, size: 36.0, color: Colors.black87),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RenderingServiceExtensions',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/rendering.dart  -  ${RenderingServiceExtensions.values.length} debug toggles',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white70,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.4), width: 1.0),
          ),
          child: Text(
            'Each value is the name of a VM service extension registered by '
            'RendererBinding.initServiceExtensions(). DevTools and ext.flutter.* '
            'callers use these names to flip rendering-pipeline debug flags.',
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.white,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of a debug rendering toggle
  // ============================================================
  final anatomyGradient = LinearGradient(
    colors: [Colors.indigo.shade50, Colors.blue.shade50, Colors.cyan.shade50],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  final anatomy = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: anatomyGradient,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.indigo.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of a debug rendering toggle',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _anatomyNode('DevTools / IDE', Icons.developer_mode, Colors.deepPurple),
            _anatomyArrow(Colors.deepPurple),
            _anatomyNode('ext.flutter.<name>', Icons.api, Colors.indigo),
            _anatomyArrow(Colors.indigo),
            _anatomyNode('debug flag', Icons.toggle_on, Colors.teal),
            _anatomyArrow(Colors.teal),
            _anatomyNode('paint() / layout()', Icons.brush, Colors.orange),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            '.name on each enum value yields the wire string ("debugPaint", '
            '"repaintRainbow", ...). Calling that extension toggles the '
            'underlying flag (debugPaintSizeEnabled, debugRepaintRainbowEnabled, ...) '
            'which the rendering pipeline reads on the next paint or layout.',
            style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade900, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-value cards (each value gets a distinct visual)
  // ============================================================
  final perValueCards = <Widget>[];

  // 3.1 invertOversizedImages -> show inverted thumbnails
  perValueCards.add(_valueCardScaffold(
    value: RenderingServiceExtensions.invertOversizedImages,
    accent: Colors.pink,
    summary: 'Color-inverts and horizontally flips images decoded too big.',
    flagName: 'debugInvertOversizedImages',
    visual: _invertImagesVisual(),
  ));

  // 3.2 debugPaint -> show layout overlay
  perValueCards.add(_valueCardScaffold(
    value: RenderingServiceExtensions.debugPaint,
    accent: Colors.teal,
    summary: 'Outlines RenderBox bounds, padding, alignments and construction lines.',
    flagName: 'debugPaintSizeEnabled',
    visual: _debugPaintVisual(),
  ));

  // 3.3 debugPaintBaselinesEnabled -> show baselines
  perValueCards.add(_valueCardScaffold(
    value: RenderingServiceExtensions.debugPaintBaselinesEnabled,
    accent: Colors.deepOrange,
    summary: 'Draws alphabetic and ideographic baselines under each text run.',
    flagName: 'debugPaintBaselinesEnabled',
    visual: _baselinesVisual(),
  ));

  // 3.4 repaintRainbow -> rotating colors over repaint regions
  perValueCards.add(_valueCardScaffold(
    value: RenderingServiceExtensions.repaintRainbow,
    accent: Colors.purple,
    summary: 'Overlays rotating rainbow on layers as they repaint - hot spots glow.',
    flagName: 'debugRepaintRainbowEnabled',
    visual: _rainbowVisual(),
  ));

  // 3.5 debugDumpLayerTree -> ascii layer dump
  perValueCards.add(_valueCardScaffold(
    value: RenderingServiceExtensions.debugDumpLayerTree,
    accent: Colors.blueGrey,
    summary: 'Prints the layer tree to the console for offline inspection.',
    flagName: '(no flag - one-shot dump)',
    visual: _layerTreeDumpVisual(),
  ));

  // 3.6 debugDisableClipLayers -> shows what gets cut off when clip is off
  perValueCards.add(_valueCardScaffold(
    value: RenderingServiceExtensions.debugDisableClipLayers,
    accent: Colors.red,
    summary: 'Bypasses ClipRect / ClipRRect / ClipPath - reveals overflow.',
    flagName: 'debugDisableClipLayers',
    visual: _clipDisabledVisual(),
  ));

  // 3.7 debugDisablePhysicalShapeLayers -> flatten material shadows
  perValueCards.add(_valueCardScaffold(
    value: RenderingServiceExtensions.debugDisablePhysicalShapeLayers,
    accent: Colors.brown,
    summary: 'Removes elevation / physical shadows - ideal for raster cost diffs.',
    flagName: 'debugDisablePhysicalShapeLayers',
    visual: _physicalShapeVisual(),
  ));

  // 3.8 debugDisableOpacityLayers -> opaque vs transparent compare
  perValueCards.add(_valueCardScaffold(
    value: RenderingServiceExtensions.debugDisableOpacityLayers,
    accent: Colors.amber,
    summary: 'Forces opaque rendering of Opacity widgets to measure overhead.',
    flagName: 'debugDisableOpacityLayers',
    visual: _opacityDisabledVisual(),
  ));

  // 3.9 debugDumpRenderTree -> ascii render tree
  perValueCards.add(_valueCardScaffold(
    value: RenderingServiceExtensions.debugDumpRenderTree,
    accent: Colors.green,
    summary: 'Prints the RenderObject tree with constraints and sizes.',
    flagName: '(no flag - one-shot dump)',
    visual: _renderTreeDumpVisual(),
  ));

  // 3.10 debugDumpSemanticsTreeInTraversalOrder
  perValueCards.add(_valueCardScaffold(
    value: RenderingServiceExtensions.debugDumpSemanticsTreeInTraversalOrder,
    accent: Colors.cyan,
    summary: 'Dumps the semantics tree in screen-reader traversal order.',
    flagName: '(no flag - one-shot dump)',
    visual: _semanticsTraversalVisual(),
  ));

  // 3.11 debugDumpSemanticsTreeInInverseHitTestOrder
  perValueCards.add(_valueCardScaffold(
    value: RenderingServiceExtensions.debugDumpSemanticsTreeInInverseHitTestOrder,
    accent: Colors.lightBlue,
    summary: 'Dumps semantics in inverse hit-test order - debugging gestures first.',
    flagName: '(no flag - one-shot dump)',
    visual: _semanticsHitTestVisual(),
  ));

  // 3.12 profileRenderObjectPaints -> timeline bars
  perValueCards.add(_valueCardScaffold(
    value: RenderingServiceExtensions.profileRenderObjectPaints,
    accent: Colors.orange,
    summary: 'Adds Timeline events for every painted RenderObject (perf overlay).',
    flagName: 'debugProfilePaintsEnabled',
    visual: _profilePaintsVisual(),
  ));

  // 3.13 profileRenderObjectLayouts -> timeline bars
  perValueCards.add(_valueCardScaffold(
    value: RenderingServiceExtensions.profileRenderObjectLayouts,
    accent: Colors.lime,
    summary: 'Adds Timeline events for every laid-out RenderObject (perf overlay).',
    flagName: 'debugProfileLayoutsEnabled',
    visual: _profileLayoutsVisual(),
  ));

  // ============================================================
  // SECTION 4: DevTools recipes
  // ============================================================
  final recipes = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Colors.greenAccent.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'DevTools / VM service recipes',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent.shade400,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _recipeBlock(
          label: 'Toggle layout overlay',
          extName: RenderingServiceExtensions.debugPaint.name,
          color: Colors.tealAccent.shade400,
        ),
        _recipeBlock(
          label: 'Toggle repaint rainbow',
          extName: RenderingServiceExtensions.repaintRainbow.name,
          color: Colors.purpleAccent.shade100,
        ),
        _recipeBlock(
          label: 'Dump layer tree',
          extName: RenderingServiceExtensions.debugDumpLayerTree.name,
          color: Colors.cyanAccent.shade400,
        ),
        _recipeBlock(
          label: 'Dump render tree',
          extName: RenderingServiceExtensions.debugDumpRenderTree.name,
          color: Colors.lightGreenAccent.shade400,
        ),
        _recipeBlock(
          label: 'Toggle paint timeline events',
          extName: RenderingServiceExtensions.profileRenderObjectPaints.name,
          color: Colors.orangeAccent.shade200,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Pitfalls and gotchas
  // ============================================================
  final pitfalls = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50, Colors.yellow.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.red.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls and gotchas',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pitfallRow(
          'Only available in debug builds.',
          'In release / profile mode the extensions are simply not registered.',
          Colors.red,
        ),
        _pitfallRow(
          'Toggles are global.',
          'They affect the entire app - turn them back off when you are done.',
          Colors.deepOrange,
        ),
        _pitfallRow(
          'Repaint rainbow can mislead.',
          'A widget that always repaints because something above it does is not the leak.',
          Colors.orange,
        ),
        _pitfallRow(
          'Dump extensions are one-shot.',
          'They print to console once per call - they do not toggle a flag.',
          Colors.amber,
        ),
        _pitfallRow(
          'Profile flags add overhead.',
          'Leaving profileRenderObjectPaints / profileRenderObjectLayouts on warps timings.',
          Colors.brown,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Comparison table
  // ============================================================
  final comparison = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comparison: kind, scope, lifetime',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade100, Colors.blue.shade100],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
          child: Row(
            children: [
              _compHeader('Extension', 200.0),
              _compHeader('Kind', 80.0),
              _compHeader('Scope', 100.0),
              _compHeader('Lifetime', 100.0),
            ],
          ),
        ),
        for (final row in _comparisonRows())
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
              ),
            ),
            child: Row(
              children: [
                _compCell(row[0], 200.0, Colors.black87, mono: true),
                _compKindBadge(row[1], 80.0),
                _compCell(row[2], 100.0, Colors.indigo.shade700),
                _compCell(row[3], 100.0, Colors.teal.shade700),
              ],
            ),
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Quick reference grid
  // ============================================================
  final quickRefTiles = <Widget>[];
  for (final v in RenderingServiceExtensions.values) {
    quickRefTiles.add(_quickRefTile(v));
  }
  final quickRef = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.purple.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_view, color: Colors.deepPurple.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Quick reference (all ${RenderingServiceExtensions.values.length} values)',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: quickRefTiles,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: ASCII footer
  // ============================================================
  final asciiFooter = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black, Colors.grey.shade900],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.greenAccent.withValues(alpha: 0.2),
          blurRadius: 14.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: DefaultTextStyle(
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: Colors.greenAccent.shade400,
        height: 1.3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('+----------------------------------------------------------------+'),
          Text('|              RenderingServiceExtensions cheat-sheet            |'),
          Text('+----------------------------------------------------------------+'),
          Text('| toggles ............ debugPaint, debugPaintBaselinesEnabled,   |'),
          Text('|                      repaintRainbow, invertOversizedImages,    |'),
          Text('|                      debugDisableClipLayers,                   |'),
          Text('|                      debugDisablePhysicalShapeLayers,          |'),
          Text('|                      debugDisableOpacityLayers                 |'),
          Text('| dumps .............. debugDumpLayerTree, debugDumpRenderTree,  |'),
          Text('|                      debugDumpSemanticsTree*                   |'),
          Text('| profilers .......... profileRenderObjectPaints,                |'),
          Text('|                      profileRenderObjectLayouts                |'),
          Text('+----------------------------------------------------------------+'),
          SizedBox(height: 6.0),
          Text('// generated for d4rt deep-visual demo - static animations only'),
        ],
      ),
    ),
  );

  // ============================================================
  // Compose body
  // ============================================================
  final body = SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        hero,
        anatomy,
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 6.0),
          child: Text(
            '3. Per-value visualisations',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        ...perValueCards,
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 6.0),
          child: Text(
            '4. DevTools recipes',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        recipes,
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 6.0),
          child: Text(
            '5. Pitfalls',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        pitfalls,
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 6.0),
          child: Text(
            '6. Comparison table',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        comparison,
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 6.0),
          child: Text(
            '7. Quick reference',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        quickRef,
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 6.0),
          child: Text(
            '8. ASCII cheat-sheet',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        asciiFooter,
        SizedBox(height: 24.0),
      ],
    ),
  );

  return MaterialApp(home: Scaffold(body: body));
}

// ================================================================
// Helper: anatomy node
// ================================================================
Widget _anatomyNode(String label, IconData icon, Color color) {
  return Container(
    width: 78.0,
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withValues(alpha: 0.18), color.withValues(alpha: 0.08)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(height: 4.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.bold,
            color: color,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyArrow(Color color) {
  return Icon(Icons.arrow_forward, size: 16.0, color: color);
}

// ================================================================
// Helper: per-value card scaffold
// ================================================================
Widget _valueCardScaffold({
  required RenderingServiceExtensions value,
  required Color accent,
  required String summary,
  required String flagName,
  required Widget visual,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, accent.withValues(alpha: 0.06)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header strip
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accent.withValues(alpha: 0.25), accent.withValues(alpha: 0.08)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 30.0,
                height: 30.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.4),
                      blurRadius: 6.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: Text(
                  '${value.index}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  value.name,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                    color: accent.withValues(alpha: 0.95),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  flagName,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontFamily: 'monospace',
                    color: accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Body
        Padding(
          padding: EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                summary,
                style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.4),
              ),
              SizedBox(height: 12.0),
              visual,
            ],
          ),
        ),
      ],
    ),
  );
}

// ================================================================
// Per-value visuals
// ================================================================

// 3.1 invertOversizedImages: side-by-side normal vs inverted+flipped tile
Widget _invertImagesVisual() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _imageTile('OFF', Colors.pink.shade400, false),
      Icon(Icons.compare_arrows, color: Colors.pink, size: 28.0),
      _imageTile('ON', Colors.pink.shade700, true),
    ],
  );
}

Widget _imageTile(String label, Color label_, bool inverted) {
  // Simulate "image content" with a gradient + glyph; invert flips and color-inverts.
  final gradient = LinearGradient(
    colors: inverted
        ? [Color(0xFF00FFFF), Color(0xFFFF00FF)]
        : [Color(0xFFFF0000), Color(0xFF00FF00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final tile = Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Icon(Icons.image, size: 42.0, color: Colors.white.withValues(alpha: 0.85)),
  );
  return Column(
    children: [
      // Horizontal flip when "ON"
      Transform(
        alignment: Alignment.center,
        transform: inverted ? (Matrix4.identity()..scale(-1.0, 1.0, 1.0)) : Matrix4.identity(),
        child: tile,
      ),
      SizedBox(height: 6.0),
      Text(label, style: TextStyle(color: label_, fontWeight: FontWeight.bold, fontSize: 12.0)),
    ],
  );
}

// 3.2 debugPaint: layout overlay
Widget _debugPaintVisual() {
  return Container(
    height: 110.0,
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(painter: _DebugPaintPainter()),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withValues(alpha: 0.3),
                  blurRadius: 6.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            child: Text(
              'RenderBox bounds + padding',
              style: TextStyle(fontSize: 11.0, color: Colors.teal.shade800, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}

class _DebugPaintPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final outline = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRect(Offset(4, 4) & Size(size.width - 8, size.height - 8), outline);
    final pad = Paint()
      ..color = Colors.tealAccent.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(Offset(16, 16) & Size(size.width - 32, size.height - 32), pad);
    final cross = Paint()
      ..color = Colors.teal.shade300
      ..strokeWidth = 0.8;
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), cross);
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), cross);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 3.3 baselines visualization
Widget _baselinesVisual() {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #74, P11):
  // The original `height: 110.0` left only 110 − 2*8 (Container padding)
  // − 2*18 (inner Padding) = 58 px for the inner Column. The two Text
  // children (fontSize 22 + SizedBox 12 + fontSize 18, with leading)
  // measure ~69 px → 11 px bottom overflow. Drop the explicit height so
  // Container self-sizes to its Stack content; CustomPaint via
  // Positioned.fill still paints over the actual area, and the baseline
  // guides at y=38/78 remain inside the resulting ~120-px Stack.
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.deepOrange.shade50,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(painter: _BaselinePainter()),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quick',
                  style: TextStyle(fontSize: 22.0, color: Colors.deepOrange.shade900)),
              SizedBox(height: 12.0),
              Text('brown fox',
                  style: TextStyle(fontSize: 18.0, color: Colors.deepOrange.shade700)),
            ],
          ),
        ),
      ],
    ),
  );
}

class _BaselinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.deepOrange.withValues(alpha: 0.7)
      ..strokeWidth = 1.0;
    final paths = [38.0, 78.0];
    for (final y in paths) {
      // Dashed line approximation
      double x = 0.0;
      while (x < size.width) {
        canvas.drawLine(Offset(x, y), Offset(x + 4.0, y), p);
        x += 8.0;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 3.4 repaint rainbow visualization
Widget _rainbowVisual() {
  final rainbow = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  return SizedBox(
    height: 110.0,
    child: Row(
      children: [
        for (int i = 0; i < rainbow.length; i++)
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [rainbow[i].withValues(alpha: 0.4), rainbow[i]],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                    color: rainbow[i].withValues(alpha: 0.4),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                'L${i + 1}',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

// 3.5 layer tree dump
Widget _layerTreeDumpVisual() {
  return _consoleDump(
    lines: [
      'TransformLayer#1a2b',
      ' +- ContainerLayer#3c4d',
      '    +- OffsetLayer#5e6f',
      '       +- PictureLayer#7a8b',
      '       +- ClipRectLayer#9c0d',
      '          +- PictureLayer#1e2f',
    ],
    fg: Colors.blueGrey.shade100,
    bg: Colors.blueGrey.shade900,
  );
}

// 3.6 clip disabled visualization
Widget _clipDisabledVisual() {
  return SizedBox(
    height: 110.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _clipPanel(clipped: true),
        Icon(Icons.compare_arrows, color: Colors.red, size: 24.0),
        _clipPanel(clipped: false),
      ],
    ),
  );
}

Widget _clipPanel({required bool clipped}) {
  final inner = Container(
    width: 120.0,
    height: 60.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade300, Colors.red.shade700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.4),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text('overflow', style: TextStyle(color: Colors.white, fontSize: 11.0)),
  );

  return Column(
    children: [
      Container(
        width: 100.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.red.shade400, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        clipBehavior: clipped ? Clip.hardEdge : Clip.none,
        child: OverflowBox(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          child: inner,
        ),
      ),
      SizedBox(height: 6.0),
      Text(
        clipped ? 'Clip ON (default)' : 'Clip layers DISABLED',
        style: TextStyle(
          fontSize: 11.0,
          color: clipped ? Colors.red.shade400 : Colors.red.shade900,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

// 3.7 physical shape visualization
Widget _physicalShapeVisual() {
  return SizedBox(
    height: 110.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _physicalCard(elevated: true),
        Icon(Icons.compare_arrows, color: Colors.brown, size: 24.0),
        _physicalCard(elevated: false),
      ],
    ),
  );
}

Widget _physicalCard({required bool elevated}) {
  return Column(
    children: [
      Container(
        width: 100.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.brown.shade100,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: elevated
              ? [
                  BoxShadow(
                    color: Colors.brown.withValues(alpha: 0.5),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 6.0),
                  ),
                ]
              : <BoxShadow>[],
        ),
        alignment: Alignment.center,
        child: Text(
          elevated ? 'elev: 6' : 'elev: -',
          style: TextStyle(color: Colors.brown.shade900, fontSize: 12.0, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 6.0),
      Text(
        elevated ? 'PhysicalShape ON' : 'PhysicalShape OFF',
        style: TextStyle(
          fontSize: 11.0,
          color: Colors.brown.shade800,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

// 3.8 opacity disabled visualization
Widget _opacityDisabledVisual() {
  return SizedBox(
    height: 110.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _opacityCard(opacity: 0.3, label: 'Opacity 0.3'),
        _opacityCard(opacity: 0.6, label: 'Opacity 0.6'),
        _opacityCard(opacity: 1.0, label: 'Forced 1.0'),
      ],
    ),
  );
}

Widget _opacityCard({required double opacity, required String label}) {
  return Column(
    children: [
      Opacity(
        opacity: opacity,
        child: Container(
          width: 80.0,
          height: 60.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber.shade400, Colors.amber.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(Icons.brightness_5, color: Colors.white, size: 24.0),
        ),
      ),
      SizedBox(height: 6.0),
      Text(label, style: TextStyle(fontSize: 10.5, color: Colors.amber.shade900, fontWeight: FontWeight.bold)),
    ],
  );
}

// 3.9 render tree dump
Widget _renderTreeDumpVisual() {
  return _consoleDump(
    lines: [
      'RenderView#0001',
      ' size: Size(412.0, 915.0)',
      ' +- RenderRepaintBoundary#0002',
      '    +- RenderCustomPaint#0003',
      '       +- RenderConstrainedBox#0004',
      '          BoxConstraints(w=400.0, h=200.0)',
      '          +- RenderFlex#0005 (direction: vertical)',
    ],
    fg: Colors.greenAccent.shade400,
    bg: Colors.green.shade900,
  );
}

// 3.10 semantics traversal order
Widget _semanticsTraversalVisual() {
  final order = ['title', 'subtitle', 'image', 'button:like', 'button:share'];
  final cyan = Colors.cyan.shade700;
  return Column(
    children: [
      for (int i = 0; i < order.length; i++)
        Container(
          margin: EdgeInsets.symmetric(vertical: 2.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [cyan.withValues(alpha: 0.18), cyan.withValues(alpha: 0.05)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: cyan.withValues(alpha: 0.4), width: 1.0),
          ),
          child: Row(
            children: [
              Container(
                width: 22.0,
                height: 22.0,
                decoration: BoxDecoration(color: cyan, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text('${i + 1}',
                    style: TextStyle(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.bold)),
              ),
              SizedBox(width: 10.0),
              Text(
                order[i],
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: cyan,
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_downward, size: 14.0, color: cyan.withValues(alpha: 0.4)),
            ],
          ),
        ),
    ],
  );
}

// 3.11 semantics inverse hit-test order
Widget _semanticsHitTestVisual() {
  final order = ['top-most overlay', 'modal sheet', 'fab', 'list-tile', 'background'];
  final blue = Colors.lightBlue.shade700;
  return Column(
    children: [
      for (int i = 0; i < order.length; i++)
        Container(
          margin: EdgeInsets.symmetric(vertical: 2.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [blue.withValues(alpha: 0.15), blue.withValues(alpha: 0.04)],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: blue.withValues(alpha: 0.4), width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.touch_app, size: 14.0, color: blue),
              SizedBox(width: 10.0),
              Text(
                order[i],
                style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', color: blue),
              ),
              Spacer(),
              Container(
                width: 22.0,
                height: 22.0,
                decoration: BoxDecoration(color: blue, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text('${order.length - i}',
                    style: TextStyle(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
    ],
  );
}

// 3.12 profile paints visualization (timeline bars)
Widget _profilePaintsVisual() {
  return _timelineBars(
    rows: [
      ('paint RenderFlex', 0.10, 0.65, Colors.orange),
      ('paint RenderImage', 0.15, 0.40, Colors.deepOrange),
      ('paint RenderText', 0.20, 0.55, Colors.amber),
      ('paint RenderPhysicalModel', 0.25, 0.80, Colors.orange.shade700),
    ],
    accent: Colors.orange,
  );
}

// 3.13 profile layouts visualization (timeline bars)
Widget _profileLayoutsVisual() {
  return _timelineBars(
    rows: [
      ('layout RenderFlex', 0.05, 0.45, Colors.lime),
      ('layout RenderConstrainedBox', 0.10, 0.30, Colors.lightGreen),
      ('layout RenderParagraph', 0.15, 0.50, Colors.green),
      ('layout RenderViewport', 0.20, 0.70, Colors.teal),
    ],
    accent: Colors.lime,
  );
}

// ================================================================
// Helper: console dump block
// ================================================================
Widget _consoleDump({required List<String> lines, required Color fg, required Color bg}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [bg, Color.alphaBlend(Colors.black.withValues(alpha: 0.25), bg)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: bg.withValues(alpha: 0.5),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: DefaultTextStyle(
      style: TextStyle(fontFamily: 'monospace', fontSize: 11.5, color: fg, height: 1.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [for (final l in lines) Text(l)],
      ),
    ),
  );
}

// ================================================================
// Helper: timeline bar group
// ================================================================
Widget _timelineBars({required List<(String, double, double, Color)> rows, required Color accent}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final r in rows)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              children: [
                SizedBox(
                  width: 150.0,
                  child: Text(r.$1, style: TextStyle(fontSize: 10.5, fontFamily: 'monospace', color: Colors.black87)),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    height: 14.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: r.$2 + r.$3,
                            child: SizedBox.expand(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: r.$2,
                            child: SizedBox.expand(),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: AnimatedContainer(
                            duration: Duration.zero,
                            width: 0.0,
                          ),
                        ),
                        // Actual visible bar (offset + width segment)
                        FractionallySizedBox(
                          widthFactor: 1.0,
                          child: CustomPaint(
                            painter: _BarPainter(start: r.$2, length: r.$3, color: r.$4),
                          ),
                        ),
                      ],
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

class _BarPainter extends CustomPainter {
  _BarPainter({required this.start, required this.length, required this.color});
  final double start;
  final double length;
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final x = size.width * start;
    final w = size.width * length;
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(x, 1.0, w, size.height - 2.0),
      Radius.circular(3.0),
    );
    final p = Paint()
      ..shader = LinearGradient(
        colors: [color.withValues(alpha: 0.6), color],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(rrect.outerRect);
    canvas.drawRRect(rrect, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ================================================================
// Helper: recipe block (DevTools recipes)
// ================================================================
Widget _recipeBlock({required String label, required String extName, required Color color}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.chevron_right, color: color, size: 16.0),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'await serviceClient.callServiceExtension(\n'
          "  'ext.flutter.$extName',\n"
          "  args: <String, String>{ 'enabled': 'true' },\n"
          ');',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.white.withValues(alpha: 0.85),
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

// ================================================================
// Helper: pitfall row
// ================================================================
Widget _pitfallRow(String title, String body, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 2.0),
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(Icons.priority_high, color: Colors.white, size: 12.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: color),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade800, height: 1.35),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ================================================================
// Helper: comparison rows / cells
// ================================================================
List<List<String>> _comparisonRows() {
  return [
    ['invertOversizedImages', 'toggle', 'images', 'persistent'],
    ['debugPaint', 'toggle', 'every box', 'persistent'],
    ['debugPaintBaselinesEnabled', 'toggle', 'text', 'persistent'],
    ['repaintRainbow', 'toggle', 'layers', 'persistent'],
    ['debugDumpLayerTree', 'dump', 'layers', 'one-shot'],
    ['debugDisableClipLayers', 'toggle', 'layers', 'persistent'],
    ['debugDisablePhysicalShapeLayers', 'toggle', 'layers', 'persistent'],
    ['debugDisableOpacityLayers', 'toggle', 'layers', 'persistent'],
    ['debugDumpRenderTree', 'dump', 'render obj', 'one-shot'],
    ['debugDumpSemanticsTreeInTraversalOrder', 'dump', 'semantics', 'one-shot'],
    ['debugDumpSemanticsTreeInInverseHitTestOrder', 'dump', 'semantics', 'one-shot'],
    ['profileRenderObjectPaints', 'profile', 'paints', 'persistent'],
    ['profileRenderObjectLayouts', 'profile', 'layouts', 'persistent'],
  ];
}

Widget _compHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

Widget _compCell(String text, double width, Color color, {bool mono = false}) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        color: color,
        fontFamily: mono ? 'monospace' : null,
      ),
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget _compKindBadge(String kind, double width) {
  Color color;
  IconData icon;
  switch (kind) {
    case 'toggle':
      color = Colors.teal;
      icon = Icons.toggle_on;
      break;
    case 'dump':
      color = Colors.blueGrey;
      icon = Icons.subject;
      break;
    case 'profile':
      color = Colors.orange;
      icon = Icons.timeline;
      break;
    default:
      color = Colors.grey;
      icon = Icons.help_outline;
  }
  return SizedBox(
    width: width,
    child: Container(
      margin: EdgeInsets.only(right: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color, width: 1.0),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.0, color: color),
          SizedBox(width: 4.0),
          Text(kind, style: TextStyle(fontSize: 10.5, color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

// ================================================================
// Helper: quick-reference tile
// ================================================================
Widget _quickRefTile(RenderingServiceExtensions value) {
  final palette = [
    Colors.pink,
    Colors.teal,
    Colors.deepOrange,
    Colors.purple,
    Colors.blueGrey,
    Colors.red,
    Colors.brown,
    Colors.amber,
    Colors.green,
    Colors.cyan,
    Colors.lightBlue,
    Colors.orange,
    Colors.lime,
  ];
  final color = palette[value.index % palette.length];
  return Container(
    width: 200.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withValues(alpha: 0.18), color.withValues(alpha: 0.04)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 24.0,
          height: 24.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Text('${value.index}',
              style: TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.bold)),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value.name,
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              color: color,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

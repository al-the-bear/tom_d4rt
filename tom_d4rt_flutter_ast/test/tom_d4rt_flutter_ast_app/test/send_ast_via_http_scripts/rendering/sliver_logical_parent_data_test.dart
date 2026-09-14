// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliverLogicalParentData from rendering
// Deep Demo: Visual tour of SliverLogicalParentData and its single
// `layoutOffset` field, with comparisons to SliverPhysicalParentData,
// scroll axis variants, lifecycle, and footguns.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('SliverLogicalParentData Deep Demo executing');

  // Cool indigo / mint / amber palette anchors
  final indigoDeep = Colors.indigo.shade700;
  final indigoMid = Colors.indigo.shade400;
  final mintDeep = Colors.teal.shade700;
  final mintMid = Colors.teal.shade300;
  final amberDeep = Colors.amber.shade700;
  final amberMid = Colors.amber.shade400;

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade800,
          Colors.indigo.shade400,
          Colors.teal.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.shade900.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.teal.shade300.withValues(alpha: 0.25),
          blurRadius: 28.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
              width: 2.0,
            ),
          ),
          child: Icon(Icons.swap_vert, size: 56.0, color: Colors.white),
        ),
        SizedBox(height: 12.0),
        Text(
          'SliverLogicalParentData',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Logical layout offsets for sliver children',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white.withValues(alpha: 0.85),
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade300.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            'package:flutter/rendering.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.indigo.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy — single `layoutOffset` field
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomySliverDiagram = Container(
    height: 280.0,
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.teal.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: indigoMid, width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Axis legend on the left
        Container(
          width: 80.0,
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0.0',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: indigoDeep,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.arrow_downward, size: 22.0, color: indigoDeep),
              Text(
                'main\naxis',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.0,
                  color: indigoMid,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Icon(Icons.arrow_downward, size: 22.0, color: indigoDeep),
              Text(
                '∞',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'monospace',
                  color: indigoDeep,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.0),
        // Sliver column
        Expanded(
          child: Stack(
            children: [
              // Background sliver track
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: mintMid, width: 1.0),
                ),
              ),
              // The single field — layoutOffset highlight band
              Positioned(
                top: 60.0,
                left: 16.0,
                right: 16.0,
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.amber.shade200,
                        Colors.amber.shade400,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: amberDeep.withValues(alpha: 0.4),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 4.0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.flag, color: indigoDeep, size: 20.0),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'layoutOffset',
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: indigoDeep,
                              ),
                            ),
                            Text(
                              'double? — main-axis offset',
                              style: TextStyle(
                                fontSize: 11.0,
                                color: indigoDeep.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Top label
              Positioned(
                top: 12.0,
                left: 16.0,
                child: Text(
                  'sliver child top edge',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontStyle: FontStyle.italic,
                    color: indigoDeep,
                  ),
                ),
              ),
              // Bottom label
              Positioned(
                bottom: 12.0,
                left: 16.0,
                child: Text(
                  'further children continue along the main axis',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontStyle: FontStyle.italic,
                    color: mintDeep,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Logical vs Physical comparison cards
  // ============================================================
  print('=== Section 3: Logical vs Physical ===');

  final logicalCard = _buildKindCard(
    title: 'SliverLogicalParentData',
    field: 'double? layoutOffset',
    summary: 'Scroll-direction-natural offset along the main axis. The render '
        'sliver decides how to convert it to a paint Offset.',
    accent: indigoDeep,
    accentSoft: Colors.indigo.shade50,
    icon: Icons.straighten,
    bullets: [
      'Single scalar (main-axis only)',
      'Independent of axis direction',
      'Computed by parent layout pass',
      'Painted via parent transform',
    ],
    arrowLabel: 'main-axis →',
  );

  final physicalCard = _buildKindCard(
    title: 'SliverPhysicalParentData',
    field: 'Offset paintOffset',
    summary: 'Concrete pixel offset from parent origin. Encodes axis direction '
        'directly into the (dx, dy) pair.',
    accent: mintDeep,
    accentSoft: Colors.teal.shade50,
    icon: Icons.crop_free,
    bullets: [
      'Vector (dx, dy) in pixels',
      'Already axis-resolved',
      'Used during paint',
      'No re-projection needed',
    ],
    arrowLabel: '(dx, dy)',
  );

  final logicalVsPhysical = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.indigo.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: amberMid, width: 1.5),
    ),
    child: Column(
      children: [
        Text(
          'Logical vs Physical Parent Data',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: indigoDeep,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: logicalCard),
            SizedBox(width: 12.0),
            Expanded(child: physicalCard),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: amberDeep, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: amberDeep, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Pick logical when the parent renders along a single axis '
                  'and reuses the same child layout regardless of direction.',
                  style: TextStyle(fontSize: 12.0, color: indigoDeep),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Six instance cards with different layoutOffset values
  // ============================================================
  print('=== Section 4: Instance cards ===');

  final sampleOffsets = <double?>[0.0, 100.0, 200.0, 500.0, 1000.0, null];
  final instanceCards = <Widget>[];
  for (final v in sampleOffsets) {
    final pd = SliverLogicalParentData();
    pd.layoutOffset = v;
    print('Instance: layoutOffset=${pd.layoutOffset}');
    instanceCards.add(_buildOffsetInstanceCard(
      pd,
      indigoDeep: indigoDeep,
      mintDeep: mintDeep,
      amberDeep: amberDeep,
    ));
  }
  print('Created ${instanceCards.length} instance cards');

  // ============================================================
  // SECTION 5: Scroll axis impact visualization
  // ============================================================
  print('=== Section 5: Scroll axis impact ===');

  final axisCards = <Widget>[
    _buildAxisCard(
      label: 'AxisDirection.down',
      icon: Icons.arrow_downward,
      accent: indigoDeep,
      offsetVisual: Alignment.topCenter,
      offsetText: 'layoutOffset → y from top',
      direction: AxisDirection.down,
    ),
    _buildAxisCard(
      label: 'AxisDirection.up',
      icon: Icons.arrow_upward,
      accent: mintDeep,
      offsetVisual: Alignment.bottomCenter,
      offsetText: 'layoutOffset → y from bottom',
      direction: AxisDirection.up,
    ),
    _buildAxisCard(
      label: 'AxisDirection.right',
      icon: Icons.arrow_forward,
      accent: amberDeep,
      offsetVisual: Alignment.centerLeft,
      offsetText: 'layoutOffset → x from left',
      direction: AxisDirection.right,
    ),
    _buildAxisCard(
      label: 'AxisDirection.left',
      icon: Icons.arrow_back,
      accent: Colors.deepPurple.shade600,
      offsetVisual: Alignment.centerRight,
      offsetText: 'layoutOffset → x from right',
      direction: AxisDirection.left,
    ),
  ];

  final axisGrid = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: mintMid, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: mintDeep.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'One field, four axis projections',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: indigoDeep,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.center,
          children: axisCards,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Real-world flow — CustomScrollView with three SliverLists
  // ============================================================
  print('=== Section 6: Real-world flow ===');

  final flowChildren = <Map<String, Object>>[
    {
      'name': 'Sliver A (header)',
      'pd': SliverLogicalParentData()..layoutOffset = 0.0,
      'extent': 80.0,
      'color': indigoDeep,
    },
    {
      'name': 'Sliver B (list)',
      'pd': SliverLogicalParentData()..layoutOffset = 80.0,
      'extent': 240.0,
      'color': mintDeep,
    },
    {
      'name': 'Sliver C (footer)',
      'pd': SliverLogicalParentData()..layoutOffset = 320.0,
      'extent': 60.0,
      'color': amberDeep,
    },
  ];

  for (final c in flowChildren) {
    final pd = c['pd'] as SliverLogicalParentData;
    print('${c['name']} -> layoutOffset=${pd.layoutOffset}');
  }

  final flowDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: indigoMid, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: indigoDeep.withValues(alpha: 0.15),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.list_alt, color: indigoDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'CustomScrollView with three slivers',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: indigoDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (final c in flowChildren)
          _buildFlowRow(
            name: c['name'] as String,
            pd: c['pd'] as SliverLogicalParentData,
            extent: c['extent'] as double,
            accent: c['color'] as Color,
          ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: amberMid, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.calculate, color: amberDeep, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Each child stores its own layoutOffset; the parent sums '
                  'preceding extents to compute the next.',
                  style: TextStyle(fontSize: 12.0, color: indigoDeep),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Container vs single-child variant
  // ============================================================
  print('=== Section 7: Container vs single-child ===');

  final variantCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.amber.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: indigoMid, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: indigoDeep.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'SliverLogicalParentData vs SliverLogicalContainerParentData',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: indigoDeep,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildVariantPanel(
                title: 'SliverLogicalParentData',
                subtitle: 'Single-child / leaf use',
                fields: const ['layoutOffset'],
                accent: indigoDeep,
                accentSoft: Colors.indigo.shade100,
                icon: Icons.crop_square,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _buildVariantPanel(
                title: 'SliverLogicalContainerParentData',
                subtitle: 'Multi-child container use',
                fields: const [
                  'layoutOffset (inherited)',
                  'nextSibling',
                  'previousSibling',
                ],
                accent: mintDeep,
                accentSoft: Colors.teal.shade100,
                icon: Icons.dns,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: amberDeep, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.compare_arrows, color: amberDeep, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'The container variant adds a linked list for sibling '
                  'walking; the layoutOffset semantics stay identical.',
                  style: TextStyle(fontSize: 12.0, color: indigoDeep),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Code block — RenderSliver usage snippet
  // ============================================================
  print('=== Section 8: Code block ===');

  final codeBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.tealAccent.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'RenderSliver wiring',
              style: TextStyle(
                color: Colors.tealAccent.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildCodeSnippet(
          '@override\n'
          'void setupParentData(RenderObject child) {\n'
          '  if (child.parentData is! SliverLogicalParentData) {\n'
          '    child.parentData = SliverLogicalParentData();\n'
          '  }\n'
          '}',
          Colors.lightBlueAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _buildCodeSnippet(
          '@override\n'
          'void performLayout() {\n'
          '  double offset = 0.0;\n'
          '  RenderSliver? c = firstChild;\n'
          '  while (c != null) {\n'
          '    final pd = c.parentData! as SliverLogicalParentData;\n'
          '    pd.layoutOffset = offset;\n'
          '    c.layout(constraints, parentUsesSize: true);\n'
          '    offset += c.geometry!.layoutExtent;\n'
          '    c = childAfter(c);\n'
          '  }\n'
          '}',
          Colors.amberAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _buildCodeSnippet(
          '// Logical -> physical paint offset is computed at paint time.\n'
          'final paintOffset = computeAbsolutePaintOffset(\n'
          '  child,\n'
          '  pd.layoutOffset!,\n'
          '  growthDirection,\n'
          ');',
          Colors.greenAccent.shade100,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Lifecycle — 4 numbered steps
  // ============================================================
  print('=== Section 9: Lifecycle ===');

  final lifecycleSteps = <Widget>[
    _buildLifecycleStep(
      step: 1,
      title: 'parentData attached',
      detail: 'setupParentData() assigns a SliverLogicalParentData '
          'instance with layoutOffset = null.',
      accent: indigoDeep,
      icon: Icons.link,
    ),
    _buildLifecycleStep(
      step: 2,
      title: 'layout pass',
      detail: 'performLayout() walks children, sets each '
          'pd.layoutOffset to the running main-axis cursor.',
      accent: mintDeep,
      icon: Icons.architecture,
    ),
    _buildLifecycleStep(
      step: 3,
      title: 'paintOffset computed',
      detail: 'At paint time, parent projects layoutOffset onto the '
          'concrete axis to yield an Offset.',
      accent: amberDeep,
      icon: Icons.visibility,
    ),
    _buildLifecycleStep(
      step: 4,
      title: 'painted',
      detail: 'Child is composited at the projected offset. Re-layouts '
          'reuse the same parentData slot.',
      accent: Colors.deepPurple.shade600,
      icon: Icons.brush,
    ),
  ];

  final lifecycle = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.teal.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: indigoMid, width: 1.5),
    ),
    child: Column(
      children: [
        Text(
          'Lifecycle of a single layoutOffset',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: indigoDeep,
          ),
        ),
        SizedBox(height: 12.0),
        for (final s in lifecycleSteps) s,
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Footgun cards
  // ============================================================
  print('=== Section 10: Footguns ===');

  final footguns = <Widget>[
    _buildFootgunCard(
      title: 'Logical ≠ physical',
      detail: 'layoutOffset is NOT a pixel coordinate. Do not feed it '
          'directly into a Canvas drawRect — project it first.',
      accent: Colors.red.shade700,
      accentSoft: Colors.red.shade50,
      icon: Icons.warning_amber,
    ),
    _buildFootgunCard(
      title: 'null means not laid out',
      detail: 'A null layoutOffset signals the child has not been '
          'laid out in the current frame. Treat it as "skip paint".',
      accent: Colors.deepOrange.shade700,
      accentSoft: Colors.deepOrange.shade50,
      icon: Icons.help_outline,
    ),
    _buildFootgunCard(
      title: 'Scroll-direction-natural coords',
      detail: 'For AxisDirection.up, larger layoutOffset moves the '
          'child further from the leading edge — which is the bottom.',
      accent: amberDeep,
      accentSoft: Colors.amber.shade50,
      icon: Icons.flip,
    ),
    _buildFootgunCard(
      title: 'Single field — no Offset()',
      detail: 'Logical parent data only stores main-axis position. '
          'Cross-axis is implicitly 0 in the parent\'s frame.',
      accent: indigoDeep,
      accentSoft: Colors.indigo.shade50,
      icon: Icons.straighten,
    ),
    _buildFootgunCard(
      title: 'Don\'t share instances',
      detail: 'Each child needs its own SliverLogicalParentData. '
          'Sharing one across children corrupts layout.',
      accent: mintDeep,
      accentSoft: Colors.teal.shade50,
      icon: Icons.block,
    ),
  ];

  final footgunSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: amberDeep, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: amberDeep.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.report_problem, color: amberDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Footguns',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: amberDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (final f in footguns) f,
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap ===');

  final recap = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade700,
          Colors.teal.shade600,
          Colors.amber.shade600,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.shade900.withValues(alpha: 0.35),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bookmark, color: Colors.white, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildRecapBullet(
          'SliverLogicalParentData stores ONE field: '
          'double? layoutOffset.',
        ),
        _buildRecapBullet(
          'Coordinates are scroll-direction-natural; the parent '
          'projects them at paint time.',
        ),
        _buildRecapBullet(
          'Use it for slivers laid out along a single main axis '
          'where pixels can stay parent-resolved.',
        ),
        _buildRecapBullet(
          'Need siblings? Reach for the container subclass instead.',
        ),
        _buildRecapBullet(
          'null layoutOffset is a real signal — it means "not laid '
          'out this frame".',
        ),
      ],
    ),
  );

  print('SliverLogicalParentData Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          _buildSectionHeader('1. Anatomy', Icons.architecture, indigoDeep),
          anatomySliverDiagram,
          _buildSectionHeader(
            '2. Logical vs Physical',
            Icons.compare_arrows,
            mintDeep,
          ),
          logicalVsPhysical,
          _buildSectionHeader(
            '3. Six layoutOffset instances',
            Icons.format_list_numbered,
            amberDeep,
          ),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            alignment: WrapAlignment.center,
            children: instanceCards,
          ),
          SizedBox(height: 8.0),
          _buildSectionHeader('4. Scroll axis impact', Icons.swap_calls, indigoDeep),
          axisGrid,
          _buildSectionHeader('5. CustomScrollView flow', Icons.list, mintDeep),
          flowDiagram,
          _buildSectionHeader(
            '6. Container vs single-child',
            Icons.account_tree,
            amberDeep,
          ),
          variantCard,
          _buildSectionHeader('7. Code', Icons.code, indigoDeep),
          codeBlock,
          _buildSectionHeader('8. Lifecycle', Icons.timeline, mintDeep),
          lifecycle,
          _buildSectionHeader('9. Footguns', Icons.warning, amberDeep),
          footgunSection,
          _buildSectionHeader('10. Recap', Icons.bookmark, indigoDeep),
          recap,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// Helpers
// ----------------------------------------------------------------------------

Widget _buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(top: 18.0, bottom: 6.0, left: 8.0, right: 8.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildKindCard({
  required String title,
  required String field,
  required String summary,
  required Color accent,
  required Color accentSoft,
  required IconData icon,
  required List<String> bullets,
  required String arrowLabel,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [accentSoft, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            field,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          summary,
          style: TextStyle(fontSize: 11.0, color: Colors.black87),
        ),
        SizedBox(height: 10.0),
        for (final b in bullets)
          Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check, color: accent, size: 14.0),
                SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    b,
                    style: TextStyle(fontSize: 11.0, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            arrowLabel,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildOffsetInstanceCard(
  SliverLogicalParentData pd, {
  required Color indigoDeep,
  required Color mintDeep,
  required Color amberDeep,
}) {
  final value = pd.layoutOffset;
  final isNull = value == null;
  final accent = isNull
      ? Colors.red.shade600
      : (value == 0.0
          ? indigoDeep
          : (value < 200.0 ? mintDeep : amberDeep));
  final label = isNull ? 'null' : value.toStringAsFixed(1);
  final fillFraction = isNull
      ? 0.0
      : (value <= 0.0 ? 0.05 : (value / 1000.0).clamp(0.05, 1.0));

  return Container(
    width: 150.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accent.withValues(alpha: 0.08),
          accent.withValues(alpha: 0.22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(
              isNull ? Icons.help_outline : Icons.flag,
              color: accent,
              size: 18.0,
            ),
            SizedBox(width: 6.0),
            Text(
              'layoutOffset',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          height: 70.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: accent.withValues(alpha: 0.4)),
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: FractionallySizedBox(
              widthFactor: 1.0,
              heightFactor: fillFraction,
              child: Container(
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(6.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          isNull ? 'not laid out' : 'main-axis y',
          style: TextStyle(
            fontSize: 10.0,
            color: accent,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _buildAxisCard({
  required String label,
  required IconData icon,
  required Color accent,
  required Alignment offsetVisual,
  required String offsetText,
  required AxisDirection direction,
}) {
  // Track which side the layoutOffset measures from.
  final isVertical = direction == AxisDirection.down ||
      direction == AxisDirection.up;
  return Container(
    width: 200.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accent.withValues(alpha: 0.08),
          accent.withValues(alpha: 0.22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 20.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: accent.withValues(alpha: 0.5)),
          ),
          child: Stack(
            children: [
              Align(
                alignment: offsetVisual,
                child: Container(
                  width: isVertical ? double.infinity : 16.0,
                  height: isVertical ? 16.0 : double.infinity,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.6),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'child',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          offsetText,
          style: TextStyle(
            fontSize: 11.0,
            color: accent,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _buildFlowRow({
  required String name,
  required SliverLogicalParentData pd,
  required double extent,
  required Color accent,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          width: 6.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: accent,
                ),
              ),
              Text(
                'extent: ${extent.toStringAsFixed(1)} px',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.black54,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            'layoutOffset = ${pd.layoutOffset?.toStringAsFixed(1) ?? 'null'}',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildVariantPanel({
  required String title,
  required String subtitle,
  required List<String> fields,
  required Color accent,
  required Color accentSoft,
  required IconData icon,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: accentSoft,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 20.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: accent,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Fields:',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4.0),
        for (final f in fields)
          Padding(
            padding: EdgeInsets.only(bottom: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.fiber_manual_record, color: accent, size: 8.0),
                SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    f,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                      color: Colors.black87,
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

Widget _buildCodeSnippet(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: textColor, width: 3.0),
      ),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

Widget _buildLifecycleStep({
  required int step,
  required String title,
  required String detail,
  required Color accent,
  required IconData icon,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.12),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accent,
                accent.withValues(alpha: 0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.4),
                blurRadius: 4.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: accent, size: 18.0),
                  SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: accent,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                detail,
                style: TextStyle(fontSize: 12.0, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFootgunCard({
  required String title,
  required String detail,
  required Color accent,
  required Color accentSoft,
  required IconData icon,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: accentSoft,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: accent, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: accent,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                detail,
                style: TextStyle(fontSize: 11.5, color: Colors.black87),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecapBullet(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: Colors.white, size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.white,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

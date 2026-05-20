// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Stack widget (with Positioned, Positioned.fill,
// Positioned.directional, PositionedDirectional, Align, IndexedStack)
// from package:flutter/widgets.dart.
// Deep Demo: A theatrical stage with layered backdrops, scrims, actors and
// spotlights. Each Stack is a stage; each child is a piece of scenery, an
// actor, or a lighting cue that lives on its own plane.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Stack Deep Demo executing — curtain up on the theatrical stage');

  // ============================================================
  // SECTION 1: Stage anatomy — what a Stack actually is
  // ============================================================
  print('=== Section 1: Stage Anatomy ===');

  final anatomyDiagram = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade900, Colors.indigo.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.shade900.withValues(alpha: 0.5),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.theater_comedy, color: Colors.amber.shade300, size: 32.0),
            SizedBox(width: 12.0),
            Text(
              'A Stack is a Stage',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade200,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'Children are painted in order: first child is the rear backdrop, '
          'last child is the front spotlight. Un-positioned children are '
          'centered (or placed by alignment) and define the stage bounds. '
          'Positioned/PositionedDirectional children are pinned by edge.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white.withValues(alpha: 0.85),
            height: 1.5,
          ),
        ),
        SizedBox(height: 20.0),
        // Layered planes diagram — itself a Stack!
        Center(
          child: SizedBox(
            width: 280.0,
            height: 180.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildPlane('Backdrop', 0, Colors.indigo.shade400, 0),
                _buildPlane('Mid-scene', 1, Colors.purple.shade400, 24),
                _buildPlane('Actors', 2, Colors.pink.shade400, 48),
                _buildPlane('Spotlight', 3, Colors.amber.shade400, 72),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  print('Anatomy diagram constructed');

  // ============================================================
  // SECTION 2: z-order — first child rear, last child front
  // ============================================================
  print('=== Section 2: Z-Order Layering ===');

  final zOrderLabels = <String>['1st (rear)', '2nd', '3rd', '4th (front)'];
  final zOrderColors = <Color>[
    Colors.red.shade400,
    Colors.orange.shade400,
    Colors.green.shade400,
    Colors.blue.shade400,
  ];

  final zOrderChildren = <Widget>[];
  for (int i = 0; i < 4; i++) {
    final offset = i * 20.0;
    zOrderChildren.add(
      Positioned(
        left: offset,
        top: offset,
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                zOrderColors[i],
                zOrderColors[i].withValues(alpha: 0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white, width: 2.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8.0,
                offset: Offset(2.0, 4.0),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            zOrderLabels[i],
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  final zOrderStage = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Painters Algorithm — Children Painted In Order',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'children: [red, orange, green, blue] → blue is on top because it '
          'was painted last. Reverse the list to flip the visual stack.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        Center(
          child: SizedBox(
            width: 200.0,
            height: 180.0,
            child: Stack(children: zOrderChildren),
          ),
        ),
      ],
    ),
  );
  print('Z-order stage built with ${zOrderChildren.length} children');

  // ============================================================
  // SECTION 3: Alignment of un-positioned children
  // ============================================================
  print('=== Section 3: Alignment of Un-Positioned Children ===');

  final alignmentEntries = <Map<String, Object>>[
    {'name': 'topLeft', 'value': Alignment.topLeft},
    {'name': 'topCenter', 'value': Alignment.topCenter},
    {'name': 'topRight', 'value': Alignment.topRight},
    {'name': 'centerLeft', 'value': Alignment.centerLeft},
    {'name': 'center', 'value': Alignment.center},
    {'name': 'centerRight', 'value': Alignment.centerRight},
    {'name': 'bottomLeft', 'value': Alignment.bottomLeft},
    {'name': 'bottomCenter', 'value': Alignment.bottomCenter},
    {'name': 'bottomRight', 'value': Alignment.bottomRight},
  ];

  final alignmentTiles = <Widget>[];
  for (int i = 0; i < alignmentEntries.length; i++) {
    final entry = alignmentEntries[i];
    final name = entry['name'] as String;
    final align = entry['value'] as Alignment;
    print('Alignment.$name → ($align)');

    alignmentTiles.add(
      Container(
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.cyan.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.teal.shade300, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.shade100,
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        padding: EdgeInsets.all(6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 90.0,
              height: 90.0,
              child: Stack(
                alignment: align,
                children: [
                  Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.shade400,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepOrange.shade200,
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 9.0,
                color: Colors.teal.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Alignment matrix built with ${alignmentTiles.length} tiles');

  // ============================================================
  // SECTION 4: StackFit — loose, expand, passthrough
  // ============================================================
  print('=== Section 4: StackFit Comparison ===');

  final fitEntries = <Map<String, Object>>[
    {
      'name': 'StackFit.loose',
      'fit': StackFit.loose,
      'desc': 'Children get loose constraints — they can be smaller than parent.',
      'color': Colors.lightBlue,
    },
    {
      'name': 'StackFit.expand',
      'fit': StackFit.expand,
      'desc': 'Non-positioned children are forced to fill the parent.',
      'color': Colors.orange,
    },
    {
      'name': 'StackFit.passthrough',
      'fit': StackFit.passthrough,
      'desc': 'Constraints are passed through unchanged from parent.',
      'color': Colors.green,
    },
  ];

  final fitDemos = <Widget>[];
  for (int i = 0; i < fitEntries.length; i++) {
    final entry = fitEntries[i];
    final name = entry['name'] as String;
    final fit = entry['fit'] as StackFit;
    final desc = entry['desc'] as String;
    final color = entry['color'] as MaterialColor;
    print('Demonstrating $name');

    fitDemos.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.shade50, color.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.shade300, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.shade100,
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.aspect_ratio, color: color.shade700, size: 18.0),
                SizedBox(width: 8.0),
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: color.shade900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              desc,
              style: TextStyle(fontSize: 11.0, color: color.shade900),
            ),
            SizedBox(height: 10.0),
            Center(
              child: SizedBox(
                width: 200.0,
                height: 100.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: color.shade400, width: 2.0),
                  ),
                  child: Stack(
                    fit: fit,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 60.0,
                        height: 40.0,
                        color: color.shade300,
                        alignment: Alignment.center,
                        child: Text(
                          '60×40',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 4.0,
                        top: 4.0,
                        child: Container(
                          width: 16.0,
                          height: 16.0,
                          color: color.shade700,
                        ),
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
  print('Built ${fitDemos.length} StackFit demos');

  // ============================================================
  // SECTION 5: Positioned variants — left/right/top/bottom/fill/width/height
  // ============================================================
  print('=== Section 5: Positioned Variants ===');

  final positionedShowcase = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.blueGrey.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.shade200,
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Positioned — Pinning Actors To Stage Edges',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Positioned takes any subset of left/right/top/bottom plus optional '
          'width/height. Positioned.fill is shorthand for all four edges = 0.',
          style: TextStyle(fontSize: 11.0, color: Colors.blueGrey.shade800),
        ),
        SizedBox(height: 14.0),
        Center(
          child: SizedBox(
            width: 320.0,
            height: 220.0,
            child: Stack(
              children: [
                // Backdrop using Positioned.fill
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.indigo.shade100,
                          Colors.indigo.shade300,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                // top-left pin
                Positioned(
                  left: 8.0,
                  top: 8.0,
                  child: _buildPin('left:8 top:8', Colors.red.shade400),
                ),
                // top-right pin
                Positioned(
                  right: 8.0,
                  top: 8.0,
                  child: _buildPin('right:8 top:8', Colors.orange.shade400),
                ),
                // bottom-left pin
                Positioned(
                  left: 8.0,
                  bottom: 8.0,
                  child: _buildPin('left:8 bottom:8', Colors.green.shade500),
                ),
                // bottom-right pin
                Positioned(
                  right: 8.0,
                  bottom: 8.0,
                  child: _buildPin('right:8 bottom:8', Colors.blue.shade500),
                ),
                // explicit width/height with left+top
                Positioned(
                  left: 80.0,
                  top: 60.0,
                  width: 160.0,
                  height: 100.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber.shade300,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: Colors.amber.shade700,
                        width: 2.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'w:160 h:100\nleft:80 top:60',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Center actor (un-positioned, falls back to Stack alignment)
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade400,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.shade300,
                          blurRadius: 8.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.star, size: 18.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  print('Positioned showcase built');

  // ============================================================
  // SECTION 6: PositionedDirectional + textDirection
  // ============================================================
  print('=== Section 6: PositionedDirectional & textDirection ===');

  final dirEntries = <Map<String, Object>>[
    {'name': 'TextDirection.ltr', 'dir': TextDirection.ltr},
    {'name': 'TextDirection.rtl', 'dir': TextDirection.rtl},
  ];
  final directionalDemos = <Widget>[];
  for (int i = 0; i < dirEntries.length; i++) {
    final entry = dirEntries[i];
    final name = entry['name'] as String;
    final dir = entry['dir'] as TextDirection;
    print('PositionedDirectional under $name');

    directionalDemos.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.pink.shade50,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.pink.shade300, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.swap_horiz, color: Colors.pink.shade700),
                SizedBox(width: 8.0),
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Colors.pink.shade900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              'PositionedDirectional uses start/end which flip with the '
              'ambient text direction. Same code, mirrored layout.',
              style: TextStyle(fontSize: 11.0, color: Colors.pink.shade900),
            ),
            SizedBox(height: 10.0),
            Center(
              child: SizedBox(
                width: 280.0,
                height: 110.0,
                child: Stack(
                  textDirection: dir,
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.pink.shade100,
                              Colors.pink.shade200,
                            ],
                          ),
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      start: 12.0,
                      top: 12.0,
                      child: _buildPin('start:12 top', Colors.purple.shade500),
                    ),
                    PositionedDirectional(
                      end: 12.0,
                      bottom: 12.0,
                      child: _buildPin('end:12 bottom', Colors.indigo.shade500),
                    ),
                    Positioned.directional(
                      textDirection: dir,
                      start: 12.0,
                      bottom: 12.0,
                      child: _buildPin(
                        'directional start:12 bot',
                        Colors.teal.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Directional demos: ${directionalDemos.length}');

  // ============================================================
  // SECTION 7: Clip behaviour comparison
  // ============================================================
  print('=== Section 7: Clip Behaviour ===');

  final clipEntries = <Map<String, Object>>[
    {
      'name': 'Clip.none',
      'clip': Clip.none,
      'desc': 'No clipping — children may paint outside bounds.',
    },
    {
      'name': 'Clip.hardEdge',
      'clip': Clip.hardEdge,
      'desc': 'Crisp rectangular clip — fastest non-none option.',
    },
    {
      'name': 'Clip.antiAlias',
      'clip': Clip.antiAlias,
      'desc': 'Smoothed clip edges — better for non-rectangular shapes.',
    },
    {
      'name': 'Clip.antiAliasWithSaveLayer',
      'clip': Clip.antiAliasWithSaveLayer,
      'desc': 'Highest fidelity — uses saveLayer; expensive.',
    },
  ];

  final clipDemos = <Widget>[];
  for (int i = 0; i < clipEntries.length; i++) {
    final entry = clipEntries[i];
    final name = entry['name'] as String;
    final clip = entry['clip'] as Clip;
    final desc = entry['desc'] as String;
    print('Clip $name applied');

    clipDemos.add(
      Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown.shade50, Colors.brown.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.brown.shade300, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.shade200,
              blurRadius: 4.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade900,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              desc,
              style: TextStyle(fontSize: 10.0, color: Colors.brown.shade900),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Container(
                width: 110.0,
                height: 80.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown.shade700, width: 2.0),
                ),
                child: Stack(
                  clipBehavior: clip,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 110.0,
                      height: 80.0,
                      color: Colors.amber.shade100,
                    ),
                    Positioned(
                      left: 80.0,
                      top: 50.0,
                      child: Container(
                        width: 60.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepOrange.shade400,
                              Colors.deepOrange.shade700,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'overflow',
                          style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }
  print('Built ${clipDemos.length} clip demos');

  // ============================================================
  // SECTION 8: Bounds-of-stack rule — un-positioned children size the stage
  // ============================================================
  print('=== Section 8: Bounds-of-Stack Rule ===');

  final boundsExplanation = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.lime.shade50, Colors.lightGreen.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.lightGreen.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.lightGreen.shade100,
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
            Icon(Icons.straighten, color: Colors.green.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Who Decides The Stage Size?',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'When a Stack has loose constraints (the default), it sizes itself '
          'to the largest non-positioned child. Positioned children do not '
          'contribute to size — they only get pinned afterwards.',
          style: TextStyle(fontSize: 12.0, color: Colors.green.shade900),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Case A: only positioned → tiny stack
            Column(
              children: [
                Text(
                  'Only Positioned',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red.shade400,
                      width: 1.5,
                      style: BorderStyle.solid,
                    ),
                    color: Colors.red.shade50,
                  ),
                  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #134, P4):
                  // The "Only Positioned" pedagogical demo wraps a Stack whose
                  // sole child is a Positioned(left:0, top:0, child: 30×30).
                  // Stacks with only Positioned children get no size hints from
                  // their children, and Flutter asserts "A Stack requires
                  // bounded constraints from its parent" when the surrounding
                  // chain (Row(spaceEvenly) > Column > Container(decoration))
                  // delivers loose/unbounded constraints. Wrapping the Stack
                  // in a SizedBox(30×30) gives the Stack tight bounded
                  // constraints matching the only Positioned child's size,
                  // so the assertion clears and the visual reduces to the
                  // single 30×30 red square — a faithful realization of the
                  // "→ collapses" narrative below (the Stack shrinks to fit
                  // its only positioned child).
                  child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0.0,
                          top: 0.0,
                          child: Container(
                            width: 30.0,
                            height: 30.0,
                            color: Colors.red.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '→ collapses',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.red.shade900,
                  ),
                ),
              ],
            ),
            // Case B: one un-positioned → stack matches child
            Column(
              children: [
                Text(
                  'Un-positioned',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green.shade700,
                      width: 1.5,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 90.0,
                        height: 60.0,
                        color: Colors.green.shade300,
                      ),
                      Positioned(
                        right: 4.0,
                        top: 4.0,
                        child: Container(
                          width: 14.0,
                          height: 14.0,
                          color: Colors.green.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '→ 90×60',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.green.shade900,
                  ),
                ),
              ],
            ),
            // Case C: tight constraints
            Column(
              children: [
                Text(
                  'Tight (SizedBox)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
                SizedBox(height: 4.0),
                SizedBox(
                  width: 100.0,
                  height: 60.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue.shade700,
                        width: 1.5,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 30.0,
                          height: 20.0,
                          color: Colors.blue.shade400,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '→ 100×60',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.blue.shade900,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
  print('Bounds explanation built');

  // ============================================================
  // SECTION 9: IndexedStack — only one child visible at a time
  // ============================================================
  print('=== Section 9: IndexedStack ===');

  final indexedActors = <Widget>[];
  final actorColors = <MaterialColor>[
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.orange,
  ];
  final actorLabels = <String>['Hamlet', 'Ophelia', 'Horatio', 'Laertes', 'Polonius'];
  for (int i = 0; i < actorLabels.length; i++) {
    final color = actorColors[i];
    indexedActors.add(
      Container(
        width: 140.0,
        height: 100.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.shade300, color.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.shade800, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.shade200,
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, color: Colors.white, size: 28.0),
            SizedBox(height: 4.0),
            Text(
              actorLabels[i],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
            Text(
              'index $i',
              style: TextStyle(fontSize: 10.0, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  final indexedShowcase = <Widget>[];
  final shownIndices = <int>[0, 2, 4];
  for (int i = 0; i < shownIndices.length; i++) {
    final idx = shownIndices[i];
    final actorsCopy = <Widget>[];
    for (int j = 0; j < indexedActors.length; j++) {
      actorsCopy.add(indexedActors[j]);
    }
    indexedShowcase.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.deepPurple.shade300, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'index: $idx',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.deepPurple.shade900,
                ),
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: IndexedStack(
                alignment: Alignment.center,
                index: idx,
                children: actorsCopy,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('IndexedStack showcase built (${indexedShowcase.length} indices)');

  // IndexedStack vs Stack diagram
  final indexedComparison = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.teal.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.teal.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stack vs IndexedStack',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            _buildComparisonColumn(
              'Stack',
              'All children rendered.\nLayered visually.\nLast-painted on top.',
              Colors.indigo,
              Icons.layers,
            ),
            SizedBox(width: 12.0),
            _buildComparisonColumn(
              'IndexedStack',
              'Only `children[index]` shown.\nOthers stay in tree but hidden.\nState is preserved.',
              Colors.deepOrange,
              Icons.filter_1,
            ),
          ],
        ),
      ],
    ),
  );
  print('Indexed comparison built');

  // ============================================================
  // SECTION 10: Code recipes
  // ============================================================
  print('=== Section 10: Code Recipes ===');

  final codeRecipes = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
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
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Stage Recipes',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeBlock(
          '// Badge on top-right of an avatar\n'
          'Stack(\n'
          '  alignment: Alignment.topRight,\n'
          '  children: [\n'
          '    CircleAvatar(radius: 32),\n'
          '    Positioned(\n'
          '      right: 0, top: 0,\n'
          '      child: Container(width: 12, height: 12,\n'
          '        decoration: BoxDecoration(\n'
          '          color: Colors.red,\n'
          '          shape: BoxShape.circle)),\n'
          '    ),\n'
          '  ],\n'
          ');',
          Colors.lightGreen.shade300,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Full-bleed background with content overlay\n'
          'Stack(\n'
          '  fit: StackFit.expand,\n'
          '  children: [\n'
          '    Image.asset(\'bg.png\', fit: BoxFit.cover),\n'
          '    Positioned.fill(\n'
          '      child: Container(color: Colors.black54),\n'
          '    ),\n'
          '    Center(child: Text(\'Title\')),\n'
          '  ],\n'
          ');',
          Colors.amber.shade200,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Tab-style state preservation with IndexedStack\n'
          'IndexedStack(\n'
          '  index: currentTab,\n'
          '  children: [\n'
          '    HomePage(),     // index 0\n'
          '    SearchPage(),   // index 1 — keeps scroll position!\n'
          '    ProfilePage(),  // index 2\n'
          '  ],\n'
          ');',
          Colors.pinkAccent.shade100,
        ),
        SizedBox(height: 12.0),
        _buildCodeBlock(
          '// Direction-aware bottom-end FAB\n'
          'Stack(\n'
          '  textDirection: Directionality.of(context),\n'
          '  children: [\n'
          '    PageBody(),\n'
          '    PositionedDirectional(\n'
          '      end: 16, bottom: 16,\n'
          '      child: FloatingActionButton(...),\n'
          '    ),\n'
          '  ],\n'
          ');',
          Colors.cyan.shade200,
        ),
      ],
    ),
  );
  print('Code recipes built');

  print('Stack Deep Demo completed — curtain falls');

  // ============================================================
  // Composite return — full scrollable theatre programme
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Curtain header — itself a Stack composition
        Container(
          height: 180.0,
          margin: EdgeInsets.only(bottom: 24.0),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.shade900,
                        Colors.deepOrange.shade700,
                        Colors.amber.shade400,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.theater_comedy,
                      size: 56.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Stack',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                    Text(
                      'A Theatre of Layered Widgets',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white.withValues(alpha: 0.85),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 12.0,
                top: 12.0,
                child: _buildPin('curtain L', Colors.red.shade300),
              ),
              Positioned(
                right: 12.0,
                top: 12.0,
                child: _buildPin('curtain R', Colors.red.shade300),
              ),
            ],
          ),
        ),

        _buildSectionTitle('1. Stage Anatomy'),
        anatomyDiagram,
        SizedBox(height: 24.0),

        _buildSectionTitle('2. Z-Order Layering'),
        zOrderStage,
        SizedBox(height: 24.0),

        _buildSectionTitle('3. Alignment of Un-Positioned Children'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: alignmentTiles,
          ),
        ),
        SizedBox(height: 24.0),

        _buildSectionTitle('4. StackFit — loose | expand | passthrough'),
        ...fitDemos,
        SizedBox(height: 24.0),

        _buildSectionTitle('5. Positioned Variants'),
        positionedShowcase,
        SizedBox(height: 24.0),

        _buildSectionTitle('6. PositionedDirectional & textDirection'),
        ...directionalDemos,
        SizedBox(height: 24.0),

        _buildSectionTitle('7. Clip Behaviour'),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(alignment: WrapAlignment.center, children: clipDemos),
        ),
        SizedBox(height: 24.0),

        _buildSectionTitle('8. Bounds-of-Stack Rule'),
        boundsExplanation,
        SizedBox(height: 24.0),

        _buildSectionTitle('9. IndexedStack — One Actor Per Spotlight'),
        indexedComparison,
        ...indexedShowcase,
        SizedBox(height: 24.0),

        _buildSectionTitle('10. Code Recipes'),
        codeRecipes,
        SizedBox(height: 32.0),

        // Closing curtain card
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black87, Colors.deepPurple.shade900],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.shade900.withValues(alpha: 0.5),
                blurRadius: 12.0,
                offset: Offset(0.0, 6.0),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.nights_stay,
                color: Colors.amber.shade200,
                size: 28.0,
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'Curtain falls. Stack remains the simplest, most flexible '
                  'layout primitive for overlap, badging, full-bleed art, '
                  'and tab-state preservation.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic,
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

// Helper: section header
Widget _buildSectionTitle(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 22.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.pinkAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
      ],
    ),
  );
}

// Helper: build a labelled plane in the anatomy diagram
Widget _buildPlane(String label, int z, Color color, double offset) {
  return Positioned(
    left: 30.0 + offset,
    top: 20.0 + offset,
    child: Container(
      width: 200.0,
      height: 60.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.85), color.withValues(alpha: 0.4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 6.0,
            offset: Offset(2.0, 4.0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Text(
              'z=$z',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper: edge pin marker
Widget _buildPin(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: Colors.white, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 3.0,
          offset: Offset(1.0, 2.0),
        ),
      ],
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 9.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// Helper: comparison column for Stack vs IndexedStack
Widget _buildComparisonColumn(
  String title,
  String body,
  MaterialColor color,
  IconData icon,
) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.shade300, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color.shade700, size: 18.0),
              SizedBox(width: 6.0),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            body,
            style: TextStyle(
              fontSize: 11.0,
              color: color.shade900,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper: monospaced code block
Widget _buildCodeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade700, width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

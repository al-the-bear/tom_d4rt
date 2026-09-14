// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Opacity widget from Flutter widgets
// Deep Demo: Visual demonstration of Opacity, the alpha-channel widget
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Opacity Deep Demo executing');

  // ============================================================
  // PALETTE: coral / magenta + warm grey
  // ============================================================
  final coral = Color(0xFFFF6B6B);
  final coralDeep = Color(0xFFE63946);
  final magenta = Color(0xFFD7263D);
  final magentaSoft = Color(0xFFFF4E8E);
  final blush = Color(0xFFFFD6CC);
  final cream = Color(0xFFFFF6F0);
  final warmGreyLight = Color(0xFFEDE6E0);
  final warmGreyMid = Color(0xFFB8AFA6);
  final warmGreyDeep = Color(0xFF6E6259);
  final ink = Color(0xFF2B2522);
  print('Palette initialized');

  // ============================================================
  // SECTION 1: Title banner with mid-opacity overlay
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    width: double.infinity,
    height: 200.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [coralDeep, magentaSoft, magenta],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: magenta.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: coralDeep.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          right: -20.0,
          top: -20.0,
          child: Opacity(
            opacity: 0.35,
            child: Icon(Icons.opacity, size: 220.0, color: Colors.white),
          ),
        ),
        Positioned(
          left: 16.0,
          bottom: 16.0,
          child: Opacity(
            opacity: 0.55,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'alpha = 0.55 overlay',
                style: TextStyle(
                  fontSize: 11.0,
                  color: ink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.gradient, size: 56.0, color: Colors.white),
            SizedBox(height: 8.0),
            Text(
              'Opacity',
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 4.0),
            Opacity(
              opacity: 0.85,
              child: Text(
                'paints a child with alpha-channel blending',
                style: TextStyle(fontSize: 13.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Title banner created');

  // ============================================================
  // SECTION 2: Anatomy diagram
  // child -> RenderOpacity -> saveLayer -> painted at alpha
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');

  Widget anatomyNode(String label, IconData icon, Color color) {
    return Container(
      width: 130.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.18), color.withValues(alpha: 0.32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color, width: 1.6),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28.0),
          SizedBox(height: 6.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget anatomyArrow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Icon(Icons.arrow_forward, color: warmGreyDeep, size: 22.0),
    );
  }

  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cream, warmGreyLight],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: warmGreyMid, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: warmGreyDeep.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Render pipeline',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              anatomyNode('child widget', Icons.widgets, coral),
              anatomyArrow(),
              anatomyNode('RenderOpacity', Icons.layers, magentaSoft),
              anatomyArrow(),
              anatomyNode('saveLayer()', Icons.save_alt, magenta),
              anatomyArrow(),
              anatomyNode('paint at α', Icons.brush, coralDeep),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: warmGreyMid, width: 1.0),
          ),
          child: Text(
            'Opacity wraps its child in a saveLayer call so the entire '
            'subtree is composited at the requested alpha. This is correct '
            'but requires an offscreen buffer.',
            style: TextStyle(fontSize: 12.0, color: warmGreyDeep, height: 1.4),
          ),
        ),
      ],
    ),
  );
  print('Anatomy diagram created');

  // ============================================================
  // SECTION 3: Opacity ladder (0.0 .. 1.0)
  // ============================================================
  print('=== Section 3: Opacity ladder ===');

  final List<double> alphaSteps = <double>[
    0.0,
    0.1,
    0.2,
    0.3,
    0.4,
    0.5,
    0.6,
    0.7,
    0.8,
    0.9,
    1.0,
  ];

  final ladderTiles = alphaSteps.map((double a) {
    return Container(
      width: 60.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: warmGreyLight,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: warmGreyMid, width: 1.0),
            ),
            child: Center(
              child: Opacity(
                opacity: a,
                child: Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [coral, magenta],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                        color: magenta.withValues(alpha: 0.4),
                        blurRadius: 4.0,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            a.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: ink,
            ),
          ),
        ],
      ),
    );
  }).toList();

  final ladder = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, blush],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: coral.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alpha ladder: 0.0 -> 1.0 in 0.1 steps',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: ladderTiles),
        ),
      ],
    ),
  );
  print('Ladder built with ${alphaSteps.length} steps');

  // ============================================================
  // SECTION 4: Solid vs gradient child at the same opacity
  // ============================================================
  print('=== Section 4: Solid vs gradient ===');

  final solidChild = Container(
    width: 140.0,
    height: 140.0,
    decoration: BoxDecoration(
      color: coral,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Center(
      child: Text(
        'solid',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  final gradientChild = Container(
    width: 140.0,
    height: 140.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [coral, magentaSoft, magenta],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Center(
      child: Text(
        'gradient',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );

  final solidVsGradient = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: warmGreyLight,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: warmGreyMid, width: 1.0),
    ),
    child: Column(
      children: [
        Text(
          'Same Opacity(0.4) on solid vs gradient child',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Opacity(opacity: 0.4, child: solidChild),
                SizedBox(height: 8.0),
                Text(
                  'opacity: 0.4',
                  style: TextStyle(fontSize: 11.0, color: warmGreyDeep),
                ),
              ],
            ),
            Column(
              children: [
                Opacity(opacity: 0.4, child: gradientChild),
                SizedBox(height: 8.0),
                Text(
                  'opacity: 0.4',
                  style: TextStyle(fontSize: 11.0, color: warmGreyDeep),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'The alpha is applied uniformly across the painted output, '
            'whether the child is one flat colour or a gradient of many.',
            style: TextStyle(fontSize: 12.0, color: warmGreyDeep, height: 1.4),
          ),
        ),
      ],
    ),
  );
  print('Solid vs gradient panel created');

  // ============================================================
  // SECTION 5: Stacked opacities - nested 0.5 * 0.5 = 0.25
  // ============================================================
  print('=== Section 5: Stacked opacities ===');

  final stackedSwatch = Container(
    width: 120.0,
    height: 120.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [coralDeep, magenta],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  Widget stackedColumn(String label, Widget swatch, String formula) {
    return Column(
      children: [
        Container(
          width: 130.0,
          height: 130.0,
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: warmGreyMid, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: warmGreyDeep.withValues(alpha: 0.15),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: swatch,
        ),
        SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        Text(
          formula,
          style: TextStyle(
            fontSize: 10.0,
            fontFamily: 'monospace',
            color: warmGreyDeep,
          ),
        ),
      ],
    );
  }

  final stacked = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [blush, cream],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: coral.withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Nested Opacity multiplies',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            stackedColumn('1.0', stackedSwatch, 'no opacity'),
            stackedColumn(
              '0.5',
              Opacity(opacity: 0.5, child: stackedSwatch),
              'α = 0.5',
            ),
            stackedColumn(
              '0.5 * 0.5',
              Opacity(
                opacity: 0.5,
                child: Opacity(opacity: 0.5, child: stackedSwatch),
              ),
              'α = 0.25',
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Nested Opacity widgets multiply: each saveLayer composites on '
            'top of the previous, so final = parent * child.',
            style: TextStyle(fontSize: 12.0, color: warmGreyDeep, height: 1.4),
          ),
        ),
      ],
    ),
  );
  print('Stacked opacity panel created');

  // ============================================================
  // SECTION 6: alwaysIncludeSemantics flag
  // ============================================================
  print('=== Section 6: alwaysIncludeSemantics ===');

  Widget semanticsCard(String title, bool flag, String body, Color color) {
    return Container(
      width: 220.0,
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.12), color.withValues(alpha: 0.28)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
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
              Icon(
                flag ? Icons.accessibility_new : Icons.visibility_off,
                color: color,
                size: 22.0,
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              flag
                  ? 'alwaysIncludeSemantics: true'
                  : 'alwaysIncludeSemantics: false',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: color,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            body,
            style: TextStyle(fontSize: 11.0, color: warmGreyDeep, height: 1.35),
          ),
          SizedBox(height: 10.0),
          Opacity(
            opacity: 0.05,
            child: Container(
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                flag ? 'still in tree' : 'pruned',
                style: TextStyle(color: Colors.white, fontSize: 11.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final semantics = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: warmGreyLight,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: warmGreyMid, width: 1.0),
    ),
    child: Column(
      children: [
        Text(
          'alwaysIncludeSemantics behaviour',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.center,
          children: [
            semanticsCard(
              'default',
              false,
              'When opacity == 0, the subtree is dropped from the semantic '
                  'tree, so screen readers skip it.',
              coral,
            ),
            semanticsCard(
              'forced inclusion',
              true,
              'Setting the flag keeps the subtree in the semantic tree even '
                  'at α = 0. Useful for offscreen-but-discoverable widgets.',
              magenta,
            ),
          ],
        ),
      ],
    ),
  );
  print('Semantics panel created');

  // ============================================================
  // SECTION 7: Opacity vs withValues(alpha:) on color
  // ============================================================
  print('=== Section 7: Opacity vs withValues ===');

  final opacityWidgetVariant = Opacity(
    opacity: 0.5,
    child: Container(
      width: 150.0,
      height: 80.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [coral, magenta],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          'Opacity(0.5)',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );

  final colorAlphaVariant = Container(
    width: 150.0,
    height: 80.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          coral.withValues(alpha: 0.5),
          magenta.withValues(alpha: 0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Center(
      child: Text(
        'withValues(α:0.5)',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );

  final opacityVsColor = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cream, warmGreyLight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: warmGreyDeep.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Opacity(0.5) vs color.withValues(alpha: 0.5)',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                opacityWidgetVariant,
                SizedBox(height: 8.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: coralDeep.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'saveLayer (expensive)',
                    style: TextStyle(fontSize: 10.0, color: coralDeep),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                colorAlphaVariant,
                SizedBox(height: 8.0),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'direct paint (cheap)',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Opacity must allocate an offscreen buffer (saveLayer) to '
            'composite the subtree. Encoding the alpha straight into the '
            'colour avoids that buffer entirely.',
            style: TextStyle(fontSize: 12.0, color: warmGreyDeep, height: 1.4),
          ),
        ),
      ],
    ),
  );
  print('Opacity vs withValues panel created');

  // ============================================================
  // SECTION 8: AnimatedOpacity reference card
  // ============================================================
  print('=== Section 8: AnimatedOpacity reference ===');

  final animatedRef = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [magentaSoft.withValues(alpha: 0.18), blush],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: magentaSoft, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: magentaSoft.withValues(alpha: 0.25),
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
            Icon(Icons.timer, color: magenta, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'AnimatedOpacity',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: magenta,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'AnimatedOpacity is the implicit-animation sibling: it stores the '
          'previous opacity, tweens linearly toward the new one over the '
          'given Duration, and rebuilds Opacity under the hood.',
          style: TextStyle(fontSize: 12.0, color: warmGreyDeep, height: 1.4),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: ink,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'AnimatedOpacity(\n'
            '  duration: Duration(milliseconds: 300),\n'
            '  opacity: visible ? 1.0 : 0.0,\n'
            '  child: badge,\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: blush,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Opacity(
              opacity: 0.2,
              child: Icon(Icons.star, color: magenta, size: 28.0),
            ),
            Opacity(
              opacity: 0.5,
              child: Icon(Icons.star, color: magenta, size: 28.0),
            ),
            Opacity(
              opacity: 0.8,
              child: Icon(Icons.star, color: magenta, size: 28.0),
            ),
            Opacity(
              opacity: 1.0,
              child: Icon(Icons.star, color: magenta, size: 28.0),
            ),
            SizedBox(width: 8.0),
            Text(
              'frames the tween would emit',
              style: TextStyle(
                fontSize: 11.0,
                fontStyle: FontStyle.italic,
                color: warmGreyDeep,
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('AnimatedOpacity card created');

  // ============================================================
  // SECTION 9: Real-world mocks
  // ============================================================
  print('=== Section 9: Real-world mocks ===');

  // 9a: dimmed disabled button
  final disabledButton = Container(
    width: 220.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: warmGreyMid, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: warmGreyDeep.withValues(alpha: 0.12),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Disabled button',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 10.0),
        Opacity(
          opacity: 0.4,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [coral, magenta],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.send, color: Colors.white, size: 16.0),
                SizedBox(width: 8.0),
                Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Opacity(0.4) on the gradient button',
          style: TextStyle(fontSize: 10.0, color: warmGreyDeep),
        ),
      ],
    ),
  );

  // 9b: watermark over image (Stack)
  final watermark = Container(
    width: 220.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: warmGreyMid, width: 1.0),
    ),
    child: Column(
      children: [
        Text(
          'Watermark overlay',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          width: 180.0,
          height: 100.0,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [warmGreyDeep, ink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              Center(
                child: Opacity(
                  opacity: 0.25,
                  child: Text(
                    'PREVIEW',
                    style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 4.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 6.0,
                bottom: 6.0,
                child: Opacity(
                  opacity: 0.6,
                  child: Icon(Icons.copyright, color: Colors.white, size: 14.0),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // 9c: faded list item
  Widget fakeListRow(double alpha, String label) {
    return Opacity(
      opacity: alpha,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: cream,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: warmGreyMid, width: 0.6),
        ),
        child: Row(
          children: [
            Icon(Icons.task_alt, color: coral, size: 16.0),
            SizedBox(width: 8.0),
            Text(
              label,
              style: TextStyle(fontSize: 12.0, color: ink),
            ),
          ],
        ),
      ),
    );
  }

  final fadedList = Container(
    width: 220.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: warmGreyMid, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Faded list (older items)',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 8.0),
        fakeListRow(1.0, 'Today: ship demo'),
        fakeListRow(0.75, 'Yesterday: review PR'),
        fakeListRow(0.5, '2 days ago: notes'),
        fakeListRow(0.25, '3 days ago: archive'),
      ],
    ),
  );

  // 9d: ghost preview card
  final ghostPreview = Container(
    width: 220.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: warmGreyMid, width: 1.0),
    ),
    child: Column(
      children: [
        Text(
          'Drag-ghost preview',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 10.0),
        Opacity(
          opacity: 0.5,
          child: Container(
            width: 170.0,
            height: 80.0,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [magentaSoft, coral],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: magenta.withValues(alpha: 0.4),
                  blurRadius: 14.0,
                  offset: Offset(0.0, 6.0),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.drag_indicator, color: Colors.white),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Card #42',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'dragging...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  final realWorld = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [warmGreyLight, blush],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: coral.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Real-world Opacity uses',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: ink,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          alignment: WrapAlignment.center,
          children: [disabledButton, watermark, fadedList, ghostPreview],
        ),
      ],
    ),
  );
  print('Real-world mocks created');

  // ============================================================
  // SECTION 10: Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');

  Widget footgunRow(IconData icon, String title, String body) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: coralDeep.withValues(alpha: 0.3), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: coralDeep.withValues(alpha: 0.12),
            blurRadius: 4.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: coralDeep, size: 22.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: coralDeep,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: warmGreyDeep,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final footguns = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          coralDeep.withValues(alpha: 0.1),
          magenta.withValues(alpha: 0.1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: coralDeep.withValues(alpha: 0.4), width: 1.4),
      boxShadow: [
        BoxShadow(
          color: coralDeep.withValues(alpha: 0.2),
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
            Icon(Icons.warning_amber, color: coralDeep, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Footguns',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: coralDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        footgunRow(
          Icons.layers_clear,
          'Opacity over a huge subtree',
          'Wrapping a large widget tree forces a saveLayer of the entire '
              'rasterised area. On low-end devices this drops frames quickly. '
              'Prefer baking alpha into colours when possible.',
        ),
        footgunRow(
          Icons.memory,
          'saveLayer cost',
          'Each Opacity allocates an offscreen surface. Avoid stacking many '
              'Opacity widgets in lists; use FadeTransition or coloured paints '
              'instead.',
        ),
        footgunRow(
          Icons.speed,
          'AnimatedOpacity needs a value change',
          'AnimatedOpacity only animates when the opacity value actually '
              'differs from the previous build. Toggling the same value will '
              'not trigger a tween.',
        ),
        footgunRow(
          Icons.accessibility,
          'Invisible but still tappable',
          'Opacity does NOT remove hit testing. A button at α = 0 still '
              'receives taps. Wrap with IgnorePointer to fully disable it.',
        ),
      ],
    ),
  );
  print('Footguns panel created');

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap ===');

  Widget recapBullet(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 16.0),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final recap = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [coralDeep, magenta, magentaSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: magenta.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: coralDeep.withValues(alpha: 0.25),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bookmark, color: Colors.white, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        recapBullet(
          Icons.check,
          'Opacity blends a child at alpha 0..1 by wrapping it in a saveLayer.',
        ),
        recapBullet(
          Icons.check,
          'Nested Opacity multiplies: 0.5 inside 0.5 = 0.25.',
        ),
        recapBullet(
          Icons.check,
          'For solid colours prefer color.withValues(alpha:) — it skips '
              'saveLayer and is much cheaper.',
        ),
        recapBullet(
          Icons.check,
          'Use AnimatedOpacity for declarative, duration-based fades; it is '
              'still the same Opacity widget under the hood.',
        ),
        recapBullet(
          Icons.check,
          'alwaysIncludeSemantics keeps fully transparent subtrees in the '
              'semantic tree — important for accessibility.',
        ),
        recapBullet(
          Icons.check,
          'Opacity does not block hit testing — combine with IgnorePointer '
              'or AbsorbPointer to truly disable interaction.',
        ),
      ],
    ),
  );
  print('Recap card created');

  print('Opacity Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: cream,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 28.0),
          Text(
            '1. Opacity at a glance',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: ink,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Opacity is a single-child widget that paints its descendant at '
            'a given alpha value. Internally it relies on RenderOpacity, '
            'which uses saveLayer to composite the subtree.',
            style: TextStyle(fontSize: 13.0, color: warmGreyDeep, height: 1.4),
          ),
          SizedBox(height: 24.0),
          Text(
            '2. Render anatomy',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: ink,
            ),
          ),
          SizedBox(height: 8.0),
          anatomy,
          SizedBox(height: 28.0),
          Text(
            '3. Alpha ladder',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: ink,
            ),
          ),
          SizedBox(height: 8.0),
          ladder,
          SizedBox(height: 28.0),
          Text(
            '4. Solid vs gradient child',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: ink,
            ),
          ),
          SizedBox(height: 8.0),
          solidVsGradient,
          SizedBox(height: 28.0),
          Text(
            '5. Nested Opacity',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: ink,
            ),
          ),
          SizedBox(height: 8.0),
          stacked,
          SizedBox(height: 28.0),
          Text(
            '6. Semantics flag',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: ink,
            ),
          ),
          SizedBox(height: 8.0),
          semantics,
          SizedBox(height: 28.0),
          Text(
            '7. Opacity vs withValues(alpha:)',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: ink,
            ),
          ),
          SizedBox(height: 8.0),
          opacityVsColor,
          SizedBox(height: 28.0),
          Text(
            '8. AnimatedOpacity reference',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: ink,
            ),
          ),
          SizedBox(height: 8.0),
          animatedRef,
          SizedBox(height: 28.0),
          Text(
            '9. Real-world mocks',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: ink,
            ),
          ),
          SizedBox(height: 8.0),
          realWorld,
          SizedBox(height: 28.0),
          Text(
            '10. Footguns',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: ink,
            ),
          ),
          SizedBox(height: 8.0),
          footguns,
          SizedBox(height: 28.0),
          Text(
            '11. Recap',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: ink,
            ),
          ),
          SizedBox(height: 8.0),
          recap,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

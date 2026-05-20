// D4rt test script: Deep visual demonstration of the Material widget.
//
// This script is interpreted by D4rt (not compiled) via the SendTestRunner
// harness in the tom_d4rt_flutter_ast project. It builds a rich, visually
// dense gallery that exercises the full surface area of `Material`:
//
//   - MaterialType variants (canvas, card, circle, button, transparency)
//   - Elevation ladder from 0 -> 24 with shadow comparisons
//   - color, shadowColor, surfaceTintColor (M3 surface tinting)
//   - textStyle propagation through descendants
//   - borderRadius vs shape (RoundedRectangleBorder / StadiumBorder /
//     BeveledRectangleBorder / CircleBorder)
//   - animationDuration tuning
//   - clipBehavior interactions with rounded borders
//   - borderOnForeground vs background painting
//   - Real-world compositions: cards, chips, FAB hosts, ink hosts
//
// CRITICAL D4rt note: for-loop closure capture is shared across iterations,
// so anywhere a callback would otherwise capture a loop variable we use
// `List.generate` so each closure gets its own index.
import 'package:flutter/material.dart';
import 'dart:math' as math;

dynamic build(BuildContext context) {
  // ==========================================================================
  // Helper: section header.
  // ==========================================================================
  Widget sectionHeader(
    String number,
    String title,
    String subtitle,
    IconData icon,
    Color accent,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 32.0, bottom: 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            accent.withValues(alpha: 0.18),
            accent.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(
          color: accent.withValues(alpha: 0.45),
          width: 1.4,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: accent.withValues(alpha: 0.40),
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 28.0),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.20),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'SECTION $number',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: accent,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: accent.withValues(alpha: 0.95),
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade700,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper: descriptive narrative block.
  Widget narrative(String body, {Color? accent}) {
    final Color color = accent ?? Colors.blueGrey;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.0),
        border: Border(
          left: BorderSide(color: color, width: 4.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.menu_book_outlined, size: 20.0, color: color),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              body,
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.grey.shade800,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper: tag/chip label.
  Widget tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.5,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  // ==========================================================================
  // HEADER
  // ==========================================================================
  final Widget header = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF1A237E),
          Color(0xFF3949AB),
          Color(0xFF5E35B1),
        ],
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF1A237E).withValues(alpha: 0.30),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.layers_outlined,
            color: Colors.white,
            size: 56.0,
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Material',
          style: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'A piece of material — the central surface of every Material UI',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.85),
          ),
        ),
        const SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.center,
          children: <Widget>[
            tag('MaterialType', Colors.cyanAccent),
            tag('elevation', Colors.amberAccent),
            tag('shape', Colors.pinkAccent),
            tag('surfaceTint', Colors.lightGreenAccent),
            tag('shadowColor', Colors.orangeAccent),
            tag('textStyle', Colors.tealAccent),
            tag('clipBehavior', Colors.purpleAccent),
            tag('borderOnForeground', Colors.lightBlueAccent),
          ],
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 1 — MaterialType gallery
  // ==========================================================================
  final List<Map<String, dynamic>> materialTypes = <Map<String, dynamic>>[
    <String, dynamic>{
      'type': MaterialType.canvas,
      'label': 'canvas',
      'desc': 'Infinite background surface, no shape constraint',
      'icon': Icons.crop_landscape,
      'color': Colors.blue,
    },
    <String, dynamic>{
      'type': MaterialType.card,
      'label': 'card',
      'desc': 'Slightly rounded rectangle with default radius',
      'icon': Icons.crop_square,
      'color': Colors.deepPurple,
    },
    <String, dynamic>{
      'type': MaterialType.circle,
      'label': 'circle',
      'desc': 'Circular shape — perfect for avatars and badges',
      'icon': Icons.circle_outlined,
      'color': Colors.pink,
    },
    <String, dynamic>{
      'type': MaterialType.button,
      'label': 'button',
      'desc': 'Compact rounded surface tuned for buttons',
      'icon': Icons.smart_button,
      'color': Colors.teal,
    },
    <String, dynamic>{
      'type': MaterialType.transparency,
      'label': 'transparency',
      'desc': 'No background painted — only ink reactions render',
      'icon': Icons.visibility_off_outlined,
      'color': Colors.orange,
    },
  ];

  final List<Widget> typeTiles = List<Widget>.generate(materialTypes.length, (
    int i,
  ) {
    final Map<String, dynamic> entry = materialTypes[i];
    final MaterialType matType = entry['type'] as MaterialType;
    final String label = entry['label'] as String;
    final String desc = entry['desc'] as String;
    final IconData icon = entry['icon'] as IconData;
    final Color color = entry['color'] as Color;

    Widget child;
    if (matType == MaterialType.circle) {
      child = Material(
        type: MaterialType.circle,
        color: color.withValues(alpha: 0.18),
        elevation: 4.0,
        child: SizedBox(
          width: 110.0,
          height: 110.0,
          child: Center(
            child: Icon(icon, color: color, size: 40.0),
          ),
        ),
      );
    } else if (matType == MaterialType.button) {
      child = Material(
        type: MaterialType.button,
        color: color.withValues(alpha: 0.18),
        elevation: 3.0,
        child: SizedBox(
          width: 140.0,
          height: 64.0,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, color: color, size: 20.0),
                const SizedBox(width: 8.0),
                Text(
                  'Button',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (matType == MaterialType.transparency) {
      child = Container(
        width: 160.0,
        height: 110.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              color.withValues(alpha: 0.30),
              color.withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: Icon(icon, color: color, size: 40.0),
          ),
        ),
      );
    } else {
      child = Material(
        type: matType,
        color: color.withValues(alpha: 0.18),
        elevation: 4.0,
        child: SizedBox(
          width: 160.0,
          height: 110.0,
          child: Center(
            child: Icon(icon, color: color, size: 40.0),
          ),
        ),
      );
    }

    return Container(
      width: 200.0,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          child,
          const SizedBox(height: 10.0),
          tag('type: $label', color),
          const SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade700,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  });

  // ==========================================================================
  // SECTION 2 — Elevation ladder (0,1,2,3,4,6,8,12,16,24)
  // ==========================================================================
  final List<double> elevations = <double>[
    0.0,
    1.0,
    2.0,
    3.0,
    4.0,
    6.0,
    8.0,
    12.0,
    16.0,
    24.0,
  ];

  final List<Widget> elevationTiles = List<Widget>.generate(elevations.length, (
    int i,
  ) {
    final double e = elevations[i];
    // Color intensity scales with elevation.
    final double t = e / 24.0;
    final Color tone = Color.lerp(
      Colors.blue.shade100,
      Colors.indigo.shade700,
      t,
    )!;
    final Color textColor = t > 0.45 ? Colors.white : Colors.indigo.shade900;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Material(
            elevation: e,
            color: tone,
            borderRadius: BorderRadius.circular(12.0),
            shadowColor: Colors.indigo,
            child: SizedBox(
              width: 100.0,
              height: 90.0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.layers, color: textColor, size: 22.0),
                    const SizedBox(height: 4.0),
                    Text(
                      e.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      'dp',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: textColor.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          tag('e=$e', Colors.indigo),
        ],
      ),
    );
  });

  // Shadow color comparison row at fixed elevation.
  final List<Map<String, dynamic>> shadowColors = <Map<String, dynamic>>[
    <String, dynamic>{'color': Colors.black, 'name': 'black (default)'},
    <String, dynamic>{'color': Colors.red, 'name': 'red'},
    <String, dynamic>{'color': Colors.blue, 'name': 'blue'},
    <String, dynamic>{'color': Colors.green, 'name': 'green'},
    <String, dynamic>{'color': Colors.purple, 'name': 'purple'},
    <String, dynamic>{'color': Colors.orange, 'name': 'orange'},
  ];

  final List<Widget> shadowTiles = List<Widget>.generate(shadowColors.length, (
    int i,
  ) {
    final Map<String, dynamic> entry = shadowColors[i];
    final Color c = entry['color'] as Color;
    final String name = entry['name'] as String;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Material(
            elevation: 12.0,
            color: Colors.white,
            shadowColor: c,
            borderRadius: BorderRadius.circular(14.0),
            child: SizedBox(
              width: 110.0,
              height: 80.0,
              child: Center(
                child: Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: c, width: 2.0),
                  ),
                  child: Icon(Icons.brightness_3, color: c, size: 20.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          tag(name, c),
        ],
      ),
    );
  });

  // ==========================================================================
  // SECTION 3 — Shape gallery
  // ==========================================================================
  final List<Map<String, dynamic>> shapeEntries = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'RoundedRectangleBorder r=4',
      'shape': RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      'color': Colors.blue,
      'icon': Icons.crop_square,
    },
    <String, dynamic>{
      'name': 'RoundedRectangleBorder r=12',
      'shape': RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      'color': Colors.indigo,
      'icon': Icons.rounded_corner,
    },
    <String, dynamic>{
      'name': 'RoundedRectangleBorder r=24',
      'shape': RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      'color': Colors.purple,
      'icon': Icons.bubble_chart,
    },
    <String, dynamic>{
      'name': 'RoundedRectangleBorder asym',
      'shape': const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.0),
          topRight: Radius.circular(4.0),
          bottomLeft: Radius.circular(4.0),
          bottomRight: Radius.circular(28.0),
        ),
      ),
      'color': Colors.deepPurple,
      'icon': Icons.format_shapes,
    },
    <String, dynamic>{
      'name': 'RoundedRectangleBorder + side',
      'shape': RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
        side: const BorderSide(color: Colors.teal, width: 3.0),
      ),
      'color': Colors.teal,
      'icon': Icons.border_style,
    },
    <String, dynamic>{
      'name': 'StadiumBorder',
      'shape': const StadiumBorder(),
      'color': Colors.pink,
      'icon': Icons.sports_basketball,
    },
    <String, dynamic>{
      'name': 'StadiumBorder + side',
      'shape': const StadiumBorder(
        side: BorderSide(color: Colors.pink, width: 2.5),
      ),
      'color': Colors.pinkAccent,
      'icon': Icons.sports_basketball,
    },
    <String, dynamic>{
      'name': 'BeveledRectangleBorder r=10',
      'shape': RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      'color': Colors.amber,
      'icon': Icons.architecture,
    },
    <String, dynamic>{
      'name': 'BeveledRectangleBorder r=18',
      'shape': BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: const BorderSide(color: Colors.deepOrange, width: 2.0),
      ),
      'color': Colors.deepOrange,
      'icon': Icons.format_shapes_outlined,
    },
    <String, dynamic>{
      'name': 'CircleBorder',
      'shape': const CircleBorder(),
      'color': Colors.green,
      'icon': Icons.circle,
    },
    <String, dynamic>{
      'name': 'CircleBorder + side',
      'shape': const CircleBorder(
        side: BorderSide(color: Colors.green, width: 3.0),
      ),
      'color': Colors.lightGreen,
      'icon': Icons.album,
    },
    <String, dynamic>{
      'name': 'ContinuousRectangleBorder',
      'shape': ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
      ),
      'color': Colors.cyan,
      'icon': Icons.waves,
    },
  ];

  final List<Widget> shapeTiles = List<Widget>.generate(shapeEntries.length, (
    int i,
  ) {
    final Map<String, dynamic> entry = shapeEntries[i];
    final String name = entry['name'] as String;
    final ShapeBorder shape = entry['shape'] as ShapeBorder;
    final Color color = entry['color'] as Color;
    final IconData icon = entry['icon'] as IconData;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Material(
            elevation: 6.0,
            color: color.withValues(alpha: 0.16),
            shape: shape,
            shadowColor: color,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              width: 130.0,
              height: 100.0,
              child: Center(
                child: Icon(icon, color: color, size: 36.0),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: 140.0,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.bold,
                color: color,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  });

  // ==========================================================================
  // SECTION 4 — Surface tint (M3)
  // ==========================================================================
  final List<Map<String, dynamic>> tintConfigs = <Map<String, dynamic>>[
    <String, dynamic>{'tint': Colors.transparent, 'name': 'none', 'e': 0.0},
    <String, dynamic>{'tint': Colors.blue, 'name': 'blue', 'e': 1.0},
    <String, dynamic>{'tint': Colors.blue, 'name': 'blue', 'e': 3.0},
    <String, dynamic>{'tint': Colors.blue, 'name': 'blue', 'e': 6.0},
    <String, dynamic>{'tint': Colors.blue, 'name': 'blue', 'e': 12.0},
    <String, dynamic>{'tint': Colors.purple, 'name': 'purple', 'e': 6.0},
    <String, dynamic>{'tint': Colors.teal, 'name': 'teal', 'e': 6.0},
    <String, dynamic>{'tint': Colors.orange, 'name': 'orange', 'e': 6.0},
  ];

  final List<Widget> tintTiles = List<Widget>.generate(tintConfigs.length, (
    int i,
  ) {
    final Map<String, dynamic> cfg = tintConfigs[i];
    final Color tint = cfg['tint'] as Color;
    final String tintName = cfg['name'] as String;
    final double e = cfg['e'] as double;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Material(
            elevation: e,
            color: Colors.white,
            surfaceTintColor: tint,
            borderRadius: BorderRadius.circular(14.0),
            child: SizedBox(
              width: 130.0,
              height: 100.0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.gradient,
                      color: tint == Colors.transparent
                          ? Colors.grey.shade500
                          : tint,
                      size: 28.0,
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'e=$e',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          tag(
            'tint: $tintName',
            tint == Colors.transparent ? Colors.grey : tint,
          ),
        ],
      ),
    );
  });

  // ==========================================================================
  // SECTION 5 — borderRadius vs shape, clipBehavior, borderOnForeground
  // ==========================================================================
  final Widget radiusVsShape = Wrap(
    spacing: 12.0,
    runSpacing: 16.0,
    children: <Widget>[
      Column(
        children: <Widget>[
          Material(
            elevation: 4.0,
            color: Colors.lightBlue.shade100,
            borderRadius: BorderRadius.circular(20.0),
            child: const SizedBox(
              width: 160.0,
              height: 90.0,
              child: Center(
                child: Text(
                  'borderRadius:\nBorderRadius.circular(20)',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          tag('borderRadius', Colors.lightBlue),
        ],
      ),
      Column(
        children: <Widget>[
          Material(
            elevation: 4.0,
            color: Colors.pink.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(color: Colors.pink, width: 2.0),
            ),
            child: const SizedBox(
              width: 160.0,
              height: 90.0,
              child: Center(
                child: Text(
                  'shape:\nRoundedRectangleBorder(20)',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          tag('shape', Colors.pink),
        ],
      ),
    ],
  );

  // Clip behavior comparison.
  final List<Clip> clipBehaviors = <Clip>[
    Clip.none,
    Clip.hardEdge,
    Clip.antiAlias,
    Clip.antiAliasWithSaveLayer,
  ];
  final List<String> clipNames = <String>[
    'none',
    'hardEdge',
    'antiAlias',
    'antiAliasWithSaveLayer',
  ];

  final List<Widget> clipTiles = List<Widget>.generate(clipBehaviors.length, (
    int i,
  ) {
    final Clip cb = clipBehaviors[i];
    final String name = clipNames[i];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Material(
            elevation: 4.0,
            color: Colors.amber.shade200,
            borderRadius: BorderRadius.circular(20.0),
            clipBehavior: cb,
            child: SizedBox(
              width: 140.0,
              height: 90.0,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: -20.0,
                    top: -20.0,
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: const BoxDecoration(
                        color: Colors.deepOrange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -10.0,
                    bottom: -10.0,
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          tag('Clip.$name', Colors.amber.shade800),
        ],
      ),
    );
  });

  // borderOnForeground demonstration.
  final Widget borderForegroundDemo = Wrap(
    spacing: 16.0,
    runSpacing: 16.0,
    children: <Widget>[
      Column(
        children: <Widget>[
          Material(
            elevation: 4.0,
            color: Colors.teal.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
              side: const BorderSide(color: Colors.teal, width: 4.0),
            ),
            child: Container(
              width: 180.0,
              height: 90.0,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.teal.shade300,
                    Colors.cyan.shade200,
                  ],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Center(
                child: Text(
                  'borderOnForeground: true\nborder paints OVER child',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          tag('borderOnForeground=true', Colors.teal),
        ],
      ),
      Column(
        children: <Widget>[
          Material(
            elevation: 4.0,
            color: Colors.deepOrange.shade100,
            borderOnForeground: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
              side: const BorderSide(color: Colors.deepOrange, width: 4.0),
            ),
            child: Container(
              width: 180.0,
              height: 90.0,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.deepOrange.shade300,
                    Colors.amber.shade200,
                  ],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Center(
                child: Text(
                  'borderOnForeground: false\nchild paints OVER border',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          tag('borderOnForeground=false', Colors.deepOrange),
        ],
      ),
    ],
  );

  // ==========================================================================
  // SECTION 6 — textStyle propagation
  // ==========================================================================
  final List<Map<String, dynamic>> textStyles = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'Default',
      'style': const TextStyle(),
      'bg': Colors.grey.shade100,
      'desc': 'no override',
    },
    <String, dynamic>{
      'name': 'Display Large',
      'style': const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w900,
        color: Color(0xFF1A237E),
        letterSpacing: 1.5,
      ),
      'bg': Colors.indigo.shade50,
      'desc': '22sp / 900 / wide',
    },
    <String, dynamic>{
      'name': 'Quiet body',
      'style': TextStyle(
        fontSize: 13.0,
        color: Colors.grey.shade600,
        height: 1.55,
        fontStyle: FontStyle.italic,
      ),
      'bg': Colors.grey.shade50,
      'desc': 'italic body',
    },
    <String, dynamic>{
      'name': 'Code',
      'style': TextStyle(
        fontFamily: 'monospace',
        fontSize: 13.0,
        color: Colors.green.shade300,
        backgroundColor: Colors.grey.shade900,
      ),
      'bg': Colors.grey.shade900,
      'desc': 'monospace code',
    },
    <String, dynamic>{
      'name': 'Branded',
      'style': const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFFB71C1C),
      ),
      'bg': const Color(0xFFFFEBEE),
      'desc': 'brand red bold',
    },
  ];

  final List<Widget> textStyleTiles = List<Widget>.generate(textStyles.length, (
    int i,
  ) {
    final Map<String, dynamic> entry = textStyles[i];
    final String name = entry['name'] as String;
    final TextStyle style = entry['style'] as TextStyle;
    final Color bg = entry['bg'] as Color;
    final String desc = entry['desc'] as String;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 3.0,
        color: bg,
        borderRadius: BorderRadius.circular(12.0),
        textStyle: style,
        child: Container(
          width: 220.0,
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.text_fields,
                    size: 16.0,
                    color: style.color ?? Colors.grey.shade700,
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w800,
                      color: style.color ?? Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              // This text uses the inherited Material.textStyle.
              const Text(
                'The quick brown fox jumps over the lazy dog.',
              ),
              const SizedBox(height: 8.0),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.normal,
                  color: style.color?.withValues(alpha: 0.7) ??
                      Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });

  // ==========================================================================
  // SECTION 7 — animationDuration variations
  // ==========================================================================
  final List<Map<String, dynamic>> durationConfigs = <Map<String, dynamic>>[
    <String, dynamic>{'ms': 0, 'label': 'instant'},
    <String, dynamic>{'ms': 100, 'label': 'snappy'},
    <String, dynamic>{'ms': 200, 'label': 'default'},
    <String, dynamic>{'ms': 400, 'label': 'soft'},
    <String, dynamic>{'ms': 800, 'label': 'slow'},
    <String, dynamic>{'ms': 1500, 'label': 'cinematic'},
  ];

  final List<Widget> durationTiles = List<Widget>.generate(
    durationConfigs.length,
    (int i) {
      final Map<String, dynamic> cfg = durationConfigs[i];
      final int ms = cfg['ms'] as int;
      final String label = cfg['label'] as String;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Material(
              elevation: 4.0,
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(14.0),
              animationDuration: Duration(milliseconds: ms),
              child: SizedBox(
                width: 130.0,
                height: 88.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.timer_outlined,
                        color: Colors.deepPurple,
                        size: 26.0,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '$ms ms',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            tag(label, Colors.deepPurple),
          ],
        ),
      );
    },
  );

  // ==========================================================================
  // SECTION 8 — Material + InkWell ripple hosts
  // ==========================================================================
  final List<Map<String, dynamic>> inkHosts = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Default ripple',
      'desc': 'standard ink reaction',
      'splash': Colors.blue.withValues(alpha: 0.30),
      'highlight': Colors.blue.withValues(alpha: 0.10),
      'icon': Icons.touch_app_outlined,
      'color': Colors.blue,
    },
    <String, dynamic>{
      'title': 'Warm splash',
      'desc': 'tap to emit amber waves',
      'splash': Colors.amber.withValues(alpha: 0.40),
      'highlight': Colors.amber.withValues(alpha: 0.15),
      'icon': Icons.wb_sunny_outlined,
      'color': Colors.amber,
    },
    <String, dynamic>{
      'title': 'Cool splash',
      'desc': 'teal/cyan ripple over Ink',
      'splash': Colors.cyan.withValues(alpha: 0.35),
      'highlight': Colors.teal.withValues(alpha: 0.12),
      'icon': Icons.water_drop_outlined,
      'color': Colors.cyan,
    },
    <String, dynamic>{
      'title': 'Subtle press',
      'desc': 'low-alpha grey reaction',
      'splash': Colors.black.withValues(alpha: 0.10),
      'highlight': Colors.black.withValues(alpha: 0.05),
      'icon': Icons.gesture_outlined,
      'color': Colors.grey,
    },
  ];

  final List<Widget> inkHostTiles = List<Widget>.generate(inkHosts.length, (
    int i,
  ) {
    final Map<String, dynamic> entry = inkHosts[i];
    final String title = entry['title'] as String;
    final String desc = entry['desc'] as String;
    final Color splash = entry['splash'] as Color;
    final Color highlight = entry['highlight'] as Color;
    final IconData icon = entry['icon'] as IconData;
    final Color color = entry['color'] as Color;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 6.0,
        color: Colors.white,
        surfaceTintColor: color,
        borderRadius: BorderRadius.circular(18.0),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          splashColor: splash,
          highlightColor: highlight,
          borderRadius: BorderRadius.circular(18.0),
          child: SizedBox(
            width: 230.0,
            height: 120.0,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 56.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Icon(icon, color: color, size: 28.0),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: color.withValues(alpha: 0.95),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          desc,
                          style: TextStyle(
                            fontSize: 11.5,
                            color: Colors.grey.shade700,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.touch_app,
                              size: 12.0,
                              color: color.withValues(alpha: 0.7),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              'Tap me',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: color.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  });

  // ==========================================================================
  // SECTION 9 — Real-world compositions
  // ==========================================================================
  // 9a. Card composition.
  final Widget profileCard = Material(
    elevation: 8.0,
    color: Colors.white,
    surfaceTintColor: Colors.indigo,
    borderRadius: BorderRadius.circular(20.0),
    shadowColor: Colors.indigo.withValues(alpha: 0.4),
    clipBehavior: Clip.antiAlias,
    child: Container(
      width: 320.0,
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Material(
                type: MaterialType.circle,
                elevation: 4.0,
                color: Colors.indigo,
                shadowColor: Colors.indigo,
                child: const SizedBox(
                  width: 56.0,
                  height: 56.0,
                  child: Center(
                    child: Text(
                      'TM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Tom Material',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Surface architect',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                type: MaterialType.button,
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(20.0),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20.0),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      'Follow',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Container(
            height: 1.0,
            color: Colors.grey.shade200,
          ),
          const SizedBox(height: 12.0),
          Text(
            'A Material widget is more than a colored rectangle — it is the '
            'physical surface that captures elevation, shadows, ink reactions '
            'and the shape language of an entire screen.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade800,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14.0),
          Row(
            children: <Widget>[
              Icon(Icons.layers, size: 14.0, color: Colors.indigo.shade300),
              const SizedBox(width: 4.0),
              Text(
                'elevation 8',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 14.0),
              Icon(
                Icons.format_paint_outlined,
                size: 14.0,
                color: Colors.indigo.shade300,
              ),
              const SizedBox(width: 4.0),
              Text(
                'tint: indigo',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 14.0),
              Icon(
                Icons.crop_din_outlined,
                size: 14.0,
                color: Colors.indigo.shade300,
              ),
              const SizedBox(width: 4.0),
              Text(
                'radius 20',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // 9b. Chip-like Material row.
  final List<Map<String, dynamic>> chipEntries = <Map<String, dynamic>>[
    <String, dynamic>{'label': 'Design', 'color': Colors.blue},
    <String, dynamic>{'label': 'Material', 'color': Colors.indigo},
    <String, dynamic>{'label': 'Flutter', 'color': Colors.cyan},
    <String, dynamic>{'label': 'Elevation', 'color': Colors.purple},
    <String, dynamic>{'label': 'Shadow', 'color': Colors.deepOrange},
    <String, dynamic>{'label': 'Surface', 'color': Colors.teal},
    <String, dynamic>{'label': 'Tint', 'color': Colors.pink},
    <String, dynamic>{'label': 'Shape', 'color': Colors.amber},
  ];
  final List<Widget> chipTiles = List<Widget>.generate(chipEntries.length, (
    int i,
  ) {
    final Map<String, dynamic> entry = chipEntries[i];
    final String label = entry['label'] as String;
    final Color color = entry['color'] as Color;
    return Material(
      elevation: 2.0,
      color: color.withValues(alpha: 0.12),
      shape: StadiumBorder(
        side: BorderSide(color: color.withValues(alpha: 0.6), width: 1.0),
      ),
      shadowColor: color,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        splashColor: color.withValues(alpha: 0.30),
        highlightColor: color.withValues(alpha: 0.10),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });

  // 9c. FAB-style host using MaterialType.circle.
  final List<Map<String, dynamic>> fabEntries = <Map<String, dynamic>>[
    <String, dynamic>{
      'icon': Icons.add,
      'color': Colors.indigo,
      'label': 'Add',
    },
    <String, dynamic>{
      'icon': Icons.send,
      'color': Colors.deepOrange,
      'label': 'Send',
    },
    <String, dynamic>{
      'icon': Icons.edit,
      'color': Colors.teal,
      'label': 'Edit',
    },
    <String, dynamic>{
      'icon': Icons.delete_outline,
      'color': Colors.red,
      'label': 'Delete',
    },
    <String, dynamic>{
      'icon': Icons.share,
      'color': Colors.purple,
      'label': 'Share',
    },
  ];
  final List<Widget> fabTiles = List<Widget>.generate(fabEntries.length, (
    int i,
  ) {
    final Map<String, dynamic> entry = fabEntries[i];
    final IconData icon = entry['icon'] as IconData;
    final Color color = entry['color'] as Color;
    final String label = entry['label'] as String;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Material(
            type: MaterialType.circle,
            elevation: 6.0,
            color: color,
            shadowColor: color,
            child: SizedBox(
              width: 64.0,
              height: 64.0,
              child: InkResponse(
                onTap: () {},
                radius: 40.0,
                splashColor: Colors.white.withValues(alpha: 0.3),
                highlightColor: Colors.white.withValues(alpha: 0.12),
                child: Icon(icon, color: Colors.white, size: 28.0),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  });

  // 9d. Composite "stat dashboard" using nested Material surfaces.
  final List<Map<String, dynamic>> statEntries = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'Surfaces',
      'value': '128',
      'icon': Icons.layers_outlined,
      'color': Colors.indigo,
    },
    <String, dynamic>{
      'label': 'Elevations',
      'value': '24dp',
      'icon': Icons.height,
      'color': Colors.deepPurple,
    },
    <String, dynamic>{
      'label': 'Shapes',
      'value': '12',
      'icon': Icons.format_shapes,
      'color': Colors.pink,
    },
    <String, dynamic>{
      'label': 'Tint',
      'value': 'M3',
      'icon': Icons.palette,
      'color': Colors.teal,
    },
  ];

  final List<Widget> statTiles = List<Widget>.generate(statEntries.length, (
    int i,
  ) {
    final Map<String, dynamic> entry = statEntries[i];
    final String label = entry['label'] as String;
    final String value = entry['value'] as String;
    final IconData icon = entry['icon'] as IconData;
    final Color color = entry['color'] as Color;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 3.0,
        color: Colors.white,
        surfaceTintColor: color,
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          width: 150.0,
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(icon, color: color, size: 20.0),
              ),
              const SizedBox(height: 10.0),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });

  // ==========================================================================
  // SECTION 10 — Elevation/shape combo matrix (visual playground)
  // ==========================================================================
  final List<double> matrixElevations = <double>[1.0, 4.0, 12.0];
  final List<Map<String, dynamic>> matrixShapes = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'rect4',
      'shape': RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    },
    <String, dynamic>{
      'name': 'rect18',
      'shape': RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    },
    <String, dynamic>{
      'name': 'stadium',
      'shape': const StadiumBorder(),
    },
    <String, dynamic>{
      'name': 'beveled',
      'shape': BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
    },
  ];

  final List<Widget> matrixRows = List<Widget>.generate(
    matrixElevations.length,
    (int row) {
      final double e = matrixElevations[row];
      final List<Widget> cells = List<Widget>.generate(matrixShapes.length, (
        int col,
      ) {
        final Map<String, dynamic> sh = matrixShapes[col];
        final String name = sh['name'] as String;
        final ShapeBorder shape = sh['shape'] as ShapeBorder;
        // Hue varies along the row for visual delight.
        final double hue = ((row * matrixShapes.length + col) /
                (matrixElevations.length * matrixShapes.length)) *
            360.0;
        final Color tone = HSVColor.fromAHSV(1.0, hue, 0.45, 0.95).toColor();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Material(
                elevation: e,
                color: tone,
                shape: shape,
                shadowColor: tone,
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: 110.0,
                  height: 70.0,
                  child: Center(
                    child: Text(
                      'e=$e\n$name',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cells,
        ),
      );
    },
  );

  // ==========================================================================
  // SECTION 11 — Properties reference table
  // ==========================================================================
  final List<Map<String, String>> propEntries = <Map<String, String>>[
    <String, String>{
      'name': 'type',
      'type': 'MaterialType',
      'desc': 'canvas, card, circle, button, transparency',
    },
    <String, String>{
      'name': 'elevation',
      'type': 'double',
      'desc': 'z-depth in logical pixels (0-24+)',
    },
    <String, String>{
      'name': 'color',
      'type': 'Color?',
      'desc': 'background fill color (default theme dependent)',
    },
    <String, String>{
      'name': 'shadowColor',
      'type': 'Color?',
      'desc': 'tint of the dropped shadow',
    },
    <String, String>{
      'name': 'surfaceTintColor',
      'type': 'Color?',
      'desc': 'M3 tint blended in by elevation overlay',
    },
    <String, String>{
      'name': 'textStyle',
      'type': 'TextStyle?',
      'desc': 'default text style for descendants',
    },
    <String, String>{
      'name': 'borderRadius',
      'type': 'BorderRadiusGeometry?',
      'desc': 'shortcut radius (only with canvas/button)',
    },
    <String, String>{
      'name': 'shape',
      'type': 'ShapeBorder?',
      'desc': 'full geometry override (incompatible w/ borderRadius)',
    },
    <String, String>{
      'name': 'borderOnForeground',
      'type': 'bool',
      'desc': 'paint border above or below the child (default true)',
    },
    <String, String>{
      'name': 'clipBehavior',
      'type': 'Clip',
      'desc': 'none, hardEdge, antiAlias, antiAliasWithSaveLayer',
    },
    <String, String>{
      'name': 'animationDuration',
      'type': 'Duration',
      'desc': 'how long color/elevation/shadow animate to new values',
    },
    <String, String>{
      'name': 'child',
      'type': 'Widget?',
      'desc': 'the contents painted on top of the surface',
    },
  ];

  final List<Widget> propRows = List<Widget>.generate(propEntries.length, (
    int i,
  ) {
    final Map<String, String> entry = propEntries[i];
    final bool odd = i.isOdd;
    final Color barColor = odd ? Colors.indigo : Colors.deepPurple;
    return Container(
      color: odd ? Colors.grey.shade50 : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 4.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: barColor,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(width: 12.0),
          SizedBox(
            width: 160.0,
            child: Text(
              entry['name']!,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: barColor,
              ),
            ),
          ),
          SizedBox(
            width: 160.0,
            child: Text(
              entry['type']!,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              entry['desc']!,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade800,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  });

  final Widget propsTable = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.0),
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.indigo,
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 10.0,
            ),
            child: Row(
              children: <Widget>[
                const SizedBox(width: 16.0),
                SizedBox(
                  width: 160.0,
                  child: Text(
                    'Property',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 160.0,
                  child: Text(
                    'Type',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...propRows,
        ],
      ),
    ),
  );

  // ==========================================================================
  // SECTION 12 — Code reference
  // ==========================================================================
  final Widget codeBlock = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: Colors.cyan.shade300, size: 18.0),
            const SizedBox(width: 8.0),
            Text(
              'Typical Material usage',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Material(\n'
            '  type: MaterialType.card,\n'
            '  elevation: 6,\n'
            '  color: Colors.white,\n'
            '  surfaceTintColor: Colors.indigo,\n'
            '  shadowColor: Colors.indigo,\n'
            '  shape: RoundedRectangleBorder(\n'
            '    borderRadius: BorderRadius.circular(16),\n'
            '    side: BorderSide(color: Colors.indigo, width: 1),\n'
            '  ),\n'
            '  clipBehavior: Clip.antiAlias,\n'
            '  animationDuration: Duration(milliseconds: 200),\n'
            '  textStyle: TextStyle(fontSize: 14),\n'
            '  child: InkWell(\n'
            '    onTap: () {},\n'
            '    child: Padding(\n'
            '      padding: EdgeInsets.all(16),\n'
            '      child: Text("Tap me"),\n'
            '    ),\n'
            '  ),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.45,
              color: Colors.green.shade300,
            ),
          ),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 13 — Summary
  // ==========================================================================
  final List<Map<String, dynamic>> summaryEntries = <Map<String, dynamic>>[
    <String, dynamic>{
      'icon': Icons.layers,
      'title': 'A physical surface',
      'desc': 'Material is the implicit canvas behind every Material widget.',
      'color': Colors.indigo,
    },
    <String, dynamic>{
      'icon': Icons.format_shapes,
      'title': 'Shape & radius',
      'desc': 'Use shape for full control, borderRadius for quick rounding.',
      'color': Colors.pink,
    },
    <String, dynamic>{
      'icon': Icons.opacity,
      'title': 'Tint & shadow',
      'desc': 'surfaceTintColor + shadowColor define the M3 elevation feel.',
      'color': Colors.teal,
    },
    <String, dynamic>{
      'icon': Icons.touch_app,
      'title': 'Ink lives here',
      'desc': 'InkWell, InkResponse and Ink reactions render onto Material.',
      'color': Colors.deepOrange,
    },
    <String, dynamic>{
      'icon': Icons.text_format,
      'title': 'Default textStyle',
      'desc': 'Material can set a default TextStyle for its subtree.',
      'color': Colors.deepPurple,
    },
  ];

  final List<Widget> summaryTiles = List<Widget>.generate(
    summaryEntries.length,
    (int i) {
      final Map<String, dynamic> entry = summaryEntries[i];
      final IconData icon = entry['icon'] as IconData;
      final String title = entry['title'] as String;
      final String desc = entry['desc'] as String;
      final Color color = entry['color'] as Color;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Material(
          elevation: 1.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          surfaceTintColor: color,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 42.0,
                  height: 42.0,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Icon(icon, color: color, size: 22.0),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        desc,
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  // A subtle radial decoration to round off the summary section.
  final Widget summaryWrapper = Container(
    margin: const EdgeInsets.only(top: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: <Color>[
          Colors.indigo.shade50,
          Colors.white,
        ],
        radius: 1.2,
        center: Alignment.topLeft,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.indigo.shade100, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: summaryTiles,
    ),
  );

  // ==========================================================================
  // SECTION 14 — A polar-coordinate "Material clock" using math (visual flair)
  // ==========================================================================
  // Twelve Material circles arranged around a center to celebrate the
  // composability of Material. Pure visuals — useful for verifying that
  // many Material instances render correctly inside D4rt.
  final List<Widget> clockNodes = List<Widget>.generate(12, (int i) {
    final double angle = (i / 12.0) * 2.0 * math.pi - math.pi / 2.0;
    final double dx = math.cos(angle) * 120.0;
    final double dy = math.sin(angle) * 120.0;
    final double hue = (i / 12.0) * 360.0;
    final Color tone = HSVColor.fromAHSV(1.0, hue, 0.55, 0.95).toColor();
    return Positioned(
      left: 150.0 + dx - 22.0,
      top: 150.0 + dy - 22.0,
      child: Material(
        type: MaterialType.circle,
        elevation: 4.0 + (i % 6).toDouble(),
        color: tone,
        shadowColor: tone,
        child: SizedBox(
          width: 44.0,
          height: 44.0,
          child: Center(
            child: Text(
              '${i + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
        ),
      ),
    );
  });

  final Widget clockBlock = Center(
    child: Container(
      width: 320.0,
      height: 320.0,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: <Color>[
            Colors.indigo.shade50,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: Colors.indigo.shade100, width: 1.5),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 100.0,
            top: 100.0,
            child: Material(
              type: MaterialType.circle,
              elevation: 12.0,
              color: Colors.indigo,
              shadowColor: Colors.indigo,
              child: const SizedBox(
                width: 100.0,
                height: 100.0,
                child: Center(
                  child: Icon(
                    Icons.layers_outlined,
                    color: Colors.white,
                    size: 44.0,
                  ),
                ),
              ),
            ),
          ),
          ...clockNodes,
        ],
      ),
    ),
  );

  // ==========================================================================
  // ASSEMBLY
  // ==========================================================================
  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          header,

          // Section 1 — MaterialType gallery
          sectionHeader(
            '01',
            'MaterialType gallery',
            'Five built-in surface archetypes and how they shape their child.',
            Icons.dashboard_customize_outlined,
            Colors.blue,
          ),
          narrative(
            'MaterialType decides how the surface clips and shadows: canvas '
            'is the default infinite surface, card adds a small radius, circle '
            'turns the surface into a disc, button is tuned for compact '
            'interactive surfaces, and transparency only renders ink — no '
            'background fill.',
            accent: Colors.blue,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: typeTiles,
          ),

          // Section 2 — Elevation
          sectionHeader(
            '02',
            'Elevation ladder',
            'The 0 → 24 dp ramp, with shadow-color variants at fixed elevation.',
            Icons.height,
            Colors.indigo,
          ),
          narrative(
            'Elevation controls both the visual shadow and (in M3) the '
            'surface-tint overlay. The ten canonical steps below are tuned '
            'to match common Material specs, while the shadow-color row '
            'shows how shadowColor recolors the dropped shadow without '
            'affecting the surface itself.',
            accent: Colors.indigo,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: elevationTiles,
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              'Shadow color variants at elevation = 12',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: shadowTiles,
          ),

          // Section 3 — Shapes
          sectionHeader(
            '03',
            'Shape gallery',
            'Rectangle, stadium, beveled and circle borders — with and without sides.',
            Icons.format_shapes,
            Colors.pink,
          ),
          narrative(
            'When shape is set, borderRadius MUST be null. Shapes can include '
            'a BorderSide, an asymmetric BorderRadius, or be fully custom. '
            'StadiumBorder pills, BeveledRectangleBorder mitres, and '
            'CircleBorder discs are all rendered from the same Material API.',
            accent: Colors.pink,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: shapeTiles,
          ),

          // Section 4 — Surface tint
          sectionHeader(
            '04',
            'Surface tint (Material 3)',
            'How elevation + surfaceTintColor combine into the M3 overlay.',
            Icons.gradient,
            Colors.teal,
          ),
          narrative(
            'In Material 3, surfaceTintColor is mixed with the surface color '
            'using an opacity derived from elevation. Higher elevations '
            'receive more tint. Set surfaceTintColor to transparent to '
            'opt out of the tinting overlay.',
            accent: Colors.teal,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: tintTiles,
          ),

          // Section 5 — borderRadius vs shape + clip + borderOnForeground
          sectionHeader(
            '05',
            'Shape, clip & borderOnForeground',
            'borderRadius vs shape, four Clip values, foreground vs background border.',
            Icons.crop_din,
            Colors.deepPurple,
          ),
          narrative(
            'borderRadius is a convenience for rounded rectangles only. shape '
            'is the powerful path — but the two are mutually exclusive. The '
            'clipBehavior controls how the child is clipped to the shape, '
            'and borderOnForeground decides whether the border paints above '
            'or below the child.',
            accent: Colors.deepPurple,
          ),
          radiusVsShape,
          const SizedBox(height: 18.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: clipTiles,
          ),
          const SizedBox(height: 18.0),
          borderForegroundDemo,

          // Section 6 — textStyle propagation
          sectionHeader(
            '06',
            'Default textStyle propagation',
            'How a Material can dictate the default text style of its subtree.',
            Icons.text_fields,
            Colors.orange,
          ),
          narrative(
            'Material exposes a textStyle parameter that sets the default '
            'DefaultTextStyle for its descendants. Each tile below sets a '
            'different textStyle and reuses the same Text widget — the '
            'rendered look depends entirely on the host Material.',
            accent: Colors.orange,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: textStyleTiles,
          ),

          // Section 7 — animationDuration
          sectionHeader(
            '07',
            'animationDuration',
            'How long color/elevation/shadow take to settle on the new value.',
            Icons.timer,
            Colors.deepPurple,
          ),
          narrative(
            'Material implicitly animates between elevations and colors. '
            'animationDuration controls how snappy or cinematic that '
            'transition feels. The default 200 ms is the M3 standard, but '
            'design systems often pin custom values.',
            accent: Colors.deepPurple,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: durationTiles,
          ),

          // Section 8 — Ink hosts
          sectionHeader(
            '08',
            'Ink hosts',
            'Material wraps every InkWell, every Ink — that is its job.',
            Icons.touch_app_outlined,
            Colors.cyan,
          ),
          narrative(
            'Ink reactions (splash, highlight, hover) live in the Material '
            'layer — every InkWell needs a Material ancestor. These tiles '
            'set splashColor and highlightColor and rely on Material to '
            'paint the resulting reaction within its clip region.',
            accent: Colors.cyan,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: inkHostTiles,
          ),

          // Section 9 — Real world compositions
          sectionHeader(
            '09',
            'Real-world compositions',
            'Profile card, chip row, FAB row and stat dashboard.',
            Icons.widgets_outlined,
            Colors.green,
          ),
          narrative(
            'Every classic Material UI element — card, chip, FAB, sheet, '
            'banner — bottoms out in a Material widget. Here are some '
            'small compositions assembled from nothing but Material + '
            'InkWell + Ink reactions.',
            accent: Colors.green,
          ),
          Center(child: profileCard),
          const SizedBox(height: 24.0),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0,
            runSpacing: 8.0,
            children: chipTiles,
          ),
          const SizedBox(height: 24.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: fabTiles,
          ),
          const SizedBox(height: 24.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: statTiles,
          ),

          // Section 10 — Combo matrix
          sectionHeader(
            '10',
            'Elevation × shape matrix',
            'Three elevations × four shapes — twelve combined surfaces.',
            Icons.grid_view,
            Colors.deepOrange,
          ),
          narrative(
            'Mixing elevation and shape is where Material design starts to '
            'feel three-dimensional. Each row holds a fixed elevation, each '
            'column a different shape; the hue rotates so that no two tiles '
            'compete for the eye.',
            accent: Colors.deepOrange,
          ),
          Column(
            children: matrixRows,
          ),

          // Section 11 — Properties table
          sectionHeader(
            '11',
            'Property reference',
            'Every constructor parameter of Material at a glance.',
            Icons.list_alt,
            Colors.brown,
          ),
          narrative(
            'A compact reference of the constructor signature. Each row '
            'shows the parameter name, its type, and the role it plays in '
            'the rendered surface.',
            accent: Colors.brown,
          ),
          propsTable,

          // Section 12 — Code
          sectionHeader(
            '12',
            'Code snippet',
            'Putting all the parameters together.',
            Icons.code,
            Colors.blueGrey,
          ),
          codeBlock,

          // Section 13 — Summary
          sectionHeader(
            '13',
            'Summary',
            'The five things to remember about Material.',
            Icons.flag_outlined,
            Colors.indigo,
          ),
          summaryWrapper,

          // Section 14 — Material clock visual flair
          sectionHeader(
            '14',
            'Material clock',
            'Twelve circular Material discs arranged with math.sin / math.cos.',
            Icons.access_time,
            Colors.purple,
          ),
          narrative(
            'A small visual flourish: twelve MaterialType.circle surfaces '
            'placed on a circle using polar coordinates. Each disc has its '
            'own elevation and hue — proof that many Material instances '
            'compose cleanly inside the D4rt interpreter.',
            accent: Colors.purple,
          ),
          clockBlock,
          const SizedBox(height: 32.0),

          // Footer.
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[
                  Color(0xFF1A237E),
                  Color(0xFF5E35B1),
                ],
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.verified_outlined,
                  color: Colors.white.withValues(alpha: 0.9),
                  size: 36.0,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Material — the surface beneath it all',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withValues(alpha: 0.95),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'D4rt visual demonstration · tom_d4rt_flutter_ast',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

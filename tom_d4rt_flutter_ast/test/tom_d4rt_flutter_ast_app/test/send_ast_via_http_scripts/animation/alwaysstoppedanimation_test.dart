// D4rt test script: Deep visual demo of AlwaysStoppedAnimation<T>
//
// AlwaysStoppedAnimation freezes a value of type T and exposes it through the
// Animation<T> interface. It never ticks, never notifies, never changes status
// (it is always AnimationStatus.forward), and therefore makes the perfect
// "constant" feeder for any widget that demands an Animation<T> parameter:
// FadeTransition, RotationTransition, SlideTransition, ScaleTransition,
// SizeTransition, DecoratedBoxTransition, PositionedTransition,
// RelativePositionedTransition, DefaultTextStyleTransition, AlignTransition,
// AnimatedBuilder, and so on.
//
// This demo walks through:
//   1. Conceptual cards (what / why / when)
//   2. Frozen double values at 0.00 / 0.25 / 0.50 / 0.75 / 1.00
//   3. Tween-driven frozen values (Tween.transform(t)) at common ratios
//   4. Generic type gallery: Color, Offset, Size, Alignment, double, int, ...
//   5. Transition gallery feeding AlwaysStoppedAnimation into every major
//      Transition widget Flutter ships
//   6. AnimatedBuilder with frozen animation as a builder driver
//   7. Comparative panel: frozen vs ticking animation contract
//   8. Summary key takeaways
//
// The script is interpreted by D4rt; no AnimationController is used because
// the entire point of AlwaysStoppedAnimation is the absence of a ticker.
import 'dart:math' as math;

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AlwaysStoppedAnimation Deep Demo - start');

  // ------------------------------------------------------------------
  // SECTION 1 - Concept cards: what is AlwaysStoppedAnimation?
  // ------------------------------------------------------------------
  print('=== Section 1: Concept cards ===');

  final conceptCards = <Widget>[];

  conceptCards.add(
    Container(
      width: 230.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.indigo.shade50,
            Colors.blue.shade50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.18),
            blurRadius: 10.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Icon(Icons.pause_circle_filled,
              size: 48.0, color: Colors.indigo.shade600),
          const SizedBox(height: 12.0),
          Text(
            'Frozen Animation',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'AlwaysStoppedAnimation<T>(value)\nholds a single value forever.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              height: 1.4,
              color: Colors.indigo.shade700,
            ),
          ),
        ],
      ),
    ),
  );

  conceptCards.add(
    Container(
      width: 230.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.teal.shade50,
            Colors.cyan.shade50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.18),
            blurRadius: 10.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Icon(Icons.tune, size: 48.0, color: Colors.teal.shade600),
          const SizedBox(height: 12.0),
          Text(
            'Status Always Forward',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'status == AnimationStatus.forward\nfor every value (even 0.0).',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              height: 1.4,
              color: Colors.teal.shade700,
            ),
          ),
        ],
      ),
    ),
  );

  conceptCards.add(
    Container(
      width: 230.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.orange.shade50,
            Colors.amber.shade50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.18),
            blurRadius: 10.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Icon(Icons.no_encryption_gmailerrorred,
              size: 48.0, color: Colors.orange.shade700),
          const SizedBox(height: 12.0),
          Text(
            'No Ticker Required',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'No AnimationController,\nno SingleTickerProviderStateMixin,\nno dispose().',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              height: 1.4,
              color: Colors.orange.shade700,
            ),
          ),
        ],
      ),
    ),
  );

  conceptCards.add(
    Container(
      width: 230.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.pink.shade50,
            Colors.purple.shade50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.pink.shade300, width: 2.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.pink.withValues(alpha: 0.18),
            blurRadius: 10.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Icon(Icons.category, size: 48.0, color: Colors.pink.shade600),
          const SizedBox(height: 12.0),
          Text(
            'Fully Generic',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade900,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Color, Offset, Size,\nAlignment, double, int,\nany T you want.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              height: 1.4,
              color: Colors.pink.shade700,
            ),
          ),
        ],
      ),
    ),
  );

  print('Created ${conceptCards.length} concept cards');

  // ------------------------------------------------------------------
  // SECTION 2 - The five canonical frozen values
  // ------------------------------------------------------------------
  print('=== Section 2: Canonical frozen values 0.0 / 0.25 / 0.5 / 0.75 / 1.0 ===');

  final canonicalValues = <double>[0.00, 0.25, 0.50, 0.75, 1.00];
  final canonicalLabels = <String>[
    'Start',
    'Quarter',
    'Halfway',
    'Three Quarters',
    'End',
  ];
  final canonicalColors = <MaterialColor>[
    Colors.blueGrey,
    Colors.lightBlue,
    Colors.teal,
    Colors.green,
    Colors.deepPurple,
  ];

  final canonicalAnimations = List<AlwaysStoppedAnimation<double>>.generate(
    canonicalValues.length,
    (int i) => AlwaysStoppedAnimation<double>(canonicalValues[i]),
  );

  for (int i = 0; i < canonicalAnimations.length; i++) {
    final AlwaysStoppedAnimation<double> a = canonicalAnimations[i];
    print('  canonical[$i] value=${a.value} status=${a.status.name}');
  }

  final canonicalTiles = List<Widget>.generate(canonicalValues.length, (int i) {
    final double value = canonicalValues[i];
    final String label = canonicalLabels[i];
    final MaterialColor color = canonicalColors[i];
    final AlwaysStoppedAnimation<double> anim = canonicalAnimations[i];

    return Container(
      width: 140.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: color.withValues(alpha: 0.5),
          width: 1.6,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 8.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: color.shade900,
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          // Frozen FadeTransition preview
          FadeTransition(
            opacity: anim,
            child: Container(
              width: 90.0,
              height: 60.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    color.withValues(alpha: 0.6),
                    color,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Center(
                child: Icon(
                  Icons.brightness_1,
                  color: Color(0xFFFFFFFF),
                  size: 22.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          // Numeric value label
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                color: color.withValues(alpha: 0.4),
                width: 1.0,
              ),
            ),
            child: Text(
              'value = ${value.toStringAsFixed(2)}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: color.shade900,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'status: ${anim.status.name}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  });

  // ------------------------------------------------------------------
  // SECTION 3 - Tween-driven frozen values (Tween.transform)
  // ------------------------------------------------------------------
  print('=== Section 3: Tween-driven frozen values ===');

  final fadeTween = Tween<double>(begin: 0.0, end: 1.0);
  final scaleTween = Tween<double>(begin: 0.5, end: 1.5);
  final colorTween = ColorTween(begin: Colors.red, end: Colors.blue);
  final offsetTween =
      Tween<Offset>(begin: const Offset(-1.0, 0.0), end: const Offset(1.0, 0.0));

  final tweenRatios = <double>[0.0, 0.2, 0.4, 0.6, 0.8, 1.0];

  for (final double t in tweenRatios) {
    final double fade = fadeTween.transform(t);
    final double scale = scaleTween.transform(t);
    final Color? c = colorTween.transform(t);
    final Offset o = offsetTween.transform(t);
    print('  t=${t.toStringAsFixed(2)} fade=$fade scale=$scale color=$c offset=$o');
  }

  final tweenTiles = List<Widget>.generate(tweenRatios.length, (int i) {
    final double t = tweenRatios[i];
    final double fade = fadeTween.transform(t);
    final double scale = scaleTween.transform(t);
    final Color colorAt = colorTween.transform(t) ?? Colors.grey;
    final Offset offsetAt = offsetTween.transform(t);

    final AlwaysStoppedAnimation<double> fadeAnim =
        AlwaysStoppedAnimation<double>(fade);
    final AlwaysStoppedAnimation<double> scaleAnim =
        AlwaysStoppedAnimation<double>(scale);

    return Container(
      width: 150.0,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              't = ${t.toStringAsFixed(1)}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          ScaleTransition(
            scale: scaleAnim,
            child: FadeTransition(
              opacity: fadeAnim,
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: colorAt,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: colorAt.withValues(alpha: 0.5),
                      blurRadius: 6.0,
                      offset: const Offset(0.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            'fade=${fade.toStringAsFixed(2)}',
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 10.0),
          ),
          Text(
            'scale=${scale.toStringAsFixed(2)}',
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 10.0),
          ),
          Text(
            'dx=${offsetAt.dx.toStringAsFixed(2)}',
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 10.0),
          ),
        ],
      ),
    );
  });

  // ------------------------------------------------------------------
  // SECTION 4 - Generic type gallery
  // ------------------------------------------------------------------
  print('=== Section 4: Generic type gallery ===');

  final doubleAnim = AlwaysStoppedAnimation<double>(0.66);
  final intAnim = AlwaysStoppedAnimation<int>(42);
  final stringAnim = AlwaysStoppedAnimation<String>('frozen');
  final colorAnim = AlwaysStoppedAnimation<Color>(Colors.deepPurple);
  final offsetAnim = AlwaysStoppedAnimation<Offset>(const Offset(0.3, -0.2));
  final sizeAnim = AlwaysStoppedAnimation<Size>(const Size(120.0, 80.0));
  final alignmentAnim =
      AlwaysStoppedAnimation<AlignmentGeometry>(Alignment.topRight);
  final boolAnim = AlwaysStoppedAnimation<bool>(true);
  final rectAnim = AlwaysStoppedAnimation<Rect>(
      const Rect.fromLTWH(10.0, 20.0, 100.0, 50.0));
  final radiusAnim = AlwaysStoppedAnimation<Radius>(const Radius.circular(16.0));
  final borderRadiusAnim = AlwaysStoppedAnimation<BorderRadius>(
      BorderRadius.circular(8.0));
  final textStyleAnim = AlwaysStoppedAnimation<TextStyle>(
    const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
  );

  print('  <double>=${doubleAnim.value} status=${doubleAnim.status.name}');
  print('  <int>=${intAnim.value} status=${intAnim.status.name}');
  print('  <String>=${stringAnim.value} status=${stringAnim.status.name}');
  print('  <Color>=${colorAnim.value}');
  print('  <Offset>=${offsetAnim.value}');
  print('  <Size>=${sizeAnim.value}');
  print('  <AlignmentGeometry>=${alignmentAnim.value}');
  print('  <bool>=${boolAnim.value}');
  print('  <Rect>=${rectAnim.value}');
  print('  <Radius>=${radiusAnim.value}');
  print('  <BorderRadius>=${borderRadiusAnim.value}');
  print('  <TextStyle>=${textStyleAnim.value}');

  final genericRows = <Map<String, dynamic>>[
    <String, dynamic>{
      'type': 'double',
      'display': doubleAnim.value.toStringAsFixed(2),
      'icon': Icons.functions,
      'color': Colors.blue,
    },
    <String, dynamic>{
      'type': 'int',
      'display': intAnim.value.toString(),
      'icon': Icons.tag,
      'color': Colors.green,
    },
    <String, dynamic>{
      'type': 'String',
      'display': '"${stringAnim.value}"',
      'icon': Icons.text_fields,
      'color': Colors.purple,
    },
    <String, dynamic>{
      'type': 'Color',
      'display': '#${(colorAnim.value.toARGB32()).toRadixString(16).padLeft(8, '0').toUpperCase()}',
      'icon': Icons.palette,
      'color': Colors.deepPurple,
    },
    <String, dynamic>{
      'type': 'Offset',
      'display':
          '(${offsetAnim.value.dx.toStringAsFixed(1)}, ${offsetAnim.value.dy.toStringAsFixed(1)})',
      'icon': Icons.control_point,
      'color': Colors.orange,
    },
    <String, dynamic>{
      'type': 'Size',
      'display':
          '${sizeAnim.value.width.toStringAsFixed(0)} x ${sizeAnim.value.height.toStringAsFixed(0)}',
      'icon': Icons.aspect_ratio,
      'color': Colors.teal,
    },
    <String, dynamic>{
      'type': 'AlignmentGeometry',
      'display': alignmentAnim.value.toString().split('.').last,
      'icon': Icons.format_align_center,
      'color': Colors.indigo,
    },
    <String, dynamic>{
      'type': 'bool',
      'display': boolAnim.value.toString(),
      'icon': Icons.check_box,
      'color': Colors.lightGreen,
    },
    <String, dynamic>{
      'type': 'Rect',
      'display':
          '${rectAnim.value.width.toStringAsFixed(0)} x ${rectAnim.value.height.toStringAsFixed(0)}',
      'icon': Icons.crop_square,
      'color': Colors.brown,
    },
    <String, dynamic>{
      'type': 'Radius',
      'display': radiusAnim.value.x.toStringAsFixed(0),
      'icon': Icons.rounded_corner,
      'color': Colors.pink,
    },
    <String, dynamic>{
      'type': 'BorderRadius',
      'display': '8px',
      'icon': Icons.crop_din,
      'color': Colors.cyan,
    },
    <String, dynamic>{
      'type': 'TextStyle',
      'display': 'fs=14 bold',
      'icon': Icons.format_size,
      'color': Colors.deepOrange,
    },
  ];

  final genericTiles = List<Widget>.generate(genericRows.length, (int i) {
    final Map<String, dynamic> row = genericRows[i];
    final Color color = row['color'] as Color;
    final IconData icon = row['icon'] as IconData;
    final String type = row['type'] as String;
    final String display = row['display'] as String;

    return Container(
      width: 130.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.4),
      ),
      child: Column(
        children: <Widget>[
          Icon(icon, color: color, size: 30.0),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              '<$type>',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            display,
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
  });

  // ------------------------------------------------------------------
  // SECTION 5 - Transition gallery (the big visual section)
  // ------------------------------------------------------------------
  print('=== Section 5: Transition gallery ===');

  // 5a. FadeTransition cascade
  final fadeOpacities = <double>[0.10, 0.30, 0.50, 0.70, 0.90, 1.00];
  final fadeTiles = List<Widget>.generate(fadeOpacities.length, (int i) {
    final double op = fadeOpacities[i];
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: Column(
        children: <Widget>[
          FadeTransition(
            opacity: AlwaysStoppedAnimation<double>(op),
            child: Container(
              width: 70.0,
              height: 70.0,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  op.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'opacity=${op.toStringAsFixed(2)}',
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 10.0),
          ),
        ],
      ),
    );
  });

  // 5b. RotationTransition cascade
  final rotationTurns = <double>[0.000, 0.125, 0.250, 0.375, 0.500, 0.750];
  final rotationTiles = List<Widget>.generate(rotationTurns.length, (int i) {
    final double turns = rotationTurns[i];
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation<double>(turns),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[
                      Color(0xFFE91E63),
                      Color(0xFFFF80AB),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(
                  child: Icon(
                    Icons.navigation,
                    color: Color(0xFFFFFFFF),
                    size: 36.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'turns=${turns.toStringAsFixed(3)}',
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 10.0),
          ),
          Text(
            '${(turns * 360.0).toStringAsFixed(0)}°',
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 10.0),
          ),
        ],
      ),
    );
  });

  // 5c. ScaleTransition cascade
  final scaleFactors = <double>[0.25, 0.50, 0.75, 1.00, 1.25, 1.50];
  final scaleTiles = List<Widget>.generate(scaleFactors.length, (int i) {
    final double s = scaleFactors[i];
    return Container(
      margin: const EdgeInsets.all(6.0),
      width: 100.0,
      height: 110.0,
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Center(
              child: ScaleTransition(
                scale: AlwaysStoppedAnimation<double>(s),
                child: Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.green.withValues(alpha: 0.4),
                        blurRadius: 4.0,
                        offset: const Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'scale=${s.toStringAsFixed(2)}',
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 10.0),
          ),
        ],
      ),
    );
  });

  // 5d. SlideTransition cascade
  final slideOffsets = <Offset>[
    const Offset(-0.5, 0.0),
    const Offset(-0.25, 0.0),
    const Offset(0.0, 0.0),
    const Offset(0.25, 0.0),
    const Offset(0.5, 0.0),
    const Offset(0.0, -0.5),
  ];
  final slideTiles = List<Widget>.generate(slideOffsets.length, (int i) {
    final Offset offset = slideOffsets[i];
    return Container(
      margin: const EdgeInsets.all(6.0),
      width: 110.0,
      height: 110.0,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Center(
              child: SlideTransition(
                position: AlwaysStoppedAnimation<Offset>(offset),
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: <Color>[
                        Color(0xFF9C27B0),
                        Color(0xFFCE93D8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
            ),
          ),
          Text(
            '(${offset.dx.toStringAsFixed(2)}, ${offset.dy.toStringAsFixed(2)})',
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 9.0),
          ),
        ],
      ),
    );
  });

  // 5e. SizeTransition cascade
  final sizeFactors = <double>[0.20, 0.40, 0.60, 0.80, 1.00];
  final sizeTiles = List<Widget>.generate(sizeFactors.length, (int i) {
    final double f = sizeFactors[i];
    return Container(
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
            color: Colors.amber.withValues(alpha: 0.4), width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 120.0,
            height: 60.0,
            child: SizeTransition(
              sizeFactor: AlwaysStoppedAnimation<double>(f),
              axis: Axis.horizontal,
              child: Container(
                color: Colors.amber.shade600,
                child: const Center(
                  child: Text(
                    'SIZE',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'sizeFactor=${f.toStringAsFixed(2)}',
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 10.0),
          ),
        ],
      ),
    );
  });

  // 5f. AlignTransition cascade
  final alignments = <Alignment>[
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.center,
    Alignment.bottomLeft,
    Alignment.bottomRight,
  ];
  final alignmentLabels = <String>[
    'topLeft',
    'topRight',
    'center',
    'bottomLeft',
    'bottomRight',
  ];
  final alignTiles = List<Widget>.generate(alignments.length, (int i) {
    final Alignment a = alignments[i];
    final String label = alignmentLabels[i];
    return Container(
      width: 120.0,
      height: 130.0,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 110.0,
            height: 90.0,
            child: AlignTransition(
              alignment: AlwaysStoppedAnimation<AlignmentGeometry>(a),
              child: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: Colors.deepOrange.shade400,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
          Text(
            label,
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 10.0),
          ),
        ],
      ),
    );
  });

  // 5g. DecoratedBoxTransition - alternates between two decorations using
  // AlwaysStoppedAnimation as the t-value.
  final decoratedTValues = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final decorationStart = BoxDecoration(
    color: Colors.lightBlue.shade300,
    borderRadius: BorderRadius.circular(4.0),
    border: Border.all(color: Colors.lightBlue.shade700, width: 1.0),
  );
  final decorationEnd = BoxDecoration(
    color: Colors.deepPurple.shade400,
    borderRadius: BorderRadius.circular(28.0),
    border: Border.all(color: Colors.deepPurple.shade900, width: 4.0),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.deepPurple.withValues(alpha: 0.5),
        blurRadius: 8.0,
        offset: const Offset(0.0, 4.0),
      ),
    ],
  );
  final decorationTween = DecorationTween(
    begin: decorationStart,
    end: decorationEnd,
  );
  final decoratedTiles = List<Widget>.generate(decoratedTValues.length, (int i) {
    final double t = decoratedTValues[i];
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: DecoratedBoxTransition(
              decoration: decorationTween.animate(
                AlwaysStoppedAnimation<double>(t),
              ),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            't=${t.toStringAsFixed(2)}',
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 10.0),
          ),
        ],
      ),
    );
  });

  // 5h. PositionedTransition (uses RelativeRect inside a Stack)
  final positionedT = <double>[0.0, 0.33, 0.66, 1.0];
  final relativeRectTween = RelativeRectTween(
    begin: const RelativeRect.fromLTRB(0.0, 0.0, 100.0, 100.0),
    end: const RelativeRect.fromLTRB(80.0, 80.0, 20.0, 20.0),
  );
  final positionedTiles = List<Widget>.generate(positionedT.length, (int i) {
    final double t = positionedT[i];
    return Container(
      margin: const EdgeInsets.all(6.0),
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.cyan.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.cyan.shade400, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 130.0,
            height: 120.0,
            child: Stack(
              children: <Widget>[
                PositionedTransition(
                  rect: relativeRectTween.animate(
                    AlwaysStoppedAnimation<double>(t),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyan.shade500,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            't=${t.toStringAsFixed(2)}',
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 10.0),
          ),
        ],
      ),
    );
  });

  // 5i. DefaultTextStyleTransition
  final textStyleTween = TextStyleTween(
    begin: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: Color(0xFF1565C0),
    ),
    end: const TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: Color(0xFFD32F2F),
    ),
  );
  final textStyleT = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final textStyleTiles = List<Widget>.generate(textStyleT.length, (int i) {
    final double t = textStyleT[i];
    return Container(
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(10.0),
      width: 130.0,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          DefaultTextStyleTransition(
            style: textStyleTween.animate(
              AlwaysStoppedAnimation<double>(t),
            ),
            child: const Text('Frozen Text'),
          ),
          const SizedBox(height: 6.0),
          Text(
            't=${t.toStringAsFixed(2)}',
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 9.0),
          ),
        ],
      ),
    );
  });

  // 5j. RelativePositionedTransition - uses Animation<Rect?>
  final rectTween2 = RectTween(
    begin: const Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
    end: const Rect.fromLTWH(60.0, 60.0, 50.0, 50.0),
  );
  final relativeT = <double>[0.0, 0.5, 1.0];
  final relativeTiles = List<Widget>.generate(relativeT.length, (int i) {
    final double t = relativeT[i];
    return Container(
      margin: const EdgeInsets.all(6.0),
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.lime.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.lime.shade400, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 130.0,
            height: 120.0,
            child: Stack(
              children: <Widget>[
                RelativePositionedTransition(
                  size: const Size(130.0, 120.0),
                  rect: rectTween2.animate(
                    AlwaysStoppedAnimation<double>(t),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lime.shade700,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            't=${t.toStringAsFixed(2)}',
            style: const TextStyle(
                fontFamily: 'monospace', fontSize: 10.0),
          ),
        ],
      ),
    );
  });

  // ------------------------------------------------------------------
  // SECTION 6 - AnimatedBuilder with a frozen driver
  // ------------------------------------------------------------------
  print('=== Section 6: AnimatedBuilder driven by frozen Animation ===');

  final builderValues = <double>[0.0, 0.2, 0.4, 0.6, 0.8, 1.0];
  final builderTiles = List<Widget>.generate(builderValues.length, (int i) {
    final double v = builderValues[i];
    final AlwaysStoppedAnimation<double> driver =
        AlwaysStoppedAnimation<double>(v);
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: AnimatedBuilder(
        animation: driver,
        builder: (BuildContext _, Widget? __) {
          final double t = driver.value;
          final double angle = t * math.pi * 2.0;
          return Column(
            children: <Widget>[
              Transform.rotate(
                angle: angle,
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color.lerp(
                          Colors.red,
                          Colors.blue,
                          t,
                        ) ??
                        Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4.0,
                        offset: const Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.star,
                      color: Color(0xFFFFFFFF),
                      size: 22.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'driver=${t.toStringAsFixed(1)}',
                style: const TextStyle(
                    fontFamily: 'monospace', fontSize: 10.0),
              ),
            ],
          );
        },
      ),
    );
  });

  // ------------------------------------------------------------------
  // SECTION 7 - Contract comparison: frozen vs ticking
  // ------------------------------------------------------------------
  print('=== Section 7: Contract comparison ===');

  final contractRows = <Map<String, dynamic>>[
    <String, dynamic>{
      'property': 'value',
      'frozen': 'Always the constructor argument',
      'ticking': 'Changes each frame',
    },
    <String, dynamic>{
      'property': 'status',
      'frozen': 'AnimationStatus.forward',
      'ticking': 'forward / reverse / dismissed / completed',
    },
    <String, dynamic>{
      'property': 'addListener',
      'frozen': 'No-op (listener never called)',
      'ticking': 'Called every frame the value changes',
    },
    <String, dynamic>{
      'property': 'addStatusListener',
      'frozen': 'No-op (status never changes)',
      'ticking': 'Called on status transitions',
    },
    <String, dynamic>{
      'property': 'Ticker required',
      'frozen': 'No',
      'ticking': 'Yes (TickerProvider)',
    },
    <String, dynamic>{
      'property': 'dispose() required',
      'frozen': 'No',
      'ticking': 'Yes (AnimationController.dispose)',
    },
    <String, dynamic>{
      'property': 'use case',
      'frozen': 'Static preview, default value, tests',
      'ticking': 'Live UI animation',
    },
  ];

  final contractWidgets = List<Widget>.generate(contractRows.length, (int i) {
    final Map<String, dynamic> r = contractRows[i];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: i.isEven
            ? const Color(0xFFFAFAFA)
            : const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(
              r['property'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              margin: const EdgeInsets.only(right: 6.0),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                r['frozen'] as String,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.indigo.shade900,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                r['ticking'] as String,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.orange.shade900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  });

  // ------------------------------------------------------------------
  // SECTION 8 - Code samples
  // ------------------------------------------------------------------
  print('=== Section 8: Code samples ===');

  final codePanel = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            const SizedBox(width: 8.0),
            Text(
              'Usage patterns',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            "// 1. Default opacity for a FadeTransition without a controller\n"
            "FadeTransition(\n"
            "  opacity: const AlwaysStoppedAnimation<double>(0.5),\n"
            "  child: Image.asset('preview.png'),\n"
            ");\n"
            "\n"
            "// 2. Static rotation\n"
            "RotationTransition(\n"
            "  turns: const AlwaysStoppedAnimation<double>(0.125),\n"
            "  child: Icon(Icons.navigation),\n"
            ");",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            "// 3. Feed a Tween at a specific t-value\n"
            "final tween = ColorTween(begin: Colors.red, end: Colors.blue);\n"
            "final frozen = tween.animate(AlwaysStoppedAnimation<double>(0.7));\n"
            "\n"
            "// 4. Generic types\n"
            "AlwaysStoppedAnimation<Offset>(Offset(10.0, 20.0));\n"
            "AlwaysStoppedAnimation<Size>(Size(120.0, 60.0));\n"
            "AlwaysStoppedAnimation<AlignmentGeometry>(Alignment.topRight);",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purple.shade200,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            "// 5. Listeners are no-ops\n"
            "final a = AlwaysStoppedAnimation<double>(0.0);\n"
            "a.addListener(() => print('never called'));\n"
            "a.addStatusListener((s) => print('never called'));\n"
            "print(a.status); // AnimationStatus.forward",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.amber.shade200,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ------------------------------------------------------------------
  // SECTION 9 - Summary panel
  // ------------------------------------------------------------------
  print('=== Section 9: Summary ===');

  final summaryEntries = <Map<String, dynamic>>[
    <String, dynamic>{
      'icon': Icons.lock,
      'title': 'Immutable',
      'desc': 'The frozen value cannot change for the lifetime of the object.',
      'color': Colors.indigo,
    },
    <String, dynamic>{
      'icon': Icons.bolt,
      'title': 'Zero overhead',
      'desc': 'No controller, no ticker, no listener bookkeeping.',
      'color': Colors.amber,
    },
    <String, dynamic>{
      'icon': Icons.widgets,
      'title': 'Drop-in driver',
      'desc': 'Works with every widget expecting Animation<T>.',
      'color': Colors.teal,
    },
    <String, dynamic>{
      'icon': Icons.category,
      'title': 'Generic',
      'desc': 'Parametrised on any type T (double, Color, Offset, ...).',
      'color': Colors.pink,
    },
    <String, dynamic>{
      'icon': Icons.science,
      'title': 'Testable',
      'desc': 'Ideal for golden tests and storybook style previews.',
      'color': Colors.green,
    },
    <String, dynamic>{
      'icon': Icons.history_toggle_off,
      'title': 'Static status',
      'desc': 'status is always AnimationStatus.forward; never changes.',
      'color': Colors.deepPurple,
    },
  ];

  final summaryTiles = List<Widget>.generate(summaryEntries.length, (int i) {
    final Map<String, dynamic> entry = summaryEntries[i];
    final Color color = entry['color'] as Color;
    return Container(
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      width: 220.0,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: color.withValues(alpha: 0.5),
          width: 1.4,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(
              entry['icon'] as IconData,
              color: color,
              size: 22.0,
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  entry['desc'] as String,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Colors.grey.shade800,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  });

  // ------------------------------------------------------------------
  // SECTION 10 - Listener no-op proof
  // ------------------------------------------------------------------
  print('=== Section 10: Listener no-op proof ===');

  final proofAnim = AlwaysStoppedAnimation<double>(0.5);
  int valueListenerCalls = 0;
  int statusListenerCalls = 0;

  void valueListener() {
    valueListenerCalls++;
  }

  void statusListenerCb(AnimationStatus s) {
    statusListenerCalls++;
  }

  proofAnim.addListener(valueListener);
  proofAnim.addStatusListener(statusListenerCb);
  print('  After addListener+addStatusListener:'
      ' value=$valueListenerCalls status=$statusListenerCalls');

  // Querying the value/status does not trigger listeners.
  final double snapshot = proofAnim.value;
  final AnimationStatus statusSnapshot = proofAnim.status;
  print('  Snapshot value=$snapshot status=${statusSnapshot.name}');

  proofAnim.removeListener(valueListener);
  proofAnim.removeStatusListener(statusListenerCb);
  print('  After remove*: value=$valueListenerCalls status=$statusListenerCalls');

  final proofWidget = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.green.shade50,
          Colors.lightGreen.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.green.shade400, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.fact_check, color: Colors.green.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              'Listeners are never invoked',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.green.shade200, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'value listener calls: $valueListenerCalls',
                style: const TextStyle(
                    fontFamily: 'monospace', fontSize: 12.0),
              ),
              Text(
                'status listener calls: $statusListenerCalls',
                style: const TextStyle(
                    fontFamily: 'monospace', fontSize: 12.0),
              ),
              Text(
                'value snapshot: ${snapshot.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontFamily: 'monospace', fontSize: 12.0),
              ),
              Text(
                'status snapshot: ${statusSnapshot.name}',
                style: const TextStyle(
                    fontFamily: 'monospace', fontSize: 12.0),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ------------------------------------------------------------------
  // SECTION 11 - Cross-product mosaic: scale x opacity
  // ------------------------------------------------------------------
  print('=== Section 11: Cross-product mosaic ===');

  final mosaicScales = <double>[0.6, 0.8, 1.0, 1.2];
  final mosaicOpacities = <double>[0.25, 0.50, 0.75, 1.00];

  final mosaicRows = List<Widget>.generate(mosaicScales.length, (int row) {
    final double scaleVal = mosaicScales[row];
    final cells = List<Widget>.generate(mosaicOpacities.length, (int col) {
      final double opVal = mosaicOpacities[col];
      return Container(
        margin: const EdgeInsets.all(6.0),
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
        ),
        child: Center(
          child: ScaleTransition(
            scale: AlwaysStoppedAnimation<double>(scaleVal),
            child: FadeTransition(
              opacity: AlwaysStoppedAnimation<double>(opVal),
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[
                      Color(0xFFFF7043),
                      Color(0xFFFFAB91),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    'S${scaleVal.toStringAsFixed(1)}\nO${opVal.toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 9.0,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: cells,
    );
  });

  // ------------------------------------------------------------------
  // SECTION 12 - Identity table: status / value / runtime type
  // ------------------------------------------------------------------
  print('=== Section 12: Identity table ===');

  final identityAnims = <Animation<dynamic>>[
    AlwaysStoppedAnimation<double>(0.0),
    AlwaysStoppedAnimation<double>(0.5),
    AlwaysStoppedAnimation<double>(1.0),
    AlwaysStoppedAnimation<int>(7),
    AlwaysStoppedAnimation<Color>(Colors.cyan),
    AlwaysStoppedAnimation<Offset>(const Offset(2.5, 3.5)),
    AlwaysStoppedAnimation<String>('locked'),
    AlwaysStoppedAnimation<bool>(false),
  ];

  final identityRows = List<Widget>.generate(identityAnims.length, (int i) {
    final Animation<dynamic> a = identityAnims[i];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: i.isEven
            ? const Color(0xFFFAFAFA)
            : const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 28.0,
            child: Text(
              '#${i + 1}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              a.runtimeType.toString(),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              a.value.toString(),
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.indigo.shade900,
              ),
            ),
          ),
          SizedBox(
            width: 80.0,
            child: Text(
              a.status.name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.orange.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  });

  // ------------------------------------------------------------------
  // SECTION 13 - kAlwaysCompleteAnimation / kAlwaysDismissedAnimation
  // ------------------------------------------------------------------
  print('=== Section 13: Constant siblings ===');

  final completeAnim = kAlwaysCompleteAnimation;
  final dismissedAnim = kAlwaysDismissedAnimation;

  print('  kAlwaysCompleteAnimation value=${completeAnim.value}'
      ' status=${completeAnim.status.name}');
  print('  kAlwaysDismissedAnimation value=${dismissedAnim.value}'
      ' status=${dismissedAnim.status.name}');

  final siblingsRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Container(
        width: 240.0,
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.green.shade400, width: 1.4),
        ),
        child: Column(
          children: <Widget>[
            Icon(Icons.done_all, color: Colors.green.shade700, size: 36.0),
            const SizedBox(height: 6.0),
            Text(
              'kAlwaysCompleteAnimation',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.green.shade900,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'value=${completeAnim.value}\nstatus=${completeAnim.status.name}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
              ),
            ),
          ],
        ),
      ),
      Container(
        width: 240.0,
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.red.shade400, width: 1.4),
        ),
        child: Column(
          children: <Widget>[
            Icon(Icons.remove_circle, color: Colors.red.shade700, size: 36.0),
            const SizedBox(height: 6.0),
            Text(
              'kAlwaysDismissedAnimation',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.red.shade900,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'value=${dismissedAnim.value}\nstatus=${dismissedAnim.status.name}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  print('AlwaysStoppedAnimation Deep Demo - assembling scaffold');

  // ------------------------------------------------------------------
  // Build the final scaffold
  // ------------------------------------------------------------------
  return Scaffold(
    backgroundColor: const Color(0xFFF7F8FB),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[
                  Color(0xFF1A237E),
                  Color(0xFF3949AB),
                  Color(0xFF5C6BC0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.indigo.withValues(alpha: 0.35),
                  blurRadius: 14.0,
                  offset: const Offset(0.0, 6.0),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                const Icon(
                  Icons.pause_circle_outline,
                  size: 56.0,
                  color: Color(0xFFFFFFFF),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'AlwaysStoppedAnimation<T>',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'A constant Animation<T> for widgets that demand an animation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white.withValues(alpha: 0.92),
                  ),
                ),
                const SizedBox(height: 14.0),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: <Widget>[
                    _headerChip('animation'),
                    _headerChip('frozen'),
                    _headerChip('generic'),
                    _headerChip('no controller'),
                    _headerChip('AnimationStatus.forward'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // Section 1
          _sectionTitle('1. What is AlwaysStoppedAnimation?'),
          const SizedBox(height: 6.0),
          _sectionBlurb(
            'A subclass of Animation<T> that ignores time, never notifies '
            'listeners and always reports AnimationStatus.forward. Use it to '
            'supply a constant value to any widget that expects an animation.',
          ),
          const SizedBox(height: 12.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: conceptCards,
          ),
          const SizedBox(height: 28.0),

          // Section 2
          _sectionTitle('2. Canonical frozen values'),
          const SizedBox(height: 6.0),
          _sectionBlurb(
            'Five evenly-spaced frozen opacities feeding FadeTransition. '
            'The status column proves all of them are AnimationStatus.forward.',
          ),
          const SizedBox(height: 12.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: canonicalTiles,
          ),
          const SizedBox(height: 28.0),

          // Section 3
          _sectionTitle('3. Tween-driven frozen samples'),
          const SizedBox(height: 6.0),
          _sectionBlurb(
            'Tween.transform(t) gives the value the tween would produce at '
            'progress t. Wrapping that result in AlwaysStoppedAnimation '
            'freezes the tween at that exact frame.',
          ),
          const SizedBox(height: 12.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: tweenTiles,
          ),
          const SizedBox(height: 28.0),

          // Section 4
          _sectionTitle('4. Generic type gallery'),
          const SizedBox(height: 6.0),
          _sectionBlurb(
            'AlwaysStoppedAnimation<T> is parameterised on T. Below are '
            'twelve specialisations, from primitives to compound types.',
          ),
          const SizedBox(height: 12.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: genericTiles,
          ),
          const SizedBox(height: 28.0),

          // Section 5 - Transition gallery
          _sectionTitle('5. Transition gallery'),
          const SizedBox(height: 6.0),
          _sectionBlurb(
            'Every major transition widget in Flutter accepts an Animation<T>. '
            'Feeding it AlwaysStoppedAnimation freezes that transition at a '
            'precise stop.',
          ),
          const SizedBox(height: 16.0),

          _subSectionTitle('5a. FadeTransition'),
          const SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: fadeTiles,
          ),
          const SizedBox(height: 20.0),

          _subSectionTitle('5b. RotationTransition'),
          const SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: rotationTiles,
          ),
          const SizedBox(height: 20.0),

          _subSectionTitle('5c. ScaleTransition'),
          const SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: scaleTiles,
          ),
          const SizedBox(height: 20.0),

          _subSectionTitle('5d. SlideTransition'),
          const SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: slideTiles,
          ),
          const SizedBox(height: 20.0),

          _subSectionTitle('5e. SizeTransition'),
          const SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: sizeTiles,
          ),
          const SizedBox(height: 20.0),

          _subSectionTitle('5f. AlignTransition'),
          const SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: alignTiles,
          ),
          const SizedBox(height: 20.0),

          _subSectionTitle('5g. DecoratedBoxTransition'),
          const SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: decoratedTiles,
          ),
          const SizedBox(height: 20.0),

          _subSectionTitle('5h. PositionedTransition'),
          const SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: positionedTiles,
          ),
          const SizedBox(height: 20.0),

          _subSectionTitle('5i. DefaultTextStyleTransition'),
          const SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: textStyleTiles,
          ),
          const SizedBox(height: 20.0),

          _subSectionTitle('5j. RelativePositionedTransition'),
          const SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: relativeTiles,
          ),
          const SizedBox(height: 28.0),

          // Section 6 - AnimatedBuilder
          _sectionTitle('6. AnimatedBuilder with frozen driver'),
          const SizedBox(height: 6.0),
          _sectionBlurb(
            'AnimatedBuilder rebuilds whenever its animation notifies. With '
            'AlwaysStoppedAnimation it is built exactly once and never again.',
          ),
          const SizedBox(height: 12.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: builderTiles,
          ),
          const SizedBox(height: 28.0),

          // Section 7 - Contract
          _sectionTitle('7. Frozen vs ticking contract'),
          const SizedBox(height: 6.0),
          _sectionBlurb(
            'Side-by-side: which guarantees apply only to frozen animations, '
            'and which to live AnimationController-driven ones.',
          ),
          const SizedBox(height: 8.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 130.0,
                      child: Text(
                        'property',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 6.0),
                        margin: const EdgeInsets.only(right: 6.0),
                        decoration: BoxDecoration(
                          color: Colors.indigo.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'AlwaysStoppedAnimation',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Colors.indigo.shade900,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'AnimationController',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Colors.orange.shade900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                ...contractWidgets,
              ],
            ),
          ),
          const SizedBox(height: 28.0),

          // Section 8 - Code panel
          _sectionTitle('8. Code samples'),
          const SizedBox(height: 6.0),
          _sectionBlurb(
            'Idiomatic usage patterns drawn from the Flutter framework itself.',
          ),
          codePanel,
          const SizedBox(height: 24.0),

          // Section 9 - Summary tiles
          _sectionTitle('9. Key takeaways'),
          const SizedBox(height: 12.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: summaryTiles,
          ),
          const SizedBox(height: 28.0),

          // Section 10 - Proof
          _sectionTitle('10. Listener no-op proof'),
          const SizedBox(height: 6.0),
          _sectionBlurb(
            'Adding listeners to a frozen animation is legal but completely '
            'meaningless: the framework guarantees the value never changes, '
            'so neither value nor status listeners are ever invoked.',
          ),
          proofWidget,
          const SizedBox(height: 28.0),

          // Section 11 - Mosaic
          _sectionTitle('11. Scale x Opacity mosaic'),
          const SizedBox(height: 6.0),
          _sectionBlurb(
            'A 4x4 grid composing ScaleTransition over FadeTransition. Each '
            'cell is driven by two AlwaysStoppedAnimation instances.',
          ),
          const SizedBox(height: 10.0),
          Column(
            children: mosaicRows,
          ),
          const SizedBox(height: 28.0),

          // Section 12 - Identity table
          _sectionTitle('12. Identity table'),
          const SizedBox(height: 6.0),
          _sectionBlurb(
            'Each row shows runtimeType, value and status for an '
            'AlwaysStoppedAnimation of a specific generic argument. Notice '
            'how status is always forward, regardless of the value.',
          ),
          const SizedBox(height: 8.0),
          Column(
            children: identityRows,
          ),
          const SizedBox(height: 28.0),

          // Section 13 - Constant siblings
          _sectionTitle('13. Constant siblings'),
          const SizedBox(height: 6.0),
          _sectionBlurb(
            'Flutter ships two pre-made AlwaysStoppedAnimation<double> '
            'constants for the most common frozen states.',
          ),
          const SizedBox(height: 10.0),
          siblingsRow,
          const SizedBox(height: 32.0),

          // Footer
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: Colors.indigo.shade900,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Column(
              children: <Widget>[
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFFFFFFFF),
                  size: 32.0,
                ),
                const SizedBox(height: 6.0),
                const Text(
                  'AlwaysStoppedAnimation: the simplest Animation<T> there is.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Use it whenever you need a static Animation<T> and nothing more.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _headerChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.35),
        width: 1.0,
      ),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _sectionTitle(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(color: Colors.indigo.shade700, width: 4.0),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

Widget _subSectionTitle(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    margin: const EdgeInsets.symmetric(horizontal: 6.0),
    decoration: BoxDecoration(
      color: Colors.indigo.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        color: Colors.indigo.shade800,
      ),
    ),
  );
}

Widget _sectionBlurb(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12.5,
        height: 1.45,
        color: Colors.grey.shade800,
      ),
    ),
  );
}

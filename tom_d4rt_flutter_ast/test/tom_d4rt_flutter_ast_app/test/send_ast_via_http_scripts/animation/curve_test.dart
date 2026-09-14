// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Curve and Curves from animation
// Deep Demo: Visual gallery of Flutter animation curves
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Curve Deep Demo executing');

  // ============================================================
  // SECTION 1: Curve Concept Cards
  // ============================================================
  print('=== Section 1: What is a Curve? ===');

  final conceptCards = <Widget>[];

  // Concept 1: What is a Curve
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.show_chart, size: 48.0, color: Colors.indigo),
          SizedBox(height: 12.0),
          Text(
            'Curve',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'A mapping of t in [0,1]\nto a value via transform(t)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 2: Curves library
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.collections, size: 48.0, color: Colors.teal),
          SizedBox(height: 12.0),
          Text(
            'Curves',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Pre-built library:\nlinear, easeIn, bounce,\nelastic, fastOutSlowIn...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.teal.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 3: Transform function
  conceptCards.add(
    Container(
      width: 220.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade50, Colors.orange.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.functions, size: 48.0, color: Colors.orange),
          SizedBox(height: 12.0),
          Text(
            'transform(t)',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Endpoints fixed:\nf(0)=0 and f(1)=1\nfor canonical curves',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.orange.shade700),
          ),
        ],
      ),
    ),
  );

  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Curve Graph Gallery
  // ============================================================
  print('=== Section 2: Curve Graph Gallery ===');

  // Sample a curve at 30 points and build a Row of vertical bars
  Widget buildCurveGraph(String name, Curve curve, Color color, IconData icon) {
    final bars = <Widget>[];
    const sampleCount = 30;
    for (var i = 0; i < sampleCount; i++) {
      final t = i / (sampleCount - 1);
      final v = curve.transform(t);
      // Clamp negative/over-shoot to [-0.3, 1.3] for display purposes
      final clamped = v.clamp(-0.3, 1.3);
      final isNegative = clamped < 0;
      final barHeight = (clamped.abs() * 100.0).clamp(1.0, 130.0);
      bars.add(
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.5),
            child: Align(
              alignment: isNegative
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              child: Container(
                height: barHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isNegative
                        ? [Colors.red.shade300, Colors.red.shade700]
                        : [color.withValues(alpha: 0.4), color],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
          ),
        ),
      );
    }

    final midValue = curve.transform(0.5);
    final endValue = curve.transform(1.0);

    return Container(
      width: 280.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 18.0),
              ),
              SizedBox(width: 8.0),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Container(
            height: 140.0,
            padding: EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: Colors.grey.shade200, width: 1.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: bars,
            ),
          ),
          SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'f(0.5)=${midValue.toStringAsFixed(3)}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: Colors.grey.shade700,
                ),
              ),
              Text(
                'f(1.0)=${endValue.toStringAsFixed(3)}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final galleryCurves = <Map<String, dynamic>>[
    {
      'name': 'linear',
      'curve': Curves.linear,
      'color': Colors.grey.shade600,
      'icon': Icons.trending_flat,
    },
    {
      'name': 'easeIn',
      'curve': Curves.easeIn,
      'color': Colors.blue,
      'icon': Icons.trending_up,
    },
    {
      'name': 'easeOut',
      'curve': Curves.easeOut,
      'color': Colors.green,
      'icon': Icons.trending_down,
    },
    {
      'name': 'easeInOut',
      'curve': Curves.easeInOut,
      'color': Colors.purple,
      'icon': Icons.swap_horiz,
    },
    {
      'name': 'fastOutSlowIn',
      'curve': Curves.fastOutSlowIn,
      'color': Colors.deepPurple,
      'icon': Icons.flash_on,
    },
    {
      'name': 'decelerate',
      'curve': Curves.decelerate,
      'color': Colors.cyan,
      'icon': Icons.slow_motion_video,
    },
    {
      'name': 'slowMiddle',
      'curve': Curves.slowMiddle,
      'color': Colors.teal,
      'icon': Icons.av_timer,
    },
    {
      'name': 'bounceIn',
      'curve': Curves.bounceIn,
      'color': Colors.orange,
      'icon': Icons.sports_basketball,
    },
    {
      'name': 'bounceOut',
      'curve': Curves.bounceOut,
      'color': Colors.deepOrange,
      'icon': Icons.sports_basketball,
    },
    {
      'name': 'bounceInOut',
      'curve': Curves.bounceInOut,
      'color': Colors.red,
      'icon': Icons.sports_basketball,
    },
    {
      'name': 'elasticIn',
      'curve': Curves.elasticIn,
      'color': Colors.pink,
      'icon': Icons.waves,
    },
    {
      'name': 'elasticOut',
      'curve': Curves.elasticOut,
      'color': Colors.pinkAccent,
      'icon': Icons.waves,
    },
    {
      'name': 'elasticInOut',
      'curve': Curves.elasticInOut,
      'color': Colors.purpleAccent,
      'icon': Icons.waves,
    },
  ];

  final galleryWidgets = <Widget>[];
  for (final entry in galleryCurves) {
    final name = entry['name'] as String;
    final curve = entry['curve'] as Curve;
    final color = entry['color'] as Color;
    final icon = entry['icon'] as IconData;
    print('Gallery curve $name: f(0.5)=${curve.transform(0.5)}');
    galleryWidgets.add(buildCurveGraph(name, curve, color, icon));
  }
  print('Created ${galleryWidgets.length} gallery widgets');

  // ============================================================
  // SECTION 3: Ease Family Comparisons
  // ============================================================
  print('=== Section 3: Ease Family Comparisons ===');

  Widget buildCompareStrip(String label, Curve curve, Color color) {
    final bars = <Widget>[];
    const sampleCount = 30;
    for (var i = 0; i < sampleCount; i++) {
      final t = i / (sampleCount - 1);
      final v = curve.transform(t).clamp(0.0, 1.0);
      bars.add(
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.5),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: v * 60.0 + 1.0,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 130.0,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 64.0,
              padding: EdgeInsets.symmetric(vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: bars,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFamilyCard(
    String title,
    List<MapEntry<String, Curve>> family,
    Color baseColor,
    IconData icon,
  ) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: baseColor.withValues(alpha: 0.4), width: 2.0),
        boxShadow: [
          BoxShadow(
            color: baseColor.withValues(alpha: 0.12),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: baseColor, size: 22.0),
              SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: baseColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          ...family.map((e) => buildCompareStrip(e.key, e.value, baseColor)),
        ],
      ),
    );
  }

  final easeInFamily = <MapEntry<String, Curve>>[
    MapEntry('easeIn', Curves.easeIn),
    MapEntry('easeInQuad', Curves.easeInQuad),
    MapEntry('easeInCubic', Curves.easeInCubic),
    MapEntry('easeInQuart', Curves.easeInQuart),
    MapEntry('easeInQuint', Curves.easeInQuint),
    MapEntry('easeInExpo', Curves.easeInExpo),
    MapEntry('easeInCirc', Curves.easeInCirc),
    MapEntry('easeInBack', Curves.easeInBack),
  ];

  final easeOutFamily = <MapEntry<String, Curve>>[
    MapEntry('easeOut', Curves.easeOut),
    MapEntry('easeOutQuad', Curves.easeOutQuad),
    MapEntry('easeOutCubic', Curves.easeOutCubic),
    MapEntry('easeOutQuart', Curves.easeOutQuart),
    MapEntry('easeOutQuint', Curves.easeOutQuint),
    MapEntry('easeOutExpo', Curves.easeOutExpo),
    MapEntry('easeOutCirc', Curves.easeOutCirc),
    MapEntry('easeOutBack', Curves.easeOutBack),
  ];

  final easeInOutFamily = <MapEntry<String, Curve>>[
    MapEntry('easeInOut', Curves.easeInOut),
    MapEntry('easeInOutQuad', Curves.easeInOutQuad),
    MapEntry('easeInOutCubic', Curves.easeInOutCubic),
    MapEntry('easeInOutQuart', Curves.easeInOutQuart),
    MapEntry('easeInOutQuint', Curves.easeInOutQuint),
    MapEntry('easeInOutExpo', Curves.easeInOutExpo),
    MapEntry('easeInOutCirc', Curves.easeInOutCirc),
    MapEntry('easeInOutBack', Curves.easeInOutBack),
  ];

  final familyCards = <Widget>[
    buildFamilyCard('easeIn family', easeInFamily, Colors.blue, Icons.north_east),
    buildFamilyCard('easeOut family', easeOutFamily, Colors.green, Icons.south_east),
    buildFamilyCard(
      'easeInOut family',
      easeInOutFamily,
      Colors.purple,
      Icons.compare_arrows,
    ),
  ];
  print('Created ${familyCards.length} family cards');

  // ============================================================
  // SECTION 4: Special Curves (Cubic, Interval, Threshold, SawTooth, Flipped)
  // ============================================================
  print('=== Section 4: Special Curves ===');

  // Custom Cubic - CSS-like ease
  final customCubic = Cubic(0.25, 0.1, 0.25, 1.0);
  print('Custom Cubic(0.25,0.1,0.25,1.0) f(0.5)=${customCubic.transform(0.5)}');

  // Material standard
  final materialStandard = Cubic(0.4, 0.0, 0.2, 1.0);
  print('Material standard f(0.5)=${materialStandard.transform(0.5)}');

  // Material decelerate
  final materialDecel = Cubic(0.0, 0.0, 0.2, 1.0);
  print('Material decelerate f(0.5)=${materialDecel.transform(0.5)}');

  // Material accelerate
  final materialAccel = Cubic(0.4, 0.0, 1.0, 1.0);
  print('Material accelerate f(0.5)=${materialAccel.transform(0.5)}');

  // Interval
  final interval = Interval(0.25, 0.75);
  print('Interval(0.25,0.75) f(0.5)=${interval.transform(0.5)}');

  // Interval with curve
  final intervalEased = Interval(0.0, 0.5, curve: Curves.easeOut);
  print('Interval(0,0.5,easeOut) f(0.25)=${intervalEased.transform(0.25)}');

  // Threshold
  final threshold = Threshold(0.5);
  print('Threshold(0.5) f(0.49)=${threshold.transform(0.49)} f(0.5)=${threshold.transform(0.5)}');

  // SawTooth
  final sawTooth = SawTooth(3);
  print('SawTooth(3) f(0.5)=${sawTooth.transform(0.5)}');

  // FlippedCurve
  final flipped = FlippedCurve(Curves.easeIn);
  print('FlippedCurve(easeIn) f(0.25)=${flipped.transform(0.25)}');

  // CatmullRom
  final catmullRom = CatmullRomCurve(<Offset>[
    Offset(0.25, 0.25),
    Offset(0.5, 1.2),
    Offset(0.75, 0.5),
  ]);
  print('CatmullRomCurve f(0.5)=${catmullRom.transform(0.5)}');

  final specialCurveCards = <Widget>[
    buildCurveGraph('Cubic(0.25,0.1,0.25,1.0)', customCubic, Colors.blue, Icons.timeline),
    buildCurveGraph('Material Standard', materialStandard, Colors.indigo, Icons.flag),
    buildCurveGraph('Material Decelerate', materialDecel, Colors.cyan, Icons.airplane_ticket),
    buildCurveGraph('Material Accelerate', materialAccel, Colors.deepPurple, Icons.rocket_launch),
    buildCurveGraph('Interval(0.25,0.75)', interval, Colors.teal, Icons.center_focus_strong),
    buildCurveGraph('Interval(0,0.5,easeOut)', intervalEased, Colors.green, Icons.start),
    buildCurveGraph('Threshold(0.5)', threshold, Colors.brown, Icons.toggle_on),
    buildCurveGraph('SawTooth(3)', sawTooth, Colors.amber, Icons.show_chart),
    buildCurveGraph('FlippedCurve(easeIn)', flipped, Colors.deepOrange, Icons.flip),
    buildCurveGraph('CatmullRomCurve', catmullRom, Colors.pink, Icons.gesture),
  ];
  print('Created ${specialCurveCards.length} special curve cards');

  // ============================================================
  // SECTION 5: Real-World Use Cases
  // ============================================================
  print('=== Section 5: Real-World Use Cases ===');

  Widget buildUseCaseCard({
    required String title,
    required String description,
    required String pattern,
    required Curve curve,
    required Color color,
    required IconData icon,
  }) {
    final bars = <Widget>[];
    const sampleCount = 30;
    for (var i = 0; i < sampleCount; i++) {
      final t = i / (sampleCount - 1);
      final v = curve.transform(t);
      final clamped = v.clamp(-0.3, 1.3);
      final isNegative = clamped < 0;
      bars.add(
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.5),
            child: Align(
              alignment: isNegative ? Alignment.topCenter : Alignment.bottomCenter,
              child: Container(
                height: (clamped.abs() * 100.0).clamp(1.0, 130.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isNegative
                        ? [Colors.red.shade300, Colors.red.shade700]
                        : [color.withValues(alpha: 0.5), color],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.05), color.withValues(alpha: 0.15)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 2.0),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28.0),
              ),
              SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        pattern,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Text(
            description,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
          ),
          SizedBox(height: 12.0),
          Container(
            height: 140.0,
            padding: EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: bars,
            ),
          ),
        ],
      ),
    );
  }

  final useCaseCards = <Widget>[
    buildUseCaseCard(
      title: 'Snappy Enter',
      description:
          'A new screen or sheet slides in quickly, then settles. fastOutSlowIn is the Material recommendation: rapid acceleration, gentle settle.',
      pattern: 'Curves.fastOutSlowIn',
      curve: Curves.fastOutSlowIn,
      color: Colors.indigo,
      icon: Icons.login,
    ),
    buildUseCaseCard(
      title: 'Gentle Exit',
      description:
          'When content leaves the screen, decelerate gives a calm wind-down. The animation starts fast and eases out naturally.',
      pattern: 'Curves.decelerate',
      curve: Curves.decelerate,
      color: Colors.teal,
      icon: Icons.logout,
    ),
    buildUseCaseCard(
      title: 'Attention Bounce',
      description:
          'For attention-getting badges and notifications, bounceOut adds a playful overshoot that draws the eye without feeling jarring.',
      pattern: 'Curves.bounceOut',
      curve: Curves.bounceOut,
      color: Colors.orange,
      icon: Icons.notifications_active,
    ),
    buildUseCaseCard(
      title: 'Playful Pop',
      description:
          'elasticOut gives a spring-loaded feel ideal for like buttons, badge increments, and tap feedback that wants to feel alive.',
      pattern: 'Curves.elasticOut',
      curve: Curves.elasticOut,
      color: Colors.pink,
      icon: Icons.favorite,
    ),
    buildUseCaseCard(
      title: 'Anticipation Pull',
      description:
          'easeInBack pulls slightly backwards before the main motion. Great for cards that flick away or off-screen exits.',
      pattern: 'Curves.easeInBack',
      curve: Curves.easeInBack,
      color: Colors.deepPurple,
      icon: Icons.swipe_left,
    ),
    buildUseCaseCard(
      title: 'Linear Progress',
      description:
          'For determinate progress bars and time-based meters, linear is the only honest choice. No easing, no surprises.',
      pattern: 'Curves.linear',
      curve: Curves.linear,
      color: Colors.blueGrey,
      icon: Icons.linear_scale,
    ),
  ];
  print('Created ${useCaseCards.length} use case cards');

  // ============================================================
  // SECTION 6: Code Panels
  // ============================================================
  print('=== Section 6: Code Panels ===');

  Widget buildCodePanel(String title, String code, Color accent) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: accent, size: 20.0),
              SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.green.shade300,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final codePanels = <Widget>[
    buildCodePanel(
      'Custom Cubic Bezier',
      '// CSS-like ease curve\n'
          'final ease = Cubic(0.25, 0.1, 0.25, 1.0);\n'
          'final v = ease.transform(0.5);\n'
          '\n'
          '// Material design easings\n'
          'final standard    = Cubic(0.4, 0.0, 0.2, 1.0);\n'
          'final decelerate  = Cubic(0.0, 0.0, 0.2, 1.0);\n'
          'final accelerate  = Cubic(0.4, 0.0, 1.0, 1.0);',
      Colors.cyan.shade300,
    ),
    buildCodePanel(
      'Interval Composition',
      '// Run easeOut only between t=0.0 and t=0.5\n'
          'final firstHalf = Interval(\n'
          '  0.0, 0.5,\n'
          '  curve: Curves.easeOut,\n'
          ');\n'
          '\n'
          '// Run elasticOut in the second half\n'
          'final secondHalf = Interval(\n'
          '  0.5, 1.0,\n'
          '  curve: Curves.elasticOut,\n'
          ');',
      Colors.amber.shade300,
    ),
    buildCodePanel(
      'FlippedCurve and SawTooth',
      '// Reverse any curve\n'
          'final reversedIn = FlippedCurve(Curves.easeIn);\n'
          '\n'
          '// Periodic ramp: 0->1, 0->1, 0->1\n'
          'final saw = SawTooth(3);\n'
          '\n'
          '// Step function at threshold 0.5\n'
          'final step = Threshold(0.5);',
      Colors.pink.shade300,
    ),
    buildCodePanel(
      'Using Curves with CurvedAnimation',
      '// Combine an AnimationController with a curve\n'
          'final controller = AnimationController(\n'
          '  vsync: this,\n'
          '  duration: Duration(milliseconds: 350),\n'
          ');\n'
          '\n'
          'final curved = CurvedAnimation(\n'
          '  parent: controller,\n'
          '  curve: Curves.fastOutSlowIn,\n'
          '  reverseCurve: Curves.easeInBack,\n'
          ');',
      Colors.lightBlueAccent.shade100,
    ),
  ];
  print('Created ${codePanels.length} code panels');

  // ============================================================
  // SECTION 7: Summary Panel
  // ============================================================
  print('=== Section 7: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.show_chart,
          'transform(t)',
          'Maps t in [0,1] to a value, usually anchored at 0 and 1',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.collections,
          'Curves library',
          'Linear, ease, bounce, elastic, fastOutSlowIn, decelerate, slowMiddle',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.timeline,
          'Custom Cubic',
          'Define any bezier with control points x1,y1,x2,y2',
          Colors.cyan,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.center_focus_strong,
          'Interval',
          'Run a sub-curve over a slice of t, ramping outside the slice',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.flip,
          'FlippedCurve',
          'Reverse another curve: 1 - curve(1 - t)',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.toggle_on,
          'Threshold and SawTooth',
          'Step and periodic patterns for non-monotonic motion',
          Colors.deepOrange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.gesture,
          'CatmullRomCurve',
          'Smooth curve through arbitrary control points',
          Colors.pink,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('Curve Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.purple, Colors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.4),
                    blurRadius: 16.0,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.show_chart, size: 56.0, color: Colors.white),
                  SizedBox(height: 8.0),
                  Text(
                    'Animation Curves Gallery',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Curve, Curves, Cubic, Interval, FlippedCurve, SawTooth',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),

            // Section 1
            Text(
              '1. Curve Concepts',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: conceptCards,
            ),
            SizedBox(height: 32.0),

            // Section 2
            Text(
              '2. Curve Graph Gallery',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6.0),
            Text(
              'Each bar samples the curve at 30 points; height shows transform(t). Red bars indicate negative values.',
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: galleryWidgets,
            ),
            SizedBox(height: 32.0),

            // Section 3
            Text(
              '3. Ease Family Comparisons',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6.0),
            Text(
              'Side-by-side strips reveal how higher-order easings sharpen the curve.',
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
            ),
            SizedBox(height: 12.0),
            ...familyCards,
            SizedBox(height: 32.0),

            // Section 4
            Text(
              '4. Special Curves',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6.0),
            Text(
              'Custom Cubic beziers, Interval slicing, Threshold step, SawTooth ramps, FlippedCurve, and CatmullRom.',
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: specialCurveCards,
            ),
            SizedBox(height: 32.0),

            // Section 5
            Text(
              '5. Real-World Use Cases',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...useCaseCards,
            SizedBox(height: 32.0),

            // Section 6
            Text(
              '6. Code Panels',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...codePanels,
            SizedBox(height: 32.0),

            // Section 7
            Text(
              '7. Summary',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            summaryPanel,
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// Helper: Build summary item
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

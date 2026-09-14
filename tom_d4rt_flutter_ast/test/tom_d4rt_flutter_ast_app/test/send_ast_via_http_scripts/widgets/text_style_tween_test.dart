// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — TextStyleTween
// Demonstrates TextStyleTween — a Tween<TextStyle> that smoothly
// interpolates between two TextStyle values using TextStyle.lerp.
// Shows how font size, color, weight, spacing, and decoration
// transition across animation values, with visual samples at
// multiple interpolation points.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextStyleTween Deep Demo executing');

  // ============================================================
  // SECTION 1: What is TextStyleTween?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.text_fields,
      'title': 'Text Style Interpolation',
      'body': 'TextStyleTween extends Tween<TextStyle> and uses '
          'TextStyle.lerp to smoothly transition between a begin '
          'and end style. Every numeric property interpolates linearly; '
          'colors blend through their color space.',
      'accent': Colors.deepPurple[800]!,
    },
    {
      'icon': Icons.animation,
      'title': 'Animation-Ready',
      'body': 'Designed to work with AnimationController and animation '
          'widgets like DefaultTextStyleTransition and '
          'AnimatedDefaultTextStyle. Calling lerp(t) returns the '
          'exact intermediate TextStyle at time t.',
      'accent': Colors.amber[800]!,
    },
    {
      'icon': Icons.account_tree,
      'title': 'Tween Hierarchy',
      'body': 'TextStyleTween → Tween<TextStyle> → Animatable<TextStyle>. '
          'Inherits transform(), animate(), chain() methods. The '
          'only override is lerp(double t) which delegates to '
          'TextStyle.lerp(begin, end, t).',
      'accent': Colors.deepPurple[700]!,
    },
    {
      'icon': Icons.palette,
      'title': 'Rich Interpolation',
      'body': 'Numeric properties (fontSize, letterSpacing, wordSpacing, '
          'height, decorationThickness) interpolate linearly. Colors '
          'blend smoothly. FontWeight steps through its 9 weights. '
          'Non-numeric properties switch at t=0.5.',
      'accent': Colors.amber[700]!,
    },
  ];

  print('  Concept cards: ${conceptCards.length}');

  // ============================================================
  // SECTION 2: Visual Lerp Showcase
  // ============================================================
  print('=== Section 2: Lerp Showcase ===');

  final styleTween = TextStyleTween(
    begin: TextStyle(
      fontSize: 12,
      color: Colors.deepPurple[900],
      fontWeight: FontWeight.w300,
      letterSpacing: 0,
    ),
    end: TextStyle(
      fontSize: 28,
      color: Colors.amber[800],
      fontWeight: FontWeight.w900,
      letterSpacing: 4,
    ),
  );

  final lerpPoints = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
  final lerpStyles = lerpPoints.map((t) {
    final s = styleTween.lerp(t);
    print('  t=$t: fontSize=${s.fontSize?.toStringAsFixed(1)}, '
        'weight=${s.fontWeight}, letterSpacing=${s.letterSpacing?.toStringAsFixed(1)}');
    return {'t': t, 'style': s};
  }).toList();

  // ============================================================
  // SECTION 3: Property-by-Property Interpolation
  // ============================================================
  print('=== Section 3: Property Details ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'fontSize',
      'begin': '12.0',
      'mid': '20.0',
      'end': '28.0',
      'type': 'Linear',
      'icon': Icons.format_size,
      'color': Colors.deepPurple[800]!,
    },
    {
      'name': 'color',
      'begin': 'DeepPurple[900]',
      'mid': 'Blended',
      'end': 'Amber[800]',
      'type': 'Color.lerp',
      'icon': Icons.color_lens,
      'color': Colors.amber[800]!,
    },
    {
      'name': 'fontWeight',
      'begin': 'w300 (Light)',
      'mid': 'w600 (Semi)',
      'end': 'w900 (Black)',
      'type': 'FontWeight.lerp',
      'icon': Icons.format_bold,
      'color': Colors.deepPurple[700]!,
    },
    {
      'name': 'letterSpacing',
      'begin': '0.0',
      'mid': '2.0',
      'end': '4.0',
      'type': 'Linear',
      'icon': Icons.space_bar,
      'color': Colors.amber[700]!,
    },
    {
      'name': 'wordSpacing',
      'begin': '0.0',
      'mid': 'Linear lerp',
      'end': 'Target value',
      'type': 'Linear',
      'icon': Icons.wrap_text,
      'color': Colors.deepPurple[600]!,
    },
    {
      'name': 'height',
      'begin': '1.0',
      'mid': 'Linear lerp',
      'end': '2.0',
      'type': 'Linear',
      'icon': Icons.height,
      'color': Colors.amber[600]!,
    },
    {
      'name': 'decorationThickness',
      'begin': '1.0',
      'mid': 'Linear lerp',
      'end': '3.0',
      'type': 'Linear',
      'icon': Icons.line_weight,
      'color': Colors.deepPurple[500]!,
    },
  ];

  print('  Properties: ${properties.length}');

  // ============================================================
  // SECTION 4: Non-Interpolable Properties
  // ============================================================
  print('=== Section 4: Non-Interpolable ===');

  final nonInterpolable = <Map<String, dynamic>>[
    {
      'name': 'fontFamily',
      'behavior': 'Switches at t > 0.5 from begin to end value. '
          'There is no smooth transition between font families.',
      'icon': Icons.font_download,
      'color': Colors.deepPurple[800]!,
    },
    {
      'name': 'fontFeatures',
      'behavior': 'Feature sets switch at t > 0.5. Individual '
          'OpenType features cannot be partially applied.',
      'icon': Icons.tune,
      'color': Colors.amber[800]!,
    },
    {
      'name': 'decoration',
      'behavior': 'TextDecoration switches at t > 0.5 (e.g., '
          'underline to line-through). The decoration type '
          'itself does not interpolate.',
      'icon': Icons.format_underlined,
      'color': Colors.deepPurple[700]!,
    },
    {
      'name': 'fontStyle',
      'behavior': 'Normal vs italic switches at t > 0.5. There '
          'is no "partial italic" in fonts.',
      'icon': Icons.format_italic,
      'color': Colors.amber[700]!,
    },
  ];

  print('  Non-interpolable: ${nonInterpolable.length}');

  // ============================================================
  // SECTION 5: Multi-Property Visual Sample
  // ============================================================
  print('=== Section 5: Multi-Property ===');

  final richTween = TextStyleTween(
    begin: TextStyle(
      fontSize: 14,
      color: Colors.deepPurple[900],
      fontWeight: FontWeight.w200,
      letterSpacing: 0,
      decoration: TextDecoration.none,
    ),
    end: TextStyle(
      fontSize: 24,
      color: Colors.amber[700],
      fontWeight: FontWeight.w800,
      letterSpacing: 3,
      decoration: TextDecoration.underline,
      decorationColor: Colors.amber[700],
    ),
  );

  final richSamples = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0].map((t) {
    final s = richTween.lerp(t);
    return {'t': t, 'style': s};
  }).toList();

  print('  Rich samples: ${richSamples.length}');

  // ============================================================
  // SECTION 6: Usage Patterns
  // ============================================================
  print('=== Section 6: Usage ===');

  final usagePatterns = <Map<String, dynamic>>[
    {
      'title': 'DefaultTextStyleTransition',
      'description': 'Animates the DefaultTextStyle of a subtree. Wraps '
          'children and transitions the text style used by all Text '
          'widgets without explicit style.',
      'code': 'DefaultTextStyleTransition(\n'
          '  style: textStyleTween.animate(controller),\n'
          '  child: Text(\'Hello\'),\n'
          ')',
      'color': Colors.deepPurple[800]!,
    },
    {
      'title': 'AnimatedDefaultTextStyle',
      'description': 'Implicit animation version — just change the style '
          'property and it transitions automatically over the given '
          'duration using a curve.',
      'code': 'AnimatedDefaultTextStyle(\n'
          '  style: isLarge ? bigStyle : smallStyle,\n'
          '  duration: Duration(milliseconds: 300),\n'
          '  child: Text(\'Hello\'),\n'
          ')',
      'color': Colors.amber[800]!,
    },
    {
      'title': 'AnimatedBuilder + TextStyleTween',
      'description': 'Manual control: create the tween, animate it, and '
          'use the interpolated style in a builder for maximum '
          'flexibility.',
      'code': 'AnimatedBuilder(\n'
          '  animation: controller,\n'
          '  builder: (ctx, _) {\n'
          '    final style = tween.evaluate(controller);\n'
          '    return Text(\'Hello\', style: style);\n'
          '  },\n'
          ')',
      'color': Colors.deepPurple[700]!,
    },
    {
      'title': 'TweenAnimationBuilder',
      'description': 'Stateless implicit animation that uses the tween '
          'directly without needing an AnimationController.',
      'code': 'TweenAnimationBuilder<TextStyle>(\n'
          '  tween: TextStyleTween(\n'
          '    begin: style1, end: style2,\n'
          '  ),\n'
          '  duration: Duration(seconds: 1),\n'
          '  builder: (ctx, style, _) =>\n'
          '    Text(\'Hello\', style: style),\n'
          ')',
      'color': Colors.amber[700]!,
    },
  ];

  print('  Usage patterns: ${usagePatterns.length}');

  // ============================================================
  // SECTION 7: Edge Cases
  // ============================================================
  print('=== Section 7: Edge Cases ===');

  final edgeCases = <Map<String, dynamic>>[
    {
      'title': 'Null Begin Field',
      'detail': 'If begin has fontSize but end does not, the result at '
          't>0 uses end\'s null. TextStyle.lerp handles this by '
          'lerping from the value to null (effectively disappearing).',
      'icon': Icons.warning_amber,
      'color': Colors.deepPurple[800]!,
    },
    {
      'title': 'Mismatched Decorations',
      'detail': 'Decoration switches at t > 0.5. Going from underline '
          'to line-through will show underline for the first half '
          'and line-through for the second.',
      'icon': Icons.swap_horiz,
      'color': Colors.amber[800]!,
    },
    {
      'title': 'Inherit Property',
      'detail': 'If inherit is true in one style and false in another, '
          'the switched value at t > 0.5 determines whether the '
          'intermediate style inherits from the DefaultTextStyle.',
      'icon': Icons.merge_type,
      'color': Colors.deepPurple[700]!,
    },
    {
      'title': 'Both Null',
      'detail': 'If both begin and end are null, lerp returns null. '
          'The TextStyleTween constructor requires non-null begin '
          'and end, but individual properties can be null.',
      'icon': Icons.block,
      'color': Colors.amber[700]!,
    },
  ];

  print('  Edge cases: ${edgeCases.length}');

  // ============================================================
  // SECTION 8: Comparison Table
  // ============================================================
  print('=== Section 8: Comparison ===');

  final tweenComparison = <Map<String, dynamic>>[
    {
      'tween': 'TextStyleTween',
      'type': 'TextStyle',
      'method': 'TextStyle.lerp',
      'use': 'Text style animations',
    },
    {
      'tween': 'ColorTween',
      'type': 'Color?',
      'method': 'Color.lerp',
      'use': 'Color transitions',
    },
    {
      'tween': 'DecorationTween',
      'type': 'Decoration',
      'method': 'Decoration.lerp',
      'use': 'Box decoration changes',
    },
    {
      'tween': 'EdgeInsetsTween',
      'type': 'EdgeInsets',
      'method': 'EdgeInsets.lerp',
      'use': 'Padding/margin changes',
    },
    {
      'tween': 'BorderRadiusTween',
      'type': 'BorderRadius?',
      'method': 'BorderRadius.lerp',
      'use': 'Corner radius changes',
    },
    {
      'tween': 'ThemeDataTween',
      'type': 'ThemeData',
      'method': 'ThemeData.lerp',
      'use': 'Full theme transitions',
    },
  ];

  print('  Comparison rows: ${tweenComparison.length}');

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
              colors: [Colors.deepPurple[800]!, Colors.amber[700]!],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(Icons.text_fields, size: 48, color: Colors.white),
              SizedBox(height: 12),
              Text(
                'TextStyleTween',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Smoothly interpolates between two TextStyle values — '
                'font size, color, weight, spacing, and decoration '
                'transition fluidly across animation time.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // ---- Section 1: Concept ----
        _sectionHeader('1. Concept', Icons.info_outline, Colors.deepPurple[800]!),
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

        // ---- Section 2: Lerp Showcase ----
        _sectionHeader('2. Visual Lerp Showcase', Icons.gradient, Colors.amber[800]!),
        SizedBox(height: 10),
        Text(
          'Each row shows text rendered at a different interpolation point. '
          'Watch fontSize grow, color shift from deep purple to amber, '
          'weight thicken, and letter spacing widen:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: lerpStyles.map((entry) {
              final t = entry['t'] as double;
              final style = entry['style'] as TextStyle;
              return Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text('t=${t.toStringAsFixed(2)}',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, fontFamily: 'monospace', fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text('TextStyleTween', style: style),
                    ),
                    Text(
                      '${style.fontSize?.toStringAsFixed(0)}px',
                      style: TextStyle(fontSize: 10, color: Colors.grey[500], fontFamily: 'monospace'),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 3: Property Details ----
        _sectionHeader('3. Interpolable Properties', Icons.tune, Colors.deepPurple[800]!),
        SizedBox(height: 10),
        ...properties.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(p['icon'] as IconData, color: p['color'] as Color, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: Text(p['name'] as String,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'monospace', color: p['color'] as Color)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _propertyChip(p['begin'] as String, Colors.deepPurple[100]!),
                          Icon(Icons.arrow_forward, size: 12, color: Colors.grey[400]),
                          _propertyChip(p['mid'] as String, Colors.grey[200]!),
                          Icon(Icons.arrow_forward, size: 12, color: Colors.grey[400]),
                          _propertyChip(p['end'] as String, Colors.amber[100]!),
                        ],
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: (p['color'] as Color).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(p['type'] as String,
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: p['color'] as Color)),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 4: Non-Interpolable Properties ----
        _sectionHeader('4. Non-Interpolable (Switch at t > 0.5)', Icons.swap_horiz, Colors.amber[800]!),
        SizedBox(height: 10),
        ...nonInterpolable.map((p) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: (p['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border(left: BorderSide(color: p['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(p['icon'] as IconData, color: p['color'] as Color, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['name'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'monospace', color: p['color'] as Color)),
                          SizedBox(height: 3),
                          Text(p['behavior'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 5: Multi-Property Rich Samples ----
        _sectionHeader('5. Multi-Property Transition', Icons.auto_awesome, Colors.deepPurple[800]!),
        SizedBox(height: 10),
        Text(
          'A rich tween with fontSize, color, weight, letterSpacing, '
          'and decoration all changing simultaneously:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.deepPurple[200]!),
          ),
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: richSamples.map((entry) {
              final t = entry['t'] as double;
              final style = entry['style'] as TextStyle;
              final pct = (t * 100).toInt();
              return Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            gradient: LinearGradient(
                              colors: [Colors.deepPurple[800]!, Colors.amber[700]!],
                              stops: [0, 1],
                            ),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: t == 0.0 ? 0.02 : t,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('$pct%',
                            style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: Colors.grey[500])),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text('The quick brown fox jumps over the lazy dog', style: style),
                    Divider(height: 12, color: Colors.grey[200]),
                  ],
                ),
              );
            }).toList(),
          ),
        ),

        SizedBox(height: 20),

        // ---- Section 6: Usage Patterns ----
        _sectionHeader('6. Usage Patterns', Icons.code, Colors.amber[800]!),
        SizedBox(height: 10),
        ...usagePatterns.map((u) => Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: (u['color'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(left: BorderSide(color: u['color'] as Color, width: 4)),
                ),
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(u['title'] as String,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: u['color'] as Color)),
                    SizedBox(height: 4),
                    Text(u['description'] as String, style: TextStyle(fontSize: 13)),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(u['code'] as String,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Colors.greenAccent[200])),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 7: Edge Cases ----
        _sectionHeader('7. Edge Cases & Gotchas', Icons.warning_amber, Colors.deepPurple[800]!),
        SizedBox(height: 10),
        ...edgeCases.map((e) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: (e['color'] as Color).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(e['icon'] as IconData, color: e['color'] as Color, size: 18),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e['title'] as String,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: e['color'] as Color)),
                          SizedBox(height: 3),
                          Text(e['detail'] as String,
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),

        SizedBox(height: 20),

        // ---- Section 8: Comparison Table ----
        _sectionHeader('8. Tween Family', Icons.compare, Colors.amber[800]!),
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
                color: Colors.amber[800],
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text('Tween', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 2, child: Text('Type', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 2, child: Text('Lerp Via', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                    Expanded(flex: 3, child: Text('Use Case', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11))),
                  ],
                ),
              ),
              ...List.generate(tweenComparison.length, (i) {
                final c = tweenComparison[i];
                return Container(
                  color: i.isEven ? Colors.white : Colors.amber[50],
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(c['tween'] as String,
                            style: TextStyle(fontSize: 11, fontWeight: i == 0 ? FontWeight.bold : FontWeight.normal, fontFamily: 'monospace')),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(c['type'] as String, style: TextStyle(fontSize: 11, fontFamily: 'monospace')),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(c['method'] as String, style: TextStyle(fontSize: 11)),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(c['use'] as String, style: TextStyle(fontSize: 11)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

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
              Icon(Icons.text_fields, color: Colors.deepPurple[600], size: 28),
              SizedBox(height: 6),
              Text(
                'TextStyleTween: smoothly transition every visual aspect '
                'of text — size, color, weight, spacing — in one tween.',
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

Widget _propertyChip(String text, Color bg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(3),
    ),
    child: Text(text, style: TextStyle(fontSize: 9, fontFamily: 'monospace')),
  );
}

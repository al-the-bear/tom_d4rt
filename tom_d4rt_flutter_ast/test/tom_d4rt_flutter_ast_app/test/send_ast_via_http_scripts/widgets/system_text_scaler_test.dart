// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SystemTextScaler / TextScaler
// Demonstrates the TextScaler system — how Flutter scales text based on
// the user's accessibility settings, the difference between linear and
// non-linear scaling, how MediaQuery provides the system text scale,
// and how to build custom TextScaler implementations for advanced control.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SystemTextScaler Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.text_fields,
      'title': 'What is TextScaler?',
      'body': 'TextScaler is an abstract class that determines how text '
          'font sizes are scaled. It replaces the deprecated '
          'textScaleFactor (a simple double) with a richer API that '
          'supports non-linear scaling curves.',
      'accent': Colors.brown,
    },
    {
      'icon': Icons.accessibility,
      'title': 'Accessibility Purpose',
      'body': 'Users with visual impairments set a preferred text size '
          'in their OS settings. TextScaler respects that preference '
          'by scaling all text proportionally, while allowing apps '
          'to clamp or customize the scaling behavior.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.phone_android,
      'title': 'System Integration',
      'body': 'The system text scale factor is provided by the platform. '
          'MediaQuery.textScalerOf(context) returns the current '
          'TextScaler. On Android and iOS, this reflects the user\'s '
          'font size preference from accessibility settings.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.trending_up,
      'title': 'Linear vs Non-Linear',
      'body': 'TextScaler.linear(factor) scales all sizes uniformly. '
          'Non-linear scalers can apply different multipliers at '
          'different base sizes — scaling small text more aggressively '
          'while keeping headings from becoming enormous.',
      'accent': Colors.deepOrange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final e = conceptItems[i];
    final accent = e['accent'] as Color;
    print('Concept ${i + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.03)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(e['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
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
  }

  // ============================================================
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'TextScaler.noScaling',
      'type': 'const TextScaler',
      'desc': 'A TextScaler that does not scale text at all. Every font '
          'size is returned as-is. Equivalent to TextScaler.linear(1.0) '
          'but as a named constant.',
    },
    {
      'name': 'TextScaler.linear(factor)',
      'type': 'factory',
      'desc': 'Creates a linear TextScaler. The given factor multiplies '
          'every font size uniformly. TextScaler.linear(1.5) makes all '
          'text 50% larger. This is the most common scaler.',
    },
    {
      'name': 'scale(fontSize)',
      'type': 'double',
      'desc': 'The core method. Takes a font size and returns the scaled '
          'size. For linear scalers: fontSize * factor. Custom scalers '
          'can implement any curve here.',
    },
    {
      'name': 'textScaleFactor',
      'type': 'double',
      'desc': 'Deprecated getter. Returns the effective linear factor. '
          'For backwards compatibility only. Prefer scale() which '
          'handles non-linear scalers correctly.',
    },
    {
      'name': 'clamp({minScaleFactor, maxScaleFactor})',
      'type': 'TextScaler',
      'desc': 'Returns a new TextScaler that clamps the scaling result '
          'within bounds. Useful for preventing text from becoming '
          'too small or too large, especially for headings.',
    },
    {
      'name': 'MediaQuery.textScalerOf(context)',
      'type': 'TextScaler',
      'desc': 'Reads the TextScaler from the nearest MediaQuery. This '
          'provides the system text scale as configured by the user '
          'in OS accessibility settings.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.brown.withOpacity(0.05)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.brown.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.brown.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      ae['name']!,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.brown,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ae['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              ae['desc']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Scale Factor Comparison
  // ============================================================
  print('=== Section 3: Scales ===');

  final scaleFactors = <double>[0.8, 1.0, 1.2, 1.5, 2.0, 3.0];
  final baseFontSize = 14.0;

  final scaleWidgets = <Widget>[];
  for (var i = 0; i < scaleFactors.length; i++) {
    final f = scaleFactors[i];
    final scaled = baseFontSize * f;
    final isDefault = f == 1.0;
    final scaleColor = isDefault
        ? Colors.green
        : f < 1.0
            ? Colors.blue
            : f <= 1.5
                ? Colors.brown
                : Colors.red;
    print('Scale ${i + 1}: ${f}x -> ${scaled}sp');

    scaleWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: scaleColor.withOpacity(isDefault ? 0.08 : 0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: scaleColor.withOpacity(isDefault ? 0.4 : 0.2),
            width: isDefault ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: scaleColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  '${f}x',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: scaleColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Show text at that visual scale (limited to visible range)
                  Text(
                    'The quick brown fox',
                    style: TextStyle(
                      fontSize: (scaled).clamp(8.0, 32.0),
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${baseFontSize.toInt()}sp -> ${scaled.toStringAsFixed(1)}sp'
                    '${isDefault ? "  (default)" : ""}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: scaleColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isDefault)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'DEFAULT',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Accessibility
  // ============================================================
  print('=== Section 4: Accessibility ===');

  final a11yTopics = <Map<String, dynamic>>[
    {
      'title': 'Legal Requirements',
      'desc': 'WCAG 2.1 Success Criterion 1.4.4 requires that text can '
          'be resized up to 200% without loss of functionality. '
          'TextScaler is Flutter\'s mechanism for meeting this.',
      'icon': Icons.gavel,
      'color': Colors.brown,
    },
    {
      'title': 'Low Vision Users',
      'desc': 'Approximately 4% of the population has low vision. Large '
          'text settings (1.5x–3.0x) are common. Apps must handle '
          'text overflow gracefully at these scales.',
      'icon': Icons.visibility_off,
      'color': Colors.blue,
    },
    {
      'title': 'Testing at Scale',
      'desc': 'Always test your UI at 1.0x, 1.5x, and 2.0x scale. Use '
          'MediaQuery.withClampedTextScaling or wrap in MediaQuery '
          'to simulate different scales during development.',
      'icon': Icons.bug_report,
      'color': Colors.orange,
    },
    {
      'title': 'Don\'t Disable Scaling',
      'desc': 'Never set textScaler to TextScaler.noScaling globally. '
          'Users who need large text cannot use your app. Instead, '
          'use clamp() to set reasonable bounds per widget.',
      'icon': Icons.block,
      'color': Colors.red,
    },
    {
      'title': 'Overflow Strategies',
      'desc': 'At large scales, text may overflow. Use Flexible/Expanded '
          'layouts, ellipsis for single-line text, and scrollable '
          'containers. Avoid fixed-height text containers.',
      'icon': Icons.height,
      'color': Colors.teal,
    },
  ];

  final a11yWidgets = <Widget>[];
  for (var i = 0; i < a11yTopics.length; i++) {
    final at = a11yTopics[i];
    final atColor = at['color'] as Color;
    print('A11y ${i + 1}: ${at['title']}');
    a11yWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: atColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: atColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: atColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(at['icon'] as IconData, color: atColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    at['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: atColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    at['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
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
    );
  }

  // ============================================================
  // SECTION 5: Layout Impact
  // ============================================================
  print('=== Section 5: Layout ===');

  final layoutExamples = <Map<String, dynamic>>[
    {
      'title': 'Button with Scaled Text',
      'desc': 'At 2x scale, button text doubles in size. If the button has '
          'a fixed width, text overflows. Use flexible width or wrap the '
          'text with FittedBox for graceful degradation.',
      'scale': 2.0,
      'element': 'Button',
      'color': Colors.brown,
    },
    {
      'title': 'AppBar Title Overflow',
      'desc': 'Long titles in AppBar may overflow at large scales. '
          'Use AutoSizeText or set overflow: TextOverflow.ellipsis '
          'to handle this. Material AppBar clips by default.',
      'scale': 1.5,
      'element': 'AppBar',
      'color': Colors.blue,
    },
    {
      'title': 'Card Content',
      'desc': 'Cards with both heading and body text grow vertically. '
          'At 2x scale, a card might need scrolling. Use '
          'ConstrainedBox with Scrollable for safety.',
      'scale': 2.0,
      'element': 'Card',
      'color': Colors.green,
    },
    {
      'title': 'Navigation Labels',
      'desc': 'BottomNavigationBar labels at large scales may overlap. '
          'Material widgets handle this internally but custom nav bars '
          'need explicit overflow handling.',
      'scale': 1.5,
      'element': 'NavBar',
      'color': Colors.orange,
    },
    {
      'title': 'Data Tables',
      'desc': 'Table cells with scaled text need wider columns. '
          'Use SingleChildScrollView for horizontal overflow. '
          'Consider clamped scaling for dense data displays.',
      'scale': 1.5,
      'element': 'Table',
      'color': Colors.purple,
    },
  ];

  final layoutWidgets = <Widget>[];
  for (var i = 0; i < layoutExamples.length; i++) {
    final le = layoutExamples[i];
    final leColor = le['color'] as Color;
    final leScale = le['scale'] as double;
    print('Layout ${i + 1}: ${le['title']}');

    // Visual: show element at normal vs scaled size
    layoutWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: leColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: leColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: leColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: leColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    le['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: leColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: leColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${leScale}x',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: leColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Before/after comparison
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.withOpacity(0.12)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '1.0x',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: leColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              le['element'] as String,
                              style: TextStyle(fontSize: 10, color: leColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(Icons.arrow_forward, size: 14, color: Colors.grey.shade400),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: leColor.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: leColor.withOpacity(0.15)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${leScale}x',
                          style: TextStyle(
                            fontSize: 9,
                            color: leColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: (20 * leScale).clamp(20.0, 40.0),
                          decoration: BoxDecoration(
                            color: leColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              le['element'] as String,
                              style: TextStyle(
                                fontSize: (10 * leScale).clamp(10.0, 18.0),
                                color: leColor,
                                fontWeight: FontWeight.w600,
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
            const SizedBox(height: 8),
            Text(
              le['desc'] as String,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade700,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Custom TextScaler
  // ============================================================
  print('=== Section 6: Custom ===');

  final customScalers = <Map<String, dynamic>>[
    {
      'title': 'Capped Heading Scaler',
      'desc': 'Scales body text normally but caps heading sizes to prevent '
          'them from dominating the screen. Checks if fontSize > 20 '
          'and applies a reduced factor for large sizes.',
      'code': 'class CappedScaler implements TextScaler {\n'
          '  final double factor;\n'
          '  const CappedScaler(this.factor);\n'
          '\n'
          '  @override\n'
          '  double scale(double fontSize) {\n'
          '    if (fontSize > 20) {\n'
          '      return fontSize * (1 + (factor - 1) * 0.5);\n'
          '    }\n'
          '    return fontSize * factor;\n'
          '  }\n'
          '  // ...\n'
          '}',
      'color': Colors.brown,
    },
    {
      'title': 'Step Scaler',
      'desc': 'Rounds scaled sizes to discrete steps (e.g., 12, 14, 16, '
          '18, 20). This keeps typography consistent even when the OS '
          'scale factor is not a clean number.',
      'code': 'class StepScaler implements TextScaler {\n'
          '  final double factor;\n'
          '  final List<double> steps = [12, 14, 16, 18, 20, 24, 28, 32];\n'
          '\n'
          '  @override\n'
          '  double scale(double fontSize) {\n'
          '    final target = fontSize * factor;\n'
          '    return steps.reduce((a, b) =>\n'
          '      (a - target).abs() < (b - target).abs() ? a : b);\n'
          '  }\n'
          '}',
      'color': Colors.blue,
    },
    {
      'title': 'Bounded Scaler via clamp()',
      'desc': 'The simplest custom approach: take the system TextScaler '
          'and call clamp() to set min/max bounds. Built into the SDK.',
      'code': 'final scaler = MediaQuery.textScalerOf(context);\n'
          'final clamped = scaler.clamp(\n'
          '  minScaleFactor: 0.8,\n'
          '  maxScaleFactor: 1.5,\n'
          ');',
      'color': Colors.green,
    },
  ];

  final customWidgets = <Widget>[];
  for (var i = 0; i < customScalers.length; i++) {
    final cs = customScalers[i];
    final csColor = cs['color'] as Color;
    print('Custom ${i + 1}: ${cs['title']}');
    customWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: csColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: csColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: csColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: csColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      cs['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: csColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                cs['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: csColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  cs['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: csColor,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: MediaQuery Integration
  // ============================================================
  print('=== Section 7: MediaQuery ===');

  final mqTopics = <Map<String, dynamic>>[
    {
      'title': 'Reading the System Scale',
      'desc': 'MediaQuery.textScalerOf(context) returns the TextScaler. '
          'This is the recommended way to access the system text scale. '
          'It subscribes to changes so the widget rebuilds.',
      'code': 'final scaler = MediaQuery.textScalerOf(context);\n'
          'final bodySize = scaler.scale(14.0); // e.g., 21.0 at 1.5x',
      'color': Colors.brown,
    },
    {
      'title': 'Overriding for a Subtree',
      'desc': 'Wrap a subtree in MediaQuery to override the text scaler '
          'for descendant widgets. Useful for areas that should ignore '
          'or limit the system scale.',
      'code': 'MediaQuery(\n'
          '  data: MediaQuery.of(context).copyWith(\n'
          '    textScaler: TextScaler.linear(1.0),\n'
          '  ),\n'
          '  child: widget,\n'
          ')',
      'color': Colors.blue,
    },
    {
      'title': 'withClampedTextScaling',
      'desc': 'A convenience: MediaQuery.withClampedTextScaling wraps a '
          'subtree and clamps the text scaler between min and max. '
          'Simpler than manually copying MediaQueryData.',
      'code': 'MediaQuery.withClampedTextScaling(\n'
          '  minScaleFactor: 1.0,\n'
          '  maxScaleFactor: 1.5,\n'
          '  child: widget,\n'
          ')',
      'color': Colors.green,
    },
    {
      'title': 'Text Widget Integration',
      'desc': 'Text and RichText automatically use MediaQuery.textScalerOf '
          'unless you set textScaler on the widget directly. Setting '
          'textScaler: TextScaler.noScaling on a Text widget opts it '
          'out of scaling.',
      'code': 'Text(\n'
          '  "Always 14sp",\n'
          '  textScaler: TextScaler.noScaling,\n'
          '  style: TextStyle(fontSize: 14),\n'
          ')',
      'color': Colors.purple,
    },
  ];

  final mqWidgets = <Widget>[];
  for (var i = 0; i < mqTopics.length; i++) {
    final mq = mqTopics[i];
    final mqColor = mq['color'] as Color;
    print('MQ ${i + 1}: ${mq['title']}');
    mqWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: mqColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: mqColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mq['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: mqColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                mq['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: mqColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  mq['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: mqColor,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.text_fields,
      'text': 'TextScaler replaces textScaleFactor with a richer API '
          'that supports non-linear scaling curves.',
    },
    {
      'icon': Icons.accessibility,
      'text': 'System text scaling is an accessibility requirement. '
          'Never disable it globally — use clamp() for limits.',
    },
    {
      'icon': Icons.trending_up,
      'text': 'TextScaler.linear(factor) is the most common scaler. '
          'The factor multiplies all font sizes uniformly.',
    },
    {
      'icon': Icons.phone_android,
      'text': 'MediaQuery.textScalerOf(context) provides the system '
          'TextScaler from the user\'s OS settings.',
    },
    {
      'icon': Icons.tune,
      'text': 'Custom TextScalers can cap headings, round to steps, '
          'or apply any scaling curve per font size.',
    },
    {
      'icon': Icons.bug_report,
      'text': 'Test your UI at 1.0x, 1.5x, and 2.0x to catch overflow '
          'issues before users encounter them.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.brown.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.brown.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.brown,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('TextScaler / System Text Scaling'),
        backgroundColor: Colors.brown,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.format_size), text: 'Scales'),
            Tab(icon: Icon(Icons.accessibility), text: 'A11y'),
            Tab(icon: Icon(Icons.view_quilt), text: 'Layout'),
            Tab(icon: Icon(Icons.tune), text: 'Custom'),
            Tab(icon: Icon(Icons.perm_media), text: 'MediaQuery'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TextScaler: the accessibility-focused text scaling '
                  'system that replaces the legacy textScaleFactor.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: API
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key API members of the TextScaler class hierarchy.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),

          // Tab 3: Scales
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Visual comparison of how different scale factors '
                  'affect a 14sp base font size.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...scaleWidgets,
            ],
          ),

          // Tab 4: A11y
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Why text scaling matters for accessibility and how '
                  'to ensure your app supports it properly.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...a11yWidgets,
            ],
          ),

          // Tab 5: Layout
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How scaled text affects layout: common overflow issues '
                  'and strategies for handling them.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...layoutWidgets,
            ],
          ),

          // Tab 6: Custom
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Building custom TextScaler implementations for '
                  'non-linear scaling and bounded ranges.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...customWidgets,
            ],
          ),

          // Tab 7: MediaQuery
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How TextScaler integrates with MediaQuery to '
                  'provide and override platform text scaling.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...mqWidgets,
            ],
          ),

          // Tab 8: Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.brown.withOpacity(0.12),
                      Colors.orange.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about TextScaler and system text scaling.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}

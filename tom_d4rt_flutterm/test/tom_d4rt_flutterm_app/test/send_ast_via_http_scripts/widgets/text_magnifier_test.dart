// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — MagnifierDecoration
// Demonstrates MagnifierDecoration, which defines the visual appearance
// of the text magnifier shown when selecting or dragging text on mobile.
// MagnifierDecoration controls the shape, shadows, border, size, and
// opacity of the loupe that appears above the user's finger.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MagnifierDecoration Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.search,
      'title': 'What is MagnifierDecoration?',
      'body': 'MagnifierDecoration is a data class that describes how a '
          'text magnifier should look. It bundles shape, size, shadows, '
          'border, and opacity into one object. It does not render the '
          'magnifier itself — that is done by RawMagnifier.',
      'accent': Colors.amber,
    },
    {
      'icon': Icons.phone_android,
      'title': 'Mobile Text Selection',
      'body': 'When a user long-presses on text and drags to select, '
          'a magnifier loupe appears above the finger to show the text '
          'underneath. Each platform has its own magnifier style '
          '(Material, Cupertino), both driven by MagnifierDecoration.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.palette,
      'title': 'Customization Points',
      'body': 'MagnifierDecoration lets you control the outer shape '
          '(via ShapeBorder), add shadows (list of BoxShadow), and '
          'adjust opacity. Combined with magnifierSize in the magnifier '
          'widget, you control every visual aspect of the loupe.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.layers,
      'title': 'Relationship to Magnifier Widgets',
      'body': 'TextMagnifier (adaptive) uses MagnifierDecoration internally. '
          'CupertinoTextMagnifier and MaterialMagnifier have pre-set '
          'decorations that match platform conventions. You can override '
          'them by providing your own MagnifierDecoration.',
      'accent': Colors.purple,
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
      'name': 'shape',
      'type': 'ShapeBorder',
      'desc': 'Defines the outer border shape of the magnifier. Common '
          'choices: RoundedRectangleBorder for a card-like loupe, '
          'CircleBorder for a round loupe, or StadiumBorder for a '
          'pill shape. Defaults to a rounded rectangle in Material.',
    },
    {
      'name': 'shadows',
      'type': 'List<BoxShadow>',
      'desc': 'Shadow(s) drawn beneath the magnifier. Material magnifiers '
          'typically have a soft elevation shadow. Cupertino uses no '
          'shadow (relying on border instead). Accepts multiple shadows.',
    },
    {
      'name': 'opacity',
      'type': 'double',
      'desc': 'Overall opacity of the magnifier decoration, from 0.0 '
          '(invisible) to 1.0 (fully opaque). Defaults to 1.0. The '
          'magnified content behind the loupe is unaffected by this — '
          'it only controls the border/shadow layer.',
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
              ? Colors.amber.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.amber.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber.shade800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
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
  // SECTION 3: Shape Variations
  // ============================================================
  print('=== Section 3: Shapes ===');

  final shapeVariants = <Map<String, dynamic>>[
    {
      'name': 'Rounded Rectangle',
      'desc': 'The Material default. Soft corners give a modern card look. '
          'RoundedRectangleBorder with borderRadius: 12.',
      'borderRadius': 12.0,
      'isCircle': false,
      'borderColor': Colors.amber,
    },
    {
      'name': 'Circle',
      'desc': 'Classic magnifying-glass style. Good for small, precise '
          'loupes. Use CircleBorder as the shape.',
      'borderRadius': 50.0,
      'isCircle': true,
      'borderColor': Colors.blue,
    },
    {
      'name': 'Pill / Stadium',
      'desc': 'Wider than a circle, narrower than a card. StadiumBorder '
          'gives fully rounded ends on a rectangular base.',
      'borderRadius': 30.0,
      'isCircle': false,
      'borderColor': Colors.green,
    },
    {
      'name': 'Sharp Rectangle',
      'desc': 'No rounding at all. Gives a technical or utilitarian feel. '
          'RoundedRectangleBorder with borderRadius: 0.',
      'borderRadius': 0.0,
      'isCircle': false,
      'borderColor': Colors.deepOrange,
    },
  ];

  final shapeWidgets = <Widget>[];
  for (var i = 0; i < shapeVariants.length; i++) {
    final sv = shapeVariants[i];
    final svColor = sv['borderColor'] as Color;
    final radius = sv['borderRadius'] as double;
    final isCircle = sv['isCircle'] as bool;
    print('Shape ${i + 1}: ${sv['name']}');

    Widget preview;
    if (isCircle) {
      preview = Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: svColor.withOpacity(0.08),
          border: Border.all(color: svColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: svColor.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Icon(Icons.zoom_in, color: svColor, size: 24),
        ),
      );
    } else {
      preview = Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: svColor.withOpacity(0.08),
          border: Border.all(color: svColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: svColor.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Abc',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: svColor,
            ),
          ),
        ),
      );
    }

    shapeWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: svColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: svColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              preview,
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sv['name'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: svColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      sv['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
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
  // SECTION 4: Shadows
  // ============================================================
  print('=== Section 4: Shadows ===');

  final shadowExamples = <Map<String, dynamic>>[
    {
      'title': 'Material Default Shadow',
      'desc': 'A soft, wide blur below and to the right. Mimics elevation '
          'on a physical card. Typically grey with 20-30% opacity and '
          'a blur radius of 8-16 pixels.',
      'shadow': BoxShadow(
        color: Colors.black.withOpacity(0.25),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
      'color': Colors.amber,
    },
    {
      'title': 'Subtle Inner Glow',
      'desc': 'A tight shadow with minimal offset creates a soft glow '
          'effect around the magnifier edge. Useful for dark-mode '
          'interfaces where drop shadows disappear against the background.',
      'shadow': BoxShadow(
        color: Colors.blue.withOpacity(0.3),
        blurRadius: 6,
        spreadRadius: 1,
      ),
      'color': Colors.blue,
    },
    {
      'title': 'No Shadow (Cupertino Style)',
      'desc': 'Cupertino magnifiers rely on a visible border instead of '
          'shadow. The loupe sits flat visually, with the border providing '
          'edges. Use an empty shadow list for this look.',
      'shadow': null,
      'color': Colors.green,
    },
    {
      'title': 'Dramatic Drop Shadow',
      'desc': 'A large offset and high blur for a floating effect. The '
          'magnifier appears to hover well above the content. Best for '
          'presentation or educational contexts.',
      'shadow': BoxShadow(
        color: Colors.black.withOpacity(0.35),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
      'color': Colors.deepOrange,
    },
  ];

  final shadowWidgets = <Widget>[];
  for (var i = 0; i < shadowExamples.length; i++) {
    final se = shadowExamples[i];
    final seColor = se['color'] as Color;
    final shadow = se['shadow'] as BoxShadow?;
    print('Shadow ${i + 1}: ${se['title']}');

    shadowWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: seColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: seColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: seColor.withOpacity(0.4)),
                  boxShadow: shadow != null ? [shadow] : [],
                ),
                child: Center(
                  child: Text(
                    'Ab',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: seColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      se['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: seColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      se['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
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
  // SECTION 5: Platform Styles
  // ============================================================
  print('=== Section 5: Platform ===');

  final platformItems = <Map<String, dynamic>>[
    {
      'title': 'Material Magnifier',
      'desc': 'Uses MagnifierDecoration with a RoundedRectangleBorder, '
          'soft elevation shadow, and full opacity. Size is typically '
          '90x48 logical pixels. The loupe floats above the finger '
          'with a shadow indicating depth.',
      'icon': Icons.android,
      'specs': 'Shape: RoundedRect(28)\n'
          'Shadow: Black26, blur:12, offset:(0,4)\n'
          'Size: 90 x 48\n'
          'Opacity: 1.0',
      'color': Colors.amber,
    },
    {
      'title': 'Cupertino Magnifier',
      'desc': 'Uses MagnifierDecoration with a continuous rounded rect '
          'border, no drop shadow, and a thin grey border. The loupe '
          'sits close to the text with a distinct iOS feel. Size is '
          'carried over from the CupertinoMagnifier constants.',
      'icon': Icons.apple,
      'specs': 'Shape: ContinuousRectangleBorder\n'
          'Shadow: None (border only)\n'
          'Border: 0.5px grey\n'
          'Opacity: 1.0',
      'color': Colors.blue,
    },
    {
      'title': 'Adaptive (TextMagnifier)',
      'desc': 'TextMagnifier.adaptiveMagnifierConfiguration selects the '
          'platform-appropriate magnifier automatically. On Android '
          'it uses MaterialMagnifier; on iOS, CupertinoMagnifier.',
      'icon': Icons.auto_fix_high,
      'specs': 'Delegates to platform style\n'
          'Detected via Theme.platform\n'
          'No manual config needed\n'
          'Most common approach',
      'color': Colors.green,
    },
    {
      'title': 'Custom Magnifier',
      'desc': 'Build your own magnifier from RawMagnifier and provide a '
          'custom MagnifierDecoration. This gives full control over '
          'shape, shadows, opacity, and size.',
      'icon': Icons.palette,
      'specs': 'Any ShapeBorder\n'
          'Any BoxShadow list\n'
          'Any opacity 0.0–1.0\n'
          'Any Size',
      'color': Colors.purple,
    },
  ];

  final platformWidgets = <Widget>[];
  for (var i = 0; i < platformItems.length; i++) {
    final pi = platformItems[i];
    final piColor = pi['color'] as Color;
    print('Platform ${i + 1}: ${pi['title']}');
    platformWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [piColor.withOpacity(0.08), piColor.withOpacity(0.02)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: piColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: piColor.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      pi['icon'] as IconData,
                      color: piColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      pi['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: piColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                pi['desc'] as String,
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
                  color: piColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  pi['specs'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: piColor,
                    height: 1.5,
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
  // SECTION 6: Custom Decoration
  // ============================================================
  print('=== Section 6: Custom ===');

  final customExamples = <Map<String, dynamic>>[
    {
      'title': 'Brand-Colored Loupe',
      'desc': 'Match the magnifier border to your app\'s brand color. '
          'Use a RoundedRectangleBorder with a side color matching '
          'your theme\'s primary.',
      'code': 'MagnifierDecoration(\n'
          '  shape: RoundedRectangleBorder(\n'
          '    borderRadius: BorderRadius.circular(16),\n'
          '    side: BorderSide(\n'
          '      color: Theme.of(context).primaryColor,\n'
          '      width: 2,\n'
          '    ),\n'
          '  ),\n'
          '  shadows: [\n'
          '    BoxShadow(\n'
          '      color: Colors.black26,\n'
          '      blurRadius: 10,\n'
          '    ),\n'
          '  ],\n'
          ')',
      'color': Colors.amber,
    },
    {
      'title': 'Ghost Magnifier (Low Opacity)',
      'desc': 'Reduce decoration opacity for a subtle, non-distracting '
          'loupe. The magnified content is still fully visible, but '
          'the border and shadow become faint.',
      'code': 'MagnifierDecoration(\n'
          '  opacity: 0.4,\n'
          '  shape: RoundedRectangleBorder(\n'
          '    borderRadius: BorderRadius.circular(12),\n'
          '    side: BorderSide(color: Colors.grey),\n'
          '  ),\n'
          '  shadows: [],  // No shadow for minimal UI\n'
          ')',
      'color': Colors.blue,
    },
    {
      'title': 'Multi-Shadow Glow',
      'desc': 'Stack multiple BoxShadows for a glowing effect. An inner '
          'tight glow plus an outer spread creates depth and draws '
          'attention to the magnifier.',
      'code': 'MagnifierDecoration(\n'
          '  shape: CircleBorder(\n'
          '    side: BorderSide(color: Colors.white, width: 1),\n'
          '  ),\n'
          '  shadows: [\n'
          '    BoxShadow(\n'
          '      color: Colors.blue.withOpacity(0.4),\n'
          '      blurRadius: 4,\n'
          '      spreadRadius: 1,\n'
          '    ),\n'
          '    BoxShadow(\n'
          '      color: Colors.blue.withOpacity(0.15),\n'
          '      blurRadius: 16,\n'
          '      spreadRadius: 4,\n'
          '    ),\n'
          '  ],\n'
          ')',
      'color': Colors.green,
    },
  ];

  final customWidgets = <Widget>[];
  for (var i = 0; i < customExamples.length; i++) {
    final ce = customExamples[i];
    final ceColor = ce['color'] as Color;
    print('Custom ${i + 1}: ${ce['title']}');
    customWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ceColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ceColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ce['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ceColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ce['desc'] as String,
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
                  color: ceColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ce['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: ceColor,
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
  // SECTION 7: Integration
  // ============================================================
  print('=== Section 7: Integration ===');

  final integrationItems = <Map<String, dynamic>>[
    {
      'title': 'With magnifierBuilder on TextField',
      'desc': 'TextField exposes a magnifierConfiguration parameter. '
          'Supply a TextMagnifierConfiguration with a custom builder '
          'that returns your styled magnifier.',
      'code': 'TextField(\n'
          '  magnifierConfiguration: TextMagnifierConfiguration(\n'
          '    magnifierBuilder: (context, controller, overlay) {\n'
          '      return RawMagnifier(\n'
          '        decoration: MagnifierDecoration(\n'
          '          shape: RoundedRectangleBorder(\n'
          '            borderRadius: BorderRadius.circular(20),\n'
          '            side: BorderSide(color: Colors.amber, width: 2),\n'
          '          ),\n'
          '          shadows: [BoxShadow(blurRadius: 8, color: Colors.black26)],\n'
          '        ),\n'
          '        magnificationScale: 1.5,\n'
          '        size: Size(100, 60),\n'
          '        focalPointOffset: Offset.zero,\n'
          '      );\n'
          '    },\n'
          '  ),\n'
          ')',
      'color': Colors.amber,
    },
    {
      'title': 'With EditableText',
      'desc': 'EditableText also accepts magnifierConfiguration. This is '
          'the low-level text editing widget. Custom text editors that '
          'bypass TextField can still use MagnifierDecoration.',
      'code': 'EditableText(\n'
          '  controller: textController,\n'
          '  focusNode: focusNode,\n'
          '  style: textStyle,\n'
          '  cursorColor: Colors.amber,\n'
          '  backgroundCursorColor: Colors.grey,\n'
          '  magnifierConfiguration: TextMagnifierConfiguration(\n'
          '    magnifierBuilder: (ctx, ctrl, overlay) {\n'
          '      return buildCustomMagnifier(ctrl);\n'
          '    },\n'
          '  ),\n'
          ')',
      'color': Colors.blue,
    },
    {
      'title': 'Disable the Magnifier',
      'desc': 'To completely hide the magnifier, return SizedBox.shrink '
          'from the builder. Useful for desktop platforms or when the '
          'text is large enough to not need magnification.',
      'code': 'TextField(\n'
          '  magnifierConfiguration: TextMagnifierConfiguration(\n'
          '    magnifierBuilder: (_, __, ___) => SizedBox.shrink(),\n'
          '  ),\n'
          ')',
      'color': Colors.green,
    },
  ];

  final integrationWidgets = <Widget>[];
  for (var i = 0; i < integrationItems.length; i++) {
    final ii = integrationItems[i];
    final iiColor = ii['color'] as Color;
    print('Integration ${i + 1}: ${ii['title']}');
    integrationWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: iiColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: iiColor.withOpacity(0.2)),
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
                      color: iiColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: iiColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      ii['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: iiColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                ii['desc'] as String,
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
                  color: iiColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ii['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: iiColor,
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
      'icon': Icons.search,
      'text': 'MagnifierDecoration defines shape, shadows, and opacity '
          'of the text magnifier loupe.',
    },
    {
      'icon': Icons.shape_line,
      'text': 'shape accepts any ShapeBorder — RoundedRectangleBorder, '
          'CircleBorder, StadiumBorder, and more.',
    },
    {
      'icon': Icons.blur_on,
      'text': 'shadows accepts a List<BoxShadow> for elevation effects. '
          'Empty list removes all shadows.',
    },
    {
      'icon': Icons.opacity,
      'text': 'opacity controls the decoration transparency (0.0–1.0) '
          'without affecting the magnified content.',
    },
    {
      'icon': Icons.phone_android,
      'text': 'Material and Cupertino magnifiers use different default '
          'decorations. TextMagnifier selects adaptively.',
    },
    {
      'icon': Icons.build,
      'text': 'Custom magnifiers: provide a magnifierBuilder on '
          'TextField or EditableText with a RawMagnifier.',
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
          color: Colors.amber.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.amber.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.amber.shade800,
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
        title: const Text('MagnifierDecoration'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.shape_line), text: 'Shapes'),
            Tab(icon: Icon(Icons.blur_on), text: 'Shadows'),
            Tab(icon: Icon(Icons.phone_android), text: 'Platform'),
            Tab(icon: Icon(Icons.palette), text: 'Custom'),
            Tab(icon: Icon(Icons.integration_instructions), text: 'Integrate'),
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
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'MagnifierDecoration: style the text magnifier loupe '
                  'with shape, shadows, and opacity.',
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
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'MagnifierDecoration constructor parameters.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),

          // Tab 3: Shapes
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Different ShapeBorder choices for the magnifier.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...shapeWidgets,
            ],
          ),

          // Tab 4: Shadows
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Shadow styles: from none to dramatic elevation.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...shadowWidgets,
            ],
          ),

          // Tab 5: Platform
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Material vs Cupertino vs Custom magnifier styles.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...platformWidgets,
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
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Creating custom MagnifierDecoration instances.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...customWidgets,
            ],
          ),

          // Tab 7: Integrate
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Wiring custom decorations into TextField and EditableText.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...integrationWidgets,
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
                      Colors.amber.withOpacity(0.12),
                      Colors.orange.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about MagnifierDecoration.',
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

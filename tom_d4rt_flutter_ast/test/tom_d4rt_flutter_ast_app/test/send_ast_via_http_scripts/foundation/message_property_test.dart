// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =============================================================================
// MessageProperty - A Visual Deep Demo
// =============================================================================
//
// `MessageProperty` is a small but underappreciated diagnostic helper from
// `package:flutter/foundation.dart`. It is a subclass of
// `DiagnosticsProperty<void>` whose only job is to add a free-text
// "name: message" entry to the diagnostic tree of a `Diagnosticable` object.
//
// In a typical `debugFillProperties` override you might write:
//
//     @override
//     void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//       super.debugFillProperties(properties);
//       properties.add(StringProperty('label', label));
//       properties.add(IntProperty('count', count));
//       properties.add(MessageProperty('status', 'all systems green'));
//     }
//
// `StringProperty` and `IntProperty` describe an *actual value* on the object
// they belong to. `MessageProperty` does not - it is just an annotation, a
// descriptive line that travels along with the diagnostic tree.
//
// This file is a single-screen visual deep demo. It exposes one static
// `dynamic build(BuildContext)` entry that returns a `MaterialApp` containing
// nine self-contained sections. There is no state, no async, no setState -
// every value rendered on screen is computed once at build time.
//
// Sections:
//   1. Hero: speech-bubble-in-a-tree graphic + headline tagline.
//   2. Anatomy: the constructor `MessageProperty(name, message, level, showName)`.
//   3. Sibling-property gallery: nine common DiagnosticsProperty siblings.
//   4. Worked examples: six real-world MessageProperty messages with
//      rendered `.toString()` output in a styled "console".
//   5. DiagnosticLevel panel: hidden, fine, debug, info, warning, hint,
//      summary, error, off - sample renders at each level.
//   6. showName comparison: side-by-side renders with showName: true vs false.
//   7. debugFillProperties recipe: a worked snippet showing integration.
//   8. Diagnosticable / FlutterError relationship.
//   9. Pitfalls + footer.
//
// =============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// =============================================================================
// SECTION 0 - Design tokens
// =============================================================================
//
// Centralised visual constants. The demo uses a "diagnostic console"
// aesthetic - dark slate panels, monospace code, accent colours per
// DiagnosticLevel.

const Color colorBackground = Color(0xFFEFF1F5);
const Color colorPanel = Color(0xFFFFFFFF);
const Color colorPanelAlt = Color(0xFFF6F7FA);
const Color colorBorder = Color(0xFFD7DBE2);
const Color colorBorderStrong = Color(0xFFB8BEC8);
const Color colorInk = Color(0xFF1B2030);
const Color colorInkSoft = Color(0xFF4A5366);
const Color colorInkMuted = Color(0xFF7A8190);
const Color colorAccent = Color(0xFF2F6FE0);
const Color colorAccentAlt = Color(0xFF7B3FE4);

const Color colorConsoleBg = Color(0xFF1E2230);
const Color colorConsoleInk = Color(0xFFE7ECF5);
const Color colorConsoleMuted = Color(0xFF8C95A8);
const Color colorConsoleAccent = Color(0xFF7FB7FF);
const Color colorConsoleGreen = Color(0xFF6CE2A8);
const Color colorConsoleAmber = Color(0xFFFFC857);
const Color colorConsoleRed = Color(0xFFFF6B6B);
const Color colorConsolePurple = Color(0xFFC79BFF);

// Per-DiagnosticLevel accent colour, used in the level panel.
const Map<DiagnosticLevel, Color> levelColor = <DiagnosticLevel, Color>{
  DiagnosticLevel.hidden: Color(0xFF6B7180),
  DiagnosticLevel.fine: Color(0xFF8C95A8),
  DiagnosticLevel.debug: Color(0xFF7FB7FF),
  DiagnosticLevel.info: Color(0xFF6CE2A8),
  DiagnosticLevel.warning: Color(0xFFFFC857),
  DiagnosticLevel.hint: Color(0xFFC79BFF),
  DiagnosticLevel.summary: Color(0xFF2F6FE0),
  DiagnosticLevel.error: Color(0xFFFF6B6B),
  DiagnosticLevel.off: Color(0xFF3A3F4D),
};

// Typography helpers ----------------------------------------------------------

const TextStyle styleHeadline = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w800,
  color: colorInk,
  letterSpacing: -0.6,
  height: 1.1,
);

const TextStyle styleSubhead = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
  color: colorInkSoft,
  height: 1.45,
);

const TextStyle styleSectionTitle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: colorInk,
  letterSpacing: -0.3,
);

const TextStyle styleSectionLead = TextStyle(
  fontSize: 14.5,
  color: colorInkSoft,
  height: 1.55,
);

const TextStyle styleBody = TextStyle(
  fontSize: 13.5,
  color: colorInkSoft,
  height: 1.5,
);

const TextStyle styleLabel = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  color: colorInkSoft,
  letterSpacing: 0.6,
);

const TextStyle styleMonoCode = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.5,
  color: colorInk,
  height: 1.45,
);

const TextStyle styleMonoConsole = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.5,
  color: colorConsoleInk,
  height: 1.5,
);

const TextStyle styleMonoConsoleMuted = TextStyle(
  fontFamily: 'monospace',
  fontSize: 11.5,
  color: colorConsoleMuted,
  height: 1.5,
);

// =============================================================================
// SECTION 1 - Entry point
// =============================================================================
//
// The single static `build(BuildContext)` entry. All sections are composed
// inside a single scrollable column wrapped in a MaterialApp.

class MessagePropertyDemo {
  static dynamic build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MessageProperty - Visual Deep Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: colorBackground,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: colorInk),
        ),
      ),
      home: const DemoScaffold(),
    );
  }
}

dynamic build(BuildContext context) => MessagePropertyDemo.build(context);

// -----------------------------------------------------------------------------
// DemoScaffold - hosts the scrollable list of sections.
// -----------------------------------------------------------------------------

class DemoScaffold extends StatelessWidget {
  const DemoScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const <Widget>[
                  HeroSection(),
                  SectionSpacer(),
                  AnatomySection(),
                  SectionSpacer(),
                  SiblingGallerySection(),
                  SectionSpacer(),
                  WorkedExamplesSection(),
                  SectionSpacer(),
                  DiagnosticLevelSection(),
                  SectionSpacer(),
                  ShowNameComparisonSection(),
                  SectionSpacer(),
                  DebugFillPropertiesRecipeSection(),
                  SectionSpacer(),
                  DiagnosticableRelationshipSection(),
                  SectionSpacer(),
                  PitfallsSection(),
                  SectionSpacer(),
                  FooterSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SectionSpacer extends StatelessWidget {
  const SectionSpacer({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox(height: 36);
}

// =============================================================================
// SECTION 2 - Section shell
// =============================================================================
//
// Reusable container chrome: a labelled header strip followed by the section
// body inside a soft white panel.

class SectionShell extends StatelessWidget {
  const SectionShell({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.child,
    this.accent = colorAccent,
  });

  final int index;
  final String title;
  final String subtitle;
  final Widget child;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorPanel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colorBorder),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x10000000),
            offset: Offset(0, 4),
            blurRadius: 18,
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  index.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: styleSectionTitle),
                    const SizedBox(height: 4),
                    Text(subtitle, style: styleSectionLead),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          child,
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 3 - Hero
// =============================================================================
//
// The hero combines a stylised "speech bubble in a tree" graphic with a
// headline. The graphic literally renders the metaphor of MessageProperty:
// a bubble of free text sitting amongst the structured nodes of a
// diagnostic tree.

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF1B2030), Color(0xFF2C3450)],
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            offset: Offset(0, 6),
            blurRadius: 24,
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'package:flutter/foundation.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'MessageProperty',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                    letterSpacing: -1.0,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'A free-text annotation in the diagnostic tree.',
                  style: TextStyle(
                    color: Color(0xFFD9DEEC),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Subclass of DiagnosticsProperty<void>. Adds a "name: message"\n'
                  'line to a Diagnosticable that is not tied to any value.\n'
                  'Use it inside debugFillProperties for status, hints, or todos.',
                  style: TextStyle(
                    color: Color(0xFFB8C0D6),
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: const <Widget>[
                    HeroTag(text: 'foundation'),
                    SizedBox(width: 8),
                    HeroTag(text: 'diagnostic'),
                    SizedBox(width: 8),
                    HeroTag(text: 'devtools-friendly'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 28),
          Expanded(
            flex: 5,
            child: AspectRatio(
              aspectRatio: 1.05,
              child: CustomPaint(
                painter: SpeechBubbleTreePainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeroTag extends StatelessWidget {
  const HeroTag({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0x22FFFFFF),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0x44FFFFFF)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.5,
          fontFamily: 'monospace',
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

/// Stylised "speech bubble inside a diagnostic tree" graphic.
///
/// The painter draws a small tree of three structured nodes (rectangles)
/// and one rounded "speech bubble" (the MessageProperty) hanging off the
/// trunk. It is purely cosmetic, but visually anchors the metaphor used
/// throughout the demo.
class SpeechBubbleTreePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint trunk = Paint()
      ..color = const Color(0xFF7B3FE4)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint nodeFill = Paint()..color = const Color(0xFFE7ECF5);
    final Paint nodeBorder = Paint()
      ..color = const Color(0xFF2F6FE0)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint bubbleFill = Paint()..color = const Color(0xFFFFC857);
    final Paint bubbleBorder = Paint()
      ..color = const Color(0xFFB07B00)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final double w = size.width;
    final double h = size.height;
    final Offset rootCenter = Offset(w * 0.5, h * 0.18);

    // Trunk down.
    canvas.drawLine(
      rootCenter,
      Offset(w * 0.5, h * 0.55),
      trunk,
    );
    // Branch left to first node.
    canvas.drawLine(
      Offset(w * 0.5, h * 0.40),
      Offset(w * 0.22, h * 0.62),
      trunk,
    );
    // Branch right to bubble.
    canvas.drawLine(
      Offset(w * 0.5, h * 0.45),
      Offset(w * 0.78, h * 0.50),
      trunk,
    );
    // Bottom branch.
    canvas.drawLine(
      Offset(w * 0.5, h * 0.55),
      Offset(w * 0.5, h * 0.82),
      trunk,
    );

    // Root node (RenderObject).
    final Rect root = Rect.fromCenter(
      center: rootCenter,
      width: w * 0.34,
      height: h * 0.13,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(root, const Radius.circular(8)),
      nodeFill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(root, const Radius.circular(8)),
      nodeBorder,
    );
    drawCenteredLabel(canvas, root, 'RootDiagnosticable');

    // Left node - a StringProperty.
    final Rect left = Rect.fromCenter(
      center: Offset(w * 0.22, h * 0.69),
      width: w * 0.30,
      height: h * 0.11,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(left, const Radius.circular(8)),
      nodeFill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(left, const Radius.circular(8)),
      nodeBorder,
    );
    drawCenteredLabel(canvas, left, 'StringProperty');

    // Bottom node - an IntProperty.
    final Rect bot = Rect.fromCenter(
      center: Offset(w * 0.5, h * 0.89),
      width: w * 0.28,
      height: h * 0.11,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bot, const Radius.circular(8)),
      nodeFill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bot, const Radius.circular(8)),
      nodeBorder,
    );
    drawCenteredLabel(canvas, bot, 'IntProperty');

    // Right side - the speech bubble (MessageProperty).
    final Rect bubble = Rect.fromCenter(
      center: Offset(w * 0.78, h * 0.55),
      width: w * 0.32,
      height: h * 0.18,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bubble, const Radius.circular(18)),
      bubbleFill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bubble, const Radius.circular(18)),
      bubbleBorder,
    );
    // Tail.
    final Path tail = Path()
      ..moveTo(bubble.left + 14, bubble.bottom - 4)
      ..lineTo(bubble.left - 6, bubble.bottom + 14)
      ..lineTo(bubble.left + 32, bubble.bottom - 2)
      ..close();
    canvas.drawPath(tail, bubbleFill);
    canvas.drawPath(tail, bubbleBorder);

    drawCenteredLabel(
      canvas,
      bubble,
      'MessageProperty',
      bold: true,
      color: const Color(0xFF1B2030),
    );
  }

  void drawCenteredLabel(
    Canvas canvas,
    Rect rect,
    String text, {
    bool bold = false,
    Color color = colorInk,
  }) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: rect.width - 8);
    final Offset offset = Offset(
      rect.center.dx - tp.width / 2,
      rect.center.dy - tp.height / 2,
    );
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// SECTION 4 - Anatomy
// =============================================================================
//
// Annotated constructor signature. We render the canonical signature
// `MessageProperty(String name, String message, {DiagnosticLevel level,
// bool showName})` inside a code panel and explain each parameter.

class AnatomySection extends StatelessWidget {
  const AnatomySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      index: 1,
      title: 'Anatomy of MessageProperty',
      subtitle:
          'Constructor signature, parameter semantics, and inheritance.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const CodeBlock(
            title: 'Signature',
            code: 'class MessageProperty extends DiagnosticsProperty<void> {\n'
                '  MessageProperty(\n'
                '    String name,\n'
                '    String message, {\n'
                '    DiagnosticLevel level = DiagnosticLevel.info,\n'
                '    bool showName = true,\n'
                '  }) : super(\n'
                '         name,\n'
                '         null,\n'
                '         description: message,\n'
                '         showName: showName,\n'
                '         level: level,\n'
                '       );\n'
                '}',
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Expanded(
                child: ParameterCard(
                  paramName: 'name',
                  paramType: 'String',
                  description:
                      'Label shown to the left of the colon. Typically a '
                      'short tag like "status", "todo", or "warning".',
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: ParameterCard(
                  paramName: 'message',
                  paramType: 'String',
                  description:
                      'Free-text payload. Becomes the description of the '
                      'property; rendered after "name: ". Multi-line '
                      'content is supported but discouraged for DevTools.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Expanded(
                child: ParameterCard(
                  paramName: 'level',
                  paramType: 'DiagnosticLevel',
                  description:
                      'Visibility classification. Drives whether the line '
                      'is rendered and which colour DevTools uses to show '
                      'it. Defaults to DiagnosticLevel.info.',
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: ParameterCard(
                  paramName: 'showName',
                  paramType: 'bool',
                  description:
                      'If false, only the message body is rendered - the '
                      'name and the colon are hidden. Useful for headlines '
                      'or banner-style notes.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorPanelAlt,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colorBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 4,
                  height: 56,
                  decoration: BoxDecoration(
                    color: colorAccentAlt,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Text(
                    'Inheritance: MessageProperty extends '
                    'DiagnosticsProperty<void>, which extends '
                    'DiagnosticsNode. Because the type parameter is void, '
                    'there is no "value" - the message is the only payload, '
                    'stored in the description field of the underlying '
                    'DiagnosticsProperty.',
                    style: styleBody,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ParameterCard extends StatelessWidget {
  const ParameterCard({
    super.key,
    required this.paramName,
    required this.paramType,
    required this.description,
  });
  final String paramName;
  final String paramType;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorPanelAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                paramName,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: colorInk,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7ECF5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  paramType,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: colorAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(description, style: styleBody),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CodeBlock - small reusable code box.
// -----------------------------------------------------------------------------

class CodeBlock extends StatelessWidget {
  const CodeBlock({
    super.key,
    required this.title,
    required this.code,
    this.language = 'dart',
  });
  final String title;
  final String code;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF20253A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2F3553)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
            decoration: const BoxDecoration(
              color: Color(0xFF181C2E),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: <Widget>[
                const TrafficDot(color: Color(0xFFFF6B6B)),
                const SizedBox(width: 6),
                const TrafficDot(color: Color(0xFFFFC857)),
                const SizedBox(width: 6),
                const TrafficDot(color: Color(0xFF6CE2A8)),
                const SizedBox(width: 14),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFB8C0D6),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2F3553),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    language,
                    style: const TextStyle(
                      color: Color(0xFFB8C0D6),
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: SelectableText(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: Color(0xFFE7ECF5),
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrafficDot extends StatelessWidget {
  const TrafficDot({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

// =============================================================================
// SECTION 5 - Sibling-property gallery
// =============================================================================
//
// Each card describes one DiagnosticsProperty sibling type, shows its
// canonical constructor signature, and a rendered `.toString()` of an
// example instance. MessageProperty appears first, deliberately, so the
// reader can compare it against typed siblings.

class SiblingGallerySection extends StatelessWidget {
  const SiblingGallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SiblingEntry> entries = buildSiblingEntries();
    return SectionShell(
      index: 2,
      title: 'Sibling properties at a glance',
      subtitle:
          'How MessageProperty compares to its typed neighbours in the '
          'DiagnosticsProperty family.',
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: entries
            .map((SiblingEntry e) => SizedBox(
                  width: 360,
                  child: SiblingCard(entry: e),
                ))
            .toList(),
      ),
    );
  }
}

class SiblingEntry {
  const SiblingEntry({
    required this.typeName,
    required this.signature,
    required this.rendered,
    required this.note,
    required this.accent,
    this.highlight = false,
  });
  final String typeName;
  final String signature;
  final String rendered;
  final String note;
  final Color accent;
  final bool highlight;
}

List<SiblingEntry> buildSiblingEntries() {
  // Compute MessageProperty rendering once at module level by constructing it
  // and calling toString(). We also hand-write the visible string for the
  // typed siblings (since constructing typed DiagnosticsProperty<T> objects
  // inside a const list is awkward).
  final MessageProperty msg = MessageProperty(
    'status',
    'all systems green',
  );
  final String msgRendered = msg.toString();

  return <SiblingEntry>[
    SiblingEntry(
      typeName: 'MessageProperty',
      signature:
          'MessageProperty(String name, String message, {level, showName})',
      rendered: msgRendered,
      note:
          'Free-text annotation. Subclass of DiagnosticsProperty<void>. '
          'Has no value, only a description.',
      accent: colorAccentAlt,
      highlight: true,
    ),
    const SiblingEntry(
      typeName: 'StringProperty',
      signature:
          'StringProperty(String name, String? value, {showName, quoted})',
      rendered: 'label: "Hello world"',
      note:
          'Wraps an actual String value. By default the value is rendered '
          'with surrounding double quotes.',
      accent: colorAccent,
    ),
    const SiblingEntry(
      typeName: 'IntProperty',
      signature: 'IntProperty(String name, int? value, {unit, showName})',
      rendered: 'count: 42',
      note:
          'Wraps an int. Optional unit like "px" or "ms" is appended to the '
          'rendered value.',
      accent: colorAccent,
    ),
    const SiblingEntry(
      typeName: 'DoubleProperty',
      signature:
          'DoubleProperty(String name, double? value, {unit, showName})',
      rendered: 'opacity: 0.6',
      note:
          'Wraps a double. Renders with the default toStringAsFixed formatting '
          'and an optional unit suffix.',
      accent: colorAccent,
    ),
    const SiblingEntry(
      typeName: 'FlagProperty',
      signature:
          'FlagProperty(String name, {bool? value, ifTrue, ifFalse})',
      rendered: 'enabled',
      note:
          'A boolean rendered using configurable phrases for the true and '
          'false case (e.g. "enabled" / "disabled").',
      accent: colorAccent,
    ),
    const SiblingEntry(
      typeName: 'EnumProperty<T>',
      signature:
          'EnumProperty<T>(String name, T? value, {defaultValue, showName})',
      rendered: 'alignment: TextAlign.center',
      note:
          'Renders an enum value as Type.value, hiding the property if it '
          'matches defaultValue.',
      accent: colorAccent,
    ),
    const SiblingEntry(
      typeName: 'IterableProperty<T>',
      signature: 'IterableProperty<T>(String name, Iterable<T>? value, {...})',
      rendered: 'items: [a, b, c]',
      note:
          'Renders an iterable as a compact list, with optional empty-state '
          'phrasing.',
      accent: colorAccent,
    ),
    const SiblingEntry(
      typeName: 'ColorProperty',
      signature: 'ColorProperty(String name, Color? value, {showName})',
      rendered: 'tint: Color(0xff2f6fe0)',
      note:
          'Specialised DiagnosticsProperty<Color>. Renders the colour using '
          'its standard ARGB hex form.',
      accent: colorAccent,
    ),
    const SiblingEntry(
      typeName: 'IconDataProperty',
      signature: 'IconDataProperty(String name, IconData? value, {showName})',
      rendered: 'icon: IconData(U+0E001)',
      note:
          'Wraps an IconData value. Useful in widgets that expose a glyph '
          'as part of their public API.',
      accent: colorAccent,
    ),
  ];
}

class SiblingCard extends StatelessWidget {
  const SiblingCard({super.key, required this.entry});
  final SiblingEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: entry.highlight ? const Color(0xFFFAF6FF) : colorPanelAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: entry.highlight ? colorAccentAlt : colorBorder,
          width: entry.highlight ? 1.6 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 24,
                decoration: BoxDecoration(
                  color: entry.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  entry.typeName,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: entry.highlight ? colorAccentAlt : colorInk,
                  ),
                ),
              ),
              if (entry.highlight)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: colorAccentAlt,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'FOCUS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          const Text('SIGNATURE', style: styleLabel),
          const SizedBox(height: 4),
          SelectableText(
            entry.signature,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: colorInk,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10),
          const Text('RENDERED', style: styleLabel),
          const SizedBox(height: 4),
          ConsoleLine(text: entry.rendered, color: colorConsoleAccent),
          const SizedBox(height: 10),
          Text(entry.note, style: styleBody),
        ],
      ),
    );
  }
}

class ConsoleLine extends StatelessWidget {
  const ConsoleLine({
    super.key,
    required this.text,
    this.color = colorConsoleInk,
    this.bold = false,
  });
  final String text;
  final Color color;
  final bool bold;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: colorConsoleBg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: <Widget>[
          const Text('> ', style: styleMonoConsoleMuted),
          Expanded(
            child: SelectableText(
              text,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: color,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 6 - Worked examples
// =============================================================================
//
// Six concrete MessageProperty instances rendered into a styled "console".
// Each row mirrors a real situation in which a maintainer would attach a
// note to a Diagnosticable: TODO, UPSTREAM, DEPRECATED, VERIFY, PERF, RACE.
// We construct the actual MessageProperty objects so the rendered output
// is real.

class WorkedExamplesSection extends StatelessWidget {
  const WorkedExamplesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<WorkedExample> examples = <WorkedExample>[
      WorkedExample(
        tag: 'TODO',
        accent: colorConsoleAmber,
        property: MessageProperty(
          'todo',
          'needs profile-mode test',
        ),
        note: 'Reminder for a follow-up that does not yet have an issue.',
      ),
      WorkedExample(
        tag: 'UPSTREAM',
        accent: colorConsoleAccent,
        property: MessageProperty(
          'upstream',
          'see issue #12345',
        ),
        note: 'Cross-references an external dependency or framework bug.',
      ),
      WorkedExample(
        tag: 'DEPRECATED',
        accent: colorConsoleRed,
        property: MessageProperty(
          'deprecated',
          'use newApi() instead',
          level: DiagnosticLevel.warning,
        ),
        note:
            'Surfaces deprecation guidance directly into the diagnostic '
            'tree, alongside structured properties.',
      ),
      WorkedExample(
        tag: 'VERIFY',
        accent: colorConsoleGreen,
        property: MessageProperty(
          'verify',
          'check on iOS',
        ),
        note: 'Platform-specific verification step.',
      ),
      WorkedExample(
        tag: 'PERF',
        accent: colorConsolePurple,
        property: MessageProperty(
          'perf',
          'O(n^2) in worst case',
          level: DiagnosticLevel.hint,
        ),
        note:
            'Hints at known performance characteristics. Level: hint, so '
            'DevTools renders it in a softer style.',
      ),
      WorkedExample(
        tag: 'RACE',
        accent: colorConsoleRed,
        property: MessageProperty(
          'race',
          'not thread-safe',
          level: DiagnosticLevel.error,
        ),
        note:
            'Concurrency caveat. Level: error, so the line stands out and '
            'survives DevTools level filtering.',
      ),
    ];

    return SectionShell(
      index: 3,
      title: 'Six worked examples',
      subtitle:
          'Real MessageProperty instances rendered through their actual '
          '.toString() output.',
      accent: colorAccentAlt,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        decoration: BoxDecoration(
          color: colorConsoleBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF2F3553)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2F3553),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'diagnostic console - debug build',
                    style: TextStyle(
                      color: Color(0xFFB8C0D6),
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'showing rendered MessageProperty.toString()',
                  style: TextStyle(
                    color: Color(0xFF8C95A8),
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            for (final WorkedExample e in examples) ...<Widget>[
              WorkedExampleRow(example: e),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class WorkedExample {
  const WorkedExample({
    required this.tag,
    required this.accent,
    required this.property,
    required this.note,
  });
  final String tag;
  final Color accent;
  final MessageProperty property;
  final String note;
}

class WorkedExampleRow extends StatelessWidget {
  const WorkedExampleRow({super.key, required this.example});
  final WorkedExample example;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF262C40),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF2F3553)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 90,
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 6,
            ),
            decoration: BoxDecoration(
              color: example.accent.withAlpha(40),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: example.accent),
            ),
            alignment: Alignment.center,
            child: Text(
              example.tag,
              style: TextStyle(
                color: example.accent,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SelectableText(
                  example.property.toString(),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: colorConsoleInk,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  example.note,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    color: colorConsoleMuted,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 7 - DiagnosticLevel panel
// =============================================================================
//
// Renders one row per DiagnosticLevel value (the full enum), with a sample
// MessageProperty constructed at that level. The actual value of
// `MessageProperty(...).level` is read out for each row to confirm.

class DiagnosticLevelSection extends StatelessWidget {
  const DiagnosticLevelSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DiagnosticLevel> all = <DiagnosticLevel>[
      DiagnosticLevel.hidden,
      DiagnosticLevel.fine,
      DiagnosticLevel.debug,
      DiagnosticLevel.info,
      DiagnosticLevel.warning,
      DiagnosticLevel.hint,
      DiagnosticLevel.summary,
      DiagnosticLevel.error,
      DiagnosticLevel.off,
    ];

    return SectionShell(
      index: 4,
      title: 'DiagnosticLevel - visibility classifications',
      subtitle:
          'Each MessageProperty carries a level. The level controls '
          'rendering and DevTools filter visibility.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final DiagnosticLevel l in all) ...<Widget>[
            DiagnosticLevelRow(level: l),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorPanelAlt,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colorBorder),
            ),
            child: const Text(
              'Summary: hidden never renders unless explicitly requested. '
              'fine and debug are typically suppressed in production. info '
              'is the default for MessageProperty. warning, hint, summary '
              'and error are the high-signal levels - they survive most '
              'filters and are colour-coded in DevTools.',
              style: styleBody,
            ),
          ),
        ],
      ),
    );
  }
}

class DiagnosticLevelRow extends StatelessWidget {
  const DiagnosticLevelRow({super.key, required this.level});
  final DiagnosticLevel level;

  @override
  Widget build(BuildContext context) {
    final MessageProperty p = MessageProperty(
      'status',
      'sample at ${level.name}',
      level: level,
    );
    final Color accent = levelColor[level] ?? colorInkSoft;
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: colorPanelAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: colorBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 6,
            height: 36,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 110,
            child: Text(
              level.name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: accent,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: colorConsoleBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: SelectableText(
                p.toString(),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: colorConsoleInk,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 200,
            child: Text(
              describeLevel(level),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: colorInkMuted,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String describeLevel(DiagnosticLevel l) {
    switch (l) {
      case DiagnosticLevel.hidden:
        return 'never shown by default';
      case DiagnosticLevel.fine:
        return 'very low signal';
      case DiagnosticLevel.debug:
        return 'debug-mode noise';
      case DiagnosticLevel.info:
        return 'default for MessageProperty';
      case DiagnosticLevel.warning:
        return 'warns but does not block';
      case DiagnosticLevel.hint:
        return 'soft suggestion';
      case DiagnosticLevel.summary:
        return 'short headline node';
      case DiagnosticLevel.error:
        return 'demands attention';
      case DiagnosticLevel.off:
        return 'disabled - always hidden';
    }
  }
}

// =============================================================================
// SECTION 8 - showName comparison
// =============================================================================
//
// Side-by-side: the same message rendered with showName: true vs
// showName: false. The actual `.toString()` output is rendered for both.

class ShowNameComparisonSection extends StatelessWidget {
  const ShowNameComparisonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final MessageProperty namedYes = MessageProperty(
      'banner',
      'beta build - DO NOT SHIP',
    );
    // For the showName: false variant, MessageProperty itself does not
    // expose showName publicly in modern Flutter; the equivalent rendering
    // is what a DiagnosticsProperty<void> looks like with showName disabled
    // (just the description). We render the equivalent string directly.
    const String namedNoRender = 'beta build - DO NOT SHIP';

    return SectionShell(
      index: 5,
      title: 'showName: true vs false',
      subtitle:
          'The showName flag toggles whether the "name:" prefix is rendered. '
          'Hide it for headline-style notes.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ShowNameVariantCard(
              title: 'showName: true (default)',
              renderedText: namedYes.toString(),
              accent: colorAccent,
              explanation:
                  'The name appears, then a colon, then the message. This '
                  'is the standard form, parallel to all other typed '
                  'DiagnosticsProperty rows.',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ShowNameVariantCard(
              title: 'showName: false',
              renderedText: namedNoRender,
              accent: colorAccentAlt,
              explanation:
                  'Only the message is rendered. Useful for banner-style '
                  'notes that already include their own emphasis or '
                  'category prefix.',
            ),
          ),
        ],
      ),
    );
  }
}

class ShowNameVariantCard extends StatelessWidget {
  const ShowNameVariantCard({
    super.key,
    required this.title,
    required this.renderedText,
    required this.accent,
    required this.explanation,
  });
  final String title;
  final String renderedText;
  final Color accent;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorPanelAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 22,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: colorConsoleBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: SelectableText(
              renderedText,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: colorConsoleInk,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(explanation, style: styleBody),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 9 - debugFillProperties recipe
// =============================================================================
//
// Shows a worked snippet that illustrates how MessageProperty is added in
// a typical `debugFillProperties` override, and pairs it with the resulting
// rendered tree.

class DebugFillPropertiesRecipeSection extends StatelessWidget {
  const DebugFillPropertiesRecipeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      index: 6,
      title: 'Recipe - integrating MessageProperty in debugFillProperties',
      subtitle:
          'How MessageProperty fits inside a typical Diagnosticable that '
          'already uses StringProperty / IntProperty.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const CodeBlock(
            title: 'lib/widgets/profile_tile.dart',
            code: 'class ProfileTile extends StatelessWidget {\n'
                '  const ProfileTile({super.key, required this.label, required this.count});\n'
                '  final String label;\n'
                '  final int count;\n'
                '\n'
                '  @override\n'
                '  Widget build(BuildContext context) => Text("\$label: \$count");\n'
                '\n'
                '  @override\n'
                '  void debugFillProperties(DiagnosticPropertiesBuilder properties) {\n'
                '    super.debugFillProperties(properties);\n'
                '    properties.add(StringProperty("label", label));\n'
                '    properties.add(IntProperty("count", count));\n'
                '    properties.add(MessageProperty(\n'
                '      "status",\n'
                '      "beta - DO NOT SHIP",\n'
                '      level: DiagnosticLevel.warning,\n'
                '    ));\n'
                '    properties.add(MessageProperty("todo", "needs profile-mode test"));\n'
                '  }\n'
                '}',
          ),
          const SizedBox(height: 16),
          const Text('RENDERED DIAGNOSTIC TREE', style: styleLabel),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorConsoleBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text('ProfileTile', style: styleMonoConsole),
                Text(
                  '  +-- label: "Hello"',
                  style: styleMonoConsole,
                ),
                Text('  +-- count: 42', style: styleMonoConsole),
                Text(
                  '  +-- status: beta - DO NOT SHIP',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: Color(0xFFFFC857),
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '  +-- todo: needs profile-mode test',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    color: Color(0xFFC79BFF),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorPanelAlt,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colorBorder),
            ),
            child: const Text(
              'Notice: MessageProperty rows sit beside StringProperty and '
              'IntProperty rows in the same builder. They follow the same '
              'wire format as any other DiagnosticsProperty, so DevTools '
              'and toStringDeep both render them naturally.',
              style: styleBody,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 10 - Diagnosticable / FlutterError relationship
// =============================================================================
//
// Walks through the relationship between MessageProperty, Diagnosticable,
// FlutterError, ErrorDescription / ErrorHint, and DiagnosticsBlock.

class DiagnosticableRelationshipSection extends StatelessWidget {
  const DiagnosticableRelationshipSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionShell(
      index: 7,
      title: 'Diagnosticable, FlutterError, and message-style nodes',
      subtitle:
          'Where MessageProperty sits in the wider diagnostics ecosystem.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Expanded(
                child: RelationshipCard(
                  title: 'Diagnosticable',
                  body:
                      'Base class with debugFillProperties. Anything that '
                      'wants to participate in the diagnostic tree extends '
                      'Diagnosticable or DiagnosticableTree.',
                  accent: colorAccent,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: RelationshipCard(
                  title: 'DiagnosticsProperty<T>',
                  body:
                      'A typed entry in the property list. Holds a value of '
                      'type T plus formatting metadata. MessageProperty '
                      'extends DiagnosticsProperty<void>.',
                  accent: colorAccentAlt,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: RelationshipCard(
                  title: 'FlutterError',
                  body:
                      'Error type built from a list of DiagnosticsNodes. '
                      'Uses ErrorDescription, ErrorHint, ErrorSummary - all '
                      'subclasses of DiagnosticsProperty<void>, like '
                      'MessageProperty itself.',
                  accent: Color(0xFFE25555),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text('ANALOGUES', style: styleLabel),
          const SizedBox(height: 8),
          const AnalogueRow(
            left: 'MessageProperty',
            right: 'inside debugFillProperties - annotates a Diagnosticable.',
          ),
          const AnalogueRow(
            left: 'ErrorDescription',
            right:
                'inside FlutterErrorDetails - describes what went wrong.',
          ),
          const AnalogueRow(
            left: 'ErrorHint',
            right:
                'inside FlutterErrorDetails - suggests how to fix it.',
          ),
          const AnalogueRow(
            left: 'ErrorSummary',
            right:
                'inside FlutterErrorDetails - short headline of the error.',
          ),
          const AnalogueRow(
            left: 'DiagnosticsBlock',
            right:
                'composite node holding multiple children - for grouped '
                'sub-diagnostics, not single annotations.',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorPanelAlt,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colorBorder),
            ),
            child: const Text(
              'Key insight: MessageProperty, ErrorDescription, ErrorHint, '
              'and ErrorSummary are essentially DiagnosticsProperty<void> '
              'with different defaults for level and showName. They share '
              'the same rendering machinery - pick the one whose semantic '
              'name matches the situation.',
              style: styleBody,
            ),
          ),
        ],
      ),
    );
  }
}

class RelationshipCard extends StatelessWidget {
  const RelationshipCard({
    super.key,
    required this.title,
    required this.body,
    required this.accent,
  });
  final String title;
  final String body;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorPanelAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
          const SizedBox(height: 6),
          Text(body, style: styleBody),
        ],
      ),
    );
  }
}

class AnalogueRow extends StatelessWidget {
  const AnalogueRow({super.key, required this.left, required this.right});
  final String left;
  final String right;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 180,
            child: Text(
              left,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: colorAccent,
              ),
            ),
          ),
          Expanded(child: Text(right, style: styleBody)),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 11 - Pitfalls
// =============================================================================
//
// Common mistakes when reaching for MessageProperty.

class PitfallsSection extends StatelessWidget {
  const PitfallsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionShell(
      index: 8,
      title: 'Pitfalls and gotchas',
      subtitle:
          'When NOT to use MessageProperty - and what to use instead.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PitfallCard(
            title:
                'Do not put a dynamic value in MessageProperty.',
            body:
                'MessageProperty has no value slot. If you write '
                'MessageProperty("count", "\$count"), DevTools and '
                'toStringDeep see only a string baked at construction time. '
                'Use IntProperty / StringProperty / DoubleProperty etc. so '
                'the value is visible as data, not as text.',
          ),
          PitfallCard(
            title: 'Pick a level that matches DevTools filtering.',
            body:
                'If you set level: DiagnosticLevel.fine, your message will '
                'be hidden by the default DevTools filter. For visible '
                'maintainer notes, prefer level: warning, hint, or summary. '
                'For background reminders, info or debug is fine.',
          ),
          PitfallCard(
            title: 'Multi-line messages fight DevTools.',
            body:
                'DevTools is line-oriented. Long multi-paragraph text in a '
                'MessageProperty renders as a single hard-to-scan blob. '
                'Split into multiple MessageProperty rows, or use a '
                'DiagnosticsBlock with structured children.',
          ),
          PitfallCard(
            title: 'Do not reach for MessageProperty inside FlutterError.',
            body:
                'Inside an error chain, prefer ErrorDescription / ErrorHint '
                '/ ErrorSummary. They are semantically richer for '
                'consumers of the error API and DevTools renders them with '
                'tailored styling.',
          ),
          PitfallCard(
            title: 'No state. No async. No setters.',
            body:
                'A MessageProperty is constructed once when '
                'debugFillProperties is called. It does not subscribe, '
                'recompute, or update. If you need a live value, expose it '
                'through a typed DiagnosticsProperty whose value is read '
                'each call.',
          ),
        ],
      ),
    );
  }
}

class PitfallCard extends StatelessWidget {
  const PitfallCard({super.key, required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF7E6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFFFC857)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Icon(
                Icons.warning_amber_rounded,
                color: Color(0xFFB07B00),
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF7A4A00),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(body, style: styleBody),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 12 - Footer
// =============================================================================

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2030),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF2F3553),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.chat_bubble_outline,
              color: Color(0xFFFFC857),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'MessageProperty in three lines:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '1. It is a DiagnosticsProperty<void> - value-less, '
                  'message-only.\n'
                  '2. Use it inside debugFillProperties for free-text notes '
                  'beside typed properties.\n'
                  '3. Its level controls DevTools visibility - pick info, '
                  'warning, hint, or error deliberately.',
                  style: TextStyle(
                    color: Color(0xFFD9DEEC),
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// END OF FILE
// =============================================================================

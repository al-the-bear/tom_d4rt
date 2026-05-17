// ignore_for_file: unused_element, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =============================================================================
//  Tooltip Feedback Visual Deep Demo
// =============================================================================
//
//  This file is a hand-written, single-entry visual reference for Flutter's
//  Material `Tooltip` widget. It focuses on the small but important family of
//  "feedback" parameters that control how a tooltip *physically* and
//  *acoustically* responds to the user, alongside the broader Tooltip API.
//
//  Specifically inspected here:
//
//      - enableFeedback        : bool        (haptic + sound on long-press)
//      - excludeFromSemantics  : bool        (hide message from a11y tree)
//      - triggerMode           : TooltipTriggerMode (manual/longPress/tap)
//      - enableTapToDismiss    : bool        (tap-anywhere dismiss)
//
//  Plus the surrounding canvas of related properties:
//
//      - message               : String      (plain text payload)
//      - richMessage           : InlineSpan  (TextSpan styled payload)
//      - decoration            : Decoration  (background bubble look)
//      - padding / margin      : EdgeInsets  (inner / outer spacing)
//      - verticalOffset        : double      (gap from anchor child)
//      - preferBelow           : bool        (placement preference)
//      - waitDuration          : Duration    (hover dwell to show)
//      - showDuration          : Duration    (linger time before fade)
//      - textStyle / textAlign : (text formatting)
//
//  Hard rules followed in this file:
//
//      - Single static `dynamic build(BuildContext)` entry point
//      - MaterialApp wrapper at the root
//      - No setState, no controllers, no async, no Future/Timer/streams
//      - PascalCase `_PrivateXxx` classes/typedefs
//      - lowerCamelCase `_privateXxx` top-level fns/vars
//      - No `.withOpacity(...)` -- `withValues(alpha: ...)` only
//      - No inline `// ignore:` comments
//
// =============================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
//  Color tokens
// -----------------------------------------------------------------------------

const Color _privateInk = Color(0xFF0F1B2A);
const Color _privateInkSoft = Color(0xFF1F2E40);
const Color _privatePaper = Color(0xFFF7F9FC);
const Color _privatePaperAlt = Color(0xFFEEF2F8);
const Color _privateAccent = Color(0xFF3D7DFF);
const Color _privateAccentDeep = Color(0xFF1F4DCC);
const Color _privateAccentSoft = Color(0xFFD9E5FF);
const Color _privateMint = Color(0xFF36C19B);
const Color _privatePeach = Color(0xFFFF8E5C);
const Color _privateRose = Color(0xFFE8557F);
const Color _privateAmber = Color(0xFFE0A800);
const Color _privatePlum = Color(0xFF7A4FB0);
const Color _privateSlate = Color(0xFF63738A);
const Color _privateLine = Color(0xFFCBD5E1);
const Color _privateLineSoft = Color(0xFFE2E8F0);
const Color _privateMutedBg = Color(0xFFF1F5FA);

// -----------------------------------------------------------------------------
//  Tiny typography helpers
// -----------------------------------------------------------------------------

TextStyle _privateTitle({double size = 22, Color color = _privateInk}) =>
    TextStyle(fontSize: size, fontWeight: FontWeight.w800, color: color);

TextStyle _privateSubtitle({double size = 15, Color color = _privateInkSoft}) =>
    TextStyle(fontSize: size, fontWeight: FontWeight.w600, color: color);

TextStyle _privateBody({double size = 13, Color color = _privateInkSoft}) =>
    TextStyle(
        fontSize: size, fontWeight: FontWeight.w400, color: color, height: 1.45);

TextStyle _privateCode({double size = 12.5, Color color = _privateInk}) =>
    TextStyle(
      fontSize: size,
      fontFamily: 'monospace',
      fontWeight: FontWeight.w500,
      color: color,
      height: 1.5,
    );

TextStyle _privateChipText({Color color = _privateInk}) => TextStyle(
      fontSize: 11.5,
      fontWeight: FontWeight.w700,
      color: color,
      letterSpacing: 0.4,
    );

// -----------------------------------------------------------------------------
//  Section scaffolding
// -----------------------------------------------------------------------------

Widget _privateSectionHeader(int n, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(4, 28, 4, 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_privateAccent, _privateAccentDeep],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _privateAccent.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            n.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _privateTitle(size: 21)),
              const SizedBox(height: 4),
              Text(subtitle, style: _privateBody(size: 13)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _privateCard({
  required Widget child,
  EdgeInsets padding = const EdgeInsets.all(18),
  Color background = Colors.white,
  Color border = _privateLineSoft,
  double radius = 16,
  List<BoxShadow>? shadow,
}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: border, width: 1),
      boxShadow: shadow ??
          [
            BoxShadow(
              color: _privateInk.withValues(alpha: 0.04),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
    ),
    child: child,
  );
}

Widget _privateChip(
  String text, {
  Color background = _privateAccentSoft,
  Color foreground = _privateAccentDeep,
  IconData? icon,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(999),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 13, color: foreground),
          const SizedBox(width: 5),
        ],
        Text(text, style: _privateChipText(color: foreground)),
      ],
    ),
  );
}

Widget _privateLabeledRow(String label, String value,
    {Color valueColor = _privateInk}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child:
              Text(label, style: _privateBody(size: 12.5, color: _privateSlate)),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 01 -- HERO CARD
// =============================================================================

Widget _privateHeroCard() {
  return Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      gradient: LinearGradient(
        colors: [_privateInk, _privateInkSoft, _privateAccentDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: _privateInk.withValues(alpha: 0.25),
          blurRadius: 22,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _privateChip(
                    'WIDGET',
                    background: Colors.white.withValues(alpha: 0.18),
                    foreground: Colors.white,
                    icon: Icons.touch_app_outlined,
                  ),
                  const SizedBox(width: 8),
                  _privateChip(
                    'MATERIAL',
                    background: Colors.white.withValues(alpha: 0.12),
                    foreground: Colors.white,
                    icon: Icons.palette_outlined,
                  ),
                  const SizedBox(width: 8),
                  _privateChip(
                    'A11Y',
                    background: Colors.white.withValues(alpha: 0.12),
                    foreground: Colors.white,
                    icon: Icons.accessibility_new_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Tooltip',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 46,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Feedback parameters & the full bubble lifecycle',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.86),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15)),
                ),
                child: const Text(
                  'enableFeedback - excludeFromSemantics - triggerMode - enableTapToDismiss',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 4,
          child: SizedBox(
            height: 220,
            child: CustomPaint(
              painter: _PrivateTooltipBubbleHero(),
              child: const SizedBox.expand(),
            ),
          ),
        ),
      ],
    ),
  );
}

class _PrivateTooltipBubbleHero extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint glow = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(size.width * 0.65, size.height * 0.55), 110, glow);
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.3), 70, glow);

    // Main bubble.
    final RRect bubble = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.18, size.height * 0.20, size.width * 0.66, 90),
      const Radius.circular(18),
    );
    final Paint bubblePaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white, _privateAccentSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bubble.outerRect);
    canvas.drawRRect(bubble, bubblePaint);

    // Tail.
    final Path tail = Path()
      ..moveTo(size.width * 0.40, size.height * 0.20 + 90)
      ..lineTo(size.width * 0.46, size.height * 0.20 + 110)
      ..lineTo(size.width * 0.52, size.height * 0.20 + 90)
      ..close();
    canvas.drawPath(tail, bubblePaint);

    // Bubble text bars.
    final Paint bar = Paint()..color = _privateInk.withValues(alpha: 0.7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.22, size.height * 0.27, 90, 8),
        const Radius.circular(4),
      ),
      bar,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.22, size.height * 0.32, 130, 8),
        const Radius.circular(4),
      ),
      bar..color = _privateInk.withValues(alpha: 0.45),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.22, size.height * 0.37, 70, 8),
        const Radius.circular(4),
      ),
      bar..color = _privateInk.withValues(alpha: 0.35),
    );

    // Anchor (the child the tooltip points to).
    final Paint anchor = Paint()..color = Colors.white;
    final RRect anchorRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.40, size.height * 0.20 + 130, 60, 38),
      const Radius.circular(8),
    );
    canvas.drawRRect(anchorRect, anchor);
    canvas.drawRRect(
      anchorRect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = _privateAccent,
    );
    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'i',
        style: TextStyle(
          color: _privateAccentDeep,
          fontSize: 22,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      Offset(size.width * 0.40 + 30 - tp.width / 2,
          size.height * 0.20 + 130 + 19 - tp.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
//  SECTION 02 -- TOOLTIP ANATOMY DIAGRAM
// =============================================================================

Widget _privateAnatomyDiagram() {
  return _privateCard(
    padding: const EdgeInsets.all(22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Anatomy of a Tooltip', style: _privateSubtitle(size: 17)),
        const SizedBox(height: 4),
        Text(
          'A target child renders normally; on hover/long-press the bubble appears '
          'with a tail pointing to the child. The bubble can sit above or below '
          'depending on viewport and `preferBelow`.',
          style: _privateBody(),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 280,
          child: CustomPaint(
            painter: _PrivateAnatomyPainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            _privateChip('1 - bubble', icon: Icons.chat_bubble_outline),
            _privateChip('2 - tail', icon: Icons.change_history),
            _privateChip('3 - anchor / child', icon: Icons.crop_square_outlined),
            _privateChip('4 - vertical offset', icon: Icons.height),
            _privateChip('5 - margin', icon: Icons.crop_free),
          ],
        ),
      ],
    ),
  );
}

class _PrivateAnatomyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint guide = Paint()
      ..color = _privateLine
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Bubble.
    final RRect bubble = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.18, 30, size.width * 0.46, 76),
      const Radius.circular(10),
    );
    canvas.drawRRect(bubble, Paint()..color = _privateInk);
    canvas.drawRRect(bubble, guide);

    // Tail.
    final Path tail = Path()
      ..moveTo(size.width * 0.36, 30 + 76)
      ..lineTo(size.width * 0.41, 30 + 90)
      ..lineTo(size.width * 0.46, 30 + 76)
      ..close();
    canvas.drawPath(tail, Paint()..color = _privateInk);

    // Bubble text bars.
    final Paint bar = Paint()..color = Colors.white.withValues(alpha: 0.85);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.21, 48, 130, 8),
        const Radius.circular(4),
      ),
      bar,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.21, 62, 100, 8),
        const Radius.circular(4),
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.55),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.21, 76, 60, 8),
        const Radius.circular(4),
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.4),
    );

    // Anchor.
    final RRect anchor = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.38, 156, 70, 50),
      const Radius.circular(8),
    );
    canvas.drawRRect(anchor, Paint()..color = _privateAccentSoft);
    canvas.drawRRect(
      anchor,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = _privateAccent,
    );

    // Vertical offset bracket.
    final Paint dim = Paint()
      ..color = _privateAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    final double offX = size.width * 0.62;
    canvas.drawLine(Offset(offX, 30 + 90), Offset(offX, 156), dim);
    canvas.drawLine(Offset(offX - 4, 30 + 90), Offset(offX + 4, 30 + 90), dim);
    canvas.drawLine(Offset(offX - 4, 156), Offset(offX + 4, 156), dim);

    final TextPainter labels = TextPainter(textDirection: TextDirection.ltr);

    void label(String text, Offset pos, {Color color = _privateInk}) {
      labels.text = TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      );
      labels.layout();
      labels.paint(canvas, pos);
    }

    label('1  bubble', Offset(size.width * 0.66, 50));
    label('2  tail', Offset(size.width * 0.66, 110));
    label('3  anchor (child)', Offset(size.width * 0.66, 170));
    label('4  verticalOffset', Offset(offX + 8, 120),
        color: _privateAccentDeep);
    label('5  margin', Offset(8, size.height - 26), color: _privateSlate);

    // Margin frame.
    canvas.drawRect(
      Rect.fromLTWH(6, 6, size.width - 12, size.height - 12),
      Paint()
        ..color = _privateAccent.withValues(alpha: 0.18)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
//  SECTION 03 -- enableFeedback PANEL
// =============================================================================

Widget _privateFeedbackPanel() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _privateChip('enableFeedback', icon: Icons.vibration),
            const SizedBox(width: 8),
            _privateChip('default: true',
                background: _privateMutedBg, foreground: _privateSlate),
          ],
        ),
        const SizedBox(height: 12),
        Text('Haptic & sound feedback', style: _privateSubtitle(size: 17)),
        const SizedBox(height: 6),
        Text(
          'When the user activates the tooltip via long-press the framework calls '
          'platform feedback (a click sound on Android, a haptic tick on supported '
          'devices). Setting `enableFeedback: false` mutes both. Mouse hover never '
          'triggers feedback regardless of the flag.',
          style: _privateBody(),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _privateFeedbackVariant(enabled: true)),
            const SizedBox(width: 12),
            Expanded(child: _privateFeedbackVariant(enabled: false)),
          ],
        ),
      ],
    ),
  );
}

Widget _privateFeedbackVariant({required bool enabled}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: enabled ? _privateAccentSoft : _privateMutedBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: enabled ? _privateAccent : _privateLine,
        width: 1.2,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              enabled ? Icons.volume_up_outlined : Icons.volume_off_outlined,
              size: 16,
              color: enabled ? _privateAccentDeep : _privateSlate,
            ),
            const SizedBox(width: 6),
            Text(
              enabled ? 'enableFeedback: true' : 'enableFeedback: false',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: enabled ? _privateAccentDeep : _privateSlate,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          enabled
              ? '- Long-press triggers a haptic tick.\n'
                  '- A short click is played on Android.\n'
                  '- Improves perceived responsiveness.'
              : '- No haptic on long-press.\n'
                  '- No system click sound.\n'
                  '- Useful in silent / focus modes.',
          style: _privateBody(size: 12.5),
        ),
        const SizedBox(height: 10),
        Tooltip(
          message: enabled ? 'Vibrates on long-press' : 'Quiet long-press',
          enableFeedback: enabled,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _privateLineSoft),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  enabled ? Icons.touch_app : Icons.touch_app_outlined,
                  size: 16,
                  color: _privateAccentDeep,
                ),
                const SizedBox(width: 6),
                Text(
                  'long-press me',
                  style: _privateBody(size: 12, color: _privateAccentDeep),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 04 -- triggerMode PANEL (manual / longPress / tap)
// =============================================================================

Widget _privateTriggerModePanel() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _privateChip('triggerMode', icon: Icons.gesture),
            const SizedBox(width: 8),
            _privateChip(
              'TooltipTriggerMode',
              background: _privateMutedBg,
              foreground: _privateSlate,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text('How the tooltip is summoned', style: _privateSubtitle(size: 17)),
        const SizedBox(height: 6),
        Text(
          'Three values: `manual` (the tooltip is fully driven by code via a '
          'GlobalKey and `ensureTooltipVisible`), `longPress` (the default touch '
          'gesture), and `tap` (single tap toggles the bubble). Mouse hover '
          'always shows the tooltip regardless of `triggerMode` since hover is '
          'a separate input pathway.',
          style: _privateBody(),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _privateTriggerModeCard(
                title: 'manual',
                icon: Icons.smart_toy_outlined,
                accent: _privatePlum,
                description: 'Tooltip never auto-opens.\n'
                    'Code drives `ensureTooltipVisible`\n'
                    'via a GlobalKey<TooltipState>.',
                tooltipTrigger: TooltipTriggerMode.manual,
                demoMessage: 'manually shown',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _privateTriggerModeCard(
                title: 'longPress',
                icon: Icons.pan_tool_alt_outlined,
                accent: _privateAccent,
                description: 'The default for touch.\n'
                    'User holds down for ~500ms\n'
                    'before the bubble appears.',
                tooltipTrigger: TooltipTriggerMode.longPress,
                demoMessage: 'long-press to show',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _privateTriggerModeCard(
                title: 'tap',
                icon: Icons.touch_app_outlined,
                accent: _privateMint,
                description: 'Single tap toggles bubble.\n'
                    'Fast feedback, but conflicts\n'
                    'with button onPressed.',
                tooltipTrigger: TooltipTriggerMode.tap,
                demoMessage: 'tapped open',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _privateTriggerModeCard({
  required String title,
  required IconData icon,
  required Color accent,
  required String description,
  required TooltipTriggerMode tooltipTrigger,
  required String demoMessage,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: accent, size: 16),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(description, style: _privateBody(size: 12)),
        const SizedBox(height: 12),
        Container(height: 1, color: _privateLineSoft),
        const SizedBox(height: 12),
        Center(
          child: Tooltip(
            message: demoMessage,
            triggerMode: tooltipTrigger,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'sample target',
                style: TextStyle(
                  color: accent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 05 -- excludeFromSemantics PANEL
// =============================================================================

Widget _privateSemanticsPanel() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _privateChip('excludeFromSemantics',
                icon: Icons.accessibility_new_outlined),
            const SizedBox(width: 8),
            _privateChip(
              'default: false',
              background: _privateMutedBg,
              foreground: _privateSlate,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text('Should the message be announced?',
            style: _privateSubtitle(size: 17)),
        const SizedBox(height: 6),
        Text(
          'By default the tooltip message is exposed to assistive tech as the '
          'child\'s a11y description. Setting `excludeFromSemantics: true` hides '
          'the message - useful when the child already has a richer label and '
          'you do not want duplicate announcements like "Save. Save the file.".',
          style: _privateBody(),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _privateSemanticsCard(
                exclude: false,
                announced: 'Save\nSave the current file',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _privateSemanticsCard(
                exclude: true,
                announced: 'Save',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _privateSemanticsCard(
    {required bool exclude, required String announced}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: exclude ? _privateMutedBg : _privateAccentSoft,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: exclude ? _privateLine : _privateAccent,
        width: 1.2,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exclude ? 'excludeFromSemantics: true' : 'excludeFromSemantics: false',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: exclude ? _privateSlate : _privateAccentDeep,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _privateLineSoft),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.record_voice_over_outlined,
                  size: 18, color: _privateAccentDeep),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Screen reader hears:\n$announced',
                  style: _privateBody(size: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Tooltip(
          message: 'Save the current file',
          excludeFromSemantics: exclude,
          child: Semantics(
            label: 'Save',
            button: true,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: _privateAccentDeep,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.save_outlined, size: 16, color: Colors.white),
                  SizedBox(width: 6),
                  Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 06 -- FROZEN-FRAME TOOLTIP MOCKUPS (4 directions)
// =============================================================================

Widget _privateFrozenFrames() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _privateChip('placement', icon: Icons.open_in_full),
            const SizedBox(width: 8),
            _privateChip('preferBelow / verticalOffset',
                background: _privateMutedBg, foreground: _privateSlate),
          ],
        ),
        const SizedBox(height: 12),
        Text('Bubble placement matrix', style: _privateSubtitle(size: 17)),
        const SizedBox(height: 6),
        Text(
          'Tooltips primarily flip above/below depending on `preferBelow` and '
          'the available viewport. Custom widgets may emulate left/right '
          'placement using `richMessage` and a custom decoration. The diagrams '
          'below are static mockups of the four conceptual directions.',
          style: _privateBody(),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(child: _privateFrame(_PrivateFrame.above)),
            const SizedBox(width: 10),
            Expanded(child: _privateFrame(_PrivateFrame.below)),
            const SizedBox(width: 10),
            Expanded(child: _privateFrame(_PrivateFrame.left)),
            const SizedBox(width: 10),
            Expanded(child: _privateFrame(_PrivateFrame.right)),
          ],
        ),
      ],
    ),
  );
}

enum _PrivateFrame { above, below, left, right }

Widget _privateFrame(_PrivateFrame frame) {
  String label;
  switch (frame) {
    case _PrivateFrame.above:
      label = 'above';
      break;
    case _PrivateFrame.below:
      label = 'below';
      break;
    case _PrivateFrame.left:
      label = 'left';
      break;
    case _PrivateFrame.right:
      label = 'right';
      break;
  }
  return Container(
    height: 180,
    decoration: BoxDecoration(
      color: _privatePaperAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _privateLineSoft),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: _privateChipText(color: _privateInkSoft)),
              const Icon(Icons.crop_free, size: 12, color: _privateSlate),
            ],
          ),
        ),
        Expanded(
          child: CustomPaint(
            painter: _PrivateFramePainter(frame),
            child: const SizedBox.expand(),
          ),
        ),
      ],
    ),
  );
}

class _PrivateFramePainter extends CustomPainter {
  _PrivateFramePainter(this.frame);
  final _PrivateFrame frame;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Rect anchor = Rect.fromCenter(center: center, width: 38, height: 28);

    // Anchor.
    canvas.drawRRect(
      RRect.fromRectAndRadius(anchor, const Radius.circular(6)),
      Paint()..color = Colors.white,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(anchor, const Radius.circular(6)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = _privateAccent,
    );

    Rect bubble;
    Path tail;
    switch (frame) {
      case _PrivateFrame.above:
        bubble = Rect.fromLTWH(center.dx - 50, anchor.top - 44, 100, 30);
        tail = Path()
          ..moveTo(center.dx - 5, anchor.top - 14)
          ..lineTo(center.dx, anchor.top - 6)
          ..lineTo(center.dx + 5, anchor.top - 14)
          ..close();
        break;
      case _PrivateFrame.below:
        bubble = Rect.fromLTWH(center.dx - 50, anchor.bottom + 14, 100, 30);
        tail = Path()
          ..moveTo(center.dx - 5, anchor.bottom + 14)
          ..lineTo(center.dx, anchor.bottom + 6)
          ..lineTo(center.dx + 5, anchor.bottom + 14)
          ..close();
        break;
      case _PrivateFrame.left:
        bubble = Rect.fromLTWH(anchor.left - 110, center.dy - 16, 90, 30);
        tail = Path()
          ..moveTo(anchor.left - 20, center.dy - 5)
          ..lineTo(anchor.left - 12, center.dy)
          ..lineTo(anchor.left - 20, center.dy + 5)
          ..close();
        break;
      case _PrivateFrame.right:
        bubble = Rect.fromLTWH(anchor.right + 20, center.dy - 16, 90, 30);
        tail = Path()
          ..moveTo(anchor.right + 20, center.dy - 5)
          ..lineTo(anchor.right + 12, center.dy)
          ..lineTo(anchor.right + 20, center.dy + 5)
          ..close();
        break;
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(bubble, const Radius.circular(8)),
      Paint()..color = _privateInk,
    );
    canvas.drawPath(tail, Paint()..color = _privateInk);

    // Bubble bars.
    final Paint bar = Paint()..color = Colors.white.withValues(alpha: 0.85);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(bubble.left + 8, bubble.top + 8, bubble.width - 30, 5),
        const Radius.circular(2),
      ),
      bar,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(bubble.left + 8, bubble.top + 17, bubble.width - 50, 5),
        const Radius.circular(2),
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.5),
    );

    // Anchor letter.
    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: 'i',
        style: TextStyle(
          color: _privateAccentDeep,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
        canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
//  SECTION 07 -- DECORATION & PADDING GALLERY
// =============================================================================

Widget _privateDecorationGallery() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _privateChip('decoration', icon: Icons.style_outlined),
            const SizedBox(width: 8),
            _privateChip('padding / margin / textStyle',
                background: _privateMutedBg, foreground: _privateSlate),
          ],
        ),
        const SizedBox(height: 12),
        Text('Bubble look gallery', style: _privateSubtitle(size: 17)),
        const SizedBox(height: 6),
        Text(
          'Five common bubble styles. The actual `Tooltip` widget below each '
          'mockup uses the same `decoration` so you can hover/long-press to see '
          'the live render.',
          style: _privateBody(),
        ),
        const SizedBox(height: 18),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _privateDecoCard(
                title: 'default',
                accent: _privateInk,
                decoration: const BoxDecoration(
                  color: _privateInk,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _privateDecoCard(
                title: 'gradient',
                accent: _privateAccentDeep,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_privateAccent, _privatePlum],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _privateDecoCard(
                title: 'rounded',
                accent: _privateMint,
                decoration: BoxDecoration(
                  color: _privateMint,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _privateDecoCard(
                title: 'dark-themed',
                accent: _privateInk,
                decoration: BoxDecoration(
                  color: _privateInk,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _privateAccent, width: 1.5),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _privateDecoCard(
                title: 'glassy',
                accent: _privateSlate,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _privateLine, width: 1),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                dark: false,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(child: Container()),
          ],
        ),
      ],
    ),
  );
}

Widget _privateDecoCard({
  required String title,
  required Color accent,
  required Decoration decoration,
  required EdgeInsetsGeometry padding,
  bool dark = true,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _privatePaperAlt,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _privateLineSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: accent,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: padding,
          decoration: decoration,
          child: Text(
            'Tooltip text',
            style: TextStyle(
              color: dark ? Colors.white : _privateInk,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Tooltip(
          message: 'live $title',
          decoration: decoration,
          padding: padding,
          textStyle: TextStyle(
            color: dark ? Colors.white : _privateInk,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _privateLineSoft),
            ),
            child: Text(
              'hover live',
              style: _privateBody(size: 11.5, color: accent),
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 08 -- waitDuration & showDuration TIMING PANEL
// =============================================================================

Widget _privateTimingPanel() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _privateChip('waitDuration', icon: Icons.hourglass_empty),
            const SizedBox(width: 8),
            _privateChip('showDuration', icon: Icons.timelapse),
            const SizedBox(width: 8),
            _privateChip('exitDuration',
                background: _privateMutedBg, foreground: _privateSlate),
          ],
        ),
        const SizedBox(height: 12),
        Text('Timing window', style: _privateSubtitle(size: 17)),
        const SizedBox(height: 6),
        Text(
          'Three durations frame the tooltip lifecycle:\n'
          '  - `waitDuration` -- hover dwell before the bubble appears.\n'
          '  - `showDuration` -- how long the bubble lingers after the gesture ends.\n'
          '  - `exitDuration` -- fade-out window once the tooltip starts hiding.',
          style: _privateBody(),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 130,
          child: CustomPaint(
            painter: _PrivateTimingPainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 6,
          children: [
            _privateChip('default waitDuration: 0ms (touch) / instant (mouse)',
                background: _privateMutedBg, foreground: _privateSlate),
            _privateChip('default showDuration: 1500ms (touch)',
                background: _privateMutedBg, foreground: _privateSlate),
            _privateChip('mouse hover: shows immediately',
                background: _privateMutedBg, foreground: _privateSlate),
          ],
        ),
        const SizedBox(height: 14),
        Tooltip(
          message: 'I wait 800ms then linger 2.5s',
          waitDuration: const Duration(milliseconds: 800),
          showDuration: const Duration(milliseconds: 2500),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _privateAccentSoft,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _privateAccent),
            ),
            child: const Text(
              'try the timed tooltip',
              style: TextStyle(
                color: _privateAccentDeep,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class _PrivateTimingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double y = size.height / 2;
    final Paint axis = Paint()
      ..color = _privateLine
      ..strokeWidth = 1;
    canvas.drawLine(Offset(20, y), Offset(size.width - 20, y), axis);

    void tick(double x, String label, Color color) {
      canvas.drawLine(
        Offset(x, y - 6),
        Offset(x, y + 6),
        Paint()
          ..color = color
          ..strokeWidth = 2,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, y + 12));
    }

    void band(double x1, double x2, Color color, String label) {
      final Rect r = Rect.fromLTWH(x1, y - 22, x2 - x1, 14);
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(4)),
        Paint()..color = color.withValues(alpha: 0.20),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(4)),
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: color,
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x1 + 6, y - 38));
    }

    final double t0 = 40;
    final double t1 = t0 + 90;
    final double t2 = t1 + 180;
    final double t3 = t2 + 90;

    band(t0, t1, _privateAccent, 'waitDuration');
    band(t1, t2, _privateMint, 'showDuration');
    band(t2, t3, _privateRose, 'exitDuration');

    tick(t0, 'hover', _privateInk);
    tick(t1, 'show', _privateAccentDeep);
    tick(t2, 'leave', _privateInkSoft);
    tick(t3, 'gone', _privateRose);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
//  SECTION 09 -- richMessage EXAMPLE
// =============================================================================

Widget _privateRichMessageExample() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _privateChip('richMessage', icon: Icons.format_quote),
            const SizedBox(width: 8),
            _privateChip(
              'mutually exclusive with message',
              background: _privateMutedBg,
              foreground: _privateSlate,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text('InlineSpan payload', style: _privateSubtitle(size: 17)),
        const SizedBox(height: 6),
        Text(
          'When you need bold/italic/colored runs in the bubble use `richMessage` '
          'with a `TextSpan`. You may not pass both `message` and `richMessage`.',
          style: _privateBody(),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _privateInk,
            borderRadius: BorderRadius.circular(10),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                height: 1.5,
              ),
              children: [
                const TextSpan(text: 'Save changes '),
                // C15 workaround: '\n' appended to preceding span instead of
                // standalone `const TextSpan(text: '\n')` between two styled
                // spans, which crashes the Dart VM under d4rt. See
                // interpreter_unfixable.md (C15: standalone-newline TextSpan).
                TextSpan(
                  text: '(Cmd+S)\n',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: _privateMint,
                  ),
                ),
                TextSpan(
                  text: 'tip:',
                  style: TextStyle(
                    color: _privateAmber,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const TextSpan(text: ' shift to save-as'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Tooltip(
          richMessage: TextSpan(
            style: const TextStyle(color: Colors.white, fontSize: 12),
            children: [
              const TextSpan(text: 'Save '),
              TextSpan(
                text: '(Cmd+S)',
                style: TextStyle(
                  color: _privateMint,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: _privateInk,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _privateAccentDeep,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Save (rich)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 10 -- RECIPE CODE LISTING
// =============================================================================

Widget _privateRecipeListing() {
  return _privateCard(
    background: _privateInk,
    border: _privateInkSoft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _privateChip('recipe',
                icon: Icons.menu_book_outlined,
                background: _privateAccent,
                foreground: Colors.white),
            const SizedBox(width: 8),
            _privateChip(
              'full Tooltip(...) constructor',
              background: Colors.white.withValues(alpha: 0.10),
              foreground: Colors.white,
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text('Recipe', style: _privateSubtitle(size: 17, color: Colors.white)),
        const SizedBox(height: 10),
        _privateCodeLine('Tooltip(', _privateAccentSoft),
        _privateCodeLine("  message: 'Save document',", Colors.white),
        _privateCodeLine(
            '  triggerMode: TooltipTriggerMode.longPress,', _privateMint),
        _privateCodeLine('  enableFeedback: true,', _privatePeach),
        _privateCodeLine('  excludeFromSemantics: false,', Colors.white),
        _privateCodeLine('  enableTapToDismiss: true,', _privateAmber),
        _privateCodeLine(
            '  waitDuration: Duration(milliseconds: 600),', Colors.white),
        _privateCodeLine(
            '  showDuration: Duration(milliseconds: 1800),', Colors.white),
        _privateCodeLine('  preferBelow: false,', Colors.white),
        _privateCodeLine('  verticalOffset: 18,', Colors.white),
        _privateCodeLine('  padding: EdgeInsets.symmetric(', Colors.white),
        _privateCodeLine('    horizontal: 12, vertical: 8),', Colors.white),
        _privateCodeLine('  margin: EdgeInsets.all(8),', Colors.white),
        _privateCodeLine('  decoration: BoxDecoration(', _privateAccentSoft),
        _privateCodeLine('    color: Color(0xFF0F1B2A),', Colors.white),
        _privateCodeLine(
            '    borderRadius: BorderRadius.circular(8),', Colors.white),
        _privateCodeLine('  ),', _privateAccentSoft),
        _privateCodeLine(
            '  textStyle: TextStyle(color: Colors.white, fontSize: 12),',
            Colors.white),
        _privateCodeLine('  textAlign: TextAlign.center,', Colors.white),
        _privateCodeLine('  child: IconButton(', Colors.white),
        _privateCodeLine('    icon: Icon(Icons.save_outlined),', Colors.white),
        _privateCodeLine('    onPressed: handleSave,', Colors.white),
        _privateCodeLine('  ),', Colors.white),
        _privateCodeLine(')', _privateAccentSoft),
        const SizedBox(height: 18),
        // Real instance.
        Tooltip(
          message: 'Save document',
          triggerMode: TooltipTriggerMode.longPress,
          enableFeedback: true,
          excludeFromSemantics: false,
          enableTapToDismiss: true,
          waitDuration: const Duration(milliseconds: 600),
          showDuration: const Duration(milliseconds: 1800),
          preferBelow: false,
          verticalOffset: 18,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _privateInkSoft,
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(color: Colors.white, fontSize: 12),
          textAlign: TextAlign.center,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _privateAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.save_outlined, size: 16, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'live recipe instance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _privateCodeLine(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: Text(text, style: _privateCode(color: color)),
  );
}

// =============================================================================
//  SECTION 11 -- PITFALLS
// =============================================================================

Widget _privatePitfallsPanel() {
  final List<List<String>> pitfalls = [
    [
      'manual triggerMode requires a key',
      'TooltipTriggerMode.manual disables built-in gestures. You must hold a '
          'GlobalKey<TooltipState> and call `key.currentState?.ensureTooltipVisible()` '
          'yourself; otherwise the bubble never shows.',
    ],
    [
      'message vs richMessage are mutually exclusive',
      'Pass exactly one of `message` (String) or `richMessage` (InlineSpan). '
          'Passing both throws an assertion at construction.',
    ],
    [
      'tap triggerMode swallows child onTap',
      'When `triggerMode: tap` wraps a button, taps open the tooltip first; '
          'wire callbacks on the child carefully or use `longPress` instead.',
    ],
    [
      'enableFeedback only affects long-press',
      'Mouse hover never plays haptic/sound regardless. The flag is also a '
          'no-op on platforms without haptic motors.',
    ],
    [
      'excludeFromSemantics hides only the message',
      'Existing `Semantics` on the child remain. Use it to silence the '
          "tooltip's own announcement, not the child's.",
    ],
    [
      'preferBelow may flip near edges',
      'Even with `preferBelow: true` the bubble flips above when there is no '
          'space - placement is a preference, not a guarantee.',
    ],
  ];

  return _privateCard(
    background: const Color(0xFFFFF6F0),
    border: const Color(0xFFFFD8BF),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _privateChip('pitfalls',
                background: _privatePeach.withValues(alpha: 0.20),
                foreground: _privatePeach,
                icon: Icons.warning_amber_outlined),
            const SizedBox(width: 8),
            _privateChip('read before shipping',
                background: Colors.white, foreground: _privateInkSoft),
          ],
        ),
        const SizedBox(height: 12),
        Text('Common mistakes', style: _privateSubtitle(size: 17)),
        const SizedBox(height: 10),
        ...pitfalls.map((p) => _privatePitfallRow(p[0], p[1])),
      ],
    ),
  );
}

Widget _privatePitfallRow(String title, String body) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(Icons.error_outline, size: 16, color: _privatePeach),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: _privateInk,
                ),
              ),
              const SizedBox(height: 2),
              Text(body, style: _privateBody(size: 12.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 12 -- PROPERTY REFERENCE TABLE
// =============================================================================

Widget _privatePropertyTable() {
  return _privateCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _privateChip('reference', icon: Icons.list_alt),
            const SizedBox(width: 8),
            _privateChip('full constructor surface',
                background: _privateMutedBg, foreground: _privateSlate),
          ],
        ),
        const SizedBox(height: 12),
        Text('Property reference', style: _privateSubtitle(size: 17)),
        const SizedBox(height: 12),
        _privateLabeledRow('message', 'String?  // mutually exclusive'),
        _privateLabeledRow('richMessage', 'InlineSpan?  // mutually exclusive'),
        _privateLabeledRow('triggerMode', 'TooltipTriggerMode? = longPress'),
        _privateLabeledRow('enableFeedback', 'bool? = true'),
        _privateLabeledRow('excludeFromSemantics', 'bool? = false'),
        _privateLabeledRow('enableTapToDismiss', 'bool? = true'),
        _privateLabeledRow('decoration', 'Decoration?'),
        _privateLabeledRow('padding', 'EdgeInsetsGeometry?'),
        _privateLabeledRow('margin', 'EdgeInsetsGeometry?'),
        _privateLabeledRow('verticalOffset', 'double?'),
        _privateLabeledRow('preferBelow', 'bool?'),
        _privateLabeledRow('waitDuration', 'Duration?'),
        _privateLabeledRow('showDuration', 'Duration?'),
        _privateLabeledRow('exitDuration', 'Duration?'),
        _privateLabeledRow('textStyle', 'TextStyle?'),
        _privateLabeledRow('textAlign', 'TextAlign?'),
        _privateLabeledRow('height', 'double?  // deprecated, use constraints'),
        _privateLabeledRow('child', 'Widget?'),
      ],
    ),
  );
}

// =============================================================================
//  SECTION 13 -- FOOTER
// =============================================================================

Widget _privateFooter() {
  return Container(
    margin: const EdgeInsets.only(top: 28, bottom: 12),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        colors: [_privateInkSoft, _privateInk],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.tips_and_updates_outlined,
              color: Colors.white, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tooltip - Feedback Deep Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Use enableFeedback for haptics, excludeFromSemantics for a11y, '
                'and triggerMode to choose the gesture. '
                'Compose decoration + padding + textStyle for visual identity.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12.5,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        const Icon(Icons.lightbulb_outline, color: Colors.white, size: 26),
      ],
    ),
  );
}

// =============================================================================
//  ENTRY POINT
// =============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Tooltip Feedback Visual Deep Demo',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _privatePaper,
      colorScheme: ColorScheme.fromSeed(seedColor: _privateAccent),
    ),
    home: Scaffold(
      backgroundColor: _privatePaper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 28, 28, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _privateHeroCard(),
              _privateSectionHeader(
                  2, 'Anatomy', 'How the bubble, tail and anchor relate.'),
              _privateAnatomyDiagram(),
              _privateSectionHeader(3, 'enableFeedback',
                  'Haptic and click feedback on long-press.'),
              _privateFeedbackPanel(),
              _privateSectionHeader(4, 'triggerMode',
                  'manual / longPress / tap - three live samples.'),
              _privateTriggerModePanel(),
              _privateSectionHeader(5, 'excludeFromSemantics',
                  'Should the message reach assistive tech?'),
              _privateSemanticsPanel(),
              _privateSectionHeader(6, 'Placement frames',
                  'Frozen-frame bubble mockups in 4 directions.'),
              _privateFrozenFrames(),
              _privateSectionHeader(7, 'Decoration & padding',
                  'Five bubble looks with live Tooltip widgets.'),
              _privateDecorationGallery(),
              _privateSectionHeader(8, 'waitDuration & showDuration',
                  'Lifecycle timeline with live timed sample.'),
              _privateTimingPanel(),
              _privateSectionHeader(9, 'richMessage',
                  'InlineSpan payload with mixed styling.'),
              _privateRichMessageExample(),
              _privateSectionHeader(10, 'Recipe',
                  'Full constructor + a real running instance.'),
              _privateRecipeListing(),
              _privateSectionHeader(11, 'Pitfalls',
                  'Six gotchas to remember before shipping.'),
              _privatePitfallsPanel(),
              _privateSectionHeader(12, 'Property reference',
                  "Tooltip's constructor surface at a glance."),
              _privatePropertyTable(),
              _privateFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
//  Sanity helper -- never invoked, exists only to keep dart:math visible while
//  acknowledging that the file is a static visual demo with no animations.
// -----------------------------------------------------------------------------

double _privateUnusedSanity() {
  return math.sin(math.pi / 4) + math.cos(math.pi / 4);
}

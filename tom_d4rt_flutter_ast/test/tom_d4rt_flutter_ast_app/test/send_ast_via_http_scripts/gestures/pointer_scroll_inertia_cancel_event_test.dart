// D4rt deep-demo Flutter test script: PointerScrollInertiaCancelEvent.
//
// PointerScrollInertiaCancelEvent is the *quietest* member of the
// PointerSignalEvent family. Unlike its siblings PointerScrollEvent (which
// carries scrollDelta) and PointerScaleEvent (which carries scale), this
// event has *no payload of its own*. It is a pure, payload-free notification
// from the platform that an in-flight inertial scroll simulation must be
// terminated.
//
// The canonical scenario:
//
//   1.  The user flicks two fingers across a trackpad. The platform synthesises
//       a sequence of PointerScrollEvent frames as the touch lifts off and
//       continues with decaying delta as the platform-level momentum runs.
//   2.  Mid-flight, the user puts their fingers back down on the trackpad.
//   3.  The platform realises momentum is no longer appropriate — the user
//       has resumed direct manipulation. It dispatches exactly one
//       PointerScrollInertiaCancelEvent.
//   4.  The Flutter scrollable receiving the resolver callback for this
//       signal stops its physics simulation immediately so the next
//       PointerScrollEvent can drive a fresh, deterministic scroll.
//
// This file is a single-screen, scrollable, hand-authored visual reference
// that dives deeper than the sibling pointer_signal_event_test.dart demo
// into this *single* event class, with an amber/orange palette throughout.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// =============================================================================
// Top-level value classes used to drive the visual structure. These are file
// private (leading underscore on the class name itself, not on locals).
// =============================================================================

class _Palette {
  const _Palette({
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.onSurface,
    required this.accent,
    required this.danger,
  });

  final Color primary;
  final Color secondary;
  final Color surface;
  final Color onSurface;
  final Color accent;
  final Color danger;
}

class _TimelinePhase {
  const _TimelinePhase({
    required this.label,
    required this.detail,
    required this.tone,
    required this.icon,
    required this.cancel,
  });

  final String label;
  final String detail;
  final Color tone;
  final IconData icon;
  final bool cancel;
}

class _FieldCard {
  const _FieldCard({
    required this.name,
    required this.type,
    required this.sample,
    required this.prose,
    required this.icon,
  });

  final String name;
  final String type;
  final String sample;
  final String prose;
  final IconData icon;
}

class _AnatomyNode {
  const _AnatomyNode({
    required this.label,
    required this.subtitle,
    required this.tone,
    required this.icon,
  });

  final String label;
  final String subtitle;
  final Color tone;
  final IconData icon;
}

class _UseCaseCard {
  const _UseCaseCard({
    required this.title,
    required this.scenario,
    required this.handler,
    required this.tone,
    required this.icon,
  });

  final String title;
  final String scenario;
  final String handler;
  final Color tone;
  final IconData icon;
}

class _CompareEntry {
  const _CompareEntry({
    required this.eventName,
    required this.payload,
    required this.size,
    required this.tone,
    required this.icon,
  });

  final String eventName;
  final String payload;
  final String size;
  final Color tone;
  final IconData icon;
}

class _CaveatCard {
  const _CaveatCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.tone,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color tone;
}

class _Takeaway {
  const _Takeaway({
    required this.headline,
    required this.body,
    required this.icon,
  });

  final String headline;
  final String body;
  final IconData icon;
}

// =============================================================================
// Amber/orange palette presets. Each palette tints one section. Distinct from
// the cobalt/magenta/teal/etc palette of the sibling pointer_signal_event_test
// demo.
// =============================================================================

const _Palette _heroPalette = _Palette(
  primary: Color(0xFFE65100),
  secondary: Color(0xFFFF8F00),
  surface: Color(0xFFFFF3E0),
  onSurface: Color(0xFF3E2723),
  accent: Color(0xFFFFD180),
  danger: Color(0xFFBF360C),
);

const _Palette _timelinePalette = _Palette(
  primary: Color(0xFFEF6C00),
  secondary: Color(0xFFFFA000),
  surface: Color(0xFFFFF8E1),
  onSurface: Color(0xFF4E342E),
  accent: Color(0xFFFFB300),
  danger: Color(0xFFD84315),
);

const _Palette _whyPalette = _Palette(
  primary: Color(0xFFE65100),
  secondary: Color(0xFFF57C00),
  surface: Color(0xFFFFF3E0),
  onSurface: Color(0xFF3E2723),
  accent: Color(0xFFFFC400),
  danger: Color(0xFFBF360C),
);

const _Palette _anatomyPalette = _Palette(
  primary: Color(0xFFD84315),
  secondary: Color(0xFFEF6C00),
  surface: Color(0xFFFBE9E7),
  onSurface: Color(0xFF3E2723),
  accent: Color(0xFFFF9800),
  danger: Color(0xFFBF360C),
);

const _Palette _fieldsPalette = _Palette(
  primary: Color(0xFFFF6F00),
  secondary: Color(0xFFFFA000),
  surface: Color(0xFFFFF8E1),
  onSurface: Color(0xFF3E2723),
  accent: Color(0xFFFFB300),
  danger: Color(0xFFC62828),
);

const _Palette _constructionPalette = _Palette(
  primary: Color(0xFFE65100),
  secondary: Color(0xFFEF6C00),
  surface: Color(0xFFFFF3E0),
  onSurface: Color(0xFF3E2723),
  accent: Color(0xFFFFA726),
  danger: Color(0xFFBF360C),
);

const _Palette _resolverPalette = _Palette(
  primary: Color(0xFFBF360C),
  secondary: Color(0xFFE64A19),
  surface: Color(0xFFFBE9E7),
  onSurface: Color(0xFF3E2723),
  accent: Color(0xFFFF7043),
  danger: Color(0xFF8D2A0E),
);

const _Palette _useCasePalette = _Palette(
  primary: Color(0xFFEF6C00),
  secondary: Color(0xFFFB8C00),
  surface: Color(0xFFFFF3E0),
  onSurface: Color(0xFF3E2723),
  accent: Color(0xFFFFB74D),
  danger: Color(0xFFD84315),
);

const _Palette _comparePalette = _Palette(
  primary: Color(0xFFE65100),
  secondary: Color(0xFFFFA000),
  surface: Color(0xFFFFF8E1),
  onSurface: Color(0xFF3E2723),
  accent: Color(0xFFFFCA28),
  danger: Color(0xFFC62828),
);

const _Palette _caveatPalette = _Palette(
  primary: Color(0xFFD84315),
  secondary: Color(0xFFE64A19),
  surface: Color(0xFFFBE9E7),
  onSurface: Color(0xFF3E2723),
  accent: Color(0xFFFF8A65),
  danger: Color(0xFF8D2A0E),
);

const _Palette _footerPalette = _Palette(
  primary: Color(0xFF3E2723),
  secondary: Color(0xFF5D4037),
  surface: Color(0xFFEFEBE9),
  onSurface: Color(0xFF3E2723),
  accent: Color(0xFFFFA000),
  danger: Color(0xFFBF360C),
);

// =============================================================================
// Build entry point. The script returns Scaffold + SingleChildScrollView and
// composes the eleven sections in fixed order. Each section is implemented in
// its own helper below; helpers never call setState, runApp, or main.
// =============================================================================

dynamic build(BuildContext context) {
  // The reference event used for the construction sample, the field grid,
  // and the resolver flow. We use a non-zero timeStamp and embedderId so the
  // readout cards have realistic-looking values.
  const PointerScrollInertiaCancelEvent referenceEvent =
      PointerScrollInertiaCancelEvent(
    viewId: 0,
    timeStamp: Duration(milliseconds: 4250),
    device: 1,
    position: Offset(184, 232),
    embedderId: 7,
  );

  return Scaffold(
    backgroundColor: const Color(0xFFFFFBF2),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHero(),
          const SizedBox(height: 32),
          _buildTimeline(),
          const SizedBox(height: 32),
          _buildWhyItExists(),
          const SizedBox(height: 32),
          _buildAnatomyDiagram(),
          const SizedBox(height: 32),
          _buildFieldGrid(referenceEvent),
          const SizedBox(height: 32),
          _buildConstructionSample(referenceEvent),
          const SizedBox(height: 32),
          _buildResolverFlow(),
          const SizedBox(height: 32),
          _buildUseCases(),
          const SizedBox(height: 32),
          _buildComparison(),
          const SizedBox(height: 32),
          _buildCaveats(),
          const SizedBox(height: 32),
          _buildFooter(),
          const SizedBox(height: 48),
        ],
      ),
    ),
  );
}

// =============================================================================
// Section 1: Hero header.
//
// Gradient header (amber -> orange) with a "stop hand" / cancel icon, the
// event name, a one-line elevator pitch, and three quick-fact chips.
// =============================================================================

Widget _buildHero() {
  const _Palette palette = _heroPalette;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [palette.primary, palette.secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(28)),
      boxShadow: [
        BoxShadow(
          color: palette.primary.withValues(alpha: 0.45),
          blurRadius: 28,
          offset: const Offset(0, 14),
        ),
      ],
    ),
    child: Stack(
      children: [
        Positioned(
          right: -28,
          top: -36,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: palette.accent.withValues(alpha: 0.20),
            ),
          ),
        ),
        Positioned(
          right: 36,
          top: 36,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: palette.accent.withValues(alpha: 0.30),
            ),
          ),
        ),
        Positioned(
          left: -20,
          bottom: -20,
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: palette.danger.withValues(alpha: 0.26),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.50),
                      width: 1.4,
                    ),
                  ),
                  child: const Icon(
                    Icons.do_not_touch_outlined,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'PointerScrollInertiaCancelEvent',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'package:flutter/gestures.dart',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'A payload-free signal: the platform demands that an in-flight\n'
              'inertial scroll simulation be cancelled, right now.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _heroChip(label: 'extends PointerSignalEvent'),
                _heroChip(label: 'kind = PointerDeviceKind.trackpad'),
                _heroChip(label: 'no scrollDelta, no scale'),
                _heroChip(label: 'dispatched via PointerSignalResolver'),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip({required String label}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.20),
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.40),
        width: 1,
      ),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
  );
}

// =============================================================================
// Section 2: Inertia lifecycle timeline.
//
// Horizontal timeline with five phases. The fifth phase is the
// PointerScrollInertiaCancelEvent itself, highlighted in red/orange with a
// "user touched trackpad again" annotation.
// =============================================================================

Widget _buildTimeline() {
  const _Palette palette = _timelinePalette;
  const List<_TimelinePhase> phases = <_TimelinePhase>[
    _TimelinePhase(
      label: 'Flick',
      detail: 'Two fingers swipe across the trackpad and lift off. Velocity captured.',
      tone: Color(0xFFFFB300),
      icon: Icons.swipe,
      cancel: false,
    ),
    _TimelinePhase(
      label: 'Inertia frame 1',
      detail: 'Platform synthesises PointerScrollEvent with the still-strong delta.',
      tone: Color(0xFFFFA000),
      icon: Icons.fast_forward,
      cancel: false,
    ),
    _TimelinePhase(
      label: 'Inertia frame 2',
      detail: 'Delta decays. Another PointerScrollEvent is produced this tick.',
      tone: Color(0xFFFF8F00),
      icon: Icons.timeline,
      cancel: false,
    ),
    _TimelinePhase(
      label: 'Inertia frame N',
      detail: 'Continuing decay. Each frame is an additional PointerScrollEvent.',
      tone: Color(0xFFEF6C00),
      icon: Icons.linear_scale,
      cancel: false,
    ),
    _TimelinePhase(
      label: 'CANCEL',
      detail: 'User puts fingers back on the trackpad. Platform sends '
          'PointerScrollInertiaCancelEvent. Simulation must stop now.',
      tone: Color(0xFFD84315),
      icon: Icons.do_not_touch,
      cancel: true,
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: palette.surface,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: palette.primary.withValues(alpha: 0.18)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: palette.primary, size: 26),
            const SizedBox(width: 10),
            Text(
              'Inertia lifecycle timeline',
              style: TextStyle(
                color: palette.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'From flick to cancel: every phase the platform sends to Flutter.',
          style: TextStyle(
            color: palette.onSurface.withValues(alpha: 0.70),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 22),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              for (int i = 0; i < phases.length; i++) ...<Widget>[
                _timelineNode(phase: phases[i], index: i, palette: palette),
                if (i < phases.length - 1)
                  _timelineConnector(
                    color: phases[i].tone,
                    nextCancel: phases[i + 1].cancel,
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: palette.danger.withValues(alpha: 0.10),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: palette.danger.withValues(alpha: 0.40),
              width: 1.2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.touch_app, color: palette.danger, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'The CANCEL phase is fired exactly once, and only when the '
                  'user re-touches the trackpad while the platform is still '
                  'running its momentum simulation. Without it, the next '
                  'PointerScrollEvent would compound on top of the lingering '
                  'delta, producing an obvious visual stutter.',
                  style: TextStyle(
                    color: palette.danger,
                    fontSize: 13,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
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

Widget _timelineNode({
  required _TimelinePhase phase,
  required int index,
  required _Palette palette,
}) {
  final Color border = phase.cancel ? palette.danger : phase.tone;
  return Container(
    width: 200,
    margin: const EdgeInsets.symmetric(horizontal: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: phase.cancel
          ? palette.danger.withValues(alpha: 0.10)
          : Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(
        color: border.withValues(alpha: phase.cancel ? 0.85 : 0.50),
        width: phase.cancel ? 2.0 : 1.2,
      ),
      boxShadow: phase.cancel
          ? [
              BoxShadow(
                color: palette.danger.withValues(alpha: 0.20),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ]
          : <BoxShadow>[],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: border.withValues(alpha: 0.18),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Icon(phase.icon, color: border, size: 18),
            ),
            const SizedBox(width: 8),
            Text(
              'Phase ${index + 1}',
              style: TextStyle(
                color: border,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          phase.label,
          style: TextStyle(
            color: palette.onSurface,
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          phase.detail,
          style: TextStyle(
            color: palette.onSurface.withValues(alpha: 0.78),
            fontSize: 11.5,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _timelineConnector({required Color color, required bool nextCancel}) {
  return SizedBox(
    width: 28,
    height: 50,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 3,
          color: color.withValues(alpha: 0.55),
        ),
        Positioned(
          right: 2,
          child: Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: nextCancel ? const Color(0xFFD84315) : color,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 3: Why this event exists.
//
// Prose-heavy card explaining the underlying problem: when momentum scrolling
// is interrupted by a fresh finger touch, the platform must cancel the
// simulation so the next PointerScrollEvent can drive a clean scroll.
// =============================================================================

Widget _buildWhyItExists() {
  const _Palette palette = _whyPalette;
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: palette.surface,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: palette.primary.withValues(alpha: 0.20)),
      boxShadow: [
        BoxShadow(
          color: palette.primary.withValues(alpha: 0.06),
          blurRadius: 14,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: palette.primary.withValues(alpha: 0.15),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(Icons.psychology, color: palette.primary, size: 22),
            ),
            const SizedBox(width: 12),
            Text(
              'Why this event exists',
              style: TextStyle(
                color: palette.onSurface,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _whyParagraph(
          palette: palette,
          icon: Icons.info_outline,
          headline: 'The platform owns the inertia simulation',
          body:
              'When you flick a trackpad on macOS or iPadOS, the platform — '
              'not Flutter — runs the inertia simulation. The OS keeps '
              'producing scroll deltas after your fingers leave the surface, '
              'and forwards them to Flutter as a sequence of '
              'PointerScrollEvent frames. Flutter just consumes them.',
        ),
        const SizedBox(height: 14),
        _whyParagraph(
          palette: palette,
          icon: Icons.touch_app_outlined,
          headline: 'A fresh touch invalidates the simulation',
          body:
              'The moment your fingers return to the trackpad, the platform '
              'knows that direct manipulation has resumed. The momentum '
              'simulation no longer represents the user\'s intent and must '
              'be terminated before it generates any further deltas.',
        ),
        const SizedBox(height: 14),
        _whyParagraph(
          palette: palette,
          icon: Icons.cancel_presentation,
          headline: 'But Flutter does not know without being told',
          body:
              'Flutter has no way to observe the trackpad state directly. '
              'It only sees the events the platform forwards. So the '
              'platform sends a single PointerScrollInertiaCancelEvent to '
              'tell Flutter: "stop whatever momentum animation you may '
              'have started — direct input is taking over again".',
        ),
        const SizedBox(height: 14),
        _whyParagraph(
          palette: palette,
          icon: Icons.lightbulb_outline,
          headline: 'No payload, just a flag',
          body:
              'The event carries no scroll delta, no scale, no velocity. It '
              'is a flag — its mere arrival is the signal. All of its '
              'meaning is encoded in its runtime type and the (timeStamp, '
              'device, position) tuple it inherits from PointerEvent.',
        ),
      ],
    ),
  );
}

Widget _whyParagraph({
  required _Palette palette,
  required IconData icon,
  required String headline,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      border: Border.all(color: palette.primary.withValues(alpha: 0.16)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: palette.accent.withValues(alpha: 0.30),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Icon(icon, color: palette.primary, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headline,
                style: TextStyle(
                  color: palette.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: TextStyle(
                  color: palette.onSurface.withValues(alpha: 0.78),
                  fontSize: 13,
                  height: 1.50,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 4: Anatomy diagram.
//
// PointerEvent -> PointerSignalEvent -> PointerScrollInertiaCancelEvent
// inheritance chain, followed by a wrap of chips for inherited fields.
// =============================================================================

Widget _buildAnatomyDiagram() {
  const _Palette palette = _anatomyPalette;
  const List<_AnatomyNode> chain = <_AnatomyNode>[
    _AnatomyNode(
      label: 'PointerEvent',
      subtitle: 'abstract base of every pointer-related event',
      tone: Color(0xFFEF6C00),
      icon: Icons.account_tree_outlined,
    ),
    _AnatomyNode(
      label: 'PointerSignalEvent',
      subtitle: 'signal events: dispatched outside the gesture arena',
      tone: Color(0xFFFB8C00),
      icon: Icons.podcasts,
    ),
    _AnatomyNode(
      label: 'PointerScrollInertiaCancelEvent',
      subtitle: 'this event: cancel an in-flight inertial scroll simulation',
      tone: Color(0xFFD84315),
      icon: Icons.do_not_touch,
    ),
  ];

  const List<String> inheritedFields = <String>[
    'viewId',
    'timeStamp',
    'pointer',
    'kind',
    'device',
    'position',
    'localPosition',
    'embedderId',
    'transform',
    'original',
  ];

  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: palette.surface,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: palette.primary.withValues(alpha: 0.18)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: palette.primary, size: 24),
            const SizedBox(width: 10),
            Text(
              'Anatomy: inheritance chain',
              style: TextStyle(
                color: palette.onSurface,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Column(
          children: <Widget>[
            for (int i = 0; i < chain.length; i++) ...<Widget>[
              _anatomyNode(node: chain[i], index: i, palette: palette),
              if (i < chain.length - 1) _anatomyArrow(palette: palette),
            ],
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Inherited fields from PointerEvent',
          style: TextStyle(
            color: palette.onSurface,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'PointerScrollInertiaCancelEvent declares no fields of its own. '
          'Everything it carries is inherited.',
          style: TextStyle(
            color: palette.onSurface.withValues(alpha: 0.70),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            for (final String f in inheritedFields)
              _fieldChip(name: f, palette: palette),
          ],
        ),
      ],
    ),
  );
}

Widget _anatomyNode({
  required _AnatomyNode node,
  required int index,
  required _Palette palette,
}) {
  final bool last = index == 2;
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: last ? node.tone.withValues(alpha: 0.10) : Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(
        color: node.tone.withValues(alpha: last ? 0.85 : 0.45),
        width: last ? 2 : 1.2,
      ),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: node.tone.withValues(alpha: 0.20),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Icon(node.icon, color: node.tone, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                node.label,
                style: TextStyle(
                  color: palette.onSurface,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                node.subtitle,
                style: TextStyle(
                  color: palette.onSurface.withValues(alpha: 0.78),
                  fontSize: 12.5,
                  height: 1.40,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: node.tone.withValues(alpha: 0.18),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Text(
            'Level ${index + 1}',
            style: TextStyle(
              color: node.tone,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyArrow({required _Palette palette}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Center(
      child: Icon(
        Icons.south,
        color: palette.primary.withValues(alpha: 0.70),
        size: 22,
      ),
    ),
  );
}

Widget _fieldChip({required String name, required _Palette palette}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      border: Border.all(color: palette.primary.withValues(alpha: 0.30)),
    ),
    child: Text(
      name,
      style: TextStyle(
        color: palette.primary,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// =============================================================================
// Section 5: Field grid.
//
// Seven field cards: timeStamp, pointer, device, kind, position,
// localPosition, embedderId. Each card includes the actual sample value
// from the reference event plus a prose explanation.
// =============================================================================

Widget _buildFieldGrid(PointerScrollInertiaCancelEvent ref) {
  const _Palette palette = _fieldsPalette;
  final List<_FieldCard> cards = <_FieldCard>[
    _FieldCard(
      name: 'timeStamp',
      type: 'Duration',
      sample: ref.timeStamp.toString(),
      prose: 'Engine-supplied monotonic stamp for this event. Useful for '
          'correlating the cancel against the previous PointerScrollEvent.',
      icon: Icons.schedule,
    ),
    _FieldCard(
      name: 'pointer',
      type: 'int',
      sample: ref.pointer.toString(),
      prose: 'The synthetic pointer id assigned by Flutter. Signal events '
          'normally inherit pointer 0; what matters is device, not pointer.',
      icon: Icons.fingerprint,
    ),
    _FieldCard(
      name: 'device',
      type: 'int',
      sample: ref.device.toString(),
      prose: 'Platform-supplied numeric id for the physical device. '
          'A multi-trackpad system can produce concurrent cancel signals '
          'with different device ids.',
      icon: Icons.devices_other,
    ),
    _FieldCard(
      name: 'kind',
      type: 'PointerDeviceKind',
      sample: ref.kind.toString(),
      prose: 'For PointerScrollInertiaCancelEvent the kind is always '
          'PointerDeviceKind.trackpad. This is enforced at construction '
          'time and is the only kind the platform produces.',
      icon: Icons.label_important_outline,
    ),
    _FieldCard(
      name: 'position',
      type: 'Offset',
      sample: ref.position.toString(),
      prose: 'Pointer position in the global (root view) coordinate space '
          'at the moment the cancel was issued. Inherited from the last '
          'known position of the trackpad gesture.',
      icon: Icons.location_searching,
    ),
    _FieldCard(
      name: 'localPosition',
      type: 'Offset',
      sample: ref.localPosition.toString(),
      prose: 'Position translated into the local coordinate space of the '
          'receiver. For an untransformed event it equals position.',
      icon: Icons.center_focus_strong,
    ),
    _FieldCard(
      name: 'embedderId',
      type: 'int',
      sample: ref.embedderId.toString(),
      prose: 'Opaque identifier set by the embedder (e.g. native iPad '
          'host) and propagated unchanged. Useful if the embedder needs '
          'to correlate the cancel with its own state.',
      icon: Icons.qr_code_2,
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: palette.surface,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: palette.primary.withValues(alpha: 0.18)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_view, color: palette.primary, size: 24),
            const SizedBox(width: 10),
            Text(
              'Inherited fields, sampled from the reference event',
              style: TextStyle(
                color: palette.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Seven properties drive every PointerScrollInertiaCancelEvent. '
          'None of them are unique to this class.',
          style: TextStyle(
            color: palette.onSurface.withValues(alpha: 0.70),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            for (final _FieldCard c in cards)
              _fieldCard(card: c, palette: palette),
          ],
        ),
      ],
    ),
  );
}

Widget _fieldCard({required _FieldCard card, required _Palette palette}) {
  return Container(
    width: 260,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: palette.primary.withValues(alpha: 0.22)),
      boxShadow: [
        BoxShadow(
          color: palette.primary.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: palette.accent.withValues(alpha: 0.35),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Icon(card.icon, color: palette.primary, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.name,
                    style: TextStyle(
                      color: palette.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    card.type,
                    style: TextStyle(
                      color: palette.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(
              color: palette.primary.withValues(alpha: 0.20),
            ),
          ),
          child: Text(
            card.sample,
            style: TextStyle(
              color: palette.onSurface,
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          card.prose,
          style: TextStyle(
            color: palette.onSurface.withValues(alpha: 0.78),
            fontSize: 11.5,
            height: 1.40,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 6: Construction sample.
//
// A code block with a real `const PointerScrollInertiaCancelEvent(...)`
// constructor, followed by readout cards for runtimeType, hashCode and
// toString().
// =============================================================================

Widget _buildConstructionSample(PointerScrollInertiaCancelEvent ref) {
  const _Palette palette = _constructionPalette;

  // Trim toString() for compact display so the readout card stays sane.
  final String fullToString = ref.toString();
  final String trimmedToString = fullToString.length > 220
      ? '${fullToString.substring(0, 217)}...'
      : fullToString;

  const String code =
      'const PointerScrollInertiaCancelEvent referenceEvent =\n'
      '    PointerScrollInertiaCancelEvent(\n'
      '  viewId: 0,\n'
      '  timeStamp: Duration(milliseconds: 4250),\n'
      '  device: 1,\n'
      '  position: Offset(184, 232),\n'
      '  embedderId: 7,\n'
      ');';

  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: palette.surface,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: palette.primary.withValues(alpha: 0.20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: palette.primary, size: 24),
            const SizedBox(width: 10),
            Text(
              'Construction sample',
              style: TextStyle(
                color: palette.onSurface,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF3E2723),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: const Text(
            code,
            style: TextStyle(
              color: Color(0xFFFFE0B2),
              fontSize: 13,
              fontFamily: 'monospace',
              height: 1.55,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            _readoutCard(
              palette: palette,
              label: 'runtimeType',
              value: ref.runtimeType.toString(),
              icon: Icons.fingerprint,
            ),
            _readoutCard(
              palette: palette,
              label: 'hashCode',
              value: ref.hashCode.toString(),
              icon: Icons.tag,
            ),
            _readoutCard(
              palette: palette,
              label: 'down',
              value: ref.down.toString(),
              icon: Icons.south,
            ),
            _readoutCard(
              palette: palette,
              label: 'synthesized',
              value: ref.synthesized.toString(),
              icon: Icons.auto_awesome,
            ),
            _readoutCard(
              palette: palette,
              label: 'toString()',
              value: trimmedToString,
              icon: Icons.short_text,
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: palette.accent.withValues(alpha: 0.18),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: palette.accent.withValues(alpha: 0.55),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.tips_and_updates,
                  color: palette.primary, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Note: the constructor is const. Most production code does '
                  'not construct PointerScrollInertiaCancelEvent values '
                  'directly — they arrive from the engine. Direct '
                  'construction is mainly useful in tests and demos.',
                  style: TextStyle(
                    color: palette.onSurface,
                    fontSize: 12.5,
                    height: 1.40,
                    fontWeight: FontWeight.w500,
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

Widget _readoutCard({
  required _Palette palette,
  required String label,
  required String value,
  required IconData icon,
}) {
  return Container(
    width: 260,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      border: Border.all(color: palette.primary.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: palette.primary, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: palette.primary,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: palette.onSurface,
            fontSize: 11.5,
            fontFamily: 'monospace',
            height: 1.40,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 7: Resolver flow.
//
// Visualise the trip the event takes from the engine into a registered
// callback, distinct in framing from the sibling demo's resolver block.
// =============================================================================

Widget _buildResolverFlow() {
  const _Palette palette = _resolverPalette;
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: palette.surface,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: palette.primary.withValues(alpha: 0.20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.alt_route, color: palette.primary, size: 24),
            const SizedBox(width: 10),
            Text(
              'Hit-testing & resolver flow',
              style: TextStyle(
                color: palette.onSurface,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'How a single PointerScrollInertiaCancelEvent reaches the right '
          'scroll view.',
          style: TextStyle(
            color: palette.onSurface.withValues(alpha: 0.70),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 18),
        _flowStep(
          index: 1,
          title: 'Engine dispatch',
          body: 'The native embedder converts a platform "scroll cancel" '
              'into a PointerData and hands it to the engine, which '
              'forwards it as a PointerScrollInertiaCancelEvent.',
          icon: Icons.cloud_download_outlined,
          palette: palette,
        ),
        _flowArrow(palette: palette),
        _flowStep(
          index: 2,
          title: 'GestureBinding hit-test',
          body: 'GestureBinding hit-tests the event\'s position. Each '
              'hit-test entry that wants to react registers itself with '
              'GestureBinding.instance.pointerSignalResolver.register('
              'event, callback).',
          icon: Icons.center_focus_weak,
          palette: palette,
        ),
        _flowArrow(palette: palette),
        _flowStep(
          index: 3,
          title: 'PointerSignalResolver picks a winner',
          body: 'For each unique signal event, exactly one registered '
              'callback wins (top of hit-test stack). The other registrants '
              'are silently dropped — there is no "two listeners" mode.',
          icon: Icons.gavel,
          palette: palette,
        ),
        _flowArrow(palette: palette),
        _flowStep(
          index: 4,
          title: 'Scrollable cancels its simulation',
          body: 'The winning callback (typically inside Scrollable) inspects '
              'event.runtimeType, recognises the cancel, and tears down '
              'whatever ballistic simulation is currently running on its '
              'AnimationController.',
          icon: Icons.do_not_touch,
          palette: palette,
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: palette.accent.withValues(alpha: 0.12),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: palette.accent.withValues(alpha: 0.50),
              width: 1.2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: palette.primary, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Crucially: PointerScrollInertiaCancelEvent does NOT '
                  'enter the gesture arena. Pan/scale/drag recognizers do '
                  'not see it. Only signal-aware widgets registered with '
                  'the PointerSignalResolver get a shot.',
                  style: TextStyle(
                    color: palette.onSurface,
                    fontSize: 12.5,
                    height: 1.40,
                    fontWeight: FontWeight.w500,
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

Widget _flowStep({
  required int index,
  required String title,
  required String body,
  required IconData icon,
  required _Palette palette,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: palette.primary.withValues(alpha: 0.22)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: palette.primary.withValues(alpha: 0.15),
            border: Border.all(
              color: palette.primary.withValues(alpha: 0.55),
              width: 1.2,
            ),
          ),
          child: Text(
            '$index',
            style: TextStyle(
              color: palette.primary,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Icon(icon, color: palette.secondary, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: palette.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: TextStyle(
                  color: palette.onSurface.withValues(alpha: 0.78),
                  fontSize: 12.5,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _flowArrow({required _Palette palette}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.south,
          color: palette.primary.withValues(alpha: 0.65),
          size: 22,
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 8: Real-world handling.
//
// Three use-case cards illustrating concrete actions a widget might take when
// it receives a PointerScrollInertiaCancelEvent.
// =============================================================================

Widget _buildUseCases() {
  const _Palette palette = _useCasePalette;
  const List<_UseCaseCard> cases = <_UseCaseCard>[
    _UseCaseCard(
      title: 'Stop a CustomScrollView simulation',
      scenario: 'A long list is mid-flick when the user taps the trackpad. '
          'The list must freeze at its current pixel exactly, not glide '
          'further.',
      handler: 'Position.beginActivity(IdleScrollActivity(this));',
      tone: Color(0xFFEF6C00),
      icon: Icons.list_alt,
    ),
    _UseCaseCard(
      title: 'Snap to nearest page',
      scenario: 'A PageView running a SnappingPageScrollPhysics simulation '
          'should not just freeze — it should snap to whichever page edge '
          'is closest.',
      handler: 'controller.animateToPage(estimateClosestPage(),\n'
          '  duration: kSnap, curve: Curves.easeOutCubic);',
      tone: Color(0xFFFB8C00),
      icon: Icons.view_carousel_outlined,
    ),
    _UseCaseCard(
      title: 'Abort a parallax animation',
      scenario: 'A header parallax effect is being driven by the same '
          'momentum simulation. The cancel is a hint to abort the parallax '
          'too, so the visual state is consistent.',
      handler: 'parallaxNotifier.value = parallaxNotifier.value;',
      tone: Color(0xFFFFA000),
      icon: Icons.layers,
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: palette.surface,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: palette.primary.withValues(alpha: 0.18)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.handyman, color: palette.primary, size: 24),
            const SizedBox(width: 10),
            Text(
              'Real-world handling patterns',
              style: TextStyle(
                color: palette.onSurface,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Three concrete things a Flutter widget actually does on cancel.',
          style: TextStyle(
            color: palette.onSurface.withValues(alpha: 0.70),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 18),
        Column(
          children: <Widget>[
            for (int i = 0; i < cases.length; i++) ...<Widget>[
              _useCaseCard(card: cases[i], palette: palette),
              if (i < cases.length - 1) const SizedBox(height: 12),
            ],
          ],
        ),
      ],
    ),
  );
}

Widget _useCaseCard({required _UseCaseCard card, required _Palette palette}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: card.tone.withValues(alpha: 0.55), width: 1.4),
      boxShadow: [
        BoxShadow(
          color: card.tone.withValues(alpha: 0.10),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: card.tone.withValues(alpha: 0.18),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Icon(card.icon, color: card.tone, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                card.title,
                style: TextStyle(
                  color: palette.onSurface,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          card.scenario,
          style: TextStyle(
            color: palette.onSurface.withValues(alpha: 0.78),
            fontSize: 13,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF3E2723),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Text(
            card.handler,
            style: const TextStyle(
              color: Color(0xFFFFE0B2),
              fontSize: 12,
              fontFamily: 'monospace',
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 9: Comparison panel.
//
// Side-by-side comparison of the three concrete PointerSignalEvent subclasses,
// highlighting that PointerScrollInertiaCancelEvent is the only one with no
// payload.
// =============================================================================

Widget _buildComparison() {
  const _Palette palette = _comparePalette;
  const List<_CompareEntry> entries = <_CompareEntry>[
    _CompareEntry(
      eventName: 'PointerScrollEvent',
      payload: 'Offset scrollDelta',
      size: 'two doubles (dx, dy)',
      tone: Color(0xFFFB8C00),
      icon: Icons.swap_vert,
    ),
    _CompareEntry(
      eventName: 'PointerScrollInertiaCancelEvent',
      payload: '(none)',
      size: 'no payload, the type itself is the signal',
      tone: Color(0xFFD84315),
      icon: Icons.do_not_touch,
    ),
    _CompareEntry(
      eventName: 'PointerScaleEvent',
      payload: 'double scale',
      size: 'one double, multiplicative',
      tone: Color(0xFFEF6C00),
      icon: Icons.zoom_out_map,
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: palette.surface,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: palette.primary.withValues(alpha: 0.20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: palette.primary, size: 24),
            const SizedBox(width: 10),
            Text(
              'Comparison: signal events side by side',
              style: TextStyle(
                color: palette.onSurface,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'PointerScrollInertiaCancelEvent is the only one with no payload.',
          style: TextStyle(
            color: palette.onSurface.withValues(alpha: 0.70),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: palette.primary.withValues(alpha: 0.12),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: _compareHeader(
                  text: 'Event',
                  palette: palette,
                ),
              ),
              Expanded(
                flex: 3,
                child: _compareHeader(
                  text: 'Payload',
                  palette: palette,
                ),
              ),
              Expanded(
                flex: 4,
                child: _compareHeader(
                  text: 'Size / shape',
                  palette: palette,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: <Widget>[
            for (final _CompareEntry e in entries)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _compareRow(entry: e, palette: palette),
              ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: palette.danger.withValues(alpha: 0.10),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: palette.danger.withValues(alpha: 0.40),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.warning_amber, color: palette.danger, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Do not branch on payload values to detect a cancel: there '
                  'is nothing to read. Always switch on runtimeType '
                  '(or `event is PointerScrollInertiaCancelEvent`).',
                  style: TextStyle(
                    color: palette.danger,
                    fontSize: 12.5,
                    height: 1.40,
                    fontWeight: FontWeight.w600,
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

Widget _compareHeader({required String text, required _Palette palette}) {
  return Text(
    text,
    style: TextStyle(
      color: palette.primary,
      fontSize: 12,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.5,
    ),
  );
}

Widget _compareRow({required _CompareEntry entry, required _Palette palette}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: entry.tone.withValues(alpha: 0.45)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Icon(entry.icon, color: entry.tone, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  entry.eventName,
                  style: TextStyle(
                    color: palette.onSurface,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            entry.payload,
            style: TextStyle(
              color: entry.tone,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            entry.size,
            style: TextStyle(
              color: palette.onSurface.withValues(alpha: 0.78),
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 10: Caveats.
//
// Five caveat cards: trackpad-only, macOS / iPadOS specificity, no-payload
// semantics, ordering with the next scroll event, embedderId propagation.
// =============================================================================

Widget _buildCaveats() {
  const _Palette palette = _caveatPalette;
  const List<_CaveatCard> cards = <_CaveatCard>[
    _CaveatCard(
      title: 'Trackpad-only',
      body: 'PointerScrollInertiaCancelEvent is constrained to '
          'PointerDeviceKind.trackpad. The wheel of a mouse never cancels '
          'inertia because mouse wheels do not ride a momentum simulation '
          'in the first place.',
      icon: Icons.mouse_outlined,
      tone: Color(0xFFEF6C00),
    ),
    _CaveatCard(
      title: 'macOS- and iPadOS-specific in practice',
      body: 'In practice the only embedders that produce this signal are '
          'macOS and iPadOS. Linux and Windows do not have first-class '
          'platform-managed trackpad inertia, so they typically do not '
          'emit it.',
      icon: Icons.laptop_mac,
      tone: Color(0xFFD84315),
    ),
    _CaveatCard(
      title: 'No-payload semantics',
      body: 'Treat the *arrival* of the event as the entire signal. There '
          'is no scrollDelta to integrate, no scale to apply. Branching on '
          'runtimeType is the canonical detection idiom.',
      icon: Icons.cancel_presentation,
      tone: Color(0xFFFB8C00),
    ),
    _CaveatCard(
      title: 'Ordering with the next scroll event',
      body: 'Expect a fresh PointerScrollEvent to follow shortly after '
          'cancel. Do not block the scrollable from accepting it — your '
          'job is only to stop the simulation, not to ignore further '
          'input.',
      icon: Icons.swap_vert,
      tone: Color(0xFFFFA000),
    ),
    _CaveatCard(
      title: 'embedderId propagation',
      body: 'embedderId is forwarded unchanged from the engine. If the '
          'native side correlates inertia start, frames, and cancel by '
          'embedderId, you should preserve it in any logging or telemetry '
          'you derive from this event.',
      icon: Icons.qr_code_2,
      tone: Color(0xFFBF360C),
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: palette.surface,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: palette.primary.withValues(alpha: 0.20)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: palette.primary, size: 24),
            const SizedBox(width: 10),
            Text(
              'Caveats & footguns',
              style: TextStyle(
                color: palette.onSurface,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            for (final _CaveatCard c in cards)
              _caveatCard(card: c, palette: palette),
          ],
        ),
      ],
    ),
  );
}

Widget _caveatCard({required _CaveatCard card, required _Palette palette}) {
  return Container(
    width: 320,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: card.tone.withValues(alpha: 0.50), width: 1.3),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: card.tone.withValues(alpha: 0.18),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Icon(card.icon, color: card.tone, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                card.title,
                style: TextStyle(
                  color: palette.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          card.body,
          style: TextStyle(
            color: palette.onSurface.withValues(alpha: 0.78),
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 11: Footer.
//
// Three takeaway lines with an amber accent stripe and a final caption.
// =============================================================================

Widget _buildFooter() {
  const _Palette palette = _footerPalette;
  const List<_Takeaway> takeaways = <_Takeaway>[
    _Takeaway(
      headline: 'Tiny event, big consequences',
      body: 'A single PointerScrollInertiaCancelEvent can save you from a '
          'subtle but maddening "scroll keeps going after I touch" bug.',
      icon: Icons.bolt,
    ),
    _Takeaway(
      headline: 'Switch on type, not on payload',
      body: 'There is no payload. `event is PointerScrollInertiaCancelEvent` '
          'is the only correct test.',
      icon: Icons.bug_report_outlined,
    ),
    _Takeaway(
      headline: 'Always pair with PointerScrollEvent',
      body: 'In real apps, the cancel is the bridge between two scroll '
          'regimes. Handle both, and treat them as a unit.',
      icon: Icons.link,
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: palette.surface,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: palette.accent.withValues(alpha: 0.55)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 32,
              decoration: BoxDecoration(
                color: palette.accent,
                borderRadius: const BorderRadius.all(Radius.circular(3)),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Takeaways',
              style: TextStyle(
                color: palette.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: <Widget>[
            for (int i = 0; i < takeaways.length; i++) ...<Widget>[
              _takeawayRow(t: takeaways[i], palette: palette),
              if (i < takeaways.length - 1) const SizedBox(height: 10),
            ],
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: palette.accent.withValues(alpha: 0.18),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Icon(Icons.local_fire_department,
                  color: palette.accent, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Demo authored for the D4rt-AST interpreter test suite. '
                  'Visualises PointerScrollInertiaCancelEvent end to end.',
                  style: TextStyle(
                    color: palette.onSurface,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    height: 1.40,
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

Widget _takeawayRow({required _Takeaway t, required _Palette palette}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      border: Border.all(color: palette.accent.withValues(alpha: 0.40)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: palette.accent.withValues(alpha: 0.22),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Icon(t.icon, color: palette.accent, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.headline,
                style: TextStyle(
                  color: palette.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                t.body,
                style: TextStyle(
                  color: palette.onSurface.withValues(alpha: 0.78),
                  fontSize: 12.5,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

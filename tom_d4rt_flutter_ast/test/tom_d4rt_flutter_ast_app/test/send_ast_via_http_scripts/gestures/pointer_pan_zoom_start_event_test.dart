// D4rt deep-demo test script: PointerPanZoomStartEvent
// A hand-authored, scrollable visual explainer for Flutter's
// PointerPanZoomStartEvent class from package:flutter/gestures.dart.
// The page walks through the trackpad pan/zoom lifecycle and zooms in on
// the START phase: every public field, the constructor signature, a
// stylised trackpad anatomy diagram, comparisons with the Update and End
// siblings, real-world use-cases and the platform caveats that bite
// developers when they first reach for this event.
//
// Palette: violet primary, deep teal accents, amber highlights. The
// design intentionally diverges from the sibling End-event demo: rounded
// squares with teardrop accents instead of framed cards, trackpad
// converging-fingers diagram instead of vector arrows, and a vertical
// takeaway sidebar instead of a navy footer panel.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Palette constants (violet / teal / amber). Kept top-level and const so the
// helper widgets can reference them without re-instantiation.
// ---------------------------------------------------------------------------

const Color kViolet50 = Color(0xFFF5F3FF);
const Color kViolet100 = Color(0xFFEDE9FE);
const Color kViolet200 = Color(0xFFDDD6FE);
const Color kViolet300 = Color(0xFFC4B5FD);
const Color kViolet400 = Color(0xFFA78BFA);
const Color kViolet500 = Color(0xFF8B5CF6);
const Color kViolet600 = Color(0xFF7C3AED);
const Color kViolet700 = Color(0xFF6D28D9);
const Color kViolet800 = Color(0xFF5B21B6);
const Color kViolet900 = Color(0xFF4C1D95);

const Color kTeal50 = Color(0xFFF0FDFA);
const Color kTeal100 = Color(0xFFCCFBF1);
const Color kTeal200 = Color(0xFF99F6E4);
const Color kTeal300 = Color(0xFF5EEAD4);
const Color kTeal400 = Color(0xFF2DD4BF);
const Color kTeal500 = Color(0xFF14B8A6);
const Color kTeal600 = Color(0xFF0D9488);
const Color kTeal700 = Color(0xFF0F766E);
const Color kTeal800 = Color(0xFF115E59);
const Color kTeal900 = Color(0xFF134E4A);

const Color kAmber100 = Color(0xFFFEF3C7);
const Color kAmber200 = Color(0xFFFDE68A);
const Color kAmber300 = Color(0xFFFCD34D);
const Color kAmber400 = Color(0xFFFBBF24);
const Color kAmber500 = Color(0xFFF59E0B);
const Color kAmber600 = Color(0xFFD97706);
const Color kAmber700 = Color(0xFFB45309);

const Color kInkPrimary = Color(0xFF1E1B4B);
const Color kInkBody = Color(0xFF312E81);
const Color kInkMuted = Color(0xFF6B7280);
const Color kSurface = Color(0xFFFAFAF9);
const Color kSurfaceCard = Colors.white;

// ---------------------------------------------------------------------------
// Top-level value-holder classes used by individual sections. Kept const,
// behaviorless, and small.
// ---------------------------------------------------------------------------

class FieldFact {
  final String name;
  final String type;
  final String sample;
  final String summary;
  final String detail;
  final IconData icon;
  final Color teardrop;
  final Color square;

  const FieldFact({
    required this.name,
    required this.type,
    required this.sample,
    required this.summary,
    required this.detail,
    required this.icon,
    required this.teardrop,
    required this.square,
  });
}

class PhasePill {
  final String label;
  final String moment;
  final IconData icon;
  final Color base;
  final Color glow;
  final bool current;

  const PhasePill({
    required this.label,
    required this.moment,
    required this.icon,
    required this.base,
    required this.glow,
    this.current = false,
  });
}

class CompareColumn {
  final String typeName;
  final String when;
  final List<String> carries;
  final List<String> missing;
  final Color accent;
  final IconData icon;
  final bool current;

  const CompareColumn({
    required this.typeName,
    required this.when,
    required this.carries,
    required this.missing,
    required this.accent,
    required this.icon,
    this.current = false,
  });
}

class UseCaseEntry {
  final String title;
  final String summary;
  final String snippet;
  final IconData icon;
  final Color accent;
  final String tagline;

  const UseCaseEntry({
    required this.title,
    required this.summary,
    required this.snippet,
    required this.icon,
    required this.accent,
    required this.tagline,
  });
}

class CaveatEntry {
  final String title;
  final String body;
  final String hint;
  final IconData icon;
  final Color tint;

  const CaveatEntry({
    required this.title,
    required this.body,
    required this.hint,
    required this.icon,
    required this.tint,
  });
}

class TakeawayLine {
  final String headline;
  final String detail;
  final IconData icon;

  const TakeawayLine({
    required this.headline,
    required this.detail,
    required this.icon,
  });
}

class ReadoutCell {
  final String label;
  final String value;
  final String hint;
  final IconData icon;
  final Color tint;

  const ReadoutCell({
    required this.label,
    required this.value,
    required this.hint,
    required this.icon,
    required this.tint,
  });
}

// ---------------------------------------------------------------------------
// build(BuildContext): Entry-point invoked once by the harness. Constructs
// the canonical sample event, prepares all data and returns the page.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // Canonical sample used throughout the page. Const-constructible because
  // PointerPanZoomStartEvent has a const constructor.
  const PointerPanZoomStartEvent sample = PointerPanZoomStartEvent(
    timeStamp: Duration(milliseconds: 842),
    pointer: 7,
    device: 0,
    position: Offset(168, 96),
    embedderId: 0,
  );

  const String fmtPosition = '(168.0, 96.0)';
  const String fmtTimeStamp = '0:00:00.842000';
  const String fmtKind = 'PointerDeviceKind.trackpad';

  const List<FieldFact> fields = <FieldFact>[
    FieldFact(
      name: 'timeStamp',
      type: 'Duration',
      sample: fmtTimeStamp,
      summary: 'When the gesture started.',
      detail:
          'Embedder-defined epoch, monotonically increasing. Pair with the '
          'matching End event to compute the gesture duration; pair with '
          'Update events to derive instantaneous velocity.',
      icon: Icons.schedule,
      teardrop: kAmber400,
      square: kViolet100,
    ),
    FieldFact(
      name: 'pointer',
      type: 'int',
      sample: '7',
      summary: 'Engine-assigned pointer id.',
      detail:
          'Stable across the Start / Update / End sequence so recognizers '
          'can correlate phases. Multiple concurrent trackpad gestures '
          'each get their own pointer id.',
      icon: Icons.fingerprint,
      teardrop: kTeal400,
      square: kTeal50,
    ),
    FieldFact(
      name: 'device',
      type: 'int',
      sample: '0',
      summary: 'Physical input device id.',
      detail:
          'Two trackpads on the same host produce different device ids. '
          'Most laptop embeddings report device 0 for the built-in '
          'trackpad.',
      icon: Icons.devices_other,
      teardrop: kViolet400,
      square: kViolet50,
    ),
    FieldFact(
      name: 'position',
      type: 'Offset',
      sample: fmtPosition,
      summary: 'Global cursor location.',
      detail:
          'Logical-pixel coordinates relative to the Flutter view at the '
          'moment the gesture started. This is the baseline pivot for any '
          'subsequent pan or zoom math.',
      icon: Icons.gps_fixed,
      teardrop: kAmber500,
      square: kAmber100,
    ),
    FieldFact(
      name: 'embedderId',
      type: 'int',
      sample: '0',
      summary: 'Embedder correlation handle.',
      detail:
          'Optional and typically zero. Custom embedders use this to bind '
          'pointer events to host-platform handles such as a webview '
          'gesture token or a native NSEvent identifier.',
      icon: Icons.layers,
      teardrop: kTeal500,
      square: kTeal100,
    ),
    FieldFact(
      name: 'kind',
      type: 'PointerDeviceKind',
      sample: fmtKind,
      summary: 'Always trackpad.',
      detail:
          'Hardcoded by the constructor — the Start event is exclusive to '
          'trackpad-class devices. Mice, touch screens and styluses use '
          'Down/Move/Up sequences instead.',
      icon: Icons.mouse,
      teardrop: kViolet500,
      square: kViolet100,
    ),
    FieldFact(
      name: 'localPosition',
      type: 'Offset',
      sample: 'inherited',
      summary: 'Local-frame cursor location.',
      detail:
          'Inherited from PointerEvent. Mirrors position until a hit-test '
          'transforms the event into a child coordinate system; then it '
          'reflects the local frame for that subtree.',
      icon: Icons.gps_not_fixed,
      teardrop: kAmber600,
      square: kAmber100,
    ),
    FieldFact(
      name: 'down',
      type: 'bool',
      sample: 'false',
      summary: 'Always false.',
      detail:
          'Trackpad pan/zoom phases never count as a "down" pointer. The '
          'gesture is detected from inertial-class motion, not from a '
          'button press.',
      icon: Icons.toggle_off_outlined,
      teardrop: kTeal600,
      square: kTeal50,
    ),
  ];

  const List<PhasePill> phases = <PhasePill>[
    PhasePill(
      label: 'Down',
      moment: 'finger contact',
      icon: Icons.touch_app_outlined,
      base: kInkMuted,
      glow: kInkMuted,
    ),
    PhasePill(
      label: 'Move',
      moment: 'cursor drift',
      icon: Icons.drag_indicator,
      base: kInkMuted,
      glow: kInkMuted,
    ),
    PhasePill(
      label: 'PanZoomStart',
      moment: 'gesture begins',
      icon: Icons.start,
      base: kViolet600,
      glow: kViolet400,
      current: true,
    ),
    PhasePill(
      label: 'PanZoomUpdate',
      moment: 'deltas + scale',
      icon: Icons.sync,
      base: kInkMuted,
      glow: kInkMuted,
    ),
    PhasePill(
      label: 'PanZoomEnd',
      moment: 'gesture closes',
      icon: Icons.flag_outlined,
      base: kInkMuted,
      glow: kInkMuted,
    ),
  ];

  const List<CompareColumn> compareColumns = <CompareColumn>[
    CompareColumn(
      typeName: 'PointerPanZoomStartEvent',
      when: 'Phase begins.',
      carries: <String>[
        'timeStamp',
        'pointer / device',
        'baseline position',
        'kind = trackpad',
        'embedderId',
      ],
      missing: <String>[
        'no pan delta',
        'no scale',
        'no rotation',
        'no localPan',
      ],
      accent: kViolet600,
      icon: Icons.flag_circle_outlined,
      current: true,
    ),
    CompareColumn(
      typeName: 'PointerPanZoomUpdateEvent',
      when: 'Phase progresses.',
      carries: <String>[
        'timeStamp',
        'pan + panDelta',
        'scale + rotation',
        'baseline position',
        'localPan',
      ],
      missing: <String>['no terminal flag'],
      accent: kTeal600,
      icon: Icons.sync,
      current: false,
    ),
    CompareColumn(
      typeName: 'PointerPanZoomEndEvent',
      when: 'Phase ends.',
      carries: <String>[
        'timeStamp',
        'final position',
        'pointer / device',
        'kind = trackpad',
        'embedderId',
      ],
      missing: <String>['no deltas (snapshot only)'],
      accent: kAmber600,
      icon: Icons.stop_circle_outlined,
      current: false,
    ),
  ];

  const List<UseCaseEntry> useCases = <UseCaseEntry>[
    UseCaseEntry(
      title: 'Anchor a transform',
      tagline: 'pin the pivot before any motion',
      summary:
          'Capture the Start position so subsequent Update events can apply '
          'their pan/scale relative to a stable origin. Without this anchor '
          'the user perceives the surface "snapping" on the first update.',
      snippet: '''
void onPanZoomStart(PointerPanZoomStartEvent e) {
  pivot = e.position;
  baselineMatrix = currentMatrix;
}''',
      icon: Icons.push_pin_outlined,
      accent: kViolet600,
    ),
    UseCaseEntry(
      title: 'Snapshot for inertia',
      tagline: 'seed the velocity tracker',
      summary:
          'Start carries the timeStamp at which the trackpad gesture began. '
          'Inertia simulators use this as t0 and the position as p0 so the '
          'eventual fling carries the correct slope.',
      snippet: '''
void onPanZoomStart(PointerPanZoomStartEvent e) {
  velocityTracker.addPosition(e.timeStamp, e.position);
}''',
      icon: Icons.timeline,
      accent: kTeal600,
    ),
    UseCaseEntry(
      title: 'Log gesture begin',
      tagline: 'analytics breadcrumb',
      summary:
          'Start is the natural breadcrumb for analytics — it pairs cleanly '
          'with End to compute duration and abandonment, and identifies '
          'pointer / device for fan-out into per-device dashboards.',
      snippet: '''
void onPanZoomStart(PointerPanZoomStartEvent e) {
  analytics.event('gesture_begin', {
    'pointer': e.pointer,
    'device': e.device,
    'ts': e.timeStamp.inMicroseconds,
  });
}''',
      icon: Icons.event_note_outlined,
      accent: kAmber600,
    ),
    UseCaseEntry(
      title: 'Prepare the hit-test',
      tagline: 'cache the target subtree',
      summary:
          'Start is the only chance to perform a costly hit-test before '
          'Update events flood in. Cache the resolved RenderObject and '
          'reuse it for the rest of the gesture.',
      snippet: '''
void onPanZoomStart(PointerPanZoomStartEvent e) {
  final hit = HitTestResult();
  WidgetsBinding.instance.hitTest(hit, e.position);
  activeTarget = hit.path.firstOrNull;
}''',
      icon: Icons.center_focus_strong_outlined,
      accent: kViolet700,
    ),
  ];

  const List<CaveatEntry> caveats = <CaveatEntry>[
    CaveatEntry(
      title: 'Trackpad-only',
      body:
          'The framework only synthesises Pan/Zoom phases for trackpad-class '
          'devices. Mice and touch screens never produce this event class.',
      hint: 'Filter by kind defensively even though it is hardcoded.',
      icon: Icons.mouse,
      tint: kViolet500,
    ),
    CaveatEntry(
      title: 'Desktop-class platforms',
      body:
          'macOS, Windows and Linux precision touchpads emit pan/zoom. iOS '
          'and Android do not — they use scale gesture detectors backed by '
          'multi-finger touch sequences instead.',
      hint: 'Gate trackpad logic behind a platform check.',
      icon: Icons.laptop_mac,
      tint: kTeal500,
    ),
    CaveatEntry(
      title: 'down is always false',
      body:
          'Unlike PointerDownEvent the pan/zoom Start event does not set '
          'down=true. Hit-testing logic that gates on down=true will skip '
          'this event by accident.',
      hint: 'Use the runtime type, not the down flag.',
      icon: Icons.toggle_off_outlined,
      tint: kAmber600,
    ),
    CaveatEntry(
      title: 'kind is hardcoded',
      body:
          'The constructor passes PointerDeviceKind.trackpad to its super '
          'and offers no kind: parameter. Any code that tries to spoof a '
          'mouse pan/zoom is fighting the framework.',
      hint: 'Treat kind as a guarantee, not a hint.',
      icon: Icons.lock_outline,
      tint: kViolet600,
    ),
    CaveatEntry(
      title: 'embedderId semantics',
      body:
          'embedderId is opaque — its meaning is defined by the embedder. '
          'On the standard Flutter Engine it is zero; only custom embedders '
          'attach domain-specific values.',
      hint: 'Do not assume embedderId == display id.',
      icon: Icons.layers,
      tint: kTeal600,
    ),
  ];

  const List<TakeawayLine> takeaways = <TakeawayLine>[
    TakeawayLine(
      headline: 'Start carries no motion data.',
      detail:
          'It is purely a baseline marker: timeStamp, pointer, device, '
          'position. Update events deliver the actual pan/scale.',
      icon: Icons.flag_outlined,
    ),
    TakeawayLine(
      headline: 'Anchor your transforms here.',
      detail:
          'Capture the pivot and the baseline matrix on Start so Update '
          'math applies relative to a stable reference frame.',
      icon: Icons.push_pin_outlined,
    ),
    TakeawayLine(
      headline: 'Pair Start with End.',
      detail:
          'Pan/Zoom gestures are bracketed by Start and End. Match them '
          'by pointer id to compute duration and total delta.',
      icon: Icons.compare_arrows,
    ),
    TakeawayLine(
      headline: 'Trackpad-class only.',
      detail:
          'No mouse, no touchscreen, no stylus. Filter by runtime type '
          'rather than relying on kind alone.',
      icon: Icons.mouse,
    ),
    TakeawayLine(
      headline: 'Const-constructible.',
      detail:
          'The constructor is const and accepts no kind: parameter. Use '
          'this to author cheap test fixtures.',
      icon: Icons.bolt,
    ),
  ];

  const List<ReadoutCell> readouts = <ReadoutCell>[
    ReadoutCell(
      label: 'timeStamp',
      value: fmtTimeStamp,
      hint: '842 ms after the embedder epoch.',
      icon: Icons.schedule,
      tint: kViolet500,
    ),
    ReadoutCell(
      label: 'pointer',
      value: '7',
      hint: 'Stable across the Start/Update/End triplet.',
      icon: Icons.fingerprint,
      tint: kTeal500,
    ),
    ReadoutCell(
      label: 'device',
      value: '0',
      hint: 'Built-in trackpad.',
      icon: Icons.devices_other,
      tint: kAmber500,
    ),
    ReadoutCell(
      label: 'position',
      value: fmtPosition,
      hint: 'Logical pixels in the global frame.',
      icon: Icons.gps_fixed,
      tint: kViolet600,
    ),
    ReadoutCell(
      label: 'embedderId',
      value: '0',
      hint: 'Standard engine — no embedder routing.',
      icon: Icons.layers,
      tint: kTeal600,
    ),
    ReadoutCell(
      label: 'kind',
      value: 'trackpad',
      hint: 'Hardcoded by the constructor.',
      icon: Icons.mouse,
      tint: kAmber600,
    ),
    ReadoutCell(
      label: 'down',
      value: 'false',
      hint: 'Pan/Zoom never counts as a "down" pointer.',
      icon: Icons.toggle_off_outlined,
      tint: kViolet700,
    ),
    ReadoutCell(
      label: 'localPosition',
      value: fmtPosition,
      hint: 'Mirrors position before any hit-test transform.',
      icon: Icons.gps_not_fixed,
      tint: kTeal700,
    ),
  ];

  return Scaffold(
    backgroundColor: kSurface,
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // 1. Hero header (gradient violet -> deep teal)
          const HeroHeader(),
          const SizedBox(height: 26),
          // 2. Phase state machine pills
          const PhaseStateMachine(phases: phases),
          const SizedBox(height: 30),
          // 3. Field grid (rounded squares with teardrop accents)
          const FieldGridHeading(),
          const SizedBox(height: 14),
          const FieldGrid(fields: fields),
          const SizedBox(height: 30),
          // 4. Construction sample + readout cards
          const ConstructionHeading(),
          const SizedBox(height: 14),
          const ConstructionSample(
            timeStampText: fmtTimeStamp,
            position: fmtPosition,
            pointer: 7,
            device: 0,
            embedderId: 0,
          ),
          const SizedBox(height: 16),
          const ReadoutGrid(cells: readouts),
          const SizedBox(height: 30),
          // 5. Trackpad gesture diagram (320x220, three fingers)
          const DiagramHeading(),
          const SizedBox(height: 14),
          const TrackpadDiagram(),
          const SizedBox(height: 30),
          // 6. Comparison panel
          const CompareHeading(),
          const SizedBox(height: 14),
          const CompareTable(columns: compareColumns),
          const SizedBox(height: 30),
          // 7. Real-world use cases
          const UseCaseHeading(),
          const SizedBox(height: 14),
          const UseCaseGrid(entries: useCases),
          const SizedBox(height: 30),
          // 8. Caveats
          const CaveatHeading(),
          const SizedBox(height: 14),
          const CaveatGrid(entries: caveats),
          const SizedBox(height: 30),
          // 9. Footer with violet sidebar of takeaways
          const TakeawayFooter(takeaways: takeaways),
          const SizedBox(height: 18),
          const SignaturePill(),
          const SizedBox(height: 36),
          // The actual sample event referenced once so analyzer keeps it.
          SampleEcho(event: sample),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1: Hero header.
// Gradient violet -> deep teal, with a trackpad-start icon and the title.
// ---------------------------------------------------------------------------

class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(26, 24, 26, 28),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(22)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            kViolet700,
            kViolet500,
            kTeal700,
          ],
          stops: <double>[0.0, 0.55, 1.0],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 22,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const HeroIcon(),
          const SizedBox(width: 22),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'PointerPanZoomStartEvent',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'The opening note of a trackpad pan/zoom gesture.',
                  style: TextStyle(
                    color: Color(0xFFEDE9FE),
                    fontSize: 14,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const <Widget>[
                    HeroBadge(
                      label: 'gestures.dart',
                      icon: Icons.code,
                    ),
                    HeroBadge(
                      label: 'trackpad-only',
                      icon: Icons.mouse,
                    ),
                    HeroBadge(
                      label: 'phase: START',
                      icon: Icons.flag_outlined,
                    ),
                    HeroBadge(
                      label: 'down = false',
                      icon: Icons.toggle_off_outlined,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeroIcon extends StatelessWidget {
  const HeroIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 84,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: <Color>[
            Color(0xFFFEF3C7),
            Color(0xFFFCD34D),
            Color(0xFFB45309),
          ],
          stops: <double>[0.0, 0.6, 1.0],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x55000000),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.start,
          color: Color(0xFF4C1D95),
          size: 42,
        ),
      ),
    );
  }
}

class HeroBadge extends StatelessWidget {
  final String label;
  final IconData icon;

  const HeroBadge({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: const BoxDecoration(
        color: Color(0x33FFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(999)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 2: Phase state machine.
// Five connected pills. PanZoomStart is highlighted with a violet glow and
// a tooltip pointing at it.
// ---------------------------------------------------------------------------

class PhaseStateMachine extends StatelessWidget {
  final List<PhasePill> phases;

  const PhaseStateMachine({super.key, required this.phases});

  @override
  Widget build(BuildContext context) {
    final List<Widget> rowChildren = <Widget>[];
    for (int i = 0; i < phases.length; i++) {
      rowChildren.add(Expanded(child: PhasePillView(pill: phases[i])));
      if (i != phases.length - 1) {
        rowChildren.add(const PhaseConnector());
      }
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
      decoration: const BoxDecoration(
        color: kSurfaceCard,
        borderRadius: BorderRadius.all(Radius.circular(18)),
        border: Border.fromBorderSide(
          BorderSide(color: kViolet100, width: 1),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Phase state machine',
            style: TextStyle(
              color: kInkPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'A trackpad pan/zoom gesture moves through five distinct phases.',
            style: TextStyle(
              color: kInkMuted,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: rowChildren,
          ),
        ],
      ),
    );
  }
}

class PhasePillView extends StatelessWidget {
  final PhasePill pill;

  const PhasePillView({super.key, required this.pill});

  @override
  Widget build(BuildContext context) {
    if (pill.current) {
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          // Glow
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(14)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: pill.glow.withValues(alpha: 0.55),
                  blurRadius: 28,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              decoration: const BoxDecoration(
                color: kViolet600,
                borderRadius: BorderRadius.all(Radius.circular(14)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[kViolet600, kViolet800],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(pill.icon, color: Colors.white, size: 22),
                  const SizedBox(height: 6),
                  Text(
                    pill.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    pill.moment,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFEDE9FE),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: -22,
            child: TooltipBubble(text: 'you are here'),
          ),
        ],
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: const BoxDecoration(
        color: kViolet50,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: Border.fromBorderSide(
          BorderSide(color: kViolet100, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(pill.icon, color: pill.base, size: 20),
          const SizedBox(height: 6),
          Text(
            pill.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kInkBody,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            pill.moment,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: kInkMuted,
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    );
  }
}

class TooltipBubble extends StatelessWidget {
  final String text;

  const TooltipBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: const BoxDecoration(
            color: kAmber400,
            borderRadius: BorderRadius.all(Radius.circular(999)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.arrow_downward,
                size: 12,
                color: kViolet900,
              ),
              const SizedBox(width: 4),
              Text(
                text,
                style: const TextStyle(
                  color: kViolet900,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PhaseConnector extends StatelessWidget {
  const PhaseConnector({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 22,
      height: 56,
      child: Center(
        child: Icon(
          Icons.chevron_right,
          color: kViolet300,
          size: 22,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 3: Field grid heading + grid (rounded squares with teardrops).
// ---------------------------------------------------------------------------

class FieldGridHeading extends StatelessWidget {
  const FieldGridHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionHeading(
      number: '01',
      title: 'Eight fields',
      subtitle:
          'Every public field carried by a PointerPanZoomStartEvent — both '
          'the ones declared on this class and the ones inherited from '
          'PointerEvent.',
      icon: Icons.grid_view_outlined,
      tint: kViolet600,
    );
  }
}

class FieldGrid extends StatelessWidget {
  final List<FieldFact> fields;

  const FieldGrid({super.key, required this.fields});

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < fields.length; i += 2) {
      final FieldFact left = fields[i];
      final FieldFact? right = (i + 1 < fields.length) ? fields[i + 1] : null;
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: FieldSquare(field: left)),
              const SizedBox(width: 14),
              Expanded(
                child: right == null
                    ? const SizedBox.shrink()
                    : FieldSquare(field: right),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

class FieldSquare extends StatelessWidget {
  final FieldFact field;

  const FieldSquare({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: field.square,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: kViolet200, width: 1),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 14,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      field.icon,
                      color: field.teardrop,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          field.name,
                          style: const TextStyle(
                            color: kInkPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'monospace',
                          ),
                        ),
                        Text(
                          field.type,
                          style: const TextStyle(
                            color: kInkMuted,
                            fontSize: 11.5,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Row(
                  children: <Widget>[
                    const Text(
                      'sample: ',
                      style: TextStyle(
                        color: kInkMuted,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        field.sample,
                        style: const TextStyle(
                          color: kViolet800,
                          fontSize: 11.5,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                field.summary,
                style: const TextStyle(
                  color: kInkBody,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                field.detail,
                style: const TextStyle(
                  color: kInkMuted,
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ],
          ),
          // Teardrop accent in the top-right
          Positioned(
            top: -2,
            right: -2,
            child: Teardrop(color: field.teardrop),
          ),
        ],
      ),
    );
  }
}

class Teardrop extends StatelessWidget {
  final Color color;

  const Teardrop({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(11),
          topRight: Radius.circular(11),
          bottomLeft: Radius.circular(11),
          bottomRight: Radius.circular(2),
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 4: Construction sample + readout grid.
// ---------------------------------------------------------------------------

class ConstructionHeading extends StatelessWidget {
  const ConstructionHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionHeading(
      number: '02',
      title: 'Construction',
      subtitle:
          'The Start event has a const constructor with five named '
          'parameters. Note the absence of a kind: parameter — kind is '
          'fixed to PointerDeviceKind.trackpad in the super call.',
      icon: Icons.construction,
      tint: kTeal600,
    );
  }
}

class ConstructionSample extends StatelessWidget {
  final String timeStampText;
  final String position;
  final int pointer;
  final int device;
  final int embedderId;

  const ConstructionSample({
    super.key,
    required this.timeStampText,
    required this.position,
    required this.pointer,
    required this.device,
    required this.embedderId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: const BoxDecoration(
        color: Color(0xFF1E1B4B),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              CodeDot(color: Color(0xFFFCA5A5)),
              SizedBox(width: 6),
              CodeDot(color: Color(0xFFFCD34D)),
              SizedBox(width: 6),
              CodeDot(color: Color(0xFF6EE7B7)),
              SizedBox(width: 12),
              Text(
                'sample.dart',
                style: TextStyle(
                  color: Color(0xFFC4B5FD),
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const CodeLine(text: 'const PointerPanZoomStartEvent('),
          CodeLine(
            text: '  timeStamp: Duration(milliseconds: 842),',
            kind: CodeLineKind.field,
            highlight: '842',
          ),
          CodeLine(
            text: '  pointer: $pointer,',
            kind: CodeLineKind.field,
            highlight: '$pointer',
          ),
          CodeLine(
            text: '  device: $device,',
            kind: CodeLineKind.field,
            highlight: '$device',
          ),
          CodeLine(
            text: '  position: Offset(168, 96),',
            kind: CodeLineKind.field,
            highlight: '168, 96',
          ),
          CodeLine(
            text: '  embedderId: $embedderId,',
            kind: CodeLineKind.field,
            highlight: '$embedderId',
          ),
          const CodeLine(text: ');'),
          const SizedBox(height: 12),
          const CodeLine(
            text: '// kind is hardcoded to trackpad inside super().',
            kind: CodeLineKind.comment,
          ),
          const SizedBox(height: 6),
          CodeLine(text: '// timeStamp: $timeStampText', kind: CodeLineKind.comment),
          CodeLine(text: '// position:  $position', kind: CodeLineKind.comment),
        ],
      ),
    );
  }
}

class CodeDot extends StatelessWidget {
  final Color color;

  const CodeDot({super.key, required this.color});

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

enum CodeLineKind { code, comment, field }

class CodeLine extends StatelessWidget {
  final String text;
  final CodeLineKind kind;
  final String? highlight;

  const CodeLine({
    super.key,
    required this.text,
    this.kind = CodeLineKind.code,
    this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (kind) {
      case CodeLineKind.comment:
        color = const Color(0xFF7C3AED);
        break;
      case CodeLineKind.field:
        color = const Color(0xFFE0E7FF);
        break;
      case CodeLineKind.code:
        color = const Color(0xFFFAF5FF);
        break;
    }
    final String? hl = highlight;
    if (hl == null || !text.contains(hl)) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.5),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontFamily: 'monospace',
            height: 1.4,
          ),
        ),
      );
    }
    final int hlStart = text.indexOf(hl);
    final String before = text.substring(0, hlStart);
    final String after = text.substring(hlStart + hl.length);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: color,
            fontSize: 13,
            fontFamily: 'monospace',
            height: 1.4,
          ),
          children: <TextSpan>[
            TextSpan(text: before),
            TextSpan(
              text: hl,
              style: const TextStyle(
                color: kAmber300,
                fontWeight: FontWeight.w700,
                backgroundColor: Color(0x224C1D95),
              ),
            ),
            TextSpan(text: after),
          ],
        ),
      ),
    );
  }
}

class ReadoutGrid extends StatelessWidget {
  final List<ReadoutCell> cells;

  const ReadoutGrid({super.key, required this.cells});

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < cells.length; i += 2) {
      final ReadoutCell left = cells[i];
      final ReadoutCell? right = (i + 1 < cells.length) ? cells[i + 1] : null;
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: ReadoutCellView(cell: left)),
              const SizedBox(width: 10),
              Expanded(
                child: right == null
                    ? const SizedBox.shrink()
                    : ReadoutCellView(cell: right),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

class ReadoutCellView extends StatelessWidget {
  final ReadoutCell cell;

  const ReadoutCellView({super.key, required this.cell});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: const BoxDecoration(
        color: kSurfaceCard,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: Border.fromBorderSide(
          BorderSide(color: kViolet100, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: cell.tint.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(cell.icon, color: cell.tint, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  cell.label,
                  style: const TextStyle(
                    color: kInkMuted,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  cell.value,
                  style: const TextStyle(
                    color: kInkPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  cell.hint,
                  style: const TextStyle(
                    color: kInkMuted,
                    fontSize: 11.5,
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
}

// ---------------------------------------------------------------------------
// SECTION 5: Trackpad gesture diagram (320x220) with 3 fingers converging.
// ---------------------------------------------------------------------------

class DiagramHeading extends StatelessWidget {
  const DiagramHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionHeading(
      number: '03',
      title: 'Anatomy of the gesture',
      subtitle:
          'A stylised trackpad: three fingers converging on a START dot. '
          'No vectors yet — Start carries only the baseline location.',
      icon: Icons.touch_app_outlined,
      tint: kAmber600,
    );
  }
}

class TrackpadDiagram extends StatelessWidget {
  const TrackpadDiagram({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: const BoxDecoration(
        color: kSurfaceCard,
        borderRadius: BorderRadius.all(Radius.circular(18)),
        border: Border.fromBorderSide(
          BorderSide(color: kViolet100, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            width: 320,
            height: 220,
            child: TrackpadStage(),
          ),
          const SizedBox(height: 14),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: const <Widget>[
              DiagramLegend(
                color: kViolet500,
                label: 'finger contact',
                icon: Icons.fingerprint,
              ),
              DiagramLegend(
                color: kAmber500,
                label: 'START position',
                icon: Icons.flag_outlined,
              ),
              DiagramLegend(
                color: kTeal500,
                label: 'trackpad surface',
                icon: Icons.crop_landscape,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TrackpadStage extends StatelessWidget {
  const TrackpadStage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const <Widget>[
        // Trackpad surface
        Positioned(
          left: 12,
          top: 22,
          right: 12,
          bottom: 22,
          child: TrackpadSurface(),
        ),
        // Center START dot
        Positioned(
          left: 140,
          top: 90,
          child: StartDot(),
        ),
        // Three converging fingers
        Positioned(
          left: 30,
          top: 40,
          child: FingerGlyph(
            label: '1',
            color: kViolet500,
            angle: 0.6,
          ),
        ),
        Positioned(
          right: 36,
          top: 38,
          child: FingerGlyph(
            label: '2',
            color: kViolet600,
            angle: -0.6,
          ),
        ),
        Positioned(
          left: 142,
          bottom: 26,
          child: FingerGlyph(
            label: '3',
            color: kViolet700,
            angle: 0.0,
          ),
        ),
        // Converge arrows (drawn as small chevrons)
        Positioned(
          left: 78,
          top: 78,
          child: ChevronGlyph(angle: 0.6),
        ),
        Positioned(
          right: 86,
          top: 76,
          child: ChevronGlyph(angle: -0.6),
        ),
        Positioned(
          left: 156,
          bottom: 70,
          child: ChevronGlyph(angle: 1.5708),
        ),
      ],
    );
  }
}

class TrackpadSurface extends StatelessWidget {
  const TrackpadSurface({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[kTeal100, kTeal200],
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.fromBorderSide(
          BorderSide(color: kTeal400, width: 2),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          // Crosshair faint
          Positioned(
            left: 0,
            right: 0,
            top: 88,
            child: Container(height: 1, color: kTeal300),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 148,
            child: Container(width: 1, color: kTeal300),
          ),
          const Positioned(
            left: 12,
            top: 8,
            child: Text(
              'trackpad',
              style: TextStyle(
                color: kTeal800,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
              ),
            ),
          ),
          const Positioned(
            right: 12,
            bottom: 8,
            child: Text(
              'logical-pixel space',
              style: TextStyle(
                color: kTeal700,
                fontSize: 10,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StartDot extends StatelessWidget {
  const StartDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: <Color>[kAmber200, kAmber500, kAmber700],
          stops: <double>[0.0, 0.7, 1.0],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x66B45309),
            blurRadius: 18,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'S',
          style: TextStyle(
            color: kViolet900,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class FingerGlyph extends StatelessWidget {
  final String label;
  final Color color;
  final double angle;

  const FingerGlyph({
    super.key,
    required this.label,
    required this.color,
    required this.angle,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: 44,
        height: 56,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class ChevronGlyph extends StatelessWidget {
  final double angle;

  const ChevronGlyph({super.key, required this.angle});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: const Icon(
        Icons.keyboard_double_arrow_right,
        color: kViolet600,
        size: 22,
      ),
    );
  }
}

class DiagramLegend extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;

  const DiagramLegend({
    super.key,
    required this.color,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: const BorderRadius.all(Radius.circular(999)),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 6: Comparison panel — Start vs Update vs End.
// Emphasises that Start carries no deltas/scales, only a baseline position.
// ---------------------------------------------------------------------------

class CompareHeading extends StatelessWidget {
  const CompareHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionHeading(
      number: '04',
      title: 'Start vs Update vs End',
      subtitle:
          'Start opens the gesture and only carries a baseline pivot. '
          'Update adds pan, scale and rotation. End mirrors Start with the '
          'final pivot and no deltas.',
      icon: Icons.compare_arrows,
      tint: kViolet600,
    );
  }
}

class CompareTable extends StatelessWidget {
  final List<CompareColumn> columns;

  const CompareTable({super.key, required this.columns});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: kSurfaceCard,
        borderRadius: BorderRadius.all(Radius.circular(18)),
        border: Border.fromBorderSide(
          BorderSide(color: kViolet100, width: 1),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < columns.length; i++) ...<Widget>[
            Expanded(child: CompareColumnView(column: columns[i])),
            if (i != columns.length - 1) const SizedBox(width: 12),
          ],
        ],
      ),
    );
  }
}

class CompareColumnView extends StatelessWidget {
  final CompareColumn column;

  const CompareColumnView({super.key, required this.column});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: column.current
            ? column.accent.withValues(alpha: 0.08)
            : kSurface,
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        border: Border.all(
          color: column.current
              ? column.accent
              : kViolet100,
          width: column.current ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: column.accent.withValues(alpha: 0.18),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Icon(column.icon, color: column.accent, size: 16),
              ),
              const SizedBox(width: 8),
              if (column.current)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: column.accent,
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: const Text(
                    'CURRENT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            column.typeName,
            style: TextStyle(
              color: column.accent,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            column.when,
            style: const TextStyle(
              color: kInkMuted,
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          const CompareSubheading(label: 'Carries'),
          const SizedBox(height: 4),
          for (final String c in column.carries) CompareBullet(text: c, ok: true),
          const SizedBox(height: 8),
          const CompareSubheading(label: 'Missing'),
          const SizedBox(height: 4),
          for (final String m in column.missing)
            CompareBullet(text: m, ok: false),
        ],
      ),
    );
  }
}

class CompareSubheading extends StatelessWidget {
  final String label;

  const CompareSubheading({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: kInkPrimary,
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
      ),
    );
  }
}

class CompareBullet extends StatelessWidget {
  final String text;
  final bool ok;

  const CompareBullet({super.key, required this.text, required this.ok});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            ok ? Icons.check_circle_outline : Icons.remove_circle_outline,
            size: 13,
            color: ok ? kTeal600 : kAmber600,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: ok ? kInkBody : kInkMuted,
                fontSize: 11.5,
                height: 1.35,
                fontFamily: 'monospace',
                decoration:
                    ok ? TextDecoration.none : TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 7: Real-world use-case grid (4 cards).
// ---------------------------------------------------------------------------

class UseCaseHeading extends StatelessWidget {
  const UseCaseHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionHeading(
      number: '05',
      title: 'When you reach for Start',
      subtitle:
          'Four canonical use-cases in production code: anchor a transform, '
          'snapshot for inertia, log gesture begin, and prepare a hit-test.',
      icon: Icons.lightbulb_outline,
      tint: kTeal600,
    );
  }
}

class UseCaseGrid extends StatelessWidget {
  final List<UseCaseEntry> entries;

  const UseCaseGrid({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < entries.length; i += 2) {
      final UseCaseEntry left = entries[i];
      final UseCaseEntry? right =
          (i + 1 < entries.length) ? entries[i + 1] : null;
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(child: UseCaseCard(entry: left)),
              const SizedBox(width: 14),
              Expanded(
                child: right == null
                    ? const SizedBox.shrink()
                    : UseCaseCard(entry: right),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

class UseCaseCard extends StatelessWidget {
  final UseCaseEntry entry;

  const UseCaseCard({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: const BoxDecoration(
        color: kSurfaceCard,
        borderRadius: BorderRadius.all(Radius.circular(18)),
        border: Border.fromBorderSide(
          BorderSide(color: kViolet100, width: 1),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 14,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: entry.accent.withValues(alpha: 0.15),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Icon(entry.icon, color: entry.accent, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      entry.title,
                      style: const TextStyle(
                        color: kInkPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      entry.tagline,
                      style: TextStyle(
                        color: entry.accent,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            entry.summary,
            style: const TextStyle(
              color: kInkBody,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1B4B),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              entry.snippet,
              style: const TextStyle(
                color: Color(0xFFEDE9FE),
                fontSize: 11.5,
                fontFamily: 'monospace',
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 8: Caveats grid (5 cards).
// ---------------------------------------------------------------------------

class CaveatHeading extends StatelessWidget {
  const CaveatHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionHeading(
      number: '06',
      title: 'Caveats',
      subtitle:
          'Five gotchas that bite teams the first time they implement a '
          'trackpad pan/zoom gesture handler in Flutter.',
      icon: Icons.warning_amber_outlined,
      tint: kAmber600,
    );
  }
}

class CaveatGrid extends StatelessWidget {
  final List<CaveatEntry> entries;

  const CaveatGrid({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    for (final CaveatEntry e in entries) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CaveatRow(entry: e),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}

class CaveatRow extends StatelessWidget {
  final CaveatEntry entry;

  const CaveatRow({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: kSurfaceCard,
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        border: Border(
          left: BorderSide(color: entry.tint, width: 4),
          top: const BorderSide(color: kViolet100),
          right: const BorderSide(color: kViolet100),
          bottom: const BorderSide(color: kViolet100),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: entry.tint.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(entry.icon, color: entry.tint, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.title,
                  style: const TextStyle(
                    color: kInkPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.body,
                  style: const TextStyle(
                    color: kInkBody,
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: entry.tint.withValues(alpha: 0.12),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.lightbulb_outline, size: 13, color: entry.tint),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          entry.hint,
                          style: TextStyle(
                            color: entry.tint,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
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

// ---------------------------------------------------------------------------
// SECTION 9: Footer with vertical takeaway stack and a violet sidebar.
// ---------------------------------------------------------------------------

class TakeawayFooter extends StatelessWidget {
  final List<TakeawayLine> takeaways;

  const TakeawayFooter({super.key, required this.takeaways});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const SidebarStripe(),
        const SizedBox(width: 14),
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
            decoration: const BoxDecoration(
              color: kSurfaceCard,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              border: Border.fromBorderSide(
                BorderSide(color: kViolet100, width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Row(
                  children: <Widget>[
                    Icon(
                      Icons.summarize_outlined,
                      color: kViolet600,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Takeaways',
                      style: TextStyle(
                        color: kInkPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                for (int i = 0; i < takeaways.length; i++) ...<Widget>[
                  TakeawayItem(
                    index: i + 1,
                    line: takeaways[i],
                  ),
                  if (i != takeaways.length - 1) const SizedBox(height: 10),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SidebarStripe extends StatelessWidget {
  const SidebarStripe({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            kViolet400,
            kViolet600,
            kViolet800,
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x224C1D95),
            blurRadius: 10,
            offset: Offset(2, 4),
          ),
        ],
      ),
    );
  }
}

class TakeawayItem extends StatelessWidget {
  final int index;
  final TakeawayLine line;

  const TakeawayItem({
    super.key,
    required this.index,
    required this.line,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: kViolet50,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(color: kViolet300),
            ),
          ),
          child: Center(
            child: Text(
              '$index',
              style: const TextStyle(
                color: kViolet700,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(line.icon, size: 14, color: kViolet600),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      line.headline,
                      style: const TextStyle(
                        color: kInkPrimary,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                line.detail,
                style: const TextStyle(
                  color: kInkMuted,
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SignaturePill extends StatelessWidget {
  const SignaturePill({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: const BoxDecoration(
          color: kViolet50,
          borderRadius: BorderRadius.all(Radius.circular(999)),
          border: Border.fromBorderSide(
            BorderSide(color: kViolet200),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.code, size: 14, color: kViolet700),
            SizedBox(width: 6),
            Text(
              'package:flutter/gestures.dart  ·  PointerPanZoomStartEvent',
              style: TextStyle(
                color: kViolet800,
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reused building block: section heading.
// ---------------------------------------------------------------------------

class SectionHeading extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color tint;

  const SectionHeading({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.tint,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.15),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Icon(icon, color: tint, size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(
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
                      color: tint,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: Text(
                      number,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: kInkPrimary,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(
                  color: kInkMuted,
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SampleEcho: one tiny widget that references the constructed sample event
// so the analyzer sees the variable used. Renders nothing visually visible.
// ---------------------------------------------------------------------------

class SampleEcho extends StatelessWidget {
  final PointerPanZoomStartEvent event;

  const SampleEcho({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'sample.runtimeType=${event.runtimeType}  '
        'pointer=${event.pointer}  '
        'device=${event.device}  '
        'kind=${event.kind}  '
        'down=${event.down}  '
        'embedderId=${event.embedderId}  '
        'position=${event.position}  '
        'localPosition=${event.localPosition}  '
        'timeStamp=${event.timeStamp}',
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: kInkMuted,
          fontSize: 10.5,
          fontFamily: 'monospace',
          height: 1.5,
        ),
      ),
    );
  }
}

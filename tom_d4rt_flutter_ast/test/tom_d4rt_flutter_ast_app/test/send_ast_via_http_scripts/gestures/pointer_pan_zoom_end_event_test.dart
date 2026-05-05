// D4rt deep-demo test script: PointerPanZoomEndEvent
// Hand-authored visual exploration of Flutter's PointerPanZoomEndEvent class
// from package:flutter/gestures.dart. This script renders a long, scrollable,
// information-dense panel describing every facet of the event: its place in
// the trackpad pan-zoom lifecycle, every public field, comparisons with the
// Start and Update siblings, real-world use cases, and platform caveats.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level value-holder classes used by individual sections. Kept small,
// const-constructible, and free of behavior.
// ---------------------------------------------------------------------------

class _FieldRow {
  final String name;
  final String type;
  final String sampleValue;
  final String description;
  final IconData icon;
  final Color accent;

  const _FieldRow({
    required this.name,
    required this.type,
    required this.sampleValue,
    required this.description,
    required this.icon,
    required this.accent,
  });
}

class _PhaseStep {
  final String label;
  final String detail;
  final IconData icon;
  final Color color;
  final bool highlight;

  const _PhaseStep({
    required this.label,
    required this.detail,
    required this.icon,
    required this.color,
    this.highlight = false,
  });
}

class _UseCase {
  final String title;
  final String summary;
  final String snippet;
  final IconData icon;
  final Color color;

  const _UseCase({
    required this.title,
    required this.summary,
    required this.snippet,
    required this.icon,
    required this.color,
  });
}

class _ComparisonCard {
  final String typeName;
  final String moment;
  final List<String> carries;
  final Color color;
  final IconData icon;

  const _ComparisonCard({
    required this.typeName,
    required this.moment,
    required this.carries,
    required this.color,
    required this.icon,
  });
}

class _Caveat {
  final String title;
  final String body;
  final IconData icon;
  final Color tone;

  const _Caveat({
    required this.title,
    required this.body,
    required this.icon,
    required this.tone,
  });
}

class _AnatomyChip {
  final String label;
  final String type;
  final Color color;
  final bool isInherited;

  const _AnatomyChip({
    required this.label,
    required this.type,
    required this.color,
    this.isInherited = false,
  });
}

// ---------------------------------------------------------------------------
// build(BuildContext): Entry-point invoked by the harness once.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // Construct the canonical sample event used throughout the page.
  final PointerPanZoomEndEvent sampleEvent = PointerPanZoomEndEvent(
    timeStamp: const Duration(milliseconds: 1234),
    pointer: 1,
    device: 0,
    position: const Offset(120, 80),
    embedderId: 0,
  );

  // Pre-build the data that drives field-grid and other sections so the
  // widget tree itself stays declarative.
  final List<_FieldRow> fieldRows = const <_FieldRow>[
    _FieldRow(
      name: 'timeStamp',
      type: 'Duration',
      sampleValue: '1234 ms',
      description:
          'Time at which the pan-zoom gesture finished, measured from an '
          'arbitrary epoch defined by the embedder. Used to correlate this '
          'event with prior PanZoomUpdate events for velocity tracking.',
      icon: Icons.schedule,
      accent: Color(0xFF1F8FFF),
    ),
    _FieldRow(
      name: 'pointer',
      type: 'int',
      sampleValue: '1',
      description:
          'Engine-assigned unique identifier of the pointer that produced '
          'this gesture. The same id ties the Start, Update and End events '
          'together so recognizers can demux concurrent gestures.',
      icon: Icons.fingerprint,
      accent: Color(0xFFB45309),
    ),
    _FieldRow(
      name: 'device',
      type: 'int',
      sampleValue: '0',
      description:
          'Identifier of the input device. Two trackpads attached to the '
          'same machine produce events with distinct device ids; embedded '
          'displays usually report 0.',
      icon: Icons.devices_other,
      accent: Color(0xFF14B8A6),
    ),
    _FieldRow(
      name: 'position',
      type: 'Offset',
      sampleValue: '(120, 80)',
      description:
          'Final cursor position in global (logical-pixel) coordinates at '
          'the moment the gesture ended. Combined with the Start position '
          'it yields the total pan delta of the gesture.',
      icon: Icons.gps_fixed,
      accent: Color(0xFFEF4444),
    ),
    _FieldRow(
      name: 'embedderId',
      type: 'int',
      sampleValue: '0',
      description:
          'Optional embedder-side correlation id. Useful for embedders '
          'that need to round-trip gesture metadata to a host platform '
          'such as a webview or a custom host.',
      icon: Icons.layers,
      accent: Color(0xFF8B5CF6),
    ),
    _FieldRow(
      name: 'kind',
      type: 'PointerDeviceKind',
      sampleValue: 'trackpad',
      description:
          'Always trackpad for this event class. Other kinds (mouse, '
          'touch, stylus) never deliver pan-zoom phases — they use Down, '
          'Move, Up sequences instead.',
      icon: Icons.mouse,
      accent: Color(0xFF22C55E),
    ),
    _FieldRow(
      name: 'localPosition',
      type: 'Offset',
      sampleValue: 'inherited',
      description:
          'Inherited from PointerEvent. Mirrors position until a hit-test '
          'transforms the event into a child coordinate system, at which '
          'point localPosition reflects the local frame.',
      icon: Icons.center_focus_strong,
      accent: Color(0xFFEAB308),
    ),
    _FieldRow(
      name: 'down',
      type: 'bool (inherited)',
      sampleValue: 'false',
      description:
          'Always false on End events. The framework treats pan-zoom End '
          'as analogous to a pointer-up: contact with the trackpad surface '
          'has been released and the kinematic state is finalized.',
      icon: Icons.toggle_off,
      accent: Color(0xFF0EA5E9),
    ),
  ];

  final List<_PhaseStep> phaseSteps = const <_PhaseStep>[
    _PhaseStep(
      label: 'Added',
      detail: 'Trackpad enters the hit-test region.',
      icon: Icons.add_circle_outline,
      color: Color(0xFF6366F1),
    ),
    _PhaseStep(
      label: 'PanZoomStart',
      detail: 'User places two fingers; gesture begins.',
      icon: Icons.play_circle_outline,
      color: Color(0xFF3B82F6),
    ),
    _PhaseStep(
      label: 'PanZoomUpdate',
      detail: 'Continuous pan / scale / rotate deltas.',
      icon: Icons.autorenew,
      color: Color(0xFFF59E0B),
    ),
    _PhaseStep(
      label: 'PanZoomEnd',
      detail: 'Fingers lifted — finalize gesture state.',
      icon: Icons.stop_circle_outlined,
      color: Color(0xFFEF4444),
      highlight: true,
    ),
    _PhaseStep(
      label: 'Removed',
      detail: 'Pointer leaves the hit-test region.',
      icon: Icons.remove_circle_outline,
      color: Color(0xFF64748B),
    ),
  ];

  final List<_ComparisonCard> comparisonCards = const <_ComparisonCard>[
    _ComparisonCard(
      typeName: 'PointerPanZoomStartEvent',
      moment: 'Beginning of gesture',
      carries: <String>[
        'timeStamp',
        'pointer / device / kind',
        'position (initial)',
        'no pan / scale / rotation yet',
      ],
      color: Color(0xFF3B82F6),
      icon: Icons.play_arrow,
    ),
    _ComparisonCard(
      typeName: 'PointerPanZoomUpdateEvent',
      moment: 'Mid-gesture (every frame)',
      carries: <String>[
        'pan: Offset (cumulative)',
        'scale: double (relative)',
        'rotation: double (radians)',
        'panDelta: Offset (per-frame)',
      ],
      color: Color(0xFFF59E0B),
      icon: Icons.swap_horiz,
    ),
    _ComparisonCard(
      typeName: 'PointerPanZoomEndEvent',
      moment: 'End of gesture',
      carries: <String>[
        'timeStamp',
        'pointer / device / kind',
        'position (final)',
        'no deltas — gesture is done',
      ],
      color: Color(0xFFEF4444),
      icon: Icons.stop,
    ),
  ];

  final List<_UseCase> useCases = const <_UseCase>[
    _UseCase(
      title: 'Snap-to-grid on end',
      summary:
          'When the user finishes panning a canvas, snap the viewport to '
          'the nearest grid cell so layouts stay visually tidy.',
      snippet:
          'onPointerPanZoomEnd: (e) {\n'
          '  viewport.snapToGrid(cellSize: 16);\n'
          '}',
      icon: Icons.grid_on,
      color: Color(0xFF14B8A6),
    ),
    _UseCase(
      title: 'Commit pinch-zoom result',
      summary:
          'Persist the final scale value once the pinch ends. Avoids '
          'spamming the model with intermediate scale events from Update.',
      snippet:
          'onPointerPanZoomEnd: (e) {\n'
          '  doc.commit(scale: pendingScale);\n'
          '}',
      icon: Icons.zoom_in_map,
      color: Color(0xFF8B5CF6),
    ),
    _UseCase(
      title: 'Log gesture analytics',
      summary:
          'Capture duration and total pan distance for product analytics. '
          'End is the natural moment to flush a gesture record.',
      snippet:
          'onPointerPanZoomEnd: (e) {\n'
          '  analytics.logGesture(\n'
          '    duration: e.timeStamp - startStamp,\n'
          '  );\n'
          '}',
      icon: Icons.insights,
      color: Color(0xFF1F8FFF),
    ),
    _UseCase(
      title: 'Release inertia momentum',
      summary:
          'Hand off velocity tracking to a physics simulation when the '
          'user releases. End fires once and is perfect for kicking off '
          'the inertia animation.',
      snippet:
          'onPointerPanZoomEnd: (e) {\n'
          '  physics.fling(velocity: tracker.last);\n'
          '}',
      icon: Icons.rocket_launch,
      color: Color(0xFFEF4444),
    ),
  ];

  final List<_Caveat> caveats = const <_Caveat>[
    _Caveat(
      title: 'Trackpad-only',
      body:
          'Pan-zoom events exist exclusively for PointerDeviceKind.trackpad. '
          'Touch screens, mice and styli never produce them. Filter by '
          'event.kind if your code paths share a Listener.',
      icon: Icons.touch_app,
      tone: Color(0xFFEF4444),
    ),
    _Caveat(
      title: 'Desktop-class platforms',
      body:
          'Generation requires a host that exposes trackpad gesture '
          'recognizers: macOS, ChromeOS, recent iPadOS (with hardware '
          'trackpad), and select Linux compositors. Android phones lack it.',
      icon: Icons.desktop_mac,
      tone: Color(0xFFF59E0B),
    ),
    _Caveat(
      title: 'No deltas on End',
      body:
          'Unlike PointerPanZoomUpdate, the End event does not carry pan, '
          'scale, or rotation. If you need the final values, capture them '
          'from the most recent Update and stash in your recognizer state.',
      icon: Icons.do_not_disturb_on,
      tone: Color(0xFF8B5CF6),
    ),
    _Caveat(
      title: 'Velocity tracking',
      body:
          'For inertia after release you must run your own '
          'VelocityTracker across the Update phase; the End event itself '
          'gives you only the timestamp at release.',
      icon: Icons.speed,
      tone: Color(0xFF1F8FFF),
    ),
    _Caveat(
      title: 'Cancellation semantics',
      body:
          'A platform-level cancel arrives as PointerPanZoomEnd as well. '
          'There is no separate PointerPanZoomCancel — handle cleanup '
          'idempotently on End.',
      icon: Icons.warning_amber,
      tone: Color(0xFFEAB308),
    ),
  ];

  final List<_AnatomyChip> anatomyChips = const <_AnatomyChip>[
    _AnatomyChip(
      label: 'timeStamp',
      type: 'Duration',
      color: Color(0xFF1F8FFF),
      isInherited: true,
    ),
    _AnatomyChip(
      label: 'pointer',
      type: 'int',
      color: Color(0xFFB45309),
      isInherited: true,
    ),
    _AnatomyChip(
      label: 'device',
      type: 'int',
      color: Color(0xFF14B8A6),
      isInherited: true,
    ),
    _AnatomyChip(
      label: 'position',
      type: 'Offset',
      color: Color(0xFFEF4444),
      isInherited: true,
    ),
    _AnatomyChip(
      label: 'localPosition',
      type: 'Offset',
      color: Color(0xFFEAB308),
      isInherited: true,
    ),
    _AnatomyChip(
      label: 'kind',
      type: 'PointerDeviceKind',
      color: Color(0xFF22C55E),
      isInherited: true,
    ),
    _AnatomyChip(
      label: 'embedderId',
      type: 'int',
      color: Color(0xFF8B5CF6),
      isInherited: true,
    ),
    _AnatomyChip(
      label: 'down',
      type: 'bool',
      color: Color(0xFF0EA5E9),
      isInherited: true,
    ),
  ];

  // -------------------------------------------------------------------------
  // 1. Hero header — gradient strip with title and subtitle.
  // -------------------------------------------------------------------------
  final Widget heroSection = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF1E293B),
          Color(0xFF0F172A),
          Color(0xFF1F2937),
        ],
        stops: <double>[0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x55000000),
          blurRadius: 28,
          offset: Offset(0, 14),
        ),
        BoxShadow(
          color: Color(0x33EF4444),
          blurRadius: 18,
          offset: Offset(0, 4),
        ),
      ],
      border: Border.all(color: const Color(0xFF334155), width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: const RadialGradient(
              colors: <Color>[Color(0xFFEF4444), Color(0xFF7F1D1D)],
              radius: 0.85,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x66EF4444),
                blurRadius: 22,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.stop_circle,
            color: Colors.white,
            size: 38,
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'PointerPanZoomEndEvent',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Trackpad pan-zoom gesture: the moment the user lifts off.',
                style: TextStyle(
                  color: Color(0xFFCBD5E1),
                  fontSize: 14.5,
                  fontWeight: FontWeight.w400,
                  height: 1.45,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Defined in package:flutter/gestures.dart — final phase of '
                'the trackpad gesture lifecycle.',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 12.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // 2. Class anatomy — labelled diagram of the inheritance + field tree.
  // -------------------------------------------------------------------------
  final Widget anatomySection = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Color(0xFFFDF4FF), Color(0xFFF5D0FE)],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFD8B4FE), width: 1.4),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x22A855F7),
          blurRadius: 18,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.account_tree, color: Color(0xFF7C3AED), size: 22),
            SizedBox(width: 8),
            Text(
              'Class anatomy',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF581C87),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Inheritance chain and the public surface this event exposes.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF6B21A8),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 16),
        // Inheritance chain: Object -> Diagnosticable -> PointerEvent ->
        // PointerPanZoomEndEvent.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE9D5FF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Inheritance',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFF7C3AED),
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: const <Widget>[
                  _ChainNode(
                    label: 'Object',
                    color: Color(0xFF94A3B8),
                  ),
                  Icon(Icons.chevron_right, color: Color(0xFF94A3B8)),
                  _ChainNode(
                    label: 'Diagnosticable',
                    color: Color(0xFF64748B),
                  ),
                  Icon(Icons.chevron_right, color: Color(0xFF94A3B8)),
                  _ChainNode(
                    label: 'PointerEvent',
                    color: Color(0xFF6366F1),
                  ),
                  Icon(Icons.chevron_right, color: Color(0xFF7C3AED)),
                  _ChainNode(
                    label: 'PointerPanZoomEndEvent',
                    color: Color(0xFFEF4444),
                    bold: true,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE9D5FF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Field surface',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFF7C3AED),
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (final _AnatomyChip c in anatomyChips)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: c.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: c.color.withValues(alpha: 0.45),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            c.isInherited
                                ? Icons.subdirectory_arrow_right
                                : Icons.fiber_manual_record,
                            size: 14,
                            color: c.color,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            c.label,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: c.color,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            ': ${c.type}',
                            style: const TextStyle(
                              fontSize: 11.5,
                              color: Color(0xFF475569),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // 3. Field-by-field grid — cards.
  // -------------------------------------------------------------------------
  final Widget fieldGridSection = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFCBD5E1), width: 1.2),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 14,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.grid_view, color: Color(0xFF0F172A), size: 22),
            SizedBox(width: 8),
            Text(
              'Field-by-field reference',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Each card shows the field name, declared type, the value carried '
          'by the sample event, and an instructive description.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF334155),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            for (final _FieldRow f in fieldRows) _FieldCard(field: f),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // 4. Phase state machine.
  // -------------------------------------------------------------------------
  final Widget phaseSection = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF0F172A), Color(0xFF1E3A8A)],
      ),
      borderRadius: BorderRadius.circular(18),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x55000000),
          blurRadius: 18,
          offset: Offset(0, 8),
        ),
        BoxShadow(
          color: Color(0x331F8FFF),
          blurRadius: 22,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.timeline, color: Color(0xFFFCA5A5), size: 22),
            SizedBox(width: 8),
            Text(
              'Pan-zoom lifecycle',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'PointerPanZoomEndEvent is one node in the trackpad gesture state '
          'machine. The full sequence is shown below; the highlighted step '
          'is where this event sits.',
          style: TextStyle(
            color: Color(0xFFCBD5E1),
            fontSize: 13,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 6,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            for (int i = 0; i < phaseSteps.length; i++) ...<Widget>[
              _PhaseChip(step: phaseSteps[i]),
              if (i != phaseSteps.length - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: Color(0xFF94A3B8),
                  ),
                ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final _PhaseStep s in phaseSteps)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(s.icon, color: s.color, size: 18),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 130,
                        child: Text(
                          s.label,
                          style: TextStyle(
                            color: s.highlight
                                ? const Color(0xFFFCA5A5)
                                : Colors.white,
                            fontWeight: s.highlight
                                ? FontWeight.w800
                                : FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          s.detail,
                          style: const TextStyle(
                            color: Color(0xFFCBD5E1),
                            fontSize: 12.5,
                            height: 1.4,
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

  // -------------------------------------------------------------------------
  // 5. Construction sample — code block + concrete event readout.
  // -------------------------------------------------------------------------
  final Widget constructionSection = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFEF3C7), Color(0xFFFCD34D)],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFF59E0B), width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.code, color: Color(0xFF92400E), size: 22),
            SizedBox(width: 8),
            Text(
              'Construction sample',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7C2D12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'A canonical PointerPanZoomEndEvent is created by the engine; '
          'tests and synthetic dispatchers create one manually like this:',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF7C2D12),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12),
        // Dark code-style block.
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0B1020),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF1E293B)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const DefaultTextStyle(
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: Color(0xFFE2E8F0),
              height: 1.55,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'final event = PointerPanZoomEndEvent(',
                  style: TextStyle(color: Color(0xFF93C5FD)),
                ),
                Text('  timeStamp: const Duration(milliseconds: 1234),'),
                Text('  pointer: 1,'),
                Text('  device: 0,'),
                Text('  position: const Offset(120, 80),'),
                Text('  embedderId: 0,'),
                Text(
                  ');',
                  style: TextStyle(color: Color(0xFF93C5FD)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Concrete readout cards — mirror sampleEvent values.
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            _ReadoutCard(label: 'runtimeType', value: '${sampleEvent.runtimeType}'),
            _ReadoutCard(label: 'timeStamp', value: '${sampleEvent.timeStamp}'),
            _ReadoutCard(label: 'pointer', value: '${sampleEvent.pointer}'),
            _ReadoutCard(label: 'device', value: '${sampleEvent.device}'),
            _ReadoutCard(label: 'position', value: '${sampleEvent.position}'),
            _ReadoutCard(
              label: 'localPosition',
              value: '${sampleEvent.localPosition}',
            ),
            _ReadoutCard(
              label: 'embedderId',
              value: '${sampleEvent.embedderId}',
            ),
            _ReadoutCard(label: 'kind', value: '${sampleEvent.kind}'),
            _ReadoutCard(label: 'down', value: '${sampleEvent.down}'),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // 6. Comparison panel — Start / Update / End side-by-side.
  // -------------------------------------------------------------------------
  final Widget comparisonSection = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFBFDBFE), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.compare_arrows, color: Color(0xFF1D4ED8), size: 22),
            SizedBox(width: 8),
            Text(
              'Sibling comparison',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E3A8A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'How PointerPanZoomEndEvent fits among its sibling events. Note '
          'how only the Update phase carries pan / scale / rotation data.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF1E40AF),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            for (final _ComparisonCard c in comparisonCards)
              _CompareCard(card: c),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // 7. Trackpad simulator (static).
  // -------------------------------------------------------------------------
  final Widget simulatorSection = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Color(0xFFECFEFF), Color(0xFFA5F3FC)],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFF67E8F9), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(
              Icons.touch_app,
              color: Color(0xFF0E7490),
              size: 22,
            ),
            SizedBox(width: 8),
            Text(
              'Trackpad simulator (static)',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF134E4A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Visual snapshot of a finished pan-zoom gesture. The arrow is the '
          'total pan vector accumulated over the gesture; the End event '
          'fires when the user lifts both fingers off the surface.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF115E59),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Center(
          child: SizedBox(
            width: 320,
            height: 220,
            child: Stack(
              children: <Widget>[
                // Trackpad surface
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color(0xFF1E293B),
                          Color(0xFF0F172A),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFF475569),
                        width: 2,
                      ),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x66000000),
                          blurRadius: 18,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                  ),
                ),
                // Faint grid
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0x22FFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
                // Start dot
                const Positioned(
                  left: 60,
                  top: 150,
                  child: _Dot(
                    color: Color(0xFF3B82F6),
                    label: 'Start',
                    labelColor: Color(0xFF93C5FD),
                  ),
                ),
                // End dot (highlighted)
                const Positioned(
                  left: 220,
                  top: 60,
                  child: _Dot(
                    color: Color(0xFFEF4444),
                    label: 'End',
                    labelColor: Color(0xFFFCA5A5),
                    big: true,
                  ),
                ),
                // Pan vector arrow as a thin rotated container (approx.)
                Positioned(
                  left: 78,
                  top: 110,
                  child: Container(
                    width: 158,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color(0xFF3B82F6),
                          Color(0xFFEF4444),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Scale label
                Positioned(
                  right: 14,
                  top: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x33A855F7),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0x55A855F7),
                      ),
                    ),
                    child: const Text(
                      'final scale: 1.42',
                      style: TextStyle(
                        color: Color(0xFFE9D5FF),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
                // End marker badge
                Positioned(
                  left: 14,
                  top: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x66EF4444),
                          blurRadius: 12,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.stop_circle,
                          color: Colors.white,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'END EVENT',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                            letterSpacing: 0.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF67E8F9)),
          ),
          child: const Text(
            'In a live app the arrow tip and final scale are the values you '
            'will commit on receipt of PointerPanZoomEnd. Note that the End '
            'event itself does not carry these — you read them from the '
            'last PointerPanZoomUpdate observed before End.',
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF134E4A),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // 8. Real-world use cases.
  // -------------------------------------------------------------------------
  final Widget useCaseSection = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFFFBEB), Color(0xFFFDE68A)],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFFCD34D), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.lightbulb, color: Color(0xFF92400E), size: 22),
            SizedBox(width: 8),
            Text(
              'Real-world use cases',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7C2D12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'PointerPanZoomEnd is the ideal place to commit, snap, persist or '
          'fling. The Update phase is for in-flight feedback; the End phase '
          'is for finalization.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF7C2D12),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            for (final _UseCase u in useCases) _UseCaseCard(useCase: u),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // 9. Caveats / gotchas.
  // -------------------------------------------------------------------------
  final Widget caveatSection = Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFFFEF2F2), Color(0xFFFECACA)],
      ),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFFCA5A5), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.warning_amber, color: Color(0xFF991B1B), size: 22),
            SizedBox(width: 8),
            Text(
              'Caveats and gotchas',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Color(0xFF7F1D1D),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Things to remember before shipping code that depends on this '
          'event class.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF991B1B),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Column(
          children: <Widget>[
            for (final _Caveat c in caveats)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _CaveatTile(caveat: c),
              ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // 10. Footer — summary takeaways.
  // -------------------------------------------------------------------------
  final Widget footerSection = Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF0F172A), Color(0xFF1E293B)],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x55000000),
          blurRadius: 20,
          offset: Offset(0, 10),
        ),
      ],
      border: Border.all(color: const Color(0xFF334155)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.flag, color: Color(0xFFFCA5A5), size: 22),
            SizedBox(width: 8),
            Text(
              'Key takeaways',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _Bullet(
          text:
              'PointerPanZoomEndEvent is the terminal phase of the trackpad '
              'pan-zoom gesture lifecycle.',
        ),
        _Bullet(
          text:
              'It carries identity (pointer / device / kind) and the final '
              'position; it does NOT carry pan, scale or rotation deltas.',
        ),
        _Bullet(
          text:
              'Capture deltas from the most recent PointerPanZoomUpdateEvent '
              'and apply them on End for snap, commit, or fling logic.',
        ),
        _Bullet(
          text:
              'Trackpad-only — only fires on platforms that surface trackpad '
              'gesture recognizers (macOS, ChromeOS, iPadOS w/ trackpad).',
        ),
        _Bullet(
          text:
              'Treat End handlers as idempotent: a platform-level cancel '
              'will arrive as End rather than as a separate cancel event.',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // Compose the scaffold.
  // -------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: const Color(0xFFF1F5F9),
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroSection,
          anatomySection,
          fieldGridSection,
          phaseSection,
          constructionSection,
          comparisonSection,
          simulatorSection,
          useCaseSection,
          caveatSection,
          footerSection,
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Widget helpers — small const widgets used by sections above.
// ---------------------------------------------------------------------------

class _ChainNode extends StatelessWidget {
  final String label;
  final Color color;
  final bool bold;

  const _ChainNode({
    required this.label,
    required this.color,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.55)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
          fontSize: 12.5,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

class _FieldCard extends StatelessWidget {
  final _FieldRow field;

  const _FieldCard({required this.field});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: field.accent.withValues(alpha: 0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: field.accent.withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          const BoxShadow(
            color: Color(0x10000000),
            blurRadius: 6,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: field.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(field.icon, color: field.accent, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      field.name,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w800,
                        color: field.accent,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      field.type,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF64748B),
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
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Text(
              'sample: ${field.sampleValue}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: Color(0xFF334155),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            field.description,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF475569),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseChip extends StatelessWidget {
  final _PhaseStep step;

  const _PhaseChip({required this.step});

  @override
  Widget build(BuildContext context) {
    final bool h = step.highlight;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: h
            ? step.color.withValues(alpha: 0.25)
            : Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: h ? step.color : Colors.white.withValues(alpha: 0.25),
          width: h ? 2 : 1,
        ),
        boxShadow: h
            ? <BoxShadow>[
                BoxShadow(
                  color: step.color.withValues(alpha: 0.5),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ]
            : const <BoxShadow>[],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(step.icon, color: h ? Colors.white : step.color, size: 16),
          const SizedBox(width: 6),
          Text(
            step.label,
            style: TextStyle(
              color: h ? Colors.white : const Color(0xFFE2E8F0),
              fontWeight: h ? FontWeight.w800 : FontWeight.w600,
              fontSize: 12.5,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class _ReadoutCard extends StatelessWidget {
  final String label;
  final String value;

  const _ReadoutCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFFCD34D)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Color(0xFF92400E),
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(width: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF334155),
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompareCard extends StatelessWidget {
  final _ComparisonCard card;

  const _CompareCard({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: card.color.withValues(alpha: 0.55)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: card.color.withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
                  color: card.color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(card.icon, color: card.color, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  card.typeName,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5,
                    color: card.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            card.moment,
            style: const TextStyle(
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 10),
          Container(height: 1, color: const Color(0xFFE2E8F0)),
          const SizedBox(height: 10),
          for (final String line in card.carries)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.check_circle,
                    color: card.color,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      line,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF334155),
                        height: 1.35,
                        fontFamily: 'monospace',
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
}

class _Dot extends StatelessWidget {
  final Color color;
  final String label;
  final Color labelColor;
  final bool big;

  const _Dot({
    required this.color,
    required this.label,
    required this.labelColor,
    this.big = false,
  });

  @override
  Widget build(BuildContext context) {
    final double size = big ? 24 : 18;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withValues(alpha: 0.6),
                blurRadius: big ? 16 : 8,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: Colors.white, width: 2),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  final _UseCase useCase;

  const _UseCaseCard({required this.useCase});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: useCase.color.withValues(alpha: 0.55)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: useCase.color.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      useCase.color.withValues(alpha: 0.85),
                      useCase.color.withValues(alpha: 0.55),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(useCase.icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  useCase.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: useCase.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            useCase.summary,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF475569),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF0B1020),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              useCase.snippet,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFFE2E8F0),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CaveatTile extends StatelessWidget {
  final _Caveat caveat;

  const _CaveatTile({required this.caveat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: caveat.tone.withValues(alpha: 0.45)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: caveat.tone.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: caveat.tone.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(caveat.icon, color: caveat.tone, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  caveat.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: caveat.tone,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  caveat.body,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF334155),
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

class _Bullet extends StatelessWidget {
  final String text;

  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.chevron_right,
            color: Color(0xFFFCA5A5),
            size: 18,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFFE2E8F0),
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

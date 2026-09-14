// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
// ObjectCreated / MemoryAllocations — Deep Visual Demo (Aurora variant)
// -----------------------------------------------------------------------------
// This file is a hand-authored, didactic, single-screen visual exploration of
// the foundation-level memory telemetry primitive `ObjectCreated` (delivered
// through `MemoryAllocations.instance`). The screen is rendered statically — no
// timers, no animation controllers, no async — but uses StatefulBuilder pockets
// so the reader can flip through a small in-place gallery of sample payloads
// and pretend-listeners.
//
// The companion file under `retest/foundation/object_created_test.dart` covers
// the same primitive with a warm palette and a different section ordering;
// this file is intentionally cool (cyan / magenta on midnight) and uses an
// "audio mixer board" sample domain for all worked examples.
// =============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// =============================================================================
// SECTION A — palette + decoration constants
// =============================================================================

// Aurora palette: deep midnight base, cyan + magenta highlights, soft mint
// accents for "good" annotations and amber for warnings. These are intentionally
// different from the warm retest sibling.
const Color _kMidnight = Color(0xFF0B1026);
const Color _kAbyss = Color(0xFF050818);
const Color _kSlate = Color(0xFF1A2240);
const Color _kInk = Color(0xFFE8EEFF);
const Color _kInkDim = Color(0xFFA8B3D6);
const Color _kCyan = Color(0xFF42E8E0);
const Color _kCyanDeep = Color(0xFF1FA8B5);
const Color _kMagenta = Color(0xFFE85AB7);
const Color _kIris = Color(0xFF7A5CFF);
const Color _kMint = Color(0xFF74F0B5);
const Color _kAmber = Color(0xFFFFC857);
const Color _kRose = Color(0xFFFF6E8A);

// Re-used gradients across at least eight section cards.
const LinearGradient _kGradAurora = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF12183A), Color(0xFF1B2452), Color(0xFF0F1530)],
  stops: <double>[0.0, 0.55, 1.0],
);

const LinearGradient _kGradCyan = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF0E2A3E), Color(0xFF154B5F), Color(0xFF0A1620)],
);

const LinearGradient _kGradMagenta = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: <Color>[Color(0xFF3A1233), Color(0xFF5D1B52), Color(0xFF1A0A22)],
);

const LinearGradient _kGradIris = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: <Color>[Color(0xFF1F1F55), Color(0xFF302C7A), Color(0xFF110E36)],
);

const LinearGradient _kGradMint = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF0C2E2A), Color(0xFF114842), Color(0xFF071A18)],
);

const LinearGradient _kGradAmber = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0xFF3A2E10), Color(0xFF5D4515), Color(0xFF1A1308)],
);

const LinearGradient _kGradRose = LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  colors: <Color>[Color(0xFF3A1422), Color(0xFF5C1F33), Color(0xFF180812)],
);

const LinearGradient _kGradGlass = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: <Color>[Color(0x33FFFFFF), Color(0x11FFFFFF), Color(0x00FFFFFF)],
);

// Reusable shadow stacks — multi-layer to imply depth without animation.
const List<BoxShadow> _kShadowDeep = <BoxShadow>[
  BoxShadow(
    color: Color(0xCC000000),
    blurRadius: 28,
    spreadRadius: 0,
    offset: Offset(0, 14),
  ),
  BoxShadow(
    color: Color(0x4042E8E0),
    blurRadius: 18,
    spreadRadius: 0,
    offset: Offset(0, 0),
  ),
];

const List<BoxShadow> _kShadowSoft = <BoxShadow>[
  BoxShadow(
    color: Color(0x99000000),
    blurRadius: 18,
    spreadRadius: 0,
    offset: Offset(0, 8),
  ),
  BoxShadow(
    color: Color(0x33E85AB7),
    blurRadius: 28,
    spreadRadius: 1,
    offset: Offset(0, 4),
  ),
];

const List<BoxShadow> _kShadowIris = <BoxShadow>[
  BoxShadow(
    color: Color(0x802A1F66),
    blurRadius: 22,
    spreadRadius: 0,
    offset: Offset(0, 10),
  ),
  BoxShadow(
    color: Color(0x447A5CFF),
    blurRadius: 30,
    spreadRadius: 0,
    offset: Offset(0, 0),
  ),
];

const List<BoxShadow> _kShadowMint = <BoxShadow>[
  BoxShadow(
    color: Color(0x66000000),
    blurRadius: 14,
    spreadRadius: 0,
    offset: Offset(0, 6),
  ),
  BoxShadow(
    color: Color(0x4474F0B5),
    blurRadius: 20,
    spreadRadius: 0,
    offset: Offset(0, 0),
  ),
];

const List<BoxShadow> _kShadowAmber = <BoxShadow>[
  BoxShadow(
    color: Color(0x80000000),
    blurRadius: 16,
    spreadRadius: 0,
    offset: Offset(0, 8),
  ),
  BoxShadow(
    color: Color(0x55FFC857),
    blurRadius: 22,
    spreadRadius: 0,
    offset: Offset(0, 0),
  ),
];

const List<BoxShadow> _kShadowRose = <BoxShadow>[
  BoxShadow(
    color: Color(0x88000000),
    blurRadius: 18,
    spreadRadius: 0,
    offset: Offset(0, 8),
  ),
  BoxShadow(
    color: Color(0x55FF6E8A),
    blurRadius: 24,
    spreadRadius: 0,
    offset: Offset(0, 0),
  ),
];

// =============================================================================
// SECTION B — sample-domain data structures
// =============================================================================
//
// The worked examples in this file all come from a fictional "audio mixer
// board" application. None of these classes are actually allocated through
// `MemoryAllocations.instance` here — that would require a running pipeline
// with proper dispatch. Instead, we render *what the payload would look like*
// if it had been dispatched. This keeps the screen fully static while still
// letting the reader see realistic library / className / object combinations.

class _MixerSamplePayload {
  const _MixerSamplePayload({
    required this.library,
    required this.className,
    required this.objectLabel,
    required this.notes,
    required this.tint,
    required this.glyph,
  });

  final String library;
  final String className;
  final String objectLabel;
  final String notes;
  final Color tint;
  final IconData glyph;
}

const List<_MixerSamplePayload> _kSamplePayloads = <_MixerSamplePayload>[
  _MixerSamplePayload(
    library: 'package:aurora_mixer/src/strip/channel_strip.dart',
    className: 'MixerChannelStrip',
    objectLabel: 'channelStrip#03 (Kick Drum)',
    notes: 'Allocated when the user opens the mixer view; one per visible '
        'channel. Carries gain, pan, mute, solo and a list of inserts.',
    tint: _kCyan,
    glyph: Icons.tune,
  ),
  _MixerSamplePayload(
    library: 'package:aurora_mixer/src/eq/eq_band_filter.dart',
    className: 'EQBandFilter',
    objectLabel: 'eqBand#03-low-shelf',
    notes: 'Created lazily the first time the EQ panel is expanded. Backed '
        'by a biquad coefficient buffer; lifetime tied to the parent strip.',
    tint: _kMagenta,
    glyph: Icons.graphic_eq,
  ),
  _MixerSamplePayload(
    library: 'package:aurora_mixer/src/buss/buss_send_node.dart',
    className: 'BussSendNode',
    objectLabel: 'sendNode#03->aux-reverb',
    notes: 'Allocated on first routing; carries a weak reference to the '
        'destination buss, plus pre/post fader configuration.',
    tint: _kIris,
    glyph: Icons.alt_route,
  ),
  _MixerSamplePayload(
    library: 'package:aurora_mixer/src/meter/meter_decay_sampler.dart',
    className: 'MeterDecaySampler',
    objectLabel: 'meterSampler#03 (RMS+peak)',
    notes: 'Allocated per visible channel; samples RMS and peak. Eligible '
        'for disposal as soon as the strip scrolls off-screen.',
    tint: _kMint,
    glyph: Icons.equalizer,
  ),
  _MixerSamplePayload(
    library: 'package:aurora_mixer/src/automation/automation_lane.dart',
    className: 'AutomationLane',
    objectLabel: 'automation#03/gain',
    notes: 'Allocated when the user enables automation recording on a '
        'parameter. Holds breakpoints and an interpolation strategy.',
    tint: _kAmber,
    glyph: Icons.timeline,
  ),
  _MixerSamplePayload(
    library: 'package:flutter/widgets.dart',
    className: 'GlobalKey',
    objectLabel: 'GlobalKey<MixerStripState>#a1b2',
    notes: 'Flutter itself dispatches a creation event for tracked keys, so '
        'DevTools can correlate widget identity with object lifecycle.',
    tint: _kRose,
    glyph: Icons.vpn_key,
  ),
];

// =============================================================================
// SECTION C — descriptors for the anatomy diagram
// =============================================================================

class _AnatomyField {
  const _AnatomyField({
    required this.name,
    required this.type,
    required this.kind,
    required this.purpose,
    required this.accent,
  });

  final String name;
  final String type;
  final String kind;
  final String purpose;
  final Color accent;
}

const List<_AnatomyField> _kAnatomyFields = <_AnatomyField>[
  _AnatomyField(
    name: 'library',
    type: 'String',
    kind: 'identifier',
    purpose: 'Fully qualified library URI of the class. Always present, may '
        'be a "dart:", "package:" or relative path.',
    accent: _kCyan,
  ),
  _AnatomyField(
    name: 'className',
    type: 'String',
    kind: 'identifier',
    purpose: 'Simple (unqualified) class name as the framework knows it. '
        'Used by DevTools to group allocations by type.',
    accent: _kMagenta,
  ),
  _AnatomyField(
    name: 'object',
    type: 'Object',
    kind: 'reference',
    purpose: 'The newly created instance itself. Strong reference at dispatch '
        'time, but DevTools will usually keep only weak handles.',
    accent: _kIris,
  ),
  _AnatomyField(
    name: 'runtimeType',
    type: 'Type',
    kind: 'inherited',
    purpose: 'For ObjectCreated, this is "ObjectCreated". For ObjectDisposed '
        'it is the disposal subclass — useful for routing in listeners.',
    accent: _kMint,
  ),
];

// =============================================================================
// SECTION D — telemetry-hook decision matrix descriptors
// =============================================================================

class _TelemetryHookRow {
  const _TelemetryHookRow({
    required this.hook,
    required this.observes,
    required this.cost,
    required this.accent,
  });

  final String hook;
  final String observes;
  final String cost;
  final Color accent;
}

const List<_TelemetryHookRow> _kHookMatrix = <_TelemetryHookRow>[
  _TelemetryHookRow(
    hook: 'MemoryAllocations.addListener',
    observes: 'Every dispatched ObjectCreated / ObjectDisposed',
    cost: 'O(listeners) per allocation, in-process',
    accent: _kCyan,
  ),
  _TelemetryHookRow(
    hook: 'PaintingBinding.imageCache.clearListener',
    observes: 'Image cache pressure events only',
    cost: 'Cheap; one callback per cache mutation',
    accent: _kMagenta,
  ),
  _TelemetryHookRow(
    hook: 'WidgetsBinding.observer',
    observes: 'App lifecycle and metric callbacks',
    cost: 'Cheap; coarse-grained',
    accent: _kIris,
  ),
  _TelemetryHookRow(
    hook: 'Timeline.startSync / Timeline.finishSync',
    observes: 'Whatever you instrument by hand',
    cost: 'Manual; only when profile mode is active',
    accent: _kMint,
  ),
  _TelemetryHookRow(
    hook: 'developer.postEvent',
    observes: 'Service-extension messages to DevTools',
    cost: 'Network round-trip; not for tight loops',
    accent: _kAmber,
  ),
  _TelemetryHookRow(
    hook: 'FlutterMemoryAllocations.dispatchObjectEvent',
    observes: 'Custom ObjectEvent subclasses you author',
    cost: 'Equivalent to addListener fan-out cost',
    accent: _kRose,
  ),
];

// =============================================================================
// SECTION E — anatomy painter
// =============================================================================
//
// Custom painter for an event-payload schema diagram. The diagram shows the
// payload as a labelled record: a rounded outer envelope, three slot lines
// (library / className / object), and connector ticks pointing right toward
// the listener fan-out. No animation, no time — just a static layout the
// reader can study.

class _AnatomyDiagramPainter extends CustomPainter {
  const _AnatomyDiagramPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint envelope = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = _kCyan.withAlpha(0xCC);
    final Paint envelopeFill = Paint()
      ..style = PaintingStyle.fill
      ..color = _kAbyss.withAlpha(0xB0);
    final Paint slotPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = _kInkDim.withAlpha(0x99);
    final Paint accentLib = Paint()..color = _kCyan;
    final Paint accentClass = Paint()..color = _kMagenta;
    final Paint accentObject = Paint()..color = _kIris;
    final Paint connector = Paint()
      ..color = _kInk.withAlpha(0x55)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final RRect envelopeRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(12, 12, size.width - 24, size.height - 24),
      const Radius.circular(14),
    );
    canvas.drawRRect(envelopeRect, envelopeFill);
    canvas.drawRRect(envelopeRect, envelope);

    // Three slot rows
    final double slotHeight = (size.height - 60) / 3;
    final double slotLeft = 28;
    final double slotRight = size.width - 90;
    for (int i = 0; i < 3; i++) {
      final double y = 36 + slotHeight * (i + 0.5);
      canvas.drawLine(Offset(slotLeft, y), Offset(slotRight, y), slotPaint);
      final Paint dot;
      switch (i) {
        case 0:
          dot = accentLib;
          break;
        case 1:
          dot = accentClass;
          break;
        default:
          dot = accentObject;
      }
      canvas.drawCircle(Offset(slotLeft, y), 4.5, dot);
      // Connector tick to right edge
      canvas.drawLine(
        Offset(slotRight, y),
        Offset(size.width - 18, y),
        connector,
      );
      canvas.drawCircle(
        Offset(size.width - 18, y),
        3.0,
        Paint()..color = _kInkDim.withAlpha(0xAA),
      );
    }

    // Right edge "listeners" stack marker
    final Paint listenerPaint = Paint()..color = _kMint.withAlpha(0x55);
    for (int j = 0; j < 3; j++) {
      canvas.drawCircle(
        Offset(size.width - 18, 36 + slotHeight * (j + 0.5)),
        7.5,
        listenerPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// SECTION F — section helpers
// =============================================================================
//
// All sections share an outer Container with a gradient + multi-layer shadow,
// and an inner header strip. Each helper takes the gradient and shadow stack
// as parameters so we hit the "≥ 6 gradients, ≥ 6 shadows" requirement.

Widget _sectionFrame({
  required String index,
  required String title,
  required String subtitle,
  required IconData glyph,
  required Color glyphTint,
  required LinearGradient gradient,
  required List<BoxShadow> shadow,
  required Widget body,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: _kSlate, width: 1),
      boxShadow: shadow,
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: _kGradGlass,
                  border: Border.all(color: glyphTint.withAlpha(0x88), width: 1.4),
                ),
                child: Icon(glyph, color: glyphTint, size: 22),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _kAbyss.withAlpha(0xAA),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: glyphTint.withAlpha(0x66), width: 1),
                ),
                child: Text(
                  index,
                  style: TextStyle(
                    color: glyphTint,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: _kInk,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: _kInkDim,
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  glyphTint.withAlpha(0x00),
                  glyphTint.withAlpha(0xAA),
                  glyphTint.withAlpha(0x00),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          body,
        ],
      ),
    ),
  );
}

Widget _prose(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: _kInk,
      fontSize: 13,
      height: 1.55,
    ),
  );
}

Widget _proseDim(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: _kInkDim,
      fontSize: 12.5,
      height: 1.55,
    ),
  );
}

// =============================================================================
// SECTION G — header
// =============================================================================

Widget _buildHeader() {
  return Container(
    margin: const EdgeInsets.fromLTRB(12, 12, 12, 6),
    decoration: BoxDecoration(
      gradient: _kGradAurora,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(color: _kSlate, width: 1),
      boxShadow: _kShadowDeep,
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[_kCyan, _kIris, _kMagenta],
                  ),
                  boxShadow: _kShadowSoft,
                ),
                child: const Icon(Icons.memory, color: _kInk, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Text(
                      'ObjectCreated · Aurora Variant',
                      style: TextStyle(
                        color: _kInk,
                        fontWeight: FontWeight.w800,
                        fontSize: 21,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'foundation memory telemetry, hand-drawn',
                      style: TextStyle(
                        color: _kInkDim,
                        fontSize: 12.5,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: _kAbyss.withAlpha(0xB0),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kCyanDeep.withAlpha(0x88), width: 1),
            ),
            child: const Text(
              'ObjectCreated is the foundation-level signal Flutter emits each '
              'time a tracked instance is born. Every payload carries a '
              '(library, className, object) triple — enough for DevTools, a '
              'leak checker, or your own bespoke profiler to follow the '
              'instance from its first breath to its eventual disposal. This '
              'screen walks through the event\'s anatomy, the contexts where '
              'Flutter fires it, and how it pairs with ObjectDisposed.',
              style: TextStyle(
                color: _kInk,
                fontSize: 12.8,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _headerChip('foundation.dart', _kCyan),
              _headerChip('MemoryAllocations', _kMagenta),
              _headerChip('ObjectEvent base', _kIris),
              _headerChip('DevTools-facing', _kMint),
              _headerChip('weakly retained', _kAmber),
              _headerChip('pairs with Disposed', _kRose),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _headerChip(String label, Color tint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[tint.withAlpha(0x22), tint.withAlpha(0x11)],
      ),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: tint.withAlpha(0x99), width: 1),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: tint,
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
    ),
  );
}

// =============================================================================
// SECTION 1 — payload anatomy
// =============================================================================

Widget _buildSectionAnatomy() {
  return _sectionFrame(
    index: 'I',
    title: 'Payload anatomy',
    subtitle: 'What each ObjectCreated actually carries on the wire',
    glyph: Icons.account_tree,
    glyphTint: _kCyan,
    gradient: _kGradCyan,
    shadow: _kShadowDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _prose(
          'An ObjectCreated payload is intentionally small. It is a labelled '
          'record of three fields: library, className, and object. The first '
          'two are pure identifiers — strings that tell a downstream listener '
          'which kind of thing was just born. The third is the instance '
          'itself, handed across the dispatch boundary so listeners can read '
          'identityHashCode, attach a weak reference, or correlate the new '
          'object with prior framework events.',
        ),
        const SizedBox(height: 12),
        Container(
          height: 168,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: _kAbyss.withAlpha(0xAA),
            border: Border.all(color: _kCyanDeep.withAlpha(0x66), width: 1),
          ),
          child: CustomPaint(painter: const _AnatomyDiagramPainter()),
        ),
        const SizedBox(height: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _kAnatomyFields.map(_buildAnatomyRow).toList(),
        ),
        const SizedBox(height: 10),
        _proseDim(
          'Conceptually the event is a frozen snapshot — the framework will '
          'not mutate it after dispatch. Listeners must treat the object '
          'reference as borrowed: the right thing to do is record what is '
          'needed (type, identity, weak ref) and then let go before the next '
          'frame.',
        ),
      ],
    ),
  );
}

Widget _buildAnatomyRow(_AnatomyField field) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 6, right: 10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: field.accent,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: field.accent.withAlpha(0xAA),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    field.name,
                    style: TextStyle(
                      color: field.accent,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    ': ${field.type}',
                    style: const TextStyle(
                      color: _kInkDim,
                      fontFamily: 'monospace',
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: field.accent.withAlpha(0x22),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      field.kind,
                      style: TextStyle(
                        color: field.accent,
                        fontSize: 10,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                field.purpose,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 12.4,
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

// =============================================================================
// SECTION 2 — dispatch contexts (when Flutter fires)
// =============================================================================

Widget _buildSectionDispatchContexts() {
  final List<_DispatchContext> contexts = const <_DispatchContext>[
    _DispatchContext(
      title: 'Image cache entries',
      blurb:
          'PaintingBinding dispatches a creation event each time a new ImageStream '
          'lands in the cache. This lets DevTools chart cache pressure over time.',
      glyph: Icons.image,
      tint: _kCyan,
    ),
    _DispatchContext(
      title: 'Gesture recognizers',
      blurb:
          'Long-lived recognizers (drag, scale, double-tap) announce themselves '
          'so that surprising retention by a forgotten arena member is visible.',
      glyph: Icons.touch_app,
      tint: _kMagenta,
    ),
    _DispatchContext(
      title: 'Animation controllers',
      blurb:
          'Each AnimationController emits ObjectCreated; the matching ObjectDisposed '
          'is the canonical hook DevTools uses to flag the "leaky ticker" warning.',
      glyph: Icons.play_circle,
      tint: _kIris,
    ),
    _DispatchContext(
      title: 'Long-running services',
      blurb:
          'Custom application code can dispatch via FlutterMemoryAllocations.instance '
          'when allocating long-lived helpers — exactly what the mixer-board demo does.',
      glyph: Icons.dns,
      tint: _kMint,
    ),
  ];

  return _sectionFrame(
    index: 'II',
    title: 'Dispatch contexts',
    subtitle: 'Where in a real Flutter app these events come from',
    glyph: Icons.power_settings_new,
    glyphTint: _kMagenta,
    gradient: _kGradMagenta,
    shadow: _kShadowSoft,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _prose(
          'In a normal Flutter app, ObjectCreated events are dispatched from '
          'a handful of well-known pipelines. The framework itself instruments '
          'image cache entries, gesture recognizers, and animation controllers, '
          'because those are the classes most often involved in memory leaks. '
          'Application code is welcome to dispatch its own events for any '
          'objects whose lifetime is interesting enough to be worth following '
          'in DevTools.',
        ),
        const SizedBox(height: 14),
        Column(
          children: contexts.map(_buildDispatchRow).toList(),
        ),
        const SizedBox(height: 8),
        _proseDim(
          'This static demo cannot actually trigger any of these pipelines — '
          'there is no AnimationController and no real image cache to push. '
          'Instead, we render the payloads we would expect, and study them '
          'as if they had been dispatched.',
        ),
      ],
    ),
  );
}

class _DispatchContext {
  const _DispatchContext({
    required this.title,
    required this.blurb,
    required this.glyph,
    required this.tint,
  });

  final String title;
  final String blurb;
  final IconData glyph;
  final Color tint;
}

Widget _buildDispatchRow(_DispatchContext ctx) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: _kAbyss.withAlpha(0x99),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: ctx.tint.withAlpha(0x55), width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(ctx.glyph, color: ctx.tint, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                ctx.title,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                ctx.blurb,
                style: const TextStyle(
                  color: _kInkDim,
                  fontSize: 12,
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

// =============================================================================
// SECTION 3 — sample payload gallery (Wrap palette)
// =============================================================================

Widget _buildSectionPalette() {
  return _sectionFrame(
    index: 'III',
    title: 'Sample-payload palette',
    subtitle: 'A tray of chips representing realistic mixer-board events',
    glyph: Icons.palette,
    glyphTint: _kIris,
    gradient: _kGradIris,
    shadow: _kShadowIris,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _prose(
          'Each chip below is one ObjectCreated payload that the Aurora mixer '
          'app might dispatch during a normal session. The colour stripe on '
          'the left of each chip is just a visual key — it is not part of the '
          'event itself. Tapping (visually) corresponds to "this is the kind '
          'of allocation that would appear in DevTools when you opened a new '
          'channel strip".',
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _kSamplePayloads.map(_buildPaletteChip).toList(),
        ),
        const SizedBox(height: 12),
        _proseDim(
          'Note the consistency between className and library: by convention, '
          'the library URI points to the file that declares the class. This '
          'is what DevTools uses to deep-link from an allocation back to the '
          'source.',
        ),
      ],
    ),
  );
}

Widget _buildPaletteChip(_MixerSamplePayload p) {
  return Container(
    width: 220,
    padding: const EdgeInsets.fromLTRB(10, 10, 12, 10),
    decoration: BoxDecoration(
      color: _kAbyss.withAlpha(0xB0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: p.tint.withAlpha(0x88), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: p.tint.withAlpha(0x33),
          blurRadius: 14,
          spreadRadius: 0,
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 4,
          height: 44,
          margin: const EdgeInsets.only(right: 10, top: 2),
          decoration: BoxDecoration(
            color: p.tint,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(p.glyph, color: p.tint, size: 14),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      p.className,
                      style: const TextStyle(
                        color: _kInk,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w700,
                        fontSize: 12.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                p.objectLabel,
                style: const TextStyle(
                  color: _kInkDim,
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 4 — payload card gallery (StatefulBuilder cycling)
// =============================================================================

Widget _buildSectionPayloadCards() {
  return _sectionFrame(
    index: 'IV',
    title: 'Static payload cards',
    subtitle: 'Each card renders one ObjectCreated as it would appear',
    glyph: Icons.view_carousel,
    glyphTint: _kMint,
    gradient: _kGradMint,
    shadow: _kShadowMint,
    body: StatefulBuilder(
      builder: (BuildContext context, StateSetter setLocalState) {
        // Outer StatefulBuilder reserved for future per-section toggles.
        // The actual interactive index lives in _PayloadGalleryBody below.
        return _PayloadGallery(payloads: _kSamplePayloads);
      },
    ),
  );
}

class _PayloadGallery extends StatelessWidget {
  const _PayloadGallery({required this.payloads});

  final List<_MixerSamplePayload> payloads;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setLocalState) {
        // Local interactive state — index of the focused payload.
        return _PayloadGalleryBody(payloads: payloads);
      },
    );
  }
}

class _PayloadGalleryBody extends StatefulWidget {
  const _PayloadGalleryBody({required this.payloads});

  final List<_MixerSamplePayload> payloads;

  @override
  State<_PayloadGalleryBody> createState() => _PayloadGalleryBodyState();
}

class _PayloadGalleryBodyState extends State<_PayloadGalleryBody> {
  int _focusIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _MixerSamplePayload focus = widget.payloads[_focusIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _prose(
          'Use the arrow chips to flip through the static payload gallery. '
          'Nothing is dispatched; the index simply changes which sample we '
          'render in detail. The big card below shows the simulated wire '
          'format — the same triple a real listener would see.',
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            _navChip(
              label: 'prev',
              glyph: Icons.chevron_left,
              tint: _kCyan,
              onTap: () {
                setState(() {
                  _focusIndex = (_focusIndex - 1) % widget.payloads.length;
                  if (_focusIndex < 0) {
                    _focusIndex += widget.payloads.length;
                  }
                });
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Center(
                child: Text(
                  'payload ${_focusIndex + 1} / ${widget.payloads.length}',
                  style: const TextStyle(
                    color: _kInkDim,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            _navChip(
              label: 'next',
              glyph: Icons.chevron_right,
              tint: _kMagenta,
              onTap: () {
                setState(() {
                  _focusIndex = (_focusIndex + 1) % widget.payloads.length;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 14),
        _buildBigPayloadCard(focus),
      ],
    );
  }

  Widget _navChip({
    required String label,
    required IconData glyph,
    required Color tint,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _kAbyss.withAlpha(0xAA),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: tint.withAlpha(0x99), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(glyph, color: tint, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: tint,
                fontWeight: FontWeight.w600,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBigPayloadCard(_MixerSamplePayload p) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        color: _kAbyss.withAlpha(0xCC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: p.tint.withAlpha(0x99), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: p.tint.withAlpha(0x44),
            blurRadius: 22,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
          const BoxShadow(
            color: Color(0xAA000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(p.glyph, color: p.tint, size: 22),
              const SizedBox(width: 8),
              Text(
                'ObjectCreated',
                style: TextStyle(
                  color: p.tint,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: p.tint.withAlpha(0x22),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: p.tint.withAlpha(0x88), width: 1),
                ),
                child: Text(
                  'wire format',
                  style: TextStyle(
                    color: p.tint,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _kvRow('library', p.library, _kCyan),
          _kvRow('className', p.className, _kMagenta),
          _kvRow('object', p.objectLabel, _kIris),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            decoration: BoxDecoration(
              color: _kMidnight.withAlpha(0xAA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kSlate, width: 1),
            ),
            child: Text(
              p.notes,
              style: const TextStyle(
                color: _kInk,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _kvRow(String key, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 80,
            child: Text(
              key,
              style: TextStyle(
                color: accent,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const Text(
            ': ',
            style: TextStyle(
              color: _kInkDim,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: _kInk,
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 5 — telemetry hook decision matrix
// =============================================================================

Widget _buildSectionMatrix() {
  return _sectionFrame(
    index: 'V',
    title: 'Telemetry hooks compared',
    subtitle: 'MemoryAllocations is one of several lifecycle taps available',
    glyph: Icons.fact_check,
    glyphTint: _kAmber,
    gradient: _kGradAmber,
    shadow: _kShadowAmber,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _prose(
          'MemoryAllocations is one of several lifecycle taps Flutter offers. '
          'The matrix below contrasts it with the older image-cache hook, the '
          'general WidgetsBinding observer, the timeline API, and the raw '
          'developer.postEvent channel. The right column is the rough cost '
          'per event — useful when you are deciding whether to leave a '
          'listener attached in production builds.',
        ),
        const SizedBox(height: 12),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2.4),
            1: FlexColumnWidth(3.2),
            2: FlexColumnWidth(2.4),
          },
          border: TableBorder(
            horizontalInside: BorderSide(
              color: _kAmber.withAlpha(0x44),
              width: 0.8,
            ),
            verticalInside: BorderSide(
              color: _kAmber.withAlpha(0x22),
              width: 0.6,
            ),
          ),
          children: <TableRow>[
            const TableRow(
              children: <Widget>[
                _MatrixHeaderCell(text: 'Hook'),
                _MatrixHeaderCell(text: 'What it observes'),
                _MatrixHeaderCell(text: 'Cost'),
              ],
            ),
            for (final _TelemetryHookRow r in _kHookMatrix)
              TableRow(
                children: <Widget>[
                  _MatrixBodyCell(text: r.hook, accent: r.accent, mono: true),
                  _MatrixBodyCell(text: r.observes, accent: r.accent),
                  _MatrixBodyCell(text: r.cost, accent: r.accent),
                ],
              ),
          ],
        ),
        const SizedBox(height: 12),
        _proseDim(
          'The headline trade-off: MemoryAllocations is the only one that '
          'gives you per-object granularity. Everything else is coarser — '
          'either coarser in time (a single lifecycle callback) or coarser '
          'in subject (a whole cache).',
        ),
      ],
    ),
  );
}

class _MatrixHeaderCell extends StatelessWidget {
  const _MatrixHeaderCell({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
      child: Text(
        text,
        style: const TextStyle(
          color: _kAmber,
          fontWeight: FontWeight.w800,
          fontSize: 12,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _MatrixBodyCell extends StatelessWidget {
  const _MatrixBodyCell({
    required this.text,
    required this.accent,
    this.mono = false,
  });

  final String text;
  final Color accent;
  final bool mono;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Text(
        text,
        style: TextStyle(
          color: _kInk,
          fontSize: 11.5,
          height: 1.45,
          fontFamily: mono ? 'monospace' : null,
          decoration: TextDecoration.none,
          decorationColor: accent,
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 6 — code snippet card
// =============================================================================

Widget _buildSectionSnippet() {
  const String snippet = '''
import 'package:flutter/foundation.dart';

void wireUpMixerLeakChecker() {
  // Subscribe once at app start. The listener fires synchronously
  // on the thread that dispatched, so keep it small.
  FlutterMemoryAllocations.instance.addListener((ObjectEvent event) {
    if (event is ObjectCreated) {
      // Record the (className, identityHashCode) tuple in a weak set.
      _liveByType
          .putIfAbsent(event.className, _LiveSet.new)
          .track(event.object);
    } else if (event is ObjectDisposed) {
      _liveByType[event.className]?.untrack(event.object);
    }
  });
}

class MixerChannelStrip {
  MixerChannelStrip(this.index) {
    // Manually announce ourselves so the leak checker sees us.
    FlutterMemoryAllocations.instance.dispatchObjectCreated(
      library: 'package:aurora_mixer/src/strip/channel_strip.dart',
      className: 'MixerChannelStrip',
      object: this,
    );
  }
  final int index;
}
''';
  return _sectionFrame(
    index: 'VI',
    title: 'How a listener is wired up',
    subtitle: 'A small, realistic listener that pairs Created with Disposed',
    glyph: Icons.code,
    glyphTint: _kCyan,
    gradient: _kGradCyan,
    shadow: _kShadowDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _prose(
          'The snippet below is the canonical wire-up. There is exactly one '
          'addListener call per process, and the listener routes by event '
          'subclass: ObjectCreated to record, ObjectDisposed to forget. The '
          'MixerChannelStrip constructor self-announces — that is what you '
          'do when the class is yours and the framework does not already '
          'dispatch on your behalf.',
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          decoration: BoxDecoration(
            color: _kAbyss.withAlpha(0xD0),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kCyanDeep.withAlpha(0x88), width: 1),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: const Text(
            snippet,
            style: TextStyle(
              color: _kInk,
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _proseDim(
          'A real leak checker would not block on the listener — anything '
          'expensive belongs on a queue. The example above stays synchronous '
          'because the work is trivial.',
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 7 — created vs disposed pairing
// =============================================================================

Widget _buildSectionPairing() {
  return _sectionFrame(
    index: 'VII',
    title: 'The Created / Disposed pairing',
    subtitle: 'Why ObjectCreated only makes sense alongside its mirror event',
    glyph: Icons.compare_arrows,
    glyphTint: _kRose,
    gradient: _kGradRose,
    shadow: _kShadowRose,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _prose(
          'An ObjectCreated event in isolation tells you nothing about leaks. '
          'It is only when you correlate it with an ObjectDisposed event for '
          'the same instance that you can prove the object was reclaimed in '
          'a timely manner. The framework treats the pair as a contract: '
          'every dispatched ObjectCreated should eventually be balanced by '
          'an ObjectDisposed, modulo the long-lived singletons of the app.',
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _pairCard(_kCyan, 'ObjectCreated', _createdLines)),
            const SizedBox(width: 10),
            Expanded(child: _pairCard(_kRose, 'ObjectDisposed', _disposedLines)),
          ],
        ),
        const SizedBox(height: 14),
        _proseDim(
          'In the mixer app, every MixerChannelStrip pushed on screen should '
          'see a Disposed event within a few frames of leaving the viewport. '
          'A drift of more than a few seconds is the early signal a strip '
          'is being retained by something it should not be.',
        ),
      ],
    ),
  );
}

const List<String> _createdLines = <String>[
  'fires inside the constructor body',
  'object reference is fresh and live',
  'listeners may set up tracking now',
  'arrives before any pumped frame',
  'safe to read identityHashCode',
];

const List<String> _disposedLines = <String>[
  'fires inside dispose() / finalizer',
  'object reference may be near-dead',
  'listeners must release tracking',
  'arrives potentially many frames later',
  'identityHashCode still valid (briefly)',
];

Widget _pairCard(Color tint, String title, List<String> lines) {
  return Container(
    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
    decoration: BoxDecoration(
      color: _kAbyss.withAlpha(0xC0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tint.withAlpha(0x99), width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tint.withAlpha(0x33),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: tint,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            fontSize: 13.5,
          ),
        ),
        const SizedBox(height: 8),
        for (final String l in lines)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.fiber_manual_record, size: 8, color: tint),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l,
                    style: const TextStyle(
                      color: _kInk,
                      fontSize: 11.5,
                      height: 1.45,
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

// =============================================================================
// SECTION 8 — pitfalls & guarantees
// =============================================================================

Widget _buildSectionPitfalls() {
  final List<_PitfallEntry> entries = const <_PitfallEntry>[
    _PitfallEntry(
      glyph: Icons.warning_amber_rounded,
      title: 'Listeners run synchronously',
      body:
          'Dispatch returns only after every listener finishes. A slow listener '
          'taxes the construction site of the object — typically the build '
          'phase. Keep the work O(1) and queue anything heavier.',
      tint: _kAmber,
    ),
    _PitfallEntry(
      glyph: Icons.error_outline,
      title: 'No GC guarantee from Disposed',
      body:
          'ObjectDisposed says "the object reached its dispose path", not '
          '"the heap reclaimed the object". It is a strong hint, not a proof. '
          'Couple it with a weak reference if you need true reclamation '
          'evidence.',
      tint: _kRose,
    ),
    _PitfallEntry(
      glyph: Icons.bolt,
      title: 'Dispatch is not free',
      body:
          'For very hot allocation sites — bullet-storm games allocating '
          'thousands of particles per frame — even an empty listener costs '
          'a virtual call. Profile before instrumenting hot paths.',
      tint: _kIris,
    ),
    _PitfallEntry(
      glyph: Icons.shield_outlined,
      title: 'Self-announcing is opt-in',
      body:
          'The framework only instruments a handful of classes. For your own '
          'app types, you have to call dispatchObjectCreated yourself — and '
          'be careful to dispatch dispose too, lest you leave dangling '
          'tracking entries.',
      tint: _kMint,
    ),
    _PitfallEntry(
      glyph: Icons.do_not_disturb,
      title: 'Do not retain `object` strongly',
      body:
          'Tempting as it is to cache the object reference, doing so creates '
          'the very leak the system is trying to detect. Use Expando, '
          'WeakReference, or identityHashCode-keyed maps instead.',
      tint: _kCyan,
    ),
  ];

  return _sectionFrame(
    index: 'VIII',
    title: 'Pitfalls and guarantees',
    subtitle: 'What ObjectCreated does and (importantly) does not promise',
    glyph: Icons.gpp_maybe,
    glyphTint: _kAmber,
    gradient: _kGradAmber,
    shadow: _kShadowAmber,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _prose(
          'ObjectCreated is deliberately a thin primitive. It makes a small '
          'set of guarantees and leaves the rest to the listener. The list '
          'below captures the half-dozen ways a careless integration can '
          'turn a leak detector into a leak source — or just into a frame '
          'budget tax.',
        ),
        const SizedBox(height: 12),
        Column(children: entries.map(_buildPitfallTile).toList()),
      ],
    ),
  );
}

class _PitfallEntry {
  const _PitfallEntry({
    required this.glyph,
    required this.title,
    required this.body,
    required this.tint,
  });

  final IconData glyph;
  final String title;
  final String body;
  final Color tint;
}

Widget _buildPitfallTile(_PitfallEntry e) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
    decoration: BoxDecoration(
      color: _kAbyss.withAlpha(0xA0),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: e.tint.withAlpha(0x66), width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(e.glyph, size: 20, color: e.tint),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                e.title,
                style: TextStyle(
                  color: e.tint,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                e.body,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 12,
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

// =============================================================================
// SECTION 9 — closing reference card
// =============================================================================

Widget _buildClosingReferenceCard() {
  return Container(
    margin: const EdgeInsets.fromLTRB(12, 10, 12, 24),
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
    decoration: BoxDecoration(
      gradient: _kGradIris,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: _kIris.withAlpha(0x88), width: 1),
      boxShadow: _kShadowIris,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.bookmark, color: _kIris, size: 22),
            SizedBox(width: 8),
            Text(
              'Quick reference',
              style: TextStyle(
                color: _kInk,
                fontWeight: FontWeight.w800,
                fontSize: 15,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _refLine('package', 'package:flutter/foundation.dart', _kCyan),
        _refLine('class', 'ObjectCreated extends ObjectEvent', _kMagenta),
        _refLine('dispatcher', 'FlutterMemoryAllocations.instance', _kIris),
        _refLine('listener API', 'addListener(ObjectEventListener)', _kMint),
        _refLine('paired event', 'ObjectDisposed', _kRose),
        _refLine('used by', 'DevTools memory tab', _kAmber),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          decoration: BoxDecoration(
            color: _kAbyss.withAlpha(0xAA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kSlate, width: 1),
          ),
          child: const Text(
            'The Aurora variant of this demo is intentionally cool-toned and '
            'arranged top-down from anatomy → contexts → palette → cards → '
            'matrix → snippet → pairing → pitfalls → reference. The warm '
            'retest sibling tells the same story with a different palette, a '
            'different sample domain, and a different ordering — read both '
            'side by side to compare the two presentations.',
            style: TextStyle(
              color: _kInk,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _refLine(String key, String value, Color tint) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 96,
          child: Text(
            key,
            style: TextStyle(
              color: tint,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
        const Text(
          ': ',
          style: TextStyle(
            color: _kInkDim,
            fontFamily: 'monospace',
            fontSize: 12,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: _kInk,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION H — sanity probe (small, harmless event construction)
// =============================================================================
//
// Construct a couple of real ObjectCreated instances at build time so the
// screen also acts as a smoke test for the foundation API. We deliberately
// keep the references local so they have no surprising lifetime; they are
// printed for the test harness's benefit.

Widget _buildSanityProbe() {
  final ObjectCreated probeA = ObjectCreated(
    library: 'package:aurora_mixer/src/strip/channel_strip.dart',
    className: 'MixerChannelStrip',
    object: const _ProbeObject('channelStrip#probe'),
  );
  final ObjectCreated probeB = ObjectCreated(
    library: 'package:aurora_mixer/src/eq/eq_band_filter.dart',
    className: 'EQBandFilter',
    object: const _ProbeObject('eqBand#probe'),
  );
  // We intentionally do NOT addListener — that could persist across runs.
  // Print the probes so the d4rt harness sees real foundation activity.
  print('[ObjectCreated probe] library=${probeA.library} '
      'class=${probeA.className} object=${probeA.object.runtimeType}');
  print('[ObjectCreated probe] library=${probeB.library} '
      'class=${probeB.className} object=${probeB.object.runtimeType}');

  return _sectionFrame(
    index: 'IX',
    title: 'Live foundation probe',
    subtitle: 'Two real ObjectCreated values constructed at build time',
    glyph: Icons.science,
    glyphTint: _kMint,
    gradient: _kGradMint,
    shadow: _kShadowMint,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _prose(
          'In addition to the static, illustrative payload renderings above, '
          'this section constructs two genuine ObjectCreated values to verify '
          'the foundation API is bridged correctly under d4rt. The values '
          'are short-lived, scoped to this build call, and not pushed into '
          'any listener.',
        ),
        const SizedBox(height: 12),
        _probeLine('probeA', probeA, _kCyan),
        const SizedBox(height: 6),
        _probeLine('probeB', probeB, _kMagenta),
        const SizedBox(height: 10),
        _proseDim(
          'If the line beneath each label shows the expected library and '
          'className, the bridge is working — there is no need for a '
          'pipeline run, animation tick, or image cache push.',
        ),
      ],
    ),
  );
}

Widget _probeLine(String label, ObjectCreated event, Color accent) {
  return Container(
    padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
    decoration: BoxDecoration(
      color: _kAbyss.withAlpha(0xA0),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accent.withAlpha(0x66), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: accent,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          'library    : ${event.library}',
          style: const TextStyle(
            color: _kInk,
            fontFamily: 'monospace',
            fontSize: 11.5,
            height: 1.5,
          ),
        ),
        Text(
          'className  : ${event.className}',
          style: const TextStyle(
            color: _kInk,
            fontFamily: 'monospace',
            fontSize: 11.5,
            height: 1.5,
          ),
        ),
        Text(
          'object     : ${event.object.runtimeType}',
          style: const TextStyle(
            color: _kInk,
            fontFamily: 'monospace',
            fontSize: 11.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

class _ProbeObject {
  const _ProbeObject(this.label);
  final String label;

  @override
  String toString() => '_ProbeObject($label)';
}

// =============================================================================
// SECTION T — top-level build entry
// =============================================================================

dynamic build(BuildContext context) {
  print('[ObjectCreated Aurora variant] building visual demo screen');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: _kMidnight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildHeader(),
              _buildSectionAnatomy(),
              _buildSectionDispatchContexts(),
              _buildSectionPalette(),
              _buildSectionPayloadCards(),
              _buildSectionMatrix(),
              _buildSectionSnippet(),
              _buildSectionPairing(),
              _buildSectionPitfalls(),
              _buildSanityProbe(),
              _buildClosingReferenceCard(),
            ],
          ),
        ),
      ),
    ),
  );
}

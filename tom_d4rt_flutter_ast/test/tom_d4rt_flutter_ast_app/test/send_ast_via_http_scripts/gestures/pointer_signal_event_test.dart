// D4rt deep-demo Flutter test script: PointerSignalEvent class hierarchy.
//
// PointerSignalEvent is the abstract base class for "signal" events that
// originate from a pointer device but do not participate in the standard
// down/move/up positional flow. They are dispatched outside of the gesture
// arena, via the PointerSignalResolver, because there is no contention to
// resolve in the classic sense — a scroll wheel notch is what it is.
//
// Concrete subclasses:
//   * PointerScrollEvent              — wheel / trackpad scroll
//   * PointerScrollInertiaCancelEvent — finger placed on trackpad mid-fling
//   * PointerScaleEvent               — trackpad pinch-to-zoom
//
// This file is a single-screen, scrollable, hand-authored visual reference
// that demonstrates each of the above with construction samples, vector
// renderings, and prose explanations.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// =============================================================================
// Top-level value classes (no leading underscores on locals; classes themselves
// are private to this file).
// =============================================================================

class _Palette {
  const _Palette({
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.onSurface,
    required this.accent,
  });

  final Color primary;
  final Color secondary;
  final Color surface;
  final Color onSurface;
  final Color accent;
}

class _FieldSpec {
  const _FieldSpec({
    required this.name,
    required this.type,
    required this.sample,
    required this.explanation,
    required this.icon,
  });

  final String name;
  final String type;
  final String sample;
  final String explanation;
  final IconData icon;
}

class _ScrollPanelSpec {
  const _ScrollPanelSpec({
    required this.label,
    required this.delta,
    required this.note,
    required this.tone,
  });

  final String label;
  final Offset delta;
  final String note;
  final Color tone;
}

class _ScalePanelSpec {
  const _ScalePanelSpec({
    required this.factor,
    required this.label,
    required this.tone,
  });

  final double factor;
  final String label;
  final Color tone;
}

class _SubclassSpec {
  const _SubclassSpec({
    required this.name,
    required this.summary,
    required this.icon,
    required this.tone,
  });

  final String name;
  final String summary;
  final IconData icon;
  final Color tone;
}

class _Bullet {
  const _Bullet({required this.title, required this.body, required this.icon});

  final String title;
  final String body;
  final IconData icon;
}

// =============================================================================
// Palette presets (one per major section, varying tone).
// =============================================================================

const _Palette _heroPalette = _Palette(
  primary: Color(0xFF1A237E),
  secondary: Color(0xFF3949AB),
  surface: Color(0xFFE8EAF6),
  onSurface: Color(0xFF1A237E),
  accent: Color(0xFFFFC107),
);

const _Palette _hierarchyPalette = _Palette(
  primary: Color(0xFF004D40),
  secondary: Color(0xFF00897B),
  surface: Color(0xFFE0F2F1),
  onSurface: Color(0xFF004D40),
  accent: Color(0xFFFFA000),
);

const _Palette _fieldsPalette = _Palette(
  primary: Color(0xFF4A148C),
  secondary: Color(0xFF7B1FA2),
  surface: Color(0xFFF3E5F5),
  onSurface: Color(0xFF4A148C),
  accent: Color(0xFFE91E63),
);

const _Palette _scrollPalette = _Palette(
  primary: Color(0xFFB71C1C),
  secondary: Color(0xFFE53935),
  surface: Color(0xFFFFEBEE),
  onSurface: Color(0xFFB71C1C),
  accent: Color(0xFF1976D2),
);

const _Palette _inertiaPalette = _Palette(
  primary: Color(0xFFE65100),
  secondary: Color(0xFFFB8C00),
  surface: Color(0xFFFFF3E0),
  onSurface: Color(0xFFE65100),
  accent: Color(0xFF6A1B9A),
);

const _Palette _scalePalette = _Palette(
  primary: Color(0xFF0D47A1),
  secondary: Color(0xFF1976D2),
  surface: Color(0xFFE3F2FD),
  onSurface: Color(0xFF0D47A1),
  accent: Color(0xFFD81B60),
);

const _Palette _routingPalette = _Palette(
  primary: Color(0xFF263238),
  secondary: Color(0xFF455A64),
  surface: Color(0xFFECEFF1),
  onSurface: Color(0xFF263238),
  accent: Color(0xFFFF6F00),
);

const _Palette _summaryPalette = _Palette(
  primary: Color(0xFF1B5E20),
  secondary: Color(0xFF388E3C),
  surface: Color(0xFFE8F5E9),
  onSurface: Color(0xFF1B5E20),
  accent: Color(0xFFFFB300),
);

const _Palette _comparePalette = _Palette(
  primary: Color(0xFF311B92),
  secondary: Color(0xFF512DA8),
  surface: Color(0xFFEDE7F6),
  onSurface: Color(0xFF311B92),
  accent: Color(0xFF00BFA5),
);

const _Palette _caveatsPalette = _Palette(
  primary: Color(0xFF880E4F),
  secondary: Color(0xFFC2185B),
  surface: Color(0xFFFCE4EC),
  onSurface: Color(0xFF880E4F),
  accent: Color(0xFF00838F),
);

const _Palette _footerPalette = _Palette(
  primary: Color(0xFF212121),
  secondary: Color(0xFF424242),
  surface: Color(0xFFF5F5F5),
  onSurface: Color(0xFF212121),
  accent: Color(0xFF1565C0),
);

// =============================================================================
// Build entry point.
// =============================================================================

dynamic build(BuildContext context) {
  // Construct the three concrete events once. These are pulled into multiple
  // sections below to demonstrate that they are real, live values.
  const PointerScrollEvent scrollEvent = PointerScrollEvent(
    timeStamp: Duration(milliseconds: 1200),
    device: 1,
    position: Offset(120, 80),
    scrollDelta: Offset(0, -120),
  );

  const PointerScrollInertiaCancelEvent inertiaCancelEvent =
      PointerScrollInertiaCancelEvent(
    timeStamp: Duration(milliseconds: 1300),
    device: 1,
    position: Offset(120, 80),
  );

  const PointerScaleEvent scaleEvent = PointerScaleEvent(
    timeStamp: Duration(milliseconds: 1400),
    device: 1,
    position: Offset(120, 80),
    scale: 1.25,
  );

  return Scaffold(
    backgroundColor: const Color(0xFFFAFAFA),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHero(),
          const SizedBox(height: 32),
          _buildHierarchyDiagram(),
          const SizedBox(height: 32),
          _buildCommonFieldsGrid(),
          const SizedBox(height: 32),
          _buildScrollDeepDive(scrollEvent),
          const SizedBox(height: 32),
          _buildInertiaCancelDeepDive(inertiaCancelEvent),
          const SizedBox(height: 32),
          _buildScaleDeepDive(scaleEvent),
          const SizedBox(height: 32),
          _buildRoutingPanel(),
          const SizedBox(height: 32),
          _buildConstructionSummary(scrollEvent, inertiaCancelEvent, scaleEvent),
          const SizedBox(height: 32),
          _buildComparisonPanel(),
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
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      boxShadow: [
        BoxShadow(
          color: palette.primary.withValues(alpha: 0.45),
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ],
    ),
    child: Stack(
      children: [
        Positioned(
          right: -20,
          top: -20,
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: palette.accent.withValues(alpha: 0.18),
            ),
          ),
        ),
        Positioned(
          right: 40,
          bottom: -40,
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: palette.accent.withValues(alpha: 0.95),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(999)),
                  ),
                  child: const Text(
                    'flutter/gestures.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(999)),
                  ),
                  child: const Text(
                    'abstract base class',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'PointerSignalEvent',
              style: TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Non-positional pointer signals — scroll, scale, inertia cancel.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _heroChip('PointerScrollEvent'),
                _heroChip('PointerScrollInertiaCancelEvent'),
                _heroChip('PointerScaleEvent'),
                _heroChip('PointerSignalResolver'),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
      borderRadius: const BorderRadius.all(Radius.circular(999)),
      color: Colors.white.withValues(alpha: 0.08),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'monospace',
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// =============================================================================
// Section 2: Class hierarchy diagram.
// =============================================================================

Widget _buildHierarchyDiagram() {
  const _Palette palette = _hierarchyPalette;
  const List<_SubclassSpec> subclasses = <_SubclassSpec>[
    _SubclassSpec(
      name: 'PointerScrollEvent',
      summary: 'Wheel / trackpad scroll, pixels via scrollDelta.',
      icon: Icons.swap_vert,
      tone: Color(0xFF00796B),
    ),
    _SubclassSpec(
      name: 'PointerScrollInertiaCancelEvent',
      summary: 'Finger placed on trackpad mid-inertia; halts momentum.',
      icon: Icons.pan_tool,
      tone: Color(0xFFD84315),
    ),
    _SubclassSpec(
      name: 'PointerScaleEvent',
      summary: 'Trackpad pinch-to-zoom; scale is a multiplicative factor.',
      icon: Icons.zoom_in,
      tone: Color(0xFF6A1B9A),
    ),
  ];

  return _section(
    palette: palette,
    icon: Icons.account_tree_outlined,
    title: 'Class hierarchy',
    subtitle:
        'PointerEvent → PointerSignalEvent → {Scroll, ScrollInertiaCancel, Scale}',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _hierarchyNode(
          label: 'PointerEvent',
          tag: 'abstract',
          color: palette.primary,
          width: double.infinity,
        ),
        const SizedBox(height: 8),
        const Center(
          child: Icon(Icons.south, size: 22, color: Color(0xFF004D40)),
        ),
        const SizedBox(height: 8),
        _hierarchyNode(
          label: 'PointerSignalEvent',
          tag: 'abstract',
          color: palette.secondary,
          width: double.infinity,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(Icons.south_west, size: 22, color: Color(0xFF004D40)),
            Icon(Icons.south, size: 22, color: Color(0xFF004D40)),
            Icon(Icons.south_east, size: 22, color: Color(0xFF004D40)),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.spaceEvenly,
          children: <Widget>[
            for (final _SubclassSpec spec in subclasses)
              _subclassCard(spec: spec),
          ],
        ),
      ],
    ),
  );
}

Widget _hierarchyNode({
  required String label,
  required String tag,
  required Color color,
  required double width,
}) {
  return Container(
    width: width,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        const Icon(Icons.class_, color: Colors.white, size: 18),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'monospace',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: const BorderRadius.all(Radius.circular(999)),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _subclassCard({required _SubclassSpec spec}) {
  return Container(
    width: 220,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: spec.tone.withValues(alpha: 0.4), width: 1.4),
      boxShadow: [
        BoxShadow(
          color: spec.tone.withValues(alpha: 0.18),
          blurRadius: 10,
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
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: spec.tone.withValues(alpha: 0.15),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Icon(spec.icon, size: 18, color: spec.tone),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, size: 14, color: Color(0xFF607D8B)),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          spec.name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: spec.tone,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          spec.summary,
          style: const TextStyle(
            fontSize: 12,
            height: 1.35,
            color: Color(0xFF37474F),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 3: Common fields grid.
// =============================================================================

Widget _buildCommonFieldsGrid() {
  const _Palette palette = _fieldsPalette;
  const List<_FieldSpec> fields = <_FieldSpec>[
    _FieldSpec(
      name: 'timeStamp',
      type: 'Duration',
      sample: 'Duration(milliseconds: 1200)',
      explanation:
          'Time since engine start. Used to order events and compute deltas.',
      icon: Icons.schedule,
    ),
    _FieldSpec(
      name: 'pointer',
      type: 'int',
      sample: '0 (default)',
      explanation:
          'Engine-assigned id, unique across active pointers in a session.',
      icon: Icons.tag,
    ),
    _FieldSpec(
      name: 'device',
      type: 'int',
      sample: '1',
      explanation:
          'Identifies the physical device. Stable across the device lifetime.',
      icon: Icons.devices_other,
    ),
    _FieldSpec(
      name: 'position',
      type: 'Offset',
      sample: 'Offset(120, 80)',
      explanation:
          'Global pointer position when the signal was emitted, in logical px.',
      icon: Icons.my_location,
    ),
    _FieldSpec(
      name: 'kind',
      type: 'PointerDeviceKind',
      sample: 'PointerDeviceKind.mouse',
      explanation:
          'Coarse device class: touch, mouse, stylus, trackpad, unknown.',
      icon: Icons.mouse,
    ),
    _FieldSpec(
      name: 'embedderId',
      type: 'int',
      sample: '0',
      explanation:
          'Embedder-specific tag. Useful for multi-window or custom embedders.',
      icon: Icons.tag_faces,
    ),
  ];

  return _section(
    palette: palette,
    icon: Icons.grid_view_rounded,
    title: 'Common fields (inherited from PointerEvent)',
    subtitle: 'Every signal carries who/where/when, not just the what.',
    child: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: <Widget>[
        for (final _FieldSpec field in fields)
          _fieldCard(field: field, palette: palette),
      ],
    ),
  );
}

Widget _fieldCard({required _FieldSpec field, required _Palette palette}) {
  return Container(
    width: 280,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: palette.secondary.withValues(alpha: 0.25)),
      boxShadow: [
        BoxShadow(
          color: palette.primary.withValues(alpha: 0.08),
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
                color: palette.surface,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(field.icon, size: 18, color: palette.primary),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    field.name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: palette.primary,
                    ),
                  ),
                  Text(
                    field.type,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: palette.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF263238),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Text(
            field.sample,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFFB2EBF2),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          field.explanation,
          style: const TextStyle(
            fontSize: 12,
            height: 1.4,
            color: Color(0xFF37474F),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 4: PointerScrollEvent deep dive.
// =============================================================================

Widget _buildScrollDeepDive(PointerScrollEvent event) {
  const _Palette palette = _scrollPalette;
  const List<_ScrollPanelSpec> panels = <_ScrollPanelSpec>[
    _ScrollPanelSpec(
      label: 'Scroll up',
      delta: Offset(0, -120),
      note: 'Negative dy; content moves up the viewport.',
      tone: Color(0xFF1976D2),
    ),
    _ScrollPanelSpec(
      label: 'Scroll down',
      delta: Offset(0, 120),
      note: 'Positive dy; content moves down the viewport.',
      tone: Color(0xFF388E3C),
    ),
    _ScrollPanelSpec(
      label: 'Scroll left-up',
      delta: Offset(-80, -80),
      note: 'Diagonal trackpad scroll. Both axes carry pixel deltas.',
      tone: Color(0xFFFF8F00),
    ),
    _ScrollPanelSpec(
      label: 'Scroll right-down',
      delta: Offset(80, 80),
      note: 'Diagonal trackpad scroll, mirrored quadrant.',
      tone: Color(0xFF8E24AA),
    ),
  ];

  return _section(
    palette: palette,
    icon: Icons.swap_vert,
    title: 'PointerScrollEvent — wheel & trackpad scroll',
    subtitle:
        'scrollDelta is in logical pixels per step, not lines or notches.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _codeBlock(
          'const PointerScrollEvent(\n'
          '  timeStamp: Duration(milliseconds: 1200),\n'
          '  device: 1,\n'
          '  position: Offset(120, 80),\n'
          '  scrollDelta: Offset(0, -120),\n'
          ');',
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            for (final _ScrollPanelSpec p in panels) _scrollPanel(p),
          ],
        ),
        const SizedBox(height: 16),
        _explanationBox(
          palette: palette,
          icon: Icons.info_outline,
          title: 'Pixels-per-step convention',
          body:
              'Flutter normalises wheel and trackpad scrolls to logical pixel '
              'deltas. There is no "lines per notch" abstraction at this '
              'layer — embedders translate platform events (notches, line '
              'mode, smooth-scroll) into px before dispatch. This makes the '
              'framework consistent across mice, precision trackpads, and '
              'touchscreen accessibility scrolling.',
        ),
        const SizedBox(height: 10),
        _explanationBox(
          palette: palette,
          icon: Icons.bolt,
          title: 'Live event sample',
          body: 'event.position = ${event.position}\n'
              'event.scrollDelta = ${event.scrollDelta}\n'
              'event.kind = ${event.kind}\n'
              'event.timeStamp = ${event.timeStamp}',
        ),
      ],
    ),
  );
}

Widget _scrollPanel(_ScrollPanelSpec spec) {
  return Container(
    width: 240,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: spec.tone.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: spec.tone.withValues(alpha: 0.16),
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
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: spec.tone,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              spec.label,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: spec.tone,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _vectorFrame(delta: spec.delta, tone: spec.tone),
        const SizedBox(height: 10),
        Text(
          'scrollDelta = Offset(${spec.delta.dx.toStringAsFixed(0)}, '
          '${spec.delta.dy.toStringAsFixed(0)})',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xFF263238),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          spec.note,
          style: const TextStyle(
            fontSize: 11,
            height: 1.35,
            color: Color(0xFF455A64),
          ),
        ),
      ],
    ),
  );
}

Widget _vectorFrame({required Offset delta, required Color tone}) {
  // Render the offset as an arrow inside a 200x100 framed area. We compute
  // an angle (using approximations since we cannot use math.atan2 without
  // an import, and avoid imports to stay within the contract — but
  // dart:math is allowed in Flutter; nevertheless, simple sign-based
  // bucketing works fine for this demo).
  //
  // We'll express the arrow as a Transform.rotate + an icon scaled by
  // magnitude, plus axis-aligned indicators.
  final double mag = (delta.dx.abs() + delta.dy.abs()) / 240.0;
  final double clamped = mag.clamp(0.4, 1.4);
  final double angle = _angleFor(delta);
  return Container(
    width: double.infinity,
    height: 90,
    decoration: BoxDecoration(
      color: const Color(0xFFF5F5F5),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: const Color(0xFFE0E0E0)),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _GridPainter(tone: tone.withValues(alpha: 0.18)),
          ),
        ),
        Transform.rotate(
          angle: angle,
          child: Transform.scale(
            scale: clamped,
            child: Icon(Icons.arrow_forward, color: tone, size: 36),
          ),
        ),
        Positioned(
          right: 6,
          bottom: 4,
          child: Text(
            '|d| ~ ${(delta.dx.abs() + delta.dy.abs()).toStringAsFixed(0)}px',
            style: TextStyle(
              fontSize: 9,
              fontFamily: 'monospace',
              color: tone,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// Sign-based angle approximation — picks one of 8 cardinal directions so we
// don't need dart:math.atan2.
double _angleFor(Offset delta) {
  // Default points right (angle 0).
  // We treat positive y as down (Flutter convention).
  if (delta.dx == 0 && delta.dy < 0) return -1.5708; // up
  if (delta.dx == 0 && delta.dy > 0) return 1.5708; // down
  if (delta.dy == 0 && delta.dx < 0) return 3.14159; // left
  if (delta.dy == 0 && delta.dx > 0) return 0.0; // right
  if (delta.dx > 0 && delta.dy < 0) return -0.7854; // up-right
  if (delta.dx < 0 && delta.dy < 0) return -2.3562; // up-left
  if (delta.dx > 0 && delta.dy > 0) return 0.7854; // down-right
  if (delta.dx < 0 && delta.dy > 0) return 2.3562; // down-left
  return 0.0;
}

class _GridPainter extends CustomPainter {
  const _GridPainter({required this.tone});

  final Color tone;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = tone
      ..strokeWidth = 1.0;
    // Center cross.
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      p,
    );
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      p,
    );
    // Corner ticks.
    const double tick = 6.0;
    canvas.drawLine(const Offset(0, 0), const Offset(tick, 0), p);
    canvas.drawLine(const Offset(0, 0), const Offset(0, tick), p);
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width - tick, 0),
      p,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, tick),
      p,
    );
    canvas.drawLine(
      Offset(0, size.height),
      Offset(tick, size.height),
      p,
    );
    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, size.height - tick),
      p,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - tick, size.height),
      p,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - tick),
      p,
    );
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.tone != tone;
}

// =============================================================================
// Section 5: PointerScrollInertiaCancelEvent deep dive.
// =============================================================================

Widget _buildInertiaCancelDeepDive(PointerScrollInertiaCancelEvent event) {
  const _Palette palette = _inertiaPalette;
  return _section(
    palette: palette,
    icon: Icons.pan_tool,
    title: 'PointerScrollInertiaCancelEvent',
    subtitle:
        'Finger placed on trackpad mid-fling — programmatic momentum should stop.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _codeBlock(
          'const PointerScrollInertiaCancelEvent(\n'
          '  timeStamp: Duration(milliseconds: 1300),\n'
          '  device: 1,\n'
          '  position: Offset(120, 80),\n'
          ');',
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _explanationBox(
                palette: palette,
                icon: Icons.touch_app,
                title: 'When is it dispatched?',
                body:
                    'After a flick scroll on a precision trackpad, the OS '
                    'continues to emit synthetic scroll deltas to simulate '
                    'momentum. If the user touches the trackpad again before '
                    'this momentum decays, the OS sends one of these events. '
                    'Listeners that drive their own programmatic momentum '
                    'should treat this as a stop signal.',
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _explanationBox(
                palette: palette,
                icon: Icons.flag,
                title: 'Practical use',
                body:
                    'Custom scroll views, inertia-driven plot panners, and '
                    'analog physics widgets all care about this event. '
                    'Handle it by clamping any decaying velocity to zero '
                    'and snapping the visible offset to its current frame.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _inertiaTimeline(),
        const SizedBox(height: 12),
        _explanationBox(
          palette: palette,
          icon: Icons.bolt,
          title: 'Live event sample',
          body: 'event.position = ${event.position}\n'
              'event.timeStamp = ${event.timeStamp}\n'
              'event.runtimeType = ${event.runtimeType}',
        ),
      ],
    ),
  );
}

Widget _inertiaTimeline() {
  const Color base = Color(0xFFE65100);
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: base.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Inertia lifecycle',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: base,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            _timelinePill('flick', base, 0.4),
            const _TimelineArrow(),
            _timelinePill('momentum', base, 0.7),
            const _TimelineArrow(),
            _timelinePill('finger', Colors.red, 1.0),
            const _TimelineArrow(),
            _timelinePill('cancel', base.withValues(alpha: 0.85), 0.55),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Each pill represents a distinct phase. The last two — finger touch '
          'and the resulting cancel event — are the contract between the OS '
          'and Flutter for halting programmatic inertia.',
          style: TextStyle(
            fontSize: 12,
            height: 1.4,
            color: Color(0xFF455A64),
          ),
        ),
      ],
    ),
  );
}

Widget _timelinePill(String label, Color tone, double weight) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12 + 0.5 * weight),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: tone.withValues(alpha: 0.5)),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: tone,
          ),
        ),
      ),
    ),
  );
}

class _TimelineArrow extends StatelessWidget {
  const _TimelineArrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Icon(Icons.chevron_right, size: 18, color: Color(0xFF607D8B)),
    );
  }
}

// =============================================================================
// Section 6: PointerScaleEvent deep dive.
// =============================================================================

Widget _buildScaleDeepDive(PointerScaleEvent event) {
  const _Palette palette = _scalePalette;
  const List<_ScalePanelSpec> panels = <_ScalePanelSpec>[
    _ScalePanelSpec(factor: 0.5, label: 'pinch in', tone: Color(0xFF1976D2)),
    _ScalePanelSpec(factor: 0.8, label: 'small zoom-out', tone: Color(0xFF0288D1)),
    _ScalePanelSpec(factor: 1.0, label: 'identity', tone: Color(0xFF455A64)),
    _ScalePanelSpec(factor: 1.25, label: 'zoom-in', tone: Color(0xFF388E3C)),
    _ScalePanelSpec(factor: 1.6, label: 'pinch out', tone: Color(0xFFD32F2F)),
  ];

  return _section(
    palette: palette,
    icon: Icons.zoom_in,
    title: 'PointerScaleEvent — trackpad pinch zoom',
    subtitle:
        'scale is a unitless multiplier; >1 zooms in, <1 zooms out, 1 is identity.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _codeBlock(
          'const PointerScaleEvent(\n'
          '  timeStamp: Duration(milliseconds: 1400),\n'
          '  device: 1,\n'
          '  position: Offset(120, 80),\n'
          '  scale: 1.25,\n'
          ');',
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: WrapAlignment.center,
          children: <Widget>[
            for (final _ScalePanelSpec p in panels) _scalePanel(p),
          ],
        ),
        const SizedBox(height: 14),
        _explanationBox(
          palette: palette,
          icon: Icons.center_focus_strong,
          title: 'Centre of zoom',
          body:
              'The scale factor is centred on event.position in global '
              'coordinates. Apps usually convert this to a local position '
              'via the RenderBox of the affected widget and apply a Matrix4 '
              'transform whose origin is that local point.',
        ),
        const SizedBox(height: 10),
        _explanationBox(
          palette: palette,
          icon: Icons.bolt,
          title: 'Live event sample',
          body: 'event.position = ${event.position}\n'
              'event.scale = ${event.scale}\n'
              'event.kind = ${event.kind}\n'
              'event.timeStamp = ${event.timeStamp}',
        ),
      ],
    ),
  );
}

Widget _scalePanel(_ScalePanelSpec spec) {
  return Container(
    width: 150,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: spec.tone.withValues(alpha: 0.45)),
      boxShadow: [
        BoxShadow(
          color: spec.tone.withValues(alpha: 0.16),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Center(
            child: Transform.scale(
              scale: spec.factor,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: spec.tone.withValues(alpha: 0.85),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  boxShadow: [
                    BoxShadow(
                      color: spec.tone.withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          spec.label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: spec.tone,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'scale = ${spec.factor.toStringAsFixed(2)}',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xFF263238),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 7: Routing — PointerSignalResolver.
// =============================================================================

Widget _buildRoutingPanel() {
  const _Palette palette = _routingPalette;
  return _section(
    palette: palette,
    icon: Icons.alt_route,
    title: 'Routing: bypassing the gesture arena',
    subtitle: 'Signals flow through PointerSignalResolver, not GestureArena.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _routingBox(
                title: 'Positional events',
                subtitle: 'PointerDown/Move/Up',
                body:
                    'Compete in GestureArena. Multiple recognizers may claim '
                    'the same pointer; the arena picks a winner once gestures '
                    'declare victory or yield.',
                tone: const Color(0xFF455A64),
                icon: Icons.sports_kabaddi,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _routingBox(
                title: 'Signal events',
                subtitle: 'Scroll / Scale / InertiaCancel',
                body:
                    'Routed by PointerSignalResolver. The first listener to '
                    'register interest in the dispatch frame wins; there is '
                    'no protracted competition.',
                tone: palette.accent,
                icon: Icons.alt_route,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _explanationBox(
          palette: palette,
          icon: Icons.layers,
          title: 'Why a separate path?',
          body:
              'A scroll wheel notch has no concept of "winning" a gesture. '
              'It is an instantaneous event that one widget should react to. '
              'PointerSignalResolver enforces this: only one Listener per '
              'event gets to act, decided immediately, with no defer/yield '
              'protocol.',
        ),
      ],
    ),
  );
}

Widget _routingBox({
  required String title,
  required String subtitle,
  required String body,
  required Color tone,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: tone.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: tone.withValues(alpha: 0.12),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.15),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Icon(icon, color: tone, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: tone,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Color(0xFF607D8B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          body,
          style: const TextStyle(
            fontSize: 12,
            height: 1.4,
            color: Color(0xFF37474F),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 8: Construction sample summary — live values.
// =============================================================================

Widget _buildConstructionSummary(
  PointerScrollEvent scroll,
  PointerScrollInertiaCancelEvent inertia,
  PointerScaleEvent scale,
) {
  const _Palette palette = _summaryPalette;
  return _section(
    palette: palette,
    icon: Icons.fact_check_outlined,
    title: 'Live values from constructed events',
    subtitle: 'Every card pulls fields directly off the event instance.',
    child: Wrap(
      spacing: 14,
      runSpacing: 14,
      children: <Widget>[
        _liveCard(
          tone: const Color(0xFFB71C1C),
          title: 'PointerScrollEvent',
          rows: <List<String>>[
            <String>['runtimeType', '${scroll.runtimeType}'],
            <String>['position', '${scroll.position}'],
            <String>['scrollDelta', '${scroll.scrollDelta}'],
            <String>['kind', '${scroll.kind}'],
            <String>['timeStamp', '${scroll.timeStamp}'],
            <String>['pointer', '${scroll.pointer}'],
            <String>['device', '${scroll.device}'],
          ],
        ),
        _liveCard(
          tone: const Color(0xFFE65100),
          title: 'PointerScrollInertiaCancelEvent',
          rows: <List<String>>[
            <String>['runtimeType', '${inertia.runtimeType}'],
            <String>['position', '${inertia.position}'],
            <String>['kind', '${inertia.kind}'],
            <String>['timeStamp', '${inertia.timeStamp}'],
            <String>['pointer', '${inertia.pointer}'],
            <String>['device', '${inertia.device}'],
          ],
        ),
        _liveCard(
          tone: const Color(0xFF0D47A1),
          title: 'PointerScaleEvent',
          rows: <List<String>>[
            <String>['runtimeType', '${scale.runtimeType}'],
            <String>['position', '${scale.position}'],
            <String>['scale', '${scale.scale}'],
            <String>['kind', '${scale.kind}'],
            <String>['timeStamp', '${scale.timeStamp}'],
            <String>['pointer', '${scale.pointer}'],
            <String>['device', '${scale.device}'],
          ],
        ),
      ],
    ),
  );
}

Widget _liveCard({
  required Color tone,
  required String title,
  required List<List<String>> rows,
}) {
  return Container(
    width: 320,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: tone.withValues(alpha: 0.45)),
      boxShadow: [
        BoxShadow(
          color: tone.withValues(alpha: 0.16),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.bolt, size: 16, color: tone),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: tone,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (final List<String> row in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 110,
                  child: Text(
                    row[0],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Color(0xFF607D8B),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    row[1],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Color(0xFF263238),
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

// =============================================================================
// Section 9: Comparison panel — positional vs signal.
// =============================================================================

Widget _buildComparisonPanel() {
  const _Palette palette = _comparePalette;
  return _section(
    palette: palette,
    icon: Icons.compare_arrows,
    title: 'PointerEvent vs PointerSignalEvent',
    subtitle: 'Two semantic worlds in one pointer pipeline.',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _compareCard(
            title: 'PointerEvent (positional)',
            tone: palette.primary,
            rows: const <_Bullet>[
              _Bullet(
                title: 'Lifecycle',
                body: 'Down → Move (n times) → Up / Cancel.',
                icon: Icons.swap_calls,
              ),
              _Bullet(
                title: 'Routing',
                body: 'GestureArena, with claim/reject/sweep semantics.',
                icon: Icons.sports_kabaddi,
              ),
              _Bullet(
                title: 'Examples',
                body: 'PointerDownEvent, PointerMoveEvent, PointerUpEvent.',
                icon: Icons.list_alt,
              ),
              _Bullet(
                title: 'Hit-test',
                body: 'Path collected at down; reused for the entire stream.',
                icon: Icons.center_focus_weak,
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _compareCard(
            title: 'PointerSignalEvent (non-positional)',
            tone: palette.accent,
            rows: const <_Bullet>[
              _Bullet(
                title: 'Lifecycle',
                body: 'Discrete; each event is independent.',
                icon: Icons.bolt,
              ),
              _Bullet(
                title: 'Routing',
                body: 'PointerSignalResolver picks one listener per event.',
                icon: Icons.alt_route,
              ),
              _Bullet(
                title: 'Examples',
                body:
                    'PointerScrollEvent, PointerScaleEvent, PointerScrollInertiaCancelEvent.',
                icon: Icons.list_alt,
              ),
              _Bullet(
                title: 'Hit-test',
                body: 'Recomputed per event — no stream contract to maintain.',
                icon: Icons.center_focus_weak,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _compareCard({
  required String title,
  required Color tone,
  required List<_Bullet> rows,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: tone.withValues(alpha: 0.45)),
      boxShadow: [
        BoxShadow(
          color: tone.withValues(alpha: 0.14),
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
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.15),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(Icons.layers, size: 18, color: tone),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: tone,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (final _Bullet b in rows) _bulletRow(b, tone),
      ],
    ),
  );
}

Widget _bulletRow(_Bullet bullet, Color tone) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.12),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Icon(bullet.icon, size: 14, color: tone),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                bullet.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFF263238),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                bullet.body,
                style: const TextStyle(
                  fontSize: 11.5,
                  height: 1.35,
                  color: Color(0xFF455A64),
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
// Section 10: Caveats.
// =============================================================================

Widget _buildCaveats() {
  const _Palette palette = _caveatsPalette;
  return _section(
    palette: palette,
    icon: Icons.report_gmailerrorred,
    title: 'Caveats and platform notes',
    subtitle: 'Signal availability is a function of platform + device.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _caveatRow(
          icon: Icons.laptop_mac,
          tone: palette.primary,
          title: 'Trackpad signals are platform-specific',
          body:
              'PointerScaleEvent and the precision-trackpad flavour of '
              'PointerScrollInertiaCancelEvent originate from macOS, iPadOS '
              'desktop windowing, and a subset of Linux trackpads. On '
              'Windows, scroll events use mouse-wheel semantics; pinch comes '
              'in via touch (PointerPanZoom*) rather than as a scale signal.',
        ),
        _caveatRow(
          icon: Icons.tag,
          tone: palette.secondary,
          title: 'embedderId is implementation-defined',
          body:
              'The default Flutter embedders typically leave embedderId at 0. '
              'Custom embedders (e.g. multi-window, in-process plugin hosts) '
              'may use it as a per-window or per-surface tag. Don\'t treat '
              'specific values as portable.',
        ),
        _caveatRow(
          icon: Icons.timer_off,
          tone: palette.accent,
          title: 'No down/up pairing',
          body:
              'Signals don\'t pair. There is no "scroll down" or "scale up" '
              'event preceding them. Don\'t maintain a state machine that '
              'expects one.',
        ),
        _caveatRow(
          icon: Icons.swap_calls,
          tone: palette.primary,
          title: 'PointerPanZoom* is a different family',
          body:
              'On touchscreens, multi-finger pan and zoom come through '
              'PointerPanZoomStart/Update/End — these are positional and '
              'flow through the gesture arena. Do not confuse them with '
              'PointerScaleEvent.',
        ),
      ],
    ),
  );
}

Widget _caveatRow({
  required IconData icon,
  required Color tone,
  required String title,
  required String body,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      border: Border.all(color: tone.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: tone.withValues(alpha: 0.14),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Icon(icon, color: tone, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: tone,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.4,
                  color: Color(0xFF37474F),
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
// Section 11: Footer.
// =============================================================================

Widget _buildFooter() {
  const _Palette palette = _footerPalette;
  const List<_Bullet> takeaways = <_Bullet>[
    _Bullet(
      title: 'Abstract base',
      body: 'PointerSignalEvent unifies non-positional pointer events.',
      icon: Icons.account_tree_outlined,
    ),
    _Bullet(
      title: 'Three concrete types',
      body: 'Scroll, ScrollInertiaCancel, Scale.',
      icon: Icons.bolt,
    ),
    _Bullet(
      title: 'Bypasses the gesture arena',
      body: 'Routed by PointerSignalResolver, immediate dispatch.',
      icon: Icons.alt_route,
    ),
    _Bullet(
      title: 'Pixel deltas, multiplicative scale',
      body: 'scrollDelta is in logical px; scale is unitless.',
      icon: Icons.calculate,
    ),
    _Bullet(
      title: 'Watch the platform',
      body: 'Trackpad signals are macOS/iPadOS desktop and some Linux.',
      icon: Icons.laptop_mac,
    ),
  ];

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: palette.surface,
      borderRadius: const BorderRadius.all(Radius.circular(18)),
      border: Border.all(color: palette.secondary.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: palette.primary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: const Icon(Icons.flag, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            const Text(
              'Takeaways',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Color(0xFF212121),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        for (final _Bullet b in takeaways) _bulletRow(b, palette.primary),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: palette.accent.withValues(alpha: 0.12),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: palette.accent.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.info_outline, color: palette.accent, size: 18),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'See PointerSignalResolver and Listener.onPointerSignal '
                  'for the consumer-side API.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF263238),
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
// Shared building blocks.
// =============================================================================

Widget _section({
  required _Palette palette,
  required IconData icon,
  required String title,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: palette.surface,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      border: Border.all(color: palette.secondary.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(
          color: palette.primary.withValues(alpha: 0.06),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: palette.primary,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                boxShadow: [
                  BoxShadow(
                    color: palette.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: palette.primary,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: palette.secondary,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        child,
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF263238),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF263238).withValues(alpha: 0.4),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFF37474F),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: const Text(
            'dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Color(0xFFB2EBF2),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFFE0F2F1),
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _explanationBox({
  required _Palette palette,
  required IconData icon,
  required String title,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      border: Border.all(color: palette.secondary.withValues(alpha: 0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: palette.surface,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Icon(icon, size: 18, color: palette.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: palette.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.4,
                  color: Color(0xFF37474F),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

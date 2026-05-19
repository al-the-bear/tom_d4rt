// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
//
// =============================================================================
// Deep demo: dart:ui UniformVec2Slot
// =============================================================================
//
// What is UniformVec2Slot?
// ------------------------
// UniformVec2Slot is the descriptor object that the Flutter engine uses to
// represent a single 2-component (vec2) uniform inside a compiled
// FragmentProgram. When a Skia/Impeller fragment shader declares:
//
//      uniform vec2 u_resolution;
//
// the FragmentProgram metadata exposes that uniform via a *pair* of float
// slots whose Dart-side handle is UniformVec2Slot. The application writes the
// two components by issuing two consecutive setFloat calls on a
// FragmentShader:
//
//      shader.setFloat(slot + 0, x); // u_resolution.x
//      shader.setFloat(slot + 1, y); // u_resolution.y
//
// The engine narrows each Dart double to a 32-bit float and packs them
// adjacent in the uniform buffer that is bound for the next draw.
//
// Note on the local shim
// ----------------------
// The deep demo cannot import dart:ui directly (the SendTestRunner sandbox
// only re-exports types via package:flutter/material.dart). UniformVec2Slot
// is also not part of the public Flutter surface that the AST bridge exposes
// uniformly across versions, so we define a tiny local stand-in class that
// mirrors the relevant fields (slot index, two float components, semantic
// label). All behaviour shown here is descriptive — there is no real GPU
// upload happening inside the sandbox.
//
// What is demonstrated below
// --------------------------
// This script is a static "field guide" for the slot. There is no animation,
// no state and no real shader compile. Instead, every section paints a piece
// of explanatory UI that you would hand to a junior teammate the first time
// they meet the FragmentShader vec2 API:
//
//   Section 0  Anchor                  shim runtime metadata
//   Section 1  Title banner            neon synthwave gradient + drop shadow
//   Section 2  Anatomy diagram         slot index pattern, host vs GPU
//   Section 3  Visualization grid      Containers sized by sample (x, y) vec2
//   Section 4  Use-case gallery        resolution, mouse, uv, scale, ...
//   Section 5  Comparison table        FloatSlot vs Vec2/Vec3/Vec4/Sampler
//   Section 6  Lifecycle flow          two setFloat calls -> UBO -> shader
//   Section 7  Frag code panel         a typical Skia .frag file using vec2
//   Section 8  Cheat sheet             setFloat(slot, x); setFloat(slot+1, y)
//   Final      Legend / signature card
//
// Sandbox constraints honoured
// ----------------------------
//   * No StatefulWidget, no setState, no controllers, no Timer, no Future.
//   * No MaterialApp / Scaffold; demo renders inside a SingleChildScrollView.
//   * Container never combines color: with decoration: — gradients always
//     live inside BoxDecoration.
//   * Color.withValues(alpha: ...) is used instead of withOpacity.
//   * All iteration is index-based; no for-in over BridgedInstance lists.
//   * Returns one root widget tree from the top-level build() entry point.
// =============================================================================

import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Local shim for UniformVec2Slot.
//
// UniformVec2Slot is part of dart:ui's FragmentProgram metadata family. It is
// not available as a constructable type on the public Flutter surface, and it
// is not bridged by the SendTestRunner harness. The shim below is a
// hand-rolled placeholder that exposes exactly the fields the demo wants to
// render: a binding index, a two-component float pair, a human label and a
// short description. Every call site in the demo treats this shim as
// read-only, so there is no mutation, no copy semantics and no equality
// concern to worry about.
// -----------------------------------------------------------------------------
class UniformVec2Slot {
  final int slot;
  final String name;
  final String purpose;
  final double x;
  final double y;
  const UniformVec2Slot({
    required this.slot,
    required this.name,
    required this.purpose,
    required this.x,
    required this.y,
  });

  String get hexBitsX => _floatHex(x);
  String get hexBitsY => _floatHex(y);

  // Pretty-prints a host Dart double in the same format the engine uses when
  // logging a narrowed float32 — purely cosmetic, not numerically accurate.
  static String _floatHex(double value) {
    final int sign = value.isNegative ? 1 : 0;
    final int magnitude = value.abs().truncate();
    final int hash = (magnitude * 0x9E3779B1) & 0x7FFFFFFF;
    final int bits = (sign << 31) | hash;
    return '0x${bits.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  @override
  String toString() => 'UniformVec2Slot(#$slot $name = ($x, $y))';
}

// -----------------------------------------------------------------------------
// Palette: a "shader / synthwave / neon" theme.
// Every constant is a top-level Color — the script avoids per-call allocations.
// -----------------------------------------------------------------------------
const Color _kVoid = Color(0xFF05060B);
const Color _kCarbon = Color(0xFF11131C);
const Color _kSlate = Color(0xFF1B2030);
const Color _kInk = Color(0xFF252B40);
const Color _kMist = Color(0xFFB8C0D9);
const Color _kBone = Color(0xFFE8ECF7);
const Color _kAccent = Color(0xFF49E0FF);
const Color _kNeonPink = Color(0xFFFF3D7F);
const Color _kNeonOrange = Color(0xFFFFB14E);
const Color _kNeonYellow = Color(0xFFF5E663);
const Color _kNeonGreen = Color(0xFF6BFFA1);
const Color _kNeonCyan = Color(0xFF49E0FF);
const Color _kNeonViolet = Color(0xFF8C7BFF);
const Color _kNeonMagenta = Color(0xFFEC7BFF);
const Color _kWarn = Color(0xFFFFCA5C);
const Color _kError = Color(0xFFFF6B6B);
const Color _kOk = Color(0xFF6BFFA1);
const Color _kHairline = Color(0x33B8C0D9);
const Color _kPanel = Color(0xFF161B2A);
const Color _kPanelHi = Color(0xFF202942);

// =============================================================================
// Top-level entry point invoked once by the SendTestRunner sandbox.
// =============================================================================
dynamic build(BuildContext context) {
  print('==============================================================');
  print('UniformVec2Slot deep-demo build() starting');
  print('==============================================================');
  print('Root build context runtimeType: ${context.runtimeType}');
  print('Palette anchor color (_kAccent): $_kAccent');
  print('Palette warn color (_kWarn): $_kWarn');

  // ---------------------------------------------------------------------------
  // Build a small set of representative shim instances. They are used by the
  // anatomy section and the visualisation grid; defining them once at the top
  // of build() keeps the section helpers pure (no globals, no state).
  // ---------------------------------------------------------------------------
  final UniformVec2Slot resolutionSlot = const UniformVec2Slot(
    slot: 0,
    name: 'u_resolution',
    purpose: 'screen size in physical pixels',
    x: 1920.0,
    y: 1080.0,
  );
  final UniformVec2Slot mouseSlot = const UniformVec2Slot(
    slot: 2,
    name: 'u_mouse',
    purpose: 'pointer position in [0, 1] uv space',
    x: 0.42,
    y: 0.78,
  );
  final UniformVec2Slot uvSlot = const UniformVec2Slot(
    slot: 4,
    name: 'u_uvOffset',
    purpose: 'texture sampling offset',
    x: 0.125,
    y: 0.250,
  );
  final UniformVec2Slot scaleSlot = const UniformVec2Slot(
    slot: 6,
    name: 'u_scale',
    purpose: 'anisotropic 2D scale factor',
    x: 1.5,
    y: 0.75,
  );
  final UniformVec2Slot dirSlot = const UniformVec2Slot(
    slot: 8,
    name: 'u_dir',
    purpose: 'unit direction (cos, sin)',
    x: 0.7071,
    y: 0.7071,
  );

  print('  resolutionSlot: $resolutionSlot');
  print('  mouseSlot:      $mouseSlot');
  print('  uvSlot:         $uvSlot');
  print('  scaleSlot:      $scaleSlot');
  print('  dirSlot:        $dirSlot');

  final List<Widget> sections = <Widget>[];

  // -------- Section 0: Anchor the type itself ------------------------------
  print('=== Section 0: anchor UniformVec2Slot ===');
  final Type slotType = UniformVec2Slot;
  final int slotTypeHash = identityHashCode(slotType);
  final int slotTypeStdHash = slotType.hashCode;
  final String slotTypeRtt = slotType.runtimeType.toString();
  final String slotTypeStr = slotType.toString();
  print('  UniformVec2Slot Type literal: $slotTypeStr');
  print('  identityHashCode(slotType) = $slotTypeHash');
  print('  slotType.hashCode          = $slotTypeStdHash');
  print('  slotType.runtimeType       = $slotTypeRtt');
  sections.add(_buildSection0Anchor(
    typeStr: slotTypeStr,
    runtimeTypeStr: slotTypeRtt,
    identityHash: slotTypeHash,
    standardHash: slotTypeStdHash,
    sample: resolutionSlot,
  ));
  sections.add(const SizedBox(height: 18));

  // -------- Section 1: Title banner ----------------------------------------
  print('=== Section 1: title banner ===');
  print('  banner palette: void -> neonViolet -> neonCyan -> bone');
  print('  banner shadow: 3 layered BoxShadow stops');
  print('  banner subtitle font: monospace 12');
  sections.add(_buildSection1TitleBanner());
  sections.add(const SizedBox(height: 18));

  // -------- Section 2: Anatomy diagram -------------------------------------
  print('=== Section 2: anatomy diagram ===');
  print('  anatomy fields: slot index, x slot, y slot, host vs gpu');
  print('  anatomy uses two-column Row with vertical hairline');
  print('  anatomy includes a slot-pair index strip');
  sections.add(_buildSection2Anatomy(resolutionSlot));
  sections.add(const SizedBox(height: 18));

  // -------- Section 3: Visualization grid ----------------------------------
  print('=== Section 3: visualization grid ===');
  print('  vis grid cells: 6 sample vec2 values');
  print('  cell width and height map x and y to pixel sizes');
  print('  cell colour wraps around the neon spectrum');
  sections.add(_buildSection3VisualizationGrid());
  sections.add(const SizedBox(height: 18));

  // -------- Section 4: Use-case gallery ------------------------------------
  print('=== Section 4: use-case gallery ===');
  print('  gallery cards count: 8');
  print('  gallery uses Wrap with 12px run/main spacing');
  print('  gallery cards each have a unique gradient');
  sections.add(_buildSection4UseCaseGallery(<UniformVec2Slot>[
    resolutionSlot,
    mouseSlot,
    uvSlot,
    scaleSlot,
    dirSlot,
  ]));
  sections.add(const SizedBox(height: 18));

  // -------- Section 5: Comparison table ------------------------------------
  print('=== Section 5: comparison table ===');
  print('  comparison columns: Slot, Floats, Bytes, Setter, Use');
  print('  comparison rows: FloatSlot, Vec2 (current), Vec3, Vec4, SamplerSlot');
  print('  comparison header has its own gradient strip');
  sections.add(_buildSection5ComparisonTable());
  sections.add(const SizedBox(height: 18));

  // -------- Section 6: Lifecycle flow --------------------------------------
  print('=== Section 6: lifecycle flow ===');
  print('  lifecycle stages: 6 (host (x,y) -> setFloat x -> setFloat y -> '
      'pack -> ubo -> shader)');
  print('  lifecycle uses arrow chevrons in a single Row');
  print('  lifecycle stages each carry a sub-caption');
  sections.add(_buildSection6LifecycleFlow());
  sections.add(const SizedBox(height: 18));

  // -------- Section 7: Frag code panel -------------------------------------
  print('=== Section 7: frag code panel ===');
  print('  frag panel: shows a typical .frag with a vec2 uniform');
  print('  frag panel uses syntax-coloured spans');
  sections.add(_buildSection7FragCodePanel());
  sections.add(const SizedBox(height: 18));

  // -------- Section 8: Cheat sheet -----------------------------------------
  print('=== Section 8: cheat sheet ===');
  print('  cheat-sheet line 1: pair signature');
  print('  cheat-sheet line 2: x component');
  print('  cheat-sheet line 3: y component');
  print('  cheat-sheet line 4: throws on out-of-range slot pair');
  sections.add(_buildSection8CheatSheet());
  sections.add(const SizedBox(height: 18));

  // -------- Legend / signature card ----------------------------------------
  print('=== Final: legend / signature card ===');
  print('  legend lists every spectrum color used');
  print('  signature card shows shim runtime label');
  sections.add(_buildLegendCard());
  sections.add(const SizedBox(height: 24));
  sections.add(_buildSignatureCard(slotTypeStr));

  print('==============================================================');
  print('UniformVec2Slot deep-demo build() finished, sections: '
      '${sections.length}');
  print('==============================================================');

  return SingleChildScrollView(
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kVoid, _kCarbon, _kSlate],
          stops: <double>[0.0, 0.55, 1.0],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: sections,
      ),
    ),
  );
}

// =============================================================================
// SECTION 0 -- Anchor the UniformVec2Slot type
// =============================================================================
Widget _buildSection0Anchor({
  required String typeStr,
  required String runtimeTypeStr,
  required int identityHash,
  required int standardHash,
  required UniformVec2Slot sample,
}) {
  print('  _buildSection0Anchor: composing 5 metadata rows');
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kPanel, _kPanelHi, _kInk],
        stops: <double>[0.0, 0.6, 1.0],
      ),
      border: Border.all(color: _kHairline, width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x4049E0FF),
          blurRadius: 24,
          spreadRadius: -4,
          offset: Offset(0, 8),
        ),
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 6,
          spreadRadius: 0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildAnchorBadge('SECTION 0'),
            const SizedBox(width: 10),
            const Text(
              'Type Anchor',
              style: TextStyle(
                color: _kBone,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'UniformVec2Slot is the descriptor for a two-component float '
          'uniform inside a Flutter FragmentProgram. The shim below mirrors '
          'the binding index and the (x, y) pair so the demo can render '
          'the data without compiling a real shader.',
          style: TextStyle(
            color: _kMist,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14),
        _buildKeyValueRow('Type literal', typeStr),
        _buildKeyValueRow('runtimeType.toString()', runtimeTypeStr),
        _buildKeyValueRow(
            'identityHashCode', '0x${identityHash.toRadixString(16)}'),
        _buildKeyValueRow('hashCode', '0x${standardHash.toRadixString(16)}'),
        _buildKeyValueRow('sample.toString()', sample.toString()),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: _kVoid,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kHairline, width: 1),
          ),
          child: const Text(
            'final Type slot = UniformVec2Slot;\n'
            '// Concrete instances arrive at runtime from FragmentProgram.\n'
            '// They wrap a slot index and two consecutive float entries.',
            style: TextStyle(
              color: _kAccent,
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

Widget _buildAnchorBadge(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[_kNeonCyan, _kNeonViolet],
      ),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x6649E0FF),
          blurRadius: 12,
          spreadRadius: -2,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: _kVoid,
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.4,
      ),
    ),
  );
}

Widget _buildKeyValueRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 180,
          child: Text(
            key,
            style: const TextStyle(
              color: _kMist,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: _kBone,
              fontSize: 12.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 1 -- Title banner
// =============================================================================
Widget _buildSection1TitleBanner() {
  print('  _buildSection1TitleBanner: composing banner with gradient + shadow');
  return Container(
    padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _kVoid,
          _kNeonViolet,
          _kNeonMagenta,
          _kNeonCyan,
          _kBone,
        ],
        stops: <double>[0.0, 0.32, 0.55, 0.82, 1.0],
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kNeonViolet.withValues(alpha: 0.55),
          blurRadius: 32,
          spreadRadius: -2,
          offset: const Offset(0, 14),
        ),
        BoxShadow(
          color: _kNeonCyan.withValues(alpha: 0.4),
          blurRadius: 18,
          spreadRadius: -4,
          offset: const Offset(0, 4),
        ),
        const BoxShadow(
          color: Color(0x33000000),
          blurRadius: 4,
          spreadRadius: 0,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const RadialGradient(
                center: Alignment(0.85, -0.6),
                radius: 1.2,
                colors: <Color>[
                  Color(0x66FFFFFF),
                  Color(0x00000000),
                ],
                stops: <double>[0.0, 1.0],
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildBannerChip('dart:ui'),
                const SizedBox(width: 8),
                _buildBannerChip('FragmentShader'),
                const SizedBox(width: 8),
                _buildBannerChip('uniform vec2'),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'UniformVec2Slot',
              style: TextStyle(
                color: _kVoid,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'A typed handle to two consecutive 32-bit floats packed as vec2',
              style: TextStyle(
                color: Color(0xCC050608),
                fontSize: 13,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0x66050608),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'shader.setFloat(slot + 0, x); '
                'shader.setFloat(slot + 1, y);',
                style: TextStyle(
                  color: _kBone,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBannerChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: const Color(0x55050608),
      border: Border.all(color: const Color(0x55FFFFFF), width: 1),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: _kBone,
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// =============================================================================
// SECTION 2 -- Anatomy diagram
// =============================================================================
Widget _buildSection2Anatomy(UniformVec2Slot sample) {
  print('  _buildSection2Anatomy: composing two-column anatomy view');
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: _kPanel,
      border: Border.all(color: _kHairline, width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 14,
          spreadRadius: -4,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildAnchorBadge('SECTION 2'),
            const SizedBox(width: 10),
            const Text(
              'Anatomy of a vec2 slot',
              style: TextStyle(
                color: _kBone,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: _buildAnatomyColumn(
                  title: 'Host side (Dart)',
                  subtitle: 'CPU memory, double precision pair',
                  rows: <List<String>>[
                    const <String>['identifier', 'UniformVec2Slot'],
                    <String>['binding index', 'int = ${sample.slot}'],
                    const <String>['type tag', 'TYPE_VEC2'],
                    <String>['component x', '${sample.x} (double)'],
                    <String>['component y', '${sample.y} (double)'],
                    const <String>['setter pair',
                        'setFloat(i, x); setFloat(i+1, y)'],
                  ],
                  accent: _kNeonCyan,
                ),
              ),
              Container(
                width: 1,
                margin: const EdgeInsets.symmetric(horizontal: 14),
                color: _kHairline,
              ),
              Expanded(
                child: _buildAnatomyColumn(
                  title: 'GPU side (SkSL/Impeller)',
                  subtitle: 'Uniform buffer, two adjacent float32 lanes',
                  rows: const <List<String>>[
                    <String>['glsl', 'uniform vec2 name;'],
                    <String>['storage', '8 bytes / 64 bits'],
                    <String>['format', '2x IEEE-754 single'],
                    <String>['layout', 'name.x, name.y'],
                    <String>['swizzle', 'name.xy / name.yx'],
                    <String>['sample', 'name.x, name.y in body'],
                  ],
                  accent: _kNeonPink,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _buildSlotPairStrip(sample),
      ],
    ),
  );
}

Widget _buildAnatomyColumn({
  required String title,
  required String subtitle,
  required List<List<String>> rows,
  required Color accent,
}) {
  final List<Widget> children = <Widget>[
    Text(
      title,
      style: TextStyle(
        color: accent,
        fontSize: 13,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.4,
      ),
    ),
    const SizedBox(height: 2),
    Text(
      subtitle,
      style: const TextStyle(
        color: _kMist,
        fontSize: 11,
        fontStyle: FontStyle.italic,
      ),
    ),
    const SizedBox(height: 10),
  ];
  for (int i = 0; i < rows.length; i++) {
    final List<String> row = rows[i];
    children.add(
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
                  color: _kMist,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[1],
                style: const TextStyle(
                  color: _kBone,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: children,
  );
}

Widget _buildSlotPairStrip(UniformVec2Slot sample) {
  // Visualises a slot table where two consecutive entries (slot, slot+1) are
  // highlighted as the "vec2 pair" while the surrounding slots are dimmed.
  final int center = sample.slot;
  final List<Widget> cells = <Widget>[];
  for (int i = 0; i < 10; i++) {
    final bool isX = i == center;
    final bool isY = i == center + 1;
    final bool isPair = isX || isY;
    final Color cellColor = isX
        ? _kNeonCyan
        : (isY ? _kNeonMagenta : _kSlate);
    final String label = isX
        ? '.x'
        : (isY ? '.y' : 'f$i');
    cells.add(
      Container(
        width: 30,
        height: 28,
        margin: const EdgeInsets.only(right: 3),
        decoration: BoxDecoration(
          color: cellColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isPair ? _kBone : _kHairline,
            width: isPair ? 1.5 : 1,
          ),
          boxShadow: isPair
              ? <BoxShadow>[
                  BoxShadow(
                    color: cellColor.withValues(alpha: 0.6),
                    blurRadius: 8,
                    spreadRadius: -2,
                  ),
                ]
              : const <BoxShadow>[],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isPair ? _kVoid : _kMist,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text(
        'Slot table (a vec2 occupies two adjacent float lanes)',
        style: TextStyle(
          color: _kMist,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 6),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: cells,
      ),
      const SizedBox(height: 4),
      Text(
        'cyan = slot ${sample.slot} (.x)   magenta = slot '
        '${sample.slot + 1} (.y)   slate = unrelated lanes',
        style: const TextStyle(
          color: _kMist,
          fontSize: 10.5,
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 3 -- Visualization grid
// =============================================================================
Widget _buildSection3VisualizationGrid() {
  print('  _buildSection3VisualizationGrid: composing 6 sized cells');
  // Each sample maps an (x, y) vec2 to a Container size. The cells are
  // intentionally not laid out in a perfect grid because real vec2 uniforms
  // rarely produce uniform sizes.
  final List<List<dynamic>> samples = <List<dynamic>>[
    <dynamic>['(40, 40)', 40.0, 40.0, _kNeonCyan, _kNeonViolet],
    <dynamic>['(80, 30)', 80.0, 30.0, _kNeonViolet, _kNeonMagenta],
    <dynamic>['(60, 60)', 60.0, 60.0, _kNeonMagenta, _kNeonPink],
    <dynamic>['(30, 80)', 30.0, 80.0, _kNeonPink, _kNeonOrange],
    <dynamic>['(100, 50)', 100.0, 50.0, _kNeonOrange, _kNeonYellow],
    <dynamic>['(50, 100)', 50.0, 100.0, _kNeonYellow, _kNeonGreen],
  ];
  final List<Widget> cells = <Widget>[];
  for (int i = 0; i < samples.length; i++) {
    final String label = samples[i][0] as String;
    final double w = samples[i][1] as double;
    final double h = samples[i][2] as double;
    final Color a = samples[i][3] as Color;
    final Color b = samples[i][4] as Color;
    cells.add(_buildVec2Tile(label: label, width: w, height: h, a: a, b: b));
  }
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: _kPanel,
      border: Border.all(color: _kHairline, width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 14,
          spreadRadius: -4,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildAnchorBadge('SECTION 3'),
            const SizedBox(width: 10),
            const Text(
              'Visualisation: vec2 -> Size',
              style: TextStyle(
                color: _kBone,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'Each tile has its width and height bound to the (x, y) components '
          'of a hypothetical vec2 uniform. In a real shader this could feed '
          'a gl_FragCoord scaling factor or a procedural rectangle size.',
          style: TextStyle(
            color: _kMist,
            fontSize: 12,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: cells,
        ),
      ],
    ),
  );
}

Widget _buildVec2Tile({
  required String label,
  required double width,
  required double height,
  required Color a,
  required Color b,
}) {
  // Labels live above the tile so the tile itself only carries the size.
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
          color: _kBone,
          fontSize: 11,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 4),
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[a, b],
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: b.withValues(alpha: 0.5),
              blurRadius: 14,
              spreadRadius: -4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      ),
      const SizedBox(height: 4),
      Text(
        '${width.toStringAsFixed(0)} x ${height.toStringAsFixed(0)} px',
        style: const TextStyle(
          color: _kMist,
          fontSize: 10,
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 4 -- Use-case gallery
// =============================================================================
Widget _buildSection4UseCaseGallery(List<UniformVec2Slot> samples) {
  print('  _buildSection4UseCaseGallery: composing ${samples.length} cards '
      'plus 3 extra synthetic vec2 examples');
  final List<Widget> cards = <Widget>[];
  // Render the typed shim instances first.
  final List<List<Color>> grads = const <List<Color>>[
    <Color>[_kNeonPink, _kNeonOrange],
    <Color>[_kNeonOrange, _kNeonYellow],
    <Color>[_kNeonYellow, _kNeonGreen],
    <Color>[_kNeonGreen, _kNeonCyan],
    <Color>[_kNeonCyan, _kNeonViolet],
    <Color>[_kNeonViolet, _kNeonMagenta],
    <Color>[_kNeonMagenta, _kNeonPink],
    <Color>[_kNeonPink, _kNeonCyan],
  ];
  for (int i = 0; i < samples.length; i++) {
    cards.add(_buildUseCaseCard(
      title: samples[i].name,
      subtitle: samples[i].purpose,
      sample: '(${samples[i].x}, ${samples[i].y})',
      gradient: grads[i % grads.length],
    ));
  }
  // Three extra synthetic vec2 examples to round out the gallery.
  cards.add(_buildUseCaseCard(
    title: 'u_jitter',
    subtitle: 'sub-pixel offset (dx, dy)',
    sample: '(0.005, -0.003)',
    gradient: grads[5],
  ));
  cards.add(_buildUseCaseCard(
    title: 'u_pivot',
    subtitle: 'rotation pivot in uv',
    sample: '(0.5, 0.5)',
    gradient: grads[6],
  ));
  cards.add(_buildUseCaseCard(
    title: 'u_velocity',
    subtitle: 'motion-blur direction',
    sample: '(12.0, 4.5)',
    gradient: grads[7],
  ));

  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: _kPanel,
      border: Border.all(color: _kHairline, width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 14,
          spreadRadius: -4,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildAnchorBadge('SECTION 4'),
            const SizedBox(width: 10),
            const Text(
              'Typical vec2 uniforms',
              style: TextStyle(
                color: _kBone,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: cards,
        ),
      ],
    ),
  );
}

Widget _buildUseCaseCard({
  required String title,
  required String subtitle,
  required String sample,
  required List<Color> gradient,
}) {
  return Container(
    width: 178,
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: gradient,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: gradient[1].withValues(alpha: 0.45),
          blurRadius: 18,
          spreadRadius: -4,
          offset: const Offset(0, 6),
        ),
        const BoxShadow(
          color: Color(0x22000000),
          blurRadius: 4,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: _kVoid,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xCC050608),
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0x88050608),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            sample,
            style: const TextStyle(
              color: _kBone,
              fontSize: 13,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 5 -- Comparison table
// =============================================================================
Widget _buildSection5ComparisonTable() {
  print('  _buildSection5ComparisonTable: composing 5-row, 5-col table');
  final List<List<String>> rows = const <List<String>>[
    <String>['UniformFloatSlot', '1', '4', 'setFloat(i, double)', 'scalar'],
    <String>[
      'UniformVec2Slot',
      '2',
      '8',
      'setFloat(i, x); setFloat(i+1, y)',
      'uv / size'
    ],
    <String>[
      'UniformVec3Slot',
      '3',
      '12',
      'setFloat per channel (i..i+2)',
      'rgb / position'
    ],
    <String>[
      'UniformVec4Slot',
      '4',
      '16',
      'setFloat per channel (i..i+3)',
      'rgba / quat'
    ],
    <String>[
      'UniformSamplerSlot',
      '-',
      '-',
      'setImageSampler(i, image)',
      'texture bind'
    ],
  ];
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: _kPanel,
      border: Border.all(color: _kHairline, width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 14,
          spreadRadius: -4,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildAnchorBadge('SECTION 5'),
            const SizedBox(width: 10),
            const Text(
              'Slot family at a glance',
              style: TextStyle(
                color: _kBone,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            gradient: LinearGradient(
              colors: <Color>[_kNeonViolet, _kNeonCyan],
            ),
          ),
          child: Row(
            children: const <Widget>[
              SizedBox(
                width: 170,
                child: Text(
                  'Slot',
                  style: TextStyle(
                    color: _kVoid,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(
                width: 36,
                child: Text(
                  'flt',
                  style: TextStyle(
                    color: _kVoid,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                width: 44,
                child: Text(
                  'bytes',
                  style: TextStyle(
                    color: _kVoid,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'setter',
                  style: TextStyle(
                    color: _kVoid,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'use',
                  style: TextStyle(
                    color: _kVoid,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: _kCarbon,
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(10)),
            border: Border.all(color: _kHairline, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildTableRows(rows),
          ),
        ),
      ],
    ),
  );
}

List<Widget> _buildTableRows(List<List<String>> rows) {
  final List<Widget> result = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    final List<String> row = rows[i];
    final bool current = row[0] == 'UniformVec2Slot';
    final Color rowColor = i.isEven ? _kCarbon : _kSlate;
    result.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: current ? const Color(0x2249E0FF) : rowColor,
          border: Border(
            bottom: BorderSide(
              color: i == rows.length - 1
                  ? const Color(0x00000000)
                  : _kHairline,
              width: 1,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 170,
              child: Text(
                row[0],
                style: TextStyle(
                  color: current ? _kAccent : _kBone,
                  fontSize: 12,
                  fontFamily: 'monospace',
                  fontWeight:
                      current ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: 36,
              child: Text(
                row[1],
                style: const TextStyle(
                  color: _kBone,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(
              width: 44,
              child: Text(
                row[2],
                style: const TextStyle(
                  color: _kBone,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                row[3],
                style: const TextStyle(
                  color: _kMist,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                row[4],
                style: const TextStyle(
                  color: _kMist,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return result;
}

// =============================================================================
// SECTION 6 -- Lifecycle flow
// =============================================================================
Widget _buildSection6LifecycleFlow() {
  print('  _buildSection6LifecycleFlow: composing 6-stage pipeline');
  final List<Map<String, String>> stages = <Map<String, String>>[
    <String, String>{
      'label': '(x, y) host',
      'sub': 'Dart 2x f64',
      'icon': 'D',
    },
    <String, String>{
      'label': 'setFloat x',
      'sub': 'slot + 0',
      'icon': 'X',
    },
    <String, String>{
      'label': 'setFloat y',
      'sub': 'slot + 1',
      'icon': 'Y',
    },
    <String, String>{
      'label': 'pack',
      'sub': '2x narrow f32',
      'icon': '~',
    },
    <String, String>{
      'label': 'UBO',
      'sub': '8 bytes',
      'icon': 'U',
    },
    <String, String>{
      'label': 'shader',
      'sub': 'uniform vec2',
      'icon': 'G',
    },
  ];
  final List<Widget> stageWidgets = <Widget>[];
  for (int i = 0; i < stages.length; i++) {
    stageWidgets.add(_buildLifecycleStage(stages[i], i));
    if (i < stages.length - 1) {
      stageWidgets.add(_buildLifecycleArrow());
    }
  }
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[_kPanel, _kCarbon],
      ),
      border: Border.all(color: _kHairline, width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x336BFFA1),
          blurRadius: 20,
          spreadRadius: -6,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildAnchorBadge('SECTION 6'),
            const SizedBox(width: 10),
            const Text(
              'Binding lifecycle: 2 setFloats -> vec2 in shader',
              style: TextStyle(
                color: _kBone,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: stageWidgets,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Two consecutive setFloat calls stage the (x, y) pair into the '
          'host-side mirror. The engine narrows each Dart double to float32 '
          'and packs them adjacent in the uniform buffer. The actual GPU '
          'upload happens when the shader is bound to a Paint and the engine '
          'flushes the next draw.',
          style: TextStyle(
            color: _kMist,
            fontSize: 11.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget _buildLifecycleStage(Map<String, String> stage, int index) {
  final List<List<Color>> grads = const <List<Color>>[
    <Color>[_kNeonPink, _kNeonOrange],
    <Color>[_kNeonOrange, _kNeonYellow],
    <Color>[_kNeonYellow, _kNeonGreen],
    <Color>[_kNeonGreen, _kNeonCyan],
    <Color>[_kNeonCyan, _kNeonViolet],
    <Color>[_kNeonViolet, _kNeonMagenta],
  ];
  final List<Color> grad = grads[index % grads.length];
  return Container(
    width: 86,
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: grad,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: grad[1].withValues(alpha: 0.5),
          blurRadius: 14,
          spreadRadius: -3,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xCC050608),
          ),
          child: Text(
            stage['icon']!,
            style: const TextStyle(
              color: _kBone,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          stage['label']!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _kVoid,
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 2),
        Text(
          stage['sub']!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xCC050608),
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildLifecycleArrow() {
  return Container(
    width: 16,
    alignment: Alignment.center,
    child: const Text(
      '>',
      style: TextStyle(
        color: _kAccent,
        fontSize: 18,
        fontWeight: FontWeight.w800,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// =============================================================================
// SECTION 7 -- Frag code panel
// =============================================================================
Widget _buildSection7FragCodePanel() {
  print('  _buildSection7FragCodePanel: composing simulated .frag listing');
  // The "code" is a sequence of (token, color) spans. We render it as a
  // Column of Rows, each row being one line. This avoids RichText (which the
  // sandbox sometimes mishandles) and keeps the layout deterministic.
  final List<List<List<String>>> lines = <List<List<String>>>[
    // [ [text, color-tag], ... ] per line
    <List<String>>[
      <String>['#version 460 core', 'comment'],
    ],
    <List<String>>[
      <String>['#include ', 'kw'],
      <String>['<flutter/runtime_effect.glsl>', 'str'],
    ],
    <List<String>>[
      <String>['', 'plain'],
    ],
    <List<String>>[
      <String>['uniform ', 'kw'],
      <String>['vec2 ', 'type'],
      <String>['u_resolution', 'ident'],
      <String>[';', 'plain'],
      <String>['  // pixels (w, h)', 'comment'],
    ],
    <List<String>>[
      <String>['uniform ', 'kw'],
      <String>['vec2 ', 'type'],
      <String>['u_mouse', 'ident'],
      <String>[';       ', 'plain'],
      <String>['// uv space [0..1]', 'comment'],
    ],
    <List<String>>[
      <String>['uniform ', 'kw'],
      <String>['float ', 'type'],
      <String>['u_time', 'ident'],
      <String>[';        ', 'plain'],
      <String>['// seconds since start', 'comment'],
    ],
    <List<String>>[
      <String>['', 'plain'],
    ],
    <List<String>>[
      <String>['out ', 'kw'],
      <String>['vec4 ', 'type'],
      <String>['fragColor', 'ident'],
      <String>[';', 'plain'],
    ],
    <List<String>>[
      <String>['', 'plain'],
    ],
    <List<String>>[
      <String>['void ', 'kw'],
      <String>['main', 'fn'],
      <String>['() {', 'plain'],
    ],
    <List<String>>[
      <String>['  vec2 ', 'type'],
      <String>['uv ', 'ident'],
      <String>['= ', 'plain'],
      <String>['FlutterFragCoord', 'fn'],
      <String>['().xy / ', 'plain'],
      <String>['u_resolution', 'ident'],
      <String>[';', 'plain'],
    ],
    <List<String>>[
      <String>['  vec2 ', 'type'],
      <String>['d ', 'ident'],
      <String>['= ', 'plain'],
      <String>['uv ', 'ident'],
      <String>['- ', 'plain'],
      <String>['u_mouse', 'ident'],
      <String>[';', 'plain'],
    ],
    <List<String>>[
      <String>['  float ', 'type'],
      <String>['r ', 'ident'],
      <String>['= ', 'plain'],
      <String>['length', 'fn'],
      <String>['(', 'plain'],
      <String>['d', 'ident'],
      <String>[');', 'plain'],
    ],
    <List<String>>[
      <String>['  fragColor ', 'ident'],
      <String>['= ', 'plain'],
      <String>['vec4', 'fn'],
      <String>['(', 'plain'],
      <String>['uv.x', 'ident'],
      <String>[', ', 'plain'],
      <String>['uv.y', 'ident'],
      <String>[', ', 'plain'],
      <String>['r', 'ident'],
      <String>[', ', 'plain'],
      <String>['1.0', 'num'],
      <String>[');', 'plain'],
    ],
    <List<String>>[
      <String>['}', 'plain'],
    ],
  ];
  final List<Widget> renderedLines = <Widget>[];
  for (int i = 0; i < lines.length; i++) {
    renderedLines.add(_buildFragLine(i + 1, lines[i]));
  }
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: _kPanel,
      border: Border.all(color: _kHairline, width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 14,
          spreadRadius: -4,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildAnchorBadge('SECTION 7'),
            const SizedBox(width: 10),
            const Text(
              'Typical Skia .frag using a vec2',
              style: TextStyle(
                color: _kBone,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
          decoration: BoxDecoration(
            color: _kVoid,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kHairline, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: renderedLines,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Each uniform vec2 in this shader corresponds to one '
          'UniformVec2Slot on the Dart side. The host code iterates the slot '
          'list and issues two setFloat calls per slot.',
          style: TextStyle(
            color: _kMist,
            fontSize: 11.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget _buildFragLine(int lineNumber, List<List<String>> spans) {
  // Map each token tag to a color from the neon palette.
  final List<Widget> tokens = <Widget>[];
  for (int i = 0; i < spans.length; i++) {
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #9, U16):
    // Empty-string Text widgets trip a NaN Offset assertion in the
    // bridged Flutter paragraph painter (dart:ui/painting.dart:41).
    // Substitute empty span text with a single space — the visual
    // result is identical for a blank line in a monospaced listing.
    final String rawText = spans[i][0];
    final String text = rawText.isEmpty ? ' ' : rawText;
    final String tag = spans[i][1];
    Color color;
    FontWeight weight;
    if (tag == 'kw') {
      color = _kNeonViolet;
      weight = FontWeight.w800;
    } else if (tag == 'type') {
      color = _kNeonCyan;
      weight = FontWeight.w700;
    } else if (tag == 'fn') {
      color = _kNeonYellow;
      weight = FontWeight.w700;
    } else if (tag == 'ident') {
      color = _kBone;
      weight = FontWeight.w600;
    } else if (tag == 'num') {
      color = _kNeonGreen;
      weight = FontWeight.w700;
    } else if (tag == 'str') {
      color = _kNeonOrange;
      weight = FontWeight.w600;
    } else if (tag == 'comment') {
      color = _kMist;
      weight = FontWeight.w500;
    } else {
      color = _kBone;
      weight = FontWeight.w500;
    }
    tokens.add(
      Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontFamily: 'monospace',
          fontWeight: weight,
          fontStyle: tag == 'comment' ? FontStyle.italic : FontStyle.normal,
        ),
      ),
    );
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 28,
          child: Text(
            lineNumber.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: Color(0x55B8C0D9),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: tokens,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 8 -- Cheat sheet
// =============================================================================
Widget _buildSection8CheatSheet() {
  print('  _buildSection8CheatSheet: composing setFloat-pair signature');
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kInk, _kPanelHi],
      ),
      border: Border.all(color: _kHairline, width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33EC7BFF),
          blurRadius: 18,
          spreadRadius: -4,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            _buildAnchorBadge('SECTION 8'),
            const SizedBox(width: 10),
            const Text(
              'Cheat sheet: write a vec2',
              style: TextStyle(
                color: _kBone,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kVoid,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kHairline, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                '// Pair signature for vec2 uniforms',
                style: TextStyle(
                  color: _kMist,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'shader.setFloat(slot + 0, x);',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 13,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'shader.setFloat(slot + 1, y);',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 13,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '// slot   first float of the vec2 pair, 0..(N - 2)',
                style: TextStyle(
                  color: _kMist,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                '// x      first component (Dart double, narrowed to f32)',
                style: TextStyle(
                  color: _kMist,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                '// y      second component (Dart double, narrowed to f32)',
                style: TextStyle(
                  color: _kMist,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                '// throws RangeError if slot or slot+1 is out of range',
                style: TextStyle(
                  color: _kWarn,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'A common pitfall: passing only one of the two floats. The shader '
          'will then read whatever stale value lives in slot+1 — usually '
          'producing flickering or off-by-one offsets.',
          style: TextStyle(
            color: _kMist,
            fontSize: 11.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Legend / signature card
// =============================================================================
Widget _buildLegendCard() {
  print('  _buildLegendCard: composing palette legend');
  final List<List<dynamic>> entries = <List<dynamic>>[
    <dynamic>['void', _kVoid],
    <dynamic>['carbon', _kCarbon],
    <dynamic>['slate', _kSlate],
    <dynamic>['ink', _kInk],
    <dynamic>['mist', _kMist],
    <dynamic>['bone', _kBone],
    <dynamic>['accent', _kAccent],
    <dynamic>['neonPink', _kNeonPink],
    <dynamic>['neonOrange', _kNeonOrange],
    <dynamic>['neonYellow', _kNeonYellow],
    <dynamic>['neonGreen', _kNeonGreen],
    <dynamic>['neonCyan', _kNeonCyan],
    <dynamic>['neonViolet', _kNeonViolet],
    <dynamic>['neonMagenta', _kNeonMagenta],
    <dynamic>['warn', _kWarn],
    <dynamic>['error', _kError],
    <dynamic>['ok', _kOk],
  ];
  final List<Widget> chips = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    final String name = entries[i][0] as String;
    final Color color = entries[i][1] as Color;
    chips.add(_buildLegendChip(name, color));
  }
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      color: _kCarbon,
      border: Border.all(color: _kHairline, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Palette legend',
          style: TextStyle(
            color: _kBone,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: chips,
        ),
      ],
    ),
  );
}

Widget _buildLegendChip(String name, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: _kSlate,
      border: Border.all(color: _kHairline, width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withValues(alpha: 0.6),
                blurRadius: 4,
                spreadRadius: -1,
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Text(
          name,
          style: const TextStyle(
            color: _kBone,
            fontSize: 10.5,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSignatureCard(String slotTypeStr) {
  print('  _buildSignatureCard: composing signature card');
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: <Color>[_kVoid, _kPanelHi],
      ),
      border: Border.all(color: _kHairline, width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x66FF3D7F),
          blurRadius: 20,
          spreadRadius: -6,
          offset: Offset(0, 8),
        ),
        BoxShadow(
          color: Color(0x4049E0FF),
          blurRadius: 16,
          spreadRadius: -4,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          '/// signed-off-by: dart:ui deep-demo',
          style: TextStyle(
            color: _kNeonCyan,
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 6),
        Text(
          slotTypeStr,
          style: const TextStyle(
            color: _kBone,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Hand-authored static snapshot for the D4rt-AST sandbox renderer. '
          'No animation, no controllers, no async. Just widgets, a local '
          'shim, and a healthy respect for vec2 packing rules.',
          style: TextStyle(
            color: _kMist,
            fontSize: 11,
            height: 1.45,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

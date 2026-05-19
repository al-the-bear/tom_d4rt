// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// =============================================================================
// Deep demo: dart:ui UniformFloatSlot
// =============================================================================
//
// What is UniformFloatSlot?
// -------------------------
// UniformFloatSlot is the descriptor object that the Flutter engine uses to
// represent a single 32-bit floating point uniform slot inside a compiled
// FragmentProgram. When a fragment shader declares:
//
//      uniform float intensity;
//
// the FragmentProgram metadata exposes that uniform via a slot whose Dart-side
// representation is UniformFloatSlot. The application then writes a value
// through FragmentShader.setFloat(int index, double value) — the Dart double
// is narrowed to GPU float32 and pushed into the uniform buffer that is bound
// for the next draw.
//
// What is demonstrated below
// --------------------------
// This script is a static "field guide" for the slot. There is no animation,
// no state and no real shader compile (the D4rt sandbox never reaches a real
// GPU). Instead, every section paints a piece of explanatory UI that you would
// hand to a junior teammate the first time they meet the FragmentShader API:
//
//   Section 0  Anchor                  identityHashCode / runtimeType / hashCode
//   Section 1  Title banner            gradient + drop shadow
//   Section 2  Anatomy diagram         binding index, type tag, host vs GPU
//   Section 3  Use-case gallery        time, intensity, threshold, hue, ...
//   Section 4  Comparison table        FloatSlot vs Vec2/Vec3/Vec4/Sampler
//   Section 5  Lifecycle flow          CPU double -> setFloat -> UBO -> GPU
//   Section 6  Numeric precision       double -> float32, NaN, Inf, denormals
//   Section 7  Real-world examples     vignette, brightness, gain, threshold
//   Section 8  Cheat sheet             setFloat(int, double) signature
//   Final      Legend / signature card
//
// Sandbox constraints honoured
// ----------------------------
//   * No StatefulWidget, no setState, no controllers, no Timer, no Future.
//   * All animation values are static (no Tween.animate calls).
//   * All iteration is index based; no for-in over BridgedInstance lists.
//   * Returns one root widget tree from the top-level build() entry point.
// =============================================================================

import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Palette: a "shader / scientific spectrum" theme.
// Every constant is a top-level Color — the script avoids per-call allocations.
// -----------------------------------------------------------------------------
const Color _kVoid = Color(0xFF05060B);
const Color _kCarbon = Color(0xFF11131C);
const Color _kSlate = Color(0xFF1B2030);
const Color _kInk = Color(0xFF252B40);
const Color _kMist = Color(0xFFB8C0D9);
const Color _kBone = Color(0xFFE8ECF7);
const Color _kAccent = Color(0xFF49E0FF);
const Color _kSpectrumA = Color(0xFFFF3D7F);
const Color _kSpectrumB = Color(0xFFFFB14E);
const Color _kSpectrumC = Color(0xFFF5E663);
const Color _kSpectrumD = Color(0xFF6BFFA1);
const Color _kSpectrumE = Color(0xFF49E0FF);
const Color _kSpectrumF = Color(0xFF8C7BFF);
const Color _kSpectrumG = Color(0xFFEC7BFF);
const Color _kWarn = Color(0xFFFFCA5C);
const Color _kError = Color(0xFFFF6B6B);
const Color _kOk = Color(0xFF6BFFA1);
const Color _kHairline = Color(0x33B8C0D9);
const Color _kPanel = Color(0xFF161B2A);
const Color _kPanelHi = Color(0xFF202942);

// -----------------------------------------------------------------------------
// Top-level entry point invoked once by the D4rt sandbox.
// -----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('==============================================================');
  print('UniformFloatSlot deep-demo build() starting');
  print('==============================================================');
  print('Root build context runtimeType: ${context.runtimeType}');
  print('Palette anchor color (_kAccent): $_kAccent');
  print('Palette warn color (_kWarn): $_kWarn');

  final List<Widget> sections = <Widget>[];

  // -------- Section 0: Anchor the type itself ------------------------------
  print('=== Section 0: anchor UniformFloatSlot ===');
  final Type slotType = ui.UniformFloatSlot;
  final int slotTypeHash = identityHashCode(slotType);
  final int slotTypeStdHash = slotType.hashCode;
  final String slotTypeRtt = slotType.runtimeType.toString();
  final String slotTypeStr = slotType.toString();
  print('  ui.UniformFloatSlot Type literal: $slotTypeStr');
  print('  identityHashCode(slotType) = $slotTypeHash');
  print('  slotType.hashCode          = $slotTypeStdHash');
  print('  slotType.runtimeType       = $slotTypeRtt');
  sections.add(_buildSection0Anchor(
    typeStr: slotTypeStr,
    runtimeTypeStr: slotTypeRtt,
    identityHash: slotTypeHash,
    standardHash: slotTypeStdHash,
  ));
  sections.add(const SizedBox(height: 18));

  // -------- Section 1: Title banner ----------------------------------------
  print('=== Section 1: title banner ===');
  print('  banner palette: void -> spectrumE -> bone');
  print('  banner shadow: 4 layered BoxShadow stops');
  print('  banner subtitle font: monospace 12');
  sections.add(_buildSection1TitleBanner());
  sections.add(const SizedBox(height: 18));

  // -------- Section 2: Anatomy diagram -------------------------------------
  print('=== Section 2: anatomy diagram ===');
  print('  anatomy fields: bindingIndex, typeTag, host double, gpu float32');
  print('  anatomy uses two-column Row with vertical hairline');
  print('  anatomy includes a 32-bit IEEE-754 bit strip');
  sections.add(_buildSection2Anatomy());
  sections.add(const SizedBox(height: 18));

  // -------- Section 3: Use-case gallery ------------------------------------
  print('=== Section 3: use-case gallery ===');
  print('  gallery cards count: 8');
  print('  gallery uses Wrap with 12px run/main spacing');
  print('  gallery cards each have a unique gradient');
  sections.add(_buildSection3UseCaseGallery());
  sections.add(const SizedBox(height: 18));

  // -------- Section 4: Comparison table ------------------------------------
  print('=== Section 4: comparison table ===');
  print('  comparison columns: Slot, Floats, Bytes, Setter, Use');
  print('  comparison rows: FloatSlot, Vec2, Vec3, Vec4, SamplerSlot');
  print('  comparison header has its own gradient strip');
  sections.add(_buildSection4ComparisonTable());
  sections.add(const SizedBox(height: 18));

  // -------- Section 5: Lifecycle flow --------------------------------------
  print('=== Section 5: lifecycle flow ===');
  print('  lifecycle stages: 5 (host -> narrow -> set -> ubo -> gpu)');
  print('  lifecycle uses arrow chevrons in a single Row');
  print('  lifecycle stages each carry a sub-caption');
  sections.add(_buildSection5LifecycleFlow());
  sections.add(const SizedBox(height: 18));

  // -------- Section 6: Numeric precision -----------------------------------
  print('=== Section 6: numeric precision notes ===');
  print('  precision rows: cast, NaN, Inf, denormals, range');
  print('  precision uses a Stack with a left status bar');
  print('  precision shows hex bit pattern for 1.0f');
  sections.add(_buildSection6PrecisionNotes());
  sections.add(const SizedBox(height: 18));

  // -------- Section 7: Real-world examples ---------------------------------
  print('=== Section 7: real-world examples ===');
  print('  examples count: 4 (vignette, brightness, gain, threshold)');
  print('  examples include a small "shader sketch" preview');
  print('  examples include slider mock with track + handle');
  sections.add(_buildSection7RealWorldExamples());
  sections.add(const SizedBox(height: 18));

  // -------- Section 8: Cheat sheet -----------------------------------------
  print('=== Section 8: cheat sheet ===');
  print('  cheat-sheet line 1: signature');
  print('  cheat-sheet line 2: parameter index');
  print('  cheat-sheet line 3: parameter value');
  print('  cheat-sheet line 4: throws on out-of-range index');
  sections.add(_buildSection8CheatSheet());
  sections.add(const SizedBox(height: 18));

  // -------- Legend / signature card ----------------------------------------
  print('=== Final: legend / signature card ===');
  print('  legend lists every spectrum color used');
  print('  signature card shows build timestamp slot');
  sections.add(_buildLegendCard());
  sections.add(const SizedBox(height: 24));
  sections.add(_buildSignatureCard(slotTypeStr));

  print('==============================================================');
  print('UniformFloatSlot deep-demo build() finished, sections: '
      '${sections.length}');
  print('==============================================================');

  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #8):
  // Nine deep-demo sections stack to ~3091 px on the 800x600 test
  // viewport, overflowing by 2491 px. Wrap the section Column in a
  // SingleChildScrollView so the full content lays out in a bounded,
  // scrollable child (P1+P2). Visual result is unchanged for a
  // hand-driven render; the static screenshot is just the top of the
  // scrollable rather than a clipped/overflowing Column.
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kVoid, _kCarbon, _kSlate],
        stops: <double>[0.0, 0.55, 1.0],
      ),
    ),
    padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: sections,
      ),
    ),
  );
}

// =============================================================================
// SECTION 0 -- Anchor the UniformFloatSlot type
// =============================================================================
Widget _buildSection0Anchor({
  required String typeStr,
  required String runtimeTypeStr,
  required int identityHash,
  required int standardHash,
}) {
  print('  _buildSection0Anchor: composing 4 metadata rows');
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
          'The Type literal ui.UniformFloatSlot is the only handle the Dart '
          'sandbox can grab without compiling a real FragmentProgram.',
          style: TextStyle(
            color: _kMist,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14),
        _buildKeyValueRow('Type literal', typeStr),
        _buildKeyValueRow('runtimeType.toString()', runtimeTypeStr),
        _buildKeyValueRow('identityHashCode', '0x${identityHash.toRadixString(16)}'),
        _buildKeyValueRow('hashCode', '0x${standardHash.toRadixString(16)}'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: _kVoid,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kHairline, width: 1),
          ),
          child: const Text(
            'final Type slot = ui.UniformFloatSlot;\n'
            '// Concrete instances arrive at runtime from FragmentProgram.\n'
            '// They are not constructable from user code.',
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
        colors: <Color>[_kSpectrumE, _kSpectrumF],
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
          _kSpectrumF,
          _kSpectrumE,
          _kBone,
        ],
        stops: <double>[0.0, 0.45, 0.78, 1.0],
      ),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x668C7BFF),
          blurRadius: 32,
          spreadRadius: -2,
          offset: Offset(0, 14),
        ),
        BoxShadow(
          color: Color(0x4049E0FF),
          blurRadius: 18,
          spreadRadius: -4,
          offset: Offset(0, 4),
        ),
        BoxShadow(
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
                _buildBannerChip('uniform float'),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'UniformFloatSlot',
              style: TextStyle(
                color: _kVoid,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'A typed handle to a single 32-bit float in a fragment program',
              style: TextStyle(
                color: Color(0xCC050608),
                fontSize: 13,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w500,
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
Widget _buildSection2Anatomy() {
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
              'Anatomy of a slot',
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
                  subtitle: 'CPU memory, double precision',
                  rows: const <List<String>>[
                    <String>['identifier', 'UniformFloatSlot'],
                    <String>['binding index', 'int (>= 0)'],
                    <String>['type tag', 'TYPE_FLOAT'],
                    <String>['host value', 'double (64-bit)'],
                    <String>['setter', 'shader.setFloat(i, v)'],
                  ],
                  accent: _kSpectrumE,
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
                  subtitle: 'Uniform buffer, float32',
                  rows: const <List<String>>[
                    <String>['glsl', 'uniform float name;'],
                    <String>['storage', '4 bytes / 32 bits'],
                    <String>['format', 'IEEE-754 single'],
                    <String>['exposure', 'all stages'],
                    <String>['sample', 'name in shader body'],
                  ],
                  accent: _kSpectrumA,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        _buildBitStrip(),
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

Widget _buildBitStrip() {
  // 32 cells with grouped colors: 1 sign + 8 exponent + 23 mantissa
  final List<Widget> cells = <Widget>[];
  for (int i = 0; i < 32; i++) {
    Color cellColor;
    String cellText;
    if (i == 0) {
      cellColor = _kSpectrumA;
      cellText = 'S';
    } else if (i < 9) {
      cellColor = _kSpectrumB;
      cellText = 'E';
    } else {
      cellColor = _kSpectrumE;
      cellText = 'M';
    }
    cells.add(
      Container(
        width: 14,
        height: 22,
        margin: const EdgeInsets.only(right: 2),
        decoration: BoxDecoration(
          color: cellColor,
          borderRadius: BorderRadius.circular(2),
        ),
        alignment: Alignment.center,
        child: Text(
          cellText,
          style: const TextStyle(
            color: _kVoid,
            fontSize: 9,
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
        'IEEE-754 single-precision layout (32 bits)',
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
      const Text(
        'S = sign (1 bit)   E = exponent (8 bits)   M = mantissa (23 bits)',
        style: TextStyle(
          color: _kMist,
          fontSize: 10.5,
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 3 -- Use-case gallery
// =============================================================================
Widget _buildSection3UseCaseGallery() {
  print('  _buildSection3UseCaseGallery: composing 8 cards');
  final List<Widget> cards = <Widget>[
    _buildUseCaseCard(
      title: 'time',
      subtitle: 'seconds since start',
      sample: '1.2734',
      gradient: const <Color>[_kSpectrumA, _kSpectrumB],
    ),
    _buildUseCaseCard(
      title: 'intensity',
      subtitle: 'multiplier on rgb',
      sample: '0.8500',
      gradient: const <Color>[_kSpectrumB, _kSpectrumC],
    ),
    _buildUseCaseCard(
      title: 'threshold',
      subtitle: 'cutoff in [0, 1]',
      sample: '0.5000',
      gradient: const <Color>[_kSpectrumC, _kSpectrumD],
    ),
    _buildUseCaseCard(
      title: 'hueRotate',
      subtitle: 'radians',
      sample: '1.5708',
      gradient: const <Color>[_kSpectrumD, _kSpectrumE],
    ),
    _buildUseCaseCard(
      title: 'sepiaMix',
      subtitle: 'tint blend factor',
      sample: '0.3500',
      gradient: const <Color>[_kSpectrumE, _kSpectrumF],
    ),
    _buildUseCaseCard(
      title: 'glowStrength',
      subtitle: 'bloom amount',
      sample: '2.1500',
      gradient: const <Color>[_kSpectrumF, _kSpectrumG],
    ),
    _buildUseCaseCard(
      title: 'blurSigma',
      subtitle: 'pixel radius',
      sample: '4.0000',
      gradient: const <Color>[_kSpectrumG, _kSpectrumA],
    ),
    _buildUseCaseCard(
      title: 'gain',
      subtitle: 'audio-style booster',
      sample: '1.4142',
      gradient: const <Color>[_kSpectrumA, _kSpectrumE],
    ),
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
            _buildAnchorBadge('SECTION 3'),
            const SizedBox(width: 10),
            const Text(
              'Typical scalar uniforms',
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
    width: 168,
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
          color: gradient[1].withOpacity(0.45),
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
// SECTION 4 -- Comparison table
// =============================================================================
Widget _buildSection4ComparisonTable() {
  print('  _buildSection4ComparisonTable: composing 5-row, 5-col table');
  final List<List<String>> rows = const <List<String>>[
    <String>['UniformFloatSlot', '1', '4', 'setFloat(i, double)', 'scalar param'],
    <String>['UniformVec2Slot', '2', '8', 'setFloat(i, x); setFloat(i+1, y)', 'uv / size'],
    <String>['UniformVec3Slot', '3', '12', 'setFloat per channel', 'rgb / position'],
    <String>['UniformVec4Slot', '4', '16', 'setFloat per channel', 'rgba / quat'],
    <String>['UniformSamplerSlot', '-', '-', 'setImageSampler(i, image)', 'texture bind'],
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
            _buildAnchorBadge('SECTION 4'),
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
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(10)),
            gradient: const LinearGradient(
              colors: <Color>[_kSpectrumF, _kSpectrumE],
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
    final bool current = row[0] == 'UniformFloatSlot';
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
// SECTION 5 -- Lifecycle flow
// =============================================================================
Widget _buildSection5LifecycleFlow() {
  print('  _buildSection5LifecycleFlow: composing 5-stage pipeline');
  final List<Map<String, String>> stages = <Map<String, String>>[
    <String, String>{
      'label': 'host double',
      'sub': 'Dart 64-bit',
      'icon': 'D',
    },
    <String, String>{
      'label': 'narrow',
      'sub': 'cast to f32',
      'icon': '~',
    },
    <String, String>{
      'label': 'setFloat',
      'sub': 'engine call',
      'icon': 'S',
    },
    <String, String>{
      'label': 'UBO',
      'sub': 'uniform buffer',
      'icon': 'U',
    },
    <String, String>{
      'label': 'shader',
      'sub': 'uniform float',
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
            _buildAnchorBadge('SECTION 5'),
            const SizedBox(width: 10),
            const Text(
              'Binding lifecycle: CPU to GPU',
              style: TextStyle(
                color: _kBone,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: stageWidgets,
        ),
        const SizedBox(height: 10),
        const Text(
          'Each setFloat call only stages the value into a host-side mirror. '
          'The actual GPU upload happens when the shader is bound to a Paint '
          'and the engine flushes the next draw.',
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
    <Color>[_kSpectrumA, _kSpectrumB],
    <Color>[_kSpectrumB, _kSpectrumC],
    <Color>[_kSpectrumC, _kSpectrumD],
    <Color>[_kSpectrumD, _kSpectrumE],
    <Color>[_kSpectrumE, _kSpectrumF],
  ];
  final List<Color> grad = grads[index % grads.length];
  return Container(
    width: 78,
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
          color: grad[1].withOpacity(0.5),
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
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xCC050608),
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
          style: const TextStyle(
            color: _kVoid,
            fontSize: 11,
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
// SECTION 6 -- Numeric precision notes
// =============================================================================
Widget _buildSection6PrecisionNotes() {
  print('  _buildSection6PrecisionNotes: composing precision notes');
  final List<Map<String, String>> notes = <Map<String, String>>[
    <String, String>{
      'title': 'double -> float32 cast',
      'body': 'Dart double (64-bit) is silently narrowed to float32. '
          'Mantissa truncates from 52 to 23 bits.',
      'state': 'info',
    },
    <String, String>{
      'title': 'NaN propagation',
      'body': 'A NaN reaches the shader as NaN. Comparisons with NaN '
          'are false; many GPU intrinsics propagate or sanitise it.',
      'state': 'warn',
    },
    <String, String>{
      'title': 'Inf clamping',
      'body': '+Inf / -Inf survive the cast but most fragment ops will '
          'collapse them on output. Clamp on the host when in doubt.',
      'state': 'warn',
    },
    <String, String>{
      'title': 'Denormals',
      'body': 'Subnormal values may be flushed to zero on some GPUs. '
          'Do not rely on tiny sub-2^-126 magnitudes.',
      'state': 'warn',
    },
    <String, String>{
      'title': 'Magnitude range',
      'body': 'Approx +/- 3.4e38, with about 7 decimal digits of precision. '
          'Time uniforms past ~16 hours start to lose seconds-level resolution.',
      'state': 'info',
    },
  ];
  final List<Widget> noteWidgets = <Widget>[];
  for (int i = 0; i < notes.length; i++) {
    noteWidgets.add(_buildPrecisionRow(notes[i]));
    if (i < notes.length - 1) {
      noteWidgets.add(const SizedBox(height: 8));
    }
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
            _buildAnchorBadge('SECTION 6'),
            const SizedBox(width: 10),
            const Text(
              'Numeric behaviour',
              style: TextStyle(
                color: _kBone,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...noteWidgets,
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: _kVoid,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kHairline, width: 1),
          ),
          child: const Text(
            '1.0f as IEEE-754 single = 0x3F800000\n'
            '            sign=0, exponent=01111111, mantissa=0...0',
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

Widget _buildPrecisionRow(Map<String, String> note) {
  final String state = note['state'] ?? 'info';
  Color stateColor;
  if (state == 'warn') {
    stateColor = _kWarn;
  } else if (state == 'error') {
    stateColor = _kError;
  } else {
    stateColor = _kSpectrumE;
  }
  return Stack(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 12, 10),
        margin: const EdgeInsets.only(left: 6),
        decoration: BoxDecoration(
          color: _kCarbon,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kHairline, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              note['title']!,
              style: TextStyle(
                color: stateColor,
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              note['body']!,
              style: const TextStyle(
                color: _kBone,
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
      Positioned(
        left: 0,
        top: 6,
        bottom: 6,
        child: Container(
          width: 4,
          decoration: BoxDecoration(
            color: stateColor,
            borderRadius: BorderRadius.circular(3),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: stateColor.withOpacity(0.6),
                blurRadius: 8,
                spreadRadius: -2,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION 7 -- Real-world examples
// =============================================================================
Widget _buildSection7RealWorldExamples() {
  print('  _buildSection7RealWorldExamples: composing 4 example panels');
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
              'Worked examples',
              style: TextStyle(
                color: _kBone,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildExamplePanel(
          name: 'vignette',
          uniform: 'uniform float u_strength;',
          host: 'shader.setFloat(0, 0.65);',
          sliderValue: 0.65,
          accent: _kSpectrumA,
        ),
        const SizedBox(height: 10),
        _buildExamplePanel(
          name: 'brightness',
          uniform: 'uniform float u_brightness;',
          host: 'shader.setFloat(1, 1.10);',
          sliderValue: 0.55,
          accent: _kSpectrumC,
        ),
        const SizedBox(height: 10),
        _buildExamplePanel(
          name: 'gain',
          uniform: 'uniform float u_gain;',
          host: 'shader.setFloat(2, 1.41);',
          sliderValue: 0.71,
          accent: _kSpectrumD,
        ),
        const SizedBox(height: 10),
        _buildExamplePanel(
          name: 'threshold',
          uniform: 'uniform float u_threshold;',
          host: 'shader.setFloat(3, 0.50);',
          sliderValue: 0.50,
          accent: _kSpectrumE,
        ),
      ],
    ),
  );
}

Widget _buildExamplePanel({
  required String name,
  required String uniform,
  required String host,
  required double sliderValue,
  required Color accent,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCarbon,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kHairline, width: 1),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.18),
          blurRadius: 14,
          spreadRadius: -4,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: RadialGradient(
              center: const Alignment(-0.1, -0.1),
              radius: 0.9,
              colors: <Color>[
                accent,
                accent.withOpacity(0.0),
              ],
              stops: const <double>[0.0, 1.0],
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            name.substring(0, 1).toUpperCase(),
            style: const TextStyle(
              color: _kVoid,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  color: accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                uniform,
                style: const TextStyle(
                  color: _kMist,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                host,
                style: const TextStyle(
                  color: _kBone,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              _buildMockSlider(value: sliderValue, accent: accent),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMockSlider({required double value, required Color accent}) {
  return SizedBox(
    height: 18,
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          right: 0,
          top: 7,
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: _kSlate,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Positioned(
          left: 0,
          top: 7,
          child: Container(
            height: 4,
            width: 220 * value,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  accent.withOpacity(0.6),
                  accent,
                ],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Positioned(
          left: (220 * value) - 9,
          top: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: accent.withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: -2,
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
// SECTION 8 -- Cheat sheet
// =============================================================================
Widget _buildSection8CheatSheet() {
  print('  _buildSection8CheatSheet: composing setFloat signature breakdown');
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
              'Cheat sheet: setFloat',
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
                'void FragmentShader.setFloat(int index, double value);',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 13,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '// index   binding slot, 0..(floatUniformsCount - 1)',
                style: TextStyle(
                  color: _kMist,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                '// value   Dart double, narrowed to float32 on upload',
                style: TextStyle(
                  color: _kMist,
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                '// throws  RangeError if index is outside the slot table',
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
          'Multi-component slots are written as consecutive float entries: '
          'a vec4 at index i is set with setFloat(i + 0..3).',
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
    <dynamic>['spectrumA', _kSpectrumA],
    <dynamic>['spectrumB', _kSpectrumB],
    <dynamic>['spectrumC', _kSpectrumC],
    <dynamic>['spectrumD', _kSpectrumD],
    <dynamic>['spectrumE', _kSpectrumE],
    <dynamic>['spectrumF', _kSpectrumF],
    <dynamic>['spectrumG', _kSpectrumG],
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
                color: color.withOpacity(0.6),
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
            color: _kSpectrumE,
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
          'No animation, no controllers, no async. Just widgets.',
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

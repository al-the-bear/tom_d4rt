// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demonstration of HitTestable from
// package:flutter/gestures.dart.
//
// HitTestable is the abstract interface that participants in Flutter's
// hit-test pipeline implement. It exposes a single contract:
//
//     void hitTest(HitTestResult result, Offset position)
//
// Implementers walk their internal structure for the supplied logical
// position, and append HitTestEntry instances to the supplied
// HitTestResult whenever they (or one of their children) intersect the
// pointer location. The accumulated path is then handed to
// GestureBinding.dispatchEvent, which delivers the pointer event in
// reverse order — innermost target first, outermost target last.
//
// This file is a static teaching demo: no live pointers, no listeners,
// no dispatch. We render a long, annotated diagram tree explaining the
// pipeline, the anatomy of HitTestResult, the standard implementers,
// a "build your own" pseudocode block, a worked z-stacked example,
// and a list of common pitfalls.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ---------------------------------------------------------------------------
// Private fake target. HitTestEntry needs a HitTestTarget; we keep the class
// declaration around purely as a teaching reference (it's shown verbatim in
// Section 6's pseudocode) — but we never actually instantiate it.
//
// D4RT-SCRIPT-WORKAROUND (U5/U9/U10 family — see
// `interpreter_unfixable.md` U-cluster): a script-defined
// `implements HitTestTarget` cannot cross the d4rt → native boundary as a
// native `HitTestTarget`, so the bridged `HitTestEntry(target)` constructor
// rejects the `InterpretedInstance` with
// `Argument Error: Invalid parameter "target": expected HitTestTarget, got
// InterpretedInstance(_FakeTarget)`. We substitute a pure script-side
// `_DemoHitEntry(label, runtimeTypeStr)` for the anatomy-panel display
// instead. The native `HitTestResult` and `BoxHitTestResult` constructors
// still execute successfully — only the `HitTestEntry(_FakeTarget)` boundary
// crossing is skipped.
// ---------------------------------------------------------------------------
class _FakeTarget implements HitTestTarget {
  _FakeTarget(this.label);

  final String label;

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    // No-op. This demo never dispatches.
  }

  @override
  String toString() => '_FakeTarget($label)';
}

// Script-side stand-in for HitTestEntry display (see U-cluster comment above).
class _DemoHitEntry {
  _DemoHitEntry(this.label, this.runtimeTypeStr);
  final String label;
  final String runtimeTypeStr;
}

// ---------------------------------------------------------------------------
// Top-level entry point. Returns a SingleChildScrollView containing the
// entire teaching layout.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('HitTestable Deep Demo executing');
  print('HitTestable: abstract interface — hitTest(HitTestResult, Offset)');

  // Build a sample anatomy view. We still construct real HitTestResult and
  // BoxHitTestResult instances to demonstrate that those native classes
  // exist and are reachable through the bridge — but we hold the per-entry
  // display data in script-side `_DemoHitEntry` records because
  // `HitTestEntry(<script-defined HitTestTarget>)` is rejected at the
  // bridged-constructor boundary (see U-cluster comment on `_FakeTarget`).
  final HitTestResult sampleResult = HitTestResult();
  final BoxHitTestResult sampleBoxResult = BoxHitTestResult();
  final List<_DemoHitEntry> sampleEntries = <_DemoHitEntry>[
    _DemoHitEntry('RenderParagraph#text', 'HitTestEntry'),
    _DemoHitEntry('RenderPadding#padding', 'HitTestEntry'),
    _DemoHitEntry('RenderView#root', 'HitTestEntry'),
  ];
  print('Sample HitTestResult constructed: ${sampleResult.runtimeType}');
  print('Sample HitTestResult initial path length: ${sampleResult.path.length}');
  print('Sample BoxHitTestResult: ${sampleBoxResult.runtimeType}');
  print('Demo anatomy entries (script-side): ${sampleEntries.length}');

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  print('=== Section 1: Hero header ===');
  final hero = _buildHero();

  // ============================================================
  // SECTION 2: Interface contract panel
  // ============================================================
  print('=== Section 2: Interface contract ===');
  final contract = _buildContractPanel();

  // ============================================================
  // SECTION 3: Pipeline diagram
  // ============================================================
  print('=== Section 3: Pipeline diagram ===');
  final pipeline = _buildPipelineDiagram();

  // ============================================================
  // SECTION 4: Anatomy of HitTestResult
  // ============================================================
  print('=== Section 4: HitTestResult anatomy ===');
  final anatomy = _buildAnatomyPanel(sampleEntries);

  // ============================================================
  // SECTION 5: Implementers gallery
  // ============================================================
  print('=== Section 5: Implementers gallery ===');
  final implementers = _buildImplementersGallery();

  // ============================================================
  // SECTION 6: "Build your own" pseudocode
  // ============================================================
  print('=== Section 6: Build your own ===');
  final pseudocode = _buildPseudocodePanel();

  // ============================================================
  // SECTION 7: Worked example — z-stacked widgets
  // ============================================================
  print('=== Section 7: Worked z-stack example ===');
  final worked = _buildZStackExample();

  // ============================================================
  // SECTION 8: Pitfalls
  // ============================================================
  print('=== Section 8: Pitfalls ===');
  final pitfalls = _buildPitfallsPanel();

  // ============================================================
  // SECTION 9: Footer
  // ============================================================
  print('=== Section 9: Footer ===');
  final footer = _buildFooter();

  print('HitTestable Deep Demo completed successfully');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        hero,
        SizedBox(height: 28.0),
        _sectionTitle('1. The Contract'),
        contract,
        SizedBox(height: 28.0),
        _sectionTitle('2. Where HitTestable Lives in the Pipeline'),
        pipeline,
        SizedBox(height: 28.0),
        _sectionTitle('3. Anatomy of a HitTestResult'),
        anatomy,
        SizedBox(height: 28.0),
        _sectionTitle('4. Who Implements HitTestable?'),
        implementers,
        SizedBox(height: 28.0),
        _sectionTitle('5. Build Your Own HitTestable'),
        pseudocode,
        SizedBox(height: 28.0),
        _sectionTitle('6. Worked Example: A Z-Stacked Hit Test'),
        worked,
        SizedBox(height: 28.0),
        _sectionTitle('7. Common Pitfalls'),
        pitfalls,
        SizedBox(height: 28.0),
        footer,
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1: Hero
// ---------------------------------------------------------------------------
Widget _buildHero() {
  return Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0F2027),
          Color(0xFF203A43),
          Color(0xFF2C5364),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.cyanAccent.withValues(alpha: 0.18),
          blurRadius: 60.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.cyanAccent.withValues(alpha: 0.7),
                Colors.cyan.withValues(alpha: 0.0),
              ],
            ),
          ),
          child: Icon(
            Icons.ads_click,
            size: 64.0,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'HitTestable',
          style: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'package:flutter/gestures.dart',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13.0,
            color: Colors.cyanAccent.shade100,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(999.0),
            border: Border.all(
              color: Colors.cyanAccent.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
          child: Text(
            'Hit-test interface for the Flutter pointer pipeline',
            style: TextStyle(color: Colors.white70, fontSize: 13.0),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2: Contract
// ---------------------------------------------------------------------------
Widget _buildContractPanel() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.12),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.handshake, color: Colors.indigo.shade700, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'The Interface',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeCard(
          'abstract interface class HitTestable {\n'
          '  void hitTest(HitTestResult result, Offset position);\n'
          '}',
          accent: Colors.cyanAccent,
        ),
        SizedBox(height: 16.0),
        Text(
          'Two responsibilities, one method:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 8.0),
        _bulletLine(
          Icons.input,
          Colors.deepPurple,
          'Receive a logical Offset (in this object\'s local coordinate system).',
        ),
        _bulletLine(
          Icons.layers,
          Colors.teal,
          'Append HitTestEntry instances to the supplied HitTestResult for '
          'every child / region the position intersects.',
        ),
        _bulletLine(
          Icons.south_east,
          Colors.orange,
          'Recurse into children — innermost-hit-first ordering is achieved '
          'because children add their entries before the parent.',
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.amber.shade400, width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'HitTestable returns nothing. Output is communicated via '
                  'mutation of the result argument. This lets the same result '
                  'thread through arbitrarily deep call chains without '
                  'allocations or repeated wrapping.',
                  style: TextStyle(fontSize: 12.5, color: Colors.amber.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3: Pipeline diagram
// ---------------------------------------------------------------------------
Widget _buildPipelineDiagram() {
  final stages = <_PipelineStage>[
    _PipelineStage(
      label: 'PointerEvent',
      sub: 'arrives from engine',
      icon: Icons.touch_app,
      color: Colors.deepOrange,
    ),
    _PipelineStage(
      label: 'GestureBinding\n.hitTest()',
      sub: 'builds initial result',
      icon: Icons.account_tree,
      color: Colors.purple,
    ),
    _PipelineStage(
      label: 'RendererBinding\n.hitTest()',
      sub: 'enters render tree',
      icon: Icons.dashboard,
      color: Colors.indigo,
    ),
    _PipelineStage(
      label: 'RenderBox.hitTest()\nchain',
      sub: 'recursive descent',
      icon: Icons.account_tree_outlined,
      color: Colors.teal,
    ),
    _PipelineStage(
      label: 'HitTestResult',
      sub: 'accumulated path',
      icon: Icons.list_alt,
      color: Colors.green,
    ),
    _PipelineStage(
      label: 'GestureBinding\n.dispatchEvent()',
      sub: 'walks path in reverse',
      icon: Icons.send,
      color: Colors.blue,
    ),
  ];

  final children = <Widget>[];
  for (var i = 0; i < stages.length; i++) {
    children.add(_pipelineBlock(stages[i]));
    if (i < stages.length - 1) {
      children.add(_pipelineArrow());
    }
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade100, Colors.grey.shade200],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.alt_route, color: Colors.deepPurple, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Pointer dispatch flow',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade300, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _legendLine(
                Colors.deepOrange,
                'Engine push: the platform sends a PointerEvent to the framework.',
              ),
              _legendLine(
                Colors.purple,
                'GestureBinding.hitTest constructs an empty HitTestResult.',
              ),
              _legendLine(
                Colors.indigo,
                'RendererBinding (a HitTestable) forwards into the render tree.',
              ),
              _legendLine(
                Colors.teal,
                'Each RenderBox decides if it is hit, then asks children — '
                'innermost adds first.',
              ),
              _legendLine(
                Colors.green,
                'The accumulated HitTestResult.path is the dispatch list.',
              ),
              _legendLine(
                Colors.blue,
                'GestureBinding.dispatchEvent walks path; targets receive '
                'handleEvent in order.',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _PipelineStage {
  _PipelineStage({
    required this.label,
    required this.sub,
    required this.icon,
    required this.color,
  });
  final String label;
  final String sub;
  final IconData icon;
  final Color color;
}

Widget _pipelineBlock(_PipelineStage stage) {
  return Container(
    width: 150.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          stage.color.withValues(alpha: 0.85),
          stage.color.withValues(alpha: 0.55),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: stage.color.withValues(alpha: 0.45),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(stage.icon, color: Colors.white, size: 30.0),
        SizedBox(height: 8.0),
        Text(
          stage.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.5,
            height: 1.2,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            stage.sub,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 9.5),
          ),
        ),
      ],
    ),
  );
}

Widget _pipelineArrow() {
  return Container(
    width: 36.0,
    alignment: Alignment.center,
    child: Icon(Icons.arrow_forward, color: Colors.grey.shade700, size: 26.0),
  );
}

Widget _legendLine(Color color, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.only(top: 4.0, right: 8.0),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4: Anatomy of a HitTestResult
// ---------------------------------------------------------------------------
Widget _buildAnatomyPanel(List<_DemoHitEntry> sampleEntries) {
  // Build a stacked card "pile" representing the path. Innermost (added
  // first) is at the top of the visual stack — that's the order in which
  // dispatchEvent will deliver the event.
  //
  // D4RT-SCRIPT-WORKAROUND (see U-cluster comment on `_FakeTarget`): we
  // iterate the script-side `_DemoHitEntry` list rather than a native
  // `HitTestResult.path` because `HitTestEntry(<script HitTestTarget>)` is
  // rejected at the bridged-constructor boundary.
  final entries = sampleEntries;
  final cards = <Widget>[];
  for (var i = 0; i < entries.length; i++) {
    final entry = entries[i];
    cards.add(_anatomyCard(
      index: i,
      total: entries.length,
      title: entry.label,
      runtimeType: entry.runtimeTypeStr,
    ));
    if (i < entries.length - 1) {
      cards.add(Center(
        child: Icon(
          Icons.south,
          color: Colors.grey.shade500,
          size: 22.0,
        ),
      ));
    }
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.teal.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.15),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers, color: Colors.teal.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'HitTestResult.path is an ordered list',
              style: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Path length: ${entries.length} entries — innermost (added first) '
          'at the top.',
          style: TextStyle(fontSize: 12.5, color: Colors.teal.shade800),
        ),
        SizedBox(height: 16.0),
        ...cards,
        SizedBox(height: 18.0),
        _codeCard(
          '// Reading a result\n'
          'for (final HitTestEntry entry in result.path) {\n'
          '  final HitTestTarget target = entry.target;\n'
          '  // dispatchEvent will call target.handleEvent(event, entry)\n'
          '}',
          accent: Colors.greenAccent,
        ),
        SizedBox(height: 12.0),
        _kvRow('Type', 'HitTestResult'),
        _kvRow('Box variant', 'BoxHitTestResult (extends HitTestResult)'),
        _kvRow('Sliver variant', 'SliverHitTestResult'),
        _kvRow('Mutation', 'add(HitTestEntry) — append-only, no remove'),
        _kvRow('Transform stack', 'pushTransform / pushOffset for matrix-aware children'),
      ],
    ),
  );
}

Widget _anatomyCard({
  required int index,
  required int total,
  required String title,
  required String runtimeType,
}) {
  // Vary the indentation slightly so the cards look like a pile.
  final indent = (index * 12.0);
  final palette = [
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.teal,
    Colors.green,
  ];
  final color = palette[index % palette.length];
  return Container(
    margin: EdgeInsets.only(left: indent, right: 0.0, bottom: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withValues(alpha: 0.2), color.withValues(alpha: 0.05)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 13.5,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                'entry: $runtimeType  (${index + 1} of $total)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        if (index == 0)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'dispatched first',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _kvRow(String key, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            key,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
              color: Colors.teal.shade900,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5: Implementers gallery
// ---------------------------------------------------------------------------
Widget _buildImplementersGallery() {
  final implementers = <_Impl>[
    _Impl(
      name: 'RendererBinding',
      summary:
          'The framework binding that owns the render tree. Its hitTest '
          'starts the recursive descent into the root RenderView.',
      icon: Icons.dashboard_customize,
      color: Colors.indigo,
    ),
    _Impl(
      name: 'GestureBinding',
      summary:
          'Coordinates pointer events. It calls hitTest on RendererBinding '
          'and then dispatchEvent over the resulting path.',
      icon: Icons.account_tree,
      color: Colors.deepPurple,
    ),
    _Impl(
      name: 'MouseTracker',
      summary:
          'Performs hit tests in response to mouse moves to compute hover '
          'entry/exit for MouseRegion widgets.',
      icon: Icons.mouse,
      color: Colors.teal,
    ),
    _Impl(
      name: 'RenderView',
      summary:
          'Root render object for a view. Forwards hits from screen-space '
          'coordinates into the render-object subtree.',
      icon: Icons.crop_landscape,
      color: Colors.blue,
    ),
    _Impl(
      name: 'PipelineOwner-attached subtrees',
      summary:
          'Custom embedders may attach their own HitTestable nodes (e.g., '
          'overlays, platform views) to feed pointers into Flutter.',
      icon: Icons.extension,
      color: Colors.orange,
    ),
    _Impl(
      name: 'Test bindings',
      summary:
          'TestWidgetsFlutterBinding intercepts and forwards hit tests so '
          'WidgetTester.tap() can route synthetic pointers correctly.',
      icon: Icons.science,
      color: Colors.pink,
    ),
  ];

  return Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    children: implementers.map(_implementerCard).toList(),
  );
}

class _Impl {
  _Impl({
    required this.name,
    required this.summary,
    required this.icon,
    required this.color,
  });
  final String name;
  final String summary;
  final IconData icon;
  final Color color;
}

Widget _implementerCard(_Impl impl) {
  return Container(
    width: 240.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          impl.color.withValues(alpha: 0.12),
          impl.color.withValues(alpha: 0.04),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: impl.color.withValues(alpha: 0.55),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: impl.color.withValues(alpha: 0.20),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: impl.color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(impl.icon, color: impl.color, size: 20.0),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                impl.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: impl.color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          impl.summary,
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6: Build your own (pseudocode)
// ---------------------------------------------------------------------------
Widget _buildPseudocodePanel() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1E1E2E), Color(0xFF11111B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Colors.greenAccent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Implement your own HitTestable',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Pseudocode shape used by RenderBox and friends.',
          style: TextStyle(color: Colors.white60, fontSize: 12.0),
        ),
        SizedBox(height: 14.0),
        _codeCard(
          'class MyHitGrid implements HitTestable, HitTestTarget {\n'
          '  MyHitGrid(this.cells);\n'
          '  final List<MyCell> cells;\n'
          '\n'
          '  @override\n'
          '  void hitTest(HitTestResult result, Offset position) {\n'
          '    // 1) Quick bounds reject.\n'
          '    if (!_bounds.contains(position)) return;\n'
          '\n'
          '    // 2) Recurse into children, innermost-first.\n'
          '    for (final cell in cells.reversed) {\n'
          '      if (cell.contains(position)) {\n'
          '        cell.hitTest(result, position - cell.offset);\n'
          '        // Could break here for opaque hits.\n'
          '      }\n'
          '    }\n'
          '\n'
          '    // 3) Add self last so dispatch reaches us after children.\n'
          '    result.add(HitTestEntry(this));\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  void handleEvent(PointerEvent e, HitTestEntry entry) {\n'
          '    // Receive dispatched events here.\n'
          '  }\n'
          '}',
          accent: Colors.greenAccent,
          dark: true,
        ),
        SizedBox(height: 14.0),
        _stepLine('1', Colors.cyan, 'Reject early when position is outside bounds.'),
        _stepLine('2', Colors.lightGreen,
            'Recurse children before adding self — preserves dispatch order.'),
        _stepLine('3', Colors.amber,
            'Use HitTestEntry(this) so handleEvent is invoked during dispatch.'),
        _stepLine('4', Colors.pinkAccent,
            'For transformed children, prefer BoxHitTestResult.addWithPaintTransform.'),
      ],
    ),
  );
}

Widget _stepLine(String n, Color color, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22.0,
          height: 22.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Text(
            n,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.white70, fontSize: 12.5),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7: Worked example — z-stacked widgets with a pointer dot
// ---------------------------------------------------------------------------
Widget _buildZStackExample() {
  // We draw a faux scene with three z-stacked rectangles A (back), B
  // (middle), C (front), plus a pointer dot inside C. We then list the
  // resulting hit-test entries in dispatch order.
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.blue.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.15),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.touch_app, color: Colors.blueGrey.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'A pointer drops at (180, 120)',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Center(
          child: Container(
            width: 320.0,
            height: 220.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.grey.shade400, width: 1.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.10),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Stack(
              children: [
                // A — back layer
                Positioned(
                  left: 30.0,
                  top: 30.0,
                  width: 260.0,
                  height: 160.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple.shade300, Colors.purple.shade100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withValues(alpha: 0.3),
                          blurRadius: 6.0,
                          offset: Offset(0.0, 3.0),
                        ),
                      ],
                    ),
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      'A — RenderStack',
                      style: TextStyle(
                        color: Colors.purple.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                // B — middle layer
                Positioned(
                  left: 90.0,
                  top: 70.0,
                  width: 180.0,
                  height: 100.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal.shade300, Colors.teal.shade100],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withValues(alpha: 0.3),
                          blurRadius: 6.0,
                          offset: Offset(0.0, 3.0),
                        ),
                      ],
                    ),
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      'B — RenderPadding',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                // C — front layer
                Positioned(
                  left: 140.0,
                  top: 95.0,
                  width: 90.0,
                  height: 60.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.orange.shade400, Colors.orange.shade200],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withValues(alpha: 0.45),
                          blurRadius: 6.0,
                          offset: Offset(0.0, 3.0),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'C — RenderText',
                      style: TextStyle(
                        color: Colors.brown.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                ),
                // Pointer dot at (180, 120) within the 320x220 canvas
                Positioned(
                  left: 174.0,
                  top: 114.0,
                  child: Container(
                    width: 14.0,
                    height: 14.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                      border: Border.all(color: Colors.white, width: 2.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withValues(alpha: 0.6),
                          blurRadius: 8.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 18.0),
        Text(
          'Resulting HitTestResult.path (innermost first):',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey.shade900,
          ),
        ),
        SizedBox(height: 8.0),
        _zStackEntry(1, Colors.orange, 'C — RenderText',
            'Smallest box that still contains the pointer; added first.'),
        _zStackEntry(2, Colors.teal, 'B — RenderPadding',
            'Parent of C; contains the pointer; added after recursion returns.'),
        _zStackEntry(3, Colors.purple, 'A — RenderStack',
            'Root of the stack; outermost; added last.'),
        _zStackEntry(4, Colors.indigo, 'RenderView',
            'Always at the tail — the root render object.'),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade900,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            '// dispatchEvent walks path and calls handleEvent in order:\n'
            '//   C.handleEvent  -> B.handleEvent  -> A.handleEvent  -> RenderView.handleEvent\n'
            '// Listener / GestureDetector hooks read entries during this walk.',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.cyanAccent.shade100,
              fontSize: 11.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _zStackEntry(int order, Color color, String name, String note) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #21, P5(a)):
  // Border(left: 4, top/right/bottom: 1) with borderRadius is rejected
  // by the bridged painter ("uniform-colors"). Render the rounded card
  // via ClipRRect > IntrinsicHeight > Row with the left accent as a
  // sibling Container (width: 4) and a uniform Border.all on the body.
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(width: 4.0, color: color),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200, width: 1.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24.0,
                      height: 24.0,
                      alignment: Alignment.center,
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle),
                      child: Text(
                        '$order',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: color,
                              fontSize: 13.0,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            note,
                            style: TextStyle(
                                fontSize: 11.5,
                                color: Colors.grey.shade700),
                          ),
                        ],
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
  );
}

// ---------------------------------------------------------------------------
// SECTION 8: Pitfalls
// ---------------------------------------------------------------------------
Widget _buildPitfallsPanel() {
  final pits = <_Pit>[
    _Pit(
      title: 'Forgetting to add yourself to the result',
      detail:
          'If your hitTest returns without ever calling result.add, then '
          'handleEvent will never fire on this object. Easy to miss when a '
          'short-circuit return path is added.',
      icon: Icons.error,
      color: Colors.red,
    ),
    _Pit(
      title: 'Adding self before recursing into children',
      detail:
          'Reverses dispatch order — your object will receive the pointer '
          'before the inner widget that visually owns it. Always recurse '
          'first, then add self.',
      icon: Icons.swap_calls,
      color: Colors.deepOrange,
    ),
    _Pit(
      title: 'Ignoring transforms',
      detail:
          'A child painted via Transform.scale or RotatedBox needs '
          'BoxHitTestResult.addWithPaintTransform; otherwise the position '
          'you forward is in the wrong coordinate space.',
      icon: Icons.threed_rotation,
      color: Colors.purple,
    ),
    _Pit(
      title: 'Overlay rendering vs hit-testing',
      detail:
          'Painting on top with a translucent layer does not automatically '
          'put it into the hit-test path — your render object still has to '
          'participate. IgnorePointer / AbsorbPointer flip the behaviour '
          'explicitly.',
      icon: Icons.layers_clear,
      color: Colors.indigo,
    ),
    _Pit(
      title: 'Mutating result.path during iteration',
      detail:
          'HitTestResult.path is a live view. Iterating it while another '
          'HitTestable adds entries leads to ConcurrentModification.',
      icon: Icons.sync_problem,
      color: Colors.brown,
    ),
    _Pit(
      title: 'Calling dispatchEvent yourself',
      detail:
          'GestureBinding.instance.dispatchEvent is the supported entry; '
          'rolling a custom dispatcher bypasses gesture arenas, mouse '
          'tracking, and platform-view routing.',
      icon: Icons.do_disturb_on,
      color: Colors.pink,
    ),
  ];

  return Column(
    children: pits.map(_pitCard).toList(),
  );
}

class _Pit {
  _Pit({
    required this.title,
    required this.detail,
    required this.icon,
    required this.color,
  });
  final String title;
  final String detail;
  final IconData icon;
  final Color color;
}

Widget _pitCard(_Pit pit) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          pit.color.withValues(alpha: 0.12),
          Colors.white,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: pit.color.withValues(alpha: 0.5), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: pit.color.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: pit.color.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: Icon(pit.icon, color: pit.color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pit.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: pit.color,
                  fontSize: 13.5,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                pit.detail,
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9: Footer with file path inside an ASCII box
// ---------------------------------------------------------------------------
Widget _buildFooter() {
  const path =
      'tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/'
      'send_ast_via_http_scripts/gestures/hit_testable_test.dart';
  final box =
      '+----------------------------------------------------------------+\n'
      '|  HitTestable Deep Demo                                         |\n'
      '|  package:flutter/gestures.dart                                 |\n'
      '|                                                                |\n'
      '|  $path  |\n'
      '+----------------------------------------------------------------+';
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flag, color: Colors.greenAccent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'End of demo',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          box,
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.cyanAccent.shade100,
            fontSize: 11.0,
            height: 1.25,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Static visualisation only. No live pointers, no dispatch, '
          'no listeners. Read this alongside RendererBinding.hitTest and '
          'RenderBox.hitTest for the real implementations.',
          style: TextStyle(color: Colors.white60, fontSize: 11.5),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------
Widget _sectionTitle(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10.0, left: 4.0),
    child: Row(
      children: [
        Container(
          width: 6.0,
          height: 22.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.indigo],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _bulletLine(IconData icon, Color color, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
  );
}

Widget _codeCard(String code, {required Color accent, bool dark = false}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: dark ? Color(0xFF0B0B12) : Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: accent,
        height: 1.35,
      ),
    ),
  );
}

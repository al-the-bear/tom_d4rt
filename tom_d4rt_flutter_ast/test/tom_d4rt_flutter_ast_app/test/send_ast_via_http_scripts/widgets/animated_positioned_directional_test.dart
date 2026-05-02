// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// AnimatedPositionedDirectional — Deep Demo
// =============================================================================
//
// AnimatedPositionedDirectional is the directional sibling of
// AnimatedPositioned. While AnimatedPositioned uses physical edges (`left` and
// `right`), AnimatedPositionedDirectional uses logical edges (`start` and
// `end`). Those edges are resolved against the inherited Directionality:
//
//   - In TextDirection.ltr, `start` maps to the left edge and `end` maps to
//     the right edge.
//   - In TextDirection.rtl, `start` maps to the right edge and `end` maps to
//     the left edge.
//
// The widget therefore auto-mirrors its children when the surrounding
// Directionality flips, which is essential for internationalised Flutter apps
// that ship in both LTR (English, German, French...) and RTL (Arabic, Hebrew,
// Persian...) locales.
//
// Like AnimatedPositioned, AnimatedPositionedDirectional may only sit as a
// direct child of a Stack, and it implicitly animates between values whenever
// its `start`, `end`, `top`, `bottom`, `width`, or `height` change.
//
// This demo is intentionally hand-authored and verbose. It covers:
//
//   1.  Intro / explanation with an ASCII diagram for LTR vs RTL.
//   2.  Live LTR slide demo.
//   3.  Live RTL slide demo (same animation, mirrored).
//   4.  Side-by-side LTR / RTL comparison.
//   5.  Complex multi-card scene with staggered animations.
//   6.  start / end / top / bottom matrix with a "compact" toggle.
//   7.  width / height morph (docked -> fullscreen).
//   8.  AnimatedPositioned vs AnimatedPositionedDirectional comparison.
//   9.  Toggleable Directionality (SegmentedButton LTR / RTL).
//   10. Real-world recipe: drawer-like reveal.
//   11. Real-world recipe: notification badge anchoring.
//   12. Reference table.
//
// =============================================================================

dynamic build(BuildContext context) {
  print('=== AnimatedPositionedDirectional Deep Demo ===');
  print('Sections: intro, ltr, rtl, side-by-side, scene, matrix,');
  print('size morph, vs AnimatedPositioned, toggle direction, drawer,');
  print('badge, reference table.');

  return MaterialApp(
    title: 'AnimatedPositionedDirectional Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorSchemeSeed: Colors.indigo,
      useMaterial3: true,
      brightness: Brightness.light,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedPositionedDirectional Deep Demo'),
        backgroundColor: Colors.indigo.shade50,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _Section1Intro(),
              SizedBox(height: 24),
              _Section2LtrLive(),
              SizedBox(height: 24),
              _Section3RtlLive(),
              SizedBox(height: 24),
              _Section4SideBySide(),
              SizedBox(height: 24),
              _Section5CardsScene(),
              SizedBox(height: 24),
              _Section6Matrix(),
              SizedBox(height: 24),
              _Section7SizeMorph(),
              SizedBox(height: 24),
              _Section8VsLeftRight(),
              SizedBox(height: 24),
              _Section9ToggleDirection(),
              SizedBox(height: 24),
              _Section10DrawerReveal(),
              SizedBox(height: 24),
              _Section11BadgeAnchor(),
              SizedBox(height: 24),
              _Section12ReferenceTable(),
              SizedBox(height: 32),
              _FooterNote(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Common visual helpers
// =============================================================================

/// A simple section header used at the top of every demo block. Keeps the
/// typography consistent without relying on a Theme override per-section.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
  });

  final int index;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '$index',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A small pill-style label used inside the demos to annotate things.
class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    this.color = Colors.indigo,
  });

  final MaterialColor color;

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        border: Border.all(color: color.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color.shade900,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// A boxed caption used under each interactive demo to summarise behaviour.
class _Caption extends StatelessWidget {
  const _Caption(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        border: Border.all(color: Colors.amber.shade200),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12.5, height: 1.35),
      ),
    );
  }
}

/// A simple card-shaped widget used inside Stacks for the demos. The colour
/// is configurable so that multiple cards in the same Stack can be told apart.
class _DemoCard extends StatelessWidget {
  const _DemoCard({
    required this.label,
    required this.color,
    this.width = 96,
    this.height = 64,
  });

  final String label;
  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

/// Stage area used to host a Stack demo. Provides a fixed-size dashed
/// background so the user can reason about positions visually.
class _Stage extends StatelessWidget {
  const _Stage({
    required this.child,
    this.height = 180,
    this.label,
  });

  final Widget child;
  final double height;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        border: Border.all(color: Colors.indigo.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: <Widget>[
          if (label != null)
            Positioned(
              left: 6,
              top: 4,
              child: Text(
                label!,
                style: TextStyle(
                  color: Colors.indigo.shade400,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 1 — Intro
// =============================================================================

class _Section1Intro extends StatelessWidget {
  const _Section1Intro();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: 1,
          title: 'Intro: start vs left',
          subtitle:
              'AnimatedPositionedDirectional uses logical edges that flip with Directionality.',
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'AnimatedPositioned takes physical anchors (left, right). Those\n'
            'do not change when the surrounding Directionality flips, which is\n'
            'a problem for RTL-aware UIs.\n\n'
            'AnimatedPositionedDirectional swaps `left` and `right` for `start`\n'
            'and `end`. They are resolved at layout time against the inherited\n'
            'Directionality. The animation logic is identical, only the edge\n'
            'naming and resolution rules differ.',
            style: TextStyle(fontSize: 13.5, height: 1.4),
          ),
        ),
        const SizedBox(height: 12),
        // ASCII-style diagram contrasting LTR vs RTL.
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const DefaultTextStyle(
            style: TextStyle(
              color: Colors.greenAccent,
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.35,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('LTR — TextDirection.ltr'),
                Text('  start ────────────►          ◄──────────── end'),
                Text('  +-----------------------------------------+'),
                Text('  | [card]                                  |'),
                Text('  +-----------------------------------------+'),
                SizedBox(height: 8),
                Text('RTL — TextDirection.rtl'),
                Text('  end ──────────────►          ◄────────── start'),
                Text('  +-----------------------------------------+'),
                Text('  |                                  [card] |'),
                Text('  +-----------------------------------------+'),
                SizedBox(height: 8),
                Text('Same widget tree. Same `start: 12`. Mirrored render.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: const <Widget>[
            _Pill(label: 'Stack child only', color: Colors.indigo),
            _Pill(label: 'Implicit animation', color: Colors.teal),
            _Pill(label: 'Locale-aware', color: Colors.deepOrange),
            _Pill(label: 'Material 3 friendly', color: Colors.pink),
          ],
        ),
        const SizedBox(height: 12),
        const _Caption(
          'Heuristic: every time you would reach for AnimatedPositioned with\n'
          '`left` or `right`, prefer AnimatedPositionedDirectional with\n'
          '`start` / `end` unless you genuinely need physical edges.',
        ),
      ],
    );
  }
}

// =============================================================================
// Section 2 — Live LTR demo
// =============================================================================

class _Section2LtrLive extends StatelessWidget {
  const _Section2LtrLive();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _SectionHeader(
          index: 2,
          title: 'Live LTR slide',
          subtitle:
              'Toggle `start` / `end` in a single AnimatedPositionedDirectional.',
        ),
        SizedBox(height: 12),
        _LtrSlideDemo(),
        SizedBox(height: 8),
        _Caption(
          'Tap the button. The card animates between (start: 12, top: 12)\n'
          'and (end: 12, top: 12). Duration 600 ms, Curves.easeOutCubic.',
        ),
      ],
    );
  }
}

class _LtrSlideDemo extends StatefulWidget {
  const _LtrSlideDemo();

  @override
  State<_LtrSlideDemo> createState() => _LtrSlideDemoState();
}

class _LtrSlideDemoState extends State<_LtrSlideDemo> {
  bool _atStart = true;
  int _toggleCount = 0;

  void _toggle() {
    setState(() {
      _atStart = !_atStart;
      _toggleCount += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _Stage(
          label: 'LTR stage',
          child: Stack(
            children: <Widget>[
              AnimatedPositionedDirectional(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                start: _atStart ? 12 : null,
                end: _atStart ? null : 12,
                top: 12,
                child: const _DemoCard(
                  label: 'LTR\nCard',
                  color: Colors.indigo,
                ),
              ),
              const Positioned(
                left: 8,
                bottom: 8,
                child: Text(
                  'Directionality: ltr (default)',
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: _toggle,
              icon: const Icon(Icons.swap_horiz),
              label: Text(_atStart ? 'Slide to end' : 'Slide to start'),
            ),
            const SizedBox(width: 12),
            Text('Toggles: $_toggleCount'),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// Section 3 — Live RTL demo
// =============================================================================

class _Section3RtlLive extends StatelessWidget {
  const _Section3RtlLive();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _SectionHeader(
          index: 3,
          title: 'Live RTL slide',
          subtitle:
              'Same widget code as section 2, wrapped in Directionality.rtl.',
        ),
        SizedBox(height: 12),
        _RtlSlideDemo(),
        SizedBox(height: 8),
        _Caption(
          'The exact same AnimatedPositionedDirectional configuration is\n'
          'wrapped in `Directionality(textDirection: TextDirection.rtl)`.\n'
          'Notice how `start` is now the right edge.',
        ),
      ],
    );
  }
}

class _RtlSlideDemo extends StatefulWidget {
  const _RtlSlideDemo();

  @override
  State<_RtlSlideDemo> createState() => _RtlSlideDemoState();
}

class _RtlSlideDemoState extends State<_RtlSlideDemo> {
  bool _atStart = true;
  int _toggleCount = 0;

  void _toggle() {
    setState(() {
      _atStart = !_atStart;
      _toggleCount += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Directionality(
          textDirection: TextDirection.rtl,
          child: _Stage(
            label: 'RTL stage',
            child: Stack(
              children: <Widget>[
                AnimatedPositionedDirectional(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  start: _atStart ? 12 : null,
                  end: _atStart ? null : 12,
                  top: 12,
                  child: const _DemoCard(
                    label: 'RTL\nCard',
                    color: Colors.deepOrange,
                  ),
                ),
                const Positioned(
                  left: 8,
                  bottom: 8,
                  child: Text(
                    'Directionality: rtl',
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: _toggle,
              icon: const Icon(Icons.swap_horiz),
              label: Text(_atStart ? 'Slide to end' : 'Slide to start'),
            ),
            const SizedBox(width: 12),
            Text('Toggles: $_toggleCount'),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// Section 4 — Side-by-side LTR vs RTL
// =============================================================================

class _Section4SideBySide extends StatelessWidget {
  const _Section4SideBySide();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _SectionHeader(
          index: 4,
          title: 'Side-by-side LTR vs RTL',
          subtitle:
              'A single shared toggle drives both stages simultaneously.',
        ),
        SizedBox(height: 12),
        _LtrVsRtlDemo(),
        SizedBox(height: 8),
        _Caption(
          'Both stacks use the same AnimatedPositionedDirectional config.\n'
          'Only the surrounding Directionality differs. Compare the motion.',
        ),
      ],
    );
  }
}

class _LtrVsRtlDemo extends StatefulWidget {
  const _LtrVsRtlDemo();

  @override
  State<_LtrVsRtlDemo> createState() => _LtrVsRtlDemoState();
}

class _LtrVsRtlDemoState extends State<_LtrVsRtlDemo> {
  bool _atStart = true;

  void _toggle() => setState(() => _atStart = !_atStart);

  Widget _buildStage(TextDirection dir, Color color, String label) {
    return Directionality(
      textDirection: dir,
      child: _Stage(
        label: label,
        child: Stack(
          children: <Widget>[
            AnimatedPositionedDirectional(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOutCubic,
              start: _atStart ? 12 : null,
              end: _atStart ? null : 12,
              top: 16,
              child: _DemoCard(
                label: label,
                color: color,
                width: 88,
                height: 56,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _buildStage(
                TextDirection.ltr,
                Colors.indigo,
                'LTR',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildStage(
                TextDirection.rtl,
                Colors.deepOrange,
                'RTL',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: _toggle,
              icon: const Icon(Icons.compare_arrows),
              label: Text(_atStart ? 'Move both to end' : 'Move both to start'),
            ),
            const SizedBox(width: 12),
            Text(
              'State: ${_atStart ? "start anchored" : "end anchored"}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// Section 5 — Multi-card scene
// =============================================================================

class _Section5CardsScene extends StatelessWidget {
  const _Section5CardsScene();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _SectionHeader(
          index: 5,
          title: 'Multi-card scene',
          subtitle:
              'Four AnimatedPositionedDirectional cards shuffled with staggered curves.',
        ),
        SizedBox(height: 12),
        _CardsScene(),
        SizedBox(height: 8),
        _Caption(
          'Each card has its own duration and curve. Tap "Shuffle" to permute\n'
          'their `start` / `top` values; the staircase rebuilds itself.',
        ),
      ],
    );
  }
}

class _CardsScene extends StatefulWidget {
  const _CardsScene();

  @override
  State<_CardsScene> createState() => _CardsSceneState();
}

class _CardsSceneState extends State<_CardsScene> {
  // Four logical "slots" expressed as (start, top) pairs.
  static const List<List<double>> _slotsA = <List<double>>[
    <double>[8, 8],
    <double>[120, 8],
    <double>[8, 90],
    <double>[120, 90],
  ];

  static const List<List<double>> _slotsB = <List<double>>[
    <double>[120, 90],
    <double>[8, 90],
    <double>[120, 8],
    <double>[8, 8],
  ];

  bool _useA = true;
  int _shuffleCount = 0;

  void _shuffle() {
    setState(() {
      _useA = !_useA;
      _shuffleCount += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<List<double>> slots = _useA ? _slotsA : _slotsB;
    final List<Color> colors = <Color>[
      Colors.indigo,
      Colors.deepOrange,
      Colors.teal,
      Colors.purple,
    ];
    final List<Curve> curves = <Curve>[
      Curves.easeOutCubic,
      Curves.easeInOutCubic,
      Curves.elasticOut,
      Curves.bounceOut,
    ];
    final List<int> durationsMs = <int>[400, 600, 900, 1200];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _Stage(
          height: 200,
          label: 'Cards scene (LTR)',
          child: Stack(
            children: <Widget>[
              for (int i = 0; i < 4; i++)
                AnimatedPositionedDirectional(
                  key: ValueKey<int>(i),
                  duration: Duration(milliseconds: durationsMs[i]),
                  curve: curves[i],
                  start: slots[i][0],
                  top: slots[i][1],
                  child: _DemoCard(
                    label: 'Card ${i + 1}',
                    color: colors[i],
                    width: 88,
                    height: 56,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: _shuffle,
              icon: const Icon(Icons.shuffle),
              label: const Text('Shuffle'),
            ),
            const SizedBox(width: 12),
            Text('Shuffles: $_shuffleCount'),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// Section 6 — start/end/top/bottom matrix
// =============================================================================

class _Section6Matrix extends StatelessWidget {
  const _Section6Matrix();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _SectionHeader(
          index: 6,
          title: 'start / end / top / bottom matrix',
          subtitle:
              'Four cards anchored to all four logical corners; "Compact" recentres them.',
        ),
        SizedBox(height: 12),
        _MatrixDemo(),
        SizedBox(height: 8),
        _Caption(
          'The four anchor combinations cover every logical corner. Toggle\n'
          'compact mode to animate them all to a centre cluster.',
        ),
      ],
    );
  }
}

class _MatrixDemo extends StatefulWidget {
  const _MatrixDemo();

  @override
  State<_MatrixDemo> createState() => _MatrixDemoState();
}

class _MatrixDemoState extends State<_MatrixDemo> {
  bool _compact = false;

  void _toggle() => setState(() => _compact = !_compact);

  @override
  Widget build(BuildContext context) {
    const Duration duration = Duration(milliseconds: 700);
    const Curve curve = Curves.easeInOutCubic;

    // In compact mode all cards converge near the centre. We approximate the
    // centre cluster using fixed offsets relative to the stage size.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _Stage(
          height: 220,
          label: 'Anchors matrix',
          child: Stack(
            children: <Widget>[
              // start + top
              AnimatedPositionedDirectional(
                duration: duration,
                curve: curve,
                start: _compact ? 110 : 12,
                top: _compact ? 80 : 12,
                child: const _DemoCard(
                  label: 'start\n+top',
                  color: Colors.indigo,
                  width: 80,
                  height: 50,
                ),
              ),
              // end + top
              AnimatedPositionedDirectional(
                duration: duration,
                curve: curve,
                end: _compact ? 110 : 12,
                top: _compact ? 80 : 12,
                child: const _DemoCard(
                  label: 'end\n+top',
                  color: Colors.deepOrange,
                  width: 80,
                  height: 50,
                ),
              ),
              // start + bottom
              AnimatedPositionedDirectional(
                duration: duration,
                curve: curve,
                start: _compact ? 110 : 12,
                bottom: _compact ? 80 : 12,
                child: const _DemoCard(
                  label: 'start\n+bottom',
                  color: Colors.teal,
                  width: 80,
                  height: 50,
                ),
              ),
              // end + bottom
              AnimatedPositionedDirectional(
                duration: duration,
                curve: curve,
                end: _compact ? 110 : 12,
                bottom: _compact ? 80 : 12,
                child: const _DemoCard(
                  label: 'end\n+bottom',
                  color: Colors.purple,
                  width: 80,
                  height: 50,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            FilledButton.icon(
              onPressed: _toggle,
              icon: Icon(
                _compact ? Icons.open_in_full : Icons.close_fullscreen,
              ),
              label: Text(_compact ? 'Expand' : 'Compact'),
            ),
            const SizedBox(width: 12),
            Text(
              'Mode: ${_compact ? "compact cluster" : "corners"}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// Section 7 — width / height morph
// =============================================================================

class _Section7SizeMorph extends StatelessWidget {
  const _Section7SizeMorph();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _SectionHeader(
          index: 7,
          title: 'width / height morph',
          subtitle:
              'Animate position and size together: docked card -> fullscreen cover.',
        ),
        SizedBox(height: 12),
        _SizeMorphDemo(),
        SizedBox(height: 8),
        _Caption(
          'AnimatedPositionedDirectional can also animate width/height.\n'
          'Tap the button to morph the docked card into a fullscreen cover\n'
          'within the stage and back.',
        ),
      ],
    );
  }
}

class _SizeMorphDemo extends StatefulWidget {
  const _SizeMorphDemo();

  @override
  State<_SizeMorphDemo> createState() => _SizeMorphDemoState();
}

class _SizeMorphDemoState extends State<_SizeMorphDemo> {
  bool _expanded = false;

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints c) {
            final double maxWidth = c.maxWidth;
            const double stageHeight = 220;
            final double smallW = 120;
            final double smallH = 64;
            final double bigW = maxWidth - 16; // leaves an 8 px margin
            final double bigH = stageHeight - 16;

            return _Stage(
              height: stageHeight,
              label: 'Docked -> fullscreen morph',
              child: Stack(
                children: <Widget>[
                  AnimatedPositionedDirectional(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeInOutCubic,
                    start: _expanded ? 8 : 12,
                    top: _expanded ? 8 : 12,
                    width: _expanded ? bigW : smallW,
                    height: _expanded ? bigH : smallH,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Colors.indigo.shade700,
                            Colors.purple.shade400,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _expanded ? 'FULLSCREEN' : 'docked',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            FilledButton.icon(
              onPressed: _toggle,
              icon: Icon(
                _expanded ? Icons.fullscreen_exit : Icons.fullscreen,
              ),
              label: Text(_expanded ? 'Dock' : 'Expand'),
            ),
            const SizedBox(width: 12),
            Text(
              'State: ${_expanded ? "expanded" : "docked"}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// Section 8 — AnimatedPositioned vs AnimatedPositionedDirectional
// =============================================================================

class _Section8VsLeftRight extends StatelessWidget {
  const _Section8VsLeftRight();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _SectionHeader(
          index: 8,
          title: 'AnimatedPositioned vs AnimatedPositionedDirectional',
          subtitle:
              'Identical setup; toggle Directionality to see them diverge.',
        ),
        SizedBox(height: 12),
        _VsLeftRight(),
        SizedBox(height: 8),
        _Caption(
          'In LTR both cards land at the same position. In RTL the\n'
          'AnimatedPositioned card sticks to the physical left while the\n'
          'AnimatedPositionedDirectional card flips to the right.',
        ),
      ],
    );
  }
}

class _VsLeftRight extends StatefulWidget {
  const _VsLeftRight();

  @override
  State<_VsLeftRight> createState() => _VsLeftRightState();
}

class _VsLeftRightState extends State<_VsLeftRight> {
  bool _rtl = false;
  bool _atStart = true;

  void _toggleDir() => setState(() => _rtl = !_rtl);
  void _toggleAnchor() => setState(() => _atStart = !_atStart);

  @override
  Widget build(BuildContext context) {
    final TextDirection dir = _rtl ? TextDirection.rtl : TextDirection.ltr;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Directionality(
          textDirection: dir,
          child: Row(
            children: <Widget>[
              Expanded(
                child: _Stage(
                  label: 'AnimatedPositioned (left/right)',
                  child: Stack(
                    children: <Widget>[
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOutCubic,
                        left: _atStart ? 12 : null,
                        right: _atStart ? null : 12,
                        top: 16,
                        child: const _DemoCard(
                          label: 'left/right',
                          color: Colors.indigo,
                          width: 96,
                          height: 56,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _Stage(
                  label: 'AnimatedPositionedDirectional (start/end)',
                  child: Stack(
                    children: <Widget>[
                      AnimatedPositionedDirectional(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOutCubic,
                        start: _atStart ? 12 : null,
                        end: _atStart ? null : 12,
                        top: 16,
                        child: const _DemoCard(
                          label: 'start/end',
                          color: Colors.teal,
                          width: 96,
                          height: 56,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: _toggleDir,
              icon: const Icon(Icons.translate),
              label: Text(_rtl ? 'Switch to LTR' : 'Switch to RTL'),
            ),
            ElevatedButton.icon(
              onPressed: _toggleAnchor,
              icon: const Icon(Icons.swap_horiz),
              label: Text(_atStart ? 'Anchor end' : 'Anchor start'),
            ),
            Text(
              'dir: ${_rtl ? "rtl" : "ltr"} | anchor: '
              '${_atStart ? "start" : "end"}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// Section 9 — Toggleable Directionality
// =============================================================================

class _Section9ToggleDirection extends StatelessWidget {
  const _Section9ToggleDirection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _SectionHeader(
          index: 9,
          title: 'Toggleable Directionality',
          subtitle:
              'A SegmentedButton picks LTR / RTL; the Stack re-runs the animation.',
        ),
        SizedBox(height: 12),
        _ToggleDirectionDemo(),
        SizedBox(height: 8),
        _Caption(
          'Rebuilding with a different inherited Directionality re-resolves\n'
          'start/end and animates the card to its new physical position.',
        ),
      ],
    );
  }
}

class _ToggleDirectionDemo extends StatefulWidget {
  const _ToggleDirectionDemo();

  @override
  State<_ToggleDirectionDemo> createState() => _ToggleDirectionDemoState();
}

class _ToggleDirectionDemoState extends State<_ToggleDirectionDemo> {
  TextDirection _dir = TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SegmentedButton<TextDirection>(
          segments: const <ButtonSegment<TextDirection>>[
            ButtonSegment<TextDirection>(
              value: TextDirection.ltr,
              label: Text('LTR'),
              icon: Icon(Icons.format_textdirection_l_to_r),
            ),
            ButtonSegment<TextDirection>(
              value: TextDirection.rtl,
              label: Text('RTL'),
              icon: Icon(Icons.format_textdirection_r_to_l),
            ),
          ],
          selected: <TextDirection>{_dir},
          onSelectionChanged: (Set<TextDirection> selection) {
            setState(() => _dir = selection.first);
          },
        ),
        const SizedBox(height: 8),
        Directionality(
          textDirection: _dir,
          child: _Stage(
            label: 'Live Directionality',
            child: Stack(
              children: <Widget>[
                AnimatedPositionedDirectional(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  start: 24,
                  top: 24,
                  child: _DemoCard(
                    label: _dir == TextDirection.ltr ? 'LTR' : 'RTL',
                    color: _dir == TextDirection.ltr
                        ? Colors.indigo
                        : Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Current direction: $_dir',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

// =============================================================================
// Section 10 — Drawer-like reveal
// =============================================================================

class _Section10DrawerReveal extends StatelessWidget {
  const _Section10DrawerReveal();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _SectionHeader(
          index: 10,
          title: 'Recipe: drawer-like reveal',
          subtitle:
              'A panel slides in from start: -240 to start: 0 — auto-mirrored under RTL.',
        ),
        SizedBox(height: 12),
        _DrawerRevealDemo(),
        SizedBox(height: 8),
        _Caption(
          'In a typical app you would conditionally render the scrim plus\n'
          'this AnimatedPositionedDirectional. Here we keep the scrim\n'
          'visible for clarity. RTL flips the open/close direction for free.',
        ),
      ],
    );
  }
}

class _DrawerRevealDemo extends StatefulWidget {
  const _DrawerRevealDemo();

  @override
  State<_DrawerRevealDemo> createState() => _DrawerRevealDemoState();
}

class _DrawerRevealDemoState extends State<_DrawerRevealDemo> {
  bool _open = false;
  bool _rtl = false;

  void _toggleDrawer() => setState(() => _open = !_open);
  void _toggleDir() => setState(() => _rtl = !_rtl);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Directionality(
          textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
          child: _Stage(
            height: 220,
            label: 'Drawer scene',
            child: Stack(
              children: <Widget>[
                // Underlying "page" content.
                Positioned.fill(
                  child: Container(
                    color: Colors.indigo.shade50,
                    alignment: Alignment.center,
                    child: const Text(
                      'Page content\n(behind the drawer)',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                // Animated drawer panel using start.
                AnimatedPositionedDirectional(
                  duration: const Duration(milliseconds: 450),
                  curve: Curves.easeOutCubic,
                  start: _open ? 0 : -240,
                  top: 0,
                  bottom: 0,
                  width: 240,
                  child: Container(
                    color: Colors.indigo.shade700,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'Drawer',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Inbox',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Sent',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Drafts',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            FilledButton.icon(
              onPressed: _toggleDrawer,
              icon: Icon(_open ? Icons.menu_open : Icons.menu),
              label: Text(_open ? 'Close drawer' : 'Open drawer'),
            ),
            ElevatedButton.icon(
              onPressed: _toggleDir,
              icon: const Icon(Icons.translate),
              label: Text(_rtl ? 'LTR' : 'RTL'),
            ),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// Section 11 — Notification badge anchoring
// =============================================================================

class _Section11BadgeAnchor extends StatelessWidget {
  const _Section11BadgeAnchor();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _SectionHeader(
          index: 11,
          title: 'Recipe: notification badge anchoring',
          subtitle:
              'A small badge animates into the end-top corner of a card.',
        ),
        SizedBox(height: 12),
        _BadgeAnchorDemo(),
        SizedBox(height: 8),
        _Caption(
          'The badge starts off-card and animates to (end: 4, top: 4) when\n'
          'a new notification "appears". Under RTL it flips to the start side\n'
          'automatically.',
        ),
      ],
    );
  }
}

class _BadgeAnchorDemo extends StatefulWidget {
  const _BadgeAnchorDemo();

  @override
  State<_BadgeAnchorDemo> createState() => _BadgeAnchorDemoState();
}

class _BadgeAnchorDemoState extends State<_BadgeAnchorDemo> {
  bool _hasBadge = false;
  bool _rtl = false;
  int _badgeCount = 0;

  void _spawnBadge() {
    setState(() {
      _hasBadge = true;
      _badgeCount += 1;
    });
  }

  void _clearBadge() {
    setState(() {
      _hasBadge = false;
    });
  }

  void _toggleDir() => setState(() => _rtl = !_rtl);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Directionality(
          textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
          child: _Stage(
            height: 200,
            label: 'Card + badge',
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          const Center(
                            child: Text(
                              'Notification\nhost card',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          AnimatedPositionedDirectional(
                            duration: const Duration(milliseconds: 450),
                            curve: Curves.easeOutBack,
                            end: _hasBadge ? 4 : -28,
                            top: _hasBadge ? 4 : -28,
                            width: 22,
                            height: 22,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$_badgeCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            FilledButton.icon(
              onPressed: _spawnBadge,
              icon: const Icon(Icons.notifications_active),
              label: const Text('New notification'),
            ),
            OutlinedButton.icon(
              onPressed: _clearBadge,
              icon: const Icon(Icons.notifications_off),
              label: const Text('Clear badge'),
            ),
            ElevatedButton.icon(
              onPressed: _toggleDir,
              icon: const Icon(Icons.translate),
              label: Text(_rtl ? 'LTR' : 'RTL'),
            ),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// Section 12 — Reference table
// =============================================================================

class _Section12ReferenceTable extends StatelessWidget {
  const _Section12ReferenceTable();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeader(
          index: 12,
          title: 'Reference',
          subtitle:
              'Properties of AnimatedPositionedDirectional and adjacent widgets.',
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.hardEdge,
          child: const Column(
            children: <Widget>[
              _RefRow(
                label: 'start',
                value:
                    'Distance from the leading edge (left in LTR, right in RTL).',
                isHeader: false,
              ),
              _RefRow(
                label: 'end',
                value:
                    'Distance from the trailing edge (right in LTR, left in RTL).',
                isHeader: false,
              ),
              _RefRow(
                label: 'top',
                value: 'Distance from the top edge (unchanged by Directionality).',
                isHeader: false,
              ),
              _RefRow(
                label: 'bottom',
                value:
                    'Distance from the bottom edge (unchanged by Directionality).',
                isHeader: false,
              ),
              _RefRow(
                label: 'width',
                value:
                    'Optional width. Animated alongside position when changed.',
                isHeader: false,
              ),
              _RefRow(
                label: 'height',
                value:
                    'Optional height. Animated alongside position when changed.',
                isHeader: false,
              ),
              _RefRow(
                label: 'duration',
                value: 'Required. Duration of every implicit animation.',
                isHeader: false,
              ),
              _RefRow(
                label: 'curve',
                value: 'Defaults to Curves.linear. Used for every property.',
                isHeader: false,
              ),
              _RefRow(
                label: 'onEnd',
                value: 'Optional callback triggered when an animation finishes.',
                isHeader: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Comparison with related widgets',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.hardEdge,
          child: const Column(
            children: <Widget>[
              _RefRow(
                label: 'Widget',
                value: 'Edges | Animated | Locale-aware',
                isHeader: true,
              ),
              _RefRow(
                label: 'AnimatedPositioned',
                value: 'left/right | yes | no',
                isHeader: false,
              ),
              _RefRow(
                label: 'AnimatedPositionedDirectional',
                value: 'start/end | yes | yes',
                isHeader: false,
              ),
              _RefRow(
                label: 'PositionedDirectional',
                value: 'start/end | no | yes',
                isHeader: false,
              ),
              _RefRow(
                label: 'Positioned',
                value: 'left/right | no | no',
                isHeader: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const _Caption(
          'Quick mental model: AnimatedPositionedDirectional is the\n'
          'intersection of "implicit animation" and "logical edges". The\n'
          'three sibling widgets above each drop one of those traits.',
        ),
      ],
    );
  }
}

class _RefRow extends StatelessWidget {
  const _RefRow({
    required this.label,
    required this.value,
    required this.isHeader,
  });

  final String label;
  final String value;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    final TextStyle labelStyle = TextStyle(
      fontWeight: isHeader ? FontWeight.bold : FontWeight.w600,
      color: isHeader ? Colors.indigo.shade900 : Colors.black87,
      fontFamily: 'monospace',
      fontSize: 12.5,
    );
    final TextStyle valueStyle = TextStyle(
      fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
      color: Colors.black87,
      fontSize: 12.5,
    );
    return Container(
      decoration: BoxDecoration(
        color: isHeader ? Colors.indigo.shade50 : Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 180,
            child: Text(label, style: labelStyle),
          ),
          Expanded(
            child: Text(value, style: valueStyle),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Footer
// =============================================================================

class _FooterNote extends StatelessWidget {
  const _FooterNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.indigo.shade100),
      ),
      child: const Text(
        'End of demo. Every section above uses real, live\n'
        'AnimatedPositionedDirectional widgets driven by setState. The\n'
        'patterns shown here cover the bulk of practical usage in real apps:\n'
        'sliding panels, anchored badges, multi-card scenes and locale-aware\n'
        'layouts.',
        style: TextStyle(fontSize: 12.5, height: 1.4),
      ),
    );
  }
}

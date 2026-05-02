// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// RenderAnimatedSizeState — Deep Demo (Hand-Authored)
// =============================================================================
//
// `RenderAnimatedSizeState` is a small enum nested inside the `rendering`
// library that backs the public `AnimatedSize` widget. The render object
// (`RenderAnimatedSize`) tracks four states while it watches its child:
//
//   * start    — Initial state. The render object has not yet seen a child.
//                As soon as the first layout pass completes, the state
//                transitions to `stable`.
//   * stable   — The child's intrinsic size has not changed since the last
//                completed animation. While `stable`, no animation is
//                actively driven.
//   * changed  — The child reported a new size during layout. The render
//                object kicks off a tween between the previous and new size.
//                When the tween completes, the state returns to `stable`.
//   * unstable — The child changed size *again* while a tween was in flight,
//                more than once in quick succession. To prevent visual
//                jitter, AnimatedSize gives up animating and snaps to the
//                latest size. State returns to `stable` only after the
//                child remains untouched for a frame.
//
// End users never set this enum directly. They observe its consequences
// through `AnimatedSize` (and by extension `AnimatedSwitcher`, certain
// `AnimatedCrossFade` codepaths, and any custom widget that builds on
// `RenderAnimatedSize`).
//
// This file exercises every state transition using the public API.
// =============================================================================

dynamic build(BuildContext context) {
  print('=== RenderAnimatedSizeState Deep Demo ===');
  print('Subject: enum RenderAnimatedSizeState (rendering library, Flutter 3.41.6)');
  print('Values: start, stable, changed, unstable');
  print('Public surface used: AnimatedSize, AnimatedSwitcher, SizeTransition');

  // All four enum values referenced as live data, used by Section 2 (chips),
  // Section 14 (DataTable), and various comparisons throughout.
  const allStates = <String>['start', 'stable', 'changed', 'unstable'];
  print('Enum values rendered live: $allStates');

  return MaterialApp(
    title: 'RenderAnimatedSizeState Deep Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorSchemeSeed: Colors.indigo,
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('RenderAnimatedSizeState'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _section1HeroIntro(),
              const SizedBox(height: 24),
              _section2EnumIdentity(),
              const SizedBox(height: 24),
              _section3BasicAnimatedSize(),
              const SizedBox(height: 24),
              _section4DurationShowcase(),
              const SizedBox(height: 24),
              _section5CurveGallery(),
              const SizedBox(height: 24),
              _section6ReverseCurve(),
              const SizedBox(height: 24),
              _section7StableVsChanged(),
              const SizedBox(height: 24),
              _section8UnstableDemo(),
              const SizedBox(height: 24),
              _section9CollapsibleCard(),
              const SizedBox(height: 24),
              _section10ListItemResize(),
              const SizedBox(height: 24),
              _section11AnimatedSwitcherCombo(),
              const SizedBox(height: 24),
              _section12DecisionCard(),
              const SizedBox(height: 24),
              _section13StateMachineVisualiser(),
              const SizedBox(height: 24),
              _section14ReferenceTable(),
              const SizedBox(height: 24),
              _section15Footer(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// Section 1 — Hero intro
// =============================================================================
// Palette: deep indigo / violet. Explains AnimatedSize's contract and
// shows the state machine via a dedicated CustomPainter.
// =============================================================================

Widget _section1HeroIntro() {
  return _SectionShell(
    title: '1. Hero intro — what AnimatedSize is for',
    subtitle: 'and when it gives up.',
    palette: const _Palette(
      background: Color(0xFFEDE7F6),
      border: Color(0xFF5E35B1),
      accent: Color(0xFF311B92),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AnimatedSize is the lightweight render-object-backed widget that '
          'smoothly tweens between sizes whenever its child reports a new '
          'intrinsic size. It is one of the simplest implicit animations: '
          'no controller, no Tween, no AnimationController.lifecycle to '
          'manage — you just hand it a child and a duration, and the render '
          'object (RenderAnimatedSize) does the rest.',
        ),
        const SizedBox(height: 12),
        const Text(
          'Internally the render object walks a four-state machine. The '
          'illustration below shows each transition. The starting state is '
          '"start"; once layout sees the first child, it moves to "stable". '
          'When the child changes, the render object enters "changed" and '
          'tweens. If the child changes too rapidly, AnimatedSize protects '
          'the user from jitter by entering "unstable" — animations are '
          'bypassed until the child settles down again.',
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 220,
          child: CustomPaint(
            painter: _StateMachineDiagramPainter(),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Diagram legend: arrows show transitions. start→stable is a one-way '
          'door (a render object never returns to "start"). stable↔changed '
          'is the normal animation loop. changed→unstable is the bail-out '
          'path triggered by repeated mid-animation child resizes.',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 2 — Enum identity
// =============================================================================
// Every value as a Chip, with index and toString().
// =============================================================================

Widget _section2EnumIdentity() {
  // Mirror of dart:ui's hidden enum so we can iterate over all four values
  // for display. The actual enum lives at:
  //   package:flutter/src/rendering/animated_size.dart
  const labels = <String>['start', 'stable', 'changed', 'unstable'];
  const semantics = <String>[
    'Initial — render object has no child yet.',
    'Stable — child size unchanged since last frame.',
    'Changed — child resized; tween in flight.',
    'Unstable — child resized too often; tween disabled.',
  ];

  return _SectionShell(
    title: '2. Enum identity — all four values, live',
    subtitle: 'index, toString(), and semantic.',
    palette: const _Palette(
      background: Color(0xFFE3F2FD),
      border: Color(0xFF1565C0),
      accent: Color(0xFF0D47A1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'The enum is declared as `enum RenderAnimatedSizeState { start, '
          'stable, changed, unstable }`. The order matters — `index` is the '
          'declaration order and is what the SDK stores in private fields '
          'when serializing diagnostics.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var i = 0; i < labels.length; i++)
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: _stateColor(labels[i]),
                  foregroundColor: Colors.white,
                  child: Text('$i'),
                ),
                label: Text('RenderAnimatedSizeState.${labels[i]}'),
                backgroundColor: Colors.white,
                side: BorderSide(color: _stateColor(labels[i])),
              ),
          ],
        ),
        const SizedBox(height: 16),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF1565C0)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < labels.length; i++) ...[
                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: _stateColor(labels[i]),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '#${i.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'RenderAnimatedSizeState.${labels[i]}',
                        style: const TextStyle(fontFamily: 'monospace'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          semantics[i],
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                  if (i < labels.length - 1)
                    const Divider(height: 16, thickness: 0.5),
                ],
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Color _stateColor(String name) {
  switch (name) {
    case 'start':
      return const Color(0xFF607D8B);
    case 'stable':
      return const Color(0xFF2E7D32);
    case 'changed':
      return const Color(0xFFF9A825);
    case 'unstable':
      return const Color(0xFFC62828);
  }
  return Colors.black;
}

// =============================================================================
// Section 3 — Basic AnimatedSize
// =============================================================================
// One AnimatedSize whose child width grows/shrinks on tap.
// =============================================================================

Widget _section3BasicAnimatedSize() {
  return _SectionShell(
    title: '3. Basic AnimatedSize — width tween on tap',
    subtitle: 'one AnimatedSize, one duration, one curve.',
    palette: const _Palette(
      background: Color(0xFFE0F7FA),
      border: Color(0xFF00838F),
      accent: Color(0xFF006064),
    ),
    child: StatefulBuilder(
      builder: (context, setState) {
        return _BasicAnimatedSizeBody();
      },
    ),
  );
}

class _BasicAnimatedSizeBody extends StatefulWidget {
  @override
  State<_BasicAnimatedSizeBody> createState() => _BasicAnimatedSizeBodyState();
}

class _BasicAnimatedSizeBodyState extends State<_BasicAnimatedSizeBody> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tap the card. AnimatedSize tweens between the two child widths. '
          'Behind the scenes, the render object enters the "changed" state '
          'on tap, runs a 400ms tween, and returns to "stable" when the '
          'animation completes.',
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Card(
            color: const Color(0xFFB2EBF2),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                alignment: Alignment.centerLeft,
                child: Container(
                  width: _expanded ? 320 : 120,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00838F),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _expanded ? 'wide (320 px)' : 'narrow (120 px)',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('Current logical state: '),
            Chip(
              label: Text(_expanded ? 'changed → stable (wide)' : 'stable (narrow)'),
              backgroundColor: _expanded
                  ? const Color(0xFFFFF59D)
                  : const Color(0xFFC8E6C9),
            ),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// Section 4 — Multiple AnimatedSize duration showcase
// =============================================================================
// Six durations, all toggling at once.
// =============================================================================

Widget _section4DurationShowcase() {
  return _SectionShell(
    title: '4. Duration showcase — six AnimatedSize side by side',
    subtitle: '100, 250, 500, 1000, 1500, 3000ms.',
    palette: const _Palette(
      background: Color(0xFFFFF3E0),
      border: Color(0xFFEF6C00),
      accent: Color(0xFFE65100),
    ),
    child: StatefulBuilder(
      builder: (context, setState) {
        return _DurationShowcaseBody();
      },
    ),
  );
}

class _DurationShowcaseBody extends StatefulWidget {
  @override
  State<_DurationShowcaseBody> createState() => _DurationShowcaseBodyState();
}

class _DurationShowcaseBodyState extends State<_DurationShowcaseBody> {
  bool _expanded = false;

  static const _durations = <int>[100, 250, 500, 1000, 1500, 3000];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AnimatedSize uses a single duration for forward (and optionally '
          'reverse) transitions. Below, six AnimatedSize instances are '
          'driven by the same toggle; only their duration differs. Watch '
          'how each render object spends a different amount of time in '
          'the "changed" state.',
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          icon: Icon(_expanded ? Icons.unfold_less : Icons.unfold_more),
          label: Text(_expanded ? 'Shrink all' : 'Expand all'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEF6C00),
            foregroundColor: Colors.white,
          ),
          onPressed: () => setState(() => _expanded = !_expanded),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final ms in _durations)
              _durationCard(ms, _expanded),
          ],
        ),
      ],
    );
  }

  Widget _durationCard(int ms, bool expanded) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEF6C00)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${ms}ms',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFE65100),
            ),
          ),
          const SizedBox(height: 4),
          AnimatedSize(
            duration: Duration(milliseconds: ms),
            curve: Curves.easeInOut,
            alignment: Alignment.topLeft,
            child: Container(
              width: expanded ? 140 : 60,
              height: expanded ? 60 : 30,
              decoration: BoxDecoration(
                color: const Color(0xFFFFB74D),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text(
                expanded ? 'wide' : 'narrow',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 5 — Curve gallery
// =============================================================================
// Six curves on AnimatedSize.
// =============================================================================

Widget _section5CurveGallery() {
  return _SectionShell(
    title: '5. Curve gallery — six standard curves',
    subtitle: 'linear, easeIn, easeOut, easeInOut, bounceOut, elasticOut.',
    palette: const _Palette(
      background: Color(0xFFF1F8E9),
      border: Color(0xFF558B2F),
      accent: Color(0xFF33691E),
    ),
    child: StatefulBuilder(
      builder: (context, setState) {
        return _CurveGalleryBody();
      },
    ),
  );
}

class _CurveGalleryBody extends StatefulWidget {
  @override
  State<_CurveGalleryBody> createState() => _CurveGalleryBodyState();
}

class _CurveGalleryBodyState extends State<_CurveGalleryBody> {
  bool _expanded = false;

  static const _curves = <String, Curve>{
    'linear': Curves.linear,
    'easeIn': Curves.easeIn,
    'easeOut': Curves.easeOut,
    'easeInOut': Curves.easeInOut,
    'bounceOut': Curves.bounceOut,
    'elasticOut': Curves.elasticOut,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AnimatedSize honours its `curve` property only during the '
          '"changed" state. While "stable" or "unstable", the curve is '
          'irrelevant — there is no in-flight animation to shape.',
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          icon: Icon(_expanded ? Icons.unfold_less : Icons.unfold_more),
          label: Text(_expanded ? 'Shrink all' : 'Expand all'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF558B2F),
            foregroundColor: Colors.white,
          ),
          onPressed: () => setState(() => _expanded = !_expanded),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final entry in _curves.entries)
              _curveCard(entry.key, entry.value, _expanded),
          ],
        ),
      ],
    );
  }

  Widget _curveCard(String name, Curve curve, bool expanded) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF558B2F)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF33691E),
            ),
          ),
          const SizedBox(height: 4),
          AnimatedSize(
            duration: const Duration(milliseconds: 1100),
            curve: curve,
            alignment: Alignment.topLeft,
            child: Container(
              width: expanded ? 150 : 50,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFAED581),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: Text(
                expanded ? 'wide' : 'short',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 6 — Reverse-curve and reverseDuration
// =============================================================================

Widget _section6ReverseCurve() {
  return _SectionShell(
    title: '6. Reverse curves — separate shrink behaviour',
    subtitle: 'reverseDuration + reverseCurve.',
    palette: const _Palette(
      background: Color(0xFFFCE4EC),
      border: Color(0xFFAD1457),
      accent: Color(0xFF880E4F),
    ),
    child: StatefulBuilder(
      builder: (context, setState) {
        return _ReverseCurveBody();
      },
    ),
  );
}

class _ReverseCurveBody extends StatefulWidget {
  @override
  State<_ReverseCurveBody> createState() => _ReverseCurveBodyState();
}

class _ReverseCurveBodyState extends State<_ReverseCurveBody> {
  bool _expanded = false;
  bool _useDistinctReverse = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'The `reverseDuration` and `reverseCurve` parameters allow '
          'AnimatedSize to use a different timing for shrink than for '
          'grow. Both are still bounded by the same render-object state '
          'machine: the moment the child reports a smaller size we enter '
          '"changed", run the reverse tween, and return to "stable".',
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Switch(
              value: _useDistinctReverse,
              activeColor: const Color(0xFFAD1457),
              onChanged: (v) => setState(() => _useDistinctReverse = v),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Use distinct reverseDuration (1500ms, easeInOut) and '
                'reverseCurve. When off, both directions use 400ms easeIn.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Center(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 400),
            reverseDuration: _useDistinctReverse
                ? const Duration(milliseconds: 1500)
                : null,
            curve: _useDistinctReverse ? Curves.easeInOut : Curves.easeIn,
            alignment: Alignment.center,
            child: Container(
              width: _expanded ? 320 : 80,
              height: _expanded ? 120 : 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF06292),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                _expanded ? 'expanded' : 'collapsed',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFAD1457),
              foregroundColor: Colors.white,
            ),
            onPressed: () => setState(() => _expanded = !_expanded),
            child: Text(_expanded ? 'Shrink (reverse)' : 'Grow (forward)'),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Section 7 — Stable vs changed in flight
// =============================================================================

Widget _section7StableVsChanged() {
  return _SectionShell(
    title: '7. Stable vs Changed — counter-driven transitions',
    subtitle: 'observe the state on each tap.',
    palette: const _Palette(
      background: Color(0xFFE8F5E9),
      border: Color(0xFF2E7D32),
      accent: Color(0xFF1B5E20),
    ),
    child: StatefulBuilder(
      builder: (context, setState) {
        return _StableVsChangedBody();
      },
    ),
  );
}

class _StableVsChangedBody extends StatefulWidget {
  @override
  State<_StableVsChangedBody> createState() => _StableVsChangedBodyState();
}

class _StableVsChangedBodyState extends State<_StableVsChangedBody> {
  int _taps = 0;

  String _logicalState() {
    if (_taps == 0) return 'stable';
    return 'changed';
  }

  String _annotation() {
    switch (_taps) {
      case 0:
        return 'Initial layout pass — child has size, render object is "stable".';
      case 1:
        return 'First tap — child grew, render object is now "changed". Tween in flight.';
      case 2:
        return 'Second tap — child resized again. Still "changed" (a single tween is restarted).';
      case 3:
        return 'Third tap — render object stays in "changed" until the tween settles.';
      default:
        return 'Tap $_taps — render object alternates rapidly between '
            '"changed" and "stable" as each tween completes.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = 80.0 + (_taps % 4) * 50.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Each tap mutates the child\'s width, forcing AnimatedSize\'s '
          'render object back into the "changed" state. If a new tap '
          'arrives before the previous tween completes, the existing '
          'tween is restarted from the new starting size.',
        ),
        const SizedBox(height: 12),
        Center(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            child: Container(
              width: size,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF66BB6A),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                '${size.toStringAsFixed(0)} px',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
            ),
            onPressed: () => setState(() => _taps++),
            label: Text('Resize child (taps: $_taps)'),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF2E7D32)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Logical state: '),
                  Chip(
                    label: Text(_logicalState()),
                    backgroundColor: _stateColor(_logicalState()).withValues(alpha: 0.2),
                    side: BorderSide(color: _stateColor(_logicalState())),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _annotation(),
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap counter sequence: ${List.generate(_taps + 1, (i) => i == 0 ? 'stable' : 'changed').join(' / ')}',
                style: const TextStyle(fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Section 8 — Unstable demo
// =============================================================================
// Toggle on a 50ms timer to drive the render object into "unstable".
// =============================================================================

Widget _section8UnstableDemo() {
  return _SectionShell(
    title: '8. Unstable demo — child resizes faster than the tween',
    subtitle: 'AnimatedSize gives up animating; sizes snap.',
    palette: const _Palette(
      background: Color(0xFFFFEBEE),
      border: Color(0xFFC62828),
      accent: Color(0xFFB71C1C),
    ),
    child: StatefulBuilder(
      builder: (context, setState) {
        return _UnstableDemoBody();
      },
    ),
  );
}

class _UnstableDemoBody extends StatefulWidget {
  @override
  State<_UnstableDemoBody> createState() => _UnstableDemoBodyState();
}

class _UnstableDemoBodyState extends State<_UnstableDemoBody> {
  bool _running = false;
  bool _wide = false;
  int _flips = 0;

  void _toggleRunning() {
    setState(() {
      _running = !_running;
      if (_running) {
        _kickAnimation();
      }
    });
  }

  void _kickAnimation() {
    if (!_running || !mounted) return;
    Future.delayed(const Duration(milliseconds: 50), () {
      if (!_running || !mounted) return;
      setState(() {
        _wide = !_wide;
        _flips++;
      });
      _kickAnimation();
    });
  }

  @override
  void dispose() {
    _running = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tap "Start". A timer flips the child width every 50ms. Because '
          'AnimatedSize\'s tween is 800ms, the child resizes ~16 times per '
          'tween. The render object detects the rapid succession and falls '
          'back to "unstable" — sizes now snap rather than tween.',
        ),
        const SizedBox(height: 12),
        Center(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            child: Container(
              width: _wide ? 280 : 100,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFEF5350),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                _running
                    ? 'flipping (${_flips}x)'
                    : (_wide ? 'wide' : 'narrow'),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: ElevatedButton.icon(
            icon: Icon(_running ? Icons.stop : Icons.play_arrow),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC62828),
              foregroundColor: Colors.white,
            ),
            onPressed: _toggleRunning,
            label: Text(_running ? 'Stop' : 'Start instability'),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFC62828)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Predicted state: '),
                  Chip(
                    label: Text(_running ? 'unstable' : 'stable'),
                    backgroundColor: _stateColor(_running ? 'unstable' : 'stable')
                        .withValues(alpha: 0.2),
                    side: BorderSide(
                      color: _stateColor(_running ? 'unstable' : 'stable'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'When "unstable", the render object gives up on tweening '
                'and snaps directly to the new child size. Stop the timer '
                'to let the render object recover and return to "stable".',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Section 9 — Real-life: collapsible card
// =============================================================================

Widget _section9CollapsibleCard() {
  return _SectionShell(
    title: '9. Real-life — collapsible card',
    subtitle: 'AnimatedSize wrapping conditional content.',
    palette: const _Palette(
      background: Color(0xFFE0F2F1),
      border: Color(0xFF00695C),
      accent: Color(0xFF004D40),
    ),
    child: StatefulBuilder(
      builder: (context, setState) {
        return _CollapsibleCardBody();
      },
    ),
  );
}

class _CollapsibleCardBody extends StatefulWidget {
  @override
  State<_CollapsibleCardBody> createState() => _CollapsibleCardBodyState();
}

class _CollapsibleCardBodyState extends State<_CollapsibleCardBody> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AnimatedSize is the canonical solution to the "expandable card" '
          'pattern. Wrap the variable-height region in AnimatedSize, and '
          'a simple `if (expanded) ...` is enough to drive a smooth open/'
          'close. The render object enters "changed" on every toggle.',
        ),
        const SizedBox(height: 12),
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFF00695C)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.article, color: Color(0xFF00695C)),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'RenderAnimatedSize internals',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _expanded ? Icons.expand_less : Icons.expand_more,
                          color: const Color(0xFF00695C),
                        ),
                        onPressed: () =>
                            setState(() => _expanded = !_expanded),
                      ),
                    ],
                  ),
                  const Text(
                    'A single-child render object that smoothly tweens '
                    'between two child sizes.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  if (_expanded) ...[
                    const SizedBox(height: 12),
                    const Divider(),
                    const Text(
                      'Internally, the object holds two sizes: the previous '
                      'child size and the current child size. On each '
                      'performLayout pass, it computes the child\'s '
                      'intrinsic size and compares with the previous size. '
                      'A divergence enters "changed"; equality keeps '
                      '"stable". A custom AnimationController drives the '
                      'tween, and an internal counter tracks how many '
                      'consecutive frames produced a "changed" result. '
                      'After a small threshold, the counter trips '
                      '"unstable".',
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: const [
                        Chip(label: Text('start → first layout')),
                        Chip(label: Text('stable ↔ changed loop')),
                        Chip(label: Text('changed → unstable bailout')),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// Section 10 — List item resize
// =============================================================================

Widget _section10ListItemResize() {
  return _SectionShell(
    title: '10. List item resize — AnimatedSize inside a tile',
    subtitle: 'tap any row to expand it.',
    palette: const _Palette(
      background: Color(0xFFEDE7F6),
      border: Color(0xFF4527A0),
      accent: Color(0xFF311B92),
    ),
    child: StatefulBuilder(
      builder: (context, setState) {
        return _ListItemResizeBody();
      },
    ),
  );
}

class _ListItemResizeBody extends StatefulWidget {
  @override
  State<_ListItemResizeBody> createState() => _ListItemResizeBodyState();
}

class _ListItemResizeBodyState extends State<_ListItemResizeBody> {
  final Set<int> _expandedIndexes = <int>{};

  static const _items = <_ListEntry>[
    _ListEntry(
      title: 'start',
      summary: 'Initial state of any RenderAnimatedSize.',
      detail:
          'Once layout reaches the render object for the first time, the '
          'state immediately leaves "start" and never returns there. '
          '"start" is essentially a one-shot init token.',
    ),
    _ListEntry(
      title: 'stable',
      summary: 'No animation in flight.',
      detail:
          'Stable is the resting state. Most of the time AnimatedSize is '
          'in "stable": user has stopped resizing, tween has settled, the '
          'render object simply forwards layout and paint to the child.',
    ),
    _ListEntry(
      title: 'changed',
      summary: 'Tween between previous and new size.',
      detail:
          'A child resize triggers "changed". The render object captures '
          'the previous size, starts a new tween, and during paint blends '
          'the size based on the AnimationController\'s value.',
    ),
    _ListEntry(
      title: 'unstable',
      summary: 'Bail-out: snap rather than tween.',
      detail:
          'If the child resizes too many frames in a row, the render '
          'object enters "unstable". Animations are skipped until a '
          'frame passes with no further resize, at which point we '
          'return to "stable".',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF4527A0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          for (var i = 0; i < _items.length; i++) ...[
            InkWell(
              onTap: () => setState(() {
                if (_expandedIndexes.contains(i)) {
                  _expandedIndexes.remove(i);
                } else {
                  _expandedIndexes.add(i);
                }
              }),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _stateColor(_items[i].title),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _items[i].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(_items[i].summary)),
                          Icon(
                            _expandedIndexes.contains(i)
                                ? Icons.expand_less
                                : Icons.expand_more,
                            color: const Color(0xFF4527A0),
                          ),
                        ],
                      ),
                      if (_expandedIndexes.contains(i)) ...[
                        const SizedBox(height: 8),
                        Text(
                          _items[i].detail,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF311B92),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            if (i < _items.length - 1)
              const Divider(height: 1, thickness: 0.5),
          ],
        ],
      ),
    );
  }
}

class _ListEntry {
  final String title;
  final String summary;
  final String detail;
  const _ListEntry({
    required this.title,
    required this.summary,
    required this.detail,
  });
}

// =============================================================================
// Section 11 — AnimatedSize + AnimatedSwitcher combo
// =============================================================================

Widget _section11AnimatedSwitcherCombo() {
  return _SectionShell(
    title: '11. AnimatedSize + AnimatedSwitcher',
    subtitle: 'fade and resize at the same time.',
    palette: const _Palette(
      background: Color(0xFFE1F5FE),
      border: Color(0xFF0277BD),
      accent: Color(0xFF01579B),
    ),
    child: StatefulBuilder(
      builder: (context, setState) {
        return _SwitcherComboBody();
      },
    ),
  );
}

class _SwitcherComboBody extends StatefulWidget {
  @override
  State<_SwitcherComboBody> createState() => _SwitcherComboBodyState();
}

class _SwitcherComboBodyState extends State<_SwitcherComboBody> {
  int _index = 0;

  static const _children = <Widget>[
    Padding(
      padding: EdgeInsets.all(12),
      key: ValueKey('a'),
      child: Text('A — small content'),
    ),
    Padding(
      padding: EdgeInsets.all(12),
      key: ValueKey('b'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('B — medium content'),
          SizedBox(height: 4),
          Text('Two lines.'),
        ],
      ),
    ),
    Padding(
      padding: EdgeInsets.all(12),
      key: ValueKey('c'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('C — large content'),
          SizedBox(height: 4),
          Text('Line two of three.'),
          SizedBox(height: 4),
          Text('Line three has even more text in it.'),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AnimatedSwitcher uses an internal Stack and a default '
          'transitionBuilder of FadeTransition — but it does not animate '
          'size. Wrapping AnimatedSwitcher in AnimatedSize is the '
          'idiomatic way to fade the content while smoothly resizing '
          'the parent. Two render objects, two state machines: '
          'AnimatedSize\'s drives "stable/changed/unstable", '
          'AnimatedSwitcher\'s drives the cross-fade.',
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFF0277BD)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: _children[_index],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            for (var i = 0; i < _children.length; i++)
              ChoiceChip(
                label: Text(['A', 'B', 'C'][i]),
                selected: _index == i,
                selectedColor: const Color(0xFF0277BD),
                labelStyle: TextStyle(
                  color: _index == i ? Colors.white : Colors.black,
                ),
                onSelected: (_) => setState(() => _index = i),
              ),
          ],
        ),
      ],
    );
  }
}

// =============================================================================
// Section 12 — Decision card
// =============================================================================

Widget _section12DecisionCard() {
  return _SectionShell(
    title: '12. Decision card — when to pick what',
    subtitle: 'AnimatedSize vs AnimatedContainer vs Hero vs SizeTransition.',
    palette: const _Palette(
      background: Color(0xFFFFF8E1),
      border: Color(0xFFFF8F00),
      accent: Color(0xFFE65100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'The AnimatedSize / AnimatedContainer / Hero / SizeTransition '
          'family of widgets each tackle a different slice of "make '
          'something resize smoothly". Pick wrong and you spend hours '
          'fighting the framework — pick right and one-line implicit '
          'animations are enough.',
        ),
        const SizedBox(height: 12),
        _decisionRow(
          'AnimatedSize',
          'Child has its own intrinsic size; you don\'t know it.',
          'No controller; uses RenderAnimatedSize state machine.',
          const Color(0xFF1B5E20),
        ),
        _decisionRow(
          'AnimatedContainer',
          'You drive width/height/decoration explicitly.',
          'Uses ImplicitlyAnimatedWidget; explicit size required.',
          const Color(0xFF0D47A1),
        ),
        _decisionRow(
          'Hero',
          'Cross-route element-flight animation.',
          'Two-route Navigator coordination, not size-only.',
          const Color(0xFFAD1457),
        ),
        _decisionRow(
          'SizeTransition',
          'You already have an Animation<double>.',
          'Manual: needs an external AnimationController.',
          const Color(0xFFEF6C00),
        ),
      ],
    ),
  );
}

Widget _decisionRow(String name, String when, String how, Color color) {
  return Container(
    margin: const EdgeInsets.only(top: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text('Use when: $when'),
        Text(
          'How: $how',
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

// =============================================================================
// Section 13 — Live state-machine visualiser
// =============================================================================
// CustomPainter showing the deduced current state of an AnimatedSize.
// =============================================================================

Widget _section13StateMachineVisualiser() {
  return _SectionShell(
    title: '13. Live visualiser — deduced state vs threshold',
    subtitle: 'CustomPainter highlights the active node.',
    palette: const _Palette(
      background: Color(0xFFFFFDE7),
      border: Color(0xFFF9A825),
      accent: Color(0xFFF57F17),
    ),
    child: StatefulBuilder(
      builder: (context, setState) {
        return _LiveVisualiserBody();
      },
    ),
  );
}

class _LiveVisualiserBody extends StatefulWidget {
  @override
  State<_LiveVisualiserBody> createState() => _LiveVisualiserBodyState();
}

class _LiveVisualiserBodyState extends State<_LiveVisualiserBody>
    with SingleTickerProviderStateMixin {
  // Simulated state used to drive both the AnimatedSize child and the
  // CustomPainter overlay. The painter listens to `_repaint`, which is
  // bumped on every state mutation.
  final ValueNotifier<int> _repaint = ValueNotifier<int>(0);

  String _state = 'start';
  double _width = 80;
  DateTime _lastChange = DateTime.now();
  int _changesInWindow = 0;

  void _recordChange() {
    final now = DateTime.now();
    final delta = now.difference(_lastChange).inMilliseconds;
    _lastChange = now;
    if (delta < 200) {
      _changesInWindow++;
    } else {
      _changesInWindow = 1;
    }
    if (_changesInWindow >= 4) {
      _state = 'unstable';
    } else {
      _state = 'changed';
    }
    _repaint.value++;
  }

  void _settle() {
    _state = 'stable';
    _changesInWindow = 0;
    _repaint.value++;
  }

  @override
  void dispose() {
    _repaint.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'This visualiser tracks how often you tap "resize" and infers '
          'the render object\'s current state. Tap once: "changed". Tap '
          'multiple times within 200ms: "unstable". Wait, then tap '
          '"settle" to return to "stable". The CustomPainter highlights '
          'the active node.',
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: CustomPaint(
            painter: _LiveStateMachinePainter(
              repaint: _repaint,
              activeState: () => _state,
            ),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            child: Container(
              width: _width,
              height: 50,
              decoration: BoxDecoration(
                color: _stateColor(_state),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                _state,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.aspect_ratio),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF9A825),
                foregroundColor: Colors.white,
              ),
              onPressed: () => setState(() {
                _width = 80 + (DateTime.now().millisecondsSinceEpoch % 240);
                _recordChange();
              }),
              label: const Text('Resize'),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
              ),
              onPressed: () => setState(_settle),
              label: const Text('Settle (stable)'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('Changes in last 200ms window: $_changesInWindow'),
      ],
    );
  }
}

// =============================================================================
// Section 14 — Reference DataTable
// =============================================================================

Widget _section14ReferenceTable() {
  return _SectionShell(
    title: '14. Reference — enum value, semantic, trigger',
    subtitle: 'one row per state.',
    palette: const _Palette(
      background: Color(0xFFECEFF1),
      border: Color(0xFF455A64),
      accent: Color(0xFF263238),
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 24,
        headingRowColor: WidgetStateProperty.all(const Color(0xFFCFD8DC)),
        columns: const [
          DataColumn(label: Text('Value', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('index', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Semantic', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Triggered by', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: [
          DataRow(cells: [
            DataCell(_dotLabel('start')),
            const DataCell(Text('0')),
            const DataCell(Text('Default; before first child layout')),
            const DataCell(Text('Construction of RenderAnimatedSize')),
          ]),
          DataRow(cells: [
            DataCell(_dotLabel('stable')),
            const DataCell(Text('1')),
            const DataCell(Text('Child size unchanged; no tween in flight')),
            const DataCell(Text('Tween completes, or first layout settles')),
          ]),
          DataRow(cells: [
            DataCell(_dotLabel('changed')),
            const DataCell(Text('2')),
            const DataCell(Text('Tween in flight from previous to new size')),
            const DataCell(Text('Child reports a different intrinsic size')),
          ]),
          DataRow(cells: [
            DataCell(_dotLabel('unstable')),
            const DataCell(Text('3')),
            const DataCell(Text('Animation bypassed; sizes snap')),
            const DataCell(Text('Child resized too many frames in a row')),
          ]),
        ],
      ),
    ),
  );
}

Widget _dotLabel(String name) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: _stateColor(name),
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 8),
      Text(name, style: const TextStyle(fontFamily: 'monospace')),
    ],
  );
}

// =============================================================================
// Section 15 — Footer
// =============================================================================

Widget _section15Footer() {
  return _SectionShell(
    title: '15. References',
    subtitle: 'where to read more.',
    palette: const _Palette(
      background: Color(0xFFEFEBE9),
      border: Color(0xFF4E342E),
      accent: Color(0xFF3E2723),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('• Flutter API: AnimatedSize'),
        Text('• Flutter source: package:flutter/src/rendering/animated_size.dart'),
        Text('• Flutter source: package:flutter/src/widgets/animated_size.dart'),
        Text('• Cookbook: Animate the size of a widget'),
        Text('• Related: AnimatedSwitcher, AnimatedCrossFade, SizeTransition'),
        SizedBox(height: 8),
        Text(
          'This deep demo exercises every public surface of AnimatedSize '
          'and explicitly walks through every value of the private enum '
          'RenderAnimatedSizeState: start, stable, changed, unstable.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

// =============================================================================
// Shared helpers — section shell
// =============================================================================

class _Palette {
  final Color background;
  final Color border;
  final Color accent;
  const _Palette({
    required this.background,
    required this.border,
    required this.accent,
  });
}

class _SectionShell extends StatelessWidget {
  final String title;
  final String subtitle;
  final _Palette palette;
  final Widget child;

  const _SectionShell({
    required this.title,
    required this.subtitle,
    required this.palette,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.background,
        border: Border.all(color: palette.border, width: 1.5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: palette.border.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: palette.accent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: palette.accent.withValues(alpha: 0.8),
            ),
          ),
          const Divider(height: 20, thickness: 0.7),
          child,
        ],
      ),
    );
  }
}

// =============================================================================
// CustomPainter #1 — static state-machine diagram
// =============================================================================

class _StateMachineDiagramPainter extends CustomPainter {
  _StateMachineDiagramPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFFFFFFF);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(8),
      ),
      bg,
    );

    // Layout: four nodes in a horizontal row.
    const labels = ['start', 'stable', 'changed', 'unstable'];
    final nodeRadius = 36.0;
    final centers = <Offset>[];
    final spacing = (size.width - 4 * 2 * nodeRadius) / 5;
    var x = spacing + nodeRadius;
    final y = size.height / 2;
    for (var i = 0; i < labels.length; i++) {
      centers.add(Offset(x, y));
      x += spacing + 2 * nodeRadius;
    }

    // Arrows: start→stable, stable→changed, changed→stable, changed→unstable,
    // unstable→stable (recovery).
    _drawArrow(canvas, centers[0], centers[1], const Color(0xFF607D8B));
    _drawArrow(canvas, centers[1], centers[2], const Color(0xFF2E7D32));
    _drawArrow(canvas, centers[2], centers[1], const Color(0xFFF9A825),
        offset: const Offset(0, 16));
    _drawArrow(canvas, centers[2], centers[3], const Color(0xFFC62828));
    _drawArrow(canvas, centers[3], centers[1], const Color(0xFF6A1B9A),
        offset: const Offset(0, -36));

    // Nodes.
    for (var i = 0; i < labels.length; i++) {
      final paint = Paint()..color = _stateColor(labels[i]);
      canvas.drawCircle(centers[i], nodeRadius, paint);
      canvas.drawCircle(
        centers[i],
        nodeRadius,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      _drawText(canvas, labels[i], centers[i], Colors.white, bold: true);
    }
  }

  void _drawArrow(Canvas canvas, Offset from, Offset to, Color color,
      {Offset offset = Offset.zero}) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final start = from + offset;
    final end = to + offset;
    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(end.dx, end.dy);
    canvas.drawPath(path, paint);

    // Arrowhead.
    final dir = (end - start);
    final len = dir.distance;
    if (len == 0) return;
    final unit = Offset(dir.dx / len, dir.dy / len);
    final perp = Offset(-unit.dy, unit.dx);
    final tip = end - unit * 40;
    final p1 = tip + perp * 6;
    final p2 = tip - perp * 6;
    canvas.drawPath(
      Path()
        ..moveTo(end.dx - unit.dx * 40, end.dy - unit.dy * 40)
        ..lineTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..close(),
      Paint()..color = color,
    );
  }

  void _drawText(Canvas canvas, String text, Offset center, Color color,
      {bool bold = false}) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      Offset(center.dx - tp.width / 2, center.dy - tp.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _StateMachineDiagramPainter oldDelegate) => false;
}

// =============================================================================
// CustomPainter #2 — live state-machine highlighter
// =============================================================================

class _LiveStateMachinePainter extends CustomPainter {
  final ValueNotifier<int> repaint;
  final String Function() activeState;

  _LiveStateMachinePainter({
    required this.repaint,
    required this.activeState,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFFFFFFF);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(8),
      ),
      bg,
    );

    const labels = ['start', 'stable', 'changed', 'unstable'];
    final nodeRadius = 32.0;
    final centers = <Offset>[];
    final spacing = (size.width - 4 * 2 * nodeRadius) / 5;
    var x = spacing + nodeRadius;
    final y = size.height / 2;
    for (var i = 0; i < labels.length; i++) {
      centers.add(Offset(x, y));
      x += spacing + 2 * nodeRadius;
    }

    // Light arrows in the background.
    final arrowPaint = Paint()
      ..color = const Color(0xFFCCCCCC)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    for (var i = 0; i < labels.length - 1; i++) {
      canvas.drawLine(centers[i], centers[i + 1], arrowPaint);
    }

    final active = activeState();
    for (var i = 0; i < labels.length; i++) {
      final isActive = labels[i] == active;
      final color = _stateColor(labels[i]);
      final radius = isActive ? nodeRadius * 1.15 : nodeRadius;

      // Halo when active.
      if (isActive) {
        canvas.drawCircle(
          centers[i],
          radius * 1.4,
          Paint()
            ..color = color.withValues(alpha: 0.25)
            ..style = PaintingStyle.fill,
        );
      }

      canvas.drawCircle(
        centers[i],
        radius,
        Paint()..color = isActive ? color : color.withValues(alpha: 0.4),
      );
      canvas.drawCircle(
        centers[i],
        radius,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = isActive ? 3 : 1.5,
      );

      final tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: Colors.white,
            fontSize: isActive ? 12 : 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(
          centers[i].dx - tp.width / 2,
          centers[i].dy - tp.height / 2,
        ),
      );
    }

    // Heading.
    final heading = TextPainter(
      text: TextSpan(
        text: 'Active state: $active',
        style: const TextStyle(
          color: Color(0xFFF57F17),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    heading.paint(canvas, const Offset(12, 8));
  }

  @override
  bool shouldRepaint(covariant _LiveStateMachinePainter oldDelegate) => true;
}

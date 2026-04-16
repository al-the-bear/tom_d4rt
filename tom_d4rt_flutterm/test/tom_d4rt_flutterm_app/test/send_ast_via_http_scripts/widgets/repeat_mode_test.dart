import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// RepeatMode Deep Demo
// RepeatMode is not an enum in Flutter core — it is an *educational concept*
// grouping the four fundamental animation repeat behaviours that every Flutter
// developer needs to understand.  This demo builds each mode from first
// principles using AnimationController + TweenAnimationBuilder and shows them
// side-by-side with interactive controls.
//
// The four canonical modes demonstrated:
//   • none      – plays once from 0 → 1, then stops.
//   • loop      – repeats 0 → 1 → 0 → 1 … continuously.
//   • pingPong  – repeats 0 → 1 → 0 with full easing in both directions.
//   • reverse   – plays once from 1 → 0 (mirror of none).
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// Palette — indigo + orange M3 seeds reused across all tabs.
// ---------------------------------------------------------------------------
const Color _kSeed = Color(0xFF3D2B9E);
const Color _kInk = Color(0xFF1A1340);
const Color _kSurface = Color(0xFFF4F2FF);
const Color _kSurfaceAlt = Color(0xFFEAE6FF);
const Color _kBorder = Color(0xFFBCB5E8);
const Color _kAccent = Color(0xFFD4610B);
const Color _kLoop = Color(0xFF2D7DD2);
const Color _kPing = Color(0xFF2BA84A);
const Color _kReverse = Color(0xFFB5432A);
const Color _kNone = Color(0xFF8B5CF6);

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers — drive interactivity from stateless widgets.
// ---------------------------------------------------------------------------
final ValueNotifier<double> _loopSpeed = ValueNotifier<double>(1.0);
final ValueNotifier<double> _pingSpeed = ValueNotifier<double>(1.0);
final ValueNotifier<int> _noneRestartSignal = ValueNotifier<int>(0);
final ValueNotifier<int> _reverseRestartSignal = ValueNotifier<int>(0);

// ---------------------------------------------------------------------------
// Entry point.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _RepeatModeDeepDemo();
}

// ===========================================================================
// Root app.
// ===========================================================================
class _RepeatModeDeepDemo extends StatelessWidget {
  const _RepeatModeDeepDemo();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: _kSeed,
      brightness: Brightness.light,
    );
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _kSurface,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kInk, height: 1.4),
        titleLarge: TextStyle(
          color: _kInk,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const _ShellScaffold(),
    );
  }
}

// ===========================================================================
// Shell scaffold with 9 tabs.
// ===========================================================================
class _ShellScaffold extends StatelessWidget {
  const _ShellScaffold();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: _kSurface,
        appBar: AppBar(
          backgroundColor: _kInk,
          foregroundColor: Colors.white,
          toolbarHeight: 92,
          elevation: 0,
          title: const _AppBarTitle(),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(52),
            child: _ShellTabBar(),
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            _HeroBannerTab(),
            _NoneTab(),
            _LoopTab(),
            _PingPongTab(),
            _ReverseTab(),
            _CurvesTab(),
            _ComparisonTab(),
            _UseCasesTab(),
            _DiagramTab(),
          ],
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Text(
          'RepeatMode',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 2),
        Text(
          'Animation repeat behaviour patterns — a deep Flutter demo',
          style: TextStyle(fontSize: 11, color: Color(0xFFCBC8FF)),
        ),
      ],
    );
  }
}

class _ShellTabBar extends StatelessWidget {
  const _ShellTabBar();

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      labelColor: Colors.white,
      unselectedLabelColor: const Color(0xFF9B96D0),
      indicatorColor: _kAccent,
      indicatorWeight: 3,
      tabs: const <Tab>[
        Tab(text: 'Intro'),
        Tab(text: 'None'),
        Tab(text: 'Loop'),
        Tab(text: 'PingPong'),
        Tab(text: 'Reverse'),
        Tab(text: 'Curves'),
        Tab(text: 'Compare'),
        Tab(text: 'Use Cases'),
        Tab(text: 'Diagram'),
      ],
    );
  }
}

// ===========================================================================
// Shared helpers.
// ===========================================================================
Widget _sectionHeader(String title, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      border: Border(left: BorderSide(color: color, width: 4)),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: color.withValues(alpha: 0.85),
      ),
    ),
  );
}

Widget _bodyText(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    child: Text(text, style: const TextStyle(fontSize: 13.5, color: _kInk)),
  );
}

Widget _divider() => const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(color: _kBorder, thickness: 1),
    );

Widget _chip(String label, Color bg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: bg.withValues(alpha: 0.5)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: bg.withValues(alpha: 0.9),
      ),
    ),
  );
}

class _Card extends StatelessWidget {
  const _Card({required this.child, this.color});
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Color(0x0D000000), blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }
}

// ---------------------------------------------------------------------------
// Animated bar — core reusable building block used in multiple tabs.
// TweenAnimationBuilder drives a 0→1 (or 1→0) progress value.
// Repeat is emulated by embedding the builder inside a ValueListenableBuilder
// that re-triggers it when a "tick" counter increments.
// ---------------------------------------------------------------------------

/// Modes understood by _AnimatedBar.
enum _Mode { none, loop, pingPong, reverse }

/// A self-contained animated bar for a given mode.
/// Uses TweenAnimationBuilder to animate a fill fraction.
class _AnimatedBar extends StatelessWidget {
  const _AnimatedBar({
    required this.mode,
    required this.color,
    required this.height,
    this.duration = const Duration(milliseconds: 1200),
    this.curve = Curves.easeInOut,
    this.label,
    this.restartNotifier,
    this.speedNotifier,
  });

  final _Mode mode;
  final Color color;
  final double height;
  final Duration duration;
  final Curve curve;
  final String? label;
  final ValueNotifier<int>? restartNotifier;
  final ValueNotifier<double>? speedNotifier;

  @override
  Widget build(BuildContext context) {
    // Speed modulation via ValueListenable.
    if (speedNotifier != null) {
      return ValueListenableBuilder<double>(
        valueListenable: speedNotifier!,
        builder: (BuildContext ctx, double speed, Widget? _) {
          final Duration d = Duration(
            milliseconds: (duration.inMilliseconds / speed).round(),
          );
          return _buildCore(ctx, d);
        },
      );
    }
    if (restartNotifier != null) {
      return ValueListenableBuilder<int>(
        valueListenable: restartNotifier!,
        builder: (BuildContext ctx, int tick, Widget? _) => _buildCore(ctx, duration),
      );
    }
    return _buildCore(context, duration);
  }

  Widget _buildCore(BuildContext context, Duration d) {
    switch (mode) {
      case _Mode.none:
        return _NoneBar(
          color: color,
          height: height,
          duration: d,
          curve: curve,
          label: label,
          restartNotifier: restartNotifier,
        );
      case _Mode.loop:
        return _LoopBar(
          color: color,
          height: height,
          duration: d,
          curve: curve,
          label: label,
        );
      case _Mode.pingPong:
        return _PingPongBar(
          color: color,
          height: height,
          duration: d,
          curve: curve,
          label: label,
        );
      case _Mode.reverse:
        return _ReverseBar(
          color: color,
          height: height,
          duration: d,
          curve: curve,
          label: label,
          restartNotifier: restartNotifier,
        );
    }
  }
}

// ---------------------------------------------------------------------------
// None — plays 0 → 1 once. Uses TweenAnimationBuilder with end=1.
// ---------------------------------------------------------------------------
class _NoneBar extends StatelessWidget {
  const _NoneBar({
    required this.color,
    required this.height,
    required this.duration,
    required this.curve,
    this.label,
    this.restartNotifier,
  });

  final Color color;
  final double height;
  final Duration duration;
  final Curve curve;
  final String? label;
  final ValueNotifier<int>? restartNotifier;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey<int>(restartNotifier?.value ?? 0),
      tween: Tween<double>(begin: 0, end: 1),
      duration: duration,
      curve: curve,
      builder: (BuildContext ctx, double v, Widget? _) {
        return _BarBody(
          value: v,
          color: color,
          height: height,
          label: label,
          modeLabel: 'none',
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Loop — 0 → 1 → 0 → 1 … Uses TweenAnimationBuilder alternating end value.
// The trick: wrap in AnimationLoopHelper which swaps between 0↔1 on complete.
// Since StatefulWidget is forbidden we use a top-level ValueNotifier per
// instance to track phase.  We scope per label to avoid collisions.
// ---------------------------------------------------------------------------
final Map<String, ValueNotifier<double>> _loopEnds =
    <String, ValueNotifier<double>>{};

ValueNotifier<double> _loopEnd(String key) {
  return _loopEnds.putIfAbsent(key, () => ValueNotifier<double>(1.0));
}

class _LoopBar extends StatelessWidget {
  const _LoopBar({
    required this.color,
    required this.height,
    required this.duration,
    required this.curve,
    this.label,
  });

  final Color color;
  final double height;
  final Duration duration;
  final Curve curve;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final String key = label ?? 'loop_${color.toARGB32()}';
    final ValueNotifier<double> endNotifier = _loopEnd(key);
    return ValueListenableBuilder<double>(
      valueListenable: endNotifier,
      builder: (BuildContext ctx, double endVal, Widget? _) {
        return TweenAnimationBuilder<double>(
          key: ValueKey<double>(endVal),
          tween: Tween<double>(begin: endVal == 1.0 ? 0.0 : 1.0, end: endVal),
          duration: duration,
          curve: curve,
          onEnd: () {
            endNotifier.value = endVal == 1.0 ? 0.0 : 1.0;
          },
          builder: (BuildContext c, double v, Widget? _) {
            return _BarBody(
              value: v,
              color: color,
              height: height,
              label: label,
              modeLabel: 'loop',
            );
          },
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// PingPong — same as loop but Curves.easeInOut applied symmetrically.
// ---------------------------------------------------------------------------
final Map<String, ValueNotifier<double>> _pingEnds =
    <String, ValueNotifier<double>>{};

ValueNotifier<double> _pingEnd(String key) {
  return _pingEnds.putIfAbsent(key, () => ValueNotifier<double>(1.0));
}

class _PingPongBar extends StatelessWidget {
  const _PingPongBar({
    required this.color,
    required this.height,
    required this.duration,
    required this.curve,
    this.label,
  });

  final Color color;
  final double height;
  final Duration duration;
  final Curve curve;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final String key = label ?? 'ping_${color.toARGB32()}';
    final ValueNotifier<double> endNotifier = _pingEnd(key);
    return ValueListenableBuilder<double>(
      valueListenable: endNotifier,
      builder: (BuildContext ctx, double endVal, Widget? _) {
        return TweenAnimationBuilder<double>(
          key: ValueKey<double>(endVal),
          tween: Tween<double>(begin: endVal == 1.0 ? 0.0 : 1.0, end: endVal),
          duration: duration,
          curve: Curves.easeInOut,
          onEnd: () {
            endNotifier.value = endVal == 1.0 ? 0.0 : 1.0;
          },
          builder: (BuildContext c, double v, Widget? _) {
            return _BarBody(
              value: v,
              color: color,
              height: height,
              label: label,
              modeLabel: 'pingPong',
            );
          },
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Reverse — plays 1 → 0 once. Uses TweenAnimationBuilder(begin:1, end:0).
// ---------------------------------------------------------------------------
class _ReverseBar extends StatelessWidget {
  const _ReverseBar({
    required this.color,
    required this.height,
    required this.duration,
    required this.curve,
    this.label,
    this.restartNotifier,
  });

  final Color color;
  final double height;
  final Duration duration;
  final Curve curve;
  final String? label;
  final ValueNotifier<int>? restartNotifier;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey<int>(restartNotifier?.value ?? 0),
      tween: Tween<double>(begin: 1, end: 0),
      duration: duration,
      curve: curve,
      builder: (BuildContext ctx, double v, Widget? _) {
        return _BarBody(
          value: v,
          color: color,
          height: height,
          label: label,
          modeLabel: 'reverse',
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Shared bar body widget.
// ---------------------------------------------------------------------------
class _BarBody extends StatelessWidget {
  const _BarBody({
    required this.value,
    required this.color,
    required this.height,
    this.label,
    required this.modeLabel,
  });

  final double value;
  final Color color;
  final double height;
  final String? label;
  final String modeLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  label!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _kInk,
                  ),
                ),
                Text(
                  '${(value * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Stack(
            children: <Widget>[
              Container(
                height: height,
                width: double.infinity,
                color: color.withValues(alpha: 0.12),
              ),
              FractionallySizedBox(
                widthFactor: value,
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[color.withValues(alpha: 0.7), color],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'mode: $modeLabel  •  value: ${value.toStringAsFixed(3)}',
          style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.7)),
        ),
      ],
    );
  }
}

// ===========================================================================
// TAB 1 — Hero Banner
// ===========================================================================
class _HeroBannerTab extends StatelessWidget {
  const _HeroBannerTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        // Hero gradient card.
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF3D2B9E), Color(0xFF7C4DE8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Animation Repeat Modes',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'The four fundamental patterns for controlling how an animation '
                'repeats over time in Flutter.',
                style: TextStyle(fontSize: 14, color: Color(0xFFDDD9FF)),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const <Widget>[
                  _HeroChip(label: 'none', color: _kNone),
                  _HeroChip(label: 'loop', color: _kLoop),
                  _HeroChip(label: 'pingPong', color: _kPing),
                  _HeroChip(label: 'reverse', color: _kReverse),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _sectionHeader('What is RepeatMode?', _kSeed),
        _bodyText(
          'Flutter\'s animation system is built on the Tween + AnimationController '
          'pipeline.  RepeatMode is not a single Flutter enum but rather the '
          'conceptual category for how an animation behaves after it completes '
          'its first run.  Four patterns cover virtually every real-world use case.',
        ),
        _bodyText(
          'Understanding these patterns lets you choose the right tool — '
          'TweenAnimationBuilder, AnimationController.repeat(), or a custom '
          'Animation — without guessing.',
        ),
        _divider(),
        _sectionHeader('The Four Fundamental Patterns', _kSeed),
        const SizedBox(height: 8),
        const _PatternSummaryCard(
          mode: 'none',
          color: _kNone,
          headline: 'Single run, forward',
          description:
              'Animates from begin → end exactly once and then stops at the end '
              'value.  Ideal for entry transitions, one-shot reveals, and loading '
              'sequences that should not loop.',
          apiHint: 'AnimationController.forward()  •  TweenAnimationBuilder',
        ),
        const _PatternSummaryCard(
          mode: 'loop',
          color: _kLoop,
          headline: 'Continuous forward repetition',
          description:
              'After reaching the end, jumps back to the begin value and repeats '
              'immediately.  Produces a sawtooth waveform.  Perfect for spinners, '
              'progress pulses, and any effect that must never stop.',
          apiHint: 'AnimationController.repeat()  •  repeat(reverse: false)',
        ),
        const _PatternSummaryCard(
          mode: 'pingPong',
          color: _kPing,
          headline: 'Smooth forward + reverse repetition',
          description:
              'After reaching the end, reverses back to begin, then forward again — '
              'producing a triangle waveform with easing applied in both directions. '
              'Looks more natural than a raw loop for breathing, pulsing, and hover '
              'effects.',
          apiHint: 'AnimationController.repeat(reverse: true)',
        ),
        const _PatternSummaryCard(
          mode: 'reverse',
          color: _kReverse,
          headline: 'Single run, backward',
          description:
              'Animates from end → begin exactly once and then stops.  Use this for '
              'exit transitions, dismiss animations, and any effect that mirrors '
              '"none" in the opposite direction.',
          apiHint: 'AnimationController.reverse()  •  Tween(begin:1, end:0)',
        ),
        _divider(),
        _sectionHeader('Quick API Map', _kAccent),
        const SizedBox(height: 8),
        _Card(
          child: Column(
            children: <Widget>[
              _ApiRow('none', 'controller.forward()', _kNone),
              _ApiRow('loop', 'controller.repeat(reverse: false)', _kLoop),
              _ApiRow('pingPong', 'controller.repeat(reverse: true)', _kPing),
              _ApiRow('reverse', 'controller.reverse()', _kReverse),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _PatternSummaryCard extends StatelessWidget {
  const _PatternSummaryCard({
    required this.mode,
    required this.color,
    required this.headline,
    required this.description,
    required this.apiHint,
  });
  final String mode;
  final Color color;
  final String headline;
  final String description;
  final String apiHint;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.animation, color: color, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      mode,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: color,
                      ),
                    ),
                    Text(
                      headline,
                      style: const TextStyle(
                        fontSize: 12,
                        color: _kInk,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(description, style: const TextStyle(fontSize: 13, color: _kInk)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              apiHint,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: color.withValues(alpha: 0.85),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiRow extends StatelessWidget {
  const _ApiRow(this.mode, this.api, this.color);
  final String mode;
  final String api;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 80,
            child: Text(
              mode,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
          Expanded(
            child: Text(
              api,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                color: _kInk,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 2 — None (single run, forward)
// ===========================================================================
class _NoneTab extends StatelessWidget {
  const _NoneTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionHeader('Mode: none — single forward run', _kNone),
        _bodyText(
          'The animation plays from 0.0 to 1.0 exactly once.  After completion it '
          'holds at the final value.  Use "Restart" to replay from the beginning.',
        ),
        const SizedBox(height: 12),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Live demo',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kNone,
                ),
              ),
              const SizedBox(height: 12),
              _AnimatedBar(
                mode: _Mode.none,
                color: _kNone,
                height: 36,
                duration: const Duration(seconds: 2),
                curve: Curves.easeOut,
                label: 'progress (0 → 1)',
                restartNotifier: _noneRestartSignal,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ValueListenableBuilder<int>(
            valueListenable: _noneRestartSignal,
            builder: (BuildContext ctx, int v, Widget? _) {
              return ElevatedButton.icon(
                onPressed: () => _noneRestartSignal.value++,
                icon: const Icon(Icons.replay),
                label: Text('Restart (played $v time(s))'),
                style: ElevatedButton.styleFrom(backgroundColor: _kNone),
              );
            },
          ),
        ),
        _divider(),
        _sectionHeader('How it works', _kNone),
        _bodyText(
          'TweenAnimationBuilder(tween: Tween(begin: 0, end: 1), ...) '
          'drives the value from 0 to 1 on mount.  To replay, provide a new '
          'key so Flutter discards the old builder and creates a fresh one.',
        ),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _CodeLine('TweenAnimationBuilder<double>('),
              _CodeLine('  key: ValueKey(restartCount),   // fresh key → replay'),
              _CodeLine('  tween: Tween(begin: 0, end: 1),'),
              _CodeLine('  duration: Duration(seconds: 2),'),
              _CodeLine('  curve: Curves.easeOut,'),
              _CodeLine('  builder: (ctx, value, _) {'),
              _CodeLine('    return _YourWidget(progress: value);'),
              _CodeLine('  },'),
              _CodeLine(')'),
            ],
          ),
        ),
        _divider(),
        _sectionHeader('Three curves, same mode', _kNone),
        _bodyText(
          'Changing the curve does not change the repeat mode — it only changes '
          'the shape of progress over time.',
        ),
        const SizedBox(height: 8),
        ...const <_CurveNoneRow>[
          _CurveNoneRow(curveName: 'easeIn', curve: Curves.easeIn),
          _CurveNoneRow(curveName: 'easeOut', curve: Curves.easeOut),
          _CurveNoneRow(curveName: 'bounceOut', curve: Curves.bounceOut),
        ],
        _divider(),
        _sectionHeader('When to use none', _kNone),
        const SizedBox(height: 8),
        const _UseCaseRow(
          icon: Icons.login,
          title: 'Entry transitions',
          body: 'Slide in, fade in, scale up — play once on navigation.',
        ),
        const _UseCaseRow(
          icon: Icons.check_circle,
          title: 'Completion confirmations',
          body: 'A checkmark drawing, a progress bar filling to 100 %.',
        ),
        const _UseCaseRow(
          icon: Icons.swipe,
          title: 'Onboarding hints',
          body: 'A one-time swipe indicator that plays and then disappears.',
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _CurveNoneRow extends StatelessWidget {
  const _CurveNoneRow({required this.curveName, required this.curve});
  final String curveName;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: _AnimatedBar(
        mode: _Mode.none,
        color: _kNone,
        height: 28,
        duration: const Duration(seconds: 3),
        curve: curve,
        label: 'Curves.$curveName',
        restartNotifier: _noneRestartSignal,
      ),
    );
  }
}

class _UseCaseRow extends StatelessWidget {
  const _UseCaseRow({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: _kSeed, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
                Text(body, style: const TextStyle(fontSize: 12.5, color: _kInk)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeLine extends StatelessWidget {
  const _CodeLine(this.code);
  final String code;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        code,
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'monospace',
          color: Color(0xFF3D2B9E),
        ),
      ),
    );
  }
}

// ===========================================================================
// TAB 3 — Loop
// ===========================================================================
class _LoopTab extends StatelessWidget {
  const _LoopTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionHeader('Mode: loop — continuous repetition', _kLoop),
        _bodyText(
          'Once the animation reaches 1.0 it instantly resets to 0.0 and '
          'repeats.  This creates a sawtooth wave.  Use the slider to control '
          'speed.',
        ),
        const SizedBox(height: 12),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Live demo',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kLoop,
                ),
              ),
              const SizedBox(height: 12),
              _AnimatedBar(
                mode: _Mode.loop,
                color: _kLoop,
                height: 36,
                duration: const Duration(milliseconds: 1400),
                curve: Curves.linear,
                label: 'progress (loops)',
                speedNotifier: _loopSpeed,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Speed multiplier',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              ValueListenableBuilder<double>(
                valueListenable: _loopSpeed,
                builder: (BuildContext ctx, double speed, Widget? _) {
                  return Column(
                    children: <Widget>[
                      Slider(
                        value: speed,
                        min: 0.25,
                        max: 4.0,
                        divisions: 15,
                        label: '${speed.toStringAsFixed(2)}×',
                        activeColor: _kLoop,
                        onChanged: (double v) => _loopSpeed.value = v,
                      ),
                      Text(
                        '${speed.toStringAsFixed(2)}× — '
                        '${(1400 / speed).round()} ms per cycle',
                        style: const TextStyle(fontSize: 12, color: _kInk),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        _divider(),
        _sectionHeader('Waveform: sawtooth', _kLoop),
        _bodyText(
          'A loop produces a sawtooth wave: value climbs linearly then drops '
          'to zero instantaneously.  This can look choppy — use a fade or '
          'snap to mask the reset.',
        ),
        _Card(
          child: CustomPaint(
            size: const Size(double.infinity, 120),
            painter: _SawtoothPainter(),
          ),
        ),
        _divider(),
        _sectionHeader('How it works', _kLoop),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _CodeLine('// Using AnimationController:'),
              _CodeLine('controller.repeat(reverse: false);'),
              _CodeLine(''),
              _CodeLine('// Using TweenAnimationBuilder (stateless trick):'),
              _CodeLine('// Swap end value on completion using ValueNotifier'),
              _CodeLine('onEnd: () => endNotifier.value = 1 - endNotifier.value,'),
            ],
          ),
        ),
        _divider(),
        _sectionHeader('Multiple bars at different speeds', _kLoop),
        const SizedBox(height: 4),
        _LoopMultiBar(label: 'Slow (2 s)', durationMs: 2000),
        _LoopMultiBar(label: 'Medium (1 s)', durationMs: 1000),
        _LoopMultiBar(label: 'Fast (500 ms)', durationMs: 500),
        _divider(),
        _sectionHeader('When to use loop', _kLoop),
        const SizedBox(height: 4),
        const _UseCaseRow(
          icon: Icons.rotate_right,
          title: 'Loading spinner',
          body: 'A circular indicator that never stops until data arrives.',
        ),
        const _UseCaseRow(
          icon: Icons.wifi,
          title: 'Signal strength pulse',
          body: 'Repeating bar fills to show network activity.',
        ),
        const _UseCaseRow(
          icon: Icons.timer,
          title: 'Countdown shimmer',
          body: 'A background shimmer sweep that repeats until action taken.',
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _LoopMultiBar extends StatelessWidget {
  const _LoopMultiBar({required this.label, required this.durationMs});
  final String label;
  final int durationMs;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: _AnimatedBar(
        mode: _Mode.loop,
        color: _kLoop,
        height: 24,
        duration: Duration(milliseconds: durationMs),
        curve: Curves.linear,
        label: label,
      ),
    );
  }
}

class _SawtoothPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = _kLoop
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    final Path path = Path();
    const int cycles = 3;
    final double w = size.width / cycles;
    final double h = size.height;
    for (int i = 0; i < cycles; i++) {
      final double x0 = i * w;
      final double x1 = x0 + w;
      path.moveTo(x0, h - 8);
      path.lineTo(x1 - 2, 8);
      path.moveTo(x1 - 2, 8);
      path.lineTo(x1, h - 8);
    }
    canvas.drawPath(path, paint);
    // Labels
    final TextPainter tp = TextPainter(textDirection: TextDirection.ltr);
    tp.text = const TextSpan(
      text: 'sawtooth  (value snaps back to 0)',
      style: TextStyle(fontSize: 11, color: _kLoop),
    );
    tp.layout();
    tp.paint(canvas, Offset(8, h - 20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

// ===========================================================================
// TAB 4 — PingPong
// ===========================================================================
class _PingPongTab extends StatelessWidget {
  const _PingPongTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionHeader('Mode: pingPong — smooth forward + reverse', _kPing),
        _bodyText(
          'The animation plays 0 → 1, then reverses to 0, then repeats.  '
          'Unlike loop, the value never snaps — it eases in both directions, '
          'producing a smooth triangle wave.',
        ),
        const SizedBox(height: 12),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Live demo',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPing,
                ),
              ),
              const SizedBox(height: 12),
              _AnimatedBar(
                mode: _Mode.pingPong,
                color: _kPing,
                height: 36,
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeInOut,
                label: 'progress (pingPong)',
                speedNotifier: _pingSpeed,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Speed multiplier',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              ValueListenableBuilder<double>(
                valueListenable: _pingSpeed,
                builder: (BuildContext ctx, double speed, Widget? _) {
                  return Column(
                    children: <Widget>[
                      Slider(
                        value: speed,
                        min: 0.25,
                        max: 4.0,
                        divisions: 15,
                        label: '${speed.toStringAsFixed(2)}×',
                        activeColor: _kPing,
                        onChanged: (double v) => _pingSpeed.value = v,
                      ),
                      Text(
                        'Half-cycle: ${(1200 / speed).round()} ms each direction',
                        style: const TextStyle(fontSize: 12, color: _kInk),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        _divider(),
        _sectionHeader('Waveform: triangle', _kPing),
        _bodyText(
          'A pingPong produces a triangle wave: value rises, then falls, '
          'then rises again — with easing at the peaks.',
        ),
        _Card(
          child: CustomPaint(
            size: const Size(double.infinity, 120),
            painter: _TrianglePainter(),
          ),
        ),
        _divider(),
        _sectionHeader('PingPong vs Loop', _kPing),
        const SizedBox(height: 4),
        _Card(
          child: Column(
            children: <Widget>[
              _PingVsLoopRow('End value', 'snaps to 0', 'smoothly reverses'),
              _PingVsLoopRow('Waveform', 'sawtooth', 'triangle'),
              _PingVsLoopRow('Feel', 'mechanical', 'organic'),
              _PingVsLoopRow(
                'Best for',
                'spinners, tickers',
                'breathing, pulsing',
              ),
            ],
          ),
        ),
        _divider(),
        _sectionHeader('How it works', _kPing),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _CodeLine('// AnimationController:'),
              _CodeLine('controller.repeat(reverse: true);'),
              _CodeLine(''),
              _CodeLine('// TweenAnimationBuilder (stateless):'),
              _CodeLine('// Swap tween direction on each completion'),
              _CodeLine('onEnd: () => endNotifier.value = 1 - endNotifier.value,'),
              _CodeLine('// But apply Curves.easeInOut in both directions!'),
            ],
          ),
        ),
        _divider(),
        _sectionHeader('Three curves in pingPong', _kPing),
        const SizedBox(height: 4),
        _PingCurveBar(label: 'Curves.linear', curve: Curves.linear),
        _PingCurveBar(label: 'Curves.easeInOut', curve: Curves.easeInOut),
        _PingCurveBar(label: 'Curves.fastOutSlowIn', curve: Curves.fastOutSlowIn),
        _divider(),
        _sectionHeader('When to use pingPong', _kPing),
        const _UseCaseRow(
          icon: Icons.favorite,
          title: 'Heartbeat pulse',
          body: 'Scale up → scale down repeatedly; smooth at both ends.',
        ),
        const _UseCaseRow(
          icon: Icons.wb_sunny,
          title: 'Breathing indicator',
          body: 'Opacity fades in and out to signal live connectivity.',
        ),
        const _UseCaseRow(
          icon: Icons.highlight,
          title: 'Attention highlight',
          body: 'A glow that grows and shrinks to draw the eye.',
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _PingVsLoopRow extends StatelessWidget {
  const _PingVsLoopRow(this.property, this.loop, this.ping);
  final String property;
  final String loop;
  final String ping;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 90,
            child: Text(
              property,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _kInk,
              ),
            ),
          ),
          Expanded(
            child: Text(
              loop,
              style: const TextStyle(fontSize: 12, color: _kLoop),
            ),
          ),
          Expanded(
            child: Text(
              ping,
              style: const TextStyle(fontSize: 12, color: _kPing),
            ),
          ),
        ],
      ),
    );
  }
}

class _PingCurveBar extends StatelessWidget {
  const _PingCurveBar({required this.label, required this.curve});
  final String label;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: _AnimatedBar(
        mode: _Mode.pingPong,
        color: _kPing,
        height: 24,
        duration: const Duration(milliseconds: 1400),
        curve: curve,
        label: label,
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = _kPing
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;
    final Path path = Path();
    const int cycles = 3;
    final double w = size.width / cycles;
    final double h = size.height;
    for (int i = 0; i < cycles; i++) {
      final double x0 = i * w;
      final double xMid = x0 + w / 2;
      final double x1 = x0 + w;
      if (i == 0) {
        path.moveTo(x0, h - 8);
      }
      path.lineTo(xMid, 8);
      path.lineTo(x1, h - 8);
    }
    canvas.drawPath(path, paint);
    final TextPainter tp = TextPainter(textDirection: TextDirection.ltr);
    tp.text = const TextSpan(
      text: 'triangle  (smooth reversal at each end)',
      style: TextStyle(fontSize: 11, color: _kPing),
    );
    tp.layout();
    tp.paint(canvas, Offset(8, h - 20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

// ===========================================================================
// TAB 5 — Reverse
// ===========================================================================
class _ReverseTab extends StatelessWidget {
  const _ReverseTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionHeader('Mode: reverse — single backward run', _kReverse),
        _bodyText(
          'The animation plays from 1.0 down to 0.0 exactly once, then stops.  '
          'This is the mirror of "none" and is used for exit/dismiss animations.',
        ),
        const SizedBox(height: 12),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Live demo',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kReverse,
                ),
              ),
              const SizedBox(height: 12),
              _AnimatedBar(
                mode: _Mode.reverse,
                color: _kReverse,
                height: 36,
                duration: const Duration(seconds: 2),
                curve: Curves.easeIn,
                label: 'progress (1 → 0)',
                restartNotifier: _reverseRestartSignal,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ValueListenableBuilder<int>(
            valueListenable: _reverseRestartSignal,
            builder: (BuildContext ctx, int v, Widget? _) {
              return ElevatedButton.icon(
                onPressed: () => _reverseRestartSignal.value++,
                icon: const Icon(Icons.replay),
                label: Text('Replay reverse ($v time(s))'),
                style: ElevatedButton.styleFrom(backgroundColor: _kReverse),
              );
            },
          ),
        ),
        _divider(),
        _sectionHeader('None vs Reverse', _kReverse),
        const SizedBox(height: 4),
        _Card(
          child: Column(
            children: <Widget>[
              Row(
                children: const <Widget>[
                  SizedBox(width: 100),
                  Expanded(
                    child: Text(
                      'none',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: _kNone,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'reverse',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: _kReverse,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              _NoneReverseRow('Direction', '0 → 1', '1 → 0'),
              _NoneReverseRow('Start value', '0.0', '1.0'),
              _NoneReverseRow('End value', '1.0', '0.0'),
              _NoneReverseRow('Use case', 'entry', 'exit'),
            ],
          ),
        ),
        _divider(),
        _sectionHeader('How it works', _kReverse),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _CodeLine('// AnimationController:'),
              _CodeLine('controller.reverse();'),
              _CodeLine(''),
              _CodeLine('// TweenAnimationBuilder:'),
              _CodeLine('TweenAnimationBuilder<double>('),
              _CodeLine('  tween: Tween(begin: 1.0, end: 0.0),   // reversed!'),
              _CodeLine('  duration: Duration(seconds: 2),'),
              _CodeLine('  curve: Curves.easeIn,'),
              _CodeLine('  builder: (ctx, value, _) => ...,'),
              _CodeLine(')'),
            ],
          ),
        ),
        _divider(),
        _sectionHeader('Reverse with multiple curves', _kReverse),
        const SizedBox(height: 4),
        _ReverseCurveBar(label: 'Curves.easeIn', curve: Curves.easeIn),
        _ReverseCurveBar(label: 'Curves.decelerate', curve: Curves.decelerate),
        _ReverseCurveBar(label: 'Curves.fastOutSlowIn', curve: Curves.fastOutSlowIn),
        _divider(),
        _sectionHeader('When to use reverse', _kReverse),
        const _UseCaseRow(
          icon: Icons.logout,
          title: 'Exit transitions',
          body: 'Slide out, fade out — play once on pop/dismiss.',
        ),
        const _UseCaseRow(
          icon: Icons.close,
          title: 'Dismiss animations',
          body: 'A modal shrinking away after the user taps close.',
        ),
        const _UseCaseRow(
          icon: Icons.undo,
          title: 'Undo reveal',
          body: 'Progress bar filling backwards to signal an undo action.',
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _NoneReverseRow extends StatelessWidget {
  const _NoneReverseRow(this.property, this.none, this.rev);
  final String property;
  final String none;
  final String rev;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Text(
              property,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(none, style: const TextStyle(fontSize: 12, color: _kNone)),
          ),
          Expanded(
            child: Text(rev, style: const TextStyle(fontSize: 12, color: _kReverse)),
          ),
        ],
      ),
    );
  }
}

class _ReverseCurveBar extends StatelessWidget {
  const _ReverseCurveBar({required this.label, required this.curve});
  final String label;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: _AnimatedBar(
        mode: _Mode.reverse,
        color: _kReverse,
        height: 24,
        duration: const Duration(seconds: 3),
        curve: curve,
        label: label,
        restartNotifier: _reverseRestartSignal,
      ),
    );
  }
}

// ===========================================================================
// TAB 6 — Curves + repeat
// ===========================================================================
class _CurvesTab extends StatelessWidget {
  const _CurvesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionHeader('Curves + Repeat Modes', _kAccent),
        _bodyText(
          'A curve shapes the progress function within a single cycle.  '
          'The repeat mode decides what happens when that cycle ends.  '
          'They are orthogonal — any curve can be combined with any repeat mode.',
        ),
        _divider(),
        _sectionHeader('Loop with various curves', _kLoop),
        const SizedBox(height: 4),
        _LoopCurveCard(
          label: 'linear (constant velocity)',
          curve: Curves.linear,
          description: 'Steady fill — good for progress bars.',
        ),
        _LoopCurveCard(
          label: 'easeInOut (gentle)',
          curve: Curves.easeInOut,
          description: 'Accelerates then decelerates — feels natural.',
        ),
        _LoopCurveCard(
          label: 'elasticIn (springy start)',
          curve: Curves.elasticIn,
          description: 'Overshoot on entry — dramatic effect.',
        ),
        _divider(),
        _sectionHeader('PingPong with various curves', _kPing),
        const SizedBox(height: 4),
        _PingCurveCard(
          label: 'easeInOut (default)',
          curve: Curves.easeInOut,
          description: 'The classic breathing feel.',
        ),
        _PingCurveCard(
          label: 'bounceInOut (playful)',
          curve: Curves.bounceInOut,
          description: 'Bounce at both ends — cartoon style.',
        ),
        _PingCurveCard(
          label: 'slowMiddle (emphasises extremes)',
          curve: Curves.slowMiddle,
          description: 'Pauses in the middle, rushes to the ends.',
        ),
        _divider(),
        _sectionHeader('Curve quick-reference', _kSeed),
        const SizedBox(height: 4),
        _Card(
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _chip('linear', _kInk),
              _chip('easeIn', _kNone),
              _chip('easeOut', _kNone),
              _chip('easeInOut', _kPing),
              _chip('decelerate', _kLoop),
              _chip('fastOutSlowIn', _kLoop),
              _chip('bounceIn', _kReverse),
              _chip('bounceOut', _kReverse),
              _chip('bounceInOut', _kReverse),
              _chip('elasticIn', _kAccent),
              _chip('elasticOut', _kAccent),
              _chip('slowMiddle', _kAccent),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _LoopCurveCard extends StatelessWidget {
  const _LoopCurveCard({
    required this.label,
    required this.curve,
    required this.description,
  });
  final String label;
  final Curve curve;
  final String description;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _AnimatedBar(
            mode: _Mode.loop,
            color: _kLoop,
            height: 28,
            duration: const Duration(milliseconds: 1600),
            curve: curve,
            label: label,
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(fontSize: 12, color: _kInk),
          ),
        ],
      ),
    );
  }
}

class _PingCurveCard extends StatelessWidget {
  const _PingCurveCard({
    required this.label,
    required this.curve,
    required this.description,
  });
  final String label;
  final Curve curve;
  final String description;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _AnimatedBar(
            mode: _Mode.pingPong,
            color: _kPing,
            height: 28,
            duration: const Duration(milliseconds: 1400),
            curve: curve,
            label: label,
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(fontSize: 12, color: _kInk),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 7 — Comparison Grid
// ===========================================================================
class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionHeader('Side-by-side: all 4 modes', _kSeed),
        _bodyText(
          'All four modes run simultaneously at the same speed.  Observe the '
          'differences in waveform shape, continuity, and direction.',
        ),
        const SizedBox(height: 12),
        _Card(
          child: Column(
            children: <Widget>[
              _AnimatedBar(
                mode: _Mode.none,
                color: _kNone,
                height: 32,
                duration: const Duration(seconds: 2),
                curve: Curves.easeOut,
                label: 'none',
                restartNotifier: _noneRestartSignal,
              ),
              const SizedBox(height: 14),
              _AnimatedBar(
                mode: _Mode.loop,
                color: _kLoop,
                height: 32,
                duration: const Duration(seconds: 2),
                curve: Curves.linear,
                label: 'loop',
              ),
              const SizedBox(height: 14),
              _AnimatedBar(
                mode: _Mode.pingPong,
                color: _kPing,
                height: 32,
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                label: 'pingPong',
              ),
              const SizedBox(height: 14),
              _AnimatedBar(
                mode: _Mode.reverse,
                color: _kReverse,
                height: 32,
                duration: const Duration(seconds: 2),
                curve: Curves.easeIn,
                label: 'reverse',
                restartNotifier: _reverseRestartSignal,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _noneRestartSignal.value++;
                    _reverseRestartSignal.value++;
                  },
                  icon: const Icon(Icons.replay),
                  label: const Text('Restart one-shots'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kSeed,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        _divider(),
        _sectionHeader('Key differences at a glance', _kSeed),
        const SizedBox(height: 4),
        _Card(
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(1),
            },
            children: <TableRow>[
              _tableHeader(<String>['Property', 'none', 'loop', 'pingPong', 'reverse']),
              _tableRow(<String>['Direction', 'fwd', 'fwd', 'fwd↔rev', 'rev']),
              _tableRow(<String>['Repeat?', 'No', 'Yes', 'Yes', 'No']),
              _tableRow(<String>['Waveform', '—', 'sawtooth', 'triangle', '—']),
              _tableRow(<String>['Snaps?', 'No', 'Yes', 'No', 'No']),
              _tableRow(<String>['End value', '1.0', '∞', '∞', '0.0']),
            ],
          ),
        ),
        _divider(),
        _sectionHeader('Animated circles — 4 modes', _kSeed),
        const SizedBox(height: 8),
        _Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const <Widget>[
              _CircleMode(mode: _Mode.none, color: _kNone, label: 'none'),
              _CircleMode(mode: _Mode.loop, color: _kLoop, label: 'loop'),
              _CircleMode(mode: _Mode.pingPong, color: _kPing, label: 'pingPong'),
              _CircleMode(mode: _Mode.reverse, color: _kReverse, label: 'reverse'),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

TableRow _tableHeader(List<String> cells) {
  return TableRow(
    decoration: BoxDecoration(color: _kSeed.withValues(alpha: 0.1)),
    children: cells
        .map(
          (String c) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Text(
              c,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _kInk,
              ),
            ),
          ),
        )
        .toList(),
  );
}

TableRow _tableRow(List<String> cells) {
  return TableRow(
    children: cells
        .map(
          (String c) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
            child: Text(c, style: const TextStyle(fontSize: 11, color: _kInk)),
          ),
        )
        .toList(),
  );
}

class _CircleMode extends StatelessWidget {
  const _CircleMode({
    required this.mode,
    required this.color,
    required this.label,
  });
  final _Mode mode;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final Widget bar = _AnimatedBar(
      mode: mode,
      color: color,
      height: 60,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      restartNotifier: mode == _Mode.none
          ? _noneRestartSignal
          : mode == _Mode.reverse
              ? _reverseRestartSignal
              : null,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 70,
          child: bar,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}

// ===========================================================================
// TAB 8 — Use Cases
// ===========================================================================
class _UseCasesTab extends StatelessWidget {
  const _UseCasesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionHeader('Real-world use cases', _kSeed),
        _bodyText(
          'Six mini-demos showing how repeat modes map to everyday UI effects.',
        ),
        const SizedBox(height: 12),
        const _LoadingSpinnerCard(),
        const SizedBox(height: 10),
        const _HeartbeatCard(),
        const SizedBox(height: 10),
        const _ProgressBarCard(),
        const SizedBox(height: 10),
        const _ShakeAlertCard(),
        const SizedBox(height: 10),
        const _FadeInCard(),
        const SizedBox(height: 10),
        const _DismissCard(),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _LoadingSpinnerCard extends StatelessWidget {
  const _LoadingSpinnerCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      color: _kSurfaceAlt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _chip('loop', _kLoop),
              const SizedBox(width: 8),
              const Text(
                'Loading Spinner',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _AnimatedBar(
            mode: _Mode.loop,
            color: _kLoop,
            height: 10,
            duration: const Duration(milliseconds: 900),
            curve: Curves.linear,
            label: 'rotating fill',
          ),
          const SizedBox(height: 8),
          const Text(
            'A spinning indicator uses loop mode: value goes 0→1→0→1 '
            'indefinitely.  Typically mapped to a rotation angle (0→2π).',
            style: TextStyle(fontSize: 12, color: _kInk),
          ),
        ],
      ),
    );
  }
}

class _HeartbeatCard extends StatelessWidget {
  const _HeartbeatCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      color: _kSurfaceAlt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _chip('pingPong', _kPing),
              const SizedBox(width: 8),
              const Text(
                'Heartbeat Pulse',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _AnimatedBar(
            mode: _Mode.pingPong,
            color: _kPing,
            height: 10,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            label: 'scale factor',
          ),
          const SizedBox(height: 8),
          const Text(
            'A heartbeat uses pingPong: scale goes 1.0→1.3→1.0 repeatedly '
            'with smooth easing at both peaks.',
            style: TextStyle(fontSize: 12, color: _kInk),
          ),
        ],
      ),
    );
  }
}

class _ProgressBarCard extends StatelessWidget {
  const _ProgressBarCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      color: _kSurfaceAlt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _chip('none', _kNone),
              const SizedBox(width: 8),
              const Text(
                'Progress Bar',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _AnimatedBar(
            mode: _Mode.none,
            color: _kNone,
            height: 16,
            duration: const Duration(seconds: 3),
            curve: Curves.easeOut,
            label: 'upload progress',
            restartNotifier: _noneRestartSignal,
          ),
          const SizedBox(height: 8),
          const Text(
            'A determinate progress bar uses none: fills 0→100% once and '
            'holds.  Button above restarts to simulate a new upload.',
            style: TextStyle(fontSize: 12, color: _kInk),
          ),
        ],
      ),
    );
  }
}

class _ShakeAlertCard extends StatelessWidget {
  const _ShakeAlertCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      color: _kSurfaceAlt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _chip('pingPong (fast)', _kReverse),
              const SizedBox(width: 8),
              const Text(
                'Shake Alert',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _AnimatedBar(
            mode: _Mode.pingPong,
            color: _kReverse,
            height: 10,
            duration: const Duration(milliseconds: 80),
            curve: Curves.linear,
            label: 'horizontal offset',
          ),
          const SizedBox(height: 8),
          const Text(
            'A shake alert uses fast pingPong: horizontal offset oscillates '
            '-10px→+10px at 80ms/cycle for the duration of the shake.',
            style: TextStyle(fontSize: 12, color: _kInk),
          ),
        ],
      ),
    );
  }
}

class _FadeInCard extends StatelessWidget {
  const _FadeInCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      color: _kSurfaceAlt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _chip('none', _kNone),
              const SizedBox(width: 8),
              const Text(
                'Fade-In Transition',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _AnimatedBar(
            mode: _Mode.none,
            color: _kNone,
            height: 10,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeIn,
            label: 'opacity',
            restartNotifier: _noneRestartSignal,
          ),
          const SizedBox(height: 8),
          const Text(
            'Screen transitions fade in with none mode: opacity 0→1 once. '
            'Navigator.push wraps the new route in a FadeTransition.',
            style: TextStyle(fontSize: 12, color: _kInk),
          ),
        ],
      ),
    );
  }
}

class _DismissCard extends StatelessWidget {
  const _DismissCard();

  @override
  Widget build(BuildContext context) {
    return _Card(
      color: _kSurfaceAlt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _chip('reverse', _kReverse),
              const SizedBox(width: 8),
              const Text(
                'Dismiss / Exit',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _AnimatedBar(
            mode: _Mode.reverse,
            color: _kReverse,
            height: 10,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            label: 'scale / opacity',
            restartNotifier: _reverseRestartSignal,
          ),
          const SizedBox(height: 8),
          const Text(
            'A dismissal uses reverse: the widget shrinks/fades 1→0 once '
            'and then is removed from the tree.  Use Navigator.pop after '
            'the animation completes.',
            style: TextStyle(fontSize: 12, color: _kInk),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// TAB 9 — Diagram (CustomPainter timeline)
// ===========================================================================
class _DiagramTab extends StatelessWidget {
  const _DiagramTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _sectionHeader('Value-over-time diagrams', _kSeed),
        _bodyText(
          'Each diagram plots the animation value (y-axis, 0.0–1.0) over '
          'normalised time (x-axis, 0–3 cycles).  Solid lines show the actual '
          'path; a dotted line marks value = 0.5 for reference.',
        ),
        const SizedBox(height: 12),
        _DiagramCard(
          title: 'none',
          color: _kNone,
          painter: _NoneDiagramPainter(),
          description: 'Rises from 0 to 1 once (easeOut curve), then holds at 1.',
        ),
        const SizedBox(height: 10),
        _DiagramCard(
          title: 'loop',
          color: _kLoop,
          painter: _LoopDiagramPainter(),
          description: 'Sawtooth: rises 0→1 then snaps back to 0, repeats.',
        ),
        const SizedBox(height: 10),
        _DiagramCard(
          title: 'pingPong',
          color: _kPing,
          painter: _PingPongDiagramPainter(),
          description: 'Triangle: rises 0→1 then smoothly falls 1→0, repeats.',
        ),
        const SizedBox(height: 10),
        _DiagramCard(
          title: 'reverse',
          color: _kReverse,
          painter: _ReverseDiagramPainter(),
          description: 'Falls from 1 to 0 once (easeIn curve), then holds at 0.',
        ),
        _divider(),
        _sectionHeader('API Cheat Sheet', _kSeed),
        const SizedBox(height: 4),
        _Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              _CheatRow(
                mode: 'none',
                color: _kNone,
                snippet: 'TweenAnimationBuilder(\n'
                    '  tween: Tween(begin:0, end:1),\n'
                    '  duration: ...,\n'
                    '  builder: (ctx,v,_) => ...,\n'
                    ')',
              ),
              SizedBox(height: 12),
              _CheatRow(
                mode: 'loop',
                color: _kLoop,
                snippet: 'AnimationController(\n'
                    '  vsync: this,\n'
                    '  duration: ...,\n'
                    ')..repeat(reverse: false)',
              ),
              SizedBox(height: 12),
              _CheatRow(
                mode: 'pingPong',
                color: _kPing,
                snippet: 'AnimationController(\n'
                    '  vsync: this,\n'
                    '  duration: ...,\n'
                    ')..repeat(reverse: true)',
              ),
              SizedBox(height: 12),
              _CheatRow(
                mode: 'reverse',
                color: _kReverse,
                snippet: 'TweenAnimationBuilder(\n'
                    '  tween: Tween(begin:1, end:0),\n'
                    '  duration: ...,\n'
                    '  builder: (ctx,v,_) => ...,\n'
                    ')',
              ),
            ],
          ),
        ),
        _divider(),
        _sectionHeader('Flutter framework notes', _kSeed),
        _bodyText(
          '• RepeatMode is not a Flutter enum in the public API (as of Flutter 3.x).  '
          'Some packages (e.g. Lottie, Rive) define their own RepeatMode enum.  '
          'In core Flutter, repeat behaviour is controlled via AnimationController '
          'methods: forward(), reverse(), repeat(reverse: bool).',
        ),
        _bodyText(
          '• TweenAnimationBuilder is stateless-friendly.  Provide a ValueKey '
          'based on a restart counter to replay "none" and "reverse" animations.',
        ),
        _bodyText(
          '• For loop and pingPong without StatefulWidget, use a top-level '
          'ValueNotifier to swap the tween end value on each onEnd callback.  '
          'This triggers a rebuild with a new key, restarting the tween.',
        ),
        _bodyText(
          '• Curves.linear produces the purest waveform.  Non-linear curves '
          'distort the waveform but do not change the repeat mode itself.',
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _DiagramCard extends StatelessWidget {
  const _DiagramCard({
    required this.title,
    required this.color,
    required this.painter,
    required this.description,
  });
  final String title;
  final Color color;
  final CustomPainter painter;
  final String description;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CustomPaint(
            size: const Size(double.infinity, 130),
            painter: painter,
          ),
          const SizedBox(height: 6),
          Text(description, style: const TextStyle(fontSize: 12, color: _kInk)),
        ],
      ),
    );
  }
}

class _CheatRow extends StatelessWidget {
  const _CheatRow({
    required this.mode,
    required this.color,
    required this.snippet,
  });
  final String mode;
  final Color color;
  final String snippet;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 80,
          child: Text(
            mode,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              snippet,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: color.withValues(alpha: 0.85),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Diagram painters.
// ---------------------------------------------------------------------------

/// Shared helper: draw axes + midline on canvas.
void _drawAxes(Canvas canvas, Size size, Color color) {
  final Paint axisPaint = Paint()
    ..color = _kBorder
    ..strokeWidth = 1;
  // x-axis (bottom)
  canvas.drawLine(Offset(0, size.height - 16), Offset(size.width, size.height - 16), axisPaint);
  // y-axis (left)
  canvas.drawLine(const Offset(20, 0), Offset(20, size.height - 16), axisPaint);
  // mid-line dotted
  final Paint dotPaint = Paint()
    ..color = _kBorder
    ..strokeWidth = 1
    ..style = PaintingStyle.stroke;
  for (double x = 20; x < size.width; x += 8) {
    canvas.drawLine(
      Offset(x, (size.height - 16) / 2),
      Offset(x + 4, (size.height - 16) / 2),
      dotPaint,
    );
  }
  // labels
  final TextPainter tp = TextPainter(textDirection: TextDirection.ltr);
  tp.text = const TextSpan(text: '1.0', style: TextStyle(fontSize: 9, color: _kBorder));
  tp.layout();
  tp.paint(canvas, const Offset(2, 2));
  tp.text = const TextSpan(text: '0.0', style: TextStyle(fontSize: 9, color: _kBorder));
  tp.layout();
  tp.paint(canvas, Offset(2, size.height - 28));
}

Offset _pt(Size size, double normX, double normY) {
  final double usableW = size.width - 24;
  final double usableH = size.height - 20;
  return Offset(20 + normX * usableW, (1 - normY) * usableH + 2);
}

class _NoneDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawAxes(canvas, size, _kNone);
    final Paint p = Paint()
      ..color = _kNone
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Path path = Path();
    // easeOut approximation: y = 1 - (1-x)^3 for x in [0, 1/3], then hold
    path.moveTo(_pt(size, 0, 0).dx, _pt(size, 0, 0).dy);
    for (int i = 1; i <= 60; i++) {
      final double t = i / 60.0;
      final double x = t * (1 / 3.0);
      final double y = t < 1.0 ? 1 - (1 - t) * (1 - t) * (1 - t) : 1.0;
      path.lineTo(_pt(size, x, y).dx, _pt(size, x, y).dy);
    }
    // hold at 1 from 1/3 to 1
    path.lineTo(_pt(size, 1.0, 1.0).dx, _pt(size, 1.0, 1.0).dy);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _LoopDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawAxes(canvas, size, _kLoop);
    final Paint p = Paint()
      ..color = _kLoop
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const int cycles = 3;
    final Path path = Path();
    for (int c = 0; c < cycles; c++) {
      final double x0 = c / cycles.toDouble();
      final double x1 = (c + 1) / cycles.toDouble();
      path.moveTo(_pt(size, x0, 0).dx, _pt(size, x0, 0).dy);
      path.lineTo(_pt(size, x1 - 0.005, 1).dx, _pt(size, x1 - 0.005, 1).dy);
    }
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _PingPongDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawAxes(canvas, size, _kPing);
    final Paint p = Paint()
      ..color = _kPing
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const int halfCycles = 5;
    final Path path = Path();
    path.moveTo(_pt(size, 0, 0).dx, _pt(size, 0, 0).dy);
    for (int h = 0; h < halfCycles; h++) {
      final double x0 = h / halfCycles.toDouble();
      final double x1 = (h + 1) / halfCycles.toDouble();
      final bool up = h % 2 == 0;
      for (int i = 1; i <= 20; i++) {
        final double t = i / 20.0;
        // easeInOut approx: 3t² - 2t³
        final double eased = 3 * t * t - 2 * t * t * t;
        final double x = x0 + t * (x1 - x0);
        final double y = up ? eased : 1 - eased;
        path.lineTo(_pt(size, x, y).dx, _pt(size, x, y).dy);
      }
    }
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _ReverseDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawAxes(canvas, size, _kReverse);
    final Paint p = Paint()
      ..color = _kReverse
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final Path path = Path();
    path.moveTo(_pt(size, 0, 1).dx, _pt(size, 0, 1).dy);
    for (int i = 1; i <= 60; i++) {
      final double t = i / 60.0;
      // easeIn approx: t³
      final double x = t * (1 / 3.0);
      final double eased = t < 1.0 ? t * t * t : 1.0;
      final double y = 1 - eased;
      path.lineTo(_pt(size, x, y).dx, _pt(size, x, y).dy);
    }
    // hold at 0 from 1/3 to 1
    path.lineTo(_pt(size, 1.0, 0.0).dx, _pt(size, 1.0, 0.0).dy);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

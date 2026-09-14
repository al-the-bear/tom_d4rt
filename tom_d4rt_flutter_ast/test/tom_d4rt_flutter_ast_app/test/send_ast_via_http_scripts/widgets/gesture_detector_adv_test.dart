// D4rt deep visual demo: GestureDetector (advanced)
// Stateless only; top-level ValueNotifiers hold mutable state.
// Entry point: dynamic build(BuildContext context).

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ============================================================================
// Top-level notifiers — stateless widgets read via ValueListenableBuilder.
// ============================================================================

// Tap family.
final ValueNotifier<List<String>> tapLog = ValueNotifier<List<String>>(
  <String>[],
);
final ValueNotifier<int> tapCount = ValueNotifier<int>(0);
final ValueNotifier<int> doubleTapCount = ValueNotifier<int>(0);
final ValueNotifier<int> longPressCount = ValueNotifier<int>(0);
final ValueNotifier<Offset> lastTapDown = ValueNotifier<Offset>(Offset.zero);
final ValueNotifier<Offset> lastTapUp = ValueNotifier<Offset>(Offset.zero);
final ValueNotifier<bool> tapCanceledFlag = ValueNotifier<bool>(false);
final ValueNotifier<bool> doubleTapCanceledFlag = ValueNotifier<bool>(false);

// Long-press family.
final ValueNotifier<Offset> longPressPosition = ValueNotifier<Offset>(
  const Offset(120, 60),
);
final ValueNotifier<double> longPressProgress = ValueNotifier<double>(0);
final ValueNotifier<bool> longPressActive = ValueNotifier<bool>(false);
final ValueNotifier<List<String>> longPressLog = ValueNotifier<List<String>>(
  <String>[],
);

// Pan/Drag family.
final ValueNotifier<Offset> dragCardPosition = ValueNotifier<Offset>(
  const Offset(40, 40),
);
final ValueNotifier<double> horizontalLaneX = ValueNotifier<double>(16);
final ValueNotifier<double> verticalLaneY = ValueNotifier<double>(16);
final ValueNotifier<int> panEventCount = ValueNotifier<int>(0);
final ValueNotifier<Velocity> lastPanVelocity = ValueNotifier<Velocity>(
  Velocity.zero,
);

// Scale/Pinch.
final ValueNotifier<double> pinchScale = ValueNotifier<double>(1.0);
final ValueNotifier<double> pinchRotation = ValueNotifier<double>(0.0);
final ValueNotifier<int> pinchPointerCount = ValueNotifier<int>(0);
final ValueNotifier<Offset> pinchFocalPoint = ValueNotifier<Offset>(
  const Offset(140, 140),
);

// Secondary / Tertiary.
final ValueNotifier<int> secondaryTapCount = ValueNotifier<int>(0);
final ValueNotifier<int> secondaryLongPressCount = ValueNotifier<int>(0);
final ValueNotifier<int> tertiaryTapCount = ValueNotifier<int>(0);
final ValueNotifier<int> tertiaryLongPressCount = ValueNotifier<int>(0);

// HitTestBehavior.
final ValueNotifier<int> layerDeferCount = ValueNotifier<int>(0);
final ValueNotifier<int> layerOpaqueCount = ValueNotifier<int>(0);
final ValueNotifier<int> layerTranslucentCount = ValueNotifier<int>(0);
final ValueNotifier<int> layerBackdropCount = ValueNotifier<int>(0);

// Gesture arena viz.
final ValueNotifier<int> arenaFrame = ValueNotifier<int>(0);

// Semantics toggle.
final ValueNotifier<bool> excludeSemantics = ValueNotifier<bool>(false);
final ValueNotifier<int> semanticsTapCount = ValueNotifier<int>(0);

// Use-cases gallery.
final ValueNotifier<bool> dismissibleDismissed = ValueNotifier<bool>(false);
final ValueNotifier<List<String>> reorderList = ValueNotifier<List<String>>(
  <String>['Alpha', 'Bravo', 'Charlie', 'Delta', 'Echo'],
);
final ValueNotifier<int?> reorderDragIndex = ValueNotifier<int?>(null);
final ValueNotifier<double> photoZoom = ValueNotifier<double>(1.0);
final ValueNotifier<Offset> photoPan = ValueNotifier<Offset>(Offset.zero);
final ValueNotifier<int> likeCount = ValueNotifier<int>(0);
final ValueNotifier<bool> likeBurst = ValueNotifier<bool>(false);
final ValueNotifier<bool> menuVisible = ValueNotifier<bool>(false);
final ValueNotifier<double> scratchRevealed = ValueNotifier<double>(0);
final ValueNotifier<List<Offset>> scratchStrokes = ValueNotifier<List<Offset>>(
  <Offset>[],
);

// ----------------------------------------------------------------------------
// Logging helpers.
// ----------------------------------------------------------------------------

void _pushTapLog(String line) {
  final List<String> next = <String>[line, ...tapLog.value];
  tapLog.value = next.length > 14 ? next.sublist(0, 14) : next;
}

void _pushLongPressLog(String line) {
  final List<String> next = <String>[line, ...longPressLog.value];
  longPressLog.value = next.length > 10 ? next.sublist(0, 10) : next;
}

String _fmtOffset(Offset o) {
  return '(${o.dx.toStringAsFixed(1)}, ${o.dy.toStringAsFixed(1)})';
}

// ============================================================================
// Entry point.
// ============================================================================

dynamic build(BuildContext context) {
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF4F46E5),
    brightness: Brightness.light,
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true, colorScheme: scheme),
    home: DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GestureDetector — advanced tour'),
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.touch_app_outlined), text: 'Intro'),
              Tab(icon: Icon(Icons.ads_click), text: 'Tap family'),
              Tab(icon: Icon(Icons.timer_outlined), text: 'Long press'),
              Tab(icon: Icon(Icons.pan_tool_alt_outlined), text: 'Pan/Drag'),
              Tab(icon: Icon(Icons.pinch_outlined), text: 'Scale/Pinch'),
              Tab(icon: Icon(Icons.mouse_outlined), text: 'Secondary/Tertiary'),
              Tab(icon: Icon(Icons.layers_outlined), text: 'HitTestBehavior'),
              Tab(icon: Icon(Icons.stadium_outlined), text: 'Gesture arena'),
              Tab(icon: Icon(Icons.accessibility_new), text: 'Semantics'),
              Tab(icon: Icon(Icons.collections_bookmark), text: 'Gallery'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _IntroTab(),
            _TapFamilyTab(),
            _LongPressTab(),
            _PanDragTab(),
            _ScalePinchTab(),
            _SecondaryTertiaryTab(),
            _HitTestBehaviorTab(),
            _GestureArenaTab(),
            _SemanticsTab(),
            _GalleryTab(),
          ],
        ),
        bottomNavigationBar: const _CheatSheetBar(),
      ),
    ),
  );
}

// ============================================================================
// Shared visual primitives.
// ============================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title, this.hint});

  final IconData icon;
  final String title;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: scheme.onPrimaryContainer),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (hint != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      hint!,
                      style: Theme.of(context).textTheme.bodySmall,
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

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color tint = scheme.secondaryContainer;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: tint.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            Text(body, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.label,
    required this.value,
    this.icon,
    this.color,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: (color ?? scheme.surfaceContainerHighest).withValues(
          alpha: 0.9,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 16, color: scheme.primary),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontFeatures: const <FontFeature>[
                    FontFeature.tabularFigures(),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}

class _LogPane extends StatelessWidget {
  const _LogPane({required this.notifier, required this.title, this.height});

  final ValueNotifier<List<String>> notifier;
  final String title;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.receipt_long, size: 18, color: scheme.primary),
              const SizedBox(width: 6),
              Text(title, style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: height ?? 160,
            child: ValueListenableBuilder<List<String>>(
              valueListenable: notifier,
              builder: (BuildContext ctx, List<String> lines, Widget? _) {
                if (lines.isEmpty) {
                  return Center(
                    child: Text(
                      'No events yet — interact above.',
                      style: Theme.of(ctx).textTheme.bodySmall,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: lines.length,
                  itemBuilder: (BuildContext c, int i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 28,
                            child: Text(
                              '${lines.length - i}',
                              style: Theme.of(c).textTheme.labelSmall,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              lines[i],
                              style: Theme.of(c).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 1) INTRO tab.
// ============================================================================

class _IntroTab extends StatelessWidget {
  const _IntroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                scheme.primary,
                scheme.tertiary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.touch_app_outlined,
                    size: 42,
                    color: scheme.onPrimary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'GestureDetector',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            color: scheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Flutter\'s most versatile gesture-handling widget.\n'
                'Wire taps, long-presses, pans, pinches, rotations, secondary and tertiary pointers, '
                'all while controlling hit-testing behavior and semantics exposure.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: scheme.onPrimary,
                    ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const <Widget>[
                  _HeroPill(label: 'Tap', icon: Icons.ads_click),
                  _HeroPill(label: 'Double-tap', icon: Icons.double_arrow),
                  _HeroPill(label: 'Long-press', icon: Icons.timer_outlined),
                  _HeroPill(label: 'Pan', icon: Icons.pan_tool_outlined),
                  _HeroPill(label: 'Scale', icon: Icons.pinch_outlined),
                  _HeroPill(
                    label: 'Secondary',
                    icon: Icons.mouse_outlined,
                  ),
                  _HeroPill(label: 'Tertiary', icon: Icons.circle_outlined),
                  _HeroPill(label: 'Arena', icon: Icons.stadium_outlined),
                  _HeroPill(
                    label: 'Semantics',
                    icon: Icons.accessibility_new,
                  ),
                ],
              ),
            ],
          ),
        ),
        const _SectionHeader(
          icon: Icons.info_outline,
          title: 'Why GestureDetector is powerful',
          hint: 'One widget — many recognizers — cooperative arena',
        ),
        const _InfoCard(
          title: 'Composable callbacks',
          body: 'Every gesture family is optional. Declare only what you need, '
              'and Flutter enters the matching recognizers into the gesture arena. '
              'The winner receives the stream of events; the losers are cancelled.',
        ),
        const _InfoCard(
          title: 'Hit-test behavior controls event routing',
          body: 'HitTestBehavior.deferToChild (default) lets only the child decide. '
              'opaque claims the whole bounding rect; translucent allows events to '
              'continue to widgets under it as well.',
        ),
        const _InfoCard(
          title: 'Semantics participation',
          body: 'Setting excludeFromSemantics: true hides the detector from '
              'screen readers. Use it carefully — only when a nested widget is '
              'already exposing a proper semantic action.',
        ),
        const _InfoCard(
          title: 'Drag start behavior',
          body: 'dragStartBehavior: DragStartBehavior.down starts drags on the '
              'first pointer-down (snappier); .start (default) waits until movement '
              'exceeds slop — preventing accidental drags during taps.',
        ),
        const _InfoCard(
          title: 'Trackpad scroll handling',
          body: 'trackpadScrollCausesScale: true reinterprets two-finger '
              'trackpad scrolls as scale gestures, matching desktop pinch-to-zoom '
              'expectations.',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Card(
            elevation: 0,
            color: scheme.surfaceContainerLow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: scheme.outlineVariant),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'What you will explore',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  _BulletLine(
                    icon: Icons.ads_click,
                    text: 'Tap family — down/up/cancel/double-tap/long-press',
                  ),
                  _BulletLine(
                    icon: Icons.timer_outlined,
                    text: 'Long-press streaming with live position tracking',
                  ),
                  _BulletLine(
                    icon: Icons.pan_tool_alt_outlined,
                    text: 'Pan/drag with velocity and axis constraints',
                  ),
                  _BulletLine(
                    icon: Icons.pinch_outlined,
                    text: 'Scale including rotation and focal-point tracking',
                  ),
                  _BulletLine(
                    icon: Icons.mouse_outlined,
                    text: 'Secondary and tertiary pointer handling',
                  ),
                  _BulletLine(
                    icon: Icons.layers_outlined,
                    text: 'HitTestBehavior with stacked layer visualization',
                  ),
                  _BulletLine(
                    icon: Icons.stadium_outlined,
                    text: 'Gesture arena — how recognizers compete',
                  ),
                  _BulletLine(
                    icon: Icons.accessibility_new,
                    text: 'Semantics exposure and excludeFromSemantics',
                  ),
                  _BulletLine(
                    icon: Icons.collections_bookmark,
                    text: 'Practical use-case gallery',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.onPrimary.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.onPrimary.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: scheme.onPrimary),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: scheme.onPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 16, color: scheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 2) TAP FAMILY tab.
// ============================================================================

class _TapFamilyTab extends StatelessWidget {
  const _TapFamilyTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: <Widget>[
        const _SectionHeader(
          icon: Icons.ads_click,
          title: 'Tap family — every callback wired',
          hint:
              'onTap, onTapDown, onTapUp, onTapCancel, onDoubleTap*, onLongPress*',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ValueListenableBuilder<int>(
            valueListenable: tapCount,
            builder: (BuildContext ctx, int count, Widget? _) {
              return ValueListenableBuilder<int>(
                valueListenable: doubleTapCount,
                builder: (BuildContext ctx, int dtc, Widget? _) {
                  return ValueListenableBuilder<int>(
                    valueListenable: longPressCount,
                    builder: (BuildContext ctx, int lpc, Widget? _) {
                      return Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: <Widget>[
                          _StatChip(
                            label: 'taps',
                            value: '$count',
                            icon: Icons.ads_click,
                          ),
                          _StatChip(
                            label: 'double-taps',
                            value: '$dtc',
                            icon: Icons.swap_calls,
                          ),
                          _StatChip(
                            label: 'long-presses',
                            value: '$lpc',
                            icon: Icons.timer_outlined,
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              tapCount.value = tapCount.value + 1;
              _pushTapLog('onTap #${tapCount.value}');
            },
            onTapDown: (TapDownDetails d) {
              lastTapDown.value = d.localPosition;
              _pushTapLog('onTapDown @ ${_fmtOffset(d.localPosition)}');
            },
            onTapUp: (TapUpDetails d) {
              lastTapUp.value = d.localPosition;
              _pushTapLog('onTapUp @ ${_fmtOffset(d.localPosition)}');
            },
            onTapCancel: () {
              tapCanceledFlag.value = !tapCanceledFlag.value;
              _pushTapLog('onTapCancel');
            },
            onDoubleTap: () {
              doubleTapCount.value = doubleTapCount.value + 1;
              _pushTapLog('onDoubleTap #${doubleTapCount.value}');
            },
            onDoubleTapDown: (TapDownDetails d) {
              _pushTapLog('onDoubleTapDown @ ${_fmtOffset(d.localPosition)}');
            },
            onDoubleTapCancel: () {
              doubleTapCanceledFlag.value = !doubleTapCanceledFlag.value;
              _pushTapLog('onDoubleTapCancel');
            },
            onLongPress: () {
              longPressCount.value = longPressCount.value + 1;
              _pushTapLog('onLongPress #${longPressCount.value}');
            },
            onLongPressStart: (LongPressStartDetails d) {
              _pushTapLog(
                'onLongPressStart @ ${_fmtOffset(d.localPosition)}',
              );
            },
            onLongPressEnd: (LongPressEndDetails d) {
              _pushTapLog('onLongPressEnd @ ${_fmtOffset(d.localPosition)}');
            },
            onLongPressUp: () {
              _pushTapLog('onLongPressUp');
            },
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    scheme.primaryContainer,
                    scheme.tertiaryContainer,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: scheme.primary),
              ),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.touch_app,
                          size: 48,
                          color: scheme.primary,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Tap / double-tap / long-press',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'All ten callbacks are wired',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 8,
                    child: ValueListenableBuilder<Offset>(
                      valueListenable: lastTapDown,
                      builder: (BuildContext ctx, Offset o, Widget? _) {
                        return _StatChip(
                          label: 'down',
                          value: _fmtOffset(o),
                          icon: Icons.arrow_downward,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 8,
                    child: ValueListenableBuilder<Offset>(
                      valueListenable: lastTapUp,
                      builder: (BuildContext ctx, Offset o, Widget? _) {
                        return _StatChip(
                          label: 'up',
                          value: _fmtOffset(o),
                          icon: Icons.arrow_upward,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 8,
                    child: ValueListenableBuilder<bool>(
                      valueListenable: tapCanceledFlag,
                      builder: (BuildContext ctx, bool flag, Widget? _) {
                        return _StatChip(
                          label: 'cancel',
                          value: flag ? 'yes' : 'no',
                          icon: Icons.block,
                          color: flag
                              ? scheme.errorContainer
                              : scheme.surfaceContainerHighest,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const _InfoCard(
          title: 'Tap cancel semantics',
          body: 'If the pointer moves outside the hit region or another '
              'recognizer wins the arena, onTapCancel fires instead of onTapUp. '
              'The same applies to onDoubleTapCancel and onLongPressCancel.',
        ),
        const _InfoCard(
          title: 'Ordering',
          body: '1) onTapDown  →  2) onTapUp  OR  onTapCancel  →  3) onTap\n'
              'For long-press: onTapDown  →  onLongPressStart  →  '
              'onLongPressMoveUpdate*  →  onLongPressEnd  →  onLongPressUp  →  '
              'onLongPress.',
        ),
        _LogPane(
          notifier: tapLog,
          title: 'Tap family — live event trace',
          height: 220,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              OutlinedButton.icon(
                onPressed: () {
                  tapLog.value = <String>[];
                  tapCount.value = 0;
                  doubleTapCount.value = 0;
                  longPressCount.value = 0;
                  lastTapDown.value = Offset.zero;
                  lastTapUp.value = Offset.zero;
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reset trace'),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Use secondary or tertiary mouse buttons on the Secondary/'
                  'Tertiary tab.',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 3) LONG PRESS tab.
// ============================================================================

class _LongPressTab extends StatelessWidget {
  const _LongPressTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: <Widget>[
        const _SectionHeader(
          icon: Icons.timer_outlined,
          title: 'Long-press — streaming position',
          hint:
              'onLongPressStart → onLongPressMoveUpdate → onLongPressEnd / Up',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 260,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onLongPressStart: (LongPressStartDetails d) {
                longPressActive.value = true;
                longPressPosition.value = d.localPosition;
                _pushLongPressLog(
                  'start @ ${_fmtOffset(d.localPosition)}',
                );
              },
              onLongPressMoveUpdate: (LongPressMoveUpdateDetails d) {
                longPressPosition.value = d.localPosition;
                longPressProgress.value =
                    d.offsetFromOrigin.distance.clamp(0.0, 100.0) / 100.0;
                _pushLongPressLog(
                  'move Δ=${d.offsetFromOrigin.distance.toStringAsFixed(1)}',
                );
              },
              onLongPressEnd: (LongPressEndDetails d) {
                longPressActive.value = false;
                _pushLongPressLog(
                  'end v=${d.velocity.pixelsPerSecond.distance.toStringAsFixed(0)}',
                );
              },
              onLongPressUp: () {
                longPressProgress.value = 0;
                _pushLongPressLog('up');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: scheme.outline),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _LongPressGridPainter(scheme: scheme),
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: longPressActive,
                      builder: (BuildContext ctx, bool active, Widget? _) {
                        return ValueListenableBuilder<Offset>(
                          valueListenable: longPressPosition,
                          builder: (BuildContext c, Offset pos, Widget? _) {
                            return Stack(
                              children: <Widget>[
                                Positioned(
                                  left: pos.dx - 20,
                                  top: pos.dy - 20,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: active
                                          ? scheme.primary
                                              .withValues(alpha: 0.9)
                                          : scheme.primaryContainer,
                                      border: Border.all(
                                        color: scheme.onPrimary,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      active
                                          ? Icons.fiber_manual_record
                                          : Icons.radio_button_unchecked,
                                      size: 18,
                                      color: scheme.onPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Text(
                        'Long-press and drag',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: ValueListenableBuilder<double>(
                        valueListenable: longPressProgress,
                        builder: (BuildContext c, double v, Widget? _) {
                          return SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'drag progress',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall,
                                ),
                                const SizedBox(height: 4),
                                LinearProgressIndicator(value: v),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const _InfoCard(
          title: 'offsetFromOrigin',
          body: 'onLongPressMoveUpdate details include offsetFromOrigin '
              '(distance from the initial down point) and localOffsetFromOrigin. '
              'Great for dial-like controls, draw-on-press tools, and '
              'range-selectors.',
        ),
        const _InfoCard(
          title: 'Long-press velocity',
          body: 'onLongPressEnd carries a Velocity — useful for fling-style '
              'effects when the user releases while still moving.',
        ),
        _LogPane(
          notifier: longPressLog,
          title: 'Long-press event trace',
          height: 180,
        ),
      ],
    );
  }
}

class _LongPressGridPainter extends CustomPainter {
  const _LongPressGridPainter({required this.scheme});

  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint line = Paint()
      ..color = scheme.outlineVariant.withValues(alpha: 0.7)
      ..strokeWidth = 1;
    const double step = 28;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), line);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }
  }

  @override
  bool shouldRepaint(covariant _LongPressGridPainter oldDelegate) => false;
}

// ============================================================================
// 4) PAN/DRAG tab.
// ============================================================================

class _PanDragTab extends StatelessWidget {
  const _PanDragTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: <Widget>[
        const _SectionHeader(
          icon: Icons.pan_tool_alt_outlined,
          title: 'Pan & Drag — 2D and axis-locked',
          hint: 'onPanStart / Update / End + horizontal- and vertical-only',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 280,
            child: Container(
              decoration: BoxDecoration(
                color: scheme.surfaceContainer,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: scheme.outline),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _DragBackdropPainter(scheme: scheme),
                    ),
                  ),
                  ValueListenableBuilder<Offset>(
                    valueListenable: dragCardPosition,
                    builder: (BuildContext ctx, Offset pos, Widget? _) {
                      return Positioned(
                        left: pos.dx,
                        top: pos.dy,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          dragStartBehavior: DragStartBehavior.down,
                          onPanStart: (DragStartDetails d) {
                            panEventCount.value = panEventCount.value + 1;
                          },
                          onPanUpdate: (DragUpdateDetails d) {
                            final Offset next = pos + d.delta;
                            dragCardPosition.value = Offset(
                              next.dx.clamp(0.0, 240.0),
                              next.dy.clamp(0.0, 200.0),
                            );
                          },
                          onPanEnd: (DragEndDetails d) {
                            lastPanVelocity.value = d.velocity;
                          },
                          onPanCancel: () {
                            // cancel is rare — still observable.
                          },
                          onPanDown: (DragDownDetails d) {},
                          child: Container(
                            width: 90,
                            height: 64,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: scheme.primary,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: scheme.shadow
                                      .withValues(alpha: 0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.open_with,
                                  color: scheme.onPrimary,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Drag',
                                  style: TextStyle(
                                    color: scheme.onPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: ValueListenableBuilder<int>(
                      valueListenable: panEventCount,
                      builder: (BuildContext ctx, int c, Widget? _) {
                        return _StatChip(
                          label: 'pan events',
                          value: '$c',
                          icon: Icons.timeline,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: ValueListenableBuilder<Velocity>(
                      valueListenable: lastPanVelocity,
                      builder: (BuildContext c, Velocity v, Widget? _) {
                        return _StatChip(
                          label: 'v px/s',
                          value: v.pixelsPerSecond.distance
                              .toStringAsFixed(0),
                          icon: Icons.speed,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const _SectionHeader(
          icon: Icons.swap_horiz,
          title: 'Horizontal-only drag lane',
          hint: 'onHorizontalDragStart / Update / End',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Stack(
              children: <Widget>[
                ValueListenableBuilder<double>(
                  valueListenable: horizontalLaneX,
                  builder: (BuildContext ctx, double x, Widget? _) {
                    return Positioned(
                      left: x,
                      top: 18,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onHorizontalDragUpdate:
                            (DragUpdateDetails d) {
                          horizontalLaneX.value = (horizontalLaneX.value +
                                  d.delta.dx)
                              .clamp(0.0, 260.0);
                        },
                        child: Container(
                          width: 54,
                          height: 54,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: scheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: scheme.onPrimary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Positioned(
                  left: 12,
                  bottom: 8,
                  child: Text('Drag the circle ←→ only'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        const _SectionHeader(
          icon: Icons.swap_vert,
          title: 'Vertical-only drag lane',
          hint: 'onVerticalDragStart / Update / End',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: scheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Stack(
              children: <Widget>[
                ValueListenableBuilder<double>(
                  valueListenable: verticalLaneY,
                  builder: (BuildContext ctx, double y, Widget? _) {
                    return Positioned(
                      left: 20,
                      top: y,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onVerticalDragUpdate:
                            (DragUpdateDetails d) {
                          verticalLaneY.value = (verticalLaneY.value +
                                  d.delta.dy)
                              .clamp(0.0, 120.0);
                        },
                        child: Container(
                          width: 54,
                          height: 54,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: scheme.tertiary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_downward,
                            color: scheme.onTertiary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const Positioned(
                  right: 12,
                  bottom: 8,
                  child: Text('Drag the circle ↑↓ only'),
                ),
              ],
            ),
          ),
        ),
        const _InfoCard(
          title: 'Axis-locked drags win faster',
          body: 'onHorizontalDrag* and onVerticalDrag* are cheaper than '
              'onPan* because they only need to exceed slop in one axis. '
              'This helps inside scrollables: horizontal cards can be dragged '
              'without fighting the vertical list.',
        ),
        const _InfoCard(
          title: 'DragStartBehavior',
          body: 'down: drag begins at the first touch-down; the initial delta '
              'is zero but onStart fires immediately.\n'
              'start (default): drag begins once movement exceeds kTouchSlop; '
              'the initial delta may be non-zero.',
        ),
      ],
    );
  }
}

class _DragBackdropPainter extends CustomPainter {
  const _DragBackdropPainter({required this.scheme});

  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = scheme.outlineVariant.withValues(alpha: 0.5)
      ..strokeWidth = 1;
    const double step = 24;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant _DragBackdropPainter oldDelegate) => false;
}

// ============================================================================
// 5) SCALE / PINCH tab.
// ============================================================================

class _ScalePinchTab extends StatelessWidget {
  const _ScalePinchTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: <Widget>[
        const _SectionHeader(
          icon: Icons.pinch_outlined,
          title: 'Scale gestures — pinch and rotate',
          hint: 'onScaleStart, onScaleUpdate, onScaleEnd',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 300,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              trackpadScrollCausesScale: true,
              onScaleStart: (ScaleStartDetails d) {
                pinchPointerCount.value = d.pointerCount;
                pinchFocalPoint.value = d.localFocalPoint;
              },
              onScaleUpdate: (ScaleUpdateDetails d) {
                pinchScale.value = d.scale.clamp(0.3, 3.0);
                pinchRotation.value = d.rotation;
                pinchPointerCount.value = d.pointerCount;
                pinchFocalPoint.value = d.localFocalPoint;
              },
              onScaleEnd: (ScaleEndDetails d) {
                pinchPointerCount.value = 0;
              },
              child: Container(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: scheme.outline),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ValueListenableBuilder<double>(
                      valueListenable: pinchScale,
                      builder: (BuildContext ctx, double s, Widget? _) {
                        return ValueListenableBuilder<double>(
                          valueListenable: pinchRotation,
                          builder: (BuildContext c, double r, Widget? _) {
                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..scaleByDouble(s, s, 1.0, 1.0)
                                ..rotateZ(r),
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      scheme.primary,
                                      scheme.tertiary,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 56,
                                    color: scheme.onPrimary,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder<Offset>(
                      valueListenable: pinchFocalPoint,
                      builder: (BuildContext ctx, Offset f, Widget? _) {
                        return Positioned(
                          left: f.dx - 10,
                          top: f.dy - 10,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: scheme.error,
                              border: Border.all(
                                color: scheme.onError,
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      left: 12,
                      top: 12,
                      child: ValueListenableBuilder<double>(
                        valueListenable: pinchScale,
                        builder: (BuildContext c, double v, Widget? _) {
                          return _StatChip(
                            label: 'scale',
                            value: 'x${v.toStringAsFixed(2)}',
                            icon: Icons.zoom_in,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      right: 12,
                      top: 12,
                      child: ValueListenableBuilder<double>(
                        valueListenable: pinchRotation,
                        builder: (BuildContext c, double v, Widget? _) {
                          return _StatChip(
                            label: 'rot rad',
                            value: v.toStringAsFixed(2),
                            icon: Icons.rotate_right,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: 12,
                      bottom: 12,
                      child: ValueListenableBuilder<int>(
                        valueListenable: pinchPointerCount,
                        builder: (BuildContext c, int n, Widget? _) {
                          return _StatChip(
                            label: 'pointers',
                            value: '$n',
                            icon: Icons.pan_tool_outlined,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          pinchScale.value = 1.0;
                          pinchRotation.value = 0;
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const _InfoCard(
          title: 'Scale details',
          body: 'ScaleUpdateDetails carries: scale (absolute since start), '
              'horizontalScale, verticalScale, rotation (radians), focalPoint '
              'and focalPointDelta. Use focalPoint for pivoting, rotation for '
              'rotational UIs, and scale for zooming.',
        ),
        const _InfoCard(
          title: 'trackpadScrollCausesScale',
          body: 'On desktops, a two-finger trackpad scroll can be interpreted '
              'as a scale gesture when this flag is true. Combine with '
              'trackpadScrollToScaleFactor for fine-grained control.',
        ),
        const _InfoCard(
          title: 'Scale vs pan vs long-press',
          body: 'If you register onScale*, you cannot also register onPan* on '
              'the same detector — onPan* is a subset of onScale*. The arena '
              'flags this at construction time. Use onScale* alone; pans are '
              'automatically emitted as 1-pointer scale updates.',
        ),
      ],
    );
  }
}

// ============================================================================
// 6) SECONDARY / TERTIARY tab.
// ============================================================================

class _SecondaryTertiaryTab extends StatelessWidget {
  const _SecondaryTertiaryTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: <Widget>[
        const _SectionHeader(
          icon: Icons.mouse_outlined,
          title: 'Secondary & Tertiary pointers',
          hint: 'Right-click / middle-click handling with all callbacks',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onSecondaryTap: () {
                    secondaryTapCount.value = secondaryTapCount.value + 1;
                  },
                  onSecondaryTapDown: (TapDownDetails d) {},
                  onSecondaryTapUp: (TapUpDetails d) {},
                  onSecondaryTapCancel: () {},
                  onSecondaryLongPress: () {
                    secondaryLongPressCount.value =
                        secondaryLongPressCount.value + 1;
                  },
                  onSecondaryLongPressStart: (LongPressStartDetails d) {},
                  onSecondaryLongPressMoveUpdate:
                      (LongPressMoveUpdateDetails d) {},
                  onSecondaryLongPressEnd: (LongPressEndDetails d) {},
                  onSecondaryLongPressUp: () {},
                  child: _PointerCard(
                    title: 'Secondary',
                    subtitle: 'Right-click',
                    icon: Icons.mouse,
                    color: scheme.primary,
                    countNotifier: secondaryTapCount,
                    longPressNotifier: secondaryLongPressCount,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTertiaryTapDown: (TapDownDetails d) {
                    tertiaryTapCount.value = tertiaryTapCount.value + 1;
                  },
                  onTertiaryTapUp: (TapUpDetails d) {},
                  onTertiaryTapCancel: () {},
                  onTertiaryLongPress: () {
                    tertiaryLongPressCount.value =
                        tertiaryLongPressCount.value + 1;
                  },
                  onTertiaryLongPressStart: (LongPressStartDetails d) {},
                  onTertiaryLongPressMoveUpdate:
                      (LongPressMoveUpdateDetails d) {},
                  onTertiaryLongPressEnd: (LongPressEndDetails d) {},
                  onTertiaryLongPressUp: () {},
                  child: _PointerCard(
                    title: 'Tertiary',
                    subtitle: 'Middle-click',
                    icon: Icons.mouse_outlined,
                    color: scheme.tertiary,
                    countNotifier: tertiaryTapCount,
                    longPressNotifier: tertiaryLongPressCount,
                  ),
                ),
              ),
            ],
          ),
        ),
        const _InfoCard(
          title: 'Pointer buttons',
          body: 'Secondary = right mouse button. Tertiary = middle mouse '
              'button. On touchscreens only the primary pointer fires — '
              'secondary/tertiary are desktop-centric. Long-press variants '
              'follow the same down/move/end/up pattern as the primary.',
        ),
        const _InfoCard(
          title: 'Typical uses',
          body: 'Secondary tap → context menus. Tertiary tap → open-in-new-'
              'tab semantics. Both complement primary taps without stealing '
              'them from the arena.',
        ),
      ],
    );
  }
}

class _PointerCard extends StatelessWidget {
  const _PointerCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.countNotifier,
    required this.longPressNotifier,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final ValueNotifier<int> countNotifier;
  final ValueNotifier<int> longPressNotifier;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      height: 180,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color),
              const SizedBox(width: 6),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          ValueListenableBuilder<int>(
            valueListenable: countNotifier,
            builder: (BuildContext ctx, int c, Widget? _) {
              return _StatChip(
                label: 'taps',
                value: '$c',
                icon: Icons.ads_click,
              );
            },
          ),
          const SizedBox(height: 6),
          ValueListenableBuilder<int>(
            valueListenable: longPressNotifier,
            builder: (BuildContext ctx, int c, Widget? _) {
              return _StatChip(
                label: 'long-presses',
                value: '$c',
                icon: Icons.timer_outlined,
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 7) HITTESTBEHAVIOR tab.
// ============================================================================

class _HitTestBehaviorTab extends StatelessWidget {
  const _HitTestBehaviorTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: <Widget>[
        const _SectionHeader(
          icon: Icons.layers_outlined,
          title: 'HitTestBehavior — layered click-through',
          hint: 'deferToChild / opaque / translucent',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 320,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      layerBackdropCount.value =
                          layerBackdropCount.value + 1;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: scheme.outline),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Backdrop (opaque)',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 30,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      layerTranslucentCount.value =
                          layerTranslucentCount.value + 1;
                    },
                    child: _LayerCard(
                      label: 'translucent',
                      width: 220,
                      height: 120,
                      color:
                          scheme.tertiaryContainer.withValues(alpha: 0.6),
                      counter: layerTranslucentCount,
                      note: 'hit + forward',
                    ),
                  ),
                ),
                Positioned(
                  left: 80,
                  top: 110,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      layerOpaqueCount.value = layerOpaqueCount.value + 1;
                    },
                    child: _LayerCard(
                      label: 'opaque',
                      width: 200,
                      height: 110,
                      color: scheme.primaryContainer,
                      counter: layerOpaqueCount,
                      note: 'block hit',
                    ),
                  ),
                ),
                Positioned(
                  left: 40,
                  top: 180,
                  child: GestureDetector(
                    behavior: HitTestBehavior.deferToChild,
                    onTap: () {
                      layerDeferCount.value = layerDeferCount.value + 1;
                    },
                    child: _LayerCard(
                      label: 'deferToChild',
                      width: 220,
                      height: 110,
                      color: scheme.secondaryContainer,
                      counter: layerDeferCount,
                      note: 'only child region',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ValueListenableBuilder<int>(
            valueListenable: layerBackdropCount,
            builder: (BuildContext ctx, int n, Widget? _) {
              return _StatChip(
                label: 'backdrop hits (under translucent)',
                value: '$n',
                icon: Icons.layers,
              );
            },
          ),
        ),
        const _InfoCard(
          title: 'deferToChild',
          body: 'The detector is only hit where its child paints. If the '
              'child has transparent regions, taps there pass through to '
              'widgets behind — even without the translucent flag.',
        ),
        const _InfoCard(
          title: 'opaque',
          body: 'Claims the entire bounding rect regardless of child painting. '
              'Events never fall through. Useful for full-card tappable areas '
              'that have partial content.',
        ),
        const _InfoCard(
          title: 'translucent',
          body: 'Reports a hit itself AND lets the same event continue through '
              'to widgets behind. Great for overlay hotspots that should not '
              'block underlying scrolling.',
        ),
      ],
    );
  }
}

class _LayerCard extends StatelessWidget {
  const _LayerCard({
    required this.label,
    required this.width,
    required this.height,
    required this.color,
    required this.counter,
    required this.note,
  });

  final String label;
  final double width;
  final double height;
  final Color color;
  final ValueNotifier<int> counter;
  final String note;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.layers_outlined,
                  size: 16, color: scheme.onSurface),
              const SizedBox(width: 4),
              Text(label,
                  style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
          Text(note, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 8),
          ValueListenableBuilder<int>(
            valueListenable: counter,
            builder: (BuildContext ctx, int n, Widget? _) {
              return _StatChip(
                label: 'hits',
                value: '$n',
                icon: Icons.ads_click,
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 8) GESTURE ARENA tab.
// ============================================================================

class _GestureArenaTab extends StatelessWidget {
  const _GestureArenaTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: <Widget>[
        const _SectionHeader(
          icon: Icons.stadium_outlined,
          title: 'Gesture arena — how recognizers compete',
          hint: 'Pointer-down enters all candidates; one wins, others lose',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AspectRatio(
            aspectRatio: 1.4,
            child: ValueListenableBuilder<int>(
              valueListenable: arenaFrame,
              builder: (BuildContext ctx, int frame, Widget? _) {
                return CustomPaint(
                  painter: _ArenaPainter(scheme: scheme, frame: frame),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              OutlinedButton.icon(
                onPressed: () {
                  arenaFrame.value = (arenaFrame.value + 1) % 4;
                },
                icon: const Icon(Icons.skip_next),
                label: const Text('Next frame'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ValueListenableBuilder<int>(
                  valueListenable: arenaFrame,
                  builder: (BuildContext c, int v, Widget? _) {
                    const List<String> labels = <String>[
                      '1) pointer-down — all candidates admitted',
                      '2) pointers move — recognizers call accept/reject',
                      '3) first accept wins — others forcibly lose',
                      '4) events stream only to the winner',
                    ];
                    return Text(
                      labels[v],
                      style: Theme.of(c).textTheme.titleSmall,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const _InfoCard(
          title: 'Admission',
          body: 'Each GestureDetector has a GestureRecognizer for every '
              'enabled callback. When a pointer lands, all recognizers in the '
              'hit chain are admitted to the arena for that pointer.',
        ),
        const _InfoCard(
          title: 'Resolution',
          body: 'Recognizers progressively call resolve(accepted|rejected). '
              'The first to accept wins; any remaining are forcibly rejected. '
              'This is why tap vs drag cannot fire for the same pointer.',
        ),
        const _InfoCard(
          title: 'Sweep',
          body: 'If a pointer is released and no one has accepted yet, the '
              'arena sweeps: the earliest-added candidate wins. This is why '
              'short taps still fire reliably when several detectors compete.',
        ),
        const _InfoCard(
          title: 'Team members',
          body: 'Advanced recognizers may join a GestureArenaTeam and share '
              'a captain. The captain decides which member claims the pointer '
              '— used e.g. to coordinate scroll views with drag handles.',
        ),
      ],
    );
  }
}

class _ArenaPainter extends CustomPainter {
  _ArenaPainter({required this.scheme, required this.frame});

  final ColorScheme scheme;
  final int frame;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = scheme.surfaceContainer;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(16),
      ),
      bg,
    );

    final Paint ring = Paint()
      ..color = scheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.shortestSide * 0.38;

    canvas.drawCircle(center, radius, ring);

    final Paint inner = Paint()
      ..color = scheme.primaryContainer.withValues(alpha: 0.3);
    canvas.drawCircle(center, radius, inner);

    // Arena label.
    final TextPainter arenaLabel = TextPainter(
      text: TextSpan(
        text: 'ARENA',
        style: TextStyle(
          color: scheme.onSurface,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    arenaLabel.paint(
      canvas,
      Offset(center.dx - arenaLabel.width / 2,
          center.dy - arenaLabel.height / 2),
    );

    // Candidates around the arena.
    final List<String> names = <String>[
      'Tap',
      'DoubleTap',
      'LongPress',
      'Pan',
      'Scale',
    ];
    final List<Color> colors = <Color>[
      scheme.primary,
      scheme.tertiary,
      scheme.secondary,
      scheme.error,
      scheme.primaryContainer,
    ];

    for (int i = 0; i < names.length; i++) {
      final double angle = (i / names.length) * 2 * 3.14159 - 1.57;
      final double cx = center.dx + (radius + 50) * _cos(angle);
      final double cy = center.dy + (radius + 50) * _sin(angle);

      bool isWinner = frame >= 2 && i == 3; // Pan wins after frame 2.
      bool isRejected = frame >= 3 && i != 3;

      final Paint fill = Paint()
        ..color = isWinner
            ? scheme.primary
            : (isRejected
                ? colors[i].withValues(alpha: 0.25)
                : colors[i]);
      canvas.drawCircle(Offset(cx, cy), 26, fill);

      final Paint border = Paint()
        ..color = scheme.outline
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawCircle(Offset(cx, cy), 26, border);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: names[i],
          style: TextStyle(
            color: isRejected
                ? scheme.onSurface.withValues(alpha: 0.45)
                : scheme.onPrimary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(cx - tp.width / 2, cy - tp.height / 2));

      // Arrow to arena.
      if (frame >= 1) {
        final Paint arrow = Paint()
          ..color = isWinner
              ? scheme.primary
              : scheme.outlineVariant.withValues(alpha: 0.7)
          ..strokeWidth = isWinner ? 3 : 1;
        final double tx = center.dx + radius * _cos(angle);
        final double ty = center.dy + radius * _sin(angle);
        canvas.drawLine(Offset(cx, cy), Offset(tx, ty), arrow);
      }

      // X mark for losers.
      if (isRejected) {
        final Paint x = Paint()
          ..color = scheme.error
          ..strokeWidth = 2;
        canvas.drawLine(
            Offset(cx - 8, cy - 8), Offset(cx + 8, cy + 8), x);
        canvas.drawLine(
            Offset(cx + 8, cy - 8), Offset(cx - 8, cy + 8), x);
      }

      // Crown for winner.
      if (isWinner) {
        final TextPainter crown = TextPainter(
          text: const TextSpan(
            text: '★',
            style: TextStyle(
              color: Color(0xFFFFD700),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        crown.paint(canvas, Offset(cx + 12, cy - 30));
      }
    }

    // Pointer.
    final Paint pointerPaint = Paint()..color = scheme.error;
    canvas.drawCircle(
      Offset(center.dx, size.height - 20),
      8,
      pointerPaint,
    );
    final TextPainter pp = TextPainter(
      text: TextSpan(
        text: 'pointer',
        style: TextStyle(
          color: scheme.onSurface,
          fontSize: 11,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    pp.paint(canvas,
        Offset(center.dx - pp.width / 2, size.height - 20 + 12));
  }

  @override
  bool shouldRepaint(covariant _ArenaPainter old) => old.frame != frame;

  double _cos(double r) {
    // Minimal cosine without dart:math import in sandbox.
    // Use Taylor-ish via double.parse? No — sin/cos are not available here
    // without import; we can still import dart:math in most sandboxes.
    // Safer: use a tiny polynomial. Range-reduce to [-pi,pi].
    double x = r;
    const double twoPi = 6.28318530718;
    while (x > 3.14159265359) {
      x = x - twoPi;
    }
    while (x < -3.14159265359) {
      x = x + twoPi;
    }
    final double x2 = x * x;
    return 1 - x2 / 2 + (x2 * x2) / 24 - (x2 * x2 * x2) / 720;
  }

  double _sin(double r) {
    double x = r;
    const double twoPi = 6.28318530718;
    while (x > 3.14159265359) {
      x = x - twoPi;
    }
    while (x < -3.14159265359) {
      x = x + twoPi;
    }
    final double x2 = x * x;
    return x - (x * x2) / 6 + (x * x2 * x2) / 120 - (x * x2 * x2 * x2) / 5040;
  }
}

// ============================================================================
// 9) SEMANTICS tab.
// ============================================================================

class _SemanticsTab extends StatelessWidget {
  const _SemanticsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: <Widget>[
        const _SectionHeader(
          icon: Icons.accessibility_new,
          title: 'Semantics and screen readers',
          hint: 'excludeFromSemantics — when and why',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ValueListenableBuilder<bool>(
            valueListenable: excludeSemantics,
            builder: (BuildContext ctx, bool excl, Widget? _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SwitchListTile(
                    value: excl,
                    onChanged: (bool v) {
                      excludeSemantics.value = v;
                    },
                    title: const Text('excludeFromSemantics'),
                    subtitle: Text(
                      excl
                          ? 'Detector is HIDDEN from TalkBack/VoiceOver.'
                          : 'Detector IS EXPOSED to TalkBack/VoiceOver.',
                    ),
                    secondary: Icon(
                      excl
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: excl ? scheme.error : scheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    excludeFromSemantics: excl,
                    onTap: () {
                      semanticsTapCount.value =
                          semanticsTapCount.value + 1;
                    },
                    child: Container(
                      height: 96,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: excl
                            ? scheme.errorContainer
                            : scheme.primaryContainer,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            excl
                                ? Icons.visibility_off
                                : Icons.accessibility_new,
                            size: 32,
                            color: excl
                                ? scheme.onErrorContainer
                                : scheme.onPrimaryContainer,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            excl
                                ? 'Invisible to a11y tree'
                                : 'Visible to a11y tree',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ValueListenableBuilder<int>(
                    valueListenable: semanticsTapCount,
                    builder: (BuildContext c, int n, Widget? _) {
                      return _StatChip(
                        label: 'taps',
                        value: '$n',
                        icon: Icons.ads_click,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AspectRatio(
            aspectRatio: 2,
            child: CustomPaint(
              painter: _SemanticsTreePainter(scheme: scheme),
            ),
          ),
        ),
        const _InfoCard(
          title: 'Default behavior',
          body: 'By default, GestureDetector adds semantic actions for the '
              'gestures it handles (tap, long-press, horizontal/vertical '
              'scroll). Screen readers announce these and support the '
              'corresponding accessibility actions.',
        ),
        const _InfoCard(
          title: 'When to exclude',
          body: 'If an inner widget — say an IconButton — already exposes a '
              'tap action, the outer GestureDetector should usually '
              'excludeFromSemantics so the screen reader does not announce '
              'the same action twice.',
        ),
        const _InfoCard(
          title: 'Do not abuse',
          body: 'Never use excludeFromSemantics to "hide" a control from '
              'screen-reader users. Prefer providing a Semantics wrapper with '
              'a clear label over silencing the widget.',
        ),
      ],
    );
  }
}

class _SemanticsTreePainter extends CustomPainter {
  const _SemanticsTreePainter({required this.scheme});

  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = scheme.surfaceContainerLow;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(16),
      ),
      bg,
    );

    final Paint node = Paint()..color = scheme.primary;
    final Paint nodeDim = Paint()
      ..color = scheme.outlineVariant.withValues(alpha: 0.6);
    final Paint line = Paint()
      ..color = scheme.outline
      ..strokeWidth = 1.5;

    final Offset root = Offset(size.width / 2, 30);
    final List<Offset> mids = <Offset>[
      Offset(size.width / 4, size.height / 2),
      Offset(size.width / 2, size.height / 2),
      Offset(size.width * 3 / 4, size.height / 2),
    ];

    canvas.drawCircle(root, 14, node);
    for (final Offset m in mids) {
      canvas.drawLine(root, m, line);
      canvas.drawCircle(m, 12, m.dx == mids[1].dx ? nodeDim : node);
    }

    final List<String> labels = <String>['button', 'excluded', 'link'];
    for (int i = 0; i < mids.length; i++) {
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: scheme.onSurface,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(mids[i].dx - tp.width / 2, mids[i].dy + 18));
    }

    final TextPainter rootLabel = TextPainter(
      text: TextSpan(
        text: 'Semantics tree root',
        style: TextStyle(
          color: scheme.onSurface,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    rootLabel.paint(
      canvas,
      Offset(root.dx - rootLabel.width / 2, 48),
    );
  }

  @override
  bool shouldRepaint(covariant _SemanticsTreePainter old) => false;
}

// ============================================================================
// 10) USE CASES GALLERY tab.
// ============================================================================

class _GalleryTab extends StatelessWidget {
  const _GalleryTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: const <Widget>[
        _SectionHeader(
          icon: Icons.collections_bookmark,
          title: 'Use-case gallery',
          hint: 'GestureDetector in everyday UI patterns',
        ),
        _SwipeToDismissDemo(),
        _DragToReorderDemo(),
        _PhotoZoomDemo(),
        _TapToLikeDemo(),
        _LongPressMenuDemo(),
        _ScratchRevealDemo(),
        _ComparisonSection(),
      ],
    );
  }
}

// ---------------- Swipe to dismiss ----------------

class _SwipeToDismissDemo extends StatelessWidget {
  const _SwipeToDismissDemo();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '1) Swipe to dismiss',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          ValueListenableBuilder<bool>(
            valueListenable: dismissibleDismissed,
            builder: (BuildContext ctx, bool dismissed, Widget? _) {
              if (dismissed) {
                return Container(
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.check_circle, color: scheme.primary),
                      const SizedBox(width: 6),
                      const Text('Dismissed!'),
                      const SizedBox(width: 14),
                      TextButton.icon(
                        onPressed: () {
                          dismissibleDismissed.value = false;
                        },
                        icon: const Icon(Icons.undo),
                        label: const Text('Undo'),
                      ),
                    ],
                  ),
                );
              }
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragEnd: (DragEndDetails d) {
                  if (d.primaryVelocity != null &&
                      d.primaryVelocity!.abs() > 200) {
                    dismissibleDismissed.value = true;
                  }
                },
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.notifications_outlined,
                        color: scheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Swipe me away',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall,
                            ),
                            Text(
                              'onHorizontalDragEnd → primaryVelocity',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.swipe, color: scheme.onPrimaryContainer),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ---------------- Drag to reorder ----------------

class _DragToReorderDemo extends StatelessWidget {
  const _DragToReorderDemo();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '2) Drag to reorder',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          ValueListenableBuilder<List<String>>(
            valueListenable: reorderList,
            builder: (BuildContext ctx, List<String> items, Widget? _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(items.length, (int i) {
                  return ValueListenableBuilder<int?>(
                    valueListenable: reorderDragIndex,
                    builder:
                        (BuildContext c, int? dragIdx, Widget? _) {
                      final bool isDragging = dragIdx == i;
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onLongPressStart: (LongPressStartDetails d) {
                          reorderDragIndex.value = i;
                        },
                        onLongPressMoveUpdate:
                            (LongPressMoveUpdateDetails d) {
                          final int? current = reorderDragIndex.value;
                          if (current == null) return;
                          final double dy = d.offsetFromOrigin.dy;
                          final int target =
                              (current + (dy / 50).round())
                                  .clamp(0, items.length - 1);
                          if (target != current) {
                            final List<String> next =
                                List<String>.from(items);
                            final String item = next.removeAt(current);
                            next.insert(target, item);
                            reorderList.value = next;
                            reorderDragIndex.value = target;
                          }
                        },
                        onLongPressEnd: (LongPressEndDetails d) {
                          reorderDragIndex.value = null;
                        },
                        child: Container(
                          margin:
                              const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDragging
                                ? scheme.primary
                                : scheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isDragging
                                  ? scheme.primary
                                  : scheme.outlineVariant,
                              width: isDragging ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.drag_indicator,
                                color: isDragging
                                    ? scheme.onPrimary
                                    : scheme.onSurface,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                items[i],
                                style: TextStyle(
                                  color: isDragging
                                      ? scheme.onPrimary
                                      : scheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${i + 1}',
                                style: TextStyle(
                                  color: isDragging
                                      ? scheme.onPrimary
                                      : scheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ---------------- Photo zoom ----------------

class _PhotoZoomDemo extends StatelessWidget {
  const _PhotoZoomDemo();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '3) Pinch to zoom a photo',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Container(
            height: 220,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(18),
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleUpdate: (ScaleUpdateDetails d) {
                photoZoom.value = (photoZoom.value * d.scale).clamp(
                  0.8,
                  4.0,
                );
                photoPan.value = photoPan.value + d.focalPointDelta;
              },
              onDoubleTap: () {
                if (photoZoom.value > 1.5) {
                  photoZoom.value = 1.0;
                  photoPan.value = Offset.zero;
                } else {
                  photoZoom.value = 2.5;
                }
              },
              child: ValueListenableBuilder<double>(
                valueListenable: photoZoom,
                builder: (BuildContext c, double z, Widget? _) {
                  return ValueListenableBuilder<Offset>(
                    valueListenable: photoPan,
                    builder:
                        (BuildContext ctx, Offset p, Widget? _) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..translateByDouble(p.dx, p.dy, 0.0, 1.0)
                          ..scaleByDouble(z, z, 1.0, 1.0),
                        child: CustomPaint(
                          painter: _FakePhotoPainter(scheme: scheme),
                          child: const SizedBox.expand(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FakePhotoPainter extends CustomPainter {
  const _FakePhotoPainter({required this.scheme});

  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect sky = Rect.fromLTWH(0, 0, size.width, size.height * 0.6);
    final Paint skyPaint = Paint()
      ..shader = LinearGradient(
        colors: <Color>[
          scheme.primary,
          scheme.tertiary,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(sky);
    canvas.drawRect(sky, skyPaint);

    final Paint ground = Paint()..color = scheme.secondaryContainer;
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        size.height * 0.6,
        size.width,
        size.height * 0.4,
      ),
      ground,
    );

    // Sun.
    final Paint sun = Paint()..color = scheme.inversePrimary;
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.25),
      24,
      sun,
    );

    // Mountains.
    final Path mountain = Path()
      ..moveTo(0, size.height * 0.6)
      ..lineTo(size.width * 0.3, size.height * 0.3)
      ..lineTo(size.width * 0.5, size.height * 0.55)
      ..lineTo(size.width * 0.75, size.height * 0.25)
      ..lineTo(size.width, size.height * 0.6)
      ..close();
    canvas.drawPath(mountain, Paint()..color = scheme.primaryContainer);

    // Label.
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: 'Pinch / double-tap',
        style: TextStyle(
          color: scheme.onPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, const Offset(12, 10));
  }

  @override
  bool shouldRepaint(covariant _FakePhotoPainter old) => false;
}

// ---------------- Tap to like ----------------

class _TapToLikeDemo extends StatelessWidget {
  const _TapToLikeDemo();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '4) Double-tap to like',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onDoubleTap: () {
              likeCount.value = likeCount.value + 1;
              likeBurst.value = !likeBurst.value;
            },
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: scheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ValueListenableBuilder<bool>(
                    valueListenable: likeBurst,
                    builder: (BuildContext ctx, bool burst, Widget? _) {
                      return Icon(
                        burst ? Icons.favorite : Icons.favorite_border,
                        size: 72,
                        color: scheme.error,
                      );
                    },
                  ),
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: ValueListenableBuilder<int>(
                      valueListenable: likeCount,
                      builder: (BuildContext ctx, int n, Widget? _) {
                        return _StatChip(
                          label: 'likes',
                          value: '$n',
                          icon: Icons.favorite,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Text(
                      'Double-tap anywhere',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Long-press menu ----------------

class _LongPressMenuDemo extends StatelessWidget {
  const _LongPressMenuDemo();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '5) Long-press context menu',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Stack(
            children: <Widget>[
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onLongPress: () {
                  menuVisible.value = !menuVisible.value;
                },
                onTap: () {
                  menuVisible.value = false;
                },
                child: Container(
                  height: 120,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: scheme.outline),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.image_outlined,
                        size: 48,
                        color: scheme.primary,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Long-press this tile for a context menu.',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: menuVisible,
                builder: (BuildContext ctx, bool visible, Widget? _) {
                  if (!visible) return const SizedBox.shrink();
                  return Positioned(
                    right: 20,
                    top: 20,
                    child: Material(
                      elevation: 6,
                      borderRadius: BorderRadius.circular(12),
                      color: scheme.surface,
                      child: SizedBox(
                        width: 180,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _MenuItem(
                                icon: Icons.open_in_new, label: 'Open'),
                            _MenuItem(
                                icon: Icons.share_outlined,
                                label: 'Share'),
                            _MenuItem(
                                icon: Icons.download_outlined,
                                label: 'Save'),
                            _MenuItem(
                                icon: Icons.delete_outline,
                                label: 'Delete'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        menuVisible.value = false;
      },
    );
  }
}

// ---------------- Scratch to reveal ----------------

class _ScratchRevealDemo extends StatelessWidget {
  const _ScratchRevealDemo();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '6) Scratch to reveal',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Container(
            height: 140,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          scheme.primary,
                          scheme.tertiary,
                        ],
                      ),
                    ),
                    child: Text(
                      'SECRET: 8 4 1 6',
                      style:
                          Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: scheme.onPrimary,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 4,
                              ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onPanUpdate: (DragUpdateDetails d) {
                      scratchStrokes.value = <Offset>[
                        ...scratchStrokes.value,
                        d.localPosition,
                      ];
                      scratchRevealed.value =
                          (scratchRevealed.value + 0.01).clamp(0, 1);
                    },
                    onPanEnd: (DragEndDetails d) {},
                    child: ValueListenableBuilder<List<Offset>>(
                      valueListenable: scratchStrokes,
                      builder: (BuildContext ctx, List<Offset> pts,
                          Widget? _) {
                        return CustomPaint(
                          painter: _ScratchPainter(
                            scheme: scheme,
                            points: pts,
                          ),
                          child: const SizedBox.expand(),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton.filledTonal(
                    onPressed: () {
                      scratchStrokes.value = <Offset>[];
                      scratchRevealed.value = 0;
                    },
                    icon: const Icon(Icons.refresh),
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

class _ScratchPainter extends CustomPainter {
  _ScratchPainter({required this.scheme, required this.points});

  final ColorScheme scheme;
  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw opaque layer over the secret.
    final Paint cover = Paint()
      ..color = scheme.surfaceContainerHighest;
    canvas.drawRect(Offset.zero & size, cover);

    // "Erase" by drawing BlendMode.clear circles at each pan point.
    final Paint erase = Paint()
      ..blendMode = BlendMode.clear
      ..color = const Color(0x00000000);
    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawRect(Offset.zero & size, cover);
    for (final Offset p in points) {
      canvas.drawCircle(p, 18, erase);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ScratchPainter old) =>
      old.points.length != points.length;
}

// ============================================================================
// 11) Comparison section (inside gallery).
// ============================================================================

class _ComparisonSection extends StatelessWidget {
  const _ComparisonSection();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'GestureDetector vs alternatives',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: const Column(
              children: <Widget>[
                _CompareRow(
                  widget: 'GestureDetector',
                  good: 'Most callbacks, arena-aware',
                  bad: 'No visual feedback (no ripple)',
                ),
                _CompareRow(
                  widget: 'InkWell',
                  good: 'Material ripple + Focus + Semantics',
                  bad: 'Requires Material ancestor; tap-only subset',
                ),
                _CompareRow(
                  widget: 'RawGestureDetector',
                  good: 'Custom recognizers + team/captain control',
                  bad: 'Verbose; you manage everything',
                ),
                _CompareRow(
                  widget: 'Listener',
                  good: 'Raw pointer events (down/move/up/cancel)',
                  bad: 'No arena; you must resolve conflicts yourself',
                ),
                _CompareRow(
                  widget: 'MouseRegion',
                  good: 'Enter/Exit/Hover events (no taps)',
                  bad: 'Desktop/web only; pair with GestureDetector',
                  last: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareRow extends StatelessWidget {
  const _CompareRow({
    required this.widget,
    required this.good,
    required this.bad,
    this.last = false,
  });

  final String widget;
  final String good;
  final String bad;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: last ? Colors.transparent : scheme.outlineVariant,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130,
            child: Text(
              widget,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.check, size: 16, color: scheme.primary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        good,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.close, size: 16, color: scheme.error),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        bad,
                        style: Theme.of(context).textTheme.bodySmall,
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
  }
}

// ============================================================================
// Bottom cheat-sheet bar.
// ============================================================================

class _CheatSheetBar extends StatelessWidget {
  const _CheatSheetBar();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      color: scheme.surfaceContainer,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: const <Widget>[
            _CheatPill(icon: Icons.ads_click, text: 'onTap'),
            _CheatPill(icon: Icons.double_arrow, text: 'onDoubleTap'),
            _CheatPill(icon: Icons.timer_outlined, text: 'onLongPress'),
            _CheatPill(icon: Icons.pan_tool_outlined, text: 'onPan*'),
            _CheatPill(icon: Icons.swap_horiz, text: 'onHorizontalDrag*'),
            _CheatPill(icon: Icons.swap_vert, text: 'onVerticalDrag*'),
            _CheatPill(icon: Icons.pinch_outlined, text: 'onScale*'),
            _CheatPill(icon: Icons.mouse, text: 'onSecondary*'),
            _CheatPill(icon: Icons.circle_outlined, text: 'onTertiary*'),
            _CheatPill(icon: Icons.layers, text: 'behavior'),
            _CheatPill(
              icon: Icons.accessibility_new,
              text: 'excludeFromSemantics',
            ),
            _CheatPill(
              icon: Icons.start,
              text: 'dragStartBehavior',
            ),
          ],
        ),
      ),
    );
  }
}

class _CheatPill extends StatelessWidget {
  const _CheatPill({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 14, color: scheme.primary),
            const SizedBox(width: 4),
            Text(
              text,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}

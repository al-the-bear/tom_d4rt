import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers — stateless demo, no StatefulWidget allowed.
// ---------------------------------------------------------------------------
final ValueNotifier<bool> _dismissibleOpen = ValueNotifier<bool>(false);
final ValueNotifier<bool> _nonDismissibleOpen = ValueNotifier<bool>(false);
final ValueNotifier<String> _nonDismissTapMsg = ValueNotifier<String>('');
final ValueNotifier<bool> _animatedOpen = ValueNotifier<bool>(false);
final ValueNotifier<List<String>> _dismissLog =
    ValueNotifier<List<String>>([]);

// ---------------------------------------------------------------------------
// Entry point required by d4rt sandbox harness.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5B4FD6)),
    ),
    home: const _ModalBarrierDemoShell(),
  );
}

// ---------------------------------------------------------------------------
// Shell — DefaultTabController with 9 tabs.
// ---------------------------------------------------------------------------
class _ModalBarrierDemoShell extends StatelessWidget {
  const _ModalBarrierDemoShell();

  static const List<Tab> _tabs = <Tab>[
    Tab(icon: Icon(Icons.info_outline), text: 'Hero'),
    Tab(icon: Icon(Icons.touch_app), text: 'Dismiss'),
    Tab(icon: Icon(Icons.block), text: 'No-Dismiss'),
    Tab(icon: Icon(Icons.palette_outlined), text: 'Colors'),
    Tab(icon: Icon(Icons.animation), text: 'Animated'),
    Tab(icon: Icon(Icons.accessibility_new), text: 'A11y'),
    Tab(icon: Icon(Icons.schema_outlined), text: 'Diagram'),
    Tab(icon: Icon(Icons.list_alt), text: 'Log'),
    Tab(icon: Icon(Icons.compare), text: 'Compare'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ModalBarrier Explorer'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroTab(),
            _DismissibleTab(),
            _NonDismissibleTab(),
            _ColorShowcaseTab(),
            _AnimatedTab(),
            _A11yTab(),
            _DiagramTab(),
            _LogTab(),
            _CompareTab(),
          ],
        ),
        // Extra: Use Cases & Pitfalls + API Cheat Sheet in a bottom sheet
        // reachable from the FAB on any tab.
        floatingActionButton: _CheatSheetFab(),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// FAB → bottom sheet with Use Cases, Pitfalls, API table.
// ---------------------------------------------------------------------------
class _CheatSheetFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: 'cheatsheet_fab',
      icon: const Icon(Icons.menu_book_outlined),
      label: const Text('Cheat Sheet'),
      onPressed: () => _showCheatSheet(context),
    );
  }

  void _showCheatSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _CheatSheetBottomSheet(),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 1 — Hero Banner
// ---------------------------------------------------------------------------
class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Gradient hero card
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  cs.primaryContainer,
                  cs.secondaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: cs.primary.withAlpha(60),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.shield_outlined,
                          size: 40, color: cs.onPrimaryContainer),
                      const SizedBox(width: 12),
                      Text(
                        'ModalBarrier',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: cs.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'A transparent-to-opaque overlay that absorbs all pointer '
                    'events below it. Whenever Flutter shows a Dialog, '
                    'BottomSheet, or DatePicker it inserts a ModalBarrier '
                    'beneath the foreground route so taps on the scrim either '
                    'pop the route (dismissible) or are silently swallowed '
                    '(non-dismissible).',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: cs.onPrimaryContainer,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Three quick-fact tiles
          _FactTile(
            icon: Icons.layers_outlined,
            title: 'Route-level scrim',
            body:
                'Navigator inserts a ModalBarrier automatically for every '
                'opaque or translucent route via ModalRoute._buildModalBarrier.',
          ),
          const SizedBox(height: 12),
          _FactTile(
            icon: Icons.touch_app_outlined,
            title: 'Pointer absorption',
            body:
                'ModalBarrier uses a Listener + MouseRegion internally so it '
                'consumes all pointer-down events regardless of what lies below.',
          ),
          const SizedBox(height: 12),
          _FactTile(
            icon: Icons.close_outlined,
            title: 'Optional dismiss',
            body:
                'When dismissible:true the barrier calls Navigator.maybePop() '
                'or fires onDismiss. When false, taps are absorbed but nothing '
                'happens — you must provide your own close mechanism.',
          ),
          const SizedBox(height: 24),

          // Constructor signature card
          Card(
            elevation: 0,
            color: cs.surfaceContainerHighest,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Constructor',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 10),
                  SelectableText(
                    'ModalBarrier({\n'
                    '  Key? key,\n'
                    '  Color? color,\n'
                    '  bool dismissible = true,\n'
                    '  String? semanticsLabel,\n'
                    '  bool barrierSemanticsDismissible = true,\n'
                    '  VoidCallback? onDismiss,\n'
                    '})',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontFamily: 'monospace',
                          color: cs.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100), // room for FAB
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 2 — Live Dismissible Demo
// ---------------------------------------------------------------------------
class _DismissibleTab extends StatelessWidget {
  const _DismissibleTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Dismissible Barrier',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Tap the "Show Barrier" button to overlay a black-54 ModalBarrier. '
            'Then tap anywhere on the dark scrim — the barrier fires onDismiss '
            'and disappears.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),

          // Stack-based live demo
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ValueListenableBuilder<bool>(
              valueListenable: _dismissibleOpen,
              builder: (_, bool open,  _) {
                return SizedBox(
                  height: 260,
                  child: Stack(
                    children: <Widget>[
                      // Background content
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              cs.primary,
                              cs.tertiary,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.image_outlined,
                                  size: 56,
                                  color:
                                      cs.onPrimary.withAlpha(180)),
                              const SizedBox(height: 8),
                              Text('Background Content',
                                  style: TextStyle(
                                      color: cs.onPrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                      // Conditional ModalBarrier
                      if (open)
                        ModalBarrier(
                          color: Colors.black54,
                          dismissible: true,
                          onDismiss: () {
                            _dismissibleOpen.value = false;
                            _appendLog('Dismissible barrier tapped → dismissed');
                          },
                        ),
                      // Status badge
                      Positioned(
                        top: 10,
                        right: 10,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: open
                                ? Colors.black87
                                : cs.primaryContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            open ? 'BARRIER ACTIVE' : 'NO BARRIER',
                            style: TextStyle(
                              color: open
                                  ? Colors.white
                                  : cs.onPrimaryContainer,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Control button
          ValueListenableBuilder<bool>(
            valueListenable: _dismissibleOpen,
            builder: (_, bool open,  _) {
              return FilledButton.icon(
                icon: Icon(open
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
                label: Text(open ? 'Barrier is ON — tap scrim to dismiss'
                    : 'Show Barrier'),
                onPressed: open ? null : () => _dismissibleOpen.value = true,
              );
            },
          ),
          const SizedBox(height: 24),

          // Explanation card
          _InfoCard(
            icon: Icons.lightbulb_outline,
            title: 'How it works',
            lines: const <String>[
              '1. ValueNotifier<bool> _dismissibleOpen tracks visibility.',
              '2. When true, a ModalBarrier overlays the Stack.',
              '3. ModalBarrier(dismissible: true) → tapping fires onDismiss.',
              '4. onDismiss sets _dismissibleOpen.value = false.',
              '5. ValueListenableBuilder rebuilds; barrier disappears.',
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 3 — Non-Dismissible Barrier
// ---------------------------------------------------------------------------
class _NonDismissibleTab extends StatelessWidget {
  const _NonDismissibleTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Non-Dismissible Barrier',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'When dismissible: false the barrier absorbs pointer events but '
            'never calls onDismiss or Navigator.maybePop(). '
            'Only the explicit "Close" button can remove it.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ValueListenableBuilder<bool>(
              valueListenable: _nonDismissibleOpen,
              builder: (_, bool open,  _) {
                return SizedBox(
                  height: 280,
                  child: Stack(
                    children: <Widget>[
                      // Background
                      Container(
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerLow,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.lock_outline,
                                  size: 48, color: cs.primary),
                              const SizedBox(height: 8),
                              Text('Protected Content',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: cs.primary)),
                            ],
                          ),
                        ),
                      ),
                      // Non-dismissible barrier
                      if (open)
                        ModalBarrier(
                          color: Colors.indigo.withAlpha(140),
                          dismissible: false,
                          onDismiss: () {
                            // This is never called when dismissible: false.
                            _nonDismissTapMsg.value =
                                'BUG: onDismiss called unexpectedly!';
                          },
                        ),
                      // Tap feedback overlay (rendered above barrier)
                      if (open)
                        Positioned(
                          bottom: 60,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: ValueListenableBuilder<String>(
                              valueListenable: _nonDismissTapMsg,
                              builder: (_, String msg,  _) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    _nonDismissTapMsg.value =
                                        'Tapped — barrier absorbed it. '
                                        'Use Close button.';
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(220),
                                      borderRadius:
                                          BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      msg.isEmpty
                                          ? 'Tap anywhere on scrim…'
                                          : msg,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.indigo,
                                          fontSize: 13),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      // Close button above barrier
                      if (open)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.close),
                            label: const Text('Close'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cs.errorContainer,
                              foregroundColor: cs.onErrorContainer,
                            ),
                            onPressed: () {
                              _nonDismissibleOpen.value = false;
                              _nonDismissTapMsg.value = '';
                              _appendLog(
                                  'Non-dismissible barrier closed via button');
                            },
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          ValueListenableBuilder<bool>(
            valueListenable: _nonDismissibleOpen,
            builder: (_, bool open,  _) {
              return FilledButton.icon(
                icon: const Icon(Icons.shield),
                label: Text(open
                    ? 'Barrier active — only "Close" works'
                    : 'Show Non-Dismissible Barrier'),
                onPressed: open
                    ? null
                    : () {
                        _nonDismissibleOpen.value = true;
                        _nonDismissTapMsg.value = '';
                      },
              );
            },
          ),
          const SizedBox(height: 24),

          _InfoCard(
            icon: Icons.warning_amber_outlined,
            title: 'Pitfall: No exit path',
            lines: const <String>[
              'dismissible: false is safe only when you provide a clear close',
              'mechanism in the foreground layer (above the barrier in the Stack).',
              'Without it the user is permanently locked out of the app.',
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 4 — Color Showcase
// ---------------------------------------------------------------------------
class _ColorShowcaseTab extends StatelessWidget {
  const _ColorShowcaseTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Color Showcase',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Six barrier configurations. Each card shows the underlying '
            'content partially or fully obscured.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          _ColorCard(
            label: 'transparent',
            barrierColor: Colors.transparent,
            description:
                'Absorbs taps with no visual change. Good for invisible '
                'touch guards.',
          ),
          const SizedBox(height: 14),
          _ColorCard(
            label: 'Colors.black26',
            barrierColor: Colors.black26,
            description:
                'Subtle dimming — common for side-drawer scrims.',
          ),
          const SizedBox(height: 14),
          _ColorCard(
            label: 'Colors.black54',
            barrierColor: Colors.black54,
            description:
                'Standard dialog scrim. Good contrast without full blackout.',
          ),
          const SizedBox(height: 14),
          _ColorCard(
            label: 'Primary (alpha 160)',
            barrierColor:
                Theme.of(context).colorScheme.primary.withAlpha(160),
            description:
                'Branded scrim — links visual dismiss to the app palette.',
          ),
          const SizedBox(height: 14),
          _ColorCard(
            label: 'Error (alpha 120)',
            barrierColor:
                Theme.of(context).colorScheme.error.withAlpha(120),
            description:
                'Danger-state overlay for destructive confirmation dialogs.',
          ),
          const SizedBox(height: 14),
          _GradientBarrierCard(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _ColorCard extends StatelessWidget {
  const _ColorCard({
    required this.label,
    required this.barrierColor,
    required this.description,
  });

  final String label;
  final Color barrierColor;
  final String description;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 110,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                // Background
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[cs.primary, cs.secondary],
                    ),
                  ),
                  child: Center(
                    child: Text('Content',
                        style: TextStyle(
                            color: cs.onPrimary,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                // ModalBarrier — dismissible just to receive taps
                ModalBarrier(
                  color: barrierColor,
                  dismissible: false,
                ),
                // Label
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(label,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 11)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text(description,
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}

/// Gradient scrim approximation using two stacked Containers.
class _GradientBarrierCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 2,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 110,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[cs.primary, cs.tertiary],
                    ),
                  ),
                  child: Center(
                    child: Text('Content',
                        style: TextStyle(
                            color: cs.onPrimary,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                // First barrier — bottom half dark
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: 0.6,
                    child: ModalBarrier(
                      color: Colors.black.withAlpha(100),
                      dismissible: false,
                    ),
                  ),
                ),
                // Second barrier — top half subtle
                Align(
                  alignment: Alignment.topCenter,
                  child: FractionallySizedBox(
                    heightFactor: 0.4,
                    child: ModalBarrier(
                      color: Colors.black.withAlpha(20),
                      dismissible: false,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Pseudo-gradient (2 barriers)',
                        style: TextStyle(
                            color: Colors.white, fontSize: 11)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text(
                'Two ModalBarriers stacked at different heights simulate a '
                'bottom-fade gradient — useful for carousel scrims.',
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 5 — Animated Barrier Opacity
// ---------------------------------------------------------------------------
class _AnimatedTab extends StatelessWidget {
  const _AnimatedTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Animated Barrier',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'A TweenAnimationBuilder animates barrier opacity from 0 → 0.7. '
            'Toggle to watch the scrim fade in/out.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ValueListenableBuilder<bool>(
              valueListenable: _animatedOpen,
              builder: (_, bool open,  _) {
                return SizedBox(
                  height: 280,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      // Rich background
                      Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: <Color>[
                              cs.primaryContainer,
                              cs.tertiaryContainer,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.star_outline,
                                  size: 60, color: cs.onPrimaryContainer),
                              const SizedBox(height: 8),
                              Text(
                                'Animate me!',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: cs.onPrimaryContainer),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Animated barrier using TweenAnimationBuilder
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                            begin: 0.0, end: open ? 0.7 : 0.0),
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                        builder: (_, double opacity,  _) {
                          if (opacity < 0.005) {
                            return const SizedBox.shrink();
                          }
                          return ModalBarrier(
                            color: Colors.black.withAlpha(
                                (opacity * 255).round()),
                            dismissible: true,
                            onDismiss: () {
                              _animatedOpen.value = false;
                              _appendLog('Animated barrier dismissed');
                            },
                          );
                        },
                      ),
                      // Opacity readout
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                              begin: 0.0, end: open ? 0.7 : 0.0),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                          builder: (_, double v,  _) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(220),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'opacity: ${v.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          ValueListenableBuilder<bool>(
            valueListenable: _animatedOpen,
            builder: (_, bool open,  _) {
              return Row(
                children: <Widget>[
                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.play_arrow_outlined),
                      label: const Text('Fade IN'),
                      onPressed:
                          open ? null : () => _animatedOpen.value = true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.stop_outlined),
                      label: const Text('Fade OUT'),
                      onPressed:
                          open ? () => _animatedOpen.value = false : null,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          _InfoCard(
            icon: Icons.tips_and_updates_outlined,
            title: 'Implementation note',
            lines: const <String>[
              'ModalBarrier itself has no built-in animation.',
              'Wrap it in TweenAnimationBuilder or AnimatedOpacity to animate.',
              'The framework uses AnimatedModalBarrier for route transitions,',
              'which wraps ModalBarrier with an Animation<Color?>.',
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 6 — Accessibility (semanticsLabel)
// ---------------------------------------------------------------------------
class _A11yTab extends StatelessWidget {
  const _A11yTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Accessibility',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'ModalBarrier exposes two accessibility parameters: '
            'semanticsLabel and barrierSemanticsDismissible.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),

          // semanticsLabel card
          Card(
            elevation: 0,
            color: cs.primaryContainer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.label_outline,
                          color: cs.onPrimaryContainer),
                      const SizedBox(width: 8),
                      Text('semanticsLabel',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: cs.onPrimaryContainer)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'A screen-reader label announced when focus enters the '
                    'barrier. Defaults to null. '
                    'Flutter\'s showDialog uses "Dismiss" in English locales.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: cs.onPrimaryContainer),
                  ),
                  const SizedBox(height: 12),
                  SelectableText(
                    'ModalBarrier(\n'
                    '  semanticsLabel: "Close dialog",\n'
                    '  dismissible: true,\n'
                    ')',
                    style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: cs.onPrimaryContainer),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          // barrierSemanticsDismissible card
          Card(
            elevation: 0,
            color: cs.secondaryContainer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.accessibility_new_outlined,
                          color: cs.onSecondaryContainer),
                      const SizedBox(width: 8),
                      Text('barrierSemanticsDismissible',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: cs.onSecondaryContainer)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'When true (default) the Semantics node includes the '
                    '"dismiss" action — screen readers can swipe-dismiss the '
                    'barrier. Set to false for non-dismissible overlays so '
                    'TalkBack/VoiceOver doesn\'t announce a dismiss action '
                    'that does nothing.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: cs.onSecondaryContainer),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Live semantics preview
          Text('Live Semantics Preview',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Semantics(
                label: 'ModalBarrier semantics demo area',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _SemanticRow(
                      prop: 'semanticsLabel',
                      value: '"Close dialog"',
                      note:
                          'TalkBack announces "Close dialog — double-tap to '
                          'activate"',
                    ),
                    const Divider(height: 20),
                    _SemanticRow(
                      prop: 'barrierSemanticsDismissible',
                      value: 'true',
                      note:
                          'dismiss action added — swipe-up or double-tap '
                          'dismisses in screen reader',
                    ),
                    const Divider(height: 20),
                    _SemanticRow(
                      prop: 'barrierSemanticsDismissible',
                      value: 'false',
                      note:
                          'dismiss action removed — screen reader skips '
                          'barrier without offering dismiss',
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _SemanticRow extends StatelessWidget {
  const _SemanticRow({
    required this.prop,
    required this.value,
    required this.note,
  });

  final String prop;
  final String value;
  final String note;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: cs.primaryContainer,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(prop,
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: cs.onPrimaryContainer)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(value,
                  style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(note,
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 7 — CustomPainter Diagram
// ---------------------------------------------------------------------------
class _DiagramTab extends StatelessWidget {
  const _DiagramTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Route Stack Diagram',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Visualises how Navigator stacks a background route, '
            'ModalBarrier, and foreground dialog in Z-order.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: 360,
              child: CustomPaint(
                painter: _RouteStackPainter(
                  primaryColor:
                      Theme.of(context).colorScheme.primary,
                  secondaryColor:
                      Theme.of(context).colorScheme.secondary,
                  surfaceColor:
                      Theme.of(context).colorScheme.surfaceContainerHigh,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _DiagramLegend(),
          const SizedBox(height: 24),

          // Pointer absorption explanation
          _InfoCard(
            icon: Icons.touch_app_outlined,
            title: 'Pointer absorption in the hit-test tree',
            lines: const <String>[
              'Hit-testing walks the widget tree top-down (highest Z first).',
              'ModalBarrier\'s RenderObject returns true for hitTest, so events',
              'never reach layers below — the background route is invisible',
              'to the gesture arena while the barrier is present.',
              'The foreground dialog is ABOVE the barrier in Z, so it still',
              'receives pointer events normally.',
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _RouteStackPainter extends CustomPainter {
  const _RouteStackPainter({
    required this.primaryColor,
    required this.secondaryColor,
    required this.surfaceColor,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final Color surfaceColor;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // ── Layer 1: Background route ──────────────────────────────────────
    final Paint bgPaint = Paint()
      ..color = primaryColor.withAlpha(40)
      ..style = PaintingStyle.fill;
    final Rect bgRect =
        Rect.fromLTWH(w * 0.05, h * 0.55, w * 0.9, h * 0.38);
    canvas.drawRRect(
        RRect.fromRectAndRadius(bgRect, const Radius.circular(10)),
        bgPaint);
    final Paint bgBorder = Paint()
      ..color = primaryColor.withAlpha(120)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(
        RRect.fromRectAndRadius(bgRect, const Radius.circular(10)),
        bgBorder);
    _drawLabel(canvas, 'Background Route', w * 0.5, h * 0.74, 13);

    // ── Layer 2: ModalBarrier ──────────────────────────────────────────
    final Paint mbPaint = Paint()
      ..color = Colors.black.withAlpha(50)
      ..style = PaintingStyle.fill;
    final Rect mbRect =
        Rect.fromLTWH(w * 0.05, h * 0.35, w * 0.9, h * 0.3);
    canvas.drawRRect(
        RRect.fromRectAndRadius(mbRect, const Radius.circular(10)),
        mbPaint);
    final Paint mbBorder = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRRect(
        RRect.fromRectAndRadius(mbRect, const Radius.circular(10)),
        mbBorder);
    _drawLabel(canvas, 'ModalBarrier  (color: black54)', w * 0.5, h * 0.5,
        12);

    // ── Layer 3: Foreground dialog ─────────────────────────────────────
    final Paint dlgPaint = Paint()
      ..color = surfaceColor
      ..style = PaintingStyle.fill;
    final Rect dlgRect =
        Rect.fromLTWH(w * 0.2, h * 0.04, w * 0.6, h * 0.28);
    canvas.drawRRect(
        RRect.fromRectAndRadius(dlgRect, const Radius.circular(12)),
        dlgPaint);
    final Paint dlgBorder = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(
        RRect.fromRectAndRadius(dlgRect, const Radius.circular(12)),
        dlgBorder);
    _drawLabel(canvas, 'Dialog / BottomSheet', w * 0.5, h * 0.18, 13);

    // ── Z-order arrows (right side) ────────────────────────────────────
    final Paint arrowPaint = Paint()
      ..color = secondaryColor.withAlpha(200)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final double ax = w * 0.93;
    // From bg up to barrier
    _drawArrow(canvas, ax, h * 0.74, ax, h * 0.52, arrowPaint);
    // From barrier up to dialog
    _drawArrow(canvas, ax, h * 0.50, ax, h * 0.18, arrowPaint);

    // Z label
    _drawLabel(canvas, '↑ Z', w * 0.96, h * 0.45, 11);

    // ── Pointer event blocked label ────────────────────────────────────
    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: '✕ pointer blocked',
        style: TextStyle(
            color: Colors.redAccent,
            fontSize: 11,
            fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas,
        Offset(w * 0.5 - tp.width / 2, h * 0.62));
  }

  void _drawLabel(
      Canvas canvas, String text, double cx, double cy, double size) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
            color: Colors.black87,
            fontSize: size,
            fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(cx - tp.width / 2, cy - tp.height / 2));
  }

  void _drawArrow(Canvas canvas, double x1, double y1, double x2,
      double y2, Paint paint) {
    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    // Arrowhead
    const double ah = 8;
    final double angle = (y2 < y1) ? -1.5708 : 1.5708;
    canvas.drawLine(
        Offset(x2, y2),
        Offset(x2 + ah * 0.7 * (y2 < y1 ? 1 : -1),
            y2 + ah * (y2 < y1 ? 1 : -1)),
        paint);
    canvas.drawLine(
        Offset(x2, y2),
        Offset(x2 - ah * 0.7 * (y2 < y1 ? 1 : -1),
            y2 + ah * (y2 < y1 ? 1 : -1) * (angle < 0 ? 1 : -1)),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DiagramLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: const <Widget>[
        _LegendItem(color: Color(0xFF80AAFF), label: 'Background Route'),
        _LegendItem(color: Color(0x80000000), label: 'ModalBarrier'),
        _LegendItem(color: Color(0xFFCCDDFF), label: 'Dialog / Sheet'),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black26),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 8 — onDismiss Callback Log
// ---------------------------------------------------------------------------
class _LogTab extends StatelessWidget {
  const _LogTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Dismiss Log',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Each time any barrier in this demo fires onDismiss an entry '
            'is appended here with a timestamp.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),

          // Demo buttons to generate log entries
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              FilledButton.icon(
                icon: const Icon(Icons.add_circle_outline, size: 18),
                label: const Text('Simulate dismiss'),
                onPressed: () => _appendLog('Barrier dismiss (simulated)'),
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.delete_outline, size: 18),
                label: const Text('Clear log'),
                onPressed: () => _dismissLog.value = <String>[],
              ),
            ],
          ),
          const SizedBox(height: 16),

          Expanded(
            child: Card(
              elevation: 0,
              color: cs.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              child: ValueListenableBuilder<List<String>>(
                valueListenable: _dismissLog,
                builder: (_, List<String> log,  _) {
                  if (log.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.receipt_long_outlined,
                              size: 48,
                              color: cs.onSurfaceVariant.withAlpha(120)),
                          const SizedBox(height: 8),
                          Text('No dismiss events yet.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: cs.onSurfaceVariant
                                          .withAlpha(160))),
                        ],
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: log.length,
                    separatorBuilder: (_,  _) =>
                        const Divider(height: 1),
                    itemBuilder: (_, int i) {
                      final int index = log.length - 1 - i;
                      return ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          radius: 14,
                          backgroundColor: cs.primaryContainer,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                                fontSize: 10,
                                color: cs.onPrimaryContainer,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(log[index],
                            style: const TextStyle(fontSize: 13)),
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

// ---------------------------------------------------------------------------
// TAB 9 — Comparison Table
// ---------------------------------------------------------------------------
class _CompareTab extends StatelessWidget {
  const _CompareTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Comparison',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'ModalBarrier vs other hit-test blocking widgets.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          _CompareTable(),
          const SizedBox(height: 24),
          _UseCasesSection(),
          const SizedBox(height: 24),
          _PitfallsSection(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _CompareTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    const List<List<String>> rows = <List<String>>[
      [
        'Widget',
        'Blocks pointers',
        'Visible color',
        'Auto dismiss',
        'Typical use',
      ],
      [
        'ModalBarrier',
        'Yes',
        'Yes (optional)',
        'Yes (onDismiss)',
        'Dialog / Sheet scrim',
      ],
      [
        'AbsorbPointer',
        'Yes',
        'No',
        'No',
        'Disable subtree interactions',
      ],
      [
        'IgnorePointer',
        'Yes (pass-through)',
        'No',
        'No',
        'Hit-transparent overlays',
      ],
      [
        'GestureDetector\n(opaque)',
        'Yes (gestures only)',
        'No',
        'Callback',
        'Custom tap regions',
      ],
      [
        'ColoredBox',
        'No',
        'Yes',
        'No',
        'Background fill only',
      ],
    ];

    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          border: TableBorder(
            horizontalInside:
                BorderSide(color: cs.outlineVariant, width: 0.5),
          ),
          children: rows.asMap().entries.map((MapEntry<int, List<String>> e) {
            final bool isHeader = e.key == 0;
            return TableRow(
              decoration: BoxDecoration(
                color: isHeader ? cs.primaryContainer : null,
              ),
              children: e.value.map((String cell) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  child: Text(
                    cell,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                      color: isHeader
                          ? cs.onPrimaryContainer
                          : cs.onSurface,
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _UseCasesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const List<Map<String, dynamic>> cases = <Map<String, dynamic>>[
      {
        'icon': Icons.chat_bubble_outline,
        'title': 'Modal dialog',
        'body':
            'showDialog inserts ModalBarrier with black54 and dismissible:true.'
      },
      {
        'icon': Icons.arrow_upward_outlined,
        'title': 'Bottom sheet',
        'body': 'showModalBottomSheet uses a barrier allowing tap-outside dismiss.'
      },
      {
        'icon': Icons.calendar_today_outlined,
        'title': 'Date picker',
        'body':
            'showDatePicker layers a barrier — tap outside to cancel the picker.'
      },
      {
        'icon': Icons.hourglass_empty_outlined,
        'title': 'Loading overlay',
        'body':
            'Use dismissible:false to prevent interaction while a task runs.'
      },
      {
        'icon': Icons.menu_open_outlined,
        'title': 'Side drawer',
        'body':
            'Drawer uses a semi-transparent barrier on the right of the drawer.'
      },
      {
        'icon': Icons.warning_amber_outlined,
        'title': 'Confirmation',
        'body':
            'AlertDialog barrier prevents accidental interaction with the page.'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Use Cases',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.6,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: cases.map((Map<String, dynamic> c) {
            return _UseCaseCard(
              icon: c['icon'] as IconData,
              title: c['title'] as String,
              body: c['body'] as String,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerHighest,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, size: 18, color: cs.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              color: cs.primary)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Text(body,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 10),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}

class _PitfallsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Pitfalls',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        _PitfallTile(
          number: '1',
          title: 'Z-order mistakes',
          body:
              'If the barrier is lower in the Stack than the content you '
              'want to protect, the content still receives pointer events.',
        ),
        const SizedBox(height: 8),
        _PitfallTile(
          number: '2',
          title: 'Forgetting onDismiss',
          body:
              'dismissible:true fires Navigator.maybePop() by default — '
              'if there is nothing to pop, nothing happens and the barrier '
              'stays forever. Always pass onDismiss when in a custom Stack.',
        ),
        const SizedBox(height: 8),
        _PitfallTile(
          number: '3',
          title: 'Non-dismissible with no close path',
          body:
              'dismissible:false with no visible close button or keyboard '
              'shortcut traps all users including keyboard and touch users.',
        ),
      ],
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.number,
    required this.title,
    required this.body,
  });

  final String number;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.errorContainer,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: cs.error,
          radius: 14,
          child: Text(number,
              style: TextStyle(
                  color: cs.onError,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        ),
        title: Text(title,
            style: TextStyle(
                color: cs.onErrorContainer,
                fontWeight: FontWeight.bold,
                fontSize: 13)),
        subtitle: Text(body,
            style: TextStyle(
                color: cs.onErrorContainer.withAlpha(200),
                fontSize: 12)),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom sheet — Use Cases, Pitfalls, API Cheat Sheet (FAB)
// ---------------------------------------------------------------------------
class _CheatSheetBottomSheet extends StatelessWidget {
  const _CheatSheetBottomSheet();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      builder: (_, ScrollController sc) {
        return ListView(
          controller: sc,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
          children: <Widget>[
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('API Cheat Sheet',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            _ApiTable(),
            const SizedBox(height: 24),
            Text('Inherited ModalRoute usage',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            Card(
              elevation: 0,
              color: cs.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: SelectableText(
                  '// ModalRoute controls barrier via overrides:\n'
                  '@override Color? get barrierColor => Colors.black54;\n'
                  '@override bool get barrierDismissible => true;\n'
                  '@override String? get barrierLabel => "Dismiss";\n'
                  '\n'
                  '// Flutter constructs:\n'
                  '// ModalBarrier(\n'
                  '//   color: barrierColor,\n'
                  '//   dismissible: barrierDismissible,\n'
                  '//   semanticsLabel: barrierLabel,\n'
                  '// )',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Quick tips',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            ...<String>[
              'Use AnimatedModalBarrier for route transitions; '
                  'it accepts an Animation<Color?> for fade.',
              'Set color: null (transparent) when you only need pointer '
                  'blocking without any visual dim.',
              'barrierSemanticsDismissible mirrors dismissible; keep them '
                  'consistent for accessibility.',
              'In Stack-based UIs always set onDismiss to update your '
                  'ValueNotifier — relying on maybePop may silently fail.',
              'Wrap a loading spinner and a non-dismissible barrier in a '
                  'single Stack for a rock-solid loading overlay.',
            ].map((String tip) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.check_circle_outline,
                        size: 16, color: cs.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(tip,
                          style:
                              Theme.of(context).textTheme.bodySmall),
                    ),
                  ],
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

class _ApiTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    const List<List<String>> rows = <List<String>>[
      ['Property', 'Type', 'Default', 'Description'],
      ['key', 'Key?', 'null', 'Widget identity key.'],
      ['color', 'Color?', 'null', 'Scrim color. null = transparent.'],
      [
        'dismissible',
        'bool',
        'true',
        'If true, taps call Navigator.maybePop or onDismiss.'
      ],
      [
        'semanticsLabel',
        'String?',
        'null',
        'Screen reader label. "Dismiss" used by showDialog.'
      ],
      [
        'barrierSemanticsDismissible',
        'bool',
        'true',
        'Whether the semantics node exposes a dismiss action.'
      ],
      [
        'onDismiss',
        'VoidCallback?',
        'null',
        'Called instead of maybePop when barrier is tapped.'
      ],
    ];

    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          border: TableBorder(
            horizontalInside:
                BorderSide(color: cs.outlineVariant, width: 0.5),
          ),
          children: rows.asMap().entries.map((MapEntry<int, List<String>> e) {
            final bool isHeader = e.key == 0;
            return TableRow(
              decoration: BoxDecoration(
                color: isHeader ? cs.primaryContainer : null,
              ),
              children: e.value.map((String cell) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 9),
                  child: Text(
                    cell,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal,
                      color: isHeader
                          ? cs.onPrimaryContainer
                          : cs.onSurface,
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable helper widgets
// ---------------------------------------------------------------------------

class _FactTile extends StatelessWidget {
  const _FactTile({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerHighest,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 20,
              backgroundColor: cs.primaryContainer,
              child: Icon(icon, color: cs.onPrimaryContainer, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(body,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.lines,
  });

  final IconData icon;
  final String title;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.tertiaryContainer,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, size: 18, color: cs.onTertiaryContainer),
                const SizedBox(width: 8),
                Text(title,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: cs.onTertiaryContainer,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            ...lines.map((String l) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(l,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: cs.onTertiaryContainer)),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Helper — append timestamped entry to dismiss log.
// ---------------------------------------------------------------------------
void _appendLog(String message) {
  final DateTime now = DateTime.now();
  final String ts =
      '${now.hour.toString().padLeft(2, '0')}:'
      '${now.minute.toString().padLeft(2, '0')}:'
      '${now.second.toString().padLeft(2, '0')}';
  _dismissLog.value = <String>[
    ..._dismissLog.value,
    '$ts — $message',
  ];
}

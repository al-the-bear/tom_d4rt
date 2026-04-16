import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers — STATELESS demo, mutable state lives here.
// ---------------------------------------------------------------------------

final ValueNotifier<RouteTransitionsBuilder> _selectedTransition =
    ValueNotifier<RouteTransitionsBuilder>(_fadeTransition);

final ValueNotifier<Color> _barrierColor =
    ValueNotifier<Color>(Colors.black54);

final ValueNotifier<bool> _barrierDismissible = ValueNotifier<bool>(true);

final ValueNotifier<Duration> _transitionDuration =
    ValueNotifier<Duration>(const Duration(milliseconds: 300));

final ValueNotifier<Offset?> _anchorPoint = ValueNotifier<Offset?>(null);

final ValueNotifier<String> _activeTransitionLabel =
    ValueNotifier<String>('fade');

final ValueNotifier<String> _activeBarrierLabel =
    ValueNotifier<String>('black54');

final ValueNotifier<String> _activeDurationLabel =
    ValueNotifier<String>('300 ms');

// ---------------------------------------------------------------------------
// Reusable transition builders
// ---------------------------------------------------------------------------

RouteTransitionsBuilder _fadeTransition = (
  BuildContext ctx,
  Animation<double> anim,
  Animation<double> secondaryAnim,
  Widget child,
) {
  return FadeTransition(opacity: anim, child: child);
};

RouteTransitionsBuilder _scaleTransition = (
  BuildContext ctx,
  Animation<double> anim,
  Animation<double> secondaryAnim,
  Widget child,
) {
  return ScaleTransition(
    scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
    child: child,
  );
};

RouteTransitionsBuilder _slideUpTransition = (
  BuildContext ctx,
  Animation<double> anim,
  Animation<double> secondaryAnim,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
    child: child,
  );
};

RouteTransitionsBuilder _rotateTransition = (
  BuildContext ctx,
  Animation<double> anim,
  Animation<double> secondaryAnim,
  Widget child,
) {
  return RotationTransition(
    turns: Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: anim, curve: Curves.easeOut),
    ),
    child: FadeTransition(opacity: anim, child: child),
  );
};

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5C6BC0)),
    ),
    home: const _RawDialogRouteDemoHome(),
  );
}

// ---------------------------------------------------------------------------
// Home scaffold with DefaultTabController
// ---------------------------------------------------------------------------

class _RawDialogRouteDemoHome extends StatelessWidget {
  const _RawDialogRouteDemoHome();

  static const List<String> _tabLabels = [
    'Overview',
    'Live Push',
    'Transitions',
    'Barrier',
    'Dismissible',
    'Anchor',
    'Duration',
    'Diagram',
    'Compare',
    'Pitfalls',
    'API',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabLabels.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RawDialogRoute Deep Demo'),
          bottom: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: _tabLabels
                .map((label) => Tab(text: label))
                .toList(),
          ),
        ),
        body: const TabBarView(
          children: [
            _OverviewTab(),
            _LivePushTab(),
            _TransitionsTab(),
            _BarrierColorTab(),
            _DismissibleTab(),
            _AnchorPointTab(),
            _DurationTab(),
            _DiagramTab(),
            _CompareTab(),
            _PitfallsTab(),
            _ApiTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        text,
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.icon, required this.title, required this.body});
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: theme.colorScheme.primary, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(body, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock(this.code);
  final String code;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
        ),
      ),
      child: Text(
        code,
        style: theme.textTheme.bodySmall?.copyWith(
          fontFamily: 'monospace',
          color: theme.colorScheme.onSurface,
          height: 1.6,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Custom dialog card used in all live demos
// ---------------------------------------------------------------------------

class _CustomDialogCard extends StatelessWidget {
  const _CustomDialogCard({
    required this.title,
    required this.subtitle,
    this.showCloseButton = false,
  });
  final String title;
  final String subtitle;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Material(
          borderRadius: BorderRadius.circular(24),
          color: cs.surface,
          elevation: 12,
          shadowColor: cs.shadow,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Colored header strip
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [cs.primaryContainer, cs.secondaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    Icon(Icons.hub_rounded, size: 48, color: cs.primary),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: cs.onPrimaryContainer,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Body
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: cs.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    if (showCloseButton)
                      FilledButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                        label: const Text('Close'),
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop('cancel'),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 8),
                          FilledButton(
                            onPressed: () => Navigator.of(context).pop('ok'),
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 1 – Overview / Hero Banner
// ---------------------------------------------------------------------------

class _OverviewTab extends StatelessWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Hero banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [cs.primaryContainer, cs.tertiaryContainer],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: cs.primary.withAlpha(40),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.layers_rounded, size: 40, color: cs.primary),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'RawDialogRoute',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: cs.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'The low-level PopupRoute that powers Flutter\'s dialog system. '
                'No Material chrome. No default decoration. Pure routing primitives.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: cs.onPrimaryContainer,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Chip(
                avatar: Icon(Icons.foundation, size: 18, color: cs.primary),
                label: const Text('Foundation layer of showDialog & DialogRoute'),
                backgroundColor: cs.surface.withAlpha(200),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const _SectionHeader('What is RawDialogRoute?'),
        const _InfoCard(
          icon: Icons.article_outlined,
          title: 'Definition',
          body:
              'RawDialogRoute<T> is a PopupRoute that shows a widget as an overlay '
              'over the current Navigator route. Unlike showDialog or DialogRoute, '
              'it adds NO Material-specific decoration, scrim opacity, or elevation. '
              'You supply your own pageBuilder — you have full control.',
        ),
        const SizedBox(height: 8),
        const _InfoCard(
          icon: Icons.build_circle_outlined,
          title: 'Foundation role',
          body:
              'showDialog() calls DialogRoute() which extends RawDialogRoute. '
              'CupertinoDialogRoute also extends RawDialogRoute. It is the shared '
              'root for all dialog-like routes in Flutter\'s routing system.',
        ),
        const SizedBox(height: 8),
        const _InfoCard(
          icon: Icons.compare_arrows_rounded,
          title: 'Vs DialogRoute / showDialog',
          body:
              'DialogRoute wraps your widget in a Dialog widget (shadow, background, '
              'rounded corners). showDialog wraps it further in Theme + DefaultTextStyle. '
              'RawDialogRoute delivers the bare PopupRoute mechanism — barrier + overlay '
              '— without any of that. Choose RawDialogRoute when you need total control.',
        ),
        const SizedBox(height: 16),
        const _SectionHeader('Core constructor'),
        _CodeBlock('''Navigator.of(context).push(
  RawDialogRoute<T>(
    pageBuilder: (ctx, anim, secondaryAnim) => MyWidget(),
    barrierDismissible: true,
    barrierColor: Colors.black54,
    barrierLabel: 'Dismiss',
    transitionDuration: Duration(milliseconds: 300),
    transitionBuilder: (ctx, anim, secondary, child) =>
        FadeTransition(opacity: anim, child: child),
    settings: RouteSettings(name: '/my-dialog'),
    anchorPoint: Offset(200, 400),
    traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
  ),
);'''),
        const SizedBox(height: 16),
        const _SectionHeader('Key properties at a glance'),
        _PropertyRow('pageBuilder', 'WidgetBuilder', 'Required. Builds your dialog widget.'),
        _PropertyRow('barrierDismissible', 'bool', 'Tap outside to close. Default true.'),
        _PropertyRow('barrierColor', 'Color?', 'Scrim tint behind dialog.'),
        _PropertyRow('barrierLabel', 'String?', 'Accessibility label for barrier.'),
        _PropertyRow('transitionDuration', 'Duration', 'Route open/close animation length.'),
        _PropertyRow('transitionBuilder', 'RouteTransitionsBuilder?', 'Custom enter/exit animation.'),
        _PropertyRow('settings', 'RouteSettings?', 'Name & arguments for the route.'),
        _PropertyRow('anchorPoint', 'Offset?', 'Preferred screen anchor for sub-routes.'),
        _PropertyRow('traversalEdgeBehavior', 'TraversalEdgeBehavior?', 'Focus wrap at dialog edges.'),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _PropertyRow extends StatelessWidget {
  const _PropertyRow(this.name, this.type, this.desc);
  final String name;
  final String type;
  final String desc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(name,
                style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                    color: cs.primary)),
          ),
          Expanded(
            flex: 3,
            child: Text(type,
                style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    color: cs.secondary)),
          ),
          Expanded(
            flex: 5,
            child: Text(desc,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: cs.onSurfaceVariant)),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 2 – Live Push Demo
// ---------------------------------------------------------------------------

class _LivePushTab extends StatelessWidget {
  const _LivePushTab();

  void _pushDialog(BuildContext context) {
    Navigator.of(context).push(
      RawDialogRoute<String>(
        pageBuilder: (ctx, anim, secondaryAnim) => _CustomDialogCard(
          title: 'RawDialogRoute',
          subtitle:
              'This card is built entirely by you — '
              'no Material Dialog wrapper. Pure RawDialogRoute.',
          showCloseButton: false,
        ),
        barrierColor: Colors.black54,
        barrierDismissible: true,
        barrierLabel: 'Dismiss dialog',
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (ctx, anim, secondary, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader('Live Push Demo'),
        const _InfoCard(
          icon: Icons.touch_app_rounded,
          title: 'How it works',
          body:
              'Press the button below. It calls Navigator.of(context).push(RawDialogRoute(...)). '
              'The dialog card is a custom widget — no AlertDialog, no Dialog, no Material wrapper. '
              'Tap the dark barrier or press Cancel to dismiss.',
        ),
        const SizedBox(height: 20),
        // Visual call-site preview
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: cs.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: cs.tertiary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('main.dart',
                      style: theme.textTheme.labelSmall
                          ?.copyWith(color: cs.outline)),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '''Navigator.of(context).push(
  RawDialogRoute<String>(
    pageBuilder: (ctx, anim, _) =>
        _CustomDialogCard(...),
    barrierColor: Colors.black54,
    barrierDismissible: true,
    transitionBuilder: fadeTransition,
  ),
);''',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: cs.onSurface,
                  height: 1.7,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Center(
          child: FilledButton.icon(
            onPressed: () => _pushDialog(context),
            icon: const Icon(Icons.open_in_new_rounded),
            label: const Text('Push RawDialogRoute'),
            style: FilledButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(height: 28),
        const _SectionHeader('What makes this "raw"?'),
        _BulletPoint('No Dialog widget — no rounded Material background.'),
        _BulletPoint('No DefaultTextStyle injection from showDialog.'),
        _BulletPoint('No barrierLabel default — you provide it.'),
        _BulletPoint('No elevation model — you own the visual hierarchy.'),
        _BulletPoint('The barrier is still provided (barrierColor) — that IS part of PopupRoute.'),
        const SizedBox(height: 20),
        const _InfoCard(
          icon: Icons.lightbulb_outline_rounded,
          title: 'Design note',
          body:
              'The custom card above uses a gradient header, your own icon, '
              'and custom buttons. None of that comes from Flutter — '
              'RawDialogRoute simply positions your widget on top of the barrier '
              'and manages focus, back-gesture, and result propagation.',
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _BulletPoint extends StatelessWidget {
  const _BulletPoint(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 10),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: cs.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(text, style: theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 3 – Custom Transition Builders
// ---------------------------------------------------------------------------

class _TransitionsTab extends StatelessWidget {
  const _TransitionsTab();

  static final List<_TransitionOption> _options = [
    _TransitionOption(
      label: 'fade',
      icon: Icons.opacity_rounded,
      builder: _fadeTransition,
      description: 'FadeTransition — opacity 0→1. '
          'The default if no transitionBuilder is supplied.',
    ),
    _TransitionOption(
      label: 'scale',
      icon: Icons.zoom_in_rounded,
      builder: _scaleTransition,
      description: 'ScaleTransition with easeOutBack curve — '
          'bouncy elastic entrance.',
    ),
    _TransitionOption(
      label: 'slide-up',
      icon: Icons.arrow_upward_rounded,
      builder: _slideUpTransition,
      description: 'SlideTransition from bottom — common bottom-sheet feel '
          'applied to a dialog overlay.',
    ),
    _TransitionOption(
      label: 'rotate',
      icon: Icons.rotate_right_rounded,
      builder: _rotateTransition,
      description: 'RotationTransition 0.85→1.0 turns combined with fade. '
          'Dramatic entrance for prominent dialogs.',
    ),
  ];

  void _pushWithTransition(BuildContext context, RouteTransitionsBuilder builder) {
    Navigator.of(context).push(
      RawDialogRoute<void>(
        pageBuilder: (ctx, anim, secondaryAnim) => const _CustomDialogCard(
          title: 'Custom Transition',
          subtitle:
              'Notice how this dialog enters and exits using '
              'the selected transition builder.',
        ),
        barrierColor: Colors.black54,
        barrierDismissible: true,
        barrierLabel: 'Dismiss',
        transitionDuration: _transitionDuration.value,
        transitionBuilder: builder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader('Custom Transition Builders'),
        const _InfoCard(
          icon: Icons.animation_rounded,
          title: 'transitionBuilder parameter',
          body:
              'RawDialogRoute accepts a RouteTransitionsBuilder: '
              '(context, animation, secondaryAnimation, child) => Widget. '
              'The animation runs 0→1 on push and 1→0 on pop. '
              'The child is your pageBuilder output.',
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<String>(
          valueListenable: _activeTransitionLabel,
          builder: (ctx, activeLabel, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select transition:',
                  style: Theme.of(ctx).textTheme.labelLarge,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _options.map((opt) {
                    final selected = activeLabel == opt.label;
                    return FilterChip(
                      avatar: Icon(opt.icon, size: 18),
                      label: Text(opt.label),
                      selected: selected,
                      onSelected: (_) {
                        _selectedTransition.value = opt.builder;
                        _activeTransitionLabel.value = opt.label;
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                ..._options
                    .where((o) => o.label == activeLabel)
                    .map((o) => _InfoCard(
                          icon: o.icon,
                          title: o.label,
                          body: o.description,
                        )),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<RouteTransitionsBuilder>(
          valueListenable: _selectedTransition,
          builder: (ctx, builder, _) {
            return Center(
              child: FilledButton.icon(
                onPressed: () => _pushWithTransition(ctx, builder),
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Push with selected transition'),
                style: FilledButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        const _SectionHeader('Transition builder signature'),
        _CodeBlock('''typedef RouteTransitionsBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,       // 0.0 → 1.0 on push
  Animation<double> secondaryAnimation, // parent route fade-out
  Widget child,                      // your pageBuilder output
);

// Example — scale + fade combo:
(ctx, anim, _, child) => ScaleTransition(
  scale: CurvedAnimation(
    parent: anim,
    curve: Curves.easeOutBack,
  ),
  child: FadeTransition(opacity: anim, child: child),
);'''),
        const SizedBox(height: 16),
        const _InfoCard(
          icon: Icons.info_outline_rounded,
          title: 'No transitionBuilder?',
          body:
              'If you omit transitionBuilder, RawDialogRoute uses a simple '
              'opacity fade by default. This is identical to what DialogRoute '
              'uses unless you customise it.',
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _TransitionOption {
  const _TransitionOption({
    required this.label,
    required this.icon,
    required this.builder,
    required this.description,
  });
  final String label;
  final IconData icon;
  final RouteTransitionsBuilder builder;
  final String description;
}

// ---------------------------------------------------------------------------
// Tab 4 – barrierColor Playground
// ---------------------------------------------------------------------------

class _BarrierColorTab extends StatelessWidget {
  const _BarrierColorTab();


  static List<_BarrierOption> _dynamicOptions(ColorScheme cs) => [
        _BarrierOption(label: 'black54', color: Colors.black54),
        _BarrierOption(label: 'black26', color: Colors.black26),
        _BarrierOption(label: 'transparent', color: Colors.transparent),
        _BarrierOption(label: 'primary', color: cs.primary.withAlpha(153)),
        _BarrierOption(label: 'error', color: cs.error.withAlpha(120)),
      ];

  void _pushWithBarrier(BuildContext context, Color color, String label) {
    Navigator.of(context).push(
      RawDialogRoute<void>(
        pageBuilder: (ctx, anim, _) => _CustomDialogCard(
          title: 'Barrier: $label',
          subtitle:
              'Look at the scrim behind this dialog. '
              'The barrierColor is set to "$label".',
        ),
        barrierColor: color,
        barrierDismissible: true,
        barrierLabel: 'Dismiss',
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (ctx, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final allOptions = _dynamicOptions(cs);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader('barrierColor Playground'),
        const _InfoCard(
          icon: Icons.blur_on_rounded,
          title: 'What is the barrier?',
          body:
              'The barrier is a full-screen colored overlay rendered behind your '
              'dialog widget and in front of the previous route. '
              'barrierColor controls its tint. '
              'Set to Colors.transparent for no visual scrim.',
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<String>(
          valueListenable: _activeBarrierLabel,
          builder: (ctx, activeLabel, _) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: allOptions.map((opt) {
                final selected = activeLabel == opt.label;
                return FilterChip(
                  avatar: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: opt.color == Colors.transparent
                          ? null
                          : opt.color,
                      border: Border.all(color: cs.outline),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: opt.color == Colors.transparent
                        ? const Icon(Icons.block, size: 12)
                        : null,
                  ),
                  label: Text(opt.label),
                  selected: selected,
                  onSelected: (_) {
                    _barrierColor.value = opt.color;
                    _activeBarrierLabel.value = opt.label;
                  },
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 20),
        // Color swatches visual
        Row(
          children: allOptions.map((opt) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: opt.color,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: cs.outline),
                        image: opt.color == Colors.transparent
                            ? const DecorationImage(
                                image: AssetImage(''),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      opt.label,
                      style: Theme.of(context).textTheme.labelSmall,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<Color>(
          valueListenable: _barrierColor,
          builder: (ctx, color, _) {
            return ValueListenableBuilder<String>(
              valueListenable: _activeBarrierLabel,
              builder: (ctx2, label, _) {
                return Center(
                  child: FilledButton.icon(
                    onPressed: () => _pushWithBarrier(ctx2, color, label),
                    icon: const Icon(Icons.open_in_new_rounded),
                    label: Text('Push with "$label" barrier'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                    ),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 24),
        const _SectionHeader('Usage notes'),
        _BulletPoint(
            'Colors.black54 is the standard Material dialog barrier — strong contrast.'),
        _BulletPoint(
            'Colors.black26 is lighter; the background content is more visible.'),
        _BulletPoint(
            'Colors.transparent removes the barrier visually but it is still tappable if barrierDismissible is true.'),
        _BulletPoint(
            'Theme colors (primary, error) enable branded barrier tints.'),
        _BulletPoint(
            'barrierLabel is the semantics label read by screen readers when the barrier is focused.'),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _BarrierOption {
  const _BarrierOption({required this.label, required this.color});
  final String label;
  final Color color;
}

// ---------------------------------------------------------------------------
// Tab 5 – barrierDismissible toggle
// ---------------------------------------------------------------------------

class _DismissibleTab extends StatelessWidget {
  const _DismissibleTab();

  void _pushDialog(BuildContext context, bool dismissible) {
    Navigator.of(context).push(
      RawDialogRoute<void>(
        pageBuilder: (ctx, anim, _) => _CustomDialogCard(
          title: dismissible ? 'Tap outside to close' : 'Locked dialog',
          subtitle: dismissible
              ? 'Tap the dark barrier around this dialog to dismiss it. '
                  'barrierDismissible is true.'
              : 'This dialog cannot be dismissed by tapping the barrier. '
                  'You MUST press the Close button. '
                  'barrierDismissible is false.',
          showCloseButton: !dismissible,
        ),
        barrierColor: Colors.black54,
        barrierDismissible: dismissible,
        barrierLabel: 'Dismiss',
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (ctx, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader('barrierDismissible Toggle'),
        const _InfoCard(
          icon: Icons.touch_app_rounded,
          title: 'barrierDismissible',
          body:
              'When true (default), tapping the barrier outside the dialog '
              'closes the route. When false, the user must interact with '
              'content inside the dialog to dismiss it.',
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<bool>(
          valueListenable: _barrierDismissible,
          builder: (ctx, isDismissible, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('barrierDismissible:',
                    style: theme.textTheme.labelLarge),
                const SizedBox(height: 12),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment<bool>(
                      value: true,
                      label: Text('true'),
                      icon: Icon(Icons.check_circle_outline),
                    ),
                    ButtonSegment<bool>(
                      value: false,
                      label: Text('false'),
                      icon: Icon(Icons.lock_outline),
                    ),
                  ],
                  selected: {isDismissible},
                  onSelectionChanged: (s) {
                    _barrierDismissible.value = s.first;
                  },
                ),
                const SizedBox(height: 20),
                // Live status indicator
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDismissible
                        ? cs.primaryContainer
                        : cs.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isDismissible
                            ? Icons.open_with_rounded
                            : Icons.lock_rounded,
                        color: isDismissible
                            ? cs.onPrimaryContainer
                            : cs.onErrorContainer,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          isDismissible
                              ? 'Dialog will close when barrier is tapped.'
                              : 'Dialog locked — requires explicit close action inside.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isDismissible
                                ? cs.onPrimaryContainer
                                : cs.onErrorContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: FilledButton.icon(
                    onPressed: () => _pushDialog(ctx, isDismissible),
                    icon: Icon(isDismissible
                        ? Icons.open_in_new_rounded
                        : Icons.lock_open_rounded),
                    label: Text(
                      isDismissible
                          ? 'Push dismissible dialog'
                          : 'Push locked dialog',
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                      backgroundColor:
                          isDismissible ? null : cs.error,
                      foregroundColor:
                          isDismissible ? null : cs.onError,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 24),
        const _SectionHeader('UX guidance'),
        _BulletPoint(
            'Always set barrierDismissible: false when data loss could occur '
            '(e.g. an unsaved form). Provide a clear close button.'),
        _BulletPoint(
            'For informational or low-stakes dialogs, true is preferred — '
            'less friction for the user.'),
        _BulletPoint(
            'When false, ensure keyboard navigation can also reach the close button '
            '(traversalEdgeBehavior helps here).'),
        _CodeBlock('''RawDialogRoute<void>(
  pageBuilder: (ctx, anim, _) => MyDialog(
    // Must have its own close/cancel button
    onClose: () => Navigator.of(ctx).pop(),
  ),
  barrierDismissible: false,  // <-- locked
  barrierColor: Colors.black54,
  barrierLabel: 'Dialog is modal',
)'''),
        const SizedBox(height: 24),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 6 – anchorPoint demo
// ---------------------------------------------------------------------------

class _AnchorPointTab extends StatelessWidget {
  const _AnchorPointTab();

  static const List<_AnchorOption> _anchorOptions = [
    _AnchorOption(label: 'Center', point: null),
    _AnchorOption(label: 'Top-left', point: Offset(0, 0)),
    _AnchorOption(label: 'Top-right', point: Offset(9999, 0)),
    _AnchorOption(label: 'Bottom-left', point: Offset(0, 9999)),
    _AnchorOption(label: 'Bottom-right', point: Offset(9999, 9999)),
  ];

  void _pushWithAnchor(
      BuildContext context, Offset? anchor, String label) {
    Navigator.of(context).push(
      RawDialogRoute<void>(
        pageBuilder: (ctx, anim, _) => _CustomDialogCard(
          title: 'Anchor: $label',
          subtitle:
              'anchorPoint hint: ${anchor == null ? 'null (default center)' : '(${anchor.dx.toStringAsFixed(0)}, ${anchor.dy.toStringAsFixed(0)})'}\n\n'
              'Note: anchorPoint is a hint for sub-routes (like Cupertino action sheets on iPad). '
              'For most use-cases it does not visually reposition the dialog itself.',
        ),
        barrierColor: Colors.black54,
        barrierDismissible: true,
        barrierLabel: 'Dismiss',
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (ctx, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
        anchorPoint: anchor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final size = MediaQuery.sizeOf(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader('anchorPoint Demo'),
        const _InfoCard(
          icon: Icons.location_pin,
          title: 'What is anchorPoint?',
          body:
              'anchorPoint is an Offset hint that sub-routes (routes pushed from '
              'inside this dialog) can use to determine their preferred position. '
              'On iPad with Cupertino action sheets, it controls popover attachment. '
              'It does NOT directly reposition RawDialogRoute itself.',
        ),
        const SizedBox(height: 16),
        // Screen position diagram
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: Text(
                    'Screen (${size.width.toInt()} × ${size.height.toInt()})',
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: cs.outline),
                  ),
                ),
              ),
              ..._anchorOptions.where((o) => o.point != null).map<Widget>((opt) {
                final isTopLeft = opt.point!.dx == 0 && opt.point!.dy == 0;
                final isTopRight = opt.point!.dx > 100 && opt.point!.dy == 0;
                final isBottomLeft = opt.point!.dx == 0 && opt.point!.dy > 100;
                final isBottomRight = opt.point!.dx > 100 && opt.point!.dy > 100;

                AlignmentGeometry alignment;
                if (isTopLeft) {
                  alignment = Alignment.topLeft;
                } else if (isTopRight) {
                  alignment = Alignment.topRight;
                } else if (isBottomLeft) {
                  alignment = Alignment.bottomLeft;
                } else if (isBottomRight) {
                  alignment = Alignment.bottomRight;
                } else {
                  alignment = Alignment.center;
                }

                return Align(
                  alignment: alignment,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Chip(
                      label: Text(opt.label,
                          style: theme.textTheme.labelSmall),
                      backgroundColor: cs.primaryContainer,
                      side: BorderSide.none,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<Offset?>(
          valueListenable: _anchorPoint,
          builder: (ctx, current, _) {
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _anchorOptions.map((opt) {
                final selected = current == opt.point;
                return FilterChip(
                  label: Text(opt.label),
                  selected: selected,
                  onSelected: (_) {
                    _anchorPoint.value = opt.point;
                  },
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<Offset?>(
          valueListenable: _anchorPoint,
          builder: (ctx, anchor, _) {
            final label = _anchorOptions
                .firstWhere(
                  (o) => o.point == anchor,
                  orElse: () => _anchorOptions.first,
                )
                .label;
            return Center(
              child: FilledButton.icon(
                onPressed: () => _pushWithAnchor(ctx, anchor, label),
                icon: const Icon(Icons.location_on_rounded),
                label: Text('Push with anchor: $label'),
                style: FilledButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        const _SectionHeader('Code example'),
        _CodeBlock('''RawDialogRoute<void>(
  pageBuilder: ...,
  anchorPoint: Offset(0, 0),  // top-left hint
  // On iPad: Cupertino action sheets launched from inside
  // this dialog will prefer attaching near (0, 0).
)'''),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _AnchorOption {
  const _AnchorOption({required this.label, required this.point});
  final String label;
  final Offset? point;
}

// ---------------------------------------------------------------------------
// Tab 7 – transitionDuration
// ---------------------------------------------------------------------------

class _DurationTab extends StatelessWidget {
  const _DurationTab();

  static const List<_DurationOption> _durations = [
    _DurationOption(label: '150 ms', ms: 150),
    _DurationOption(label: '300 ms', ms: 300),
    _DurationOption(label: '600 ms', ms: 600),
    _DurationOption(label: '1200 ms', ms: 1200),
  ];

  void _pushWithDuration(BuildContext context, int ms, String label) {
    Navigator.of(context).push(
      RawDialogRoute<void>(
        pageBuilder: (ctx, anim, _) => _CustomDialogCard(
          title: 'Duration: $label',
          subtitle:
              'Notice how the enter and exit animations take $label. '
              'Dismiss by tapping outside to see the pop animation.',
        ),
        barrierColor: Colors.black54,
        barrierDismissible: true,
        barrierLabel: 'Dismiss',
        transitionDuration: Duration(milliseconds: ms),
        transitionBuilder: (ctx, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader('transitionDuration'),
        const _InfoCard(
          icon: Icons.timer_outlined,
          title: 'How it works',
          body:
              'transitionDuration controls how long the push (enter) and pop (exit) '
              'animations take. The default is 200ms for RawDialogRoute. '
              'Both enter and exit share the same duration — there is no separate '
              'reverseTransitionDuration unless you override it by subclassing.',
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder<String>(
          valueListenable: _activeDurationLabel,
          builder: (ctx, activeLabel, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select duration:', style: theme.textTheme.labelLarge),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _durations.map((opt) {
                    final selected = activeLabel == opt.label;
                    return FilterChip(
                      label: Text(opt.label),
                      selected: selected,
                      onSelected: (_) {
                        _transitionDuration.value =
                            Duration(milliseconds: opt.ms);
                        _activeDurationLabel.value = opt.label;
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                // Visual progress bar showing relative duration
                ...List.generate(_durations.length, (i) {
                  final opt = _durations[i];
                  final fraction = opt.ms / 1200;
                  final isActive = opt.label == activeLabel;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 72,
                          child: Text(opt.label,
                              style: theme.textTheme.labelMedium?.copyWith(
                                fontWeight: isActive
                                    ? FontWeight.w700
                                    : FontWeight.normal,
                              )),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: fraction,
                              minHeight: isActive ? 10 : 6,
                              color: isActive ? cs.primary : cs.primaryContainer,
                              backgroundColor: cs.surfaceContainerHighest,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('${opt.ms}ms',
                            style: theme.textTheme.labelSmall
                                ?.copyWith(color: cs.outline)),
                      ],
                    ),
                  );
                }),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<Duration>(
          valueListenable: _transitionDuration,
          builder: (ctx, dur, _) {
            final label = _durations
                .firstWhere(
                  (o) => o.ms == dur.inMilliseconds,
                  orElse: () => _durations[1],
                )
                .label;
            return Center(
              child: FilledButton.icon(
                onPressed: () =>
                    _pushWithDuration(ctx, dur.inMilliseconds, label),
                icon: const Icon(Icons.play_circle_outline_rounded),
                label: Text('Push with $label animation'),
                style: FilledButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        const _SectionHeader('Best practice'),
        _BulletPoint(
            '150–200ms: Fast, snappy. Good for frequent, small dialogs.'),
        _BulletPoint(
            '300ms: Material Design recommendation for dialogs.'),
        _BulletPoint(
            '600ms+: Slow and dramatic. Use sparingly for onboarding or '
            'first-run experiences.'),
        _BulletPoint(
            '1200ms: Very slow. Only for deliberate, attention-grabbing moments.'),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _DurationOption {
  const _DurationOption({required this.label, required this.ms});
  final String label;
  final int ms;
}

// ---------------------------------------------------------------------------
// Tab 8 – Diagram (CustomPainter)
// ---------------------------------------------------------------------------

class _DiagramTab extends StatelessWidget {
  const _DiagramTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader('Navigator Route Stack Diagram'),
        const _InfoCard(
          icon: Icons.layers_outlined,
          title: 'How RawDialogRoute sits in the stack',
          body:
              'When you call Navigator.of(context).push(RawDialogRoute(...)), '
              'two layers are added on top of the current route: '
              '(1) the barrier overlay, and (2) your dialog widget. '
              'The current route remains mounted but visually covered.',
        ),
        const SizedBox(height: 20),
        // CustomPainter diagram
        Container(
          height: 380,
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CustomPaint(
              painter: _RouteStackPainter(cs: cs),
              child: const SizedBox.expand(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const _SectionHeader('Layer breakdown'),
        _LayerRow(
          color: Colors.blue.shade100,
          label: 'Previous Route',
          description: 'Your main page/screen. Stays mounted. '
              'Input blocked by barrier.',
        ),
        const SizedBox(height: 8),
        _LayerRow(
          color: Colors.black54,
          label: 'Barrier Layer',
          description: 'Full-screen scrim. Color from barrierColor. '
              'Tappable if barrierDismissible.',
          lightText: true,
        ),
        const SizedBox(height: 8),
        _LayerRow(
          color: Colors.indigo.shade200,
          label: 'Dialog Widget',
          description: 'Your pageBuilder output. Sized and positioned '
              'by your own widget tree.',
        ),
        const SizedBox(height: 20),
        const _SectionHeader('Route object hierarchy'),
        _CodeBlock('''Route (abstract)
  └─ OverlayRoute
       └─ TransitionRoute
            └─ ModalRoute
                 └─ PopupRoute              ← blocks input to routes below
                      └─ RawDialogRoute<T>  ← adds barrier + pageBuilder layers
                           ├─ DialogRoute<T>       (Material)
                           └─ CupertinoDialogRoute (Cupertino)'''),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _LayerRow extends StatelessWidget {
  const _LayerRow({
    required this.color,
    required this.label,
    required this.description,
    this.lightText = false,
  });
  final Color color;
  final String label;
  final String description;
  final bool lightText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: theme.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w700)),
              Text(description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class _RouteStackPainter extends CustomPainter {
  const _RouteStackPainter({required this.cs});
  final ColorScheme cs;

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: cs.onSurface,
      fontSize: 12,
      fontFamily: 'monospace',
    );
    final lightTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontFamily: 'monospace',
      fontWeight: FontWeight.w600,
    );
    final labelStyle = TextStyle(
      color: cs.outline,
      fontSize: 10,
    );

    // Layer 1 — Previous Route (bottom)
    final layer1Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(16, size.height - 90, size.width - 32, 70),
      const Radius.circular(8),
    );
    canvas.drawRRect(
      layer1Rect,
      Paint()..color = cs.primaryContainer,
    );
    _drawText(
        canvas, 'Previous Route (e.g. Home)', textStyle, layer1Rect.outerRect);

    // Layer 2 — Barrier
    final layer2Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(32, size.height - 175, size.width - 64, 70),
      const Radius.circular(8),
    );
    canvas.drawRRect(
      layer2Rect,
      Paint()..color = Colors.black54,
    );
    _drawText(
        canvas, 'Barrier Layer  (barrierColor)', lightTextStyle, layer2Rect.outerRect);

    // Layer 3 — Dialog
    final layer3Rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(64, size.height - 260, size.width - 128, 70),
      const Radius.circular(8),
    );
    canvas.drawRRect(
      layer3Rect,
      Paint()..color = cs.secondaryContainer,
    );
    _drawText(
        canvas, 'Dialog Widget  (pageBuilder)', textStyle, layer3Rect.outerRect);

    // Arrows
    final arrowPaint = Paint()
      ..color = cs.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Arrow: barrier to dialog
    final a1Start = Offset(size.width / 2, layer2Rect.top);
    final a1End = Offset(size.width / 2, layer3Rect.bottom);
    canvas.drawLine(a1Start, a1End, arrowPaint);
    _drawArrowHead(canvas, a1End, arrowPaint);

    // Arrow: previous to barrier
    final a2Start = Offset(size.width / 2, layer1Rect.top);
    final a2End = Offset(size.width / 2, layer2Rect.bottom);
    canvas.drawLine(a2Start, a2End, arrowPaint);
    _drawArrowHead(canvas, a2End, arrowPaint);

    // Label: Navigator stack indicator
    _drawTextAt(
      canvas,
      '↑  Navigator stack grows upward',
      labelStyle,
      Offset(16, 8),
      size.width - 32,
    );

    // Label: RawDialogRoute bracket
    final bracketX = size.width - 20;
    final bracketPaint = Paint()
      ..color = cs.tertiary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(bracketX, layer2Rect.top),
      Offset(bracketX, layer3Rect.bottom),
      bracketPaint,
    );
    _drawTextAt(
      canvas,
      'RawDialogRoute',
      TextStyle(
        color: cs.tertiary,
        fontSize: 9,
        fontWeight: FontWeight.w700,
      ),
      Offset(bracketX - 60, (layer2Rect.top + layer3Rect.bottom) / 2 - 6),
      80,
    );
  }

  void _drawText(Canvas canvas, String text, TextStyle style, Rect bounds) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: bounds.width - 16);
    tp.paint(
      canvas,
      Offset(
        bounds.left + (bounds.width - tp.width) / 2,
        bounds.top + (bounds.height - tp.height) / 2,
      ),
    );
  }

  void _drawTextAt(
      Canvas canvas, String text, TextStyle style, Offset offset, double maxWidth) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
    tp.paint(canvas, offset);
  }

  void _drawArrowHead(Canvas canvas, Offset tip, Paint paint) {
    final path = Path()
      ..moveTo(tip.dx - 6, tip.dy + 10)
      ..lineTo(tip.dx, tip.dy)
      ..lineTo(tip.dx + 6, tip.dy + 10);
    canvas.drawPath(path, paint..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Tab 9 – Comparison table
// ---------------------------------------------------------------------------

class _CompareTab extends StatelessWidget {
  const _CompareTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader('Comparison with related routes'),
        const _InfoCard(
          icon: Icons.compare_rounded,
          title: 'Why this matters',
          body:
              'All Flutter dialog APIs share a common ancestry. Understanding the '
              'hierarchy helps you pick the right level of abstraction for your use-case '
              'and know exactly what each layer adds.',
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(cs.primaryContainer),
            border: TableBorder.all(color: cs.outlineVariant, borderRadius: BorderRadius.circular(8)),
            columns: const [
              DataColumn(label: Text('API')),
              DataColumn(label: Text('Extends')),
              DataColumn(label: Text('Material deco')),
              DataColumn(label: Text('Default barrier')),
              DataColumn(label: Text('Typical use')),
            ],
            rows: [
              _compareRow(cs, 'RawDialogRoute', 'PopupRoute', 'None', 'black54', 'Custom dialogs; foundation layer'),
              _compareRow(cs, 'DialogRoute', 'RawDialogRoute', 'Dialog widget', 'black54', 'Fully custom content, Material chrome'),
              _compareRow(cs, 'showDialog()', 'DialogRoute', 'Dialog + Theme', 'black54', 'Standard Material dialogs'),
              _compareRow(cs, 'CupertinoDialogRoute', 'RawDialogRoute', 'None', 'black54', 'Cupertino-style dialogs'),
              _compareRow(cs, 'ModalBottomSheet', 'PopupRoute', 'Bottom sheet', 'black54', 'Slide-up panels'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _SectionHeader('Decision guide'),
        _DecisionCard(
          label: 'Use showDialog()',
          when: 'You want a standard Material AlertDialog or SimpleDialog with '
              'all defaults (theme, scrim, rounded rect, elevation).',
          icon: Icons.check_circle_outline,
          color: cs.primaryContainer,
        ),
        const SizedBox(height: 8),
        _DecisionCard(
          label: 'Use DialogRoute',
          when: 'You want the Material Dialog wrapper but need to control routing '
              'details (transition, settings, barrier) directly via push().',
          icon: Icons.tune_rounded,
          color: cs.secondaryContainer,
        ),
        const SizedBox(height: 8),
        _DecisionCard(
          label: 'Use RawDialogRoute',
          when: 'You need complete control over the dialog appearance — '
              'no Material chrome — or you are building your own dialog primitive.',
          icon: Icons.build_rounded,
          color: cs.tertiaryContainer,
        ),
        const SizedBox(height: 8),
        _DecisionCard(
          label: 'Use CupertinoDialogRoute',
          when: 'You are building a Cupertino-style dialog on iOS/macOS '
              'with the platform-native look.',
          icon: Icons.apple_rounded,
          color: cs.surfaceContainerHighest,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  DataRow _compareRow(
    ColorScheme cs,
    String api,
    String ext,
    String deco,
    String barrier,
    String use,
  ) {
    return DataRow(cells: [
      DataCell(Text(api,
          style: const TextStyle(fontWeight: FontWeight.w700))),
      DataCell(Text(ext)),
      DataCell(Text(deco)),
      DataCell(Text(barrier)),
      DataCell(SizedBox(width: 160, child: Text(use))),
    ]);
  }
}

class _DecisionCard extends StatelessWidget {
  const _DecisionCard({
    required this.label,
    required this.when,
    required this.icon,
    required this.color,
  });
  final String label;
  final String when;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: theme.textTheme.labelLarge
                        ?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(when, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 10 – Pitfalls
// ---------------------------------------------------------------------------

class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader('Common Pitfalls'),
        _PitfallCard(
          number: '01',
          title: 'Context not below Navigator',
          severity: 'Error',
          severityColor: cs.error,
          body:
              'Navigator.of(context) requires a context that has a Navigator ancestor. '
              'If you call this in a widget that is above MaterialApp, you get '
              '"Navigator operation requested with a context that does not include a Navigator."',
          fix:
              'Ensure the context is inside MaterialApp or Navigator. '
              'Use Builder(builder: (ctx) => ...) to get the right context if needed.',
          code:
              '''// BAD: context above MaterialApp
Widget build(BuildContext context) {
  Navigator.of(context).push(...); // throws!
  return MaterialApp(...);
}

// GOOD: use Builder inside MaterialApp body
MaterialApp(
  home: Builder(
    builder: (ctx) => ElevatedButton(
      onPressed: () => Navigator.of(ctx).push(...),
      child: Text('Show'),
    ),
  ),
)''',
        ),
        const SizedBox(height: 12),
        _PitfallCard(
          number: '02',
          title: 'No Material decoration by default',
          severity: 'Design',
          severityColor: cs.tertiary,
          body:
              'RawDialogRoute does NOT wrap your widget in Dialog, Card, or Material. '
              'If you push a bare Text widget, it appears floating with no background '
              'or elevation.',
          fix:
              'Wrap your dialog content in Material (or Card, Container with BoxDecoration) '
              'to provide the visual surface.',
          code:
              '''RawDialogRoute<void>(
  pageBuilder: (ctx, anim, _) => Center(
    child: Material(          // ← you must add this
      borderRadius: BorderRadius.circular(16),
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text('My dialog'),
      ),
    ),
  ),
)''',
        ),
        const SizedBox(height: 12),
        _PitfallCard(
          number: '03',
          title: 'traversalEdgeBehavior and focus trapping',
          severity: 'Accessibility',
          severityColor: cs.secondary,
          body:
              'By default, keyboard focus can escape the dialog and reach background routes. '
              'This breaks accessibility and violates WCAG 2.1 "Focus Trap" guidance for modals.',
          fix:
              'Set traversalEdgeBehavior to TraversalEdgeBehavior.closedLoop to '
              'trap focus inside the dialog.',
          code:
              '''RawDialogRoute<void>(
  pageBuilder: ...,
  traversalEdgeBehavior:
      TraversalEdgeBehavior.closedLoop, // ← trap focus
)''',
        ),
        const SizedBox(height: 12),
        _PitfallCard(
          number: '04',
          title: 'No reverseTransitionDuration override',
          severity: 'Behaviour',
          severityColor: cs.primary,
          body:
              'RawDialogRoute uses transitionDuration for BOTH push and pop animations. '
              'You cannot set a different pop duration without subclassing.',
          fix:
              'Subclass RawDialogRoute and override reverseTransitionDuration to '
              'provide a different exit duration.',
          code:
              '''class MyDialogRoute<T> extends RawDialogRoute<T> {
  MyDialogRoute({required super.pageBuilder})
      : super(
          transitionDuration: Duration(milliseconds: 400),
        );

  @override
  Duration get reverseTransitionDuration =>
      const Duration(milliseconds: 200); // faster exit
}''',
        ),
        const SizedBox(height: 12),
        _PitfallCard(
          number: '05',
          title: 'Missing barrierLabel for semantics',
          severity: 'Accessibility',
          severityColor: cs.secondary,
          body:
              'Without barrierLabel, screen readers have no description for the '
              'dismiss gesture on the barrier. This hurts users of assistive technology.',
          fix: 'Always provide a meaningful barrierLabel string.',
          code:
              '''RawDialogRoute<void>(
  pageBuilder: ...,
  barrierDismissible: true,
  barrierLabel: 'Dismiss confirmation dialog',  // ← always set this
)''',
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.number,
    required this.title,
    required this.severity,
    required this.severityColor,
    required this.body,
    required this.fix,
    required this.code,
  });
  final String number;
  final String title;
  final String severity;
  final Color severityColor;
  final String body;
  final String fix;
  final String code;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    number,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: severityColor.withAlpha(40),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    severity,
                    style: theme.textTheme.labelSmall
                        ?.copyWith(color: severityColor, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(body, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_outline,
                    size: 16, color: cs.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    fix,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _CodeBlock(code),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tab 11 – API Cheat Sheet
// ---------------------------------------------------------------------------

class _ApiTab extends StatelessWidget {
  const _ApiTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _SectionHeader('API Cheat Sheet'),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [cs.primaryContainer, cs.secondaryContainer],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RawDialogRoute<T>',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                  color: cs.onPrimaryContainer,
                ),
              ),
              Text(
                'extends PopupRoute<T>',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: 'monospace',
                  color: cs.onPrimaryContainer.withAlpha(180),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const _SectionHeader('Constructor parameters'),
        _ApiRow(
          name: 'pageBuilder',
          type: 'WidgetBuilder',
          required: true,
          defaultVal: '—',
          description:
              'Builds the dialog widget. Receives (context, animation, secondaryAnimation).',
          cs: null,
        ),
        _ApiRow(
          name: 'barrierDismissible',
          type: 'bool',
          required: false,
          defaultVal: 'true',
          description: 'Whether tapping the barrier dismisses the route.',
          cs: null,
        ),
        _ApiRow(
          name: 'barrierColor',
          type: 'Color?',
          required: false,
          defaultVal: 'null',
          description:
              'Tint color of the full-screen scrim. null means no scrim.',
          cs: null,
        ),
        _ApiRow(
          name: 'barrierLabel',
          type: 'String?',
          required: false,
          defaultVal: 'null',
          description:
              'Semantics label for the barrier. Required for good accessibility.',
          cs: null,
        ),
        _ApiRow(
          name: 'transitionDuration',
          type: 'Duration',
          required: false,
          defaultVal: '200ms',
          description:
              'Length of push and pop animations.',
          cs: null,
        ),
        _ApiRow(
          name: 'transitionBuilder',
          type: 'RouteTransitionsBuilder?',
          required: false,
          defaultVal: 'null (fade)',
          description:
              'Custom animation builder for push/pop. Defaults to FadeTransition.',
          cs: null,
        ),
        _ApiRow(
          name: 'settings',
          type: 'RouteSettings?',
          required: false,
          defaultVal: 'null',
          description:
              'Name and arguments for the route. Useful for analytics and deep links.',
          cs: null,
        ),
        _ApiRow(
          name: 'anchorPoint',
          type: 'Offset?',
          required: false,
          defaultVal: 'null',
          description:
              'Preferred screen position hint for sub-routes (e.g. popovers on iPad).',
          cs: null,
        ),
        _ApiRow(
          name: 'traversalEdgeBehavior',
          type: 'TraversalEdgeBehavior?',
          required: false,
          defaultVal: 'null',
          description:
              'Controls how keyboard focus behaves at the dialog boundary.',
          cs: null,
        ),
        const SizedBox(height: 24),
        const _SectionHeader('Inherited from PopupRoute / ModalRoute'),
        _ApiRow(
          name: 'barrierCurve',
          type: 'Curve',
          required: false,
          defaultVal: 'Curves.ease',
          description: 'Animation curve for the barrier opacity.',
          cs: null,
        ),
        _ApiRow(
          name: 'maintainState',
          type: 'bool',
          required: false,
          defaultVal: 'true',
          description:
              'Whether the route below keeps its state when covered.',
          cs: null,
        ),
        _ApiRow(
          name: 'reverseTransitionDuration',
          type: 'Duration',
          required: false,
          defaultVal: '== transitionDuration',
          description:
              'Override in subclass to set a different pop animation length.',
          cs: null,
        ),
        const SizedBox(height: 24),
        const _SectionHeader('Minimal complete example'),
        _CodeBlock('''// Push a RawDialogRoute with all key parameters:
Navigator.of(context).push(
  RawDialogRoute<String>(
    pageBuilder: (ctx, animation, secondaryAnimation) {
      return Center(
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Hello from RawDialogRoute',
                    style: Theme.of(ctx).textTheme.titleLarge),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => Navigator.of(ctx).pop('result'),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        ),
      );
    },
    barrierDismissible: true,
    barrierColor: Colors.black54,
    barrierLabel: 'Dismiss hello dialog',
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (ctx, anim, _, child) =>
        ScaleTransition(
          scale: CurvedAnimation(
            parent: anim,
            curve: Curves.easeOutBack,
          ),
          child: FadeTransition(opacity: anim, child: child),
        ),
    settings: const RouteSettings(name: '/hello-dialog'),
    traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
  ),
).then((result) {
  // result is 'result' or null if barrier was tapped
});'''),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline_rounded,
                  color: cs.onSecondaryContainer),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'All of Flutter\'s dialog widgets (showDialog, CupertinoDialog, '
                  'showGeneralDialog) ultimately delegate to RawDialogRoute. '
                  'Mastering it gives you full control of the dialog layer.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _ApiRow extends StatelessWidget {
  const _ApiRow({
    required this.name,
    required this.type,
    required this.required,
    required this.defaultVal,
    required this.description,
    required this.cs,
  });
  final String name;
  final String type;
  final bool required;
  final String defaultVal;
  final String description;
  final ColorScheme? cs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = cs ?? Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: required ? colorScheme.error : colorScheme.outlineVariant,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              if (required)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('required',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onErrorContainer,
                        fontWeight: FontWeight.w700,
                      )),
                ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(type,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    color: colorScheme.secondary,
                  )),
              if (!required) ...[
                Text('  •  default: ',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: colorScheme.outline)),
                Text(defaultVal,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      color: colorScheme.outline,
                    )),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(description,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

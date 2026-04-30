import 'package:flutter/material.dart';

// ─── Top-level notifiers (stateless-safe) ────────────────────────────────────

final ValueNotifier<int> _counterNotifier = ValueNotifier<int>(0);
final ValueNotifier<int> _selectiveNotifier = ValueNotifier<int>(0);
final ValueNotifier<bool> _returnValueNotifier = ValueNotifier<bool>(true);

// ─── Entry point ─────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5B4FCF)),
    ),
    home: const _NotifiableElementMixinDemo(),
  );
}

// ─── Root scaffold with DefaultTabController ─────────────────────────────────

class _NotifiableElementMixinDemo extends StatelessWidget {
  const _NotifiableElementMixinDemo();

  static const List<Tab> _tabs = <Tab>[
    Tab(text: 'Hero'),
    Tab(text: 'Diagram'),
    Tab(text: 'Observable'),
    Tab(text: 'Return Val'),
    Tab(text: 'Selective'),
    Tab(text: 'Lifecycle'),
    Tab(text: 'Comparison'),
    Tab(text: 'Snippet'),
    Tab(text: 'Pitfalls'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NotifiableElementMixin'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroTab(),
            _DiagramTab(),
            _ObservableTab(),
            _ReturnValueTab(),
            _SelectiveRebuildTab(),
            _LifecycleTab(),
            _ComparisonTab(),
            _SnippetTab(),
            _PitfallsTab(),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Hero Banner
// ═══════════════════════════════════════════════════════════════════════════════

class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ── gradient banner ──
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: <Color>[cs.primary, cs.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: -30,
                  bottom: -30,
                  child: Icon(
                    Icons.notifications_active_rounded,
                    size: 160,
                    color: cs.onPrimary.withAlpha(30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'NotifiableElementMixin',
                        style: tt.headlineSmall?.copyWith(
                          color: cs.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'mixin on Element',
                        style: tt.titleMedium?.copyWith(
                          color: cs.onPrimary.withAlpha(200),
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── pill badge ──
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: cs.errorContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Framework-internal · Not for direct subclassing',
                style: tt.labelSmall?.copyWith(color: cs.onErrorContainer),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ── summary card ──
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('What is it?', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(
                    'NotifiableElementMixin is a mixin applied to Flutter framework Element '
                    'subclasses that need to receive targeted notifications from an '
                    'InheritedNotifier when its Listenable fires. Rather than relying solely on '
                    'the standard updateShouldNotify / markNeedsBuild path, this mixin provides '
                    'an onNotification() hook that allows an element to be informed—and '
                    'potentially act on—a notification before a full rebuild is triggered.',
                    style: tt.bodyMedium,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ── role cards ──
          _InfoRow(
            icon: Icons.hub_outlined,
            color: cs.primaryContainer,
            title: 'Role in the rebuild pipeline',
            body:
                'InheritedNotifier.notifyClients() iterates all registered dependents. For '
                'each dependent that is a NotifiableElementMixin, it calls notifyDependent() '
                'which in turn calls element.didChangeDependencies() (and schedules a rebuild). '
                'This gives those elements a direct, targeted signal rather than a broad '
                'markNeedsBuild sweep.',
          ),

          const SizedBox(height: 12),

          _InfoRow(
            icon: Icons.lock_outline_rounded,
            color: cs.secondaryContainer,
            title: 'Framework-internal nature',
            body:
                'This mixin is not part of the public Flutter API surface intended for app '
                'developers. It is applied internally by the framework on specific Element '
                'subclasses (e.g., ProxyElement, StatefulElement). Understanding it helps '
                'reason about performance and rebuild behaviour when using InheritedNotifier.',
          ),

          const SizedBox(height: 12),

          _InfoRow(
            icon: Icons.compare_arrows_rounded,
            color: cs.tertiaryContainer,
            title: 'InheritedWidget vs InheritedNotifier',
            body:
                'InheritedWidget relies on updateShouldNotify to decide whether to notify '
                'dependents on rebuild. InheritedNotifier instead holds a Listenable (such as '
                'a ValueNotifier) and rebuilds dependents whenever the Listenable fires—without '
                'needing a parent rebuild to trigger the cascade.',
          ),

          const SizedBox(height: 12),

          _InfoRow(
            icon: Icons.bolt_rounded,
            color: cs.primaryContainer,
            title: 'Key method: onNotification()',
            body:
                'The mixin overrides onNotification() → bool. When the InheritedNotifier\'s '
                'Listenable fires, each dependent element\'s onNotification() is called. '
                'Returning true signals that this element has consumed the notification; '
                'returning false allows further propagation up the element tree.',
          ),

          const SizedBox(height: 20),

          // ── quick-reference chip row ──
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _Chip('flutter/src/widgets/framework.dart'),
              _Chip('mixin on Element'),
              _Chip('onNotification() → bool'),
              _Chip('didChangeDependencies()'),
              _Chip('InheritedNotifier<T extends Listenable>'),
              _Chip('notifyClients()'),
              _Chip('notifyDependent()'),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Diagram (CustomPainter)
// ═══════════════════════════════════════════════════════════════════════════════

class _DiagramTab extends StatelessWidget {
  const _DiagramTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Notification Flow Diagram',
            style: tt.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'How a ValueNotifier change propagates through the framework.',
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 20),

          // ── custom painter ──
          SizedBox(
            height: 480,
            child: CustomPaint(
              painter: _FlowDiagramPainter(
                primaryColor: cs.primary,
                secondaryColor: cs.secondary,
                tertiaryColor: cs.tertiary,
                errorColor: cs.error,
                surfaceColor: cs.surface,
                onSurfaceColor: cs.onSurface,
                outlineColor: cs.outline,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // ── legend ──
          Text('Legend', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _LegendRow(color: cs.primary, label: 'App-level trigger (ValueNotifier.value = …)'),
          const SizedBox(height: 6),
          _LegendRow(color: cs.secondary, label: 'InheritedNotifier internal machinery'),
          const SizedBox(height: 6),
          _LegendRow(color: cs.tertiary, label: 'NotifiableElementMixin hook'),
          const SizedBox(height: 6),
          _LegendRow(color: cs.error, label: 'Element rebuild path'),
          const SizedBox(height: 20),

          Card(
            color: cs.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Step-by-step',
                    style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _StepRow(step: '1', text: 'App code sets valueNotifier.value = newValue.'),
                  _StepRow(step: '2', text: 'ValueNotifier calls notifyListeners() internally.'),
                  _StepRow(
                    step: '3',
                    text: 'InheritedNotifier is subscribed to the Listenable; its _handleUpdate() fires.',
                  ),
                  _StepRow(step: '4', text: 'InheritedNotifier calls notifyClients() on its element.'),
                  _StepRow(
                    step: '5',
                    text: 'For each dependent Element that is a NotifiableElementMixin, '
                        'notifyDependent() is called.',
                  ),
                  _StepRow(
                    step: '6',
                    text: 'notifyDependent() calls element.didChangeDependencies() on the dependent.',
                  ),
                  _StepRow(step: '7', text: 'The element schedules a rebuild (markNeedsBuild).'),
                  _StepRow(step: '8', text: 'On the next frame, build() is called on the widget.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FlowDiagramPainter extends CustomPainter {
  const _FlowDiagramPainter({
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    required this.errorColor,
    required this.surfaceColor,
    required this.onSurfaceColor,
    required this.outlineColor,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  final Color errorColor;
  final Color surfaceColor;
  final Color onSurfaceColor;
  final Color outlineColor;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    const double boxW = 220;
    const double boxH = 44;
    const double gap = 24;
    const double startY = 16;

    final List<_DiagramNode> nodes = <_DiagramNode>[
      _DiagramNode('valueNotifier.value = x', primaryColor, startY),
      _DiagramNode('ValueNotifier.notifyListeners()', primaryColor, startY + (boxH + gap)),
      _DiagramNode('InheritedNotifier._handleUpdate()', secondaryColor, startY + 2 * (boxH + gap)),
      _DiagramNode('InheritedNotifier.notifyClients()', secondaryColor, startY + 3 * (boxH + gap)),
      _DiagramNode('NotifiableElementMixin.onNotification()', tertiaryColor, startY + 4 * (boxH + gap)),
      _DiagramNode('element.didChangeDependencies()', tertiaryColor, startY + 5 * (boxH + gap)),
      _DiagramNode('element.markNeedsBuild()', errorColor, startY + 6 * (boxH + gap)),
      _DiagramNode('widget.build(context)', errorColor, startY + 7 * (boxH + gap)),
    ];

    final Paint arrowPaint = Paint()
      ..color = outlineColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint arrowHead = Paint()
      ..color = outlineColor
      ..style = PaintingStyle.fill;

    for (int i = 0; i < nodes.length; i++) {
      final _DiagramNode n = nodes[i];
      final double top = n.y;
      final Rect rect = Rect.fromCenter(
        center: Offset(cx, top + boxH / 2),
        width: boxW,
        height: boxH,
      );
      final RRect rr = RRect.fromRectAndRadius(rect, const Radius.circular(8));

      // fill
      canvas.drawRRect(
        rr,
        Paint()..color = n.color.withAlpha(40),
      );
      // stroke
      canvas.drawRRect(
        rr,
        Paint()
          ..color = n.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );

      // label
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: n.label,
          style: TextStyle(
            fontSize: 11,
            color: onSurfaceColor,
            fontFamily: 'monospace',
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: boxW - 8);
      tp.paint(
        canvas,
        Offset(cx - tp.width / 2, top + (boxH - tp.height) / 2),
      );

      // arrow to next
      if (i < nodes.length - 1) {
        final double arrowTop = top + boxH;
        final double arrowBot = nodes[i + 1].y;
        final double midY = (arrowTop + arrowBot) / 2;

        // line
        canvas.drawLine(Offset(cx, arrowTop), Offset(cx, arrowBot - 8), arrowPaint);

        // arrowhead
        final Path path = Path()
          ..moveTo(cx, arrowBot)
          ..lineTo(cx - 6, arrowBot - 10)
          ..lineTo(cx + 6, arrowBot - 10)
          ..close();
        canvas.drawPath(path, arrowHead);

        // step number
        final TextPainter stepPainter = TextPainter(
          text: TextSpan(
            text: '${i + 1}',
            style: TextStyle(fontSize: 10, color: outlineColor),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        stepPainter.paint(canvas, Offset(cx + 10, midY - stepPainter.height / 2));
      }
    }
  }

  @override
  bool shouldRepaint(_FlowDiagramPainter oldDelegate) =>
      oldDelegate.primaryColor != primaryColor;
}

class _DiagramNode {
  const _DiagramNode(this.label, this.color, this.y);
  final String label;
  final Color color;
  final double y;
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Observable Behavior Demo
// ═══════════════════════════════════════════════════════════════════════════════

// InheritedNotifier scope
class _CounterScope extends InheritedNotifier<ValueNotifier<int>> {
  const _CounterScope({
    required super.notifier,
    required super.child,
  });

  static ValueNotifier<int>? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_CounterScope>()
        ?.notifier;
  }
}

class _ObservableTab extends StatelessWidget {
  const _ObservableTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return _CounterScope(
      notifier: _counterNotifier,
      child: Builder(
        builder: (BuildContext ctx) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Observable Behavior Demo',
                  style: tt.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'All four dependent cards below share a single InheritedNotifier<ValueNotifier<int>> '
                  'scope. Each card calls dependOnInheritedWidgetOfExactType, registering itself '
                  'as a dependent. When the notifier fires, all four rebuild simultaneously.',
                  style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 20),

                // trigger button
                Center(
                  child: ValueListenableBuilder<int>(
                    valueListenable: _counterNotifier,
                    builder: (BuildContext bCtx, int val, Widget? _) {
                      return FilledButton.icon(
                        onPressed: () {
                          _counterNotifier.value++;
                        },
                        icon: const Icon(Icons.add_circle_outline),
                        label: Text('Fire notifier  (current: $val)'),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // 4 dependent cards
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.3,
                  children: const <Widget>[
                    _DependentCard(label: 'Card A', accentIndex: 0),
                    _DependentCard(label: 'Card B', accentIndex: 1),
                    _DependentCard(label: 'Card C', accentIndex: 2),
                    _DependentCard(label: 'Card D', accentIndex: 3),
                  ],
                ),

                const SizedBox(height: 20),

                Card(
                  color: cs.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'What is happening',
                          style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Each _DependentCard widget calls '
                          '_CounterScope.of(context), which internally calls '
                          'context.dependOnInheritedWidgetOfExactType<_CounterScope>(). '
                          'This registers the card\'s element as a dependent of the '
                          '_CounterScope InheritedNotifier.\n\n'
                          'When _counterNotifier.value is incremented, the Listenable fires, '
                          'InheritedNotifier._handleUpdate() triggers notifyClients(), and '
                          'every registered dependent has didChangeDependencies() called, '
                          'scheduling a rebuild. The rebuild counter on each card increments '
                          'by 1 per button press.',
                          style: tt.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DependentCard extends StatelessWidget {
  const _DependentCard({required this.label, required this.accentIndex});

  final String label;
  final int accentIndex;

  static final List<Color> _accents = <Color>[
    const Color(0xFF6750A4),
    const Color(0xFF006874),
    const Color(0xFF7D5260),
    const Color(0xFF386A20),
  ];

  @override
  Widget build(BuildContext context) {
    // Registers this element as a dependent of _CounterScope
    final int? value = _CounterScope.of(context)?.value;
    final Color accent = _accents[accentIndex % _accents.length];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: accent, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: accent,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: accent.withAlpha(30),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'rebuilds: ${value ?? 0}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 4 — onNotification Return Value
// ═══════════════════════════════════════════════════════════════════════════════

class _ReturnValueTab extends StatelessWidget {
  const _ReturnValueTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'onNotification Return Value',
            style: tt.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'The bool return value of onNotification() controls whether the notification '
            'is considered consumed by this element.',
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 20),

          // toggle
          ValueListenableBuilder<bool>(
            valueListenable: _returnValueNotifier,
            builder: (BuildContext ctx, bool returning, Widget? _) {
              return Card(
                color: returning ? cs.primaryContainer : cs.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'onNotification() returns:',
                            style: tt.titleSmall,
                          ),
                          Switch(
                            value: returning,
                            onChanged: (bool v) {
                              _returnValueNotifier.value = v;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: cs.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: cs.outline),
                        ),
                        child: Text(
                          returning ? 'true  → consumed; propagation stops' : 'false → propagates further up the tree',
                          style: tt.bodyMedium?.copyWith(fontFamily: 'monospace'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          // diagram
          SizedBox(
            height: 280,
            child: ValueListenableBuilder<bool>(
              valueListenable: _returnValueNotifier,
              builder: (BuildContext ctx, bool consumed, Widget? _) {
                return CustomPaint(
                  painter: _ReturnValueDiagramPainter(
                    consumed: consumed,
                    primaryColor: cs.primary,
                    secondaryColor: cs.secondary,
                    errorColor: cs.error,
                    onSurfaceColor: cs.onSurface,
                    outlineColor: cs.outline,
                    surfaceColor: cs.surface,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // code snippet
          _CodeBlock(
            code: '''
// Inside the framework's notifyDependent():
@override
void notifyDependent(
    InheritedWidget oldWidget,
    Element dependent) {
  // If the dependent element mixes in
  // NotifiableElementMixin, call onNotification().
  bool consumed = false;
  if (dependent is NotifiableElementMixin) {
    consumed = dependent.onNotification();
  }
  // If NOT consumed, fall through to
  // standard didChangeDependencies().
  if (!consumed) {
    dependent.didChangeDependencies();
  }
}''',
          ),

          const SizedBox(height: 16),

          _InfoRow(
            icon: Icons.check_circle_outline,
            color: cs.primaryContainer,
            title: 'Returning true',
            body:
                'The element signals it has fully handled the notification. The framework '
                'does NOT call didChangeDependencies() on this element; the element is '
                'responsible for scheduling any rebuild it needs itself.',
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.arrow_forward_outlined,
            color: cs.secondaryContainer,
            title: 'Returning false',
            body:
                'The notification is NOT consumed. The framework continues with its normal '
                'didChangeDependencies() call, triggering a scheduled rebuild of the element '
                'as it would for any dependent of an InheritedWidget.',
          ),
        ],
      ),
    );
  }
}

class _ReturnValueDiagramPainter extends CustomPainter {
  const _ReturnValueDiagramPainter({
    required this.consumed,
    required this.primaryColor,
    required this.secondaryColor,
    required this.errorColor,
    required this.onSurfaceColor,
    required this.outlineColor,
    required this.surfaceColor,
  });

  final bool consumed;
  final Color primaryColor;
  final Color secondaryColor;
  final Color errorColor;
  final Color onSurfaceColor;
  final Color outlineColor;
  final Color surfaceColor;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    const double boxW = 200;
    const double boxH = 40;

    void drawBox(String text, double y, Color color) {
      final Rect rect = Rect.fromCenter(
        center: Offset(cx, y + boxH / 2),
        width: boxW,
        height: boxH,
      );
      final RRect rr = RRect.fromRectAndRadius(rect, const Radius.circular(8));
      canvas.drawRRect(rr, Paint()..color = color.withAlpha(40));
      canvas.drawRRect(
        rr,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(fontSize: 11, color: onSurfaceColor, fontFamily: 'monospace'),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: boxW - 8);
      tp.paint(canvas, Offset(cx - tp.width / 2, y + (boxH - tp.height) / 2));
    }

    void drawArrow(double fromY, double toY, String label, Color arrowColor) {
      final Paint p = Paint()
        ..color = arrowColor
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      canvas.drawLine(Offset(cx, fromY), Offset(cx, toY - 8), p);
      final Path head = Path()
        ..moveTo(cx, toY)
        ..lineTo(cx - 6, toY - 10)
        ..lineTo(cx + 6, toY - 10)
        ..close();
      canvas.drawPath(head, Paint()..color = arrowColor);
      if (label.isNotEmpty) {
        final TextPainter lp = TextPainter(
          text: TextSpan(
            text: label,
            style: TextStyle(fontSize: 10, color: arrowColor),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        lp.paint(canvas, Offset(cx + 8, (fromY + toY) / 2 - lp.height / 2));
      }
    }

    drawBox('notifyClients()', 10, secondaryColor);
    drawArrow(50, 80, '', outlineColor);
    drawBox('onNotification()', 80, primaryColor);

    if (consumed) {
      // consumed → no further call
      drawArrow(120, 150, 'true', primaryColor);
      drawBox('self.markNeedsBuild()\n(if needed)', 150, primaryColor);

      // cross out didChangeDependencies path
      final Paint crossPaint = Paint()
        ..color = errorColor.withAlpha(120)
        ..strokeWidth = 2;
      final double xOff = cx + boxW / 2 + 20;
      canvas.drawLine(Offset(xOff - 10, 195), Offset(xOff + 10, 215), crossPaint);
      canvas.drawLine(Offset(xOff + 10, 195), Offset(xOff - 10, 215), crossPaint);
    } else {
      // not consumed → normal path
      drawArrow(120, 150, 'false', secondaryColor);
      drawBox('didChangeDependencies()', 150, secondaryColor);
      drawArrow(190, 220, '', outlineColor);
      drawBox('markNeedsBuild() → rebuild', 220, errorColor);
    }
  }

  @override
  bool shouldRepaint(_ReturnValueDiagramPainter old) => old.consumed != consumed;
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 5 — Selective Rebuild Pattern
// ═══════════════════════════════════════════════════════════════════════════════

// Second InheritedNotifier scope for selective demo
class _SelectiveScope extends InheritedNotifier<ValueNotifier<int>> {
  const _SelectiveScope({
    required super.notifier,
    required super.child,
  });

  static ValueNotifier<int>? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_SelectiveScope>()
        ?.notifier;
  }
}

class _SelectiveRebuildTab extends StatelessWidget {
  const _SelectiveRebuildTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return _SelectiveScope(
      notifier: _selectiveNotifier,
      child: Builder(
        builder: (BuildContext ctx) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Selective Rebuild Pattern',
                  style: tt.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Only widgets that have called dependOnInheritedWidgetOfExactType '
                  'are registered as dependents and will rebuild. Subtrees that did '
                  'NOT register are completely untouched.',
                  style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 20),

                // trigger button
                Center(
                  child: ValueListenableBuilder<int>(
                    valueListenable: _selectiveNotifier,
                    builder: (BuildContext bCtx, int val, Widget? _) {
                      return FilledButton.tonal(
                        onPressed: () {
                          _selectiveNotifier.value++;
                        },
                        child: Text('Fire selective notifier  (fired $val×)'),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          _SectionLabel('REGISTERED', cs.primary),
                          const SizedBox(height: 8),
                          const _SelectiveDependentCard(
                            label: 'Subscriber A',
                            isRegistered: true,
                          ),
                          const SizedBox(height: 8),
                          const _SelectiveDependentCard(
                            label: 'Subscriber B',
                            isRegistered: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          _SectionLabel('NOT REGISTERED', cs.outline),
                          const SizedBox(height: 8),
                          const _SelectiveIndependentCard(label: 'Bystander C'),
                          const SizedBox(height: 8),
                          const _SelectiveIndependentCard(label: 'Bystander D'),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Card(
                  color: cs.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'How selectivity works',
                          style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'An element becomes a dependent only when it calls '
                          'dependOnInheritedWidgetOfExactType during its build. The '
                          'framework stores this dependency in the element\'s '
                          '_dependencies set and in the InheritedElement\'s _dependents map.\n\n'
                          'When notifyClients() runs, it iterates _dependents. Elements '
                          'NOT in this map—no matter how deep in the same subtree—are '
                          'never visited. This is the foundation of Flutter\'s efficient '
                          'partial-tree rebuild model.',
                          style: tt.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                _CodeBlock(
                  code: '''
// This element WILL rebuild:
final value = context
    .dependOnInheritedWidgetOfExactType<MyScope>()
    ?.notifier?.value;

// This element will NOT rebuild:
// (reads without registering a dependency)
final scope = context
    .getInheritedWidgetOfExactType<MyScope>();''',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SelectiveDependentCard extends StatelessWidget {
  const _SelectiveDependentCard({required this.label, required this.isRegistered});

  final String label;
  final bool isRegistered;

  @override
  Widget build(BuildContext context) {
    // Registers this element as a dependent
    final int? value = _SelectiveScope.of(context)?.value;
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: cs.primary, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Icon(Icons.link_rounded, color: cs.primary, size: 20),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 6),
            _RebuildChip(count: value ?? 0, color: cs.primary),
          ],
        ),
      ),
    );
  }
}

class _SelectiveIndependentCard extends StatelessWidget {
  const _SelectiveIndependentCard({required this.label});

  final String label;

  // This widget deliberately does NOT call _SelectiveScope.of(context),
  // so it never registers as a dependent and never rebuilds.
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: cs.outline),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Icon(Icons.link_off_rounded, color: cs.outline, size: 20),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'never rebuilds',
                style: TextStyle(fontSize: 11, color: cs.outline, fontFamily: 'monospace'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 6 — Element Lifecycle
// ═══════════════════════════════════════════════════════════════════════════════

class _LifecycleTab extends StatelessWidget {
  const _LifecycleTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Element Lifecycle',
            style: tt.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Where NotifiableElementMixin intercepts within the standard element lifecycle.',
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 20),

          SizedBox(
            height: 520,
            child: CustomPaint(
              painter: _LifecycleDiagramPainter(
                primaryColor: cs.primary,
                secondaryColor: cs.secondary,
                tertiaryColor: cs.tertiary,
                errorColor: cs.error,
                onSurfaceColor: cs.onSurface,
                outlineColor: cs.outline,
                highlightColor: cs.tertiary,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // phase descriptions
          _PhaseCard(
            phase: 'createElement',
            color: cs.primaryContainer,
            description:
                'The framework creates the element for the widget. At this point, '
                'the element is not yet attached to the tree. NotifiableElementMixin '
                'is already mixed in but has no active dependencies.',
          ),
          const SizedBox(height: 10),
          _PhaseCard(
            phase: 'mount',
            color: cs.secondaryContainer,
            description:
                'The element is inserted into the element tree at a specific slot. '
                'Any inherited widgets in the ancestor chain are discoverable from '
                'this point. The first call to build() follows mount.',
          ),
          const SizedBox(height: 10),
          _PhaseCard(
            phase: 'didChangeDependencies ← HERE',
            color: cs.tertiaryContainer,
            description:
                'Called after mount AND whenever an inherited widget the element '
                'depends on changes. NotifiableElementMixin intercepts here: when '
                'the InheritedNotifier\'s Listenable fires, notifyDependent() calls '
                'didChangeDependencies() directly on this element, scheduling rebuild.',
            highlight: true,
          ),
          const SizedBox(height: 10),
          _PhaseCard(
            phase: 'build',
            color: cs.primaryContainer,
            description:
                'widget.build(context) is called. Any calls to '
                'dependOnInheritedWidgetOfExactType here register new dependencies '
                'that are then tracked for future notification.',
          ),
          const SizedBox(height: 10),
          _PhaseCard(
            phase: 'unmount',
            color: cs.errorContainer,
            description:
                'The element is removed from the tree. All dependency subscriptions '
                'are cleared. The element is no longer in any InheritedElement\'s '
                '_dependents map, so it will never receive further notifications.',
          ),
        ],
      ),
    );
  }
}

class _LifecycleDiagramPainter extends CustomPainter {
  const _LifecycleDiagramPainter({
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    required this.errorColor,
    required this.onSurfaceColor,
    required this.outlineColor,
    required this.highlightColor,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  final Color errorColor;
  final Color onSurfaceColor;
  final Color outlineColor;
  final Color highlightColor;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    const double boxW = 210;
    const double boxH = 44;
    const double gap = 22;
    const double startY = 10;

    final List<(String, Color, bool)> phases = <(String, Color, bool)>[
      ('createElement()', primaryColor, false),
      ('mount()', secondaryColor, false),
      ('didChangeDependencies()  ← NotifiableElementMixin', tertiaryColor, true),
      ('build()', primaryColor, false),
      ('update() / rebuild', secondaryColor, false),
      ('unmount()', errorColor, false),
    ];

    for (int i = 0; i < phases.length; i++) {
      final (String label, Color color, bool highlight) = phases[i];
      final double y = startY + i * (boxH + gap);
      final Rect rect = Rect.fromCenter(
        center: Offset(cx, y + boxH / 2),
        width: boxW,
        height: boxH,
      );
      final RRect rr = RRect.fromRectAndRadius(rect, const Radius.circular(8));

      canvas.drawRRect(rr, Paint()..color = color.withAlpha(highlight ? 80 : 35));
      canvas.drawRRect(
        rr,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = highlight ? 3 : 1.5,
      );

      if (highlight) {
        // glow
        canvas.drawRRect(
          rr.inflate(3),
          Paint()
            ..color = color.withAlpha(60)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 5,
        );
      }

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            fontSize: 10,
            color: onSurfaceColor,
            fontFamily: 'monospace',
            fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: boxW - 8);
      tp.paint(canvas, Offset(cx - tp.width / 2, y + (boxH - tp.height) / 2));

      if (i < phases.length - 1) {
        final double fromY = y + boxH;
        final double toY = startY + (i + 1) * (boxH + gap);
        canvas.drawLine(
          Offset(cx, fromY),
          Offset(cx, toY - 8),
          Paint()
            ..color = outlineColor
            ..strokeWidth = 1.5,
        );
        final Path head = Path()
          ..moveTo(cx, toY)
          ..lineTo(cx - 5, toY - 9)
          ..lineTo(cx + 5, toY - 9)
          ..close();
        canvas.drawPath(head, Paint()..color = outlineColor);
      }
    }

    // side annotation for the intercept point
    final double interceptY = startY + 2 * (boxH + gap);
    final TextPainter note = TextPainter(
      text: TextSpan(
        text: 'InheritedNotifier\nnotifies here',
        style: TextStyle(fontSize: 9, color: tertiaryColor),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    )..layout(maxWidth: 90);

    final double noteX = cx + boxW / 2 + 10;
    note.paint(canvas, Offset(noteX, interceptY + (boxH - note.height) / 2));

    canvas.drawLine(
      Offset(noteX - 2, interceptY + boxH / 2),
      Offset(cx + boxW / 2, interceptY + boxH / 2),
      Paint()
        ..color = tertiaryColor
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(_LifecycleDiagramPainter old) => false;
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 7 — Comparison with InheritedWidget
// ═══════════════════════════════════════════════════════════════════════════════

class _ComparisonTab extends StatelessWidget {
  const _ComparisonTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'InheritedWidget vs InheritedNotifier',
            style: tt.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Two mechanisms for propagating state down the widget tree, with different '
            'triggering semantics.',
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 20),

          // comparison table
          Table(
            border: TableBorder.all(color: cs.outline, borderRadius: BorderRadius.circular(8)),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: <TableRow>[
              _tableHeader(cs, tt, <String>['Aspect', 'InheritedWidget', 'InheritedNotifier']),
              _tableRow(cs, tt, <String>[
                'Trigger',
                'Parent rebuilds → updateShouldNotify() returns true',
                'Listenable fires (e.g. ValueNotifier.value = x)',
              ]),
              _tableRow(cs, tt, <String>[
                'Rebuild method',
                'markNeedsBuild on all dependents',
                'notifyClients() → notifyDependent() → didChangeDependencies()',
              ]),
              _tableRow(cs, tt, <String>[
                'Element hook',
                '(none app-level)',
                'NotifiableElementMixin.onNotification()',
              ]),
              _tableRow(cs, tt, <String>[
                'Notification consumed?',
                'N/A',
                'Yes if onNotification() returns true',
              ]),
              _tableRow(cs, tt, <String>[
                'Parent rebuild required?',
                'Yes — must rebuild parent to trigger cascade',
                'No — Listenable fires independently of widget rebuild',
              ]),
              _tableRow(cs, tt, <String>[
                'Typical use case',
                'Theme, MediaQuery, Navigator',
                'Animation controllers, ChangeNotifier models',
              ]),
              _tableRow(cs, tt, <String>[
                'Performance characteristic',
                'Rebuilds all dependents whenever parent rebuilds (if shouldNotify)',
                'Rebuilds dependents ONLY when Listenable fires, no parent rebuild overhead',
              ]),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Card(
                  color: cs.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'InheritedWidget',
                          style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Best when data is derived from the build context itself and changes '
                          'when an ancestor widget is rebuilt. Does not require external Listenable.',
                          style: tt.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Card(
                  color: cs.secondaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'InheritedNotifier',
                          style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Best when the source of truth is a long-lived Listenable (model, '
                          'animation, stream controller). Rebuilds only when the Listenable fires, '
                          'not on every parent rebuild.',
                          style: tt.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TableRow _tableHeader(ColorScheme cs, TextTheme tt, List<String> cells) {
    return TableRow(
      decoration: BoxDecoration(color: cs.surfaceContainerHighest),
      children: cells
          .map(
            (String c) => Padding(
              padding: const EdgeInsets.all(8),
              child: Text(c, style: tt.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
          )
          .toList(),
    );
  }

  TableRow _tableRow(ColorScheme cs, TextTheme tt, List<String> cells) {
    return TableRow(
      children: cells
          .map(
            (String c) => Padding(
              padding: const EdgeInsets.all(8),
              child: Text(c, style: tt.bodySmall),
            ),
          )
          .toList(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 8 — Practical Code Snippet
// ═══════════════════════════════════════════════════════════════════════════════

class _SnippetTab extends StatelessWidget {
  const _SnippetTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Practical Code Snippet',
            style: tt.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'A complete InheritedNotifier subclass. Annotations highlight which parts '
            'rely on NotifiableElementMixin internally.',
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 20),

          _AnnotatedCodeBlock(
            segments: const <_CodeSegment>[
              _CodeSegment(
                code: '// 1. Define your Listenable model\n'
                    'class CounterModel extends ChangeNotifier {\n'
                    '  int _value = 0;\n'
                    '  int get value => _value;\n'
                    '  void increment() {\n'
                    '    _value++;\n'
                    '    notifyListeners(); // ← triggers the whole chain\n'
                    '  }\n'
                    '}\n',
                annotationIndex: 0,
              ),
              _CodeSegment(
                code: '\n// 2. Wrap it in an InheritedNotifier\n'
                    'class CounterScope\n'
                    '    extends InheritedNotifier<CounterModel> {\n'
                    '  const CounterScope({\n'
                    '    required CounterModel notifier,\n'
                    '    required Widget child,\n'
                    '    super.key,\n'
                    '  }) : super(notifier: notifier, child: child);\n'
                    '\n'
                    '  // No updateShouldNotify needed:\n'
                    '  // InheritedNotifier handles it automatically.\n'
                    '\n'
                    '  static CounterModel of(BuildContext context) =>\n'
                    '    context\n'
                    '      .dependOnInheritedWidgetOfExactType<CounterScope>()!\n'
                    '      .notifier!;\n'
                    '      // ↑ This registers the element as a dependent\n'
                    '      //   → NotifiableElementMixin.onNotification() fires\n'
                    '      //     when notifier.notifyListeners() is called\n'
                    '}\n',
                annotationIndex: 1,
              ),
              _CodeSegment(
                code: '\n// 3. Consume in a stateless widget\n'
                    'class CounterDisplay extends StatelessWidget {\n'
                    '  const CounterDisplay({super.key});\n'
                    '\n'
                    '  @override\n'
                    '  Widget build(BuildContext context) {\n'
                    '    // dependOnInheritedWidgetOfExactType registers\n'
                    '    // this element in the InheritedElement._dependents map.\n'
                    '    final model = CounterScope.of(context);\n'
                    '    return Text(\'Count: \${model.value}\');\n'
                    '  }\n'
                    '}\n',
                annotationIndex: 2,
              ),
              _CodeSegment(
                code: '\n// 4. Trigger from anywhere\n'
                    'CounterScope.of(context).increment();\n'
                    '// → ChangeNotifier.notifyListeners()\n'
                    '// → InheritedNotifier._handleUpdate()\n'
                    '// → InheritedElement.notifyClients()\n'
                    '// → NotifiableElementMixin.onNotification() per dependent\n'
                    '// → element.didChangeDependencies()\n'
                    '// → element.markNeedsBuild()\n'
                    '// → widget.build(context) on next frame\n',
                annotationIndex: 3,
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text('Annotation Key', style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          _AnnotationKey(
            index: 0,
            color: cs.primary,
            text:
                'ChangeNotifier.notifyListeners() is the entry point. It is the call '
                'that ultimately drives NotifiableElementMixin.onNotification().',
          ),
          const SizedBox(height: 8),
          _AnnotationKey(
            index: 1,
            color: cs.secondary,
            text:
                'InheritedNotifier subscribes to the Listenable in initState/didUpdateWidget. '
                'When the Listenable fires, InheritedNotifier calls notifyClients() which '
                'visits each NotifiableElementMixin dependent.',
          ),
          const SizedBox(height: 8),
          _AnnotationKey(
            index: 2,
            color: cs.tertiary,
            text:
                'dependOnInheritedWidgetOfExactType is what registers the element. Without '
                'this call, the element is not in _dependents and onNotification() is never '
                'called for it.',
          ),
          const SizedBox(height: 8),
          _AnnotationKey(
            index: 3,
            color: cs.error,
            text:
                'The full call chain from user action to rebuild, showing exactly where '
                'NotifiableElementMixin participates.',
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 9 — Pitfalls
// ═══════════════════════════════════════════════════════════════════════════════

class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Common Pitfalls',
            style: tt.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Mistakes that can cause subtle bugs or performance issues when working with '
            'InheritedNotifier and NotifiableElementMixin.',
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 20),

          _PitfallCard(
            number: 1,
            title: 'Calling notifyListeners() during build',
            severity: 'Critical',
            severityColor: cs.error,
            description:
                'Calling notifyListeners() (or setting a ValueNotifier.value) synchronously '
                'inside a build() method triggers an immediate call to notifyClients(), which '
                'tries to mark elements as dirty while the framework is already in a build phase. '
                'This throws a "setState() or markNeedsBuild() called during build" assertion.',
            badCode:
                '@override\n'
                'Widget build(BuildContext context) {\n'
                '  myNotifier.value++; // ← THROWS!\n'
                '  return Text(\'...\')\n'
                '}',
            goodCode:
                '@override\n'
                'Widget build(BuildContext context) {\n'
                '  WidgetsBinding.instance\n'
                '      .addPostFrameCallback((_) {\n'
                '    myNotifier.value++; // safe\n'
                '  });\n'
                '  return Text(\'...\');\n'
                '}',
          ),

          const SizedBox(height: 16),

          _PitfallCard(
            number: 2,
            title: 'Deep notification chains causing jank',
            severity: 'Performance',
            severityColor: cs.tertiary,
            description:
                'If an InheritedNotifier\'s Listenable fires very frequently (e.g., from an '
                'animation ticker at 60fps) and many widgets are registered as dependents, each '
                'frame causes hundreds of didChangeDependencies() calls and rebuilds. This can '
                'drop frame rate significantly.',
            badCode:
                '// Animation controller notifier at 60fps\n'
                '// with 200 dependents:\n'
                '// 60 × 200 = 12,000 rebuilds/sec',
            goodCode:
                '// Prefer AnimatedBuilder / AnimationBuilder\n'
                '// to scope rebuilds to a single subtree,\n'
                '// or use AnimatedWidget directly.',
          ),

          const SizedBox(height: 16),

          _PitfallCard(
            number: 3,
            title: 'Missing dependency registration',
            severity: 'Logic Bug',
            severityColor: cs.secondary,
            description:
                'Using getInheritedWidgetOfExactType instead of dependOnInheritedWidgetOfExactType '
                'reads the widget value WITHOUT registering a dependency. The element will never be '
                'notified when the Listenable fires, producing stale UI.',
            badCode:
                '// Reads value but does NOT subscribe:\n'
                'final scope = context\n'
                '    .getInheritedWidgetOfExactType<MyScope>();\n'
                '// scope?.notifier?.value is stale!',
            goodCode:
                '// Reads AND subscribes:\n'
                'final scope = context\n'
                '    .dependOnInheritedWidgetOfExactType<MyScope>();\n'
                '// Rebuilds when notifier fires.',
          ),

          const SizedBox(height: 16),

          _PitfallCard(
            number: 4,
            title: 'Disposing the Listenable too early',
            severity: 'Crash',
            severityColor: cs.error,
            description:
                'If you dispose the Listenable (e.g., a ValueNotifier or ChangeNotifier) while '
                'the InheritedNotifier is still in the tree, its _handleUpdate listener still '
                'holds a reference. A subsequent notifyListeners() call on the disposed object '
                'may throw or access freed memory.',
            badCode:
                '// Parent disposes before child scope is removed:\n'
                'myNotifier.dispose(); // ← scope still active!',
            goodCode:
                '// Ensure InheritedNotifier is removed from\n'
                '// the tree (parent widget is unmounted) before\n'
                '// disposing the Listenable.',
          ),

          const SizedBox(height: 16),

          _PitfallCard(
            number: 5,
            title: 'Returning true from onNotification without rebuilding',
            severity: 'Logic Bug',
            severityColor: cs.secondary,
            description:
                'If an element\'s onNotification() returns true (consumed), the framework skips '
                'didChangeDependencies() for that element. If the element needed a rebuild, it must '
                'call markNeedsBuild() itself before returning true. Omitting this leaves the UI stale.',
            badCode:
                '@override\n'
                'bool onNotification() {\n'
                '  // Consumed, but forgot to rebuild!\n'
                '  return true;\n'
                '}',
            goodCode:
                '@override\n'
                'bool onNotification() {\n'
                '  markNeedsBuild(); // schedule rebuild\n'
                '  return true; // then consume\n'
                '}',
          ),

          const SizedBox(height: 20),

          Card(
            color: cs.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'General guidelines',
                    style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _BulletPoint('Prefer ValueListenableBuilder / AnimatedBuilder for frequent updates.'),
                  _BulletPoint('Use select() (from Provider or similar) to narrow rebuild scope.'),
                  _BulletPoint('Always register dependencies via dependOnInheritedWidgetOfExactType.'),
                  _BulletPoint('Never call notifyListeners() synchronously inside build().'),
                  _BulletPoint(
                    'Dispose Listenables only after the InheritedNotifier has been removed from the tree.',
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

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helper widgets
// ═══════════════════════════════════════════════════════════════════════════════

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, color: cs.onPrimary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(body, style: tt.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.outline),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: cs.onSurface),
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;

    return Row(
      children: <Widget>[
        Container(width: 16, height: 16, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: tt.bodySmall),
      ],
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.step, required this.text});

  final String step;
  final String text;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
            child: Center(
              child: Text(
                step,
                style: TextStyle(fontSize: 11, color: cs.onPrimary, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: tt.bodySmall)),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outline),
      ),
      child: SelectableText(
        code,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: cs.onSurface,
          height: 1.5,
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text, this.color);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

class _RebuildChip extends StatelessWidget {
  const _RebuildChip({required this.count, required this.color});

  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Text(
        'rebuilt $count×',
        style: TextStyle(fontSize: 11, color: color, fontFamily: 'monospace'),
      ),
    );
  }
}

class _PhaseCard extends StatelessWidget {
  const _PhaseCard({
    required this.phase,
    required this.color,
    required this.description,
    this.highlight = false,
  });

  final String phase;
  final Color color;
  final String description;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;

    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: highlight ? BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 2) : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(phase, style: tt.titleSmall?.copyWith(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(description, style: tt.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.number,
    required this.title,
    required this.severity,
    required this.severityColor,
    required this.description,
    required this.badCode,
    required this.goodCode,
  });

  final int number;
  final String title;
  final String severity;
  final Color severityColor;
  final String description;
  final String badCode;
  final String goodCode;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      '$number',
                      style: TextStyle(color: cs.onPrimary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(title, style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: severityColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: severityColor),
                  ),
                  child: Text(
                    severity,
                    style: TextStyle(fontSize: 10, color: severityColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(description, style: tt.bodySmall),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.close_rounded, size: 14, color: cs.error),
                          const SizedBox(width: 4),
                          Text('Avoid', style: tt.labelSmall?.copyWith(color: cs.error)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: cs.errorContainer.withAlpha(60),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          badCode,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: cs.onSurface),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.check_rounded, size: 14, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(
                            'Prefer',
                            style: tt.labelSmall?.copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.withAlpha(30),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          goodCode,
                          style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: cs.onSurface),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  const _BulletPoint(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 5, right: 8),
            decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
          ),
          Expanded(child: Text(text, style: tt.bodySmall)),
        ],
      ),
    );
  }
}

class _AnnotationKey extends StatelessWidget {
  const _AnnotationKey({required this.index, required this.color, required this.text});

  final int index;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    final TextTheme tt = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(
              '${index + 1}',
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: tt.bodySmall)),
      ],
    );
  }
}

// ─── Annotated code block ──────────────────────────────────────────────────────

class _CodeSegment {
  const _CodeSegment({required this.code, required this.annotationIndex});

  final String code;
  final int annotationIndex;
}

class _AnnotatedCodeBlock extends StatelessWidget {
  const _AnnotatedCodeBlock({required this.segments});

  final List<_CodeSegment> segments;

  static const List<Color> _annotationColors = <Color>[
    Color(0xFF6750A4),
    Color(0xFF006874),
    Color(0xFF7D5260),
    Color(0xFFB3261E),
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: segments.map((seg) {
          final Color accent = _annotationColors[seg.annotationIndex % _annotationColors.length];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 3,
                margin: const EdgeInsets.only(right: 10, top: 2),
                color: accent,
                constraints: const BoxConstraints(minHeight: 40),
                child: LayoutBuilder(
                  builder: (BuildContext ctx, BoxConstraints bc) {
                    return const SizedBox.shrink();
                  },
                ),
              ),
              Expanded(
                child: SelectableText(
                  seg.code,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: cs.onSurface,
                    height: 1.5,
                  ),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.only(left: 6, top: 2),
                decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    '${seg.annotationIndex + 1}',
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

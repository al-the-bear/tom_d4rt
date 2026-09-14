import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final ValueNotifier<_PlatformOwner> platform =
      ValueNotifier<_PlatformOwner>(_PlatformOwner.linux);
  final ValueNotifier<_WindowStateMode> stateMode =
      ValueNotifier<_WindowStateMode>(_WindowStateMode.normal);
  final ValueNotifier<double> windowCount = ValueNotifier<double>(3);
  final ValueNotifier<double> focusWindow = ValueNotifier<double>(1);
  final ValueNotifier<bool> allowTiling = ValueNotifier<bool>(true);
  final ValueNotifier<bool> allowModalStack = ValueNotifier<bool>(true);
  final ValueNotifier<bool> multiMonitor = ValueNotifier<bool>(true);

  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3F4F9D)),
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    ),
    child: DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFFEEF0FD), Color(0xFFF8F4EC)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        children: <Widget>[
          const _OwnerHero(),
          const SizedBox(height: 16),
          _OwnerControlPanel(
            platform: platform,
            stateMode: stateMode,
            windowCount: windowCount,
            focusWindow: focusWindow,
            allowTiling: allowTiling,
            allowModalStack: allowModalStack,
            multiMonitor: multiMonitor,
          ),
          const SizedBox(height: 16),
          _OwnerContractBoard(platform: platform),
          const SizedBox(height: 16),
          _OwnerImplementationMatrix(platform: platform),
          const SizedBox(height: 16),
          _OwnerOrchestrationCanvas(
            platform: platform,
            stateMode: stateMode,
            windowCount: windowCount,
            focusWindow: focusWindow,
            allowTiling: allowTiling,
            allowModalStack: allowModalStack,
            multiMonitor: multiMonitor,
          ),
          const SizedBox(height: 16),
          _OwnerMessageTimeline(platform: platform),
          const SizedBox(height: 16),
          _OwnerRecipeDeck(platform: platform),
          const SizedBox(height: 16),
          const _OwnerChecklist(),
        ],
      ),
    ),
  );
}

enum _PlatformOwner {
  linux,
  macOS,
  win32,
}

enum _WindowStateMode {
  normal,
  maximized,
  minimized,
  fullscreen,
}

class _OwnerHero extends StatelessWidget {
  const _OwnerHero();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xFF3F4F9D),
                  child: Icon(Icons.settings_applications, color: Colors.white),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'WindowingOwner Deep Demo',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'WindowingOwner is the abstract contract coordinating platform '
              'window lifecycles for Flutter desktop internals. This demo maps '
              'shared responsibilities, platform implementation differences, and '
              'event-orchestration behavior through a visual operations board.',
            ),
          ],
        ),
      ),
    );
  }
}

class _OwnerControlPanel extends StatelessWidget {
  const _OwnerControlPanel({
    required this.platform,
    required this.stateMode,
    required this.windowCount,
    required this.focusWindow,
    required this.allowTiling,
    required this.allowModalStack,
    required this.multiMonitor,
  });

  final ValueNotifier<_PlatformOwner> platform;
  final ValueNotifier<_WindowStateMode> stateMode;
  final ValueNotifier<double> windowCount;
  final ValueNotifier<double> focusWindow;
  final ValueNotifier<bool> allowTiling;
  final ValueNotifier<bool> allowModalStack;
  final ValueNotifier<bool> multiMonitor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder7<_PlatformOwner, _WindowStateMode, double,
            double, bool, bool, bool>(
          first: platform,
          second: stateMode,
          third: windowCount,
          fourth: focusWindow,
          fifth: allowTiling,
          sixth: allowModalStack,
          seventh: multiMonitor,
          builder: (BuildContext context, _PlatformOwner owner,
              _WindowStateMode mode, double count, double focus, bool tiling,
              bool modal, bool monitors) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Owner Command Panel',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final _PlatformOwner value in _PlatformOwner.values)
                      ChoiceChip(
                        selected: owner == value,
                        label: Text(value.name),
                        onSelected: (_) => platform.value = value,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final _WindowStateMode value in _WindowStateMode.values)
                      FilterChip(
                        selected: mode == value,
                        label: Text(value.name),
                        onSelected: (_) => stateMode.value = value,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Window count: ${count.toStringAsFixed(0)}'),
                Slider(
                  min: 1,
                  max: 6,
                  divisions: 5,
                  value: count,
                  onChanged: (double v) {
                    windowCount.value = v;
                    if (focusWindow.value > v) {
                      focusWindow.value = v;
                    }
                  },
                ),
                Text('Focused window index: ${focus.toStringAsFixed(0)}'),
                Slider(
                  min: 1,
                  max: count,
                  divisions: (count - 1).round().clamp(1, 5),
                  value: focus,
                  onChanged: (double v) => focusWindow.value = v,
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Allow tiling orchestration'),
                  value: tiling,
                  onChanged: (bool v) => allowTiling.value = v,
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Allow modal stack management'),
                  value: modal,
                  onChanged: (bool v) => allowModalStack.value = v,
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Multi-monitor routing enabled'),
                  value: monitors,
                  onChanged: (bool v) => multiMonitor.value = v,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OwnerContractBoard extends StatelessWidget {
  const _OwnerContractBoard({required this.platform});

  final ValueNotifier<_PlatformOwner> platform;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder<_PlatformOwner>(
          valueListenable: platform,
          builder: (BuildContext context, _PlatformOwner value, Widget? child) {
            final List<_ContractMethod> methods = <_ContractMethod>[
              const _ContractMethod(
                name: 'createWindow()',
                purpose: 'Allocates native window and attaches render view host.',
              ),
              const _ContractMethod(
                name: 'destroyWindow()',
                purpose: 'Tears down native resources and listeners safely.',
              ),
              const _ContractMethod(
                name: 'setWindowBounds()',
                purpose: 'Applies geometry updates after policy validation.',
              ),
              const _ContractMethod(
                name: 'setWindowState()',
                purpose: 'Transitions between normal, maximized, and fullscreen.',
              ),
              _ContractMethod(
                name: 'dispatchPlatformEvent()',
                purpose: 'Routes ${value.name} callbacks into framework lifecycle.',
              ),
            ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Abstract Contract Board',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                for (final _ContractMethod method in methods)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFD3DFE6)),
                        color: const Color(0xFFF8FBFD),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Icon(Icons.functions, color: Color(0xFF3F4F9D), size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    method.name,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(method.purpose),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OwnerImplementationMatrix extends StatelessWidget {
  const _OwnerImplementationMatrix({required this.platform});

  final ValueNotifier<_PlatformOwner> platform;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder<_PlatformOwner>(
          valueListenable: platform,
          builder: (BuildContext context, _PlatformOwner selected, Widget? child) {
            final List<_ImplementationRow> rows = <_ImplementationRow>[
              _ImplementationRow('Linux', 'Wayland/X11 bridge', selected == _PlatformOwner.linux),
              _ImplementationRow('macOS', 'Cocoa NSWindow adapter', selected == _PlatformOwner.macOS),
              _ImplementationRow('Win32', 'HWND message loop owner', selected == _PlatformOwner.win32),
            ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Implementation Matrix',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                for (final _ImplementationRow row in rows)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: row.active
                              ? const Color(0xFF5263B6)
                              : const Color(0xFFD3DFE6),
                          width: row.active ? 1.6 : 1,
                        ),
                        color: row.active
                            ? const Color(0xFFEFF2FF)
                            : const Color(0xFFF8FBFD),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 100,
                              child: Text(
                                row.platform,
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            Expanded(child: Text(row.adapter)),
                            Chip(
                              label: Text(row.active ? 'active' : 'standby'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OwnerOrchestrationCanvas extends StatelessWidget {
  const _OwnerOrchestrationCanvas({
    required this.platform,
    required this.stateMode,
    required this.windowCount,
    required this.focusWindow,
    required this.allowTiling,
    required this.allowModalStack,
    required this.multiMonitor,
  });

  final ValueNotifier<_PlatformOwner> platform;
  final ValueNotifier<_WindowStateMode> stateMode;
  final ValueNotifier<double> windowCount;
  final ValueNotifier<double> focusWindow;
  final ValueNotifier<bool> allowTiling;
  final ValueNotifier<bool> allowModalStack;
  final ValueNotifier<bool> multiMonitor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder7<_PlatformOwner, _WindowStateMode, double,
            double, bool, bool, bool>(
          first: platform,
          second: stateMode,
          third: windowCount,
          fourth: focusWindow,
          fifth: allowTiling,
          sixth: allowModalStack,
          seventh: multiMonitor,
          builder: (BuildContext context, _PlatformOwner owner,
              _WindowStateMode mode, double count, double focus, bool tiling,
              bool modal, bool monitors) {
            final _OrchestrationResult result = _simulateOwner(
              owner: owner,
              stateMode: mode,
              windowCount: count.round(),
              focusWindow: focus.round(),
              allowTiling: tiling,
              allowModalStack: modal,
              multiMonitor: monitors,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Orchestration Simulation',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                AspectRatio(
                  aspectRatio: 1.85,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFD0DEE6)),
                    ),
                    child: CustomPaint(
                      painter: _OwnerSimulationPainter(result: result),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Dispatch steps: ${result.steps.join(' -> ')}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(result.summary),
              ],
            );
          },
        ),
      ),
    );
  }
}

_OrchestrationResult _simulateOwner({
  required _PlatformOwner owner,
  required _WindowStateMode stateMode,
  required int windowCount,
  required int focusWindow,
  required bool allowTiling,
  required bool allowModalStack,
  required bool multiMonitor,
}) {
  final List<_WindowNode> nodes = <_WindowNode>[];
  final List<String> steps = <String>['collect'];

  for (int i = 0; i < windowCount; i++) {
    final bool focused = (i + 1) == focusWindow;
    final Rect rect = allowTiling
        ? Rect.fromLTWH(30 + i * 130, 40 + i * 20, 240, 150)
        : Rect.fromLTWH(70 + i * 40, 70 + i * 30, 260, 170);
    nodes.add(_WindowNode(id: i + 1, rect: rect, focused: focused));
  }

  steps.add('route-${owner.name}');
  if (allowModalStack) {
    steps.add('modal-check');
  }
  if (multiMonitor) {
    steps.add('monitor-map');
  }
  steps.add('state-${stateMode.name}');
  steps.add('commit');

  return _OrchestrationResult(
    nodes: nodes,
    steps: steps,
    summary:
        'Owner ${owner.name} manages $windowCount windows, focus on #$focusWindow, state ${stateMode.name}.',
    owner: owner,
  );
}

class _OwnerMessageTimeline extends StatelessWidget {
  const _OwnerMessageTimeline({required this.platform});

  final ValueNotifier<_PlatformOwner> platform;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder<_PlatformOwner>(
          valueListenable: platform,
          builder: (BuildContext context, _PlatformOwner owner, Widget? child) {
            final List<_MessageStep> messages = <_MessageStep>[
              const _MessageStep('framework request', 'setWindowBounds(windowId, rect)'),
              _MessageStep('owner translate', 'translate to ${owner.name} protocol payload'),
              const _MessageStep('platform callback', 'native event pushed to bridge queue'),
              const _MessageStep('state sync', 'WidgetsBinding observer receives update'),
            ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Owner Message Timeline',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                for (int i = 0; i < messages.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: const Color(0xFF3F4F9D),
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFD3DFE6)),
                              color: const Color(0xFFF8FBFD),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    messages[i].title,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(messages[i].detail),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OwnerRecipeDeck extends StatelessWidget {
  const _OwnerRecipeDeck({required this.platform});

  final ValueNotifier<_PlatformOwner> platform;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder<_PlatformOwner>(
          valueListenable: platform,
          builder: (BuildContext context, _PlatformOwner owner, Widget? child) {
            final List<_RecipeCard> cards = <_RecipeCard>[
              const _RecipeCard(
                title: 'Abstract facade call',
                code:
                    'owner.setWindowState(windowId, WindowState.maximized);\nowner.setWindowBounds(windowId, nextBounds);',
                note: 'Callers stay platform-agnostic through the owner contract.',
              ),
              _RecipeCard(
                title: 'Owner selection',
                code:
                    'WindowingOwner owner = switch(platform) {\n  linux => WindowingOwnerLinux(),\n  macOS => WindowingOwnerMacOS(),\n  win32 => WindowingOwnerWin32(),\n};',
                note: 'Current selected platform in this demo: ${owner.name}.',
              ),
              const _RecipeCard(
                title: 'Event relay',
                code:
                    'platformEventStream.listen((event) {\n  owner.dispatchPlatformEvent(event);\n});',
                note: 'Keeps native callbacks synchronized with framework state.',
              ),
            ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Owner Integration Recipes',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: cards
                      .map(
                        (_RecipeCard card) => SizedBox(
                          width: 320,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFD6E1E6)),
                              color: const Color(0xFFF8FBFD),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    card.title,
                                    style: const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xFF13262C),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      card.code,
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        color: Color(0xFFD5F5FF),
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(card.note),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OwnerChecklist extends StatelessWidget {
  const _OwnerChecklist();

  @override
  Widget build(BuildContext context) {
    const List<String> checks = <String>[
      'Control panel configures platform, states, and orchestration toggles.',
      'Contract board explains owner responsibilities with concrete method roles.',
      'Implementation matrix compares Linux/macOS/Win32 behavior pathways.',
      'Simulation canvas visualizes multi-window orchestration outcomes.',
      'Recipe and timeline sections provide instructive, platform-aware usage context.',
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Demo Validation Checklist',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            const SizedBox(height: 8),
            for (final String item in checks)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.check_circle, size: 16),
                    const SizedBox(width: 8),
                    Expanded(child: Text(item)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _OwnerSimulationPainter extends CustomPainter {
  const _OwnerSimulationPainter({required this.result});

  final _OrchestrationResult result;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFF4F8FC);
    canvas.drawRect(Offset.zero & size, bg);

    if (result.owner != _PlatformOwner.macOS) {
      final Paint split = Paint()
        ..color = const Color(0xFFD4E0E7)
        ..strokeWidth = 2;
      canvas.drawLine(
        Offset(size.width * 0.55, 0),
        Offset(size.width * 0.55, size.height),
        split,
      );
    }

    for (final _WindowNode node in result.nodes) {
      final Rect rect = Rect.fromLTWH(
        node.rect.left / 820 * size.width,
        node.rect.top / 420 * size.height,
        node.rect.width / 820 * size.width,
        node.rect.height / 420 * size.height,
      );
      final Color color = node.focused
          ? const Color(0xFF5A6DD0)
          : const Color(0xFF88A0AF);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10)),
        Paint()..color = color.withValues(alpha: 0.22),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(10)),
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );

      final TextPainter label = TextPainter(
        text: TextSpan(
          text: 'W${node.id}',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      label.paint(canvas, Offset(rect.left + 8, rect.top + 8));
    }
  }

  @override
  bool shouldRepaint(covariant _OwnerSimulationPainter oldDelegate) {
    return oldDelegate.result != result;
  }
}

class _ContractMethod {
  const _ContractMethod({required this.name, required this.purpose});

  final String name;
  final String purpose;
}

class _ImplementationRow {
  const _ImplementationRow(this.platform, this.adapter, this.active);

  final String platform;
  final String adapter;
  final bool active;
}

class _WindowNode {
  const _WindowNode({
    required this.id,
    required this.rect,
    required this.focused,
  });

  final int id;
  final Rect rect;
  final bool focused;
}

class _OrchestrationResult {
  const _OrchestrationResult({
    required this.nodes,
    required this.steps,
    required this.summary,
    required this.owner,
  });

  final List<_WindowNode> nodes;
  final List<String> steps;
  final String summary;
  final _PlatformOwner owner;
}

class _MessageStep {
  const _MessageStep(this.title, this.detail);

  final String title;
  final String detail;
}

class _RecipeCard {
  const _RecipeCard({
    required this.title,
    required this.code,
    required this.note,
  });

  final String title;
  final String code;
  final String note;
}

class ValueListenableBuilder7<A, B, C, D, E, F, G> extends StatelessWidget {
  const ValueListenableBuilder7({
    super.key,
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.fifth,
    required this.sixth,
    required this.seventh,
    required this.builder,
  });

  final ValueNotifier<A> first;
  final ValueNotifier<B> second;
  final ValueNotifier<C> third;
  final ValueNotifier<D> fourth;
  final ValueNotifier<E> fifth;
  final ValueNotifier<F> sixth;
  final ValueNotifier<G> seventh;
  final Widget Function(BuildContext context, A a, B b, C c, D d, E e, F f,
      G g) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (BuildContext context, A a, Widget? child) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (BuildContext context, B b, Widget? nested) {
            return ValueListenableBuilder<C>(
              valueListenable: third,
              builder: (BuildContext context, C c, Widget? leaf) {
                return ValueListenableBuilder<D>(
                  valueListenable: fourth,
                  builder: (BuildContext context, D d, Widget? deep) {
                    return ValueListenableBuilder<E>(
                      valueListenable: fifth,
                      builder: (BuildContext context, E e, Widget? deeper) {
                        return ValueListenableBuilder<F>(
                          valueListenable: sixth,
                          builder: (BuildContext context, F f, Widget? l1) {
                            return ValueListenableBuilder<G>(
                              valueListenable: seventh,
                              builder: (BuildContext context, G g, Widget? l2) {
                                return builder(context, a, b, c, d, e, f, g);
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

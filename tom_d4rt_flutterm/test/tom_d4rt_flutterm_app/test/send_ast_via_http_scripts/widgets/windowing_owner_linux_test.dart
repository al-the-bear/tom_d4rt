import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final ValueNotifier<_LinuxBackend> backend =
      ValueNotifier<_LinuxBackend>(_LinuxBackend.wayland);
  final ValueNotifier<_LinuxWindowRole> role =
      ValueNotifier<_LinuxWindowRole>(_LinuxWindowRole.toplevel);
  final ValueNotifier<bool> clientSideDecorations = ValueNotifier<bool>(true);
  final ValueNotifier<bool> fractionalScale = ValueNotifier<bool>(true);
  final ValueNotifier<double> width = ValueNotifier<double>(720);
  final ValueNotifier<double> height = ValueNotifier<double>(440);
  final ValueNotifier<double> posX = ValueNotifier<double>(180);
  final ValueNotifier<double> posY = ValueNotifier<double>(110);

  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D6471)),
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
          colors: <Color>[Color(0xFFEBF8FA), Color(0xFFFFF3EA)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        children: <Widget>[
          const _LinuxHero(),
          const SizedBox(height: 16),
          _BackendControlPanel(
            backend: backend,
            role: role,
            clientSideDecorations: clientSideDecorations,
            fractionalScale: fractionalScale,
            width: width,
            height: height,
            posX: posX,
            posY: posY,
          ),
          const SizedBox(height: 16),
          _LinuxFeatureMatrix(backend: backend, role: role),
          const SizedBox(height: 16),
          _CompositorSimulation(
            backend: backend,
            role: role,
            clientSideDecorations: clientSideDecorations,
            fractionalScale: fractionalScale,
            width: width,
            height: height,
            posX: posX,
            posY: posY,
          ),
          const SizedBox(height: 16),
          _ProtocolTimeline(backend: backend),
          const SizedBox(height: 16),
          _LinuxRecipes(backend: backend),
          const SizedBox(height: 16),
          const _LinuxChecklist(),
        ],
      ),
    ),
  );
}

enum _LinuxBackend {
  wayland,
  x11,
}

enum _LinuxWindowRole {
  toplevel,
  popup,
  layerSurface,
  utility,
}

class _LinuxHero extends StatelessWidget {
  const _LinuxHero();

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
                  backgroundColor: Color(0xFF0D6471),
                  child: Icon(Icons.desktop_windows, color: Colors.white),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'WindowingOwnerLinux Deep Demo',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'WindowingOwnerLinux is the Linux-specific window management layer '
              'inside Flutter internals. It translates framework window intents '
              'into protocol actions for Wayland or X11. This demo visualizes '
              'backend capabilities, role semantics, and compositor outcomes.',
            ),
          ],
        ),
      ),
    );
  }
}

class _BackendControlPanel extends StatelessWidget {
  const _BackendControlPanel({
    required this.backend,
    required this.role,
    required this.clientSideDecorations,
    required this.fractionalScale,
    required this.width,
    required this.height,
    required this.posX,
    required this.posY,
  });

  final ValueNotifier<_LinuxBackend> backend;
  final ValueNotifier<_LinuxWindowRole> role;
  final ValueNotifier<bool> clientSideDecorations;
  final ValueNotifier<bool> fractionalScale;
  final ValueNotifier<double> width;
  final ValueNotifier<double> height;
  final ValueNotifier<double> posX;
  final ValueNotifier<double> posY;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder8<_LinuxBackend, _LinuxWindowRole, bool,
            bool, double, double, double, double>(
          first: backend,
          second: role,
          third: clientSideDecorations,
          fourth: fractionalScale,
          fifth: width,
          sixth: height,
          seventh: posX,
          eighth: posY,
          builder: (BuildContext context, _LinuxBackend backendValue,
              _LinuxWindowRole roleValue, bool csd, bool scaleEnabled,
              double w, double h, double x, double y) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Linux Backend Control Panel',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final _LinuxBackend value in _LinuxBackend.values)
                      ChoiceChip(
                        selected: value == backendValue,
                        label: Text(value.name),
                        onSelected: (_) => backend.value = value,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final _LinuxWindowRole value in _LinuxWindowRole.values)
                      FilterChip(
                        selected: value == roleValue,
                        label: Text(value.name),
                        onSelected: (_) => role.value = value,
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Client-side decorations'),
                  subtitle: const Text(
                    'Header bars managed in Flutter rather than compositor frame.',
                  ),
                  value: csd,
                  onChanged: (bool v) => clientSideDecorations.value = v,
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Fractional scale negotiation'),
                  subtitle: const Text(
                    'Enable scale factors such as 1.25x on high-DPI monitors.',
                  ),
                  value: scaleEnabled,
                  onChanged: (bool v) => fractionalScale.value = v,
                ),
                const SizedBox(height: 6),
                Text('Window width: ${w.toStringAsFixed(0)}'),
                Slider(
                  min: 220,
                  max: 1100,
                  value: w,
                  onChanged: (double v) => width.value = v,
                ),
                Text('Window height: ${h.toStringAsFixed(0)}'),
                Slider(
                  min: 180,
                  max: 760,
                  value: h,
                  onChanged: (double v) => height.value = v,
                ),
                Text('Position X: ${x.toStringAsFixed(0)}'),
                Slider(
                  min: 0,
                  max: 560,
                  value: x,
                  onChanged: (double v) => posX.value = v,
                ),
                Text('Position Y: ${y.toStringAsFixed(0)}'),
                Slider(
                  min: 0,
                  max: 320,
                  value: y,
                  onChanged: (double v) => posY.value = v,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LinuxFeatureMatrix extends StatelessWidget {
  const _LinuxFeatureMatrix({required this.backend, required this.role});

  final ValueNotifier<_LinuxBackend> backend;
  final ValueNotifier<_LinuxWindowRole> role;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder2<_LinuxBackend, _LinuxWindowRole>(
          first: backend,
          second: role,
          builder: (BuildContext context, _LinuxBackend currentBackend,
              _LinuxWindowRole currentRole) {
            final List<_FeatureCell> rows = _featureRows(currentBackend, currentRole);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Protocol Feature Matrix',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                for (final _FeatureCell row in rows)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 180, child: Text(row.feature)),
                        Expanded(child: Text(row.support)),
                        Chip(label: Text(row.impact)),
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

List<_FeatureCell> _featureRows(
  _LinuxBackend backend,
  _LinuxWindowRole role,
) {
  if (backend == _LinuxBackend.wayland) {
    return <_FeatureCell>[
      const _FeatureCell('Global coordinates', 'Restricted by compositor', 'secure'),
      const _FeatureCell('Popup positioning', 'xdg_positioner + constraints', 'precise'),
      const _FeatureCell('Layer surfaces', 'wlroots layer-shell capable', 'dock/panel'),
      _FeatureCell('Role semantics', role.name, 'role-bound'),
      const _FeatureCell('Decorations', 'server-side or CSD negotiation', 'mixed'),
    ];
  }
  return <_FeatureCell>[
    const _FeatureCell('Global coordinates', 'Direct screen coordinates available', 'legacy'),
    const _FeatureCell('Popup positioning', '_NET_WM hints + WM policy', 'variable'),
    const _FeatureCell('Layer surfaces', 'No direct layer-shell equivalent', 'limited'),
    _FeatureCell('Role semantics', role.name, 'wm-hints'),
    const _FeatureCell('Decorations', 'WM driven or custom CSD frame', 'traditional'),
  ];
}

class _CompositorSimulation extends StatelessWidget {
  const _CompositorSimulation({
    required this.backend,
    required this.role,
    required this.clientSideDecorations,
    required this.fractionalScale,
    required this.width,
    required this.height,
    required this.posX,
    required this.posY,
  });

  final ValueNotifier<_LinuxBackend> backend;
  final ValueNotifier<_LinuxWindowRole> role;
  final ValueNotifier<bool> clientSideDecorations;
  final ValueNotifier<bool> fractionalScale;
  final ValueNotifier<double> width;
  final ValueNotifier<double> height;
  final ValueNotifier<double> posX;
  final ValueNotifier<double> posY;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder8<_LinuxBackend, _LinuxWindowRole, bool,
            bool, double, double, double, double>(
          first: backend,
          second: role,
          third: clientSideDecorations,
          fourth: fractionalScale,
          fifth: width,
          sixth: height,
          seventh: posX,
          eighth: posY,
          builder: (BuildContext context, _LinuxBackend backendValue,
              _LinuxWindowRole roleValue, bool csd, bool scaleEnabled,
              double w, double h, double x, double y) {
            final _LinuxPlacementResult result = _simulateLinuxPlacement(
              backend: backendValue,
              role: roleValue,
              clientDecorations: csd,
              fractionalScale: scaleEnabled,
              window: Rect.fromLTWH(x, y, w, h),
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Compositor Placement Simulation',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                AspectRatio(
                  aspectRatio: 960 / 540,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFD0DEE6)),
                    ),
                    child: CustomPaint(
                      painter: _LinuxCompositorPainter(
                        initialRect: Rect.fromLTWH(x, y, w, h),
                        adjustedRect: result.adjusted,
                        backend: backendValue,
                        role: roleValue,
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Resolution steps: ${result.steps.join(' -> ')}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(result.commentary),
              ],
            );
          },
        ),
      ),
    );
  }
}

_LinuxPlacementResult _simulateLinuxPlacement({
  required _LinuxBackend backend,
  required _LinuxWindowRole role,
  required bool clientDecorations,
  required bool fractionalScale,
  required Rect window,
}) {
  const Rect display = Rect.fromLTWH(0, 0, 960, 540);
  Rect adjusted = window;
  final List<String> steps = <String>['submit'];

  if (backend == _LinuxBackend.wayland && role == _LinuxWindowRole.popup) {
    adjusted = adjusted.shift(const Offset(0, 18));
    steps.add('xdg_positioner');
  }

  if (backend == _LinuxBackend.x11 && role == _LinuxWindowRole.utility) {
    adjusted = adjusted.shift(const Offset(8, 8));
    steps.add('wm_hints');
  }

  if (clientDecorations) {
    adjusted = Rect.fromLTWH(
      adjusted.left,
      adjusted.top,
      adjusted.width,
      adjusted.height + 34,
    );
    steps.add('csd_frame');
  }

  if (fractionalScale) {
    adjusted = Rect.fromLTWH(
      adjusted.left,
      adjusted.top,
      adjusted.width * 1.10,
      adjusted.height * 1.10,
    );
    steps.add('fractional_scale');
  }

  final double clampedLeft = adjusted.left.clamp(0, display.width - adjusted.width);
  final double clampedTop = adjusted.top.clamp(0, display.height - adjusted.height);
  adjusted = Rect.fromLTWH(clampedLeft, clampedTop, adjusted.width, adjusted.height);
  steps.add('compositor_clamp');

  return _LinuxPlacementResult(
    adjusted: adjusted,
    steps: steps,
    commentary:
        'Backend ${backend.name} with role ${role.name} produced ${adjusted.width.toStringAsFixed(0)}x${adjusted.height.toStringAsFixed(0)} '
        'at (${adjusted.left.toStringAsFixed(0)}, ${adjusted.top.toStringAsFixed(0)}).',
  );
}

class _ProtocolTimeline extends StatelessWidget {
  const _ProtocolTimeline({required this.backend});

  final ValueNotifier<_LinuxBackend> backend;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder<_LinuxBackend>(
          valueListenable: backend,
          builder: (BuildContext context, _LinuxBackend value, Widget? child) {
            final List<_TimelineStep> steps = value == _LinuxBackend.wayland
                ? const <_TimelineStep>[
                    _TimelineStep('Create surface', 'wl_compositor.create_surface'),
                    _TimelineStep('Assign role', 'xdg_toplevel or xdg_popup bind'),
                    _TimelineStep('Configure ack', 'client acknowledges configure serial'),
                    _TimelineStep('Commit buffer', 'wl_surface.commit for frame update'),
                  ]
                : const <_TimelineStep>[
                    _TimelineStep('Create X window', 'XCreateWindow + visual params'),
                    _TimelineStep('Set WM hints', '_NET_WM_WINDOW_TYPE and states'),
                    _TimelineStep('Map window', 'XMapWindow exposes to manager'),
                    _TimelineStep('Process ConfigureNotify', 'WM geometry responses'),
                  ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Protocol Timeline',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                for (int i = 0; i < steps.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: const Color(0xFF0D6471),
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
                              border: Border.all(color: const Color(0xFFD3DFE5)),
                              color: const Color(0xFFF8FBFD),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    steps[i].title,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(steps[i].detail),
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

class _LinuxRecipes extends StatelessWidget {
  const _LinuxRecipes({required this.backend});

  final ValueNotifier<_LinuxBackend> backend;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder<_LinuxBackend>(
          valueListenable: backend,
          builder: (BuildContext context, _LinuxBackend value, Widget? child) {
            final List<_RecipeSnippet> snippets = value == _LinuxBackend.wayland
                ? const <_RecipeSnippet>[
                    _RecipeSnippet(
                      title: 'Wayland popup constraints',
                      code:
                          'xdg_positioner\n  ..set_anchor(anchor)\n  ..set_constraint_adjustment(flags);',
                      note: 'Preferred for context menus and anchored tooltips.',
                    ),
                    _RecipeSnippet(
                      title: 'Layer-shell panel setup',
                      code:
                          'zwlr_layer_surface_v1\n  ..set_layer(top)\n  ..set_anchor(top | left | right);',
                      note: 'Useful for desktop bars and always-on-top overlays.',
                    ),
                  ]
                : const <_RecipeSnippet>[
                    _RecipeSnippet(
                      title: 'X11 utility window hint',
                      code:
                          'XChangeProperty(_NET_WM_WINDOW_TYPE, _NET_WM_WINDOW_TYPE_UTILITY);',
                      note: 'Suggests tool-window behavior to the WM.',
                    ),
                    _RecipeSnippet(
                      title: 'X11 state request',
                      code:
                          'sendClientMessage(_NET_WM_STATE, _NET_WM_STATE_MAXIMIZED_VERT);',
                      note: 'Desktop manager decides if request is accepted.',
                    ),
                  ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Linux Integration Recipes',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: snippets
                      .map(
                        (_RecipeSnippet recipe) => SizedBox(
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
                                    recipe.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
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
                                      recipe.code,
                                      style: const TextStyle(
                                        fontFamily: 'monospace',
                                        color: Color(0xFFD5F5FF),
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(recipe.note),
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

class _LinuxChecklist extends StatelessWidget {
  const _LinuxChecklist();

  @override
  Widget build(BuildContext context) {
    const List<String> checks = <String>[
      'Backend control panel switches between Wayland and X11 semantics.',
      'Role-aware matrix explains protocol behavior for each environment.',
      'Compositor canvas visualizes initial and adjusted Linux window placement.',
      'Timeline and recipe sections provide implementation guidance.',
      'Demo remains visual and interaction-focused for interpreter validation.',
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
            for (final String line in checks)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.check_circle, size: 16),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LinuxCompositorPainter extends CustomPainter {
  const _LinuxCompositorPainter({
    required this.initialRect,
    required this.adjustedRect,
    required this.backend,
    required this.role,
  });

  final Rect initialRect;
  final Rect adjustedRect;
  final _LinuxBackend backend;
  final _LinuxWindowRole role;

  @override
  void paint(Canvas canvas, Size size) {
    final double sx = size.width / 960;
    final double sy = size.height / 540;

    Rect map(Rect rect) => Rect.fromLTWH(
          rect.left * sx,
          rect.top * sy,
          rect.width * sx,
          rect.height * sy,
        );

    final Paint monitorA = Paint()
      ..color = const Color(0xFFECF3F8)
      ..style = PaintingStyle.fill;
    final Paint monitorB = Paint()
      ..color = const Color(0xFFEAF0F4)
      ..style = PaintingStyle.fill;

    final Rect leftMonitor = Rect.fromLTWH(0, 0, size.width * 0.54, size.height);
    final Rect rightMonitor = Rect.fromLTWH(
      size.width * 0.54,
      0,
      size.width * 0.46,
      size.height,
    );

    canvas.drawRect(leftMonitor, monitorA);
    canvas.drawRect(rightMonitor, monitorB);

    final Paint splitLine = Paint()
      ..color = const Color(0xFFD2DEE6)
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(size.width * 0.54, 0),
      Offset(size.width * 0.54, size.height),
      splitLine,
    );

    final Rect initial = map(initialRect);
    final Rect adjusted = map(adjustedRect);

    final Paint beforePaint = Paint()
      ..color = const Color(0xFFC66A51).withValues(alpha: 0.24)
      ..style = PaintingStyle.fill;
    final Paint beforeBorder = Paint()
      ..color = const Color(0xFFC66A51)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Paint afterPaint = Paint()
      ..color = const Color(0xFF1D8A6E).withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;
    final Paint afterBorder = Paint()
      ..color = const Color(0xFF1D8A6E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(initial, const Radius.circular(10)),
      beforePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(initial, const Radius.circular(10)),
      beforeBorder,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(adjusted, const Radius.circular(10)),
      afterPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(adjusted, const Radius.circular(10)),
      afterBorder,
    );

    final TextPainter label = TextPainter(
      text: TextSpan(
        text: '${backend.name.toUpperCase()} · ${role.name}',
        style: const TextStyle(
          color: Color(0xFF2E4A54),
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    label.paint(canvas, const Offset(10, 10));
  }

  @override
  bool shouldRepaint(covariant _LinuxCompositorPainter oldDelegate) {
    return oldDelegate.initialRect != initialRect ||
        oldDelegate.adjustedRect != adjustedRect ||
        oldDelegate.backend != backend ||
        oldDelegate.role != role;
  }
}

class _FeatureCell {
  const _FeatureCell(this.feature, this.support, this.impact);

  final String feature;
  final String support;
  final String impact;
}

class _TimelineStep {
  const _TimelineStep(this.title, this.detail);

  final String title;
  final String detail;
}

class _RecipeSnippet {
  const _RecipeSnippet({
    required this.title,
    required this.code,
    required this.note,
  });

  final String title;
  final String code;
  final String note;
}

class _LinuxPlacementResult {
  const _LinuxPlacementResult({
    required this.adjusted,
    required this.steps,
    required this.commentary,
  });

  final Rect adjusted;
  final List<String> steps;
  final String commentary;
}

class ValueListenableBuilder2<A, B> extends StatelessWidget {
  const ValueListenableBuilder2({
    super.key,
    required this.first,
    required this.second,
    required this.builder,
  });

  final ValueNotifier<A> first;
  final ValueNotifier<B> second;
  final Widget Function(BuildContext context, A a, B b) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (BuildContext context, A a, Widget? child) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (BuildContext context, B b, Widget? nested) {
            return builder(context, a, b);
          },
        );
      },
    );
  }
}

class ValueListenableBuilder8<A, B, C, D, E, F, G, H> extends StatelessWidget {
  const ValueListenableBuilder8({
    super.key,
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.fifth,
    required this.sixth,
    required this.seventh,
    required this.eighth,
    required this.builder,
  });

  final ValueNotifier<A> first;
  final ValueNotifier<B> second;
  final ValueNotifier<C> third;
  final ValueNotifier<D> fourth;
  final ValueNotifier<E> fifth;
  final ValueNotifier<F> sixth;
  final ValueNotifier<G> seventh;
  final ValueNotifier<H> eighth;
  final Widget Function(BuildContext context, A a, B b, C c, D d, E e, F f,
      G g, H h) builder;

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
                                return ValueListenableBuilder<H>(
                                  valueListenable: eighth,
                                  builder:
                                      (BuildContext context, H h, Widget? l3) {
                                    return builder(
                                      context,
                                      a,
                                      b,
                                      c,
                                      d,
                                      e,
                                      f,
                                      g,
                                      h,
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
          },
        );
      },
    );
  }
}

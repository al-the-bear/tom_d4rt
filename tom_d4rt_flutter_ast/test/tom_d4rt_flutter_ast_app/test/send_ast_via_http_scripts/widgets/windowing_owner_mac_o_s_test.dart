import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final ValueNotifier<_MacWindowStyle> style =
      ValueNotifier<_MacWindowStyle>(_MacWindowStyle.document);
  final ValueNotifier<bool> unifiedTitleToolbar = ValueNotifier<bool>(true);
  final ValueNotifier<bool> trafficLightsVisible = ValueNotifier<bool>(true);
  final ValueNotifier<bool> fullSizeContent = ValueNotifier<bool>(false);
  final ValueNotifier<bool> stageManagerGrouping = ValueNotifier<bool>(true);
  final ValueNotifier<double> titlebarHeight = ValueNotifier<double>(50);
  final ValueNotifier<double> contentWidth = ValueNotifier<double>(780);
  final ValueNotifier<double> contentHeight = ValueNotifier<double>(510);

  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6A4D1B)),
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
          colors: <Color>[Color(0xFFFFF5E8), Color(0xFFEFF5FA)],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        children: <Widget>[
          const _MacHero(),
          const SizedBox(height: 16),
          _MacControlDeck(
            style: style,
            unifiedTitleToolbar: unifiedTitleToolbar,
            trafficLightsVisible: trafficLightsVisible,
            fullSizeContent: fullSizeContent,
            stageManagerGrouping: stageManagerGrouping,
            titlebarHeight: titlebarHeight,
            contentWidth: contentWidth,
            contentHeight: contentHeight,
          ),
          const SizedBox(height: 16),
          _MacWindowPreview(
            style: style,
            unifiedTitleToolbar: unifiedTitleToolbar,
            trafficLightsVisible: trafficLightsVisible,
            fullSizeContent: fullSizeContent,
            titlebarHeight: titlebarHeight,
            contentWidth: contentWidth,
            contentHeight: contentHeight,
          ),
          const SizedBox(height: 16),
          _MacCapabilityBoard(style: style, stageManagerGrouping: stageManagerGrouping),
          const SizedBox(height: 16),
          _MacLifecycleFlow(style: style),
          const SizedBox(height: 16),
          _MacRecipePanel(style: style),
          const SizedBox(height: 16),
          const _MacChecklist(),
        ],
      ),
    ),
  );
}

enum _MacWindowStyle {
  document,
  utility,
  panel,
  inspector,
}

class _MacHero extends StatelessWidget {
  const _MacHero();

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
                  backgroundColor: Color(0xFF6A4D1B),
                  child: Icon(Icons.laptop_mac, color: Colors.white),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'WindowingOwnerMacOS Deep Demo',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'WindowingOwnerMacOS bridges Flutter window intentions to Cocoa '
              'NSWindow behavior. This demo models titlebar composition, style '
              'masks, Stage Manager interactions, and lifecycle events that '
              'commonly matter for desktop-grade macOS applications.',
            ),
          ],
        ),
      ),
    );
  }
}

class _MacControlDeck extends StatelessWidget {
  const _MacControlDeck({
    required this.style,
    required this.unifiedTitleToolbar,
    required this.trafficLightsVisible,
    required this.fullSizeContent,
    required this.stageManagerGrouping,
    required this.titlebarHeight,
    required this.contentWidth,
    required this.contentHeight,
  });

  final ValueNotifier<_MacWindowStyle> style;
  final ValueNotifier<bool> unifiedTitleToolbar;
  final ValueNotifier<bool> trafficLightsVisible;
  final ValueNotifier<bool> fullSizeContent;
  final ValueNotifier<bool> stageManagerGrouping;
  final ValueNotifier<double> titlebarHeight;
  final ValueNotifier<double> contentWidth;
  final ValueNotifier<double> contentHeight;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder8<_MacWindowStyle, bool, bool, bool, bool,
            double, double, double>(
          first: style,
          second: unifiedTitleToolbar,
          third: trafficLightsVisible,
          fourth: fullSizeContent,
          fifth: stageManagerGrouping,
          sixth: titlebarHeight,
          seventh: contentWidth,
          eighth: contentHeight,
          builder: (BuildContext context, _MacWindowStyle currentStyle,
              bool unified, bool traffic, bool fullSize, bool stageGroup,
              double titleHeight, double width, double height) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'macOS Window Controls',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final _MacWindowStyle value in _MacWindowStyle.values)
                      ChoiceChip(
                        selected: value == currentStyle,
                        label: Text(value.name),
                        onSelected: (_) => style.value = value,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Unified titlebar + toolbar'),
                  value: unified,
                  onChanged: (bool v) => unifiedTitleToolbar.value = v,
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Traffic lights visible'),
                  value: traffic,
                  onChanged: (bool v) => trafficLightsVisible.value = v,
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Full-size content view'),
                  value: fullSize,
                  onChanged: (bool v) => fullSizeContent.value = v,
                ),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Stage Manager grouping active'),
                  value: stageGroup,
                  onChanged: (bool v) => stageManagerGrouping.value = v,
                ),
                const SizedBox(height: 6),
                Text('Titlebar height: ${titleHeight.toStringAsFixed(0)}'),
                Slider(
                  min: 30,
                  max: 92,
                  value: titleHeight,
                  onChanged: (double v) => titlebarHeight.value = v,
                ),
                Text('Content width: ${width.toStringAsFixed(0)}'),
                Slider(
                  min: 420,
                  max: 1120,
                  value: width,
                  onChanged: (double v) => contentWidth.value = v,
                ),
                Text('Content height: ${height.toStringAsFixed(0)}'),
                Slider(
                  min: 280,
                  max: 760,
                  value: height,
                  onChanged: (double v) => contentHeight.value = v,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MacWindowPreview extends StatelessWidget {
  const _MacWindowPreview({
    required this.style,
    required this.unifiedTitleToolbar,
    required this.trafficLightsVisible,
    required this.fullSizeContent,
    required this.titlebarHeight,
    required this.contentWidth,
    required this.contentHeight,
  });

  final ValueNotifier<_MacWindowStyle> style;
  final ValueNotifier<bool> unifiedTitleToolbar;
  final ValueNotifier<bool> trafficLightsVisible;
  final ValueNotifier<bool> fullSizeContent;
  final ValueNotifier<double> titlebarHeight;
  final ValueNotifier<double> contentWidth;
  final ValueNotifier<double> contentHeight;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder7<_MacWindowStyle, bool, bool, bool,
            double, double, double>(
          first: style,
          second: unifiedTitleToolbar,
          third: trafficLightsVisible,
          fourth: fullSizeContent,
          fifth: titlebarHeight,
          sixth: contentWidth,
          seventh: contentHeight,
          builder: (BuildContext context, _MacWindowStyle currentStyle,
              bool unified, bool traffic, bool fullSize, double titleHeight,
              double width, double height) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Cocoa Window Preview',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                AspectRatio(
                  aspectRatio: 1.75,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFD0DEE6)),
                      color: const Color(0xFFF8FBFD),
                    ),
                    child: CustomPaint(
                      painter: _MacWindowPainter(
                        style: currentStyle,
                        unifiedTitleToolbar: unified,
                        trafficLightsVisible: traffic,
                        fullSizeContent: fullSize,
                        titlebarHeight: titleHeight,
                        contentWidth: width,
                        contentHeight: height,
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Style ${currentStyle.name} with ${unified ? 'unified' : 'separate'} title/toolbar '
                  'and ${fullSize ? 'full-size' : 'bounded'} content behavior.',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MacCapabilityBoard extends StatelessWidget {
  const _MacCapabilityBoard({required this.style, required this.stageManagerGrouping});

  final ValueNotifier<_MacWindowStyle> style;
  final ValueNotifier<bool> stageManagerGrouping;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder2<_MacWindowStyle, bool>(
          first: style,
          second: stageManagerGrouping,
          builder: (BuildContext context, _MacWindowStyle currentStyle,
              bool stageEnabled) {
            final List<_MacCapability> capabilities = _capabilityRows(
              currentStyle,
              stageEnabled,
            );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'macOS Capability Matrix',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                for (final _MacCapability capability in capabilities)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 170, child: Text(capability.feature)),
                        Expanded(child: Text(capability.behavior)),
                        Chip(label: Text(capability.status)),
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

List<_MacCapability> _capabilityRows(
  _MacWindowStyle style,
  bool stageEnabled,
) {
  return <_MacCapability>[
    _MacCapability('Style mask', 'NSWindow style: ${style.name}', 'dynamic'),
    const _MacCapability('Spaces support', 'Move and pin across desktop spaces', 'native'),
    _MacCapability(
      'Stage Manager grouping',
      stageEnabled ? 'Grouped with active app cluster' : 'Independent window stack',
      stageEnabled ? 'enabled' : 'disabled',
    ),
    const _MacCapability('Window tabbing', 'Supported for document-style windows', 'contextual'),
    const _MacCapability('Toolbar behavior', 'NSToolbar integrated with titlebar', 'customizable'),
  ];
}

class _MacLifecycleFlow extends StatelessWidget {
  const _MacLifecycleFlow({required this.style});

  final ValueNotifier<_MacWindowStyle> style;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder<_MacWindowStyle>(
          valueListenable: style,
          builder: (BuildContext context, _MacWindowStyle value, Widget? child) {
            final List<_FlowItem> items = <_FlowItem>[
              const _FlowItem('init', 'Bridge allocates NSWindow and view host.'),
              _FlowItem('style', 'Apply ${value.name} style mask and title policy.'),
              const _FlowItem('activate', 'Become key window and register focus callbacks.'),
              const _FlowItem('space move', 'Respond to display/space transitions.'),
              const _FlowItem('teardown', 'Release delegates and close surface cleanly.'),
            ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Lifecycle Flow',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                for (int i = 0; i < items.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: const Color(0xFF6A4D1B),
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
                              border: Border.all(color: const Color(0xFFD4DEE4)),
                              color: const Color(0xFFF8FBFD),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    items[i].phase,
                                    style:
                                        const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(items[i].detail),
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

class _MacRecipePanel extends StatelessWidget {
  const _MacRecipePanel({required this.style});

  final ValueNotifier<_MacWindowStyle> style;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder<_MacWindowStyle>(
          valueListenable: style,
          builder: (BuildContext context, _MacWindowStyle value, Widget? child) {
            final List<_Recipe> recipes = <_Recipe>[
              _Recipe(
                title: 'Window style mapping',
                code:
                    'switch(style) {\n  case document: styleMask = titled | resizable;\n  case utility: styleMask = utilityWindow;\n}',
                note: 'Keep style mask mapping explicit for predictable behavior.',
              ),
              _Recipe(
                title: 'Traffic light policy',
                code:
                    'window.standardWindowButton(.closeButton)?.isHidden = !showTrafficLights',
                note: 'Inspector-style windows may hide controls intentionally.',
              ),
              _Recipe(
                title: 'Current style hint',
                code: 'activeStyle = ${value.name}',
                note: 'Use style-specific affordances in command and menu design.',
              ),
            ];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Cocoa Integration Recipes',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: recipes
                      .map(
                        (_Recipe recipe) => SizedBox(
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

class _MacChecklist extends StatelessWidget {
  const _MacChecklist();

  @override
  Widget build(BuildContext context) {
    const List<String> checks = <String>[
      'Control deck covers style masks, titlebar, traffic lights, and stage grouping.',
      'Window preview visualizes Cocoa-oriented composition changes live.',
      'Capability board and lifecycle flow explain behavior beyond visuals.',
      'Recipes map conceptual settings to practical platform code snippets.',
      'Demo is fully visual and instruction-focused for interpreter integration.',
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

class _MacWindowPainter extends CustomPainter {
  const _MacWindowPainter({
    required this.style,
    required this.unifiedTitleToolbar,
    required this.trafficLightsVisible,
    required this.fullSizeContent,
    required this.titlebarHeight,
    required this.contentWidth,
    required this.contentHeight,
  });

  final _MacWindowStyle style;
  final bool unifiedTitleToolbar;
  final bool trafficLightsVisible;
  final bool fullSizeContent;
  final double titlebarHeight;
  final double contentWidth;
  final double contentHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / 1120;
    final double scaleY = size.height / 760;
    final Rect contentRect = Rect.fromLTWH(
      80 * scaleX,
      70 * scaleY,
      contentWidth * scaleX,
      contentHeight * scaleY,
    );

    final Rect titleRect = Rect.fromLTWH(
      contentRect.left,
      contentRect.top,
      contentRect.width,
      titlebarHeight * scaleY,
    );

    final Paint shell = Paint()
      ..color = const Color(0xFFFDFEFE)
      ..style = PaintingStyle.fill;
    final Paint shellBorder = Paint()
      ..color = const Color(0xFFBFCFD8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(contentRect, const Radius.circular(12)),
      shell,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(contentRect, const Radius.circular(12)),
      shellBorder,
    );

    final Color titleColor = unifiedTitleToolbar
        ? const Color(0xFFE7EEF4)
        : const Color(0xFFF0F4F8);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        titleRect,
        topLeft: const Radius.circular(12),
        topRight: const Radius.circular(12),
      ),
      Paint()..color = titleColor,
    );

    if (trafficLightsVisible) {
      final double y = titleRect.center.dy;
      canvas.drawCircle(
        Offset(titleRect.left + 18, y),
        5,
        Paint()..color = const Color(0xFFFF5F57),
      );
      canvas.drawCircle(
        Offset(titleRect.left + 34, y),
        5,
        Paint()..color = const Color(0xFFFEBB2E),
      );
      canvas.drawCircle(
        Offset(titleRect.left + 50, y),
        5,
        Paint()..color = const Color(0xFF28C840),
      );
    }

    final Rect bodyRect = Rect.fromLTWH(
      contentRect.left,
      fullSizeContent ? contentRect.top : titleRect.bottom,
      contentRect.width,
      fullSizeContent
          ? contentRect.height
          : contentRect.height - titleRect.height,
    );
    canvas.drawRect(
      bodyRect,
      Paint()..color = const Color(0xFFF8FBFD),
    );

    final TextPainter styleLabel = TextPainter(
      text: TextSpan(
        text: 'style: ${style.name}',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Color(0xFF3D4F56),
          fontSize: 13,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    styleLabel.paint(canvas, Offset(titleRect.left + 80, titleRect.top + 12));
  }

  @override
  bool shouldRepaint(covariant _MacWindowPainter oldDelegate) {
    return oldDelegate.style != style ||
        oldDelegate.unifiedTitleToolbar != unifiedTitleToolbar ||
        oldDelegate.trafficLightsVisible != trafficLightsVisible ||
        oldDelegate.fullSizeContent != fullSizeContent ||
        oldDelegate.titlebarHeight != titlebarHeight ||
        oldDelegate.contentWidth != contentWidth ||
        oldDelegate.contentHeight != contentHeight;
  }
}

class _MacCapability {
  const _MacCapability(this.feature, this.behavior, this.status);

  final String feature;
  final String behavior;
  final String status;
}

class _FlowItem {
  const _FlowItem(this.phase, this.detail);

  final String phase;
  final String detail;
}

class _Recipe {
  const _Recipe({
    required this.title,
    required this.code,
    required this.note,
  });

  final String title;
  final String code;
  final String note;
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

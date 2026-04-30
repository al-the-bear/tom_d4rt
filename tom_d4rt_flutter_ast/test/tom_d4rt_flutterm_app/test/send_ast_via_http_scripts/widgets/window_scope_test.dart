import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final ValueNotifier<Rect> bounds = ValueNotifier<Rect>(
    const Rect.fromLTWH(40, 50, 920, 610),
  );
  final ValueNotifier<bool> active = ValueNotifier<bool>(true);
  final ValueNotifier<double> scale = ValueNotifier<double>(1.00);
  final ValueNotifier<_WindowMode> mode =
      ValueNotifier<_WindowMode>(_WindowMode.document);
  final ValueNotifier<String> scopeId = ValueNotifier<String>('main-workspace');

  return Theme(
    data: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF356D2D)),
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
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[Color(0xFFEDF8EC), Color(0xFFF1F7FB)],
        ),
      ),
      child: ValueListenableBuilder5<Rect, bool, double, _WindowMode, String>(
        first: bounds,
        second: active,
        third: scale,
        fourth: mode,
        fifth: scopeId,
        builder: (BuildContext context, Rect b, bool isActive,
            double deviceScale, _WindowMode windowMode, String id) {
          return _DemoWindowScope(
            scopeId: id,
            bounds: b,
            isActive: isActive,
            scale: deviceScale,
            mode: windowMode,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
              children: <Widget>[
                const _WindowScopeHero(),
                const SizedBox(height: 16),
                _ScopeControlCenter(
                  bounds: bounds,
                  active: active,
                  scale: scale,
                  mode: mode,
                  scopeId: scopeId,
                ),
                const SizedBox(height: 16),
                const _ScopeSnapshotPanel(),
                const SizedBox(height: 16),
                const _AspectRebuildBoard(),
                const SizedBox(height: 16),
                const _NestedScopeShowcase(),
                const SizedBox(height: 16),
                const _ScopeUsageRecipes(),
                const SizedBox(height: 16),
                const _ScopeValidationChecklist(),
              ],
            ),
          );
        },
      ),
    ),
  );
}

enum _WindowMode {
  document,
  utility,
  modal,
  panel,
}

enum _ScopeAspect {
  id,
  bounds,
  active,
  scale,
  mode,
}

class _WindowScopeHero extends StatelessWidget {
  const _WindowScopeHero();

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
                  backgroundColor: Color(0xFF356D2D),
                  child: Icon(Icons.account_tree, color: Colors.white),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'WindowScope Deep Demo',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'WindowScope is an internal InheritedModel concept that propagates '
              'window-specific context through subtrees. This demo uses a modeled '
              'scope implementation to show aspect-based dependency updates, nested '
              'scope hierarchies, and multi-window state propagation.',
            ),
          ],
        ),
      ),
    );
  }
}

class _ScopeControlCenter extends StatelessWidget {
  const _ScopeControlCenter({
    required this.bounds,
    required this.active,
    required this.scale,
    required this.mode,
    required this.scopeId,
  });

  final ValueNotifier<Rect> bounds;
  final ValueNotifier<bool> active;
  final ValueNotifier<double> scale;
  final ValueNotifier<_WindowMode> mode;
  final ValueNotifier<String> scopeId;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ValueListenableBuilder5<Rect, bool, double, _WindowMode, String>(
          first: bounds,
          second: active,
          third: scale,
          fourth: mode,
          fifth: scopeId,
          builder: (BuildContext context, Rect rect, bool isActive,
              double dpiScale, _WindowMode windowMode, String id) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Scope Control Center',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const <String>[
                    'main-workspace',
                    'detached-toolbox',
                    'presentation-window',
                    'preview-pane',
                  ]
                      .map(
                        (String value) => ChoiceChip(
                          label: Text(value),
                          selected: false,
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: id,
                  decoration: const InputDecoration(
                    labelText: 'Scope ID',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  items: const <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      value: 'main-workspace',
                      child: Text('main-workspace'),
                    ),
                    DropdownMenuItem(
                      value: 'detached-toolbox',
                      child: Text('detached-toolbox'),
                    ),
                    DropdownMenuItem(
                      value: 'presentation-window',
                      child: Text('presentation-window'),
                    ),
                    DropdownMenuItem(
                      value: 'preview-pane',
                      child: Text('preview-pane'),
                    ),
                  ],
                  onChanged: (String? next) {
                    if (next != null) {
                      scopeId.value = next;
                    }
                  },
                ),
                const SizedBox(height: 10),
                Text('Width: ${rect.width.toStringAsFixed(0)}'),
                Slider(
                  min: 360,
                  max: 1280,
                  value: rect.width,
                  onChanged: (double width) {
                    bounds.value = Rect.fromLTWH(
                      rect.left,
                      rect.top,
                      width,
                      rect.height,
                    );
                  },
                ),
                Text('Height: ${rect.height.toStringAsFixed(0)}'),
                Slider(
                  min: 280,
                  max: 840,
                  value: rect.height,
                  onChanged: (double height) {
                    bounds.value = Rect.fromLTWH(
                      rect.left,
                      rect.top,
                      rect.width,
                      height,
                    );
                  },
                ),
                Text('Device scale: ${dpiScale.toStringAsFixed(2)}'),
                Slider(
                  min: 1.0,
                  max: 2.5,
                  divisions: 30,
                  value: dpiScale,
                  onChanged: (double value) => scale.value = value,
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final _WindowMode value in _WindowMode.values)
                      ChoiceChip(
                        selected: value == windowMode,
                        label: Text(value.name),
                        onSelected: (_) => mode.value = value,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Window is active'),
                  value: isActive,
                  onChanged: (bool value) => active.value = value,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ScopeSnapshotPanel extends StatelessWidget {
  const _ScopeSnapshotPanel();

  @override
  Widget build(BuildContext context) {
    final _DemoWindowScope scope = _DemoWindowScope.of(context);
    final List<_SnapshotRow> rows = <_SnapshotRow>[
      _SnapshotRow('scopeId', scope.scopeId),
      _SnapshotRow(
        'bounds',
        '[${scope.bounds.left.toStringAsFixed(0)}, ${scope.bounds.top.toStringAsFixed(0)}] '
            '${scope.bounds.width.toStringAsFixed(0)}x${scope.bounds.height.toStringAsFixed(0)}',
      ),
      _SnapshotRow('isActive', scope.isActive.toString()),
      _SnapshotRow('scale', scope.scale.toStringAsFixed(2)),
      _SnapshotRow('mode', scope.mode.name),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Live Scope Snapshot',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            const SizedBox(height: 10),
            for (final _SnapshotRow row in rows)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 100, child: Text(row.label)),
                    Expanded(
                      child: Text(
                        row.value,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            const Text(
              'Consumers below subscribe to one aspect each. Modify controls and '
              'watch rebuild counters update only for affected aspects.',
            ),
          ],
        ),
      ),
    );
  }
}

class _AspectRebuildBoard extends StatelessWidget {
  const _AspectRebuildBoard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Aspect-Specific Rebuild Board',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                _AspectProbeCard(aspect: _ScopeAspect.id),
                _AspectProbeCard(aspect: _ScopeAspect.bounds),
                _AspectProbeCard(aspect: _ScopeAspect.active),
                _AspectProbeCard(aspect: _ScopeAspect.scale),
                _AspectProbeCard(aspect: _ScopeAspect.mode),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AspectProbeCard extends StatefulWidget {
  const _AspectProbeCard({required this.aspect});

  final _ScopeAspect aspect;

  @override
  State<_AspectProbeCard> createState() => _AspectProbeCardState();
}

class _AspectProbeCardState extends State<_AspectProbeCard> {
  int rebuilds = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    rebuilds += 1;
  }

  @override
  Widget build(BuildContext context) {
    final _DemoWindowScope scope =
        _DemoWindowScope.of(context, aspect: widget.aspect);

    String value;
    Color accent;
    IconData icon;

    switch (widget.aspect) {
      case _ScopeAspect.id:
        value = scope.scopeId;
        accent = const Color(0xFF1A6A5C);
        icon = Icons.badge;
      case _ScopeAspect.bounds:
        value = '${scope.bounds.width.toStringAsFixed(0)}x${scope.bounds.height.toStringAsFixed(0)}';
        accent = const Color(0xFF3969B5);
        icon = Icons.straighten;
      case _ScopeAspect.active:
        value = scope.isActive ? 'active' : 'inactive';
        accent = const Color(0xFF7A5B00);
        icon = Icons.bolt;
      case _ScopeAspect.scale:
        value = '${scope.scale.toStringAsFixed(2)}x';
        accent = const Color(0xFF7A275A);
        icon = Icons.zoom_in_map;
      case _ScopeAspect.mode:
        value = scope.mode.name;
        accent = const Color(0xFF595959);
        icon = Icons.view_compact_alt;
    }

    return SizedBox(
      width: 250,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: accent.withValues(alpha: 0.5)),
          color: accent.withValues(alpha: 0.10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon, color: accent),
                  const SizedBox(width: 8),
                  Text(
                    widget.aspect.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text('rebuild count: $rebuilds'),
            ],
          ),
        ),
      ),
    );
  }
}

class _NestedScopeShowcase extends StatelessWidget {
  const _NestedScopeShowcase();

  @override
  Widget build(BuildContext context) {
    final _DemoWindowScope root = _DemoWindowScope.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Nested Scope Hierarchy Showcase',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            const SizedBox(height: 10),
            const Text(
              'The inner scope below simulates a floating utility window that '
              'inherits from the root workspace but overrides mode and activity.',
            ),
            const SizedBox(height: 10),
            _DemoWindowScope(
              scopeId: '${root.scopeId}/utility-toolbox',
              bounds: Rect.fromLTWH(
                root.bounds.left + 80,
                root.bounds.top + 80,
                root.bounds.width * 0.52,
                root.bounds.height * 0.45,
              ),
              isActive: false,
              scale: root.scale,
              mode: _WindowMode.utility,
              child: const _NestedScopePanel(),
            ),
          ],
        ),
      ),
    );
  }
}

class _NestedScopePanel extends StatelessWidget {
  const _NestedScopePanel();

  @override
  Widget build(BuildContext context) {
    final _DemoWindowScope nested = _DemoWindowScope.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD2DEE6)),
        color: const Color(0xFFF8FBFD),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.call_split, color: Color(0xFF4D5E66)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    nested.scopeId,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Chip(label: Text(nested.mode.name)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Nested bounds: ${nested.bounds.width.toStringAsFixed(0)}x'
              '${nested.bounds.height.toStringAsFixed(0)} | '
              'scale: ${nested.scale.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 8),
            const Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                _NestedBadge(label: 'Panel widgets subscribe to mode + bounds'),
                _NestedBadge(label: 'Root scope still available above this node'),
                _NestedBadge(label: 'InheritedModel can partition dependencies'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NestedBadge extends StatelessWidget {
  const _NestedBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCDDCE3)),
        color: const Color(0xFFF1F7FA),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(label),
      ),
    );
  }
}

class _ScopeUsageRecipes extends StatelessWidget {
  const _ScopeUsageRecipes();

  @override
  Widget build(BuildContext context) {
    const List<_RecipeCard> recipes = <_RecipeCard>[
      _RecipeCard(
        title: 'Aspect-specific dependency',
        code:
            'final scope = DemoWindowScope.of(context, aspect: ScopeAspect.bounds);\nfinal width = scope.bounds.width;',
        note: 'Only bounds updates trigger rebuild for this consumer.',
      ),
      _RecipeCard(
        title: 'Root-only lookup',
        code:
            'final root = DemoWindowScope.of(context);\nif (root.isActive) { /* focus affordance */ }',
        note: 'Use full lookup when the widget depends on many properties.',
      ),
      _RecipeCard(
        title: 'Nested scope override',
        code:
            'DemoWindowScope(\n  scopeId: "toolbox",\n  mode: WindowMode.utility,\n  child: ToolboxView(),\n)',
        note: 'Establish local context without mutating root window state.',
      ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Usage Recipes',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: recipes
                  .map(
                    (_RecipeCard recipe) => SizedBox(
                      width: 300,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFD5E0E6)),
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
                                  color: const Color(0xFF13242B),
                                  borderRadius: BorderRadius.circular(8),
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
        ),
      ),
    );
  }
}

class _ScopeValidationChecklist extends StatelessWidget {
  const _ScopeValidationChecklist();

  @override
  Widget build(BuildContext context) {
    const List<String> checks = <String>[
      'Control center updates id, bounds, active, scale, and mode values live.',
      'Aspect probes subscribe independently and expose rebuild counters.',
      'Nested scope showcase demonstrates local override semantics clearly.',
      'Recipe cards explain practical consumer and producer patterns.',
      'All visuals are widget-based and focused on interpreter interaction behavior.',
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

class _DemoWindowScope extends InheritedModel<_ScopeAspect> {
  const _DemoWindowScope({
    required this.scopeId,
    required this.bounds,
    required this.isActive,
    required this.scale,
    required this.mode,
    required super.child,
  });

  final String scopeId;
  final Rect bounds;
  final bool isActive;
  final double scale;
  final _WindowMode mode;

  static _DemoWindowScope of(
    BuildContext context, {
    _ScopeAspect? aspect,
  }) {
    final _DemoWindowScope? scope = InheritedModel.inheritFrom<_DemoWindowScope>(
      context,
      aspect: aspect,
    );
    assert(scope != null, 'No _DemoWindowScope found in context');
    return scope!;
  }

  @override
  bool updateShouldNotify(_DemoWindowScope oldWidget) {
    return scopeId != oldWidget.scopeId ||
        bounds != oldWidget.bounds ||
        isActive != oldWidget.isActive ||
        scale != oldWidget.scale ||
        mode != oldWidget.mode;
  }

  @override
  bool updateShouldNotifyDependent(
    _DemoWindowScope oldWidget,
    Set<_ScopeAspect> dependencies,
  ) {
    if (dependencies.contains(_ScopeAspect.id) && scopeId != oldWidget.scopeId) {
      return true;
    }
    if (dependencies.contains(_ScopeAspect.bounds) && bounds != oldWidget.bounds) {
      return true;
    }
    if (dependencies.contains(_ScopeAspect.active) &&
        isActive != oldWidget.isActive) {
      return true;
    }
    if (dependencies.contains(_ScopeAspect.scale) && scale != oldWidget.scale) {
      return true;
    }
    if (dependencies.contains(_ScopeAspect.mode) && mode != oldWidget.mode) {
      return true;
    }
    return false;
  }
}

class _SnapshotRow {
  const _SnapshotRow(this.label, this.value);

  final String label;
  final String value;
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

class ValueListenableBuilder5<A, B, C, D, E> extends StatelessWidget {
  const ValueListenableBuilder5({
    super.key,
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.fifth,
    required this.builder,
  });

  final ValueNotifier<A> first;
  final ValueNotifier<B> second;
  final ValueNotifier<C> third;
  final ValueNotifier<D> fourth;
  final ValueNotifier<E> fifth;
  final Widget Function(BuildContext context, A a, B b, C c, D d, E e) builder;

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
                        return builder(context, a, b, c, d, e);
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

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const _bg = Color(0xFFF3F7FA);
const _ink = Color(0xFF173247);
const _blue = Color(0xFF2A628D);
const _green = Color(0xFF2B7F66);
const _amber = Color(0xFFB1843F);
const _rose = Color(0xFFA25C6D);
const _violet = Color(0xFF665CB0);

dynamic build(BuildContext context) {
  return const _LookupBoundaryDeepDemoApp();
}

class _LookupBoundaryDeepDemoApp extends StatelessWidget {
  const _LookupBoundaryDeepDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _blue),
        scaffoldBackgroundColor: _bg,
      ),
      home: const _LookupBoundaryDeepDemoPage(),
    );
  }
}

class _LookupBoundaryDeepDemoPage extends StatefulWidget {
  const _LookupBoundaryDeepDemoPage();

  @override
  State<_LookupBoundaryDeepDemoPage> createState() => _LookupBoundaryDeepDemoPageState();
}

class _LookupBoundaryDeepDemoPageState extends State<_LookupBoundaryDeepDemoPage> {
  bool _compact = false;
  bool _showGuide = true;
  bool _showNotes = true;
  bool _rtl = false;
  double _globalScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: _rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          toolbarHeight: 92,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('LookupBoundary Deep Demo'),
              Text(
                'ancestor visibility control | scope isolation | state/render traversal boundaries',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ControlDeck(
                compact: _compact,
                showGuide: _showGuide,
                showNotes: _showNotes,
                rtl: _rtl,
                globalScale: _globalScale,
                onCompactChanged: (v) => setState(() => _compact = v),
                onGuideChanged: (v) => setState(() => _showGuide = v),
                onNotesChanged: (v) => setState(() => _showNotes = v),
                onRtlChanged: (v) => setState(() => _rtl = v),
                onScaleChanged: (v) => setState(() => _globalScale = v),
              ),
              const SizedBox(height: 12),
              _SceneBox(
                index: 1,
                tone: _blue,
                title: 'Boundary Visibility Lab',
                subtitle:
                    'Use LookupBoundary.findAncestorWidgetOfExactType and debug hiding checks to inspect ancestor widget visibility rules.',
                child: _BoundaryVisibilityScene(compact: _compact, showGuide: _showGuide, showNotes: _showNotes, globalScale: _globalScale),
              ),
              const SizedBox(height: 12),
              _SceneBox(
                index: 2,
                tone: _green,
                title: 'Inherited Scope Lab',
                subtitle:
                    'Compare dependOnInheritedWidgetOfExactType, getInheritedWidgetOfExactType, and getElementForInheritedWidgetOfExactType across boundaries.',
                child: _InheritedScopeScene(compact: _compact, showGuide: _showGuide, showNotes: _showNotes),
              ),
              const SizedBox(height: 12),
              _SceneBox(
                index: 3,
                tone: _amber,
                title: 'State Lookup Lab',
                subtitle:
                    'Explore findAncestorStateOfType and findRootAncestorStateOfType when nested state owners are separated by LookupBoundary.',
                child: _StateLookupScene(compact: _compact, showGuide: _showGuide, showNotes: _showNotes),
              ),
              const SizedBox(height: 12),
              _SceneBox(
                index: 4,
                tone: _rose,
                title: 'Traversal and Render Lab',
                subtitle:
                    'Inspect findAncestorRenderObjectOfType plus ancestor/child element traversal APIs with boundary-aware logs.',
                child: _TraversalRenderScene(compact: _compact, showGuide: _showGuide, showNotes: _showNotes),
              ),
              const SizedBox(height: 12),
              _SceneBox(
                index: 5,
                tone: _violet,
                title: 'Practical Sandbox Console',
                subtitle:
                    'Apply LookupBoundary for feature-module isolation so independent zones do not accidentally couple to outer ancestors.',
                child: _PracticalSandboxScene(compact: _compact, showGuide: _showGuide, showNotes: _showNotes),
              ),
              const SizedBox(height: 12),
              const _RecapPanel(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _ControlDeck extends StatelessWidget {
  const _ControlDeck({
    required this.compact,
    required this.showGuide,
    required this.showNotes,
    required this.rtl,
    required this.globalScale,
    required this.onCompactChanged,
    required this.onGuideChanged,
    required this.onNotesChanged,
    required this.onRtlChanged,
    required this.onScaleChanged,
  });

  final bool compact;
  final bool showGuide;
  final bool showNotes;
  final bool rtl;
  final double globalScale;
  final ValueChanged<bool> onCompactChanged;
  final ValueChanged<bool> onGuideChanged;
  final ValueChanged<bool> onNotesChanged;
  final ValueChanged<bool> onRtlChanged;
  final ValueChanged<double> onScaleChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF183B53), Color(0xFF2B607E), Color(0xFF3A7E6D), Color(0xFF645FB1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LookupBoundary Strategy Deck',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
          ),
          const SizedBox(height: 6),
          const Text(
            'LookupBoundary defines an ancestor lookup boundary. '
            'Use it when local feature trees should not depend on widgets, states, inherited values, '
            'or render objects beyond a specific composition edge.',
            style: TextStyle(color: Color(0xFFDBEAF7), height: 1.35),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SwitchListTile(
                  value: compact,
                  onChanged: onCompactChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Compact scenes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: showGuide,
                  onChanged: onGuideChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Guide overlays', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: showNotes,
                  onChanged: onNotesChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Instruction notes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: SwitchListTile(
                  value: rtl,
                  onChanged: onRtlChanged,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('RTL mode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
          Text(
            'Global scene scale: ${globalScale.toStringAsFixed(2)}',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Slider(
            value: globalScale,
            min: 0.8,
            max: 1.35,
            divisions: 11,
            onChanged: onScaleChanged,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}

class _SceneBox extends StatelessWidget {
  const _SceneBox({
    required this.index,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final int index;
  final Color tone;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 15, offset: const Offset(0, 7)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: tone,
                  foregroundColor: Colors.white,
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: tone, fontSize: 19, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF3A5063), height: 1.34)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _BoundaryVisibilityScene extends StatefulWidget {
  const _BoundaryVisibilityScene({required this.compact, required this.showGuide, required this.showNotes, required this.globalScale});

  final bool compact;
  final bool showGuide;
  final bool showNotes;
  final double globalScale;

  @override
  State<_BoundaryVisibilityScene> createState() => _BoundaryVisibilitySceneState();
}

class _BoundaryVisibilitySceneState extends State<_BoundaryVisibilityScene> {
  bool _insertBoundary = true;
  bool _insertSecondBoundary = false;
  bool _paintCenterOverlay = true;
  int _revision = 1;

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 860.0 : 1020.0;

    final tree = _AncestorBadge(
      name: 'Root Workspace Badge',
      revision: _revision,
      color: _blue,
      child: _AncestorBadge(
        name: 'Feature Host Badge',
        revision: _revision + 1,
        color: _amber,
        child: Builder(
          builder: (context) {
            Widget child = _BoundaryProbe(
              tone: _blue,
              showCenterOverlay: _paintCenterOverlay,
              label: 'Probe Node',
            );
            if (_insertSecondBoundary) {
              child = LookupBoundary(child: child);
            }
            if (_insertBoundary) {
              child = LookupBoundary(child: child);
            }
            return child;
          },
        ),
      ),
    );

    return SizedBox(
      height: sceneHeight,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Boundary controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _insertBoundary,
                        onChanged: (v) => setState(() => _insertBoundary = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Insert primary LookupBoundary'),
                      ),
                      SwitchListTile(
                        value: _insertSecondBoundary,
                        onChanged: (v) => setState(() => _insertSecondBoundary = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Insert second nested boundary'),
                      ),
                      SwitchListTile(
                        value: _paintCenterOverlay,
                        onChanged: (v) => setState(() => _paintCenterOverlay = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Show center probe overlay'),
                      ),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () => setState(() => _revision += 1),
                        child: Text('Increment host revision ($_revision)'),
                      ),
                      const SizedBox(height: 8),
                      _DataGrid(
                        rows: [
                          _DataRowItem('primary boundary', _insertBoundary ? 'enabled' : 'disabled'),
                          _DataRowItem('second boundary', _insertSecondBoundary ? 'enabled' : 'disabled'),
                          _DataRowItem('host revision', '$_revision'),
                          _DataRowItem('overlay', _paintCenterOverlay ? 'visible' : 'hidden'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.showNotes)
                        _InstructionList(
                          tone: _blue,
                          lines: const [
                            'LookupBoundary affects lookup APIs on LookupBoundary itself, not every BuildContext helper call.',
                            'findAncestorWidgetOfExactType via LookupBoundary respects the nearest boundary and stops there.',
                            'debugIsHidingAncestorWidgetOfExactType can reveal whether a boundary is hiding a matching ancestor.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Transform.scale(
                  scale: widget.globalScale,
                  alignment: Alignment.topCenter,
                  child: tree,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BoundaryProbe extends StatefulWidget {
  const _BoundaryProbe({required this.tone, required this.showCenterOverlay, required this.label});

  final Color tone;
  final bool showCenterOverlay;
  final String label;

  @override
  State<_BoundaryProbe> createState() => _BoundaryProbeState();
}

class _BoundaryProbeState extends State<_BoundaryProbe> {
  int _refreshCount = 0;

  @override
  Widget build(BuildContext context) {
    final lookupWidget = LookupBoundary.findAncestorWidgetOfExactType<_AncestorBadge>(context);
    final directWidget = context.findAncestorWidgetOfExactType<_AncestorBadge>();
    final hiddenByBoundary = LookupBoundary.debugIsHidingAncestorWidgetOfExactType<_AncestorBadge>(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.tone.withValues(alpha: 0.45)),
        gradient: const LinearGradient(
          colors: [Color(0xFFF9FCFF), Color(0xFFE8F1FB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.label, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800, fontSize: 16)),
              const Spacer(),
              FilledButton.tonal(
                onPressed: () => setState(() => _refreshCount += 1),
                child: Text('Refresh $_refreshCount'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              _DataGrid(
                rows: [
                  _DataRowItem('LookupBoundary.findAncestorWidget', lookupWidget?.name ?? '<none>'),
                  _DataRowItem('context.findAncestorWidget', directWidget?.name ?? '<none>'),
                  _DataRowItem('lookup hidden by boundary', hiddenByBoundary ? 'yes' : 'no'),
                  _DataRowItem('lookup widget revision', lookupWidget?.revision.toString() ?? '-'),
                  _DataRowItem('direct widget revision', directWidget?.revision.toString() ?? '-'),
                ],
              ),
              if (widget.showCenterOverlay)
                IgnorePointer(
                  child: Center(
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: widget.tone.withValues(alpha: 0.38), width: 2),
                        color: widget.tone.withValues(alpha: 0.07),
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
}

class _AncestorBadge extends InheritedWidget {
  const _AncestorBadge({
    required this.name,
    required this.revision,
    required this.color,
    required super.child,
  });

  final String name;
  final int revision;
  final Color color;

  @override
  bool updateShouldNotify(covariant _AncestorBadge oldWidget) {
    return name != oldWidget.name || revision != oldWidget.revision || color != oldWidget.color;
  }
}

class _InheritedScopeScene extends StatefulWidget {
  const _InheritedScopeScene({required this.compact, required this.showGuide, required this.showNotes});

  final bool compact;
  final bool showGuide;
  final bool showNotes;

  @override
  State<_InheritedScopeScene> createState() => _InheritedScopeSceneState();
}

class _InheritedScopeSceneState extends State<_InheritedScopeScene> {
  bool _boundary = true;
  bool _localInnerScope = false;
  int _workspaceRevision = 1;
  int _innerRevision = 1;

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 940.0 : 1120.0;

    Widget probe = _ScopeProbeCard(showNotes: widget.showNotes);
    if (_localInnerScope) {
      probe = _SignalScope(
        name: 'Inner Override Scope',
        revision: _innerRevision,
        color: _amber,
        child: probe,
      );
    }
    if (_boundary) {
      probe = LookupBoundary(child: probe);
    }

    return SizedBox(
      height: sceneHeight,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Scope controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _boundary,
                        onChanged: (v) => setState(() => _boundary = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Boundary between workspace and probe'),
                      ),
                      SwitchListTile(
                        value: _localInnerScope,
                        onChanged: (v) => setState(() => _localInnerScope = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Add local inner SignalScope override'),
                      ),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () => setState(() => _workspaceRevision += 1),
                        child: Text('Bump workspace revision ($_workspaceRevision)'),
                      ),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: _localInnerScope ? () => setState(() => _innerRevision += 1) : null,
                        child: Text('Bump inner revision ($_innerRevision)'),
                      ),
                      const SizedBox(height: 8),
                      _DataGrid(
                        rows: [
                          _DataRowItem('boundary', _boundary ? 'enabled' : 'disabled'),
                          _DataRowItem('inner override', _localInnerScope ? 'enabled' : 'disabled'),
                          _DataRowItem('workspace revision', '$_workspaceRevision'),
                          _DataRowItem('inner revision', _localInnerScope ? '$_innerRevision' : '-'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.showNotes)
                        _InstructionList(
                          tone: _green,
                          lines: const [
                            'dependOnInheritedWidgetOfExactType establishes a dependency and rebuilds when that scope changes.',
                            'getInheritedWidgetOfExactType reads the nearest scope without registering dependency.',
                            'getElementForInheritedWidgetOfExactType reveals whether a matching inherited element is reachable through boundary rules.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: _SignalScope(
                  name: 'Workspace Scope',
                  revision: _workspaceRevision,
                  color: _green,
                  child: probe,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SignalScope extends InheritedWidget {
  const _SignalScope({
    required this.name,
    required this.revision,
    required this.color,
    required super.child,
  });

  final String name;
  final int revision;
  final Color color;

  @override
  bool updateShouldNotify(covariant _SignalScope oldWidget) {
    return name != oldWidget.name || revision != oldWidget.revision || color != oldWidget.color;
  }
}

class _ScopeProbeCard extends StatefulWidget {
  const _ScopeProbeCard({required this.showNotes});

  final bool showNotes;

  @override
  State<_ScopeProbeCard> createState() => _ScopeProbeCardState();
}

class _ScopeProbeCardState extends State<_ScopeProbeCard> {
  int _manualRefresh = 0;
  int _dependRebuildCount = 0;

  @override
  Widget build(BuildContext context) {
    final dependentScope = LookupBoundary.dependOnInheritedWidgetOfExactType<_SignalScope>(context);
    final nonDependentScope = LookupBoundary.getInheritedWidgetOfExactType<_SignalScope>(context);
    final scopeElement = LookupBoundary.getElementForInheritedWidgetOfExactType<_SignalScope>(context);
    final hiddenScope = LookupBoundary.debugIsHidingAncestorWidgetOfExactType<_SignalScope>(context);
    _dependRebuildCount += 1;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _green.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Inherited Probe', style: TextStyle(color: _green, fontSize: 16, fontWeight: FontWeight.w800)),
              const Spacer(),
              FilledButton.tonal(
                onPressed: () => setState(() => _manualRefresh += 1),
                child: Text('Manual refresh $_manualRefresh'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _DataGrid(
            rows: [
              _DataRowItem('dependOn scope', dependentScope?.name ?? '<none>'),
              _DataRowItem('getInherited scope', nonDependentScope?.name ?? '<none>'),
              _DataRowItem('element runtimeType', scopeElement?.runtimeType.toString() ?? '<none>'),
              _DataRowItem('scope revision (depend)', dependentScope?.revision.toString() ?? '-'),
              _DataRowItem('scope revision (read)', nonDependentScope?.revision.toString() ?? '-'),
              _DataRowItem('boundary hiding scope', hiddenScope ? 'yes' : 'no'),
              _DataRowItem('depend rebuild count', '$_dependRebuildCount'),
            ],
          ),
          if (widget.showNotes) ...[
            const SizedBox(height: 8),
            _InstructionList(
              tone: _green,
              lines: const [
                'This panel calls all three LookupBoundary inherited lookup methods on each build.',
                'When no scope is reachable through boundary rules, the results are null and hidden checks can report true.',
                'When an inner scope exists below the boundary, it remains visible because it is local to the bounded subtree.',
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _StateLookupScene extends StatefulWidget {
  const _StateLookupScene({required this.compact, required this.showGuide, required this.showNotes});

  final bool compact;
  final bool showGuide;
  final bool showNotes;

  @override
  State<_StateLookupScene> createState() => _StateLookupSceneState();
}

class _StateLookupSceneState extends State<_StateLookupScene> {
  bool _insertBoundary = true;
  bool _insertInnerArena = true;

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 980.0 : 1160.0;

    Widget probe = const _StateLookupProbe();
    if (_insertBoundary) {
      probe = LookupBoundary(child: probe);
    }
    if (_insertInnerArena) {
      probe = _CounterArena(name: 'Inner Arena', tone: _amber, child: probe);
    }

    return SizedBox(
      height: sceneHeight,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('State lookup controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _insertBoundary,
                        onChanged: (v) => setState(() => _insertBoundary = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Boundary between outer and probe'),
                      ),
                      SwitchListTile(
                        value: _insertInnerArena,
                        onChanged: (v) => setState(() => _insertInnerArena = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Insert inner state arena'),
                      ),
                      const SizedBox(height: 8),
                      _DataGrid(
                        rows: [
                          _DataRowItem('boundary', _insertBoundary ? 'enabled' : 'disabled'),
                          _DataRowItem('inner arena', _insertInnerArena ? 'enabled' : 'disabled'),
                          _DataRowItem('lookup methods', 'findAncestorStateOfType / findRootAncestorStateOfType'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.showNotes)
                        _InstructionList(
                          tone: _amber,
                          lines: const [
                            'findAncestorStateOfType returns the nearest matching state visible within boundary constraints.',
                            'findRootAncestorStateOfType returns the farthest matching state still reachable in the bounded scope.',
                            'debugIsHidingAncestorStateOfType reports if a matching state exists beyond a LookupBoundary barrier.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: _CounterArena(
                  name: 'Outer Arena',
                  tone: _blue,
                  child: probe,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CounterArena extends StatefulWidget {
  const _CounterArena({required this.name, required this.tone, required this.child});

  final String name;
  final Color tone;
  final Widget child;

  @override
  State<_CounterArena> createState() => _CounterArenaState();
}

class _CounterArenaState extends State<_CounterArena> {
  int count = 0;

  void increment() {
    setState(() => count += 1);
  }

  void decrement() {
    setState(() => count -= 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.tone.withValues(alpha: 0.45)),
        color: widget.tone.withValues(alpha: 0.08),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.name, style: TextStyle(color: widget.tone, fontWeight: FontWeight.w800, fontSize: 16)),
              const Spacer(),
              Text('count: $count', style: TextStyle(color: widget.tone, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}

class _StateLookupProbe extends StatefulWidget {
  const _StateLookupProbe();

  @override
  State<_StateLookupProbe> createState() => _StateLookupProbeState();
}

class _StateLookupProbeState extends State<_StateLookupProbe> {
  int _events = 0;
  final List<String> _log = <String>[];

  @override
  Widget build(BuildContext context) {
    final nearest = LookupBoundary.findAncestorStateOfType<_CounterArenaState>(context);
    final root = LookupBoundary.findRootAncestorStateOfType<_CounterArenaState>(context);
    final hidden = LookupBoundary.debugIsHidingAncestorStateOfType<_CounterArenaState>(context);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _amber.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('State Probe', style: TextStyle(color: _amber, fontWeight: FontWeight.w800, fontSize: 16)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.tonal(
                onPressed: nearest == null
                    ? null
                    : () {
                        nearest.increment();
                        _push('nearest.increment()');
                      },
                child: const Text('Increment nearest'),
              ),
              FilledButton.tonal(
                onPressed: nearest == null
                    ? null
                    : () {
                        nearest.decrement();
                        _push('nearest.decrement()');
                      },
                child: const Text('Decrement nearest'),
              ),
              FilledButton.tonal(
                onPressed: root == null
                    ? null
                    : () {
                        root.increment();
                        _push('root.increment()');
                      },
                child: const Text('Increment root'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _DataGrid(
            rows: [
              _DataRowItem('nearest state', nearest?.widget.name ?? '<none>'),
              _DataRowItem('root state', root?.widget.name ?? '<none>'),
              _DataRowItem('nearest count', nearest?.count.toString() ?? '-'),
              _DataRowItem('root count', root?.count.toString() ?? '-'),
              _DataRowItem('hidden by boundary', hidden ? 'yes' : 'no'),
              _DataRowItem('actions', '$_events'),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(child: _LogView(lines: _log)),
        ],
      ),
    );
  }

  void _push(String message) {
    setState(() {
      _events += 1;
      _log.insert(0, '${_clock()} | $message');
      if (_log.length > 24) {
        _log.removeRange(24, _log.length);
      }
    });
  }
}

class _TraversalRenderScene extends StatefulWidget {
  const _TraversalRenderScene({required this.compact, required this.showGuide, required this.showNotes});

  final bool compact;
  final bool showGuide;
  final bool showNotes;

  @override
  State<_TraversalRenderScene> createState() => _TraversalRenderSceneState();
}

class _TraversalRenderSceneState extends State<_TraversalRenderScene> {
  bool _insertBoundary = true;
  bool _showRenderBeacon = true;
  int _refresh = 0;

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 980.0 : 1160.0;

    Widget tree = _RenderBeacon(
      label: 'Beacon Anchor',
      child: _TraversalProbe(refreshToken: _refresh),
    );
    if (!_showRenderBeacon) {
      tree = _TraversalProbe(refreshToken: _refresh);
    }
    if (_insertBoundary) {
      tree = LookupBoundary(child: tree);
    }

    return SizedBox(
      height: sceneHeight,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _PanelSurface(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Traversal controls', style: TextStyle(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        value: _insertBoundary,
                        onChanged: (v) => setState(() => _insertBoundary = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Boundary around probe'),
                      ),
                      SwitchListTile(
                        value: _showRenderBeacon,
                        onChanged: (v) => setState(() => _showRenderBeacon = v),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Insert custom RenderBeacon ancestor'),
                      ),
                      const SizedBox(height: 8),
                      FilledButton.tonal(
                        onPressed: () => setState(() => _refresh += 1),
                        child: Text('Refresh traversal ($_refresh)'),
                      ),
                      const SizedBox(height: 8),
                      _DataGrid(
                        rows: [
                          _DataRowItem('boundary', _insertBoundary ? 'enabled' : 'disabled'),
                          _DataRowItem('render beacon', _showRenderBeacon ? 'enabled' : 'disabled'),
                          _DataRowItem('refresh token', '$_refresh'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (widget.showNotes)
                        _InstructionList(
                          tone: _rose,
                          lines: const [
                            'findAncestorRenderObjectOfType can be constrained by LookupBoundary, just like ancestor widget/state lookup APIs.',
                            'visitAncestorElements and visitChildElements help inspect composition shape and verify tree assumptions.',
                            'Boundary-controlled traversal is useful in debugging and in building robust self-contained feature modules.',
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: _PanelSurface(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: tree,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RenderBeacon extends SingleChildRenderObjectWidget {
  const _RenderBeacon({required this.label, required super.child});

  final String label;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderBeaconBox(label: label);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderBeaconBox renderObject) {
    renderObject.label = label;
  }
}

class _RenderBeaconBox extends RenderProxyBox {
  _RenderBeaconBox({required String label}) : _label = label;

  String _label;

  String get label => _label;

  set label(String value) {
    if (value == _label) {
      return;
    }
    _label = value;
    markNeedsPaint();
  }
}

class _TraversalProbe extends StatefulWidget {
  const _TraversalProbe({required this.refreshToken});

  final int refreshToken;

  @override
  State<_TraversalProbe> createState() => _TraversalProbeState();
}

class _TraversalProbeState extends State<_TraversalProbe> {
  final List<String> _ancestors = <String>[];
  final List<String> _children = <String>[];
  String _renderLookup = '<none>';
  bool _hidingRender = false;

  @override
  void didUpdateWidget(covariant _TraversalProbe oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.refreshToken != widget.refreshToken) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _collect();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _collect();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _rose.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Traversal Probe', style: TextStyle(color: _rose, fontWeight: FontWeight.w800, fontSize: 16)),
              const Spacer(),
              FilledButton.tonal(onPressed: _collect, child: const Text('Collect now')),
            ],
          ),
          const SizedBox(height: 8),
          _DataGrid(
            rows: [
              _DataRowItem('render lookup', _renderLookup),
              _DataRowItem('hidden render by boundary', _hidingRender ? 'yes' : 'no'),
              _DataRowItem('ancestor count', '${_ancestors.length}'),
              _DataRowItem('child count', '${_children.length}'),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _StringListCard(title: 'Ancestors', lines: _ancestors, tone: _rose)),
                const SizedBox(width: 8),
                Expanded(child: _StringListCard(title: 'Children', lines: _children, tone: _violet)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _collect() {
    final ancestors = <String>[];
    final children = <String>[];

    LookupBoundary.visitAncestorElements(context, (element) {
      ancestors.add(element.widget.runtimeType.toString());
      return ancestors.length < 18;
    });
    LookupBoundary.visitChildElements(context, (element) {
      children.add(element.widget.runtimeType.toString());
    });

    final render = LookupBoundary.findAncestorRenderObjectOfType<_RenderBeaconBox>(context);
    final hiding = LookupBoundary.debugIsHidingAncestorRenderObjectOfType<_RenderBeaconBox>(context);

    setState(() {
      _ancestors
        ..clear()
        ..addAll(ancestors);
      _children
        ..clear()
        ..addAll(children);
      _renderLookup = render?.label ?? '<none>';
      _hidingRender = hiding;
    });
  }
}

class _PracticalSandboxScene extends StatefulWidget {
  const _PracticalSandboxScene({required this.compact, required this.showGuide, required this.showNotes});

  final bool compact;
  final bool showGuide;
  final bool showNotes;

  @override
  State<_PracticalSandboxScene> createState() => _PracticalSandboxSceneState();
}

class _PracticalSandboxSceneState extends State<_PracticalSandboxScene> {
  bool _boundaryA = true;
  bool _boundaryB = true;
  bool _boundaryC = true;
  bool _localScopeA = true;
  bool _localScopeB = false;
  bool _localScopeC = true;
  int _workspaceRevision = 1;
  final List<String> _events = <String>[];

  @override
  Widget build(BuildContext context) {
    final sceneHeight = widget.compact ? 1120.0 : 1340.0;
    return SizedBox(
      height: sceneHeight,
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: _PanelSurface(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilledButton.tonal(
                          onPressed: () {
                            setState(() {
                              _workspaceRevision += 1;
                            });
                            _push('workspace revision -> $_workspaceRevision');
                          },
                          child: Text('Bump workspace revision ($_workspaceRevision)'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            setState(() {
                              _boundaryA = true;
                              _boundaryB = true;
                              _boundaryC = true;
                            });
                            _push('all module boundaries enabled');
                          },
                          child: const Text('Enable all boundaries'),
                        ),
                        FilledButton.tonal(
                          onPressed: () {
                            setState(() {
                              _boundaryA = false;
                              _boundaryB = false;
                              _boundaryC = false;
                            });
                            _push('all module boundaries disabled');
                          },
                          child: const Text('Disable all boundaries'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilterChip(selected: _boundaryA, label: const Text('Module A boundary'), onSelected: (v) => setState(() => _boundaryA = v)),
                        FilterChip(selected: _boundaryB, label: const Text('Module B boundary'), onSelected: (v) => setState(() => _boundaryB = v)),
                        FilterChip(selected: _boundaryC, label: const Text('Module C boundary'), onSelected: (v) => setState(() => _boundaryC = v)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        FilterChip(selected: _localScopeA, label: const Text('Module A local scope'), onSelected: (v) => setState(() => _localScopeA = v)),
                        FilterChip(selected: _localScopeB, label: const Text('Module B local scope'), onSelected: (v) => setState(() => _localScopeB = v)),
                        FilterChip(selected: _localScopeC, label: const Text('Module C local scope'), onSelected: (v) => setState(() => _localScopeC = v)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _SignalScope(
                        name: 'Workspace Scope',
                        revision: _workspaceRevision,
                        color: _violet,
                        child: Row(
                          children: [
                            Expanded(
                              child: _sandboxModule(
                                id: 'A',
                                tone: _blue,
                                boundary: _boundaryA,
                                localScope: _localScopeA,
                                localScopeName: 'Payments Scope',
                                onEvent: _push,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _sandboxModule(
                                id: 'B',
                                tone: _green,
                                boundary: _boundaryB,
                                localScope: _localScopeB,
                                localScopeName: 'Inventory Scope',
                                onEvent: _push,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _sandboxModule(
                                id: 'C',
                                tone: _amber,
                                boundary: _boundaryC,
                                localScope: _localScopeC,
                                localScopeName: 'Analytics Scope',
                                onEvent: _push,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: _PanelSurface(
              showGuide: widget.showGuide,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sandbox notes', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    _DataGrid(
                      rows: [
                        _DataRowItem('workspace revision', '$_workspaceRevision'),
                        _DataRowItem('boundaries', 'A:${_boundaryA ? 'on' : 'off'} B:${_boundaryB ? 'on' : 'off'} C:${_boundaryC ? 'on' : 'off'}'),
                        _DataRowItem('local scopes', 'A:${_localScopeA ? 'on' : 'off'} B:${_localScopeB ? 'on' : 'off'} C:${_localScopeC ? 'on' : 'off'}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (widget.showNotes)
                      _InstructionList(
                        tone: _violet,
                        lines: const [
                          'Each module runs a probe using LookupBoundary inherited/widget/state lookup helpers.',
                          'With boundaries enabled, modules can keep local assumptions stable even when workspace ancestors change.',
                          'This pattern is useful for plugin hosts, micro-frontends, and layered feature architectures.',
                        ],
                      ),
                    const SizedBox(height: 8),
                    const Text('Recent events', style: TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Expanded(child: _LogView(lines: _events)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sandboxModule({
    required String id,
    required Color tone,
    required bool boundary,
    required bool localScope,
    required String localScopeName,
    required ValueChanged<String> onEvent,
  }) {
    Widget child = _ModuleProbe(moduleId: id, tone: tone, onEvent: onEvent);
    if (localScope) {
      child = _SignalScope(
        name: localScopeName,
        revision: DateTime.now().second,
        color: tone,
        child: child,
      );
    }
    if (boundary) {
      child = LookupBoundary(child: child);
    }
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.42)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Module $id', style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Expanded(child: child),
        ],
      ),
    );
  }

  void _push(String message) {
    setState(() {
      _events.insert(0, '${_clock()} | $message');
      if (_events.length > 36) {
        _events.removeRange(36, _events.length);
      }
    });
  }
}

class _ModuleProbe extends StatefulWidget {
  const _ModuleProbe({required this.moduleId, required this.tone, required this.onEvent});

  final String moduleId;
  final Color tone;
  final ValueChanged<String> onEvent;

  @override
  State<_ModuleProbe> createState() => _ModuleProbeState();
}

class _ModuleProbeState extends State<_ModuleProbe> {
  int _tap = 0;

  @override
  Widget build(BuildContext context) {
    final scope = LookupBoundary.getInheritedWidgetOfExactType<_SignalScope>(context);
    final scopeByDepend = LookupBoundary.dependOnInheritedWidgetOfExactType<_SignalScope>(context);
    final outerBadge = LookupBoundary.findAncestorWidgetOfExactType<_AncestorBadge>(context);
    final hiddenScope = LookupBoundary.debugIsHidingAncestorWidgetOfExactType<_SignalScope>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DataGrid(
          rows: [
            _DataRowItem('scope (read)', scope?.name ?? '<none>'),
            _DataRowItem('scope (depend)', scopeByDepend?.name ?? '<none>'),
            _DataRowItem('scope revision', scope?.revision.toString() ?? '-'),
            _DataRowItem('ancestor badge', outerBadge?.name ?? '<none>'),
            _DataRowItem('scope hidden', hiddenScope ? 'yes' : 'no'),
          ],
        ),
        const SizedBox(height: 8),
        FilledButton.tonal(
          onPressed: () {
            setState(() => _tap += 1);
            widget.onEvent('Module ${widget.moduleId} action #$_tap | scope=${scope?.name ?? '<none>'}');
          },
          child: Text('Trigger module action ($_tap)'),
        ),
      ],
    );
  }
}

class _PanelSurface extends StatelessWidget {
  const _PanelSurface({required this.showGuide, required this.child});

  final bool showGuide;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC6D7E8)),
        gradient: const LinearGradient(
          colors: [Color(0xFFFBFDFF), Color(0xFFEFF5FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (showGuide) const CustomPaint(painter: _GuideGridPainter()),
          child,
        ],
      ),
    );
  }
}

class _GuideGridPainter extends CustomPainter {
  const _GuideGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0x10000000);
    const step = 22.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DataRowItem {
  const _DataRowItem(this.label, this.value);

  final String label;
  final String value;
}

class _DataGrid extends StatelessWidget {
  const _DataGrid({required this.rows});

  final List<_DataRowItem> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F8FD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD2E1EF)),
      ),
      child: Column(
        children: rows
            .map(
              (row) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    SizedBox(width: 150, child: Text(row.label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12))),
                    Expanded(child: Text(row.value, style: const TextStyle(fontSize: 12))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _InstructionList extends StatelessWidget {
  const _InstructionList({required this.tone, required this.lines});

  final Color tone;
  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: tone.withValues(alpha: 0.95), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines
            .map(
              (line) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(Icons.circle, size: 7, color: Color(0xFFBFE3FF)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(line, style: const TextStyle(color: Color(0xFFE8F6FF), height: 1.35))),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _StringListCard extends StatelessWidget {
  const _StringListCard({required this.title, required this.lines, required this.tone});

  final String title;
  final List<String> lines;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tone.withValues(alpha: 0.35)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(title, style: TextStyle(color: tone, fontWeight: FontWeight.w800)),
          ),
          Expanded(
            child: lines.isEmpty
                ? const Center(child: Text('<none>', style: TextStyle(color: Color(0xFF62798D))))
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: lines.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(lines[index], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _LogView extends StatelessWidget {
  const _LogView({required this.lines});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD1DFEC)),
        color: Colors.white,
      ),
      child: lines.isEmpty
          ? const Text('No events yet.', style: TextStyle(color: Color(0xFF62798D)))
          : ListView.builder(
              itemCount: lines.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(lines[index], style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                );
              },
            ),
    );
  }
}

class _RecapPanel extends StatelessWidget {
  const _RecapPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF14384E),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recap: LookupBoundary', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'LookupBoundary is a deliberate architecture tool for ancestor isolation. '
            'It lets feature subtrees define stable lookup contracts by limiting inherited/widget/state/render traversal beyond a boundary. '
            'Use it to avoid accidental coupling in large, compositional Flutter UIs.',
            style: TextStyle(color: Color(0xFFD7E8F6), height: 1.35),
          ),
        ],
      ),
    );
  }
}

String _clock() => DateTime.now().toIso8601String().substring(11, 19);

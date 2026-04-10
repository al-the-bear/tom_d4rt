// Deep visual demo for RenderObjectToWidgetAdapter
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

/// -------------------------------------------------------------------
/// RenderObjectToWidgetAdapter — Deep Visual Demo
///
/// Palette : BlueGrey 700 (#455A64) / Yellow 400 (#FFEE58)
/// Tabs    : Theory · Bootstrap Lab · Element Lifecycle
/// Topics  : Adapter bridging, attachToRenderTree, createElement,
///           createRenderObject, GlobalObjectKey, BuildOwner,
///           element reuse, mount vs update flow
/// -------------------------------------------------------------------

// ── colour constants ──────────────────────────────────────────────
const Color _kPrimary = Color(0xFF455A64);
const Color _kAccent = Color(0xFFFFEE58);
const Color _kBg = Color(0xFFECEFF1);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kDarkText = Color(0xFF212121);
const Color _kSubtle = Color(0xFF757575);
const Color _kCodeBg = Color(0xFFEFEBE9);
const Color _kDivider = Color(0xFFCFD8DC);

// ── entry point ───────────────────────────────────────────────────
dynamic build(BuildContext context) {
  return _RenderObjectToWidgetAdapterDemo();
}

class _RenderObjectToWidgetAdapterDemo extends StatefulWidget {
  @override
  State<_RenderObjectToWidgetAdapterDemo> createState() =>
      _RenderObjectToWidgetAdapterDemoState();
}

class _RenderObjectToWidgetAdapterDemoState
    extends State<_RenderObjectToWidgetAdapterDemo>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        title: Text('RenderObjectToWidgetAdapter',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: _kAccent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: [
            Tab(text: 'Theory'),
            Tab(text: 'Bootstrap Lab'),
            Tab(text: 'Element Lifecycle'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _TheoryTab(),
          _BootstrapLabTab(),
          _ElementLifecycleTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
//  TAB 1 — Theory
// ═══════════════════════════════════════════════════════════════════
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── Class overview ──
        _sectionCard(
          title: 'Class Overview',
          children: [
            Text(
              'RenderObjectToWidgetAdapter is the bridge that connects a '
              'widget tree to an existing RenderObject container. It is the '
              'root widget used by runApp() to attach the app widget tree to '
              'the RenderView.',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
            SizedBox(height: 12),
            _codeBlock(
              'class RenderObjectToWidgetAdapter<\n'
              '    T extends RenderObject>\n'
              '    extends RenderObjectWidget {\n'
              '  final Widget? child;\n'
              '  final RenderObjectWithChildMixin<T>\n'
              '      container;\n'
              '  final String? debugShortDescription;\n'
              '}',
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── Type Parameter ──
        _sectionCard(
          title: 'Type Parameter T',
          children: [
            _typeBadge('T extends RenderObject',
                'Type of child expected by the container'),
            SizedBox(height: 10),
            Text(
              'Typically T is RenderBox — the container is usually the '
              'RenderView which expects a single RenderBox child.',
              style: TextStyle(fontSize: 12, color: _kSubtle, height: 1.5),
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── Constructor ──
        _sectionCard(
          title: 'Constructor',
          children: [
            _codeBlock(
              'RenderObjectToWidgetAdapter({\n'
              '  this.child,\n'
              '  required this.container,\n'
              '  this.debugShortDescription,\n'
              '})\n'
              ': super(\n'
              '    key: GlobalObjectKey(container),\n'
              '  );',
            ),
            SizedBox(height: 10),
            _propertyRow('child', 'Widget?', 'Root widget of the app tree'),
            _propertyRow('container', 'RenderObjectWithChildMixin<T>',
                'Existing render object to attach to'),
            _propertyRow('debugShortDescription', 'String?',
                'Debug label for diagnostics'),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(Icons.key, size: 16, color: _kPrimary),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Uses GlobalObjectKey(container) — ensures exactly one '
                      'adapter element per container.',
                      style: TextStyle(fontSize: 11, color: _kDarkText, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── Key Methods ──
        _sectionCard(
          title: 'Key Methods',
          children: [
            _methodBlock('createElement()',
                'Returns RenderObjectToWidgetElement<T>(this)',
                'Creates the element that manages this adapter.'),
            Divider(color: _kDivider, height: 20),
            _methodBlock('createRenderObject(context)',
                'Returns container (as-is)',
                'Does NOT create a new render object — reuses the existing container.'),
            Divider(color: _kDivider, height: 20),
            _methodBlock('updateRenderObject(context, renderObject)',
                '// No-op',
                'Container already exists and is not recreated.'),
          ],
        ),
        SizedBox(height: 16),

        // ── attachToRenderTree ──
        _sectionCard(
          title: 'attachToRenderTree()',
          children: [
            Text(
              'The critical method that bootstraps the element tree into '
              'an existing render tree. Called by WidgetsBinding during startup.',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
            SizedBox(height: 12),
            _codeBlock(
              'RenderObjectToWidgetElement<T>\n'
              '  attachToRenderTree(\n'
              '    BuildOwner owner,\n'
              '    [RenderObjectToWidgetElement<T>?\n'
              '      element]\n'
              ') {\n'
              '  if (element == null) {\n'
              '    // First mount\n'
              '    owner.lockState(() {\n'
              '      element = createElement();\n'
              '      element!.assignOwner(owner);\n'
              '    });\n'
              '    owner.buildScope(\n'
              '      element!, () {\n'
              '        element!.mount(null, null);\n'
              '    });\n'
              '  } else {\n'
              '    // Update existing\n'
              '    element._newWidget = this;\n'
              '    element.markNeedsBuild();\n'
              '  }\n'
              '  return element!;\n'
              '}',
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── Where it fits ──
        _sectionCard(
          title: 'Where It Fits in the Framework',
          children: [
            _positionRow(Icons.apps, 'runApp(widget)',
                'Entry point — creates binding'),
            _positionArrow(),
            _positionRow(Icons.settings, 'WidgetsBinding',
                'Creates adapter and BuildOwner'),
            _positionArrow(),
            _positionRow(Icons.account_tree, 'RenderObjectToWidgetAdapter',
                'Bridge widget → existing render tree'),
            _positionArrow(),
            _positionRow(Icons.copy, 'RenderObjectToWidgetElement',
                'Root element managing child widgets'),
            _positionArrow(),
            _positionRow(Icons.crop_free, 'RenderView (container)',
                'Existing root render object'),
          ],
        ),
        SizedBox(height: 16),

        // ── vs RootWidget ──
        _sectionCard(
          title: 'Adapter vs RootWidget',
          children: [
            _comparisonHeader(),
            _comparisonRow('Purpose', 'Attach to container', 'Top-level root'),
            _comparisonRow('Creates RenderObject', 'No — reuses container', 'Yes — creates RenderView'),
            _comparisonRow('Used by', 'runApp() internally', 'WidgetsBinding.attachRootWidget'),
            _comparisonRow('Key type', 'GlobalObjectKey', 'Regular Key'),
            _comparisonRow('When to use', 'Custom embedding', 'Standard app startup'),
          ],
        ),
        SizedBox(height: 32),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
//  TAB 2 — Bootstrap Lab
// ═══════════════════════════════════════════════════════════════════
class _BootstrapLabTab extends StatefulWidget {
  @override
  State<_BootstrapLabTab> createState() => _BootstrapLabTabState();
}

class _BootstrapLabTabState extends State<_BootstrapLabTab> {
  int _step = 0;
  final List<String> _log = [];
  bool _elementExists = false;
  String _containerState = 'empty';
  String _buildOwnerState = 'idle';

  static const _maxSteps = 7;
  static const List<_BootstrapStepInfo> _steps = [
    _BootstrapStepInfo(
      title: 'Initial State',
      detail: 'Container (RenderView) exists but has no element tree. '
          'BuildOwner is idle.',
      icon: Icons.hourglass_empty,
    ),
    _BootstrapStepInfo(
      title: 'attachToRenderTree() called',
      detail: 'WidgetsBinding calls adapter.attachToRenderTree(owner, null). '
          'Element is null so we take the first-mount path.',
      icon: Icons.play_arrow,
    ),
    _BootstrapStepInfo(
      title: 'owner.lockState()',
      detail: 'BuildOwner locks state to prevent concurrent modifications. '
          'createElement() runs inside the lock.',
      icon: Icons.lock,
    ),
    _BootstrapStepInfo(
      title: 'createElement() + assignOwner()',
      detail: 'A new RenderObjectToWidgetElement is created and assigned '
          'this BuildOwner. No mount yet.',
      icon: Icons.add_circle_outline,
    ),
    _BootstrapStepInfo(
      title: 'owner.buildScope()',
      detail: 'BuildOwner opens a build scope. element.mount(null, null) '
          'is called within the scope.',
      icon: Icons.settings,
    ),
    _BootstrapStepInfo(
      title: 'element.mount()',
      detail: 'Element mounts into the tree, calling _rebuild() which inflates '
          'the child widget. The render tree is now connected.',
      icon: Icons.check_circle,
    ),
    _BootstrapStepInfo(
      title: 'Bootstrap Complete',
      detail: 'Element tree is attached. Future updates go through '
          'markNeedsBuild() → owner.buildScope().',
      icon: Icons.done_all,
    ),
  ];

  void _nextStep() {
    if (_step >= _maxSteps - 1) return;
    setState(() {
      _step++;
      _log.insert(0, 'Step $_step: ${_steps[_step].title}');

      switch (_step) {
        case 1:
          _buildOwnerState = 'active';
          break;
        case 2:
          _buildOwnerState = 'locked';
          break;
        case 3:
          _elementExists = true;
          _buildOwnerState = 'locked';
          break;
        case 4:
          _buildOwnerState = 'buildScope';
          break;
        case 5:
          _containerState = 'mounted';
          _buildOwnerState = 'buildScope';
          break;
        case 6:
          _buildOwnerState = 'idle';
          break;
      }
    });
  }

  void _reset() {
    setState(() {
      _step = 0;
      _log.clear();
      _elementExists = false;
      _containerState = 'empty';
      _buildOwnerState = 'idle';
    });
  }

  @override
  Widget build(BuildContext context) {
    final info = _steps[_step];
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── step progress ──
        _sectionCard(
          title: 'Bootstrap Sequence (Step ${_step + 1}/$_maxSteps)',
          children: [
            // progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (_step + 1) / _maxSteps,
                backgroundColor: _kDivider,
                valueColor: AlwaysStoppedAnimation(_kPrimary),
                minHeight: 8,
              ),
            ),
            SizedBox(height: 14),
            Row(
              children: [
                Icon(info.icon, color: _kPrimary, size: 24),
                SizedBox(width: 10),
                Expanded(
                  child: Text(info.title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: _kDarkText)),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(info.detail,
                style: TextStyle(fontSize: 12, color: _kSubtle, height: 1.5)),
            SizedBox(height: 14),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _step < _maxSteps - 1 ? _nextStep : null,
                  icon: Icon(Icons.skip_next, size: 18),
                  label: Text('Next Step'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary,
                    foregroundColor: Colors.white,
                  ),
                ),
                SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _reset,
                  icon: Icon(Icons.restart_alt, size: 18),
                  label: Text('Reset'),
                  style: OutlinedButton.styleFrom(foregroundColor: _kPrimary),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── visual state ──
        _sectionCard(
          title: 'System State',
          children: [
            Row(
              children: [
                Expanded(child: _stateIndicator('Container',
                    _containerState == 'mounted' ? 'Mounted' : 'Empty',
                    _containerState == 'mounted' ? _kAccent : _kDivider)),
                SizedBox(width: 10),
                Expanded(child: _stateIndicator('Element',
                    _elementExists ? 'Created' : 'None',
                    _elementExists ? _kAccent : _kDivider)),
                SizedBox(width: 10),
                Expanded(child: _stateIndicator('BuildOwner',
                    _buildOwnerState,
                    _buildOwnerState == 'idle' ? _kDivider
                        : _buildOwnerState == 'locked' ? Colors.orange.shade300
                        : _kAccent)),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── object diagram ──
        _sectionCard(
          title: 'Object Relationship',
          children: [
            _objectBox('RenderObjectToWidgetAdapter',
                'Widget — bridge configuration',
                _kPrimary, true),
            _connectionLine(),
            _objectBox('RenderObjectToWidgetElement',
                _elementExists ? 'Created — manages tree' : 'Not yet created',
                _elementExists ? Colors.blue.shade700 : _kSubtle,
                _elementExists),
            _connectionLine(),
            _objectBox('Container (RenderView)',
                _containerState == 'mounted'
                    ? 'Child attached — rendering'
                    : 'Exists — waiting for child',
                _containerState == 'mounted' ? Colors.green.shade700 : _kSubtle,
                true),
            _connectionLine(),
            _objectBox('BuildOwner',
                'Owner: $_buildOwnerState',
                _buildOwnerState == 'idle' ? _kSubtle : Colors.deepOrange,
                true),
          ],
        ),
        SizedBox(height: 16),

        // ── update vs mount ──
        _sectionCard(
          title: 'First Mount vs Update',
          children: [
            _codeBlock(
              '// First mount (element == null)\n'
              'owner.lockState(() {\n'
              '  element = createElement();\n'
              '  element!.assignOwner(owner);\n'
              '});\n'
              'owner.buildScope(element!, () {\n'
              '  element!.mount(null, null);\n'
              '});\n'
              '\n'
              '// Update (element != null)\n'
              'element._newWidget = this;\n'
              'element.markNeedsBuild();',
            ),
            SizedBox(height: 10),
            Row(
              children: [
                _tagChip('Mount', _kPrimary),
                SizedBox(width: 6),
                Expanded(
                  child: Text('Creates element, assigns owner, mounts in build scope',
                      style: TextStyle(fontSize: 11, color: _kSubtle)),
                ),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                _tagChip('Update', Colors.deepOrange),
                SizedBox(width: 6),
                Expanded(
                  child: Text('Sets new widget, marks dirty — rebuilt in next frame',
                      style: TextStyle(fontSize: 11, color: _kSubtle)),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── event log ──
        _sectionCard(
          title: 'Bootstrap Log',
          children: [
            if (_log.isEmpty)
              Text('Click "Next Step" to walk through bootstrap...',
                  style: TextStyle(fontSize: 12, color: _kSubtle, fontStyle: FontStyle.italic)),
            ..._log.take(10).map((e) => Padding(
                  padding: EdgeInsets.only(bottom: 3),
                  child: Row(
                    children: [
                      Icon(Icons.chevron_right, size: 14, color: _kPrimary),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(e, style: TextStyle(fontSize: 11, color: _kDarkText)),
                      ),
                    ],
                  ),
                )),
          ],
        ),
        SizedBox(height: 32),
      ],
    );
  }
}

class _BootstrapStepInfo {
  final String title;
  final String detail;
  final IconData icon;
  const _BootstrapStepInfo({
    required this.title,
    required this.detail,
    required this.icon,
  });
}

// ═══════════════════════════════════════════════════════════════════
//  TAB 3 — Element Lifecycle
// ═══════════════════════════════════════════════════════════════════
class _ElementLifecycleTab extends StatefulWidget {
  @override
  State<_ElementLifecycleTab> createState() => _ElementLifecycleTabState();
}

class _ElementLifecycleTabState extends State<_ElementLifecycleTab> {
  String _selectedPhase = 'mount';
  int _rebuildCount = 0;
  final List<String> _events = [];

  static const _phases = <String, _PhaseInfo>{
    'mount': _PhaseInfo(
      title: 'mount(parent, slot)',
      code: 'void mount(Element? parent, Object? slot) {\n'
          '  super.mount(parent, slot);\n'
          '  _rebuild();\n'
          '}',
      detail: 'Called once when the element is first inserted into the tree. '
          'After calling super.mount(), it immediately triggers _rebuild() '
          'to inflate the child widget.',
    ),
    'rebuild': _PhaseInfo(
      title: '_rebuild()',
      code: 'void _rebuild() {\n'
          '  try {\n'
          '    _child = updateChild(\n'
          '      _child,\n'
          '      (widget as ...)?.child,\n'
          '      _rootChildSlot,\n'
          '    );\n'
          '  } catch (exception, stack) {\n'
          '    // Show error widget\n'
          '    _child = updateChild(\n'
          '      null,\n'
          '      ErrorWidget.builder(...),\n'
          '      _rootChildSlot,\n'
          '    );\n'
          '  }\n'
          '}',
      detail: 'Core rebuild logic. Uses updateChild to inflate, update, or remove '
          'the child element. If an error occurs, it replaces the child with '
          'ErrorWidget — the app does not crash.',
    ),
    'update': _PhaseInfo(
      title: 'update(newWidget)',
      code: 'void update(\n'
          '    RenderObjectToWidgetAdapter<T>\n'
          '      newWidget) {\n'
          '  super.update(newWidget);\n'
          '  _rebuild();\n'
          '}',
      detail: 'Called when a new adapter widget is provided (e.g. via '
          'attachToRenderTree with existing element). Updates the widget '
          'reference and triggers a rebuild.',
    ),
    'performRebuild': _PhaseInfo(
      title: 'performRebuild()',
      code: 'void performRebuild() {\n'
          '  if (!kReleaseMode) {\n'
          '    assert(() {\n'
          '      _debugDoingBuild = true;\n'
          '      return true;\n'
          '    }());\n'
          '  }\n'
          '  _rebuild();\n'
          '}',
      detail: 'Called by the framework when the element is marked dirty. '
          'In debug mode, sets a flag for assertion checking. Delegates '
          'to _rebuild() for the actual work.',
    ),
  };

  void _simulateRebuild() {
    setState(() {
      _rebuildCount++;
      _events.insert(0, 'Rebuild #$_rebuildCount — markNeedsBuild() → _rebuild()');
      if (_events.length > 20) _events.removeLast();
    });
  }

  void _simulateHotReload() {
    setState(() {
      _rebuildCount++;
      _events.insert(0, 'Hot reload — reassemble() → markNeedsBuild()');
      if (_events.length > 20) _events.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    final phase = _phases[_selectedPhase]!;
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── element overview ──
        _sectionCard(
          title: 'RenderObjectToWidgetElement',
          children: [
            Text(
              'The element created by the adapter. It extends '
              'RootRenderObjectElement and is responsible for managing the '
              'root of the widget tree.',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
            SizedBox(height: 12),
            _codeBlock(
              'class RenderObjectToWidgetElement<\n'
              '    T extends RenderObject>\n'
              '    extends RootRenderObjectElement {\n'
              '  Element? _child;\n'
              '  // Manages single child widget\n'
              '}',
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── phase selector ──
        _sectionCard(
          title: 'Element Methods',
          children: [
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: _phases.keys.map((key) {
                final selected = key == _selectedPhase;
                return GestureDetector(
                  onTap: () => setState(() => _selectedPhase = key),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: selected ? _kPrimary : _kDivider,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(key,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: selected ? Colors.white : _kDarkText,
                        )),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 14),
            Text(phase.title,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w700, color: _kPrimary)),
            SizedBox(height: 8),
            _codeBlock(phase.code),
            SizedBox(height: 10),
            Text(phase.detail,
                style: TextStyle(fontSize: 12, color: _kSubtle, height: 1.5)),
          ],
        ),
        SizedBox(height: 16),

        // ── lifecycle flow ──
        _sectionCard(
          title: 'Lifecycle Flow',
          children: [
            _lifecycleNode('mount()', 'First insertion', 0),
            _lifecycleArrow(),
            _lifecycleNode('_rebuild()', 'Inflate child', 1),
            _lifecycleArrow(),
            _lifecycleNode('updateChild()', 'Create/update Element', 2),
            SizedBox(height: 14),
            Divider(color: _kDivider),
            SizedBox(height: 6),
            Text('On subsequent updates:',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kDarkText)),
            SizedBox(height: 8),
            _lifecycleNode('markNeedsBuild()', 'Mark dirty', 3),
            _lifecycleArrow(),
            _lifecycleNode('performRebuild()', 'Framework callback', 4),
            _lifecycleArrow(),
            _lifecycleNode('_rebuild()', 'Reconcile child', 5),
          ],
        ),
        SizedBox(height: 16),

        // ── interactive rebuild ──
        _sectionCard(
          title: 'Simulate Element Events',
          children: [
            Text(
              'Each button simulates an event that triggers the element '
              'lifecycle. Watch the event log below.',
              style: TextStyle(fontSize: 12, color: _kSubtle, height: 1.5),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _simulateRebuild,
                  icon: Icon(Icons.refresh, size: 16),
                  label: Text('Rebuild'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _simulateHotReload,
                  icon: Icon(Icons.bolt, size: 16),
                  label: Text('Hot Reload'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _rebuildCount = 0;
                      _events.clear();
                    });
                  },
                  icon: Icon(Icons.delete_outline, size: 16),
                  label: Text('Clear'),
                  style: OutlinedButton.styleFrom(foregroundColor: _kPrimary),
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kAccent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Total rebuilds: ',
                      style: TextStyle(fontSize: 12, color: _kDarkText)),
                  Text('$_rebuildCount',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: _kPrimary)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── error handling ──
        _sectionCard(
          title: 'Error Recovery',
          children: [
            Text(
              'If _rebuild() throws, the element catches the error and replaces '
              'the child with an ErrorWidget. This prevents the entire app from '
              'crashing on a build error.',
              style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.5),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Build Error Caught',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.red.shade700)),
                        Text('ErrorWidget replaces broken subtree',
                            style: TextStyle(fontSize: 11, color: Colors.red.shade400)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            _codeBlock(
              'catch (exception, stack) {\n'
              '  final details = FlutterErrorDetails(\n'
              '    exception: exception,\n'
              '    stack: stack,\n'
              '    library: \'widgets\',\n'
              '    context: ErrorDescription(\n'
              '      \'attaching to render tree\'),\n'
              '  );\n'
              '  FlutterError\n'
              '    .reportError(details);\n'
              '  _child = updateChild(\n'
              '    null,\n'
              '    ErrorWidget\n'
              '      .builder(details),\n'
              '    _rootChildSlot,\n'
              '  );\n'
              '}',
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── event log ──
        _sectionCard(
          title: 'Event Log',
          children: [
            if (_events.isEmpty)
              Text('Click Rebuild or Hot Reload to see events...',
                  style: TextStyle(fontSize: 12, color: _kSubtle, fontStyle: FontStyle.italic)),
            ..._events.take(12).map((e) => Padding(
                  padding: EdgeInsets.only(bottom: 3),
                  child: Row(
                    children: [
                      Icon(Icons.chevron_right, size: 14, color: _kPrimary),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(e, style: TextStyle(fontSize: 11, color: _kDarkText)),
                      ),
                    ],
                  ),
                )),
          ],
        ),
        SizedBox(height: 32),
      ],
    );
  }
}

class _PhaseInfo {
  final String title;
  final String code;
  final String detail;
  const _PhaseInfo({
    required this.title,
    required this.code,
    required this.detail,
  });
}

// ═══════════════════════════════════════════════════════════════════
//  Shared helpers
// ═══════════════════════════════════════════════════════════════════

Widget _sectionCard({required String title, required List<Widget> children}) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 4, height: 18, color: _kPrimary),
            SizedBox(width: 8),
            Expanded(
              child: Text(title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _kDarkText)),
            ),
          ],
        ),
        SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(code,
        style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: _kDarkText, height: 1.5)),
  );
}

Widget _typeBadge(String name, String description) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _kAccent.withOpacity(0.3),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(name,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, fontFamily: 'monospace', color: _kPrimary)),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(description, style: TextStyle(fontSize: 11, color: _kSubtle)),
      ),
    ],
  );
}

Widget _propertyRow(String name, String type, String desc) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(name,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                  fontFamily: 'monospace', color: _kPrimary)),
        ),
        SizedBox(
          width: 90,
          child: Text(type,
              style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: _kSubtle)),
        ),
        Expanded(
          child: Text(desc, style: TextStyle(fontSize: 11, color: _kDarkText)),
        ),
      ],
    ),
  );
}

Widget _methodBlock(String name, String returns, String desc) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(name,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
              fontFamily: 'monospace', color: _kPrimary)),
      SizedBox(height: 4),
      Text('→ $returns',
          style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: _kSubtle)),
      SizedBox(height: 4),
      Text(desc, style: TextStyle(fontSize: 11, color: _kDarkText, height: 1.4)),
    ],
  );
}

Widget _positionRow(IconData icon, String title, String subtitle) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: _kPrimary.withOpacity(0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kPrimary.withOpacity(0.2)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _kPrimary),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _kDarkText)),
              Text(subtitle, style: TextStyle(fontSize: 11, color: _kSubtle)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _positionArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Center(child: Icon(Icons.arrow_downward, size: 16, color: _kSubtle)),
  );
}

Widget _comparisonHeader() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: _kPrimary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text('Aspect',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _kPrimary)),
        ),
        Expanded(
          flex: 3,
          child: Text('Adapter',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _kPrimary)),
        ),
        Expanded(
          flex: 3,
          child: Text('RootWidget',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _kPrimary)),
        ),
      ],
    ),
  );
}

Widget _comparisonRow(String aspect, String adapterVal, String rootVal) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(aspect,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _kDarkText)),
        ),
        Expanded(
          flex: 3,
          child: Text(adapterVal, style: TextStyle(fontSize: 11, color: _kSubtle)),
        ),
        Expanded(
          flex: 3,
          child: Text(rootVal, style: TextStyle(fontSize: 11, color: _kSubtle)),
        ),
      ],
    ),
  );
}

Widget _stateIndicator(String label, String state, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.5)),
    ),
    child: Column(
      children: [
        Text(label,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _kDarkText)),
        SizedBox(height: 4),
        Text(state,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _kPrimary)),
      ],
    ),
  );
}

Widget _objectBox(String title, String subtitle, Color color, bool active) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: active ? color.withOpacity(0.1) : _kDivider.withOpacity(0.4),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: active ? color.withOpacity(0.5) : _kDivider,
        width: active ? 2 : 1,
      ),
    ),
    child: Row(
      children: [
        Icon(
          active ? Icons.check_circle_outline : Icons.radio_button_unchecked,
          size: 18,
          color: active ? color : _kSubtle,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                      color: active ? color : _kSubtle)),
              Text(subtitle, style: TextStyle(fontSize: 11, color: _kSubtle)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _connectionLine() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1),
    child: Center(
      child: Container(width: 2, height: 16, color: _kDivider),
    ),
  );
}

Widget _tagChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color)),
  );
}

Widget _lifecycleNode(String name, String detail, int index) {
  final colors = [
    _kPrimary, Colors.blue.shade700, Colors.teal,
    Colors.deepOrange, Colors.purple, Colors.green.shade700,
  ];
  final color = colors[index % colors.length];
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          alignment: Alignment.center,
          child: Text('${index + 1}',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                      color: _kDarkText)),
              Text(detail, style: TextStyle(fontSize: 11, color: _kSubtle)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _lifecycleArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Center(child: Icon(Icons.arrow_downward, size: 16, color: _kSubtle)),
  );
}

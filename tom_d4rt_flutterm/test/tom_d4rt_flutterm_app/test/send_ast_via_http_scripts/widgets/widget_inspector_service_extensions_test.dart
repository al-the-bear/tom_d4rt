import 'dart:math' as math;

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Blueprint clipboard palette. Oxblood, ivory, graphite, parchment tones —
// styled like a field inspector's notebook with drafting-blue accents.
// ---------------------------------------------------------------------------
const Color _wiseInk = Color(0xFF141418);
const Color _wiseGraphite = Color(0xFF2A2A32);
const Color _wiseGraphiteSoft = Color(0xFF3D3D47);
const Color _wiseIvory = Color(0xFFF4ECDA);
const Color _wiseIvorySoft = Color(0xFFFBF6E8);
const Color _wiseIvoryEdge = Color(0xFFE4D8BC);
const Color _wiseParchment = Color(0xFFE8DDC2);
const Color _wiseParchmentDeep = Color(0xFFD5C69F);
const Color _wiseOxblood = Color(0xFF7A1F1F);
const Color _wiseOxbloodDeep = Color(0xFF5B1414);
const Color _wiseOxbloodPale = Color(0xFFDDB8B8);
const Color _wiseBlueprint = Color(0xFF1F3A5F);
const Color _wiseBlueprintDeep = Color(0xFF12243D);
const Color _wiseBlueprintPale = Color(0xFFC7D5E6);
const Color _wiseMoss = Color(0xFF4A5D3A);
const Color _wiseMossPale = Color(0xFFCDD6BB);
const Color _wiseBrass = Color(0xFFA07E32);
const Color _wiseBrassPale = Color(0xFFE9D9A8);
const Color _wiseChalk = Color(0xFFEFE9DA);
const Color _wiseShadow = Color(0xFF24201A);

// ---------------------------------------------------------------------------
// d4rt entry point. Single top-level `build` returning a MaterialApp whose
// home is the full blueprint dossier shell.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _WiseApp();
}

// ===========================================================================
// ENUM CATALOG DATA
// ===========================================================================
class _WiseExtensionEntry {
  const _WiseExtensionEntry({
    required this.name,
    required this.category,
    required this.summary,
    required this.detail,
    required this.sample,
    required this.params,
    required this.response,
  });

  final String name;
  final String category;
  final String summary;
  final String detail;
  final String sample;
  final String params;
  final String response;
}

const List<_WiseExtensionEntry> _wiseCatalog = <_WiseExtensionEntry>[
  _WiseExtensionEntry(
    name: 'disposeAllGroups',
    category: 'lifecycle',
    summary: 'Clears every inspector object group.',
    detail:
        'DevTools occasionally cycles all groups to avoid retaining elements '
        'after a widget rebuild. This wire-call releases every reference the '
        'inspector is currently holding so hot-reload stays cheap.',
    sample: 'ext.flutter.inspector.disposeAllGroups',
    params: '{ "isolateId": "isolates/12345" }',
    response: '{ "result": { "type": "Success" } }',
  ),
  _WiseExtensionEntry(
    name: 'disposeGroup',
    category: 'lifecycle',
    summary: 'Disposes one named inspector group.',
    detail:
        'Each DevTools panel pins a short-lived group name (for example '
        '"inspector-12"). When the panel closes, DevTools releases it with '
        'this call so Flutter can forget the referenced elements.',
    sample: 'ext.flutter.inspector.disposeGroup',
    params: '{ "objectGroup": "inspector-12" }',
    response: '{ "result": { "type": "Success" } }',
  ),
  _WiseExtensionEntry(
    name: 'isWidgetTreeReady',
    category: 'lifecycle',
    summary: 'Polls whether a root widget exists yet.',
    detail:
        'DevTools starts inspecting only after `runApp` has built its first '
        'frame. This probe is cheap — the service returns a boolean so the '
        'DevTools UI knows when to enable tree exploration.',
    sample: 'ext.flutter.inspector.isWidgetTreeReady',
    params: '{}',
    response: '{ "result": { "type": "bool", "value": true } }',
  ),
  _WiseExtensionEntry(
    name: 'disposeId',
    category: 'lifecycle',
    summary: 'Releases a single inspection id.',
    detail:
        'Fine-grained version of disposeGroup. Used when DevTools wants to '
        'drop a specific node reference without clearing its whole group.',
    sample: 'ext.flutter.inspector.disposeId',
    params: '{ "arg": "inspector-12:node-3" }',
    response: '{ "result": { "type": "Success" } }',
  ),
  _WiseExtensionEntry(
    name: 'setPubRootDirectories',
    category: 'diagnostics',
    summary: 'Declares which paths count as "user code".',
    detail:
        'DevTools uses this allow-list to fade out framework frames in its '
        'widget tree. The call replaces the full list in one shot.',
    sample: 'ext.flutter.inspector.setPubRootDirectories',
    params: '{ "arg0": "file:///home/me/project/lib" }',
    response: '{ "result": { "type": "Success" } }',
  ),
  _WiseExtensionEntry(
    name: 'addPubRootDirectories',
    category: 'diagnostics',
    summary: 'Appends directories to the user-code allow-list.',
    detail:
        'A non-destructive alternative to `setPubRootDirectories`. Useful '
        'when a monorepo has multiple lib/ folders that all belong to the '
        'developer.',
    sample: 'ext.flutter.inspector.addPubRootDirectories',
    params: '{ "arg0": "file:///home/me/packages/extra/lib" }',
    response: '{ "result": { "type": "Success" } }',
  ),
  _WiseExtensionEntry(
    name: 'removePubRootDirectories',
    category: 'diagnostics',
    summary: 'Removes directories from the allow-list.',
    detail:
        'Invoked when the developer rescopes their workspace in DevTools, '
        'for example after toggling off vendored plugins they no longer '
        'want highlighted as user code.',
    sample: 'ext.flutter.inspector.removePubRootDirectories',
    params: '{ "arg0": "file:///home/me/packages/extra/lib" }',
    response: '{ "result": { "type": "Success" } }',
  ),
  _WiseExtensionEntry(
    name: 'getPubRootDirectories',
    category: 'diagnostics',
    summary: 'Reads the current allow-list.',
    detail:
        'Lets DevTools reconcile its local UI with the framework-side '
        'configuration; for example after another debugger changed it.',
    sample: 'ext.flutter.inspector.getPubRootDirectories',
    params: '{}',
    response:
        '{ "result": [ "file:///home/me/project/lib" ] }',
  ),
  _WiseExtensionEntry(
    name: 'setSelectionById',
    category: 'selection',
    summary: 'Selects a node by its inspector id.',
    detail:
        'When the developer taps a widget in DevTools, the id of that node '
        'flows back to the runtime and this extension moves the framework-'
        'side selection cursor to match.',
    sample: 'ext.flutter.inspector.setSelectionById',
    params: '{ "arg": "inspector-12:node-77", "objectGroup": "inspector-12" }',
    response: '{ "result": { "type": "bool", "value": true } }',
  ),
  _WiseExtensionEntry(
    name: 'getParentChain',
    category: 'tree',
    summary: 'Walks from a node up to the root.',
    detail:
        'Produces an ancestor chain for the widget tree side-panel. Every '
        'step is serialized with enough metadata for DevTools to render a '
        'breadcrumb trail.',
    sample: 'ext.flutter.inspector.getParentChain',
    params: '{ "arg": "inspector-12:node-77", "objectGroup": "inspector-12" }',
    response:
        '{ "result": [ { "node": {...}, "children": [...] }, ... ] }',
  ),
  _WiseExtensionEntry(
    name: 'getProperties',
    category: 'properties',
    summary: 'Returns diagnostic properties of a node.',
    detail:
        'Every `DiagnosticsNode` can serialize its properties (colors, '
        'paddings, flex factors, ...). This extension exposes them so the '
        'DevTools "Details" pane can render them.',
    sample: 'ext.flutter.inspector.getProperties',
    params: '{ "arg": "inspector-12:node-77", "objectGroup": "inspector-12" }',
    response: '{ "result": [ { "name": "padding", "value": "8.0 all" } ] }',
  ),
  _WiseExtensionEntry(
    name: 'getChildren',
    category: 'tree',
    summary: 'Lists immediate children of a node.',
    detail:
        'Drives the lazy expansion of tree nodes in DevTools. Each child '
        'comes back with enough shape to render an icon and a label.',
    sample: 'ext.flutter.inspector.getChildren',
    params: '{ "arg": "inspector-12:node-77", "objectGroup": "inspector-12" }',
    response: '{ "result": [ { "name": "Padding", ... } ] }',
  ),
  _WiseExtensionEntry(
    name: 'getChildrenSummaryTree',
    category: 'tree',
    summary: 'Children filtered to the summary subset.',
    detail:
        'Same shape as `getChildren`, but filters out intermediate widgets '
        'that are not "user creation" nodes, producing the compact tree '
        'DevTools shows by default.',
    sample: 'ext.flutter.inspector.getChildrenSummaryTree',
    params: '{ "arg": "inspector-12:node-77", "objectGroup": "inspector-12" }',
    response: '{ "result": [ { "name": "MyCard", "creationLocation": {...} } ] }',
  ),
  _WiseExtensionEntry(
    name: 'getChildrenDetailsSubtree',
    category: 'tree',
    summary: 'Full detail subtree rooted at a node.',
    detail:
        'A deeper variant that follows many levels in one round-trip, used '
        'when the developer expands a node and wants to see everything '
        'below it without paging.',
    sample: 'ext.flutter.inspector.getChildrenDetailsSubtree',
    params: '{ "arg": "inspector-12:node-77", "objectGroup": "inspector-12" }',
    response: '{ "result": { "name": "MyCard", "children": [ ... ] } }',
  ),
  _WiseExtensionEntry(
    name: 'getRootWidget',
    category: 'tree',
    summary: 'Returns the app root widget.',
    detail:
        'The entry point for the entire widget tree. DevTools calls this '
        'once after connecting and then walks downward from the result.',
    sample: 'ext.flutter.inspector.getRootWidget',
    params: '{ "objectGroup": "inspector-12" }',
    response: '{ "result": { "name": "MyApp", "valueId": "inspector-12:1" } }',
  ),
  _WiseExtensionEntry(
    name: 'getRootWidgetSummaryTree',
    category: 'tree',
    summary: 'Compact root-oriented summary tree.',
    detail:
        'Prunes framework nodes away and returns a tree that only contains '
        'user-authored widgets. DevTools uses this as its default view.',
    sample: 'ext.flutter.inspector.getRootWidgetSummaryTree',
    params: '{ "objectGroup": "inspector-12" }',
    response: '{ "result": { "name": "MyApp", "summary": true } }',
  ),
  _WiseExtensionEntry(
    name: 'getRootWidgetSummaryTreeWithPreviews',
    category: 'tree',
    summary: 'Summary tree plus text previews per node.',
    detail:
        'Augments the summary tree with inline previews such as the text '
        'content of a Text widget, so the left rail in DevTools reads like '
        'a mini wireframe.',
    sample: 'ext.flutter.inspector.getRootWidgetSummaryTreeWithPreviews',
    params: '{ "objectGroup": "inspector-12" }',
    response:
        '{ "result": { "name": "MyApp", "preview": "Hello", "children": [...] } }',
  ),
  _WiseExtensionEntry(
    name: 'getSelectedWidget',
    category: 'selection',
    summary: 'Describes the currently selected node.',
    detail:
        'Mirrors the framework-side selection back to DevTools. Combined '
        'with setSelectionById, this enables two-way selection sync.',
    sample: 'ext.flutter.inspector.getSelectedWidget',
    params: '{ "objectGroup": "inspector-12" }',
    response: '{ "result": { "name": "Padding", "valueId": "inspector-12:77" } }',
  ),
  _WiseExtensionEntry(
    name: 'getSelectedSummaryWidget',
    category: 'selection',
    summary: 'Selected widget within the summary tree.',
    detail:
        'When the summary tree filter is on, this returns the nearest '
        'user-authored ancestor that represents the selection.',
    sample: 'ext.flutter.inspector.getSelectedSummaryWidget',
    params: '{ "objectGroup": "inspector-12" }',
    response: '{ "result": { "name": "MyCard", "summary": true } }',
  ),
  _WiseExtensionEntry(
    name: 'isWidgetCreationTracked',
    category: 'diagnostics',
    summary: 'Reports if widget creation tracking is on.',
    detail:
        'Requires `--track-widget-creation`. When true, DevTools can show '
        'where each widget was constructed in source. When false, the '
        'source-jump feature is disabled.',
    sample: 'ext.flutter.inspector.isWidgetCreationTracked',
    params: '{}',
    response: '{ "result": { "type": "bool", "value": true } }',
  ),
  _WiseExtensionEntry(
    name: 'screenshot',
    category: 'screenshot',
    summary: 'Renders a PNG of a subtree.',
    detail:
        'Runs the render tree through `PictureRecorder` to produce a PNG '
        'encoded as base64. DevTools uses this for the "image" preview in '
        'the inspector.',
    sample: 'ext.flutter.inspector.screenshot',
    params: '{ "id": "inspector-12:77", "width": "512", "height": "512" }',
    response: '{ "result": "iVBORw0KGgoAAAANSUhEUgAA... (base64)" }',
  ),
  _WiseExtensionEntry(
    name: 'getLayoutExplorerNode',
    category: 'layout',
    summary: 'Describes one node for the Layout Explorer.',
    detail:
        'Fuels the "Flex / Box" inspector overlay. The payload includes '
        'axis, main-axis alignment, cross-axis alignment, flex factors, '
        'and sizing constraints.',
    sample: 'ext.flutter.inspector.getLayoutExplorerNode',
    params: '{ "arg": "inspector-12:77", "subtreeDepth": "1" }',
    response: '{ "result": { "type": "Flex", "direction": "row" } }',
  ),
  _WiseExtensionEntry(
    name: 'setFlexFit',
    category: 'layout',
    summary: 'Writes a new FlexFit for a Flexible.',
    detail:
        'Layout Explorer lets the user toggle `Flexible` / `Expanded` at '
        'runtime. This wire-call patches the FlexFit so the change is '
        'reflected in the next frame.',
    sample: 'ext.flutter.inspector.setFlexFit',
    params: '{ "id": "inspector-12:77", "flexFit": "tight" }',
    response: '{ "result": { "type": "Success" } }',
  ),
  _WiseExtensionEntry(
    name: 'setFlexFactor',
    category: 'layout',
    summary: 'Writes a new flex factor.',
    detail:
        'Updates the integer flex factor of a Flexible or Expanded. Often '
        'used while dragging the Layout Explorer slider.',
    sample: 'ext.flutter.inspector.setFlexFactor',
    params: '{ "id": "inspector-12:77", "flexFactor": "2" }',
    response: '{ "result": { "type": "Success" } }',
  ),
  _WiseExtensionEntry(
    name: 'setFlexProperties',
    category: 'layout',
    summary: 'Writes axis and alignment at once.',
    detail:
        'Batched update for MainAxisAlignment / CrossAxisAlignment from '
        'the Layout Explorer controls.',
    sample: 'ext.flutter.inspector.setFlexProperties',
    params:
        '{ "id": "inspector-12:77", "mainAxisAlignment": "center", '
        '"crossAxisAlignment": "stretch" }',
    response: '{ "result": { "type": "Success" } }',
  ),
  _WiseExtensionEntry(
    name: 'trackRebuildDirtyWidgets',
    category: 'diagnostics',
    summary: 'Toggles rebuild counter tracking.',
    detail:
        'Enables the per-widget rebuild heatmap in DevTools. Flutter '
        'reports the tally in a service event each frame.',
    sample: 'ext.flutter.inspector.trackRebuildDirtyWidgets',
    params: '{ "enabled": "true" }',
    response: '{ "result": { "type": "Success" } }',
  ),
  _WiseExtensionEntry(
    name: 'trackRepaintWidgets',
    category: 'diagnostics',
    summary: 'Toggles repaint-region tracking.',
    detail:
        'Sibling to trackRebuildDirtyWidgets: tracks which render objects '
        'actually repainted. Pairs with the DevTools "Repaint rainbow".',
    sample: 'ext.flutter.inspector.trackRepaintWidgets',
    params: '{ "enabled": "true" }',
    response: '{ "result": { "type": "Success" } }',
  ),
  _WiseExtensionEntry(
    name: 'structuredErrors',
    category: 'diagnostics',
    summary: 'Turns on structured error reporting.',
    detail:
        'Switches the framework from prose tracebacks to structured JSON '
        'error nodes. DevTools renders these as rich, collapsible panels.',
    sample: 'ext.flutter.inspector.structuredErrors',
    params: '{ "enabled": "true" }',
    response: '{ "result": { "type": "Success" } }',
  ),
  _WiseExtensionEntry(
    name: 'show',
    category: 'diagnostics',
    summary: 'Toggles the on-device inspector overlay.',
    detail:
        'Enables the tap-to-inspect overlay painted on top of the app. '
        'DevTools flips this when the "Select widget" toggle is clicked.',
    sample: 'ext.flutter.inspector.show',
    params: '{ "enabled": "true", "objectGroup": "inspector-12" }',
    response: '{ "result": { "type": "Success" } }',
  ),
];

// ===========================================================================
// ROOT APP
// ===========================================================================
class _WiseApp extends StatelessWidget {
  const _WiseApp();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: _wiseOxblood,
      brightness: Brightness.light,
    ).copyWith(
      primary: _wiseOxbloodDeep,
      secondary: _wiseBlueprint,
      surface: _wiseIvory,
    );
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _wiseIvory,
      fontFamily: 'RobotoMono',
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _wiseInk, height: 1.42),
        titleLarge: TextStyle(
          color: _wiseInk,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
      dividerColor: _wiseParchmentDeep,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const _WiseHome(),
    );
  }
}

// ===========================================================================
// SHELL — scrollable dossier assembled from chapter cards
// ===========================================================================
class _WiseHome extends StatefulWidget {
  const _WiseHome();

  @override
  State<_WiseHome> createState() => _WiseHomeState();
}

class _WiseHomeState extends State<_WiseHome>
    with TickerProviderStateMixin {
  late final AnimationController _pulse;
  late final AnimationController _ticker;
  int _selectedIndex = 14; // getRootWidget by default
  final List<String> _callLog = <String>[
    '[14:02:11] ext.flutter.inspector.isWidgetTreeReady -> true',
    '[14:02:11] ext.flutter.inspector.getRootWidget -> inspector-12:1',
    '[14:02:12] ext.flutter.inspector.getRootWidgetSummaryTree -> ok',
    '[14:02:14] ext.flutter.inspector.setSelectionById -> true',
    '[14:02:14] ext.flutter.inspector.getSelectedWidget -> Padding',
    '[14:02:15] ext.flutter.inspector.getProperties -> 6 items',
    '[14:02:16] ext.flutter.inspector.getChildren -> 2 items',
    '[14:02:20] ext.flutter.inspector.screenshot -> 48 KB PNG',
    '[14:02:22] ext.flutter.inspector.getLayoutExplorerNode -> Flex/row',
    '[14:02:24] ext.flutter.inspector.setFlexFactor -> Success',
  ];

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
  }

  @override
  void dispose() {
    _pulse.dispose();
    _ticker.dispose();
    super.dispose();
  }

  void _select(int index) {
    setState(() {
      _selectedIndex = index;
      final _WiseExtensionEntry entry = _wiseCatalog[index];
      final String stamp = _formatStamp();
      _callLog.insert(0, '[$stamp] ext.flutter.inspector.${entry.name} -> ok');
      if (_callLog.length > 40) {
        _callLog.removeLast();
      }
    });
  }

  String _formatStamp() {
    final DateTime now = DateTime.now();
    final String hh = now.hour.toString().padLeft(2, '0');
    final String mm = now.minute.toString().padLeft(2, '0');
    final String ss = now.second.toString().padLeft(2, '0');
    return '$hh:$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _wiseIvory,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _ticker,
              builder: (BuildContext context, Widget? child) {
                return CustomPaint(
                  painter: _WiseClipboardBackdropPainter(phase: _ticker.value),
                );
              },
            ),
          ),
          Positioned.fill(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 196,
                  backgroundColor: _wiseOxbloodDeep,
                  foregroundColor: _wiseIvory,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _WiseAppBarBackdrop(phase: _ticker),
                    titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    title: const _WiseAppBarTitle(),
                  ),
                ),
                const SliverToBoxAdapter(child: _WiseTableOfContents()),
                const SliverToBoxAdapter(child: _WiseDossierPreamble()),
                SliverToBoxAdapter(
                  child: _WiseCatalogChapter(
                    selected: _selectedIndex,
                    onSelect: _select,
                    pulse: _pulse,
                  ),
                ),
                const SliverToBoxAdapter(child: _WiseCategoryBreakdown()),
                SliverToBoxAdapter(
                  child: _WiseMockDevtoolsConsole(
                    selected: _selectedIndex,
                    onSelect: _select,
                    callLog: _callLog,
                    ticker: _ticker,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _WiseTimelineChapter(phase: _ticker),
                ),
                const SliverToBoxAdapter(child: _WiseRelationshipChapter()),
                const SliverToBoxAdapter(child: _WiseRecipeChapter()),
                const SliverToBoxAdapter(child: _WiseGlossaryChapter()),
                const SliverToBoxAdapter(child: SizedBox(height: 72)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// APP BAR TITLE AND BACKDROP
// ===========================================================================
class _WiseAppBarTitle extends StatelessWidget {
  const _WiseAppBarTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _wiseIvory, width: 1.4),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[_wiseOxblood, _wiseOxbloodDeep],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _wiseOxblood.withValues(alpha: 0.5),
                blurRadius: 14,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text(
            'WI',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: _wiseIvory,
              letterSpacing: 1.4,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Flexible(
          child: Text(
            'WidgetInspectorServiceExtensions — Field Dossier',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: _wiseIvory,
              letterSpacing: 0.25,
            ),
          ),
        ),
      ],
    );
  }
}

class _WiseAppBarBackdrop extends StatelessWidget {
  const _WiseAppBarBackdrop({required this.phase});

  final Animation<double> phase;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: phase,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: _WiseAppBarPainter(phase: phase.value),
        );
      },
    );
  }
}

class _WiseAppBarPainter extends CustomPainter {
  _WiseAppBarPainter({required this.phase});

  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backdrop = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_wiseOxbloodDeep, _wiseOxblood, _wiseOxbloodDeep],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, backdrop);

    final Paint grid = Paint()
      ..color = _wiseIvory.withValues(alpha: 0.07)
      ..strokeWidth = 0.8;
    const double step = 22.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // Connection dot — animated "vm-service connected" indicator
    final double blink = 0.5 + 0.5 * math.sin(phase * math.pi * 2);
    final Paint dot = Paint()
      ..color = _wiseMossPale.withValues(alpha: 0.35 + 0.55 * blink);
    canvas.drawCircle(Offset(size.width - 42, 32), 6, dot);
    final Paint dotCore = Paint()..color = _wiseMoss;
    canvas.drawCircle(Offset(size.width - 42, 32), 3.4, dotCore);

    // Subtle diagonal sweep
    final Paint sweep = Paint()
      ..color = _wiseIvory.withValues(alpha: 0.05);
    final Path sweepPath = Path()
      ..moveTo(-40 + phase * size.width * 1.2, 0)
      ..lineTo(40 + phase * size.width * 1.2, 0)
      ..lineTo(80 + phase * size.width * 1.2, size.height)
      ..lineTo(0 + phase * size.width * 1.2, size.height)
      ..close();
    canvas.drawPath(sweepPath, sweep);
  }

  @override
  bool shouldRepaint(covariant _WiseAppBarPainter oldDelegate) =>
      oldDelegate.phase != phase;
}

// ===========================================================================
// CLIPBOARD BACKDROP PAINTER
// ===========================================================================
class _WiseClipboardBackdropPainter extends CustomPainter {
  _WiseClipboardBackdropPainter({required this.phase});

  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint base = Paint()..color = _wiseIvory;
    canvas.drawRect(Offset.zero & size, base);

    // Paper fibre stippling
    final math.Random rnd = math.Random(17);
    final Paint fibre = Paint()
      ..color = _wiseParchment.withValues(alpha: 0.38)
      ..strokeWidth = 0.6;
    for (int i = 0; i < 420; i++) {
      final double x = rnd.nextDouble() * size.width;
      final double y = rnd.nextDouble() * size.height;
      final double len = 3 + rnd.nextDouble() * 6;
      final double angle = rnd.nextDouble() * math.pi * 2;
      final double dx = math.cos(angle) * len;
      final double dy = math.sin(angle) * len;
      canvas.drawLine(Offset(x, y), Offset(x + dx, y + dy), fibre);
    }

    // Blueprint grid — very faint
    final Paint grid = Paint()
      ..color = _wiseBlueprint.withValues(alpha: 0.07)
      ..strokeWidth = 0.6;
    const double step = 28.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // Coffee-stain ring to sell the notebook look
    final Paint ring = Paint()
      ..color = _wiseBrass.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(
      Offset(size.width * 0.82, size.height * 0.18),
      46,
      ring,
    );

    // Slow glide highlight
    final double glide = phase;
    final Paint highlight = Paint()
      ..color = _wiseIvorySoft.withValues(alpha: 0.45);
    canvas.drawCircle(
      Offset(size.width * glide, size.height * 0.6),
      110,
      highlight,
    );
  }

  @override
  bool shouldRepaint(covariant _WiseClipboardBackdropPainter oldDelegate) =>
      oldDelegate.phase != phase;
}

// ===========================================================================
// TABLE OF CONTENTS
// ===========================================================================
class _WiseTableOfContents extends StatelessWidget {
  const _WiseTableOfContents();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: _WiseSheet(
        title: 'Dossier contents',
        subtitle: 'Eight chapters — follow them in order or jump around',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            _WiseTocLine(index: '01', label: 'Preamble — what the enum names'),
            _WiseTocLine(index: '02', label: 'Enum catalog — every wire name'),
            _WiseTocLine(index: '03', label: 'Category breakdown'),
            _WiseTocLine(index: '04', label: 'Mock DevTools console'),
            _WiseTocLine(index: '05', label: 'Timeline of a service call'),
            _WiseTocLine(index: '06', label: 'Relationship with the service class'),
            _WiseTocLine(index: '07', label: 'Recipes for callers and testers'),
            _WiseTocLine(index: '08', label: 'Glossary and epilogue'),
          ],
        ),
      ),
    );
  }
}

class _WiseTocLine extends StatelessWidget {
  const _WiseTocLine({required this.index, required this.label});

  final String index;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Container(
            width: 34,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _wiseOxblood,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              index,
              style: const TextStyle(
                color: _wiseIvory,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _wiseInk,
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: 1,
            width: 40,
            color: _wiseParchmentDeep,
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// REUSABLE SHEETS AND PRIMITIVES
// ===========================================================================
class _WiseSheet extends StatelessWidget {
  const _WiseSheet({
    required this.title,
    required this.child,
    this.subtitle,
    this.accent = _wiseOxblood,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: _wiseIvorySoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _wiseParchmentDeep, width: 1),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x1A24201A),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
            decoration: BoxDecoration(
              color: _wiseParchment,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              border: Border(
                bottom: BorderSide(color: _wiseParchmentDeep, width: 1),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 26,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: _wiseInk,
                          letterSpacing: 0.3,
                        ),
                      ),
                      if (subtitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            subtitle!,
                            style: const TextStyle(
                              color: _wiseGraphiteSoft,
                              fontSize: 11.5,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                _WisePunchedHole(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _WisePunchedHole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: _wiseIvory,
        shape: BoxShape.circle,
        border: Border.all(color: _wiseParchmentDeep, width: 1),
      ),
    );
  }
}

class _WiseCodeBlock extends StatelessWidget {
  const _WiseCodeBlock({required this.code, this.tint = _wiseBlueprintDeep});

  final String code;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _wiseBlueprint, width: 1),
      ),
      child: Text(
        code,
        style: const TextStyle(
          color: _wiseIvorySoft,
          fontFamily: 'RobotoMono',
          fontSize: 11.5,
          height: 1.35,
        ),
      ),
    );
  }
}

class _WisePill extends StatelessWidget {
  const _WisePill({
    required this.label,
    required this.color,
    this.textColor = _wiseInk,
    this.dense = false,
  });

  final String label;
  final Color color;
  final Color textColor;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? 6 : 9,
        vertical: dense ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: _wiseInk.withValues(alpha: 0.12), width: 0.8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: dense ? 10 : 11,
          fontWeight: FontWeight.w700,
          color: textColor,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class _WiseFact extends StatelessWidget {
  const _WiseFact({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: _wiseGraphite,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12.5,
                color: _wiseInk,
                height: 1.38,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Color _wiseCategoryColor(String category) {
  switch (category) {
    case 'lifecycle':
      return _wiseOxbloodPale;
    case 'selection':
      return _wiseBlueprintPale;
    case 'tree':
      return _wiseMossPale;
    case 'properties':
      return _wiseBrassPale;
    case 'layout':
      return _wiseParchment;
    case 'screenshot':
      return _wiseIvoryEdge;
    case 'diagnostics':
      return _wiseOxbloodPale;
    default:
      return _wiseChalk;
  }
}

Color _wiseCategoryAccent(String category) {
  switch (category) {
    case 'lifecycle':
      return _wiseOxblood;
    case 'selection':
      return _wiseBlueprint;
    case 'tree':
      return _wiseMoss;
    case 'properties':
      return _wiseBrass;
    case 'layout':
      return _wiseGraphite;
    case 'screenshot':
      return _wiseGraphiteSoft;
    case 'diagnostics':
      return _wiseOxbloodDeep;
    default:
      return _wiseInk;
  }
}

// ===========================================================================
// CHAPTER 01 — DOSSIER PREAMBLE
// ===========================================================================
class _WiseDossierPreamble extends StatelessWidget {
  const _WiseDossierPreamble();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Column(
        children: <Widget>[
          _WiseSheet(
            title: 'Chapter 01 — What is WidgetInspectorServiceExtensions',
            subtitle: 'A canonical list of wire names',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'WidgetInspectorServiceExtensions is a plain Dart enum declared in '
                  'package:flutter/src/widgets/widget_inspector.dart. Its members do '
                  'nothing on their own. What matters is each member has a wire-level '
                  '`name` string — and those strings define the protocol that Flutter '
                  'DevTools uses to poke the widget tree at runtime.',
                  style: TextStyle(color: _wiseInk, fontSize: 13, height: 1.46),
                ),
                SizedBox(height: 10),
                _WiseFact(
                  label: 'Kind',
                  value: 'enum, 28 members, no fields other than inherited name',
                ),
                _WiseFact(
                  label: 'Declared in',
                  value: 'widgets/widget_inspector.dart',
                ),
                _WiseFact(
                  label: 'Used by',
                  value: 'WidgetInspectorService.initServiceExtensions',
                ),
                _WiseFact(
                  label: 'Consumed by',
                  value: 'Flutter DevTools, IDE plugins, custom tooling',
                ),
              ],
            ),
          ),
          _WiseSheet(
            title: 'Chapter 01 / 02 — Service extensions in one paragraph',
            subtitle: 'The VM service endpoint convention',
            accent: _wiseBlueprint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Dart VMs expose a service protocol over WebSocket. Flutter registers '
                  'hundreds of "extension methods" on that protocol, each keyed by a '
                  'dotted string such as ext.flutter.inspector.getRootWidget. Tooling '
                  'calls an extension by name and receives a JSON reply. This enum is '
                  'the whitelist of every inspector-side endpoint.',
                  style: TextStyle(color: _wiseInk, fontSize: 13, height: 1.46),
                ),
                const SizedBox(height: 8),
                const _WiseCodeBlock(
                  code:
                      '// Registration — done once during app startup\n'
                      'registerServiceExtension(\n'
                      '  name: WidgetInspectorServiceExtensions.getRootWidget.name,\n'
                      '  callback: _getRootWidget,\n'
                      ');',
                ),
                const SizedBox(height: 4),
                const _WiseCodeBlock(
                  code:
                      '// Wire-level — what DevTools sends\n'
                      '{\n'
                      '  "method": "ext.flutter.inspector.getRootWidget",\n'
                      '  "params": { "objectGroup": "inspector-12" }\n'
                      '}',
                  tint: _wiseGraphite,
                ),
              ],
            ),
          ),
          _WiseSheet(
            title: 'Chapter 01 / 03 — Why use an enum',
            subtitle: 'Type-safe names, not magic strings',
            accent: _wiseMoss,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Flutter could register the extensions with hand-typed string '
                  'literals, but that invites typos and drift. Using an enum keeps the '
                  'catalog discoverable in an IDE: a developer who needs a service '
                  'extension can type WidgetInspectorServiceExtensions. and auto-'
                  'complete will list the full set. Each enum value’s `name` getter '
                  'returns the identifier exactly as written in source.',
                  style: TextStyle(color: _wiseInk, fontSize: 13, height: 1.46),
                ),
                SizedBox(height: 8),
                Text(
                  '"getRootWidget" and WidgetInspectorServiceExtensions.getRootWidget.name '
                  'are guaranteed to match because the Dart enum name is the source of '
                  'truth for both the Dart API and the wire protocol.',
                  style: TextStyle(
                    color: _wiseGraphite,
                    fontSize: 12.5,
                    fontStyle: FontStyle.italic,
                    height: 1.42,
                  ),
                ),
              ],
            ),
          ),
          _WiseSheet(
            title: 'Chapter 01 / 04 — DevTools is just a client',
            subtitle: 'Anyone who speaks the service protocol can call these',
            accent: _wiseBlueprintDeep,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'DevTools is the headline consumer, but any tool speaking the Dart '
                  'VM service can invoke these endpoints: IDE plugins, CI agents, test '
                  'harnesses, or the `dart devtools` CLI bridge. The inspector enum is '
                  'essentially a public API — breaking its members or renaming them '
                  'breaks every external tool.',
                  style: TextStyle(color: _wiseInk, fontSize: 13, height: 1.46),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const <Widget>[
                    _WisePill(label: 'Flutter DevTools', color: _wiseBlueprintPale),
                    SizedBox(width: 6),
                    _WisePill(label: 'IntelliJ plugin', color: _wiseParchment),
                    SizedBox(width: 6),
                    _WisePill(label: 'VS Code Flutter', color: _wiseMossPale),
                    SizedBox(width: 6),
                    _WisePill(label: 'CI harness', color: _wiseBrassPale),
                  ],
                ),
              ],
            ),
          ),
          _WiseSheet(
            title: 'Chapter 01 / 05 — Lifetime and object groups',
            subtitle: 'Where the "inspector-12" strings come from',
            accent: _wiseBrass,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Most tree-walk extensions accept an `objectGroup` parameter. DevTools '
                  'creates a group per panel or per interaction and passes it along '
                  'with every call. Flutter keeps weak references to the inspected '
                  'nodes under that group key, so disposeGroup or disposeAllGroups can '
                  'free memory cleanly once the client is done.',
                  style: TextStyle(color: _wiseInk, fontSize: 13, height: 1.46),
                ),
                SizedBox(height: 6),
                _WiseFact(label: 'Typical name', value: 'inspector-0, inspector-12'),
                _WiseFact(label: 'Bucket of', value: 'InspectorReferenceData ids'),
                _WiseFact(label: 'Released by', value: 'disposeGroup / disposeAllGroups'),
              ],
            ),
          ),
          _WiseSheet(
            title: 'Chapter 01 / 06 — Names are the contract',
            subtitle: 'This enum _is_ the inspector protocol',
            accent: _wiseOxbloodDeep,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Every bit of documentation and every external tool keys off the '
                  'string names declared here. The Dart class that implements the '
                  'actual behaviour — WidgetInspectorService — binds those names to '
                  'callbacks. Think of this enum as a table of contents and '
                  'WidgetInspectorService as the book.',
                  style: TextStyle(color: _wiseInk, fontSize: 13, height: 1.46),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// CHAPTER 02 — FULL ENUM CATALOG
// ===========================================================================
class _WiseCatalogChapter extends StatelessWidget {
  const _WiseCatalogChapter({
    required this.selected,
    required this.onSelect,
    required this.pulse,
  });

  final int selected;
  final ValueChanged<int> onSelect;
  final AnimationController pulse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: _WiseSheet(
        title: 'Chapter 02 — Full enum catalog',
        subtitle: 'Every WidgetInspectorServiceExtensions member with wire call',
        accent: _wiseOxbloodDeep,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Tap any entry to wire it into the mock DevTools console below. '
              'The selected entry gets a pulsing ivory halo — a small wink '
              'that DevTools uses a similar highlight while resolving a live '
              'inspector id.',
              style: TextStyle(
                color: _wiseGraphite,
                fontSize: 12.5,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            for (int i = 0; i < _wiseCatalog.length; i++)
              _WiseCatalogRow(
                index: i,
                entry: _wiseCatalog[i],
                selected: selected == i,
                onTap: () => onSelect(i),
                pulse: pulse,
              ),
          ],
        ),
      ),
    );
  }
}

class _WiseCatalogRow extends StatelessWidget {
  const _WiseCatalogRow({
    required this.index,
    required this.entry,
    required this.selected,
    required this.onTap,
    required this.pulse,
  });

  final int index;
  final _WiseExtensionEntry entry;
  final bool selected;
  final VoidCallback onTap;
  final AnimationController pulse;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulse,
      builder: (BuildContext context, Widget? child) {
        final double halo = selected
            ? (0.35 + 0.35 * math.sin(pulse.value * math.pi))
            : 0.0;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: selected ? _wiseIvorySoft : _wiseChalk,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected
                  ? _wiseOxblood.withValues(alpha: 0.7 + halo * 0.3)
                  : _wiseParchmentDeep,
              width: selected ? 1.6 : 1,
            ),
            boxShadow: selected
                ? <BoxShadow>[
                    BoxShadow(
                      color: _wiseIvorySoft.withValues(alpha: halo),
                      blurRadius: 18,
                      spreadRadius: 2,
                    ),
                  ]
                : const <BoxShadow>[],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 32,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _wiseInk,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            (index + 1).toString().padLeft(2, '0'),
                            style: const TextStyle(
                              color: _wiseIvory,
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            entry.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: _wiseInk,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                        _WisePill(
                          label: entry.category,
                          color: _wiseCategoryColor(entry.category),
                          textColor: _wiseCategoryAccent(entry.category),
                          dense: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      entry.summary,
                      style: const TextStyle(
                        color: _wiseGraphite,
                        fontSize: 12.2,
                        height: 1.35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      entry.detail,
                      style: const TextStyle(
                        color: _wiseInk,
                        fontSize: 11.8,
                        height: 1.42,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _WiseCodeBlock(code: entry.sample),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ===========================================================================
// CHAPTER 03 — CATEGORY BREAKDOWN
// ===========================================================================
class _WiseCategoryBreakdown extends StatelessWidget {
  const _WiseCategoryBreakdown();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: _WiseSheet(
        title: 'Chapter 03 — Category breakdown',
        subtitle: 'Each cluster of extensions serves a distinct DevTools panel',
        accent: _wiseMoss,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _WiseCategoryCard(
              title: 'Lifecycle',
              members: 'disposeAllGroups · disposeGroup · isWidgetTreeReady · disposeId',
              color: _wiseOxbloodPale,
              accent: _wiseOxblood,
              body:
                  'These endpoints manage the memory Flutter holds on behalf of '
                  'DevTools. Every piece of information DevTools fetches is '
                  'bucketed under an object group; lifecycle extensions let the '
                  'client open, close, and trim those buckets. Without them, '
                  'hot reload and long debug sessions would leak elements.',
              bullets: const <String>[
                'Called when a DevTools panel opens (implicitly) and closes.',
                'Called eagerly after hot reload to invalidate stale ids.',
                'Cheap — most dispose calls release weak references only.',
                'isWidgetTreeReady gates the entire inspector UX.',
              ],
            ),
            _WiseCategoryCard(
              title: 'Selection',
              members: 'setSelectionById · getSelectedWidget · getSelectedSummaryWidget',
              color: _wiseBlueprintPale,
              accent: _wiseBlueprint,
              body:
                  'Selection is the bidirectional link between the on-device '
                  'overlay and the DevTools UI. Tapping a widget in either '
                  'place updates a single focused element reference on the '
                  'framework side; getters then read it back.',
              bullets: const <String>[
                'Tap in DevTools → setSelectionById travels to the VM.',
                'Tap on device → service event pushes the new selection.',
                'Summary variant filters to user-authored ancestors.',
                'Selection survives rebuilds via inspector-*:* ids.',
              ],
            ),
            _WiseCategoryCard(
              title: 'Tree traversal',
              members: 'getParentChain · getChildren · getChildrenSummaryTree · '
                  'getChildrenDetailsSubtree · getRootWidget · getRootWidgetSummaryTree · '
                  'getRootWidgetSummaryTreeWithPreviews',
              color: _wiseMossPale,
              accent: _wiseMoss,
              body:
                  'The DevTools tree view is a lazy walk. Expanding a node issues '
                  'a getChildren* call; opening the inspector issues a '
                  'getRootWidget*. Summary variants filter out framework-only '
                  'widgets to keep the user-facing tree digestible.',
              bullets: const <String>[
                'getChildren vs getChildrenSummaryTree: full vs curated view.',
                'getChildrenDetailsSubtree: paged deep-fetch for big subtrees.',
                'getParentChain: produces the breadcrumb side-panel.',
                'Previews variant inlines Text content without a second round-trip.',
              ],
            ),
            _WiseCategoryCard(
              title: 'Property inspection',
              members: 'getProperties',
              color: _wiseBrassPale,
              accent: _wiseBrass,
              body:
                  'DevTools fills its "Details" panel by walking the DiagnosticsNode '
                  'of the selected widget. getProperties serializes the list of '
                  'DiagnosticsProperty objects into plain JSON. Colors become hex '
                  'strings, paddings become EdgeInsets descriptions, flex factors '
                  'become numbers.',
              bullets: const <String>[
                'Runs debugFillProperties under the hood.',
                'Output includes type, default, and whether the value is "interesting".',
                'Hooked into DevTools filters: hide defaults, show only custom.',
              ],
            ),
            _WiseCategoryCard(
              title: 'Layout Explorer',
              members: 'getLayoutExplorerNode · setFlexFit · setFlexFactor · setFlexProperties',
              color: _wiseParchment,
              accent: _wiseGraphite,
              body:
                  'The Layout Explorer is the interactive flex / box overlay in '
                  'DevTools. It reads the geometry and parent constraints with '
                  'getLayoutExplorerNode and writes changes back through the '
                  'setFlex* extensions — so the developer can fiddle with flex '
                  'factors at runtime and watch the layout adapt.',
              bullets: const <String>[
                'Works with Row, Column, and Flex subclasses.',
                'setFlexProperties batches alignment changes for a responsive feel.',
                'Subtree depth parameter controls how much context comes back.',
                'Changes survive until the next rebuild resets state.',
              ],
            ),
            _WiseCategoryCard(
              title: 'Diagnostics and rendering toggles',
              members: 'setPubRootDirectories · addPubRootDirectories · '
                  'removePubRootDirectories · getPubRootDirectories · '
                  'isWidgetCreationTracked · trackRebuildDirtyWidgets · '
                  'trackRepaintWidgets · structuredErrors · show',
              color: _wiseOxbloodPale,
              accent: _wiseOxbloodDeep,
              body:
                  'The long-tail extensions: configuration switches, visualization '
                  'toggles, and meta-queries. They change how the framework behaves '
                  'while DevTools is connected — enabling rebuild heatmaps, '
                  'structured error JSON, or the tap-to-select overlay.',
              bullets: const <String>[
                'pubRoot* endpoints maintain a "this is user code" allow-list.',
                'trackRebuildDirtyWidgets and trackRepaintWidgets power heatmaps.',
                'structuredErrors rewires FlutterErrorDetails reporting.',
                '"show" is the on-device select-widget overlay toggle.',
              ],
            ),
            _WiseCategoryCard(
              title: 'Screenshots',
              members: 'screenshot',
              color: _wiseIvoryEdge,
              accent: _wiseGraphite,
              body:
                  'The single screenshot endpoint lets DevTools snapshot any '
                  'widget subtree as a PNG. Used for the "live preview" thumbnail '
                  'in the inspector, and for generating golden-style reports in '
                  'CI dashboards.',
              bullets: const <String>[
                'Encoded as base64 PNG in the JSON response.',
                'Accepts target width / height and margin.',
                'Runs through PictureRecorder — not a platform screenshot.',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WiseCategoryCard extends StatelessWidget {
  const _WiseCategoryCard({
    required this.title,
    required this.members,
    required this.color,
    required this.accent,
    required this.body,
    required this.bullets,
  });

  final String title;
  final String members;
  final Color color;
  final Color accent;
  final String body;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.55), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 28,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            members,
            style: const TextStyle(
              color: _wiseGraphite,
              fontSize: 11.5,
              fontFamily: 'RobotoMono',
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(color: _wiseInk, fontSize: 12.5, height: 1.45),
          ),
          const SizedBox(height: 8),
          for (final String b in bullets)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 6, right: 8),
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        color: _wiseInk,
                        fontSize: 12,
                        height: 1.4,
                      ),
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

// ===========================================================================
// CHAPTER 04 — MOCK DEVTOOLS CONSOLE
// ===========================================================================
class _WiseMockDevtoolsConsole extends StatelessWidget {
  const _WiseMockDevtoolsConsole({
    required this.selected,
    required this.onSelect,
    required this.callLog,
    required this.ticker,
  });

  final int selected;
  final ValueChanged<int> onSelect;
  final List<String> callLog;
  final AnimationController ticker;

  @override
  Widget build(BuildContext context) {
    final _WiseExtensionEntry entry = _wiseCatalog[selected];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: _WiseSheet(
        title: 'Chapter 04 — Mock DevTools console',
        subtitle: 'Pick a member, watch the fake request/response roll in',
        accent: _wiseBlueprint,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text(
                  'method',
                  style: TextStyle(
                    color: _wiseGraphite,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: _wiseChalk,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _wiseParchmentDeep,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      entry.sample,
                      style: const TextStyle(
                        color: _wiseOxbloodDeep,
                        fontWeight: FontWeight.w800,
                        fontSize: 12.5,
                        fontFamily: 'RobotoMono',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                _WisePill(
                  label: entry.category,
                  color: _wiseCategoryColor(entry.category),
                  textColor: _wiseCategoryAccent(entry.category),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _wiseCatalog.length,
                separatorBuilder: (BuildContext ctx, int i) =>
                    const SizedBox(width: 6),
                itemBuilder: (BuildContext ctx, int i) {
                  final bool isSelected = i == selected;
                  final _WiseExtensionEntry e = _wiseCatalog[i];
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => onSelect(i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _wiseOxbloodDeep
                              : _wiseCategoryColor(e.category),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? _wiseOxblood
                                : _wiseCategoryAccent(e.category)
                                    .withValues(alpha: 0.5),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          e.name,
                          style: TextStyle(
                            color: isSelected ? _wiseIvory : _wiseInk,
                            fontWeight: FontWeight.w700,
                            fontSize: 11.5,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: _WiseConsoleColumn(
                    title: 'Request',
                    subtitle: 'outgoing →',
                    tint: _wiseBlueprintDeep,
                    code: _wiseFormatRequest(entry),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _WiseConsoleColumn(
                    title: 'Response',
                    subtitle: '← incoming',
                    tint: _wiseGraphite,
                    code: _wiseFormatResponse(entry),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: _wiseInk,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _wiseShadow, width: 1),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: ticker,
                        builder: (BuildContext ctx, Widget? child) {
                          final double blink = 0.4 +
                              0.6 *
                                  (0.5 + 0.5 * math.sin(ticker.value * math.pi * 2));
                          return Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color:
                                  _wiseMossPale.withValues(alpha: blink),
                              shape: BoxShape.circle,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'session.log',
                        style: TextStyle(
                          color: _wiseIvory,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${callLog.length} entries',
                        style: const TextStyle(
                          color: _wiseIvorySoft,
                          fontSize: 11,
                          fontFamily: 'RobotoMono',
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: _wiseShadow, height: 16),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      itemCount: callLog.length,
                      itemBuilder: (BuildContext ctx, int i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Text(
                            callLog[i],
                            style: TextStyle(
                              color: i == 0
                                  ? _wiseMossPale
                                  : _wiseIvorySoft.withValues(alpha: 0.85),
                              fontSize: 11.5,
                              fontFamily: 'RobotoMono',
                              fontWeight:
                                  i == 0 ? FontWeight.w700 : FontWeight.w400,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _wiseFormatRequest(_WiseExtensionEntry entry) {
  return '{\n'
      '  "jsonrpc": "2.0",\n'
      '  "id": 42,\n'
      '  "method": "${entry.sample}",\n'
      '  "params": ${entry.params}\n'
      '}';
}

String _wiseFormatResponse(_WiseExtensionEntry entry) {
  return '{\n'
      '  "jsonrpc": "2.0",\n'
      '  "id": 42,\n'
      '  "method": "${entry.sample}",\n'
      '  "response": ${entry.response}\n'
      '}';
}

class _WiseConsoleColumn extends StatelessWidget {
  const _WiseConsoleColumn({
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.code,
  });

  final String title;
  final String subtitle;
  final Color tint;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _wiseBlueprint, width: 1),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: _wiseIvorySoft,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                subtitle,
                style: TextStyle(
                  color: _wiseBlueprintPale.withValues(alpha: 0.9),
                  fontSize: 10.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            code,
            style: const TextStyle(
              color: _wiseIvorySoft,
              fontSize: 11,
              fontFamily: 'RobotoMono',
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// CHAPTER 05 — TIMELINE DIAGRAM
// ===========================================================================
class _WiseTimelineChapter extends StatelessWidget {
  const _WiseTimelineChapter({required this.phase});

  final Animation<double> phase;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: _WiseSheet(
        title: 'Chapter 05 — Timeline of a service call',
        subtitle: 'DevTools → ext.flutter.inspector.X → service handler → JSON',
        accent: _wiseBlueprintDeep,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Every extension name in the enum travels the same rail. The '
              'diagram below reads left-to-right: a DevTools client emits a '
              'method call, the VM dispatcher maps that method name to a Dart '
              'callback, WidgetInspectorService produces a serialized reply, '
              'and the result returns back to the client over the VM service.',
              style: TextStyle(color: _wiseInk, fontSize: 13, height: 1.46),
            ),
            const SizedBox(height: 10),
            AspectRatio(
              aspectRatio: 2.1,
              child: AnimatedBuilder(
                animation: phase,
                builder: (BuildContext ctx, Widget? child) {
                  return CustomPaint(
                    painter: _WiseTimelinePainter(phase: phase.value),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const _WiseTimelineStep(
              step: '01',
              label: 'DevTools composes JSON-RPC',
              body:
                  'A user action fires off a request like '
                  '{ method: "ext.flutter.inspector.getRootWidget", params: ... }. '
                  'DevTools never touches Dart directly — it speaks the VM service '
                  'over WebSocket.',
            ),
            _WiseTimelineStep(
              step: '02',
              label: 'VM service dispatches',
              body:
                  'The Dart VM finds the registered extension by exact name, which '
                  'matches one of the WidgetInspectorServiceExtensions enum values.',
            ),
            _WiseTimelineStep(
              step: '03',
              label: 'WidgetInspectorService handles it',
              body:
                  'The bound Dart callback runs on the UI isolate. It walks the '
                  'element tree, reads DiagnosticsNodes, or updates selection — '
                  'then wraps the result with inspector-* ids under an object group.',
            ),
            _WiseTimelineStep(
              step: '04',
              label: 'JSON serialization',
              body:
                  'The service uses InspectorSerializationDelegate to turn Dart '
                  'objects into stable JSON. Every field name, every numeric id, '
                  'and every type hint becomes part of the wire contract.',
            ),
            _WiseTimelineStep(
              step: '05',
              label: 'Response ships back',
              body:
                  'The VM service sends the JSON reply back over the same '
                  'WebSocket frame id. DevTools renders it in whatever panel '
                  'triggered the request.',
            ),
          ],
        ),
      ),
    );
  }
}

class _WiseTimelineStep extends StatelessWidget {
  const _WiseTimelineStep({
    required this.step,
    required this.label,
    required this.body,
  });

  final String step;
  final String label;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _wiseChalk,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _wiseParchmentDeep, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _wiseBlueprintDeep,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              step,
              style: const TextStyle(
                color: _wiseIvory,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    color: _wiseInk,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: _wiseGraphite,
                    fontSize: 12,
                    height: 1.44,
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

class _WiseTimelinePainter extends CustomPainter {
  _WiseTimelinePainter({required this.phase});

  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _wiseBlueprintDeep;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(10)),
      bg,
    );

    final Paint grid = Paint()
      ..color = _wiseIvory.withValues(alpha: 0.06)
      ..strokeWidth = 0.6;
    const double step = 20;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final double laneY = size.height * 0.5;
    const int nodes = 5;
    final double laneLeft = 40;
    final double laneRight = size.width - 40;
    final double spacing = (laneRight - laneLeft) / (nodes - 1);

    // The rail
    final Paint rail = Paint()
      ..color = _wiseIvorySoft.withValues(alpha: 0.35)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(laneLeft, laneY), Offset(laneRight, laneY), rail);

    // Moving packet
    final double packetX = laneLeft + phase * (laneRight - laneLeft);
    final Paint glow = Paint()
      ..color = _wiseBrassPale.withValues(alpha: 0.4);
    canvas.drawCircle(Offset(packetX, laneY), 12, glow);
    final Paint packet = Paint()..color = _wiseBrass;
    canvas.drawCircle(Offset(packetX, laneY), 6, packet);

    final List<String> labels = <String>[
      'DevTools',
      'VM service',
      'inspector.X',
      'Service impl',
      'JSON reply',
    ];

    final Paint nodeFill = Paint()..color = _wiseIvorySoft;
    final Paint nodeStroke = Paint()
      ..color = _wiseOxblood
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    for (int i = 0; i < nodes; i++) {
      final double cx = laneLeft + spacing * i;
      final Rect rect = Rect.fromCenter(
        center: Offset(cx, laneY),
        width: 80,
        height: 28,
      );
      final RRect rrect = RRect.fromRectAndRadius(
        rect,
        const Radius.circular(6),
      );
      canvas.drawRRect(rrect, nodeFill);
      canvas.drawRRect(rrect, nodeStroke);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
            color: _wiseInk,
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
            fontFamily: 'RobotoMono',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(cx - tp.width / 2, laneY - tp.height / 2));

      // Step number above
      final TextPainter step = TextPainter(
        text: TextSpan(
          text: '0${i + 1}',
          style: const TextStyle(
            color: _wiseBrass,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            fontFamily: 'RobotoMono',
            letterSpacing: 1.0,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      step.paint(canvas, Offset(cx - step.width / 2, laneY - 28));
    }

    // Arrows between nodes
    final Paint arrow = Paint()
      ..color = _wiseIvorySoft.withValues(alpha: 0.7)
      ..strokeWidth = 1.4;
    for (int i = 0; i < nodes - 1; i++) {
      final double x1 = laneLeft + spacing * i + 40;
      final double x2 = laneLeft + spacing * (i + 1) - 40;
      canvas.drawLine(Offset(x1, laneY), Offset(x2, laneY), arrow);
      // Arrowhead
      final Path head = Path()
        ..moveTo(x2, laneY)
        ..lineTo(x2 - 6, laneY - 4)
        ..lineTo(x2 - 6, laneY + 4)
        ..close();
      canvas.drawPath(head, Paint()..color = _wiseBrass);
    }

    // Bottom legend
    final TextPainter legend = TextPainter(
      text: const TextSpan(
        text: 'one frame of the ext.flutter.inspector.* call rail',
        style: TextStyle(
          color: _wiseIvorySoft,
          fontSize: 10.5,
          fontStyle: FontStyle.italic,
          fontFamily: 'RobotoMono',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    legend.paint(
      canvas,
      Offset(size.width / 2 - legend.width / 2, size.height - 20),
    );
  }

  @override
  bool shouldRepaint(covariant _WiseTimelinePainter oldDelegate) =>
      oldDelegate.phase != phase;
}

// ===========================================================================
// CHAPTER 06 — RELATIONSHIP WITH WidgetInspectorService
// ===========================================================================
class _WiseRelationshipChapter extends StatelessWidget {
  const _WiseRelationshipChapter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Column(
        children: <Widget>[
          _WiseSheet(
            title: 'Chapter 06 — Enum vs service class',
            subtitle: 'Names here, handlers there',
            accent: _wiseBrass,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'WidgetInspectorServiceExtensions and WidgetInspectorService are '
                  'a classic name/implementation split. The enum defines the wire '
                  'vocabulary — essentially a table of strings — and the service '
                  'class binds each of those strings to a Dart function that '
                  'produces a reply.',
                  style: TextStyle(color: _wiseInk, fontSize: 13, height: 1.46),
                ),
                SizedBox(height: 10),
                _WiseTwoColumnRow(
                  left: 'WidgetInspectorServiceExtensions (this enum)',
                  leftBody:
                      '• Declares every inspector wire name in one place.\n'
                      '• Zero runtime logic; its only job is to carry a name.\n'
                      '• Changes here break tooling — rename with care.',
                  right: 'WidgetInspectorService (the service class)',
                  rightBody:
                      '• Registers each name during initServiceExtensions.\n'
                      '• Owns state: selection cursor, object groups, toggles.\n'
                      '• Produces JSON payloads via serialization delegates.',
                ),
              ],
            ),
          ),
          _WiseSheet(
            title: 'Chapter 06 / 02 — Registration pattern',
            subtitle: 'Each enum value pairs with one callback',
            accent: _wiseBlueprint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _WiseCodeBlock(
                  code:
                      'void _register(WidgetInspectorServiceExtensions ext, '
                      'ServiceExtensionCallback cb) {\n'
                      '  registerServiceExtension(\n'
                      '    name: ext.name,\n'
                      '    callback: cb,\n'
                      '  );\n'
                      '}\n\n'
                      '_register(\n'
                      '  WidgetInspectorServiceExtensions.getRootWidget,\n'
                      '  _getRootWidget,\n'
                      ');\n'
                      '_register(\n'
                      '  WidgetInspectorServiceExtensions.setSelectionById,\n'
                      '  _setSelectionById,\n'
                      ');',
                ),
                SizedBox(height: 6),
                Text(
                  'This tight loop over the enum values is what guarantees every '
                  'member actually has a handler. Adding a member to the enum '
                  'without wiring a callback is a visible gap.',
                  style: TextStyle(
                    color: _wiseGraphite,
                    fontSize: 12.5,
                    fontStyle: FontStyle.italic,
                    height: 1.42,
                  ),
                ),
              ],
            ),
          ),
          _WiseSheet(
            title: 'Chapter 06 / 03 — What the enum does NOT do',
            subtitle: 'Separation of responsibilities',
            accent: _wiseOxblood,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'It is tempting to think of the enum as "the inspector API". It '
                  'is not. It is only the list of names. Trying to derive '
                  'behaviour from the enum — for example by pattern-matching on '
                  'its members — is almost always a code smell.',
                  style: TextStyle(color: _wiseInk, fontSize: 13, height: 1.46),
                ),
                SizedBox(height: 8),
                _WiseFact(
                  label: 'Does NOT hold',
                  value: 'Element references, selection ids, or object groups.',
                ),
                _WiseFact(
                  label: 'Does NOT decide',
                  value: 'Whether a feature is enabled at runtime.',
                ),
                _WiseFact(
                  label: 'Does NOT dispatch',
                  value: 'Messages — the VM service does that.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WiseTwoColumnRow extends StatelessWidget {
  const _WiseTwoColumnRow({
    required this.left,
    required this.leftBody,
    required this.right,
    required this.rightBody,
  });

  final String left;
  final String leftBody;
  final String right;
  final String rightBody;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _WiseTwoColumnCell(title: left, body: leftBody, tint: _wiseBlueprintPale),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _WiseTwoColumnCell(title: right, body: rightBody, tint: _wiseMossPale),
        ),
      ],
    );
  }
}

class _WiseTwoColumnCell extends StatelessWidget {
  const _WiseTwoColumnCell({
    required this.title,
    required this.body,
    required this.tint,
  });

  final String title;
  final String body;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _wiseParchmentDeep, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 12.5,
              color: _wiseInk,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              color: _wiseGraphite,
              fontSize: 11.8,
              height: 1.4,
              fontFamily: 'RobotoMono',
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// CHAPTER 07 — RECIPE CARDS
// ===========================================================================
class _WiseRecipeChapter extends StatelessWidget {
  const _WiseRecipeChapter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: _WiseSheet(
        title: 'Chapter 07 — Field recipes',
        subtitle: 'Five patterns for using these extensions in practice',
        accent: _wiseMoss,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _WiseRecipeCard(
              number: 'R1',
              title: 'Resolve the root widget from a test harness',
              body:
                  'An integration test that wants to assert about the live '
                  'widget tree can open a VM service connection, call '
                  'ext.flutter.inspector.getRootWidget, and recursively '
                  'expand children. The returned valueIds are stable per '
                  'object group, so the test can pin them across frames.',
              code:
                  '// pseudo-code — what a test harness would send\n'
                  '{\n'
                  '  "method": "ext.flutter.inspector.getRootWidget",\n'
                  '  "params": { "objectGroup": "test-group-7" }\n'
                  '}',
            ),
            _WiseRecipeCard(
              number: 'R2',
              title: 'Cycle object groups between phases of a script',
              body:
                  'Long-running DevTools sessions (or scripted inspectors) should '
                  'ring-buffer their object groups. Create a new group for each '
                  'exploration pass, then drop the previous one with '
                  'disposeGroup to keep the reference table bounded.',
              code:
                  'final String g = "auto-\${DateTime.now().millisecondsSinceEpoch}";\n'
                  'call("getRootWidget", { "objectGroup": g });\n'
                  '// ... later ...\n'
                  'call("disposeGroup", { "objectGroup": g });',
            ),
            _WiseRecipeCard(
              number: 'R3',
              title: 'Drive the Layout Explorer from a script',
              body:
                  'Automate layout tweaks in CI by calling '
                  'ext.flutter.inspector.setFlexProperties with target values, '
                  'then calling screenshot to capture the result. This is how '
                  'golden-style Layout Explorer regressions are caught without '
                  'opening DevTools.',
              code:
                  '{\n'
                  '  "method": "ext.flutter.inspector.setFlexProperties",\n'
                  '  "params": {\n'
                  '    "id": "inspector-ci:42",\n'
                  '    "mainAxisAlignment": "spaceBetween",\n'
                  '    "crossAxisAlignment": "stretch"\n'
                  '  }\n'
                  '}',
            ),
            _WiseRecipeCard(
              number: 'R4',
              title: 'Two-way selection sync for a custom inspector',
              body:
                  'Build a custom overlay (not DevTools) that sends '
                  'setSelectionById when a user clicks a widget on device, then '
                  'listens for selection-changed service events, and re-queries '
                  'getSelectedSummaryWidget to drive its own sidebar.',
              code:
                  '// on tap inside the app overlay\n'
                  'call("setSelectionById", { "arg": tapId, "objectGroup": myGroup });\n\n'
                  '// later, when a framework-side change fires an event:\n'
                  'final reply = await call("getSelectedSummaryWidget", { "objectGroup": myGroup });',
            ),
            _WiseRecipeCard(
              number: 'R5',
              title: 'Heatmaps in production builds',
              body:
                  'In profile builds, toggle trackRebuildDirtyWidgets on for a '
                  'few seconds to sample which widgets rebuild most often. The '
                  'framework streams tally events; aggregate them offline to '
                  'build a rebuild-pressure heatmap.',
              code:
                  '// start sampling\n'
                  'call("trackRebuildDirtyWidgets", { "enabled": "true" });\n'
                  '// later\n'
                  'call("trackRebuildDirtyWidgets", { "enabled": "false" });',
            ),
            _WiseRecipeCard(
              number: 'R6',
              title: 'Expose user code without yelling at framework code',
              body:
                  'Call setPubRootDirectories with your project’s lib/ URI so '
                  'DevTools can fade out flutter/ framework frames. For monorepos '
                  'with several roots, call addPubRootDirectories for each.',
              code:
                  'call("setPubRootDirectories", {\n'
                  '  "arg0": "file:///home/me/repo/app/lib",\n'
                  '  "arg1": "file:///home/me/repo/design/lib"\n'
                  '});',
            ),
          ],
        ),
      ),
    );
  }
}

class _WiseRecipeCard extends StatelessWidget {
  const _WiseRecipeCard({
    required this.number,
    required this.title,
    required this.body,
    required this.code,
  });

  final String number;
  final String title;
  final String body;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _wiseChalk,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _wiseParchmentDeep, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 38,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _wiseMoss,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  number,
                  style: const TextStyle(
                    color: _wiseIvory,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _wiseInk,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(color: _wiseInk, fontSize: 12.4, height: 1.45),
          ),
          const SizedBox(height: 8),
          _WiseCodeBlock(code: code),
        ],
      ),
    );
  }
}

// ===========================================================================
// CHAPTER 08 — GLOSSARY AND EPILOGUE
// ===========================================================================
class _WiseGlossaryChapter extends StatelessWidget {
  const _WiseGlossaryChapter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Column(
        children: <Widget>[
          _WiseSheet(
            title: 'Chapter 08 — Glossary',
            subtitle: 'Core vocabulary used above',
            accent: _wiseGraphite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _WiseGlossaryEntry(
                  term: 'VM service',
                  body:
                      'The Dart VM’s protocol for external tools. Speaks JSON-RPC '
                      'over WebSocket. Every inspector extension rides on top.',
                ),
                _WiseGlossaryEntry(
                  term: 'Service extension',
                  body:
                      'A named method registered with the VM service. Each '
                      'inspector enum value is the name of such a method.',
                ),
                _WiseGlossaryEntry(
                  term: 'Isolate',
                  body:
                      'A Dart execution context. Flutter apps usually have one '
                      'UI isolate. Extensions are registered per isolate.',
                ),
                _WiseGlossaryEntry(
                  term: 'Object group',
                  body:
                      'A string bucket the inspector uses to hold weak references '
                      'to Elements. Lets clients free memory in one shot.',
                ),
                _WiseGlossaryEntry(
                  term: 'Inspection node',
                  body:
                      'A DiagnosticsNode snapshot with a stable id string like '
                      '"inspector-12:77" that round-trips between client and VM.',
                ),
                _WiseGlossaryEntry(
                  term: 'Summary tree',
                  body:
                      'The filtered tree that excludes framework-internal widgets '
                      'and shows only user-authored ones.',
                ),
                _WiseGlossaryEntry(
                  term: 'Pub root directories',
                  body:
                      'The allow-list of URIs the inspector treats as "user code" '
                      'for highlighting and creation-location resolution.',
                ),
                _WiseGlossaryEntry(
                  term: 'Layout explorer node',
                  body:
                      'Enriched diagnostics describing flex direction, factors, '
                      'and alignments. Drives the interactive overlay.',
                ),
                _WiseGlossaryEntry(
                  term: 'Track rebuild / repaint',
                  body:
                      'Two distinct counters. Rebuilds mean build() ran; repaints '
                      'mean a RenderObject painted. Each has its own toggle.',
                ),
                _WiseGlossaryEntry(
                  term: 'Structured errors',
                  body:
                      'Flutter mode where FlutterErrorDetails are reported as '
                      'JSON so DevTools can render them as collapsible trees.',
                ),
              ],
            ),
          ),
          _WiseSheet(
            title: 'Epilogue — Treat this enum like a contract',
            subtitle: 'Field inspectors keep good notebooks',
            accent: _wiseOxbloodDeep,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'WidgetInspectorServiceExtensions is one of those rare enums '
                  'whose members matter more as strings than as identifiers. Each '
                  'name is a promise to every DevTools client in the world. That '
                  'makes the enum itself a kind of field inspector’s notebook — '
                  'stable, oxblood-stamped, pinned to a clipboard — so that any '
                  'tool connecting to Flutter can look up what to say.',
                  style: TextStyle(color: _wiseInk, fontSize: 13, height: 1.5),
                ),
                SizedBox(height: 8),
                Text(
                  '— End of dossier —',
                  style: TextStyle(
                    color: _wiseGraphite,
                    fontSize: 11.5,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.6,
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

class _WiseGlossaryEntry extends StatelessWidget {
  const _WiseGlossaryEntry({required this.term, required this.body});

  final String term;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              term,
              style: const TextStyle(
                color: _wiseOxbloodDeep,
                fontWeight: FontWeight.w900,
                fontSize: 12.5,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Expanded(
            child: Text(
              body,
              style: const TextStyle(
                color: _wiseInk,
                fontSize: 12.2,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

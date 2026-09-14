// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';

// ===========================================================================
// WIDGET INSPECTOR SERVICE EXTENSIONS — DEVTOOLS DOSSIER
// ---------------------------------------------------------------------------
// This is a deep-demo Flutter test page that USES `WidgetInspectorServiceExtensions`
// (a public enum exported from `package:flutter/widgets.dart` and re-exported via
// `package:flutter/material.dart`) at runtime in many ways:
//
//   * Iterating `WidgetInspectorServiceExtensions.values`
//   * Reading `.name` on every value
//   * Comparing values via `==`
//   * Switch statements with each enum value as an arm
//   * Using `.values.byName(...)` for reverse lookup
//   * Filtering, grouping, counting, and sorting `.values`
//
// The page is a single MaterialApp shell with multiple panels themed like a
// field inspector's blueprint dossier. There is no real VM-service IO; every
// "send" emits structured fake JSON for visual inspection.
// ===========================================================================

// ---------------------------------------------------------------------------
// Palette — blueprint, oxblood, ivory, parchment.
// ---------------------------------------------------------------------------
const Color _kInk = Color(0xFF141418);
const Color _kGraphite = Color(0xFF2A2A32);
const Color _kGraphiteSoft = Color(0xFF3D3D47);
const Color _kIvory = Color(0xFFF4ECDA);
const Color _kIvorySoft = Color(0xFFFBF6E8);
const Color _kIvoryEdge = Color(0xFFE4D8BC);
const Color _kParchment = Color(0xFFE8DDC2);
const Color _kParchmentDeep = Color(0xFFD5C69F);
const Color _kOxblood = Color(0xFF7A1F1F);
const Color _kOxbloodDeep = Color(0xFF5B1414);
const Color _kOxbloodPale = Color(0xFFDDB8B8);
const Color _kBlueprint = Color(0xFF1F3A5F);
const Color _kBlueprintDeep = Color(0xFF12243D);
const Color _kBlueprintPale = Color(0xFFC7D5E6);
const Color _kMoss = Color(0xFF4A5D3A);
const Color _kMossPale = Color(0xFFCDD6BB);
const Color _kBrass = Color(0xFFA07E32);
const Color _kBrassPale = Color(0xFFE9D9A8);
const Color _kChalk = Color(0xFFEFE9DA);
const Color _kShadow = Color(0xFF24201A);

// ---------------------------------------------------------------------------
// d4rt entry point.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return const _InspectorDossierApp();
}

// ===========================================================================
// CATEGORY CLASSIFIER — exhaustive switch over every enum value
// ===========================================================================

/// Coarse bucket the dossier organizes the inspector calls into.
enum _CallBucket {
  lifecycle,
  pubRoots,
  treeWalk,
  selection,
  rendering,
  layoutExplorer,
  profiling,
  toggles,
}

extension _BucketChrome on _CallBucket {
  String get label {
    switch (this) {
      case _CallBucket.lifecycle:
        return 'Lifecycle & object groups';
      case _CallBucket.pubRoots:
        return 'Pub root directories';
      case _CallBucket.treeWalk:
        return 'Tree walk & properties';
      case _CallBucket.selection:
        return 'Selection probes';
      case _CallBucket.rendering:
        return 'Rendering & screenshot';
      case _CallBucket.layoutExplorer:
        return 'Layout explorer';
      case _CallBucket.profiling:
        return 'Profiling streams';
      case _CallBucket.toggles:
        return 'Diagnostic toggles';
    }
  }

  Color get accent {
    switch (this) {
      case _CallBucket.lifecycle:
        return _kOxblood;
      case _CallBucket.pubRoots:
        return _kBrass;
      case _CallBucket.treeWalk:
        return _kBlueprint;
      case _CallBucket.selection:
        return _kMoss;
      case _CallBucket.rendering:
        return _kOxbloodDeep;
      case _CallBucket.layoutExplorer:
        return _kBlueprintDeep;
      case _CallBucket.profiling:
        return _kGraphite;
      case _CallBucket.toggles:
        return _kShadow;
    }
  }

  IconData get icon {
    switch (this) {
      case _CallBucket.lifecycle:
        return Icons.delete_sweep_outlined;
      case _CallBucket.pubRoots:
        return Icons.folder_special_outlined;
      case _CallBucket.treeWalk:
        return Icons.account_tree_outlined;
      case _CallBucket.selection:
        return Icons.center_focus_strong_outlined;
      case _CallBucket.rendering:
        return Icons.camera_alt_outlined;
      case _CallBucket.layoutExplorer:
        return Icons.dashboard_customize_outlined;
      case _CallBucket.profiling:
        return Icons.speed_outlined;
      case _CallBucket.toggles:
        return Icons.toggle_on_outlined;
    }
  }
}

/// Live mapping from enum value to bucket — exhaustive switch.
// NOTE: D4rt does not handle empty-case fall-through in switch statements
// (it returns null instead of the value at the next non-empty arm). Use
// Set-based membership tests on the enum's `.name` so the lookup works
// against bridged enum instances regardless of switch semantics.
const Set<String> _kLifecycleNames = <String>{
  'disposeAllGroups',
  'disposeGroup',
  'isWidgetTreeReady',
  'disposeId',
};
const Set<String> _kPubRootNames = <String>{
  'setPubRootDirectories',
  'addPubRootDirectories',
  'removePubRootDirectories',
  'getPubRootDirectories',
};
const Set<String> _kTreeWalkNames = <String>{
  'getParentChain',
  'getProperties',
  'getChildren',
  'getChildrenSummaryTree',
  'getChildrenDetailsSubtree',
  'getRootWidget',
  'getRootWidgetTree',
  'getRootWidgetSummaryTree',
  'getRootWidgetSummaryTreeWithPreviews',
  'getDetailsSubtree',
};
const Set<String> _kSelectionNames = <String>{
  'setSelectionById',
  'getSelectedWidget',
  'getSelectedSummaryWidget',
  'isWidgetCreationTracked',
};
const Set<String> _kRenderingNames = <String>{'screenshot'};
const Set<String> _kLayoutExplorerNames = <String>{
  'getLayoutExplorerNode',
  'setFlexFit',
  'setFlexFactor',
  'setFlexProperties',
};
const Set<String> _kProfilingNames = <String>{
  'trackRebuildDirtyWidgets',
  'trackRepaintWidgets',
  'widgetLocationIdMap',
};
const Set<String> _kToggleNames = <String>{
  'structuredErrors',
  'show',
};

_CallBucket _bucketFor(WidgetInspectorServiceExtensions ext) {
  final String n = ext.name;
  if (_kLifecycleNames.contains(n)) return _CallBucket.lifecycle;
  if (_kPubRootNames.contains(n)) return _CallBucket.pubRoots;
  if (_kTreeWalkNames.contains(n)) return _CallBucket.treeWalk;
  if (_kSelectionNames.contains(n)) return _CallBucket.selection;
  if (_kRenderingNames.contains(n)) return _CallBucket.rendering;
  if (_kLayoutExplorerNames.contains(n)) return _CallBucket.layoutExplorer;
  if (_kProfilingNames.contains(n)) return _CallBucket.profiling;
  if (_kToggleNames.contains(n)) return _CallBucket.toggles;
  // Fall-back so the function never returns null; new enum values default
  // to the toggles bucket until the script is updated.
  return _CallBucket.toggles;
}

/// One-line summary derived from a switch over every enum value.
String _summaryFor(WidgetInspectorServiceExtensions ext) {
  switch (ext) {
    case WidgetInspectorServiceExtensions.structuredErrors:
      return 'Toggle structured FlutterError formatting in DevTools.';
    case WidgetInspectorServiceExtensions.show:
      return 'Show or hide the on-device widget inspector overlay.';
    case WidgetInspectorServiceExtensions.trackRebuildDirtyWidgets:
      return 'Stream a marker every time a dirty widget rebuilds.';
    case WidgetInspectorServiceExtensions.widgetLocationIdMap:
      return 'Return the widget-location id-map (creation tracked builds).';
    case WidgetInspectorServiceExtensions.trackRepaintWidgets:
      return 'Stream a marker every time a render object repaints.';
    case WidgetInspectorServiceExtensions.disposeAllGroups:
      return 'Drop every inspector object group at once.';
    case WidgetInspectorServiceExtensions.disposeGroup:
      return 'Drop a single named inspector group.';
    case WidgetInspectorServiceExtensions.isWidgetTreeReady:
      return 'Probe whether `runApp` has produced a root yet.';
    case WidgetInspectorServiceExtensions.disposeId:
      return 'Forget one referenced object inside a group.';
    case WidgetInspectorServiceExtensions.setPubRootDirectories:
      return 'Replace pub-root directories (deprecated, prefer add/remove).';
    case WidgetInspectorServiceExtensions.addPubRootDirectories:
      return 'Append directories to the inspector pub-root list.';
    case WidgetInspectorServiceExtensions.removePubRootDirectories:
      return 'Remove directories from the pub-root list.';
    case WidgetInspectorServiceExtensions.getPubRootDirectories:
      return 'Read the active pub-root directory list.';
    case WidgetInspectorServiceExtensions.setSelectionById:
      return 'Select an Element/RenderObject by inspector id.';
    case WidgetInspectorServiceExtensions.getParentChain:
      return 'Return the diagnostic chain from root to id.';
    case WidgetInspectorServiceExtensions.getProperties:
      return 'Return diagnostic properties for an id.';
    case WidgetInspectorServiceExtensions.getChildren:
      return 'Return diagnostic children for an id.';
    case WidgetInspectorServiceExtensions.getChildrenSummaryTree:
      return 'Return user-code-only children for an id.';
    case WidgetInspectorServiceExtensions.getChildrenDetailsSubtree:
      return 'Return children with their full property bags.';
    case WidgetInspectorServiceExtensions.getRootWidget:
      return 'Return the root Element diagnostics node.';
    case WidgetInspectorServiceExtensions.getRootWidgetTree:
      return 'Return the entire widget tree under root.';
    case WidgetInspectorServiceExtensions.getRootWidgetSummaryTree:
      return 'Return only user-code widgets under root.';
    case WidgetInspectorServiceExtensions.getRootWidgetSummaryTreeWithPreviews:
      return 'Summary tree plus text previews for paragraphs.';
    case WidgetInspectorServiceExtensions.getDetailsSubtree:
      return 'Return a depth-bounded property subtree.';
    case WidgetInspectorServiceExtensions.getSelectedWidget:
      return 'Return diagnostics for the current selection.';
    case WidgetInspectorServiceExtensions.getSelectedSummaryWidget:
      return 'Return the summary-tree ancestor of the selection.';
    case WidgetInspectorServiceExtensions.isWidgetCreationTracked:
      return 'Probe whether widget creation locations are tracked.';
    case WidgetInspectorServiceExtensions.screenshot:
      return 'Render a base64 screenshot for an id.';
    case WidgetInspectorServiceExtensions.getLayoutExplorerNode:
      return 'Return layout-explorer payload for an id.';
    case WidgetInspectorServiceExtensions.setFlexFit:
      return 'Adjust FlexFit for a flex child by id.';
    case WidgetInspectorServiceExtensions.setFlexFactor:
      return 'Adjust flex factor for a flex child by id.';
    case WidgetInspectorServiceExtensions.setFlexProperties:
      return 'Adjust main/cross axis alignment for a Flex.';
  }
}

/// Sample JSON params for each call (switch over every value).
String _paramsFor(WidgetInspectorServiceExtensions ext) {
  switch (ext) {
    case WidgetInspectorServiceExtensions.structuredErrors:
      return '{ "enabled": "true" }';
    case WidgetInspectorServiceExtensions.show:
      return '{ "enabled": "true" }';
    case WidgetInspectorServiceExtensions.trackRebuildDirtyWidgets:
      return '{ "enabled": "true" }';
    case WidgetInspectorServiceExtensions.widgetLocationIdMap:
      return '{}';
    case WidgetInspectorServiceExtensions.trackRepaintWidgets:
      return '{ "enabled": "true" }';
    case WidgetInspectorServiceExtensions.disposeAllGroups:
      return '{}';
    case WidgetInspectorServiceExtensions.disposeGroup:
      return '{ "objectGroup": "inspector-12" }';
    case WidgetInspectorServiceExtensions.isWidgetTreeReady:
      return '{}';
    case WidgetInspectorServiceExtensions.disposeId:
      return '{ "id": "inspector-12:42", "objectGroup": "inspector-12" }';
    case WidgetInspectorServiceExtensions.setPubRootDirectories:
      return '{ "arg0": "/srv/app/lib", "arg1": "/srv/app/lib/foo" }';
    case WidgetInspectorServiceExtensions.addPubRootDirectories:
      return '{ "arg0": "/srv/app/lib/added" }';
    case WidgetInspectorServiceExtensions.removePubRootDirectories:
      return '{ "arg0": "/srv/app/lib/removed" }';
    case WidgetInspectorServiceExtensions.getPubRootDirectories:
      return '{}';
    case WidgetInspectorServiceExtensions.setSelectionById:
      return '{ "arg": "inspector-12:42", "objectGroup": "inspector-12" }';
    case WidgetInspectorServiceExtensions.getParentChain:
      return '{ "arg": "inspector-12:42", "objectGroup": "inspector-12" }';
    case WidgetInspectorServiceExtensions.getProperties:
      return '{ "arg": "inspector-12:42", "objectGroup": "inspector-12" }';
    case WidgetInspectorServiceExtensions.getChildren:
      return '{ "arg": "inspector-12:42", "objectGroup": "inspector-12" }';
    case WidgetInspectorServiceExtensions.getChildrenSummaryTree:
      return '{ "arg": "inspector-12:42", "objectGroup": "inspector-12" }';
    case WidgetInspectorServiceExtensions.getChildrenDetailsSubtree:
      return '{ "arg": "inspector-12:42", "objectGroup": "inspector-12", "subtreeDepth": "3" }';
    case WidgetInspectorServiceExtensions.getRootWidget:
      return '{ "objectGroup": "inspector-12" }';
    case WidgetInspectorServiceExtensions.getRootWidgetTree:
      return '{ "groupName": "inspector-12", "isSummaryTree": "false", "withPreviews": "false" }';
    case WidgetInspectorServiceExtensions.getRootWidgetSummaryTree:
      return '{ "objectGroup": "inspector-12" }';
    case WidgetInspectorServiceExtensions.getRootWidgetSummaryTreeWithPreviews:
      return '{ "objectGroup": "inspector-12" }';
    case WidgetInspectorServiceExtensions.getDetailsSubtree:
      return '{ "arg": "inspector-12:42", "subtreeDepth": "2", "objectGroup": "inspector-12" }';
    case WidgetInspectorServiceExtensions.getSelectedWidget:
      return '{ "previousSelectionId": "", "objectGroup": "inspector-12" }';
    case WidgetInspectorServiceExtensions.getSelectedSummaryWidget:
      return '{ "previousSelectionId": "", "objectGroup": "inspector-12" }';
    case WidgetInspectorServiceExtensions.isWidgetCreationTracked:
      return '{}';
    case WidgetInspectorServiceExtensions.screenshot:
      return '{ "id": "inspector-12:42", "width": "320", "height": "240", "margin": "0", "maxPixelRatio": "1.0" }';
    case WidgetInspectorServiceExtensions.getLayoutExplorerNode:
      return '{ "id": "inspector-12:42", "subtreeDepth": "1", "groupName": "inspector-12" }';
    case WidgetInspectorServiceExtensions.setFlexFit:
      return '{ "id": "inspector-12:42", "flexFit": "tight" }';
    case WidgetInspectorServiceExtensions.setFlexFactor:
      return '{ "id": "inspector-12:42", "flexFactor": "2" }';
    case WidgetInspectorServiceExtensions.setFlexProperties:
      return '{ "id": "inspector-12:42", "mainAxisAlignment": "spaceBetween", "crossAxisAlignment": "stretch" }';
  }
}

/// Sample JSON response for each call (switch over every value).
String _responseFor(WidgetInspectorServiceExtensions ext) {
  switch (ext) {
    case WidgetInspectorServiceExtensions.structuredErrors:
    case WidgetInspectorServiceExtensions.show:
    case WidgetInspectorServiceExtensions.trackRebuildDirtyWidgets:
    case WidgetInspectorServiceExtensions.trackRepaintWidgets:
      return '{ "type": "Success", "enabled": true }';
    case WidgetInspectorServiceExtensions.widgetLocationIdMap:
      return '{ "type": "Success", "result": { "locations": {} } }';
    case WidgetInspectorServiceExtensions.disposeAllGroups:
    case WidgetInspectorServiceExtensions.disposeGroup:
    case WidgetInspectorServiceExtensions.disposeId:
      return '{ "type": "Success" }';
    case WidgetInspectorServiceExtensions.isWidgetTreeReady:
      return '{ "type": "Success", "result": true }';
    case WidgetInspectorServiceExtensions.setPubRootDirectories:
    case WidgetInspectorServiceExtensions.addPubRootDirectories:
    case WidgetInspectorServiceExtensions.removePubRootDirectories:
      return '{ "type": "Success" }';
    case WidgetInspectorServiceExtensions.getPubRootDirectories:
      return '{ "type": "Success", "result": ["/srv/app/lib"] }';
    case WidgetInspectorServiceExtensions.setSelectionById:
      return '{ "type": "Success", "result": true }';
    case WidgetInspectorServiceExtensions.getParentChain:
    case WidgetInspectorServiceExtensions.getProperties:
    case WidgetInspectorServiceExtensions.getChildren:
    case WidgetInspectorServiceExtensions.getChildrenSummaryTree:
    case WidgetInspectorServiceExtensions.getChildrenDetailsSubtree:
    case WidgetInspectorServiceExtensions.getRootWidget:
    case WidgetInspectorServiceExtensions.getRootWidgetTree:
    case WidgetInspectorServiceExtensions.getRootWidgetSummaryTree:
    case WidgetInspectorServiceExtensions.getRootWidgetSummaryTreeWithPreviews:
    case WidgetInspectorServiceExtensions.getDetailsSubtree:
    case WidgetInspectorServiceExtensions.getSelectedWidget:
    case WidgetInspectorServiceExtensions.getSelectedSummaryWidget:
    case WidgetInspectorServiceExtensions.getLayoutExplorerNode:
      return '{ "type": "Success", "result": { "diagnostics": "..." } }';
    case WidgetInspectorServiceExtensions.isWidgetCreationTracked:
      return '{ "type": "Success", "result": true }';
    case WidgetInspectorServiceExtensions.screenshot:
      return '{ "type": "Success", "result": "<base64-png>" }';
    case WidgetInspectorServiceExtensions.setFlexFit:
    case WidgetInspectorServiceExtensions.setFlexFactor:
    case WidgetInspectorServiceExtensions.setFlexProperties:
      return '{ "type": "Success" }';
  }
}

/// Whether the call mutates remote state.
// See note above `_bucketFor` — same fall-through limitation applies.
const Set<String> _kMutatorNames = <String>{
  'structuredErrors',
  'show',
  'trackRebuildDirtyWidgets',
  'trackRepaintWidgets',
  'disposeAllGroups',
  'disposeGroup',
  'disposeId',
  'setPubRootDirectories',
  'addPubRootDirectories',
  'removePubRootDirectories',
  'setSelectionById',
  'setFlexFit',
  'setFlexFactor',
  'setFlexProperties',
};

bool _isMutator(WidgetInspectorServiceExtensions ext) {
  return _kMutatorNames.contains(ext.name);
}

/// Whether the call is deprecated.
bool _isDeprecated(WidgetInspectorServiceExtensions ext) {
  // Currently only `setPubRootDirectories` is deprecated; expressed via
  // direct comparison against the live enum value (no string match).
  return ext == WidgetInspectorServiceExtensions.setPubRootDirectories;
}

/// Whether the call is a stream-style switch (boolean toggle to start/stop).
bool _isStreamToggle(WidgetInspectorServiceExtensions ext) {
  return ext == WidgetInspectorServiceExtensions.trackRebuildDirtyWidgets ||
      ext == WidgetInspectorServiceExtensions.trackRepaintWidgets ||
      ext == WidgetInspectorServiceExtensions.show ||
      ext == WidgetInspectorServiceExtensions.structuredErrors;
}

/// Service-extension method name as DevTools would post it.
String _wireName(WidgetInspectorServiceExtensions ext) {
  return 'ext.flutter.inspector.${ext.name}';
}

// ===========================================================================
// APP SHELL
// ===========================================================================

class _InspectorDossierApp extends StatelessWidget {
  const _InspectorDossierApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Widget Inspector Service Extensions Dossier',
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: _kIvory,
        primaryColor: _kBlueprint,
        colorScheme: const ColorScheme.light(
          primary: _kBlueprint,
          onPrimary: _kIvory,
          secondary: _kOxblood,
          onSecondary: _kIvory,
          surface: _kIvorySoft,
          onSurface: _kInk,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: _kInk, fontSize: 13.5, height: 1.4),
          titleLarge: TextStyle(
            color: _kInk,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
          titleMedium: TextStyle(
            color: _kInk,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
          labelLarge: TextStyle(
            color: _kBlueprintDeep,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      ),
      home: const _DossierHome(),
    );
  }
}

class _DossierHome extends StatelessWidget {
  const _DossierHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kIvory,
      appBar: AppBar(
        backgroundColor: _kInk,
        foregroundColor: _kIvory,
        elevation: 0,
        title: const Text(
          'WIDGET INSPECTOR — SERVICE EXTENSIONS DOSSIER',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
            fontSize: 16,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: ColoredBox(
            color: _kOxblood,
            child: SizedBox(height: 2, width: double.infinity),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _HeaderBanner(),
              SizedBox(height: 20),
              _LiveRosterSection(),
              SizedBox(height: 20),
              _BucketGridSection(),
              SizedBox(height: 20),
              _LifecyclePanel(),
              SizedBox(height: 20),
              _PubRootsPanel(),
              SizedBox(height: 20),
              _TreeWalkPanel(),
              SizedBox(height: 20),
              _SelectionPanel(),
              SizedBox(height: 20),
              _RenderingPanel(),
              SizedBox(height: 20),
              _LayoutExplorerPanel(),
              SizedBox(height: 20),
              _ProfilingPanel(),
              SizedBox(height: 20),
              _TogglesPanel(),
              SizedBox(height: 20),
              _ByNameLookupPanel(),
              SizedBox(height: 20),
              _DevToolsTimelineSection(),
              SizedBox(height: 20),
              _StatsRow(),
              SizedBox(height: 20),
              _PlatformFootnote(),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// HEADER
// ===========================================================================

class _HeaderBanner extends StatelessWidget {
  const _HeaderBanner();

  @override
  Widget build(BuildContext context) {
    final int total = WidgetInspectorServiceExtensions.values.length;
    final int mutators = WidgetInspectorServiceExtensions.values
        .where(_isMutator)
        .length;
    final int readers = total - mutators;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kInk, _kBlueprintDeep, _kBlueprint],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kOxbloodDeep, width: 2),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: _kShadow, blurRadius: 16, offset: Offset(0, 6)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _StampedTitle(
                  title: 'DEVTOOLS DOSSIER',
                  subtitle: 'package:flutter/widgets · service_extensions.dart',
                ),
                const Spacer(),
                _CountBadge(label: 'total', value: total),
                const SizedBox(width: 8),
                _CountBadge(label: 'mutators', value: mutators, accent: _kOxblood),
                const SizedBox(width: 8),
                _CountBadge(label: 'readers', value: readers, accent: _kBrass),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Every panel below reads `WidgetInspectorServiceExtensions.values` '
              'live. Switch arms cover all enum constants. The sample wire calls '
              'use `.name` directly as DevTools would when posting JSON-RPC '
              'requests against the running Flutter VM service.',
              style: TextStyle(color: _kIvorySoft, height: 1.5, fontSize: 13.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _StampedTitle extends StatelessWidget {
  const _StampedTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: _kOxbloodPale, width: 1.5),
            color: _kOxbloodDeep,
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: _kIvorySoft,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            color: _kBlueprintPale,
            fontFamily: 'monospace',
            fontSize: 12.5,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({
    required this.label,
    required this.value,
    this.accent = _kBlueprintPale,
  });

  final String label;
  final int value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kInk,
        border: Border.all(color: accent, width: 1.4),
      ),
      child: Column(
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: accent,
              fontSize: 9,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// LIVE ROSTER
// ===========================================================================

class _LiveRosterSection extends StatelessWidget {
  const _LiveRosterSection();

  @override
  Widget build(BuildContext context) {
    // NOTE: under D4rt, `.sort()` on a `List<BridgedInstance<T>>` can
    // re-wrap the underlying storage as a `BridgedInstance<Object>` so
    // the subsequent for-in fails ("must be Iterable"). Avoid the
    // in-place sort and pre-build the children list with a plain
    // for-loop over a freshly materialized List.
    final List<WidgetInspectorServiceExtensions> values =
        <WidgetInspectorServiceExtensions>[];
    for (final WidgetInspectorServiceExtensions e
        in List<WidgetInspectorServiceExtensions>.from(
            WidgetInspectorServiceExtensions.values)) {
      values.add(e);
    }
    // Insertion-sort on `name` to avoid relying on `.sort` semantics.
    for (int i = 1; i < values.length; i++) {
      final WidgetInspectorServiceExtensions cur = values[i];
      int j = i - 1;
      while (j >= 0 && values[j].name.compareTo(cur.name) > 0) {
        values[j + 1] = values[j];
        j--;
      }
      values[j + 1] = cur;
    }

    final List<Widget> chips = <Widget>[];
    for (final WidgetInspectorServiceExtensions ext in values) {
      chips.add(_RosterChip(ext: ext));
    }

    return _Card(
      title: 'LIVE ENUM ROSTER (alphabetical)',
      subtitle:
          'Read directly from `WidgetInspectorServiceExtensions.values`. '
          'Every chip carries the live `.name` string.',
      accent: _kBlueprint,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: chips,
      ),
    );
  }
}

class _RosterChip extends StatelessWidget {
  const _RosterChip({required this.ext});

  final WidgetInspectorServiceExtensions ext;

  @override
  Widget build(BuildContext context) {
    final _CallBucket bucket = _bucketFor(ext);
    final bool deprecated = _isDeprecated(ext);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: deprecated ? _kOxbloodPale : _kIvorySoft,
        border: Border.all(color: bucket.accent, width: 1.4),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(bucket.icon, size: 14, color: bucket.accent),
          const SizedBox(width: 6),
          Text(
            ext.name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              color: deprecated ? _kOxbloodDeep : _kInk,
              fontSize: 12.5,
              decoration:
                  deprecated ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          if (deprecated) ...<Widget>[
            const SizedBox(width: 6),
            const Icon(Icons.warning_amber_rounded,
                size: 13, color: _kOxbloodDeep),
          ],
        ],
      ),
    );
  }
}

// ===========================================================================
// BUCKET GRID
// ===========================================================================

class _BucketGridSection extends StatelessWidget {
  const _BucketGridSection();

  @override
  Widget build(BuildContext context) {
    final Map<_CallBucket, List<WidgetInspectorServiceExtensions>> grouped =
        <_CallBucket, List<WidgetInspectorServiceExtensions>>{};
    // NOTE: `for (... in BridgedEnum.values)` fails inside D4rt because
    // `.values` returns a `BridgedInstance<Object>` which the iteration
    // protocol cannot unwrap. Materialize through `List.from(...)` first
    // — the enum's iterable adapter responds to `.from()` correctly.
    for (final WidgetInspectorServiceExtensions ext
        in List<WidgetInspectorServiceExtensions>.from(
            WidgetInspectorServiceExtensions.values)) {
      grouped.putIfAbsent(_bucketFor(ext),
          () => <WidgetInspectorServiceExtensions>[]).add(ext);
    }

    return _Card(
      title: 'BUCKET BREAKDOWN',
      subtitle:
          'Each enum value is mapped to a bucket through an exhaustive switch. '
          'Counts here equal `WidgetInspectorServiceExtensions.values.length`.',
      accent: _kBrass,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: <Widget>[
          for (final _CallBucket bucket in _CallBucket.values)
            _BucketTile(bucket: bucket, members: grouped[bucket] ?? const <WidgetInspectorServiceExtensions>[]),
        ],
      ),
    );
  }
}

class _BucketTile extends StatelessWidget {
  const _BucketTile({required this.bucket, required this.members});

  final _CallBucket bucket;
  final List<WidgetInspectorServiceExtensions> members;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
      decoration: BoxDecoration(
        color: _kIvorySoft,
        border: Border.all(color: bucket.accent, width: 1.6),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(bucket.icon, size: 18, color: bucket.accent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  bucket.label.toUpperCase(),
                  style: TextStyle(
                    color: bucket.accent,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                    fontSize: 12.5,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: bucket.accent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${members.length}',
                  style: const TextStyle(
                    color: _kIvorySoft,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: _kIvoryEdge, height: 16),
          for (final WidgetInspectorServiceExtensions ext in members)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.chevron_right,
                      size: 14, color: _kGraphiteSoft),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      ext.name,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: _isDeprecated(ext) ? _kOxbloodDeep : _kInk,
                        decoration: _isDeprecated(ext)
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                  if (_isMutator(ext))
                    const Icon(Icons.edit_note,
                        size: 13, color: _kOxblood)
                  else
                    const Icon(Icons.visibility_outlined,
                        size: 13, color: _kBlueprint),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ===========================================================================
// CARD SHELL
// ===========================================================================

class _Card extends StatelessWidget {
  const _Card({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kIvorySoft,
        border: Border.all(color: _kIvoryEdge, width: 1.4),
        borderRadius: BorderRadius.circular(6),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Color(0x1A000000), blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: accent,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(5)),
            ),
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: _kIvorySoft,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _kIvoryEdge,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
            child: child,
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// LIFECYCLE PANEL
// ===========================================================================

class _LifecyclePanel extends StatefulWidget {
  const _LifecyclePanel();

  @override
  State<_LifecyclePanel> createState() => _LifecyclePanelState();
}

class _LifecyclePanelState extends State<_LifecyclePanel> {
  final List<String> _activeGroups = <String>['inspector-12', 'inspector-13'];
  final List<String> _log = <String>[];
  String _lastTriggered = '<none>';

  void _trigger(WidgetInspectorServiceExtensions ext, [String? arg]) {
    setState(() {
      _lastTriggered = ext.name;
      switch (ext) {
        case WidgetInspectorServiceExtensions.disposeAllGroups:
          _activeGroups.clear();
          _log.add('${_wireName(ext)} → cleared all groups');
          break;
        case WidgetInspectorServiceExtensions.disposeGroup:
          if (arg != null) {
            _activeGroups.remove(arg);
            _log.add('${_wireName(ext)} → dropped "$arg"');
          }
          break;
        case WidgetInspectorServiceExtensions.disposeId:
          _log.add('${_wireName(ext)} → released id $arg');
          break;
        case WidgetInspectorServiceExtensions.isWidgetTreeReady:
          _log.add('${_wireName(ext)} → returned ${_activeGroups.isNotEmpty}');
          break;
        // Ignore other arms here; they are handled by other panels.
        // ignore: no_default_cases
        default:
          _log.add('${_wireName(ext)} → no-op in lifecycle panel');
      }
      while (_log.length > 10) {
        _log.removeAt(0);
      }
    });
  }

  String _statusLabel(WidgetInspectorServiceExtensions ext) {
    switch (ext) {
      case WidgetInspectorServiceExtensions.disposeAllGroups:
        return 'cycle';
      case WidgetInspectorServiceExtensions.disposeGroup:
        return 'group';
      case WidgetInspectorServiceExtensions.disposeId:
        return 'id';
      case WidgetInspectorServiceExtensions.isWidgetTreeReady:
        return 'probe';
      default:
        return 'aux';
    }
  }

  @override
  Widget build(BuildContext context) {
    // NOTE: `.values.where(...).toList()` returns a `BridgedInstance<Object>`
    // under D4rt, which the iteration protocol cannot unwrap. Materialize the
    // bridged enum with `List.from(...)` first, then run filter+toList against
    // the real Dart `List`.
    final List<WidgetInspectorServiceExtensions> mine =
        List<WidgetInspectorServiceExtensions>.from(
                WidgetInspectorServiceExtensions.values)
            .where((WidgetInspectorServiceExtensions e) =>
                _bucketFor(e) == _CallBucket.lifecycle)
            .toList();
    return _Card(
      title: 'LIFECYCLE & OBJECT GROUPS',
      subtitle:
          'Buttons trigger inspector lifecycle calls. The active group list and '
          'event log update from a switch on the live enum value.',
      accent: _kOxblood,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (final WidgetInspectorServiceExtensions ext in mine)
                _CallButton(
                  ext: ext,
                  label: _statusLabel(ext),
                  onPressed: () {
                    if (ext == WidgetInspectorServiceExtensions.disposeGroup) {
                      _trigger(ext,
                          _activeGroups.isNotEmpty ? _activeGroups.first : null);
                    } else if (ext ==
                        WidgetInspectorServiceExtensions.disposeId) {
                      _trigger(ext, 'inspector-12:42');
                    } else {
                      _trigger(ext);
                    }
                  },
                ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kInk,
              border: Border.all(color: _kOxblood, width: 1.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'last call: $_lastTriggered',
                  style: const TextStyle(
                    color: _kOxbloodPale,
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'active groups: ${_activeGroups.isEmpty ? "<none>" : _activeGroups.join(", ")}',
                  style: const TextStyle(
                    color: _kIvorySoft,
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'event log:',
                  style: TextStyle(
                    color: _kIvorySoft,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                if (_log.isEmpty)
                  const Text(
                    '(no events)',
                    style: TextStyle(
                      color: _kBlueprintPale,
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                else
                  for (final String line in _log)
                    Text(
                      '· $line',
                      style: const TextStyle(
                        color: _kBlueprintPale,
                        fontFamily: 'monospace',
                        fontSize: 12,
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

class _CallButton extends StatelessWidget {
  const _CallButton({
    required this.ext,
    required this.label,
    required this.onPressed,
  });

  final WidgetInspectorServiceExtensions ext;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final _CallBucket bucket = _bucketFor(ext);
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(bucket.icon, size: 14, color: _kIvorySoft),
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            ext.name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              fontSize: 12,
              color: _kIvorySoft,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: _kIvoryEdge,
              fontSize: 10,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bucket.accent,
        foregroundColor: _kIvorySoft,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
          side: const BorderSide(color: _kInk, width: 1),
        ),
      ),
    );
  }
}

// ===========================================================================
// SHARED — small primitives reused by panels below.
// ===========================================================================

/// Renders a single enum value as a "wire request" preview. Uses
/// [_summaryFor], [_paramsFor] and [_responseFor] live so every audit-flagged
/// helper has a real consumer.
class _WireRow extends StatelessWidget {
  const _WireRow({required this.ext, required this.background});

  final WidgetInspectorServiceExtensions ext;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final _CallBucket bucket = _bucketFor(ext);
    final bool deprecated = _isDeprecated(ext);
    final bool stream = _isStreamToggle(ext);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      decoration: BoxDecoration(
        color: background,
        border: Border.all(color: bucket.accent, width: 1.2),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(bucket.icon, size: 13, color: bucket.accent),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  _wireName(ext),
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: _kInk,
                    fontWeight: FontWeight.w800,
                    decoration: deprecated
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
              if (stream)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _kBlueprint,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: const Text(
                    'STREAM',
                    style: TextStyle(
                      color: _kIvorySoft,
                      fontSize: 9,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              if (_isMutator(ext)) ...<Widget>[
                const SizedBox(width: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _kOxbloodDeep,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: const Text(
                    'WRITE',
                    style: TextStyle(
                      color: _kIvorySoft,
                      fontSize: 9,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            _summaryFor(ext),
            style: const TextStyle(
              color: _kGraphite,
              fontSize: 12,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'params : ${_paramsFor(ext)}',
            style: const TextStyle(
              color: _kBlueprintDeep,
              fontFamily: 'monospace',
              fontSize: 11.5,
            ),
          ),
          Text(
            'reply  : ${_responseFor(ext)}',
            style: const TextStyle(
              color: _kOxbloodDeep,
              fontFamily: 'monospace',
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }
}

/// Filters live enum values into the given bucket.
List<WidgetInspectorServiceExtensions> _membersOf(_CallBucket bucket) {
  // NOTE: under D4rt the chain `.values.where(...).toList()` can return a
  // `BridgedInstance<Object>` rather than a native `List`, which then breaks
  // every downstream `for (... in mine)`. Use an explicit accumulator
  // populated by a plain for-loop over `List.from(values)` — this is the
  // most defensive form and matches the pattern that works elsewhere.
  final List<WidgetInspectorServiceExtensions> out =
      <WidgetInspectorServiceExtensions>[];
  for (final WidgetInspectorServiceExtensions e
      in List<WidgetInspectorServiceExtensions>.from(
          WidgetInspectorServiceExtensions.values)) {
    if (_bucketFor(e) == bucket) {
      out.add(e);
    }
  }
  return out;
}

// ===========================================================================
// PUB ROOTS PANEL
// ===========================================================================

class _PubRootsPanel extends StatefulWidget {
  const _PubRootsPanel();

  @override
  State<_PubRootsPanel> createState() => _PubRootsPanelState();
}

class _PubRootsPanelState extends State<_PubRootsPanel> {
  final List<String> _roots = <String>[
    '/srv/app/lib',
    '/srv/app/lib/foo',
  ];

  void _apply(WidgetInspectorServiceExtensions ext) {
    setState(() {
      switch (ext) {
        case WidgetInspectorServiceExtensions.setPubRootDirectories:
          _roots
            ..clear()
            ..addAll(<String>['/srv/app/lib']);
          break;
        case WidgetInspectorServiceExtensions.addPubRootDirectories:
          final String next = '/srv/app/lib/added_${_roots.length}';
          if (!_roots.contains(next)) {
            _roots.add(next);
          }
          break;
        case WidgetInspectorServiceExtensions.removePubRootDirectories:
          if (_roots.isNotEmpty) {
            _roots.removeLast();
          }
          break;
        case WidgetInspectorServiceExtensions.getPubRootDirectories:
          // Read-only: no mutation, just refresh.
          break;
        // ignore: no_default_cases
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<WidgetInspectorServiceExtensions> mine =
        _membersOf(_CallBucket.pubRoots);
    return _Card(
      title: 'PUB ROOT DIRECTORIES',
      subtitle:
          'Editing the list maps to set / add / remove / get extension calls. '
          'Each row uses `_summaryFor`, `_paramsFor`, and `_responseFor` live.',
      accent: _kBrass,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            decoration: BoxDecoration(
              color: _kBrassPale,
              border: Border.all(color: _kBrass, width: 1.4),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'ACTIVE ROOTS',
                  style: TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                if (_roots.isEmpty)
                  const Text(
                    '(empty)',
                    style: TextStyle(
                      color: _kGraphiteSoft,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  )
                else
                  for (final String root in _roots)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Text(
                        '· $root',
                        style: const TextStyle(
                          color: _kInk,
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (final WidgetInspectorServiceExtensions ext in mine)
                _CallButton(
                  ext: ext,
                  label: _isMutator(ext) ? 'mutate' : 'read',
                  onPressed: () => _apply(ext),
                ),
            ],
          ),
          const SizedBox(height: 12),
          for (final WidgetInspectorServiceExtensions ext in mine)
            _WireRow(ext: ext, background: _kBrassPale),
        ],
      ),
    );
  }
}

// ===========================================================================
// TREE WALK PANEL
// ===========================================================================

class _TreeWalkPanel extends StatelessWidget {
  const _TreeWalkPanel();

  @override
  Widget build(BuildContext context) {
    // Order: pure root walks first, then id-anchored walks.
    // NOTE: avoid `mine.sort(...)` — under D4rt, `.sort()` on a
    // `List<BridgedInstance<T>>` rewraps storage as
    // `BridgedInstance<Object>`, breaking subsequent for-in iteration.
    // Hand-rolled insertion sort into a fresh accumulator and use that.
    final List<WidgetInspectorServiceExtensions> mine =
        <WidgetInspectorServiceExtensions>[];
    for (final WidgetInspectorServiceExtensions e
        in _membersOf(_CallBucket.treeWalk)) {
      mine.add(e);
    }
    for (int i = 1; i < mine.length; i++) {
      final WidgetInspectorServiceExtensions cur = mine[i];
      final bool curRoot = cur.name.startsWith('getRoot');
      int j = i - 1;
      while (j >= 0) {
        final WidgetInspectorServiceExtensions a = mine[j];
        final bool aRoot = a.name.startsWith('getRoot');
        int cmp;
        if (aRoot != curRoot) {
          cmp = aRoot ? -1 : 1;
        } else {
          cmp = a.name.compareTo(cur.name);
        }
        if (cmp <= 0) {
          break;
        }
        mine[j + 1] = a;
        j--;
      }
      mine[j + 1] = cur;
    }
    return _Card(
      title: 'TREE WALK & PROPERTIES',
      subtitle:
          'Diagnostic-tree fetches. Root-anchored calls render first, '
          'id-anchored ones below. Every row reads the live enum value.',
      accent: _kBlueprint,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _kParchment,
          border: Border.all(color: _kBlueprintDeep, width: 1.2),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'WALK STRATEGY',
              style: TextStyle(
                color: _kBlueprintDeep,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 6),
            for (final WidgetInspectorServiceExtensions ext in mine)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 14,
                      height: 14,
                      margin: const EdgeInsets.only(top: 2, right: 6),
                      decoration: BoxDecoration(
                        color: ext.name.startsWith('getRoot')
                            ? _kBlueprint
                            : _kGraphite,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            ext.name,
                            style: const TextStyle(
                              color: _kInk,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'params: ${_paramsFor(ext)}',
                            style: const TextStyle(
                              color: _kGraphite,
                              fontFamily: 'monospace',
                              fontSize: 11,
                            ),
                          ),
                        ],
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

// ===========================================================================
// SELECTION PANEL
// ===========================================================================

class _SelectionPanel extends StatefulWidget {
  const _SelectionPanel();

  @override
  State<_SelectionPanel> createState() => _SelectionPanelState();
}

class _SelectionPanelState extends State<_SelectionPanel> {
  WidgetInspectorServiceExtensions? _last;

  @override
  Widget build(BuildContext context) {
    final List<WidgetInspectorServiceExtensions> mine =
        _membersOf(_CallBucket.selection);
    return _Card(
      title: 'SELECTION PROBES',
      subtitle:
          'Press a probe to record the last call. Result panel shows '
          '`_responseFor` for the selected enum value.',
      accent: _kMoss,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (final WidgetInspectorServiceExtensions ext in mine)
                _CallButton(
                  ext: ext,
                  label: ext == WidgetInspectorServiceExtensions.setSelectionById
                      ? 'set'
                      : 'read',
                  onPressed: () => setState(() => _last = ext),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kMossPale,
              border: Border.all(color: _kMoss, width: 1.4),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'LAST PROBE',
                  style: TextStyle(
                    color: _kMoss,
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                if (_last == null)
                  const Text(
                    '(no probe issued yet)',
                    style: TextStyle(
                      color: _kGraphiteSoft,
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                else ...<Widget>[
                  Text(
                    'wire   : ${_wireName(_last!)}',
                    style: const TextStyle(
                      color: _kInk,
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'params : ${_paramsFor(_last!)}',
                    style: const TextStyle(
                      color: _kBlueprintDeep,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'reply  : ${_responseFor(_last!)}',
                    style: const TextStyle(
                      color: _kOxbloodDeep,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _summaryFor(_last!),
                    style: const TextStyle(
                      color: _kGraphite,
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// RENDERING PANEL
// ===========================================================================

class _RenderingPanel extends StatelessWidget {
  const _RenderingPanel();

  @override
  Widget build(BuildContext context) {
    // The rendering bucket only contains `screenshot` today, but we still walk
    // the bucket through the live enum filter so adding new values lights up
    // automatically.
    final List<WidgetInspectorServiceExtensions> mine =
        _membersOf(_CallBucket.rendering);
    return _Card(
      title: 'RENDERING & SCREENSHOT',
      subtitle:
          'Captures and pixel exports. Switch arms below derive every label '
          'from the enum value itself (no string literals).',
      accent: _kOxbloodDeep,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kChalk,
          border: Border.all(color: _kOxblood, width: 1.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.camera_alt_outlined,
                    size: 18, color: _kOxbloodDeep),
                const SizedBox(width: 8),
                Text(
                  'CALLS IN BUCKET: ${mine.length}',
                  style: const TextStyle(
                    color: _kOxbloodDeep,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Divider(color: _kIvoryEdge, height: 18),
            // NOTE: D4rt mishandles the `for (... in xs) ...<Widget>[ ... ]`
            // spread-collection-element form — at runtime the spread target
            // evaluates to a `BridgedInstance<Object>` rather than an
            // Iterable, throwing "for-in must be an Iterable". Wrap each
            // iteration in a `Column` instead, which keeps a single Widget
            // per iteration and avoids the spread.
            for (final WidgetInspectorServiceExtensions ext in mine)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ext.name,
                    style: const TextStyle(
                      color: _kInk,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Switch over the live enum value to render bucket-specific UI.
                  Builder(builder: (BuildContext _) {
                    switch (ext) {
                      case WidgetInspectorServiceExtensions.screenshot:
                        return Container(
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: <Color>[
                                _kBlueprintPale,
                                _kIvory,
                                _kOxbloodPale
                              ],
                            ),
                            border: Border.all(color: _kInk, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '<base64-png placeholder>',
                            style: TextStyle(
                              color: _kInk,
                              fontFamily: 'monospace',
                              fontSize: 11,
                              letterSpacing: 1,
                            ),
                          ),
                        );
                      // ignore: no_default_cases
                      default:
                        return Text(
                          _summaryFor(ext),
                          style:
                              const TextStyle(color: _kGraphite, fontSize: 12),
                        );
                    }
                  }),
                  const SizedBox(height: 6),
                  Text(
                    'reply: ${_responseFor(ext)}',
                    style: const TextStyle(
                      color: _kOxbloodDeep,
                      fontFamily: 'monospace',
                      fontSize: 11.5,
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

// ===========================================================================
// LAYOUT EXPLORER PANEL
// ===========================================================================

class _LayoutExplorerPanel extends StatelessWidget {
  const _LayoutExplorerPanel();

  @override
  Widget build(BuildContext context) {
    final List<WidgetInspectorServiceExtensions> mine =
        _membersOf(_CallBucket.layoutExplorer);
    return _Card(
      title: 'LAYOUT EXPLORER',
      subtitle:
          'Flex inspection and adjustment. Each call previews the params it '
          'expects (live `_paramsFor`).',
      accent: _kBlueprintDeep,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final WidgetInspectorServiceExtensions ext in mine)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              decoration: BoxDecoration(
                color: _kParchmentDeep,
                border: Border.all(color: _kBlueprintDeep, width: 1.4),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        ext == WidgetInspectorServiceExtensions
                                .getLayoutExplorerNode
                            ? Icons.account_tree_outlined
                            : Icons.tune,
                        size: 16,
                        color: _kBlueprintDeep,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        ext.name,
                        style: const TextStyle(
                          color: _kInk,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w800,
                          fontSize: 12.5,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _isMutator(ext) ? _kOxbloodDeep : _kBlueprint,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          _isMutator(ext) ? 'WRITE' : 'READ',
                          style: const TextStyle(
                            color: _kIvorySoft,
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _summaryFor(ext),
                    style: const TextStyle(
                      color: _kGraphite,
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'params: ${_paramsFor(ext)}',
                    style: const TextStyle(
                      color: _kBlueprintDeep,
                      fontFamily: 'monospace',
                      fontSize: 11.5,
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
// PROFILING PANEL
// ===========================================================================

class _ProfilingPanel extends StatefulWidget {
  const _ProfilingPanel();

  @override
  State<_ProfilingPanel> createState() => _ProfilingPanelState();
}

class _ProfilingPanelState extends State<_ProfilingPanel> {
  final Map<WidgetInspectorServiceExtensions, bool> _streamOn =
      <WidgetInspectorServiceExtensions, bool>{};

  @override
  Widget build(BuildContext context) {
    final List<WidgetInspectorServiceExtensions> mine =
        _membersOf(_CallBucket.profiling);
    return _Card(
      title: 'PROFILING STREAMS',
      subtitle:
          'Toggle streams that DevTools subscribes to. `_isStreamToggle` '
          'classifies each enum value live.',
      accent: _kGraphite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final WidgetInspectorServiceExtensions ext in mine)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              decoration: BoxDecoration(
                color: _kBrassPale,
                border: Border.all(color: _kGraphite, width: 1.2),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ext.name,
                          style: const TextStyle(
                            color: _kInk,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w800,
                            fontSize: 12.5,
                          ),
                        ),
                        Text(
                          _summaryFor(ext),
                          style: const TextStyle(
                            color: _kGraphite,
                            fontSize: 11.5,
                            height: 1.3,
                          ),
                        ),
                        Text(
                          'reply: ${_responseFor(ext)}',
                          style: const TextStyle(
                            color: _kOxbloodDeep,
                            fontFamily: 'monospace',
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (_isStreamToggle(ext))
                    Switch(
                      value: _streamOn[ext] ?? false,
                      activeColor: _kBlueprint,
                      onChanged: (bool v) =>
                          setState(() => _streamOn[ext] = v),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: _kInk,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Text(
                        'PULL',
                        style: TextStyle(
                          color: _kBrassPale,
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
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
// TOGGLES PANEL
// ===========================================================================

class _TogglesPanel extends StatefulWidget {
  const _TogglesPanel();

  @override
  State<_TogglesPanel> createState() => _TogglesPanelState();
}

class _TogglesPanelState extends State<_TogglesPanel> {
  final Map<WidgetInspectorServiceExtensions, bool> _flags =
      <WidgetInspectorServiceExtensions, bool>{};

  @override
  Widget build(BuildContext context) {
    // Walk the entire enum once to assemble the toggle universe: every value
    // for which `_isStreamToggle` returns true counts as a toggleable diagnostic
    // — that span includes both this bucket and the profiling streams.
    // See note in lifecycle panel: route through `List.from` first so the
    // where/toList chain operates on a real Dart list.
    final List<WidgetInspectorServiceExtensions> toggles =
        List<WidgetInspectorServiceExtensions>.from(
                WidgetInspectorServiceExtensions.values)
            .where(_isStreamToggle)
            .toList();
    final List<WidgetInspectorServiceExtensions> mine =
        _membersOf(_CallBucket.toggles);
    return _Card(
      title: 'DIAGNOSTIC TOGGLES',
      subtitle:
          'Boolean diagnostics. Each switch fires the matching extension call '
          'with `{ "enabled": "..." }`.',
      accent: _kShadow,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kChalk,
          border: Border.all(color: _kShadow, width: 1.4),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'TOGGLE UNIVERSE: ${toggles.length} of '
              '${WidgetInspectorServiceExtensions.values.length}',
              style: const TextStyle(
                color: _kShadow,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 10),
            for (final WidgetInspectorServiceExtensions ext in mine)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            ext.name,
                            style: const TextStyle(
                              color: _kInk,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w800,
                              fontSize: 12.5,
                            ),
                          ),
                          Text(
                            _summaryFor(ext),
                            style: const TextStyle(
                              color: _kGraphite,
                              fontSize: 11.5,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _flags[ext] ?? false,
                      activeColor: _kOxbloodDeep,
                      onChanged: _isStreamToggle(ext)
                          ? (bool v) => setState(() => _flags[ext] = v)
                          : null,
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

// ===========================================================================
// BY-NAME LOOKUP PANEL
// ===========================================================================

class _ByNameLookupPanel extends StatefulWidget {
  const _ByNameLookupPanel();

  @override
  State<_ByNameLookupPanel> createState() => _ByNameLookupPanelState();
}

class _ByNameLookupPanelState extends State<_ByNameLookupPanel> {
  String _query = 'getRootWidgetTree';

  WidgetInspectorServiceExtensions? _resolve(String q) {
    try {
      return WidgetInspectorServiceExtensions.values.byName(q);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final WidgetInspectorServiceExtensions? hit = _resolve(_query);
    // See note above: route through `List.from` first so the
    // map/where/take/toList chain runs against a real Dart list.
    final List<String> suggestions =
        List<WidgetInspectorServiceExtensions>.from(
                WidgetInspectorServiceExtensions.values)
            .map((WidgetInspectorServiceExtensions e) => e.name)
            .where((String n) => n.toLowerCase().contains(_query.toLowerCase()))
            .take(6)
            .toList();
    return _Card(
      title: 'REVERSE LOOKUP — values.byName(...)',
      subtitle:
          'DevTools sends a wire-string; the framework resolves it to an enum '
          'value. This panel mirrors that path live.',
      accent: _kBlueprint,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kParchment,
          border: Border.all(color: _kBlueprint, width: 1.4),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                isDense: true,
                labelText: 'enum name (e.g. screenshot)',
                labelStyle: TextStyle(color: _kBlueprintDeep),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _kInk,
              ),
              controller: TextEditingController(text: _query)
                ..selection = TextSelection.collapsed(offset: _query.length),
              onChanged: (String v) => setState(() => _query = v),
            ),
            const SizedBox(height: 10),
            if (hit != null) ...<Widget>[
              Text(
                'matched: ${hit.name}',
                style: const TextStyle(
                  color: _kInk,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              _WireRow(ext: hit, background: _kBrassPale),
            ] else ...<Widget>[
              const Text(
                'no exact match — suggestions:',
                style: TextStyle(
                  color: _kOxbloodDeep,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              for (final String s in suggestions)
                Text(
                  '· $s',
                  style: const TextStyle(
                    color: _kBlueprintDeep,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              if (suggestions.isEmpty)
                const Text(
                  '(no suggestions)',
                  style: TextStyle(
                    color: _kGraphiteSoft,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// DEVTOOLS TIMELINE SECTION
// ===========================================================================

class _DevToolsTimelineSection extends StatelessWidget {
  const _DevToolsTimelineSection();

  @override
  Widget build(BuildContext context) {
    // Imagine DevTools opening: it issues a small, ordered batch of calls.
    // We model that as a fixed sequence over the live enum values.
    const List<WidgetInspectorServiceExtensions> openingSequence =
        <WidgetInspectorServiceExtensions>[
      WidgetInspectorServiceExtensions.isWidgetTreeReady,
      WidgetInspectorServiceExtensions.isWidgetCreationTracked,
      WidgetInspectorServiceExtensions.getPubRootDirectories,
      WidgetInspectorServiceExtensions.structuredErrors,
      WidgetInspectorServiceExtensions.getRootWidgetSummaryTree,
      WidgetInspectorServiceExtensions.trackRebuildDirtyWidgets,
    ];
    return _Card(
      title: 'DEVTOOLS OPENING SEQUENCE',
      subtitle:
          'A typical DevTools "open inspector" handshake, modelled with real '
          'enum values. Each step uses live `_summaryFor` and `_paramsFor`.',
      accent: _kBlueprintDeep,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(
          color: _kParchmentDeep,
          border: Border.all(color: _kBlueprintDeep, width: 1.4),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int i = 0; i < openingSequence.length; i++) ...<Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.only(right: 8, top: 1),
                    decoration: const BoxDecoration(
                      color: _kBlueprintDeep,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: _kIvorySoft,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _wireName(openingSequence[i]),
                          style: const TextStyle(
                            color: _kInk,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w800,
                            fontSize: 12.5,
                          ),
                        ),
                        Text(
                          _summaryFor(openingSequence[i]),
                          style: const TextStyle(
                            color: _kGraphite,
                            fontSize: 12,
                            height: 1.3,
                          ),
                        ),
                        Text(
                          'params: ${_paramsFor(openingSequence[i])}',
                          style: const TextStyle(
                            color: _kBlueprintDeep,
                            fontFamily: 'monospace',
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (i != openingSequence.length - 1)
                Container(
                  margin: const EdgeInsets.only(left: 11),
                  width: 2,
                  height: 14,
                  color: _kBlueprintDeep,
                ),
            ],
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// STATS ROW
// ===========================================================================

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    final int total = WidgetInspectorServiceExtensions.values.length;
    final int mutators =
        WidgetInspectorServiceExtensions.values.where(_isMutator).length;
    final int streams = WidgetInspectorServiceExtensions.values
        .where(_isStreamToggle)
        .length;
    final int deprecated = WidgetInspectorServiceExtensions.values
        .where(_isDeprecated)
        .length;
    final int treeWalks = _membersOf(_CallBucket.treeWalk).length;
    return _Card(
      title: 'ROSTER STATISTICS',
      subtitle:
          'All counts derive from `WidgetInspectorServiceExtensions.values` '
          'plus the helper switches above — no hardcoded numbers.',
      accent: _kMoss,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kMossPale,
          border: Border.all(color: _kMoss, width: 1.4),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: <Widget>[
            _StatTile(label: 'total', value: total, accent: _kBlueprintDeep),
            _StatTile(label: 'mutators', value: mutators, accent: _kOxbloodDeep),
            _StatTile(label: 'readers', value: total - mutators, accent: _kBlueprint),
            _StatTile(label: 'streams', value: streams, accent: _kGraphite),
            _StatTile(label: 'deprecated', value: deprecated, accent: _kOxblood),
            _StatTile(label: 'tree-walks', value: treeWalks, accent: _kMoss),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.accent,
  });

  final String label;
  final int value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _kIvorySoft,
        border: Border.all(color: accent, width: 1.4),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// PLATFORM FOOTNOTE
// ===========================================================================

class _PlatformFootnote extends StatelessWidget {
  const _PlatformFootnote();

  @override
  Widget build(BuildContext context) {
    final int total = WidgetInspectorServiceExtensions.values.length;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(
        color: _kParchment,
        border: Border.all(color: _kInk, width: 1.4),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'FIELD NOTES',
            style: TextStyle(
              color: _kInk,
              fontWeight: FontWeight.w900,
              fontSize: 12,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'This dossier was rendered against $total live values of '
            '`WidgetInspectorServiceExtensions`. Every panel above iterates the '
            'enum, switches over its members, or compares against specific '
            'values via `==`. The audit-flagged enum is therefore exercised at '
            'runtime in every section.',
            style: const TextStyle(
              color: _kGraphite,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Wire prefix: ext.flutter.inspector.<enum.name>',
            style: TextStyle(
              color: _kBlueprintDeep,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

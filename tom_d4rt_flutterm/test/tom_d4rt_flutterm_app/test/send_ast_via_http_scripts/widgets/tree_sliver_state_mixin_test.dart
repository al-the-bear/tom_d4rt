import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show SliverLayoutDimensions;

// ---------------------------------------------------------------------------
// TreeSliverStateMixin demonstration — "Forest Explorer".
//
// The target class is `TreeSliverStateMixin<T>`, a framework mixin found in
// `package:flutter/src/widgets/sliver_tree.dart`. It is applied to the
// private `_TreeSliverState<T>` (the State class backing `TreeSliver<T>`)
// and exposes the imperative surface that every `TreeSliverController`
// forwards to:
//
//   bool isExpanded(TreeSliverNode<T> node);
//   bool isActive(TreeSliverNode<T> node);
//   void toggleNode(TreeSliverNode<T> node);
//   void collapseAll();
//   void expandAll();
//   TreeSliverNode<T>? getNodeFor(T content);
//   int? getActiveIndexFor(TreeSliverNode<T> node);
//
// Because the backing state class is private, the normal way to reach the
// mixin from user code is through a `TreeSliverController` — every method
// on the controller is a thin `_state!.X(...)` trampoline onto the mixin.
// This demo binds a controller per tree, wires the mixin's methods to a
// side panel, and paints a bark-and-moss forest visual language around the
// viewport so the branchy feel is unmistakable.
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// Forest palette. Every colour, stroke and radius is a named constant so that
// painters, cards and buttons all share the same tokens.
// ---------------------------------------------------------------------------
const Color _kTsmNavParchment = Color(0xFFF1E7CE);
const Color _kTsmNavParchmentDeep = Color(0xFFE6D8B4);
const Color _kTsmNavParchmentEdge = Color(0xFFD6C290);
const Color _kTsmNavBark = Color(0xFF3F2A15);
const Color _kTsmNavBarkSoft = Color(0xFF5A3E23);
const Color _kTsmNavBarkEdge = Color(0xFF2B1A0A);
const Color _kTsmNavMoss = Color(0xFF4F6B2F);
const Color _kTsmNavMossDeep = Color(0xFF2F4418);
const Color _kTsmNavMossSoft = Color(0xFF7A9A53);
const Color _kTsmNavFern = Color(0xFF6D9046);
const Color _kTsmNavFernGlow = Color(0xFFBFDD8F);
const Color _kTsmNavAmber = Color(0xFFD69A2F);
const Color _kTsmNavAmberDeep = Color(0xFFA06A15);
const Color _kTsmNavCinnabar = Color(0xFFB44A1F);
const Color _kTsmNavShadow = Color(0x33271808);
const Color _kTsmNavBranch = Color(0xFF7B5531);
const Color _kTsmNavBranchGlow = Color(0xFFBF8F4A);

// Motif strokes used by the CustomPainter decorations.
const double _kTsmNavBranchStroke = 2.6;
const double _kTsmNavTwigStroke = 1.4;
const double _kTsmNavCardRadius = 14.0;

// ---------------------------------------------------------------------------
// A small domain model for what the tree actually shows. Each node carries a
// "forest file-system" entry: a name, a kind (folder vs leaf type) and a
// short byline that appears in the breadcrumb readout.
// ---------------------------------------------------------------------------
enum _TsmNavEntryKind {
  grove,
  clearing,
  trunk,
  bough,
  leaf,
  seed,
  nest,
  fungus,
}

class _TsmNavEntry {
  const _TsmNavEntry({
    required this.id,
    required this.name,
    required this.kind,
    this.byline = '',
  });

  final String id;
  final String name;
  final _TsmNavEntryKind kind;
  final String byline;

  @override
  String toString() => name;
}

// Glyph table — used in the leading badge of every tree row so that the
// aesthetic stays forest-shaped even without icons from the icon font.
const Map<_TsmNavEntryKind, String> _kTsmNavGlyph = <_TsmNavEntryKind, String>{
  _TsmNavEntryKind.grove: 'G',
  _TsmNavEntryKind.clearing: 'C',
  _TsmNavEntryKind.trunk: 'T',
  _TsmNavEntryKind.bough: 'B',
  _TsmNavEntryKind.leaf: 'l',
  _TsmNavEntryKind.seed: 's',
  _TsmNavEntryKind.nest: 'n',
  _TsmNavEntryKind.fungus: 'f',
};

Color _kTsmNavColourFor(_TsmNavEntryKind kind) {
  switch (kind) {
    case _TsmNavEntryKind.grove:
      return _kTsmNavMossDeep;
    case _TsmNavEntryKind.clearing:
      return _kTsmNavMoss;
    case _TsmNavEntryKind.trunk:
      return _kTsmNavBark;
    case _TsmNavEntryKind.bough:
      return _kTsmNavBranch;
    case _TsmNavEntryKind.leaf:
      return _kTsmNavFern;
    case _TsmNavEntryKind.seed:
      return _kTsmNavAmber;
    case _TsmNavEntryKind.nest:
      return _kTsmNavCinnabar;
    case _TsmNavEntryKind.fungus:
      return _kTsmNavAmberDeep;
  }
}

String _kTsmNavKindLabel(_TsmNavEntryKind kind) {
  switch (kind) {
    case _TsmNavEntryKind.grove:
      return 'grove';
    case _TsmNavEntryKind.clearing:
      return 'clearing';
    case _TsmNavEntryKind.trunk:
      return 'trunk';
    case _TsmNavEntryKind.bough:
      return 'bough';
    case _TsmNavEntryKind.leaf:
      return 'leaf';
    case _TsmNavEntryKind.seed:
      return 'seed';
    case _TsmNavEntryKind.nest:
      return 'nest';
    case _TsmNavEntryKind.fungus:
      return 'fungus';
  }
}

// ---------------------------------------------------------------------------
// Sample dataset. Two root groves, each with several child boughs, many of
// them carrying leaves or seeds. Six roots in total across two trees so the
// side-by-side comparison in scenario 6 is meaningful.
// ---------------------------------------------------------------------------
List<TreeSliverNode<_TsmNavEntry>> _kTsmNavBuildNorthwoodsTree() {
  return <TreeSliverNode<_TsmNavEntry>>[
    TreeSliverNode<_TsmNavEntry>(
      const _TsmNavEntry(
        id: 'nw.oakwood',
        name: 'Oakwood Grove',
        kind: _TsmNavEntryKind.grove,
        byline: 'mature oaks, moss floor',
      ),
      expanded: true,
      children: <TreeSliverNode<_TsmNavEntry>>[
        TreeSliverNode<_TsmNavEntry>(
          const _TsmNavEntry(
            id: 'nw.oakwood.trunk_a',
            name: 'Old Crooked Trunk',
            kind: _TsmNavEntryKind.trunk,
            byline: 'split at ~3m, hollow',
          ),
          children: <TreeSliverNode<_TsmNavEntry>>[
            TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
              id: 'nw.oakwood.trunk_a.bough_1',
              name: 'Southern Bough',
              kind: _TsmNavEntryKind.bough,
              byline: 'heavy horizontal limb',
            ), children: <TreeSliverNode<_TsmNavEntry>>[
              TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
                id: 'nw.oakwood.trunk_a.bough_1.leaf_1',
                name: 'acorn-cap cluster',
                kind: _TsmNavEntryKind.leaf,
              )),
              TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
                id: 'nw.oakwood.trunk_a.bough_1.leaf_2',
                name: 'lobed leaf fan',
                kind: _TsmNavEntryKind.leaf,
              )),
              TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
                id: 'nw.oakwood.trunk_a.bough_1.nest_1',
                name: 'jay nest',
                kind: _TsmNavEntryKind.nest,
                byline: 'twiggy, noisy',
              )),
            ]),
            TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
              id: 'nw.oakwood.trunk_a.bough_2',
              name: 'Crooked Upper Arm',
              kind: _TsmNavEntryKind.bough,
            ), children: <TreeSliverNode<_TsmNavEntry>>[
              TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
                id: 'nw.oakwood.trunk_a.bough_2.leaf_1',
                name: 'young leaf spray',
                kind: _TsmNavEntryKind.leaf,
              )),
              TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
                id: 'nw.oakwood.trunk_a.bough_2.seed_1',
                name: 'acorn — fat',
                kind: _TsmNavEntryKind.seed,
              )),
              TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
                id: 'nw.oakwood.trunk_a.bough_2.seed_2',
                name: 'acorn — thin',
                kind: _TsmNavEntryKind.seed,
              )),
            ]),
            TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
              id: 'nw.oakwood.trunk_a.fungus_1',
              name: 'bracket fungus',
              kind: _TsmNavEntryKind.fungus,
              byline: 'shelf-like, layered',
            )),
          ],
        ),
        TreeSliverNode<_TsmNavEntry>(
          const _TsmNavEntry(
            id: 'nw.oakwood.trunk_b',
            name: 'Sapling Stand',
            kind: _TsmNavEntryKind.trunk,
            byline: 'young oaks in a line',
          ),
          children: <TreeSliverNode<_TsmNavEntry>>[
            TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
              id: 'nw.oakwood.trunk_b.leaf_1',
              name: 'first-leaf flush',
              kind: _TsmNavEntryKind.leaf,
            )),
            TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
              id: 'nw.oakwood.trunk_b.leaf_2',
              name: 'second-leaf flush',
              kind: _TsmNavEntryKind.leaf,
            )),
            TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
              id: 'nw.oakwood.trunk_b.seed_1',
              name: 'soft acorn',
              kind: _TsmNavEntryKind.seed,
            )),
          ],
        ),
      ],
    ),
    TreeSliverNode<_TsmNavEntry>(
      const _TsmNavEntry(
        id: 'nw.fernhollow',
        name: 'Fern Hollow',
        kind: _TsmNavEntryKind.clearing,
        byline: 'damp, shaded understory',
      ),
      children: <TreeSliverNode<_TsmNavEntry>>[
        TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
          id: 'nw.fernhollow.leaf_1',
          name: 'frond — unfurling',
          kind: _TsmNavEntryKind.leaf,
        )),
        TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
          id: 'nw.fernhollow.leaf_2',
          name: 'frond — mature',
          kind: _TsmNavEntryKind.leaf,
        )),
        TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
          id: 'nw.fernhollow.fungus_1',
          name: 'chanterelle cluster',
          kind: _TsmNavEntryKind.fungus,
        )),
        TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
          id: 'nw.fernhollow.fungus_2',
          name: 'morels — hidden',
          kind: _TsmNavEntryKind.fungus,
        )),
      ],
    ),
    TreeSliverNode<_TsmNavEntry>(
      const _TsmNavEntry(
        id: 'nw.birchwalk',
        name: 'Birch Walk',
        kind: _TsmNavEntryKind.grove,
        byline: 'slender, papery bark',
      ),
      children: <TreeSliverNode<_TsmNavEntry>>[
        TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
          id: 'nw.birchwalk.trunk_a',
          name: 'First Birch',
          kind: _TsmNavEntryKind.trunk,
        ), children: <TreeSliverNode<_TsmNavEntry>>[
          TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
            id: 'nw.birchwalk.trunk_a.leaf_1',
            name: 'catkin',
            kind: _TsmNavEntryKind.leaf,
          )),
          TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
            id: 'nw.birchwalk.trunk_a.leaf_2',
            name: 'toothed leaf',
            kind: _TsmNavEntryKind.leaf,
          )),
          TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
            id: 'nw.birchwalk.trunk_a.nest_1',
            name: 'finch nest',
            kind: _TsmNavEntryKind.nest,
          )),
        ]),
        TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
          id: 'nw.birchwalk.trunk_b',
          name: 'Leaning Birch',
          kind: _TsmNavEntryKind.trunk,
          byline: 'tilts ~15° west',
        ), children: <TreeSliverNode<_TsmNavEntry>>[
          TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
            id: 'nw.birchwalk.trunk_b.leaf_1',
            name: 'papery leaf drift',
            kind: _TsmNavEntryKind.leaf,
          )),
          TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
            id: 'nw.birchwalk.trunk_b.seed_1',
            name: 'winged samara',
            kind: _TsmNavEntryKind.seed,
          )),
        ]),
      ],
    ),
  ];
}

List<TreeSliverNode<_TsmNavEntry>> _kTsmNavBuildSouthwoodsTree() {
  return <TreeSliverNode<_TsmNavEntry>>[
    TreeSliverNode<_TsmNavEntry>(
      const _TsmNavEntry(
        id: 'sw.pineridge',
        name: 'Pine Ridge',
        kind: _TsmNavEntryKind.grove,
        byline: 'needled canopy, resin scent',
      ),
      children: <TreeSliverNode<_TsmNavEntry>>[
        TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
          id: 'sw.pineridge.trunk_a',
          name: 'Red Pine',
          kind: _TsmNavEntryKind.trunk,
        ), children: <TreeSliverNode<_TsmNavEntry>>[
          TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
            id: 'sw.pineridge.trunk_a.leaf_1',
            name: 'needle bundle',
            kind: _TsmNavEntryKind.leaf,
          )),
          TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
            id: 'sw.pineridge.trunk_a.seed_1',
            name: 'pine cone — closed',
            kind: _TsmNavEntryKind.seed,
          )),
          TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
            id: 'sw.pineridge.trunk_a.seed_2',
            name: 'pine cone — open',
            kind: _TsmNavEntryKind.seed,
          )),
          TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
            id: 'sw.pineridge.trunk_a.nest_1',
            name: 'squirrel drey',
            kind: _TsmNavEntryKind.nest,
          )),
        ]),
        TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
          id: 'sw.pineridge.trunk_b',
          name: 'White Pine',
          kind: _TsmNavEntryKind.trunk,
          byline: 'tallest on the ridge',
        ), children: <TreeSliverNode<_TsmNavEntry>>[
          TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
            id: 'sw.pineridge.trunk_b.leaf_1',
            name: 'five-needle bundle',
            kind: _TsmNavEntryKind.leaf,
          )),
          TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
            id: 'sw.pineridge.trunk_b.seed_1',
            name: 'long slim cone',
            kind: _TsmNavEntryKind.seed,
          )),
        ]),
      ],
    ),
    TreeSliverNode<_TsmNavEntry>(
      const _TsmNavEntry(
        id: 'sw.willowbend',
        name: 'Willow Bend',
        kind: _TsmNavEntryKind.clearing,
        byline: 'along the slow creek',
      ),
      children: <TreeSliverNode<_TsmNavEntry>>[
        TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
          id: 'sw.willowbend.trunk_a',
          name: 'Weeping Willow',
          kind: _TsmNavEntryKind.trunk,
        ), children: <TreeSliverNode<_TsmNavEntry>>[
          TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
            id: 'sw.willowbend.trunk_a.bough_1',
            name: 'Drooping Bough',
            kind: _TsmNavEntryKind.bough,
          ), children: <TreeSliverNode<_TsmNavEntry>>[
            TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
              id: 'sw.willowbend.trunk_a.bough_1.leaf_1',
              name: 'slender leaf',
              kind: _TsmNavEntryKind.leaf,
            )),
            TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
              id: 'sw.willowbend.trunk_a.bough_1.leaf_2',
              name: 'leaf curtain',
              kind: _TsmNavEntryKind.leaf,
            )),
          ]),
        ]),
      ],
    ),
    TreeSliverNode<_TsmNavEntry>(
      const _TsmNavEntry(
        id: 'sw.mossbed',
        name: 'Moss Bed',
        kind: _TsmNavEntryKind.clearing,
        byline: 'soft, spongy, always damp',
      ),
      children: <TreeSliverNode<_TsmNavEntry>>[
        TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
          id: 'sw.mossbed.leaf_1',
          name: 'sphagnum mat',
          kind: _TsmNavEntryKind.leaf,
        )),
        TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
          id: 'sw.mossbed.leaf_2',
          name: 'cushion moss',
          kind: _TsmNavEntryKind.leaf,
        )),
        TreeSliverNode<_TsmNavEntry>(const _TsmNavEntry(
          id: 'sw.mossbed.fungus_1',
          name: 'amanita ring',
          kind: _TsmNavEntryKind.fungus,
        )),
      ],
    ),
  ];
}

// Flatten a tree (parents first, depth-first) into a single list of nodes.
// Used to populate the "target node" dropdown.
List<TreeSliverNode<_TsmNavEntry>> _kTsmNavFlatten(
  List<TreeSliverNode<_TsmNavEntry>> roots,
) {
  final List<TreeSliverNode<_TsmNavEntry>> out = <TreeSliverNode<_TsmNavEntry>>[];
  void walk(List<TreeSliverNode<_TsmNavEntry>> list) {
    for (final TreeSliverNode<_TsmNavEntry> n in list) {
      out.add(n);
      if (n.children.isNotEmpty) {
        walk(n.children);
      }
    }
  }

  walk(roots);
  return out;
}

int _kTsmNavDepthOf(TreeSliverNode<_TsmNavEntry> node) {
  int d = 0;
  TreeSliverNode<_TsmNavEntry>? p = node.parent;
  while (p != null) {
    d += 1;
    p = p.parent;
  }
  return d;
}

List<TreeSliverNode<_TsmNavEntry>> _kTsmNavPathOf(
  TreeSliverNode<_TsmNavEntry> node,
) {
  final List<TreeSliverNode<_TsmNavEntry>> path =
      <TreeSliverNode<_TsmNavEntry>>[];
  TreeSliverNode<_TsmNavEntry>? cur = node;
  while (cur != null) {
    path.add(cur);
    cur = cur.parent;
  }
  return path.reversed.toList();
}

// ---------------------------------------------------------------------------
// Entry point. The d4rt harness expects a top-level `dynamic build` that
// returns a MaterialApp.
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: _kTsmNavBuildTheme(),
    home: const _TsmNavForestExplorerPage(),
  );
}

ThemeData _kTsmNavBuildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: _kTsmNavParchment,
    colorScheme: base.colorScheme.copyWith(
      primary: _kTsmNavMossDeep,
      onPrimary: _kTsmNavParchment,
      secondary: _kTsmNavAmber,
      onSecondary: _kTsmNavBarkEdge,
      surface: _kTsmNavParchment,
      onSurface: _kTsmNavBarkEdge,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _kTsmNavBark,
      foregroundColor: _kTsmNavParchment,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: _kTsmNavParchment,
        fontWeight: FontWeight.w700,
        fontSize: 18,
        letterSpacing: 0.4,
      ),
    ),
    textTheme: base.textTheme
        .apply(
          bodyColor: _kTsmNavBarkEdge,
          displayColor: _kTsmNavBarkEdge,
        )
        .copyWith(
          titleLarge: const TextStyle(
            color: _kTsmNavBarkEdge,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
          titleMedium: const TextStyle(
            color: _kTsmNavBarkEdge,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
          bodyMedium: const TextStyle(
            color: _kTsmNavBarkEdge,
            fontSize: 14,
            height: 1.4,
          ),
          labelLarge: const TextStyle(
            color: _kTsmNavParchment,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
    cardTheme: const CardThemeData(
      color: _kTsmNavParchmentDeep,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(_kTsmNavCardRadius)),
        side: BorderSide(color: _kTsmNavParchmentEdge, width: 1.2),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: _kTsmNavParchmentEdge,
      thickness: 1.0,
      space: 8,
    ),
    tooltipTheme: const TooltipThemeData(
      decoration: BoxDecoration(
        color: _kTsmNavBarkEdge,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      textStyle: TextStyle(color: _kTsmNavParchment, fontSize: 12),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(_kTsmNavParchmentDeep),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// The root page. Owns two tree datasets, two TreeSliverController instances
// (each binding to its own TreeSliverStateMixin), the currently-selected
// target node for mixin calls, the animation style choice and a tiny log of
// the last few operations.
// ---------------------------------------------------------------------------
class _TsmNavForestExplorerPage extends StatefulWidget {
  const _TsmNavForestExplorerPage();

  @override
  State<_TsmNavForestExplorerPage> createState() =>
      _TsmNavForestExplorerPageState();
}

class _TsmNavForestExplorerPageState extends State<_TsmNavForestExplorerPage> {
  late final List<TreeSliverNode<_TsmNavEntry>> _northRoots;
  late final List<TreeSliverNode<_TsmNavEntry>> _southRoots;
  late final List<TreeSliverNode<_TsmNavEntry>> _northFlat;
  late final List<TreeSliverNode<_TsmNavEntry>> _southFlat;

  // A TreeSliverController is the public handle that holds a reference to
  // the state's TreeSliverStateMixin and forwards every call to it. We use
  // two controllers so each TreeSliver has its own mixin-backed state —
  // that independence is one of the demo's scenarios.
  final TreeSliverController _northCtl = TreeSliverController();
  final TreeSliverController _southCtl = TreeSliverController();

  // Which of the two trees is the control-bar "active" target.
  _TsmNavWhichTree _activeTree = _TsmNavWhichTree.north;

  // The target node used by "Toggle Selected", "Expand Selected", etc.
  TreeSliverNode<_TsmNavEntry>? _selected;

  // Animation style choice — animated (default) vs snap (noAnimation).
  _TsmNavAnimationChoice _animChoice = _TsmNavAnimationChoice.animated;

  // Operation log — capped at 12 entries for the readout panel.
  final List<_TsmNavLogEntry> _log = <_TsmNavLogEntry>[];

  @override
  void initState() {
    super.initState();
    _northRoots = _kTsmNavBuildNorthwoodsTree();
    _southRoots = _kTsmNavBuildSouthwoodsTree();
    _northFlat = _kTsmNavFlatten(_northRoots);
    _southFlat = _kTsmNavFlatten(_southRoots);
    _selected = _northFlat.isNotEmpty ? _northFlat.first : null;
    _pushLog(
      _TsmNavLogKind.info,
      'initialized two trees with '
      '${_northFlat.length} + ${_southFlat.length} nodes',
    );
  }

  void _pushLog(_TsmNavLogKind kind, String message) {
    final _TsmNavLogEntry entry = _TsmNavLogEntry(kind: kind, message: message);
    if (_log.length >= 12) {
      _log.removeAt(0);
    }
    _log.add(entry);
  }

  List<TreeSliverNode<_TsmNavEntry>> get _activeFlat =>
      _activeTree == _TsmNavWhichTree.north ? _northFlat : _southFlat;

  TreeSliverController get _activeCtl =>
      _activeTree == _TsmNavWhichTree.north ? _northCtl : _southCtl;

  // The controller is ready once its associated state has mounted. We probe
  // that by catching the assertion failure from the first isExpanded() call.
  bool _ctlReady(TreeSliverController c) {
    try {
      if (_activeFlat.isEmpty) return false;
      c.isExpanded(_activeFlat.first);
      return true;
    } catch (_) {
      return false;
    }
  }

  // --- Mixin method invocations --------------------------------------------
  //
  // Every button in the control bar calls one of these. They are wrapped in
  // setState so dependent readouts (breadcrumb, expansion counts, log) update
  // along with the tree.

  void _callExpandAll() {
    final TreeSliverController ctl = _activeCtl;
    if (!_ctlReady(ctl)) {
      _pushLog(_TsmNavLogKind.warn, 'expandAll: controller not bound yet');
      setState(() {});
      return;
    }
    ctl.expandAll(); // forwards to TreeSliverStateMixin.expandAll()
    setState(() {
      _pushLog(
        _TsmNavLogKind.act,
        '${_activeTree.label}.expandAll()  (mixin.expandAll)',
      );
    });
  }

  void _callCollapseAll() {
    final TreeSliverController ctl = _activeCtl;
    if (!_ctlReady(ctl)) {
      _pushLog(_TsmNavLogKind.warn, 'collapseAll: controller not bound yet');
      setState(() {});
      return;
    }
    ctl.collapseAll(); // forwards to TreeSliverStateMixin.collapseAll()
    setState(() {
      _pushLog(
        _TsmNavLogKind.act,
        '${_activeTree.label}.collapseAll()  (mixin.collapseAll)',
      );
    });
  }

  void _callToggleSelected() {
    final TreeSliverController ctl = _activeCtl;
    final TreeSliverNode<_TsmNavEntry>? target = _selected;
    if (!_ctlReady(ctl) || target == null) {
      _pushLog(_TsmNavLogKind.warn,
          'toggleNode: no target or controller not bound');
      setState(() {});
      return;
    }
    if (target.children.isEmpty) {
      _pushLog(_TsmNavLogKind.warn,
          'toggleNode on leaf "${target.content.name}" — no-op');
      setState(() {});
      return;
    }
    ctl.toggleNode(target); // forwards to TreeSliverStateMixin.toggleNode()
    setState(() {
      _pushLog(
        _TsmNavLogKind.act,
        '${_activeTree.label}.toggleNode("${target.content.name}") → '
        'isExpanded=${ctl.isExpanded(target)}',
      );
    });
  }

  void _callExpandSelected() {
    final TreeSliverController ctl = _activeCtl;
    final TreeSliverNode<_TsmNavEntry>? target = _selected;
    if (!_ctlReady(ctl) || target == null) {
      _pushLog(_TsmNavLogKind.warn,
          'expandSelected: no target or controller not bound');
      setState(() {});
      return;
    }
    if (target.children.isEmpty) {
      _pushLog(_TsmNavLogKind.warn,
          'expandSelected on leaf "${target.content.name}" — no-op');
      setState(() {});
      return;
    }
    if (!ctl.isExpanded(target)) {
      ctl.expandNode(target);
      _pushLog(
        _TsmNavLogKind.act,
        '${_activeTree.label}.expandNode("${target.content.name}") '
        '(mixin.toggleNode internally)',
      );
    } else {
      _pushLog(
        _TsmNavLogKind.info,
        '"${target.content.name}" is already expanded',
      );
    }
    setState(() {});
  }

  void _callCollapseSelected() {
    final TreeSliverController ctl = _activeCtl;
    final TreeSliverNode<_TsmNavEntry>? target = _selected;
    if (!_ctlReady(ctl) || target == null) {
      _pushLog(_TsmNavLogKind.warn,
          'collapseSelected: no target or controller not bound');
      setState(() {});
      return;
    }
    if (target.children.isEmpty) {
      _pushLog(_TsmNavLogKind.warn,
          'collapseSelected on leaf "${target.content.name}" — no-op');
      setState(() {});
      return;
    }
    if (ctl.isExpanded(target)) {
      ctl.collapseNode(target);
      _pushLog(
        _TsmNavLogKind.act,
        '${_activeTree.label}.collapseNode("${target.content.name}") '
        '(mixin.toggleNode internally)',
      );
    } else {
      _pushLog(
        _TsmNavLogKind.info,
        '"${target.content.name}" is already collapsed',
      );
    }
    setState(() {});
  }

  void _onSwitchTree(_TsmNavWhichTree t) {
    if (t == _activeTree) return;
    setState(() {
      _activeTree = t;
      _selected = _activeFlat.isNotEmpty ? _activeFlat.first : null;
      _pushLog(
        _TsmNavLogKind.info,
        'switched active target to ${t.label} tree',
      );
    });
  }

  void _onSelectNode(TreeSliverNode<_TsmNavEntry>? n) {
    if (n == null) return;
    setState(() {
      _selected = n;
      _pushLog(
        _TsmNavLogKind.info,
        'selected target → "${n.content.name}"',
      );
    });
  }

  void _onAnimChoice(_TsmNavAnimationChoice c) {
    setState(() {
      _animChoice = c;
      _pushLog(
        _TsmNavLogKind.info,
        'animation style → ${c.label}',
      );
    });
  }

  // --- Introspection via mixin methods, used by the readouts. --------------

  int _countExpanded(
    TreeSliverController ctl,
    List<TreeSliverNode<_TsmNavEntry>> all,
  ) {
    if (!_ctlReady(ctl)) return 0;
    int n = 0;
    for (final TreeSliverNode<_TsmNavEntry> node in all) {
      if (node.children.isEmpty) continue;
      if (ctl.isExpanded(node)) n += 1;
    }
    return n;
  }

  int _countActive(
    TreeSliverController ctl,
    List<TreeSliverNode<_TsmNavEntry>> all,
  ) {
    if (!_ctlReady(ctl)) return 0;
    int n = 0;
    for (final TreeSliverNode<_TsmNavEntry> node in all) {
      if (ctl.isActive(node)) n += 1;
    }
    return n;
  }

  // --- Build ---------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forest Explorer  ·  TreeSliverStateMixin'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'target: ${_selected?.content.name ?? '—'}',
                style: const TextStyle(
                  color: _kTsmNavFernGlow,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints cons) {
            final double w = cons.maxWidth;
            if (w > 1080) {
              return _buildWideLayout();
            }
            return _buildNarrowLayout();
          },
        ),
      ),
    );
  }

  Widget _buildWideLayout() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            width: 360,
            child: _TsmNavControlPanel(
              parent: this,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: _TsmNavPreambleCard(),
                ),
                const SizedBox(height: 12),
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: _TsmNavViewportCard(
                          title: 'Northwoods',
                          subtitle: 'oak, fern hollow, birch walk',
                          isActive: _activeTree == _TsmNavWhichTree.north,
                          tree: TreeSliver<_TsmNavEntry>(
                            controller: _northCtl,
                            tree: _northRoots,
                            toggleAnimationStyle: _animChoice.style(),
                            onNodeToggle: (TreeSliverNode<Object?> n) {
                              _pushLog(
                                _TsmNavLogKind.cb,
                                'north.onNodeToggle: ${n.content}',
                              );
                              setState(() {});
                            },
                            treeNodeBuilder: _kTsmNavTreeNodeBuilder,
                            treeRowExtentBuilder: _kTsmNavRowExtentBuilder,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _TsmNavViewportCard(
                          title: 'Southwoods',
                          subtitle: 'pine ridge, willow bend, moss bed',
                          isActive: _activeTree == _TsmNavWhichTree.south,
                          tree: TreeSliver<_TsmNavEntry>(
                            controller: _southCtl,
                            tree: _southRoots,
                            toggleAnimationStyle: _animChoice.style(),
                            onNodeToggle: (TreeSliverNode<Object?> n) {
                              _pushLog(
                                _TsmNavLogKind.cb,
                                'south.onNodeToggle: ${n.content}',
                              );
                              setState(() {});
                            },
                            treeNodeBuilder: _kTsmNavTreeNodeBuilder,
                            treeRowExtentBuilder: _kTsmNavRowExtentBuilder,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: _TsmNavBreadcrumbCard(
                          selected: _selected,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _TsmNavLogCard(entries: _log),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _TsmNavEpilogueCard(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _TsmNavPreambleCard(),
          const SizedBox(height: 12),
          _TsmNavControlPanel(parent: this),
          const SizedBox(height: 12),
          SizedBox(
            height: 360,
            child: _TsmNavViewportCard(
              title: 'Northwoods',
              subtitle: 'oak, fern hollow, birch walk',
              isActive: _activeTree == _TsmNavWhichTree.north,
              tree: TreeSliver<_TsmNavEntry>(
                controller: _northCtl,
                tree: _northRoots,
                toggleAnimationStyle: _animChoice.style(),
                onNodeToggle: (TreeSliverNode<Object?> n) {
                  _pushLog(_TsmNavLogKind.cb,
                      'north.onNodeToggle: ${n.content}');
                  setState(() {});
                },
                treeNodeBuilder: _kTsmNavTreeNodeBuilder,
                treeRowExtentBuilder: _kTsmNavRowExtentBuilder,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 360,
            child: _TsmNavViewportCard(
              title: 'Southwoods',
              subtitle: 'pine ridge, willow bend, moss bed',
              isActive: _activeTree == _TsmNavWhichTree.south,
              tree: TreeSliver<_TsmNavEntry>(
                controller: _southCtl,
                tree: _southRoots,
                toggleAnimationStyle: _animChoice.style(),
                onNodeToggle: (TreeSliverNode<Object?> n) {
                  _pushLog(_TsmNavLogKind.cb,
                      'south.onNodeToggle: ${n.content}');
                  setState(() {});
                },
                treeNodeBuilder: _kTsmNavTreeNodeBuilder,
                treeRowExtentBuilder: _kTsmNavRowExtentBuilder,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _TsmNavBreadcrumbCard(selected: _selected),
          const SizedBox(height: 12),
          _TsmNavLogCard(entries: _log),
          const SizedBox(height: 12),
          _TsmNavEpilogueCard(),
        ],
      ),
    );
  }
}

enum _TsmNavWhichTree { north, south }

extension _TsmNavWhichTreeX on _TsmNavWhichTree {
  String get label {
    switch (this) {
      case _TsmNavWhichTree.north:
        return 'north';
      case _TsmNavWhichTree.south:
        return 'south';
    }
  }
}

enum _TsmNavAnimationChoice { animated, snap, slow }

extension _TsmNavAnimationChoiceX on _TsmNavAnimationChoice {
  String get label {
    switch (this) {
      case _TsmNavAnimationChoice.animated:
        return 'animated (150ms)';
      case _TsmNavAnimationChoice.snap:
        return 'snap (0ms)';
      case _TsmNavAnimationChoice.slow:
        return 'slow (520ms, easeOutCubic)';
    }
  }

  AnimationStyle style() {
    switch (this) {
      case _TsmNavAnimationChoice.animated:
        return TreeSliver.defaultToggleAnimationStyle;
      case _TsmNavAnimationChoice.snap:
        return AnimationStyle.noAnimation;
      case _TsmNavAnimationChoice.slow:
        return const AnimationStyle(
          duration: Duration(milliseconds: 520),
          curve: Curves.easeOutCubic,
        );
    }
  }
}

enum _TsmNavLogKind { info, act, cb, warn }

class _TsmNavLogEntry {
  const _TsmNavLogEntry({required this.kind, required this.message});
  final _TsmNavLogKind kind;
  final String message;
}

Color _kTsmNavLogColour(_TsmNavLogKind kind) {
  switch (kind) {
    case _TsmNavLogKind.info:
      return _kTsmNavBarkSoft;
    case _TsmNavLogKind.act:
      return _kTsmNavMossDeep;
    case _TsmNavLogKind.cb:
      return _kTsmNavAmberDeep;
    case _TsmNavLogKind.warn:
      return _kTsmNavCinnabar;
  }
}

String _kTsmNavLogTag(_TsmNavLogKind kind) {
  switch (kind) {
    case _TsmNavLogKind.info:
      return 'INFO';
    case _TsmNavLogKind.act:
      return 'ACT ';
    case _TsmNavLogKind.cb:
      return 'CB  ';
    case _TsmNavLogKind.warn:
      return 'WARN';
  }
}

// ---------------------------------------------------------------------------
// Custom tree-node builder. Paints each row in the forest palette, with a
// kind-coloured leading badge, an expand chevron for parent nodes, and a
// soft underline. The chevron taps through `TreeSliver.wrapChildToToggleNode`
// so the mixin's toggle path is exercised both from buttons AND from taps.
// ---------------------------------------------------------------------------
Widget _kTsmNavTreeNodeBuilder(
  BuildContext context,
  TreeSliverNode<Object?> node,
  AnimationStyle toggleAnimationStyle,
) {
  final _TsmNavEntry entry = node.content as _TsmNavEntry;
  final int depth = node.depth ?? 0;
  final bool hasChildren = node.children.isNotEmpty;
  final Duration dur =
      toggleAnimationStyle.duration ?? TreeSliver.defaultAnimationDuration;
  final Curve curve =
      toggleAnimationStyle.curve ?? TreeSliver.defaultAnimationCurve;

  final Color badge = _kTsmNavColourFor(entry.kind);
  final Color rowBg = depth.isEven
      ? _kTsmNavParchment
      : _kTsmNavParchmentDeep.withValues(alpha: 0.75);

  final int? indexRaw =
      TreeSliverController.of(context).getActiveIndexFor(node);
  final String indexLabel =
      indexRaw == null ? '—' : indexRaw.toString().padLeft(2, '0');

  return Container(
    decoration: BoxDecoration(
      color: rowBg,
      border: const Border(
        bottom: BorderSide(color: _kTsmNavParchmentEdge, width: 0.7),
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 36,
          child: Text(
            '#$indexLabel',
            style: const TextStyle(
              color: _kTsmNavBarkSoft,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
        TreeSliver.wrapChildToToggleNode(
          node: node,
          child: SizedBox.square(
            dimension: 28,
            child: hasChildren
                ? AnimatedRotation(
                    turns: node.isExpanded ? 0.25 : 0.0,
                    duration: dur,
                    curve: curve,
                    child: Icon(
                      Icons.play_arrow,
                      size: 16,
                      color: _kTsmNavBranch.withValues(alpha: 0.85),
                    ),
                  )
                : Center(
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _kTsmNavBranch.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 6),
        _TsmNavKindBadge(kind: entry.kind, colour: badge),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                entry.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _kTsmNavBarkEdge,
                  fontSize: 14,
                  fontWeight:
                      hasChildren ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
              if (entry.byline.isNotEmpty)
                Text(
                  entry.byline,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _kTsmNavBarkSoft,
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: badge.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: badge.withValues(alpha: 0.45),
              width: 0.8,
            ),
          ),
          child: Text(
            _kTsmNavKindLabel(entry.kind),
            style: TextStyle(
              color: badge,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    ),
  );
}

double _kTsmNavRowExtentBuilder(
  TreeSliverNode<Object?> node,
  SliverLayoutDimensions dims,
) {
  final _TsmNavEntry entry = node.content as _TsmNavEntry;
  return entry.byline.isEmpty ? 40.0 : 52.0;
}

// ---------------------------------------------------------------------------
// Leading badge. A small square tile carrying the kind glyph.
// ---------------------------------------------------------------------------
class _TsmNavKindBadge extends StatelessWidget {
  const _TsmNavKindBadge({required this.kind, required this.colour});
  final _TsmNavEntryKind kind;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    final String glyph = _kTsmNavGlyph[kind] ?? '?';
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: colour.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: colour.withValues(alpha: 0.7), width: 1.1),
      ),
      alignment: Alignment.center,
      child: Text(
        glyph,
        style: TextStyle(
          color: colour,
          fontWeight: FontWeight.w800,
          fontSize: 13,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sidebar control panel. Exposes every mixin method as a button, the target-
// node picker, the tree-switch, and the animation-style radio group.
// ---------------------------------------------------------------------------
class _TsmNavControlPanel extends StatelessWidget {
  const _TsmNavControlPanel({required this.parent});
  final _TsmNavForestExplorerPageState parent;

  @override
  Widget build(BuildContext context) {
    final TreeSliverController ctl = parent._activeCtl;
    final bool ready = parent._ctlReady(ctl);
    final int expandedCount =
        parent._countExpanded(ctl, parent._activeFlat);
    final int activeCount = parent._countActive(ctl, parent._activeFlat);
    final int totalParents = parent._activeFlat
        .where((TreeSliverNode<_TsmNavEntry> n) => n.children.isNotEmpty)
        .length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _TsmNavSectionTitle(
              label: 'IMPERATIVE CONTROL',
              glyph: '⌘',
            ),
            const SizedBox(height: 6),
            const Text(
              'Each button drives a TreeSliverController, which is nothing '
              'more than a typed handle onto the state\'s '
              'TreeSliverStateMixin. Every call below ultimately lands on a '
              'method declared by that mixin.',
              style: TextStyle(fontSize: 12, color: _kTsmNavBarkSoft),
            ),
            const SizedBox(height: 12),
            _TsmNavTreeSelector(
              current: parent._activeTree,
              onChanged: parent._onSwitchTree,
            ),
            const SizedBox(height: 10),
            _TsmNavMixinButton(
              glyph: '+',
              label: 'expandAll()',
              colour: _kTsmNavMossDeep,
              onPressed: parent._callExpandAll,
            ),
            const SizedBox(height: 6),
            _TsmNavMixinButton(
              glyph: '−',
              label: 'collapseAll()',
              colour: _kTsmNavBark,
              onPressed: parent._callCollapseAll,
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            const _TsmNavSectionTitle(
              label: 'TARGET NODE',
              glyph: '○',
            ),
            const SizedBox(height: 8),
            _TsmNavNodeDropdown(
              nodes: parent._activeFlat,
              selected: parent._selected,
              onChanged: parent._onSelectNode,
            ),
            const SizedBox(height: 10),
            _TsmNavMixinButton(
              glyph: '⇌',
              label: 'toggleNode(selected)',
              colour: _kTsmNavAmberDeep,
              onPressed: parent._callToggleSelected,
            ),
            const SizedBox(height: 6),
            _TsmNavMixinButton(
              glyph: '↧',
              label: 'expand selected',
              colour: _kTsmNavFern,
              onPressed: parent._callExpandSelected,
            ),
            const SizedBox(height: 6),
            _TsmNavMixinButton(
              glyph: '↥',
              label: 'collapse selected',
              colour: _kTsmNavCinnabar,
              onPressed: parent._callCollapseSelected,
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            const _TsmNavSectionTitle(
              label: 'ANIMATION STYLE',
              glyph: '∿',
            ),
            const SizedBox(height: 4),
            _TsmNavAnimPicker(
              current: parent._animChoice,
              onChanged: parent._onAnimChoice,
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            const _TsmNavSectionTitle(
              label: 'MIXIN READOUTS',
              glyph: '⌁',
            ),
            const SizedBox(height: 6),
            _TsmNavReadoutRow(
              label: 'parent nodes',
              value: '$totalParents',
            ),
            _TsmNavReadoutRow(
              label: 'isExpanded() count',
              value: '$expandedCount',
            ),
            _TsmNavReadoutRow(
              label: 'isActive() count',
              value: '$activeCount / ${parent._activeFlat.length}',
            ),
            if (parent._selected != null && ready)
              _TsmNavReadoutRow(
                label: 'getActiveIndexFor(sel)',
                value:
                    '${ctl.getActiveIndexFor(parent._selected!) ?? '—'}',
              ),
            if (parent._selected != null && ready)
              _TsmNavReadoutRow(
                label: 'isExpanded(sel)',
                value: ctl.isExpanded(parent._selected!).toString(),
              ),
            if (parent._selected != null && ready)
              _TsmNavReadoutRow(
                label: 'isActive(sel)',
                value: ctl.isActive(parent._selected!).toString(),
              ),
            const SizedBox(height: 8),
            _TsmNavGetNodeForProbe(parent: parent),
          ],
        ),
      ),
    );
  }
}

class _TsmNavSectionTitle extends StatelessWidget {
  const _TsmNavSectionTitle({required this.label, required this.glyph});
  final String label;
  final String glyph;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kTsmNavBark,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            glyph,
            style: const TextStyle(
              color: _kTsmNavAmber,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: _kTsmNavBark,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _TsmNavTreeSelector extends StatelessWidget {
  const _TsmNavTreeSelector({required this.current, required this.onChanged});
  final _TsmNavWhichTree current;
  final ValueChanged<_TsmNavWhichTree> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _TsmNavPillButton(
            label: 'Northwoods',
            active: current == _TsmNavWhichTree.north,
            onTap: () => onChanged(_TsmNavWhichTree.north),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: _TsmNavPillButton(
            label: 'Southwoods',
            active: current == _TsmNavWhichTree.south,
            onTap: () => onChanged(_TsmNavWhichTree.south),
          ),
        ),
      ],
    );
  }
}

class _TsmNavPillButton extends StatelessWidget {
  const _TsmNavPillButton({
    required this.label,
    required this.active,
    required this.onTap,
  });
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? _kTsmNavMossDeep : _kTsmNavParchment,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: active ? _kTsmNavMossDeep : _kTsmNavParchmentEdge,
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? _kTsmNavParchment : _kTsmNavBarkEdge,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}

class _TsmNavMixinButton extends StatelessWidget {
  const _TsmNavMixinButton({
    required this.glyph,
    required this.label,
    required this.colour,
    required this.onPressed,
  });
  final String glyph;
  final String label;
  final Color colour;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: _kTsmNavShadow,
                blurRadius: 4,
                offset: Offset(0, 1.5),
              ),
            ],
          ),
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: <Widget>[
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _kTsmNavParchment.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  glyph,
                  style: const TextStyle(
                    color: _kTsmNavParchment,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: _kTsmNavParchment,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: _kTsmNavParchment,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TsmNavNodeDropdown extends StatelessWidget {
  const _TsmNavNodeDropdown({
    required this.nodes,
    required this.selected,
    required this.onChanged,
  });
  final List<TreeSliverNode<_TsmNavEntry>> nodes;
  final TreeSliverNode<_TsmNavEntry>? selected;
  final ValueChanged<TreeSliverNode<_TsmNavEntry>?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _kTsmNavParchment,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kTsmNavParchmentEdge, width: 1.1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<TreeSliverNode<_TsmNavEntry>>(
          isExpanded: true,
          value: selected,
          icon: const Icon(Icons.arrow_drop_down, color: _kTsmNavBarkEdge),
          dropdownColor: _kTsmNavParchmentDeep,
          style: const TextStyle(color: _kTsmNavBarkEdge, fontSize: 13),
          items: nodes.map((TreeSliverNode<_TsmNavEntry> n) {
            final int depth = _kTsmNavDepthOf(n);
            final String indent = '  ' * depth;
            final String kindTag = _kTsmNavKindLabel(n.content.kind);
            return DropdownMenuItem<TreeSliverNode<_TsmNavEntry>>(
              value: n,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '$indent${n.content.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    kindTag,
                    style: TextStyle(
                      fontSize: 10,
                      color: _kTsmNavColourFor(n.content.kind),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _TsmNavAnimPicker extends StatelessWidget {
  const _TsmNavAnimPicker({required this.current, required this.onChanged});
  final _TsmNavAnimationChoice current;
  final ValueChanged<_TsmNavAnimationChoice> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _TsmNavAnimationChoice.values
          .map((_TsmNavAnimationChoice c) => _row(c))
          .toList(),
    );
  }

  Widget _row(_TsmNavAnimationChoice c) {
    final bool active = c == current;
    return InkWell(
      onTap: () => onChanged(c),
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Row(
          children: <Widget>[
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? _kTsmNavMossDeep : _kTsmNavParchment,
                border: Border.all(
                  color: active ? _kTsmNavMossDeep : _kTsmNavBarkSoft,
                  width: 1.4,
                ),
              ),
              child: active
                  ? const Center(
                      child: Icon(Icons.check,
                          size: 10, color: _kTsmNavParchment),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                c.label,
                style: TextStyle(
                  color: active ? _kTsmNavBarkEdge : _kTsmNavBarkSoft,
                  fontSize: 13,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TsmNavReadoutRow extends StatelessWidget {
  const _TsmNavReadoutRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: _kTsmNavBarkSoft,
                fontSize: 11.5,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: _kTsmNavBarkEdge,
              fontSize: 12,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _TsmNavGetNodeForProbe extends StatelessWidget {
  const _TsmNavGetNodeForProbe({required this.parent});
  final _TsmNavForestExplorerPageState parent;

  @override
  Widget build(BuildContext context) {
    final TreeSliverController ctl = parent._activeCtl;
    final bool ready = parent._ctlReady(ctl);
    // We probe the mixin's getNodeFor via a known content reference. The
    // controller forwards directly to TreeSliverStateMixin.getNodeFor.
    final TreeSliverNode<Object?>? probe =
        parent._selected == null || !ready
            ? null
            : ctl.getNodeFor(parent._selected!.content);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kTsmNavParchment,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kTsmNavParchmentEdge, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'getNodeFor(selected.content)',
            style: TextStyle(
              color: _kTsmNavBarkSoft,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            probe == null
                ? '— null —'
                : 'depth=${probe.depth ?? '?'}  '
                    'children=${probe.children.length}  '
                    'expanded=${probe.isExpanded}',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: _kTsmNavBarkEdge,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// The viewport card. Wraps a real TreeSliver inside a CustomScrollView and
// paints branch-and-twig motifs behind it via _TsmNavBranchPainter.
// ---------------------------------------------------------------------------
class _TsmNavViewportCard extends StatelessWidget {
  const _TsmNavViewportCard({
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.tree,
  });

  final String title;
  final String subtitle;
  final bool isActive;
  final TreeSliver<_TsmNavEntry> tree;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius:
            const BorderRadius.all(Radius.circular(_kTsmNavCardRadius)),
        side: BorderSide(
          color: isActive ? _kTsmNavMossDeep : _kTsmNavParchmentEdge,
          width: isActive ? 2.2 : 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: isActive ? _kTsmNavMossDeep : _kTsmNavBark,
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: isActive ? _kTsmNavFernGlow : _kTsmNavAmber,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: _kTsmNavParchment,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _kTsmNavParchment.withValues(alpha: 0.75),
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                if (isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _kTsmNavFernGlow.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'ACTIVE',
                      style: TextStyle(
                        color: _kTsmNavFernGlow,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: CustomPaint(
                    painter: _TsmNavBranchPainter(active: isActive),
                  ),
                ),
                Positioned.fill(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.account_tree,
                                  size: 16, color: _kTsmNavBranch),
                              const SizedBox(width: 6),
                              Text(
                                'TreeSliver<_TsmNavEntry> · '
                                'toggleAnimationStyle varies',
                                style: TextStyle(
                                  fontSize: 11,
                                  color:
                                      _kTsmNavBarkSoft.withValues(alpha: 0.9),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      tree,
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 20),
                      ),
                    ],
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

// ---------------------------------------------------------------------------
// Background painter: a vine-like branch that climbs the card's left edge
// with offshoot twigs. Purely decorative; does not hit-test the tree.
// ---------------------------------------------------------------------------
class _TsmNavBranchPainter extends CustomPainter {
  _TsmNavBranchPainter({required this.active});
  final bool active;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bgPaint = Paint()
      ..color = _kTsmNavParchmentDeep
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, bgPaint);

    final Paint branch = Paint()
      ..color = (active ? _kTsmNavMossDeep : _kTsmNavBranch)
          .withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = _kTsmNavBranchStroke;

    final Paint twig = Paint()
      ..color = (active ? _kTsmNavMoss : _kTsmNavBranch)
          .withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = _kTsmNavTwigStroke;

    // Main sinuous stem.
    final Path stem = Path();
    stem.moveTo(18, size.height + 10);
    double y = size.height + 10;
    double x = 18;
    final math.Random r = math.Random(active ? 7 : 13);
    while (y > -10) {
      final double nx = x + (r.nextDouble() - 0.5) * 14;
      final double ny = y - 18;
      stem.quadraticBezierTo(
        (x + nx) / 2 + (r.nextDouble() - 0.5) * 8,
        (y + ny) / 2,
        nx,
        ny,
      );
      // Offshoot.
      if (r.nextDouble() > 0.35) {
        final double dir = r.nextBool() ? 1.0 : -1.0;
        final double len = 20 + r.nextDouble() * 42;
        final double ex = nx + dir * len;
        final double ey = ny - 6 + r.nextDouble() * 12;
        final Path t = Path()
          ..moveTo(nx, ny)
          ..quadraticBezierTo(
            nx + dir * len * 0.5,
            ny - 4,
            ex,
            ey,
          );
        canvas.drawPath(t, twig);
        // tiny terminal dot (a leaf)
        canvas.drawCircle(
          Offset(ex, ey),
          2.4,
          Paint()
            ..color = _kTsmNavFern.withValues(alpha: 0.25)
            ..style = PaintingStyle.fill,
        );
      }
      x = nx;
      y = ny;
    }
    canvas.drawPath(stem, branch);

    // Scattered leaf motes across the background. Even-index motes use the
    // soft-moss swatch, odd-index motes use the branch-glow swatch, so both
    // accent colours appear in the motif.
    final Paint moteA = Paint()
      ..color = (active ? _kTsmNavMossSoft : _kTsmNavAmber)
          .withValues(alpha: 0.10)
      ..style = PaintingStyle.fill;
    final Paint moteB = Paint()
      ..color = (active ? _kTsmNavFernGlow : _kTsmNavBranchGlow)
          .withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 22; i++) {
      final double mx = r.nextDouble() * size.width;
      final double my = r.nextDouble() * size.height;
      canvas.drawCircle(
        Offset(mx, my),
        1.6 + r.nextDouble() * 2.0,
        i.isEven ? moteA : moteB,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TsmNavBranchPainter old) =>
      old.active != active;
}

// ---------------------------------------------------------------------------
// Preamble card — explains what the mixin provides and how it relates to
// TreeSliverController. Styled as a parchment note.
// ---------------------------------------------------------------------------
class _TsmNavPreambleCard extends StatelessWidget {
  const _TsmNavPreambleCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _kTsmNavMossDeep,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Ψ',
                style: TextStyle(
                  color: _kTsmNavFernGlow,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'TreeSliverStateMixin<T>',
                    style: TextStyle(
                      color: _kTsmNavBarkEdge,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'framework mixin · sliver_tree.dart',
                    style: TextStyle(
                      color: _kTsmNavBarkSoft,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'A mixin applied to the (private) state class behind '
                    'TreeSliver<T>. It declares the imperative surface — '
                    'isExpanded, isActive, toggleNode, expandAll, '
                    'collapseAll, getNodeFor, getActiveIndexFor — that '
                    'TreeSliverController forwards to under the hood.',
                    style: TextStyle(
                      color: _kTsmNavBarkEdge,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: const <Widget>[
                      _TsmNavSignaturePill(
                          text: 'isExpanded(TreeSliverNode<T>) → bool'),
                      _TsmNavSignaturePill(
                          text: 'isActive(TreeSliverNode<T>) → bool'),
                      _TsmNavSignaturePill(
                          text: 'toggleNode(TreeSliverNode<T>)'),
                      _TsmNavSignaturePill(text: 'expandAll()'),
                      _TsmNavSignaturePill(text: 'collapseAll()'),
                      _TsmNavSignaturePill(
                          text: 'getNodeFor(T) → TreeSliverNode<T>?'),
                      _TsmNavSignaturePill(
                          text: 'getActiveIndexFor(node) → int?'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Each TreeSliverController holds a single reference to '
                    'one mixin-bearing state, so two independent trees need '
                    'two controllers — the side-by-side Northwoods and '
                    'Southwoods cards below demonstrate that.',
                    style: TextStyle(
                      color: _kTsmNavBarkEdge,
                      fontSize: 12.5,
                      height: 1.45,
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

class _TsmNavSignaturePill extends StatelessWidget {
  const _TsmNavSignaturePill({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _kTsmNavParchment,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kTsmNavParchmentEdge, width: 1),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: _kTsmNavBark,
          fontFamily: 'monospace',
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Breadcrumb card — shows the ancestor path from the root to the selected
// node, using getActiveIndexFor() to annotate each step with its active row.
// ---------------------------------------------------------------------------
class _TsmNavBreadcrumbCard extends StatelessWidget {
  const _TsmNavBreadcrumbCard({required this.selected});
  final TreeSliverNode<_TsmNavEntry>? selected;

  @override
  Widget build(BuildContext context) {
    final List<TreeSliverNode<_TsmNavEntry>> path =
        selected == null ? <TreeSliverNode<_TsmNavEntry>>[] : _kTsmNavPathOf(selected!);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _TsmNavSectionTitle(
              label: 'BREADCRUMB',
              glyph: '↠',
            ),
            const SizedBox(height: 8),
            if (selected == null)
              const Text(
                'No node selected.',
                style: TextStyle(color: _kTsmNavBarkSoft),
              )
            else
              Wrap(
                spacing: 4,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < path.length; i++) ...<Widget>[
                    _TsmNavCrumbChip(
                      entry: path[i].content,
                      isTail: i == path.length - 1,
                    ),
                    if (i < path.length - 1)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Icon(
                          Icons.chevron_right,
                          size: 16,
                          color: _kTsmNavBarkSoft,
                        ),
                      ),
                  ],
                ],
              ),
            const SizedBox(height: 10),
            if (selected != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: _kTsmNavParchment,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _kTsmNavParchmentEdge,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      selected!.content.name,
                      style: const TextStyle(
                        color: _kTsmNavBarkEdge,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'id: ${selected!.content.id}',
                      style: const TextStyle(
                        color: _kTsmNavBarkSoft,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                    if (selected!.content.byline.isNotEmpty)
                      Text(
                        '"${selected!.content.byline}"',
                        style: const TextStyle(
                          color: _kTsmNavBarkSoft,
                          fontSize: 11.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    const SizedBox(height: 6),
                    Row(
                      children: <Widget>[
                        _TsmNavStatChip(
                          label: 'depth',
                          value: '${selected!.depth ?? '?'}',
                        ),
                        const SizedBox(width: 6),
                        _TsmNavStatChip(
                          label: 'children',
                          value: '${selected!.children.length}',
                        ),
                        const SizedBox(width: 6),
                        _TsmNavStatChip(
                          label:
                              selected!.children.isEmpty ? 'leaf' : 'parent',
                          value: '',
                          colour: selected!.children.isEmpty
                              ? _kTsmNavFern
                              : _kTsmNavAmberDeep,
                        ),
                      ],
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

class _TsmNavCrumbChip extends StatelessWidget {
  const _TsmNavCrumbChip({required this.entry, required this.isTail});
  final _TsmNavEntry entry;
  final bool isTail;

  @override
  Widget build(BuildContext context) {
    final Color c = _kTsmNavColourFor(entry.kind);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isTail ? c : c.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.withValues(alpha: 0.65), width: 1),
      ),
      child: Text(
        entry.name,
        style: TextStyle(
          color: isTail ? _kTsmNavParchment : c,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _TsmNavStatChip extends StatelessWidget {
  const _TsmNavStatChip({
    required this.label,
    required this.value,
    this.colour,
  });
  final String label;
  final String value;
  final Color? colour;

  @override
  Widget build(BuildContext context) {
    final Color c = colour ?? _kTsmNavBarkSoft;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: c.withValues(alpha: 0.5), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: c,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          if (value.isNotEmpty) ...<Widget>[
            const SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                color: c,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Operation-log card. Scrolls its own list, oldest at the top.
// ---------------------------------------------------------------------------
class _TsmNavLogCard extends StatelessWidget {
  const _TsmNavLogCard({required this.entries});
  final List<_TsmNavLogEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _TsmNavSectionTitle(
              label: 'OPERATION LOG',
              glyph: '≡',
            ),
            const SizedBox(height: 8),
            Expanded(
              child: entries.isEmpty
                  ? const Center(
                      child: Text(
                        'No operations yet. Try a button.',
                        style: TextStyle(
                          color: _kTsmNavBarkSoft,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: entries.length,
                      itemBuilder: (BuildContext context, int i) {
                        final _TsmNavLogEntry e =
                            entries[entries.length - 1 - i];
                        return _TsmNavLogRow(entry: e);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TsmNavLogRow extends StatelessWidget {
  const _TsmNavLogRow({required this.entry});
  final _TsmNavLogEntry entry;

  @override
  Widget build(BuildContext context) {
    final Color c = _kTsmNavLogColour(entry.kind);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              _kTsmNavLogTag(entry.kind),
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                color: c,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              entry.message,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: _kTsmNavBarkEdge,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Epilogue card — when to use the mixin vs a TreeSliverController.
// ---------------------------------------------------------------------------
class _TsmNavEpilogueCard extends StatelessWidget {
  const _TsmNavEpilogueCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _TsmNavSectionTitle(
              label: 'WHEN TO USE WHICH',
              glyph: '⚖',
            ),
            const SizedBox(height: 8),
            _row(
              glyph: 'M',
              colour: _kTsmNavMossDeep,
              title: 'Reach through a mixin-bearing state directly',
              body: 'when you own the key, want strongly typed nodes of '
                  'type TreeSliverNode<T>, and do not need to look up the '
                  'controller from a descendant context.',
            ),
            const SizedBox(height: 8),
            _row(
              glyph: 'C',
              colour: _kTsmNavAmberDeep,
              title: 'Reach through TreeSliverController',
              body: 'when a descendant widget needs to control the tree via '
                  'TreeSliverController.of(context), or when several widgets '
                  'share a single controller instance across rebuilds.',
            ),
            const SizedBox(height: 8),
            _row(
              glyph: '!',
              colour: _kTsmNavCinnabar,
              title: 'Lifecycle caveats',
              body: 'the key\'s currentState is null before the first '
                  'frame and after disposal; always null-check it, and '
                  'never call expandAll/collapseAll/toggleNode from inside '
                  'a build() — they schedule setState on the tree.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _row({
    required String glyph,
    required Color colour,
    required String title,
    required String body,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            glyph,
            style: const TextStyle(
              color: _kTsmNavParchment,
              fontWeight: FontWeight.w800,
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
                title,
                style: const TextStyle(
                  color: _kTsmNavBarkEdge,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                body,
                style: const TextStyle(
                  color: _kTsmNavBarkSoft,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

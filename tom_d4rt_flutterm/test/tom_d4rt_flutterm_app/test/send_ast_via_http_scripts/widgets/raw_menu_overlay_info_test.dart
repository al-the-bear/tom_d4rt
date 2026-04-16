import 'package:flutter/material.dart';

// ============================================================
// D4rt test script: Deep Demo — RawMenuOverlayInfo
//
// RawMenuOverlayInfo is the immutable data class passed to
// RawMenuAnchor.overlayBuilder. It carries four fields:
//
//   anchorRect       – the anchor widget's bounding box in
//                      overlay-local coordinates
//   overlaySize      – the Size of the overlay the menu lives in
//   position         – optional Offset from MenuController.open()
//   tapRegionGroupId – the Object groupId for TapRegion coordination
//
// The overlayBuilder uses these values to decide WHERE and HOW
// to paint the floating menu panel relative to its anchor.
// ============================================================

// ── Top-level ValueNotifiers (stateless-safe shared state) ──

final ValueNotifier<Offset> _demoAnchorOffset =
    ValueNotifier<Offset>(const Offset(120, 220));
final ValueNotifier<Size> _demoOverlaySize =
    ValueNotifier<Size>(const Size(400, 700));
final ValueNotifier<int> _alignmentIndex = ValueNotifier<int>(0);

// ── Public entry point ──

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5C6BC0)),
    ),
    home: const _RawMenuOverlayInfoDemo(),
  );
}

// ─────────────────────────────────────────────────────────────
// Root scaffold with DefaultTabController
// ─────────────────────────────────────────────────────────────

class _RawMenuOverlayInfoDemo extends StatelessWidget {
  const _RawMenuOverlayInfoDemo();

  static const List<Tab> _tabs = <Tab>[
    Tab(text: 'Hero'),
    Tab(text: 'Live Menu'),
    Tab(text: 'Overlay Info'),
    Tab(text: 'Architecture'),
    Tab(text: 'Alignment'),
    Tab(text: 'Cascade'),
    Tab(text: 'ContextMenu'),
    Tab(text: 'Pitfalls'),
    Tab(text: 'Use Cases'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RawMenuOverlayInfo'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroTab(),
            _LiveMenuTab(),
            _OverlayInfoTab(),
            _ArchitectureTab(),
            _AlignmentTab(),
            _CascadeTab(),
            _ContextMenuTab(),
            _PitfallsTab(),
            _UseCasesTab(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Tab 1 — Hero banner
// ─────────────────────────────────────────────────────────────

class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ── Hero card ──
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[cs.primaryContainer, cs.secondaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.layers_outlined, size: 48, color: cs.primary),
                const SizedBox(height: 12),
                Text(
                  'RawMenuOverlayInfo',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: cs.onPrimaryContainer,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'The immutable positioning payload delivered to every '
                  'RawMenuAnchor.overlayBuilder call. It answers the '
                  'four questions a menu overlay needs to position itself '
                  'correctly inside an Overlay widget.',
                  style: TextStyle(
                    fontSize: 15,
                    color: cs.onSecondaryContainer,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // ── Four-field summary cards ──
          Text(
            'Four fields — four answers',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          _FieldCard(
            icon: Icons.crop_square,
            color: const Color(0xFF1565C0),
            label: 'anchorRect',
            type: 'Rect',
            summary:
                'The bounding rectangle of the anchor widget inside the '
                'overlay coordinate space. Used to align the menu panel '
                'above, below, left, or right of the trigger.',
          ),
          const SizedBox(height: 10),
          _FieldCard(
            icon: Icons.aspect_ratio,
            color: const Color(0xFF2E7D32),
            label: 'overlaySize',
            type: 'Size',
            summary:
                'The full width and height of the containing Overlay. '
                'Lets the builder clamp the menu so it never renders '
                'off-screen.',
          ),
          const SizedBox(height: 10),
          _FieldCard(
            icon: Icons.my_location,
            color: const Color(0xFFC62828),
            label: 'position',
            type: 'Offset?',
            summary:
                'Optional extra offset forwarded from MenuController.open(). '
                'Used for context menus where the tap position matters, '
                'e.g. right-click coordinates.',
          ),
          const SizedBox(height: 10),
          _FieldCard(
            icon: Icons.touch_app,
            color: const Color(0xFF6A1B9A),
            label: 'tapRegionGroupId',
            type: 'Object',
            summary:
                'The TapRegion.groupId shared by all widgets in the menu '
                'system. Pass it to a TapRegion that wraps your menu panel '
                'so outside taps trigger auto-close.',
          ),
          const SizedBox(height: 24),
          // ── Lifecycle hint ──
          _SectionBox(
            title: 'When is RawMenuOverlayInfo created?',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _BulletRow(
                  icon: Icons.looks_one,
                  text:
                      'The app calls MenuController.open() — '
                      'optionally passing an Offset.',
                ),
                _BulletRow(
                  icon: Icons.looks_two,
                  text:
                      'RawMenuAnchor captures the anchor\'s RenderBox '
                      'and converts it to overlay-local coordinates → anchorRect.',
                ),
                _BulletRow(
                  icon: Icons.looks_3,
                  text:
                      'RawMenuAnchor reads the overlay size from the '
                      'Overlay\'s RenderBox → overlaySize.',
                ),
                _BulletRow(
                  icon: Icons.looks_4,
                  text:
                      'A new RawMenuOverlayInfo is constructed and passed '
                      'to overlayBuilder on every rebuild.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // ── Value equality ──
          _SectionBox(
            title: 'Value Equality',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'RawMenuOverlayInfo is @immutable and implements == / hashCode '
                  'over all four fields. Two instances are equal only when '
                  'anchorRect, overlaySize, position, and tapRegionGroupId '
                  'are all equal. This allows Flutter\'s build system to skip '
                  'unnecessary overlay rebuilds.',
                  style: TextStyle(height: 1.5),
                ),
                SizedBox(height: 8),
                _CodeBlock(
                  code: 'const info1 = RawMenuOverlayInfo(\n'
                      '  anchorRect: Rect.fromLTWH(10, 20, 80, 40),\n'
                      '  overlaySize: Size(400, 700),\n'
                      '  tapRegionGroupId: #myMenu,\n'
                      ');\n'
                      'const info2 = RawMenuOverlayInfo(\n'
                      '  anchorRect: Rect.fromLTWH(10, 20, 80, 40),\n'
                      '  overlaySize: Size(400, 700),\n'
                      '  tapRegionGroupId: #myMenu,\n'
                      ');\n'
                      'assert(info1 == info2); // true',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Tab 2 — Live menu demo using RawMenuAnchor
// ─────────────────────────────────────────────────────────────

class _LiveMenuTab extends StatelessWidget {
  const _LiveMenuTab();

  @override
  Widget build(BuildContext context) {
    final MenuController ctrl1 = MenuController();
    final MenuController ctrl2 = MenuController();
    final MenuController ctrl3 = MenuController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Live RawMenuAnchor Demos',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          const Text(
            'Each demo shows a RawMenuAnchor whose overlayBuilder receives '
            'a RawMenuOverlayInfo and uses it for positioning.',
            style: TextStyle(height: 1.5),
          ),
          const SizedBox(height: 24),

          // ── Demo A: Simple below-anchor menu ──
          _SectionBox(
            title: 'A — Simple dropdown (anchors below)',
            child: Column(
              children: <Widget>[
                const Text(
                  'The overlayBuilder reads info.anchorRect to position '
                  'the panel just below the button.',
                  style: TextStyle(fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 12),
                Center(
                  child: RawMenuAnchor(
                    controller: ctrl1,
                    overlayBuilder: (BuildContext ctx, RawMenuOverlayInfo info) {
                      final double left = info.anchorRect.left;
                      final double top = info.anchorRect.bottom + 4;
                      return Positioned(
                        left: left,
                        top: top,
                        child: TapRegion(
                          groupId: info.tapRegionGroupId,
                          onTapOutside: (_) => ctrl1.close(),
                          child: _SimpleMenuPanel(
                            items: const <String>[
                              'New File',
                              'Open…',
                              'Save',
                              'Quit',
                            ],
                            onSelected: (_) => ctrl1.close(),
                          ),
                        ),
                      );
                    },
                    builder: (
                      BuildContext ctx,
                      MenuController c,
                      Widget? child,
                    ) {
                      return FilledButton.icon(
                        onPressed: () =>
                            c.isOpen ? c.close() : c.open(),
                        icon: const Icon(Icons.menu),
                        label: const Text('File Menu'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── Demo B: Right-aligned menu ──
          _SectionBox(
            title: 'B — Right-aligned panel',
            child: Column(
              children: <Widget>[
                const Text(
                  'Uses info.anchorRect.right to align the menu panel\'s '
                  'right edge with the anchor\'s right edge.',
                  style: TextStyle(fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 12),
                Center(
                  child: RawMenuAnchor(
                    controller: ctrl2,
                    overlayBuilder: (
                      BuildContext ctx,
                      RawMenuOverlayInfo info,
                    ) {
                      const double panelWidth = 200;
                      final double right = info.anchorRect.right;
                      final double left =
                          (right - panelWidth).clamp(0, info.overlaySize.width - panelWidth);
                      final double top = info.anchorRect.bottom + 4;
                      return Positioned(
                        left: left,
                        top: top,
                        width: panelWidth,
                        child: TapRegion(
                          groupId: info.tapRegionGroupId,
                          onTapOutside: (_) => ctrl2.close(),
                          child: _SimpleMenuPanel(
                            items: const <String>[
                              'Profile',
                              'Settings',
                              'Sign out',
                            ],
                            onSelected: (_) => ctrl2.close(),
                          ),
                        ),
                      );
                    },
                    builder: (
                      BuildContext ctx,
                      MenuController c,
                      Widget? child,
                    ) {
                      return OutlinedButton.icon(
                        onPressed: () =>
                            c.isOpen ? c.close() : c.open(),
                        icon: const Icon(Icons.account_circle),
                        label: const Text('Account'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── Demo C: Position-offset menu (right-click style) ──
          _SectionBox(
            title: 'C — Position-offset menu (info.position)',
            child: Column(
              children: <Widget>[
                const Text(
                  'MenuController.open(position: offset) forwards the '
                  'tap offset into info.position. The overlayBuilder '
                  'adds it to the anchor\'s top-left corner.',
                  style: TextStyle(fontSize: 13, height: 1.5),
                ),
                const SizedBox(height: 12),
                Center(
                  child: RawMenuAnchor(
                    controller: ctrl3,
                    overlayBuilder: (
                      BuildContext ctx,
                      RawMenuOverlayInfo info,
                    ) {
                      final Offset base = info.anchorRect.topLeft;
                      final Offset tap = info.position ?? Offset.zero;
                      final double left = (base.dx + tap.dx)
                          .clamp(0, info.overlaySize.width - 160);
                      final double top = (base.dy + tap.dy)
                          .clamp(0, info.overlaySize.height - 120);
                      return Positioned(
                        left: left,
                        top: top,
                        child: TapRegion(
                          groupId: info.tapRegionGroupId,
                          onTapOutside: (_) => ctrl3.close(),
                          child: _SimpleMenuPanel(
                            items: const <String>[
                              'Cut',
                              'Copy',
                              'Paste',
                            ],
                            onSelected: (_) => ctrl3.close(),
                          ),
                        ),
                      );
                    },
                    builder: (
                      BuildContext ctx,
                      MenuController c,
                      Widget? child,
                    ) {
                      return GestureDetector(
                        onSecondaryTapDown: (TapDownDetails d) =>
                            c.open(position: d.localPosition),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.amber),
                          ),
                          child: const Text(
                            'Right-click / two-finger tap here',
                            style: TextStyle(fontSize: 13),
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
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Tab 3 — Overlay info concept
// ─────────────────────────────────────────────────────────────

class _OverlayInfoTab extends StatelessWidget {
  const _OverlayInfoTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'RawMenuOverlayInfo — Concepts',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),

          // ── anchorRect deep-dive ──
          _SectionBox(
            title: 'anchorRect — Positioned in overlay space',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'anchorRect is a Rect whose coordinates are relative to the '
                  'Overlay that the menu renders in. This means the top-left '
                  'corner of anchorRect is NOT relative to the widget itself, '
                  'but to the Overlay\'s origin (usually the screen\'s '
                  'top-left when useRootOverlay is true).',
                  style: TextStyle(height: 1.5),
                ),
                const SizedBox(height: 12),
                // Simulation widget
                _AnchorRectSimulator(),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── overlaySize deep-dive ──
          _SectionBox(
            title: 'overlaySize — Available canvas',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'overlaySize gives the full size of the Overlay widget. '
                  'A robust overlayBuilder clamps menu coordinates to avoid '
                  'overflow beyond the overlay boundaries.',
                  style: TextStyle(height: 1.5),
                ),
                const SizedBox(height: 12),
                _CodeBlock(
                  code: '// Clamp a menu so it fits below the anchor\n'
                      'final double left = info.anchorRect.left.clamp(\n'
                      '  0,\n'
                      '  info.overlaySize.width - menuWidth,\n'
                      ');\n'
                      'final double top = info.anchorRect.bottom + 4;\n'
                      'final double clampedTop = top.clamp(\n'
                      '  0,\n'
                      '  info.overlaySize.height - menuHeight,\n'
                      ');',
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.tertiaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.info_outline,
                        color: cs.onTertiaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'When useRootOverlay is true, overlaySize equals '
                          'the full screen size minus system insets. When '
                          'false, it equals the nearest Overlay ancestor size.',
                          style: TextStyle(
                            color: cs.onTertiaryContainer,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── position field ──
          _SectionBox(
            title: 'position — Optional contextual offset',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'position is null unless MenuController.open() was called '
                  'with an explicit Offset. When provided it represents a '
                  'point relative to the anchor\'s top-left corner. The '
                  'overlayBuilder adds anchorRect.topLeft + position to get '
                  'the screen coordinate.',
                  style: TextStyle(height: 1.5),
                ),
                const SizedBox(height: 12),
                _CodeBlock(
                  code: '// Context menu: use tap location\n'
                      'GestureDetector(\n'
                      '  onSecondaryTapDown: (d) =>\n'
                      '      controller.open(position: d.localPosition),\n'
                      '  child: content,\n'
                      ');\n\n'
                      '// In overlayBuilder:\n'
                      'final Offset screenPos = info.position == null\n'
                      '    ? info.anchorRect.bottomLeft\n'
                      '    : info.anchorRect.topLeft + info.position!;',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── tapRegionGroupId ──
          _SectionBox(
            title: 'tapRegionGroupId — Auto-close coordination',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'The TapRegion system allows a group of related widgets to '
                  'share a groupId. When a tap falls outside all TapRegion '
                  'widgets in the group, onTapOutside fires. Pass '
                  'info.tapRegionGroupId to the TapRegion wrapping your menu '
                  'panel to get automatic outside-tap dismissal.',
                  style: TextStyle(height: 1.5),
                ),
                const SizedBox(height: 12),
                _CodeBlock(
                  code: 'overlayBuilder: (ctx, info) {\n'
                      '  return Positioned(\n'
                      '    left: info.anchorRect.left,\n'
                      '    top: info.anchorRect.bottom,\n'
                      '    child: TapRegion(\n'
                      '      groupId: info.tapRegionGroupId,   // ← key\n'
                      '      onTapOutside: (_) => controller.close(),\n'
                      '      child: menuPanel,\n'
                      '    ),\n'
                      '  );\n'
                      '}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Tab 4 — Architecture diagram (CustomPainter)
// ─────────────────────────────────────────────────────────────

class _ArchitectureTab extends StatelessWidget {
  const _ArchitectureTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Architecture Diagram',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'How RawMenuAnchor computes RawMenuOverlayInfo and passes '
            'it to the overlayBuilder.',
            style: TextStyle(height: 1.5),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 480,
            child: CustomPaint(
              painter: _ArchitecturePainter(),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 20),
          _SectionBox(
            title: 'Flow description',
            child: Column(
              children: const <Widget>[
                _BulletRow(
                  icon: Icons.looks_one,
                  text:
                      'MenuController.open(position?) is called by the '
                      'trigger widget.',
                ),
                _BulletRow(
                  icon: Icons.looks_two,
                  text:
                      'RawMenuAnchor\'s state reads its own RenderBox '
                      'and converts global → overlay-local coordinates '
                      'to produce anchorRect.',
                ),
                _BulletRow(
                  icon: Icons.looks_3,
                  text:
                      'The overlay\'s RenderBox provides overlaySize.',
                ),
                _BulletRow(
                  icon: Icons.looks_4,
                  text:
                      'A new RawMenuOverlayInfo is constructed from '
                      'anchorRect, overlaySize, position, tapRegionGroupId.',
                ),
                _BulletRow(
                  icon: Icons.looks_5,
                  text:
                      'overlayBuilder(context, info) is called. Its '
                      'return value is inserted into the Overlay stack.',
                ),
                _BulletRow(
                  icon: Icons.looks_6,
                  text:
                      'TapRegion(groupId: info.tapRegionGroupId) wraps '
                      'the panel so outside taps auto-dismiss.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SectionBox(
            title: 'Coordinate spaces',
            child: Column(
              children: const <Widget>[
                _BulletRow(
                  icon: Icons.circle,
                  text:
                      'Widget tree: coordinates local to each widget\'s '
                      'parent.',
                ),
                _BulletRow(
                  icon: Icons.circle,
                  text:
                      'Overlay space: coordinates relative to the top-left '
                      'of the Overlay widget itself (not always the screen '
                      'top-left).',
                ),
                _BulletRow(
                  icon: Icons.circle,
                  text:
                      'Global space: device-pixel coordinates. '
                      'RawMenuAnchor converts via '
                      'RenderBox.localToGlobal() and '
                      'overlay.globalToLocal().',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Tab 5 — Alignment options
// ─────────────────────────────────────────────────────────────

class _AlignmentTab extends StatelessWidget {
  const _AlignmentTab();

  static const List<String> _labels = <String>[
    'Below left',
    'Below centre',
    'Below right',
    'Above left',
    'Left centre',
    'Right centre',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Alignment Options',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'RawMenuOverlayInfo supplies all coordinates needed to open '
            'a menu in any direction. Below are six common alignment '
            'strategies derived purely from anchorRect and overlaySize.',
            style: TextStyle(height: 1.5),
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<int>(
            valueListenable: _alignmentIndex,
            builder: (BuildContext ctx, int idx, _) {
              return Column(
                children: <Widget>[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List<Widget>.generate(
                      _labels.length,
                      (int i) => ChoiceChip(
                        label: Text(_labels[i]),
                        selected: idx == i,
                        onSelected: (_) => _alignmentIndex.value = i,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _AlignmentDiagram(alignmentIndex: idx),
                  const SizedBox(height: 16),
                  _AlignmentFormula(alignmentIndex: idx),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          _SectionBox(
            title: 'Choosing direction adaptively',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'A production-quality overlayBuilder should choose '
                  'direction based on available space:',
                  style: TextStyle(height: 1.5),
                ),
                SizedBox(height: 8),
                _CodeBlock(
                  code: 'final bool hasSpaceBelow =\n'
                      '    info.overlaySize.height -\n'
                      '        info.anchorRect.bottom >= menuHeight;\n'
                      'final double top = hasSpaceBelow\n'
                      '    ? info.anchorRect.bottom + 4\n'
                      '    : info.anchorRect.top - menuHeight - 4;',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Tab 6 — Cascade menus
// ─────────────────────────────────────────────────────────────

class _CascadeTab extends StatelessWidget {
  const _CascadeTab();

  @override
  Widget build(BuildContext context) {
    final MenuController parentCtrl = MenuController();
    final MenuController subCtrl = MenuController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Cascade / Submenu Positioning',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'In a nested menu, the child RawMenuAnchor lives inside the '
            'parent\'s overlay. It receives its own RawMenuOverlayInfo '
            'relative to the same Overlay. The submenu positions itself '
            'to the right of the parent menu item.',
            style: TextStyle(height: 1.5),
          ),
          const SizedBox(height: 20),
          _SectionBox(
            title: 'Live cascade demo',
            child: Center(
              child: RawMenuAnchor(
                controller: parentCtrl,
                overlayBuilder: (BuildContext ctx, RawMenuOverlayInfo info) {
                  return Positioned(
                    left: info.anchorRect.left,
                    top: info.anchorRect.bottom + 4,
                    child: TapRegion(
                      groupId: info.tapRegionGroupId,
                      onTapOutside: (_) {
                        subCtrl.close();
                        parentCtrl.close();
                      },
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 180,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                dense: true,
                                title: const Text('New'),
                                onTap: () => parentCtrl.close(),
                              ),
                              ListTile(
                                dense: true,
                                title: const Text('Open'),
                                onTap: () => parentCtrl.close(),
                              ),
                              // ── Submenu trigger ──
                              RawMenuAnchor(
                                controller: subCtrl,
                                overlayBuilder: (
                                  BuildContext subCtx,
                                  RawMenuOverlayInfo subInfo,
                                ) {
                                  return Positioned(
                                    left: subInfo.anchorRect.right + 4,
                                    top: subInfo.anchorRect.top,
                                    child: TapRegion(
                                      groupId: subInfo.tapRegionGroupId,
                                      onTapOutside: (_) => subCtrl.close(),
                                      child: Material(
                                        elevation: 6,
                                        borderRadius:
                                            BorderRadius.circular(8),
                                        child: SizedBox(
                                          width: 160,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                dense: true,
                                                title: const Text(
                                                  'Export PDF',
                                                ),
                                                onTap: () {
                                                  subCtrl.close();
                                                  parentCtrl.close();
                                                },
                                              ),
                                              ListTile(
                                                dense: true,
                                                title: const Text(
                                                  'Export PNG',
                                                ),
                                                onTap: () {
                                                  subCtrl.close();
                                                  parentCtrl.close();
                                                },
                                              ),
                                              ListTile(
                                                dense: true,
                                                title: const Text(
                                                  'Export CSV',
                                                ),
                                                onTap: () {
                                                  subCtrl.close();
                                                  parentCtrl.close();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                builder: (
                                  BuildContext subCtx,
                                  MenuController sc,
                                  Widget? _,
                                ) {
                                  return ListTile(
                                    dense: true,
                                    title: const Text('Export ▶'),
                                    onTap: () =>
                                        sc.isOpen ? sc.close() : sc.open(),
                                  );
                                },
                              ),
                              ListTile(
                                dense: true,
                                title: const Text('Close'),
                                onTap: () {
                                  subCtrl.close();
                                  parentCtrl.close();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                builder: (
                  BuildContext ctx,
                  MenuController c,
                  Widget? child,
                ) {
                  return FilledButton.tonal(
                    onPressed: () => c.isOpen ? c.close() : c.open(),
                    child: const Text('File  (tap Export ▶)'),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          _SectionBox(
            title: 'Key formula for submenu positioning',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'The submenu\'s overlayBuilder uses its own '
                  'RawMenuOverlayInfo. The submenu anchor\'s anchorRect '
                  'is the menu item\'s rect in overlay space, enabling '
                  'right-offset positioning.',
                  style: TextStyle(height: 1.5),
                ),
                SizedBox(height: 8),
                _CodeBlock(
                  code: '// Submenu opens to the right of the parent item\n'
                      'left: subInfo.anchorRect.right + 4,\n'
                      'top:  subInfo.anchorRect.top,\n\n'
                      '// Flip left if not enough space on right\n'
                      'final double subLeft = subInfo.anchorRect.right + 4 +\n'
                      '    subMenuWidth > subInfo.overlaySize.width\n'
                      '    ? subInfo.anchorRect.left - subMenuWidth - 4\n'
                      '    : subInfo.anchorRect.right + 4;',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Tab 7 — ContextMenuController demo
// ─────────────────────────────────────────────────────────────

class _ContextMenuTab extends StatelessWidget {
  const _ContextMenuTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'ContextMenuController & Position-Based Menus',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'MenuController.open(position: offset) feeds info.position '
            'in overlayBuilder — the foundation of context menus. '
            'The demo below simulates this with explicit button taps.',
            style: TextStyle(height: 1.5),
          ),
          const SizedBox(height: 20),
          _SectionBox(
            title: 'Programmatic open with position',
            child: _ContextMenuDemo(),
          ),
          const SizedBox(height: 20),
          _SectionBox(
            title: 'Position math in overlayBuilder',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'info.position is in anchor-local space. To get '
                  'overlay-local space, add anchorRect.topLeft:',
                  style: TextStyle(height: 1.5),
                ),
                SizedBox(height: 8),
                _CodeBlock(
                  code: 'final Offset menuOrigin = info.position != null\n'
                      '    ? info.anchorRect.topLeft + info.position!\n'
                      '    : info.anchorRect.bottomLeft;\n\n'
                      '// Clamp to overlay\n'
                      'final double left = menuOrigin.dx.clamp(\n'
                      '    0, info.overlaySize.width - menuWidth);\n'
                      'final double top = menuOrigin.dy.clamp(\n'
                      '    0, info.overlaySize.height - menuHeight);',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SectionBox(
            title: 'Show / hide state tracking',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'MenuController.isOpen is a bool you can read at any '
                  'time. Toggle pattern:',
                  style: TextStyle(height: 1.5),
                ),
                SizedBox(height: 8),
                _CodeBlock(
                  code: 'onPressed: () =>\n'
                      '    controller.isOpen\n'
                      '        ? controller.close()\n'
                      '        : controller.open(position: offset),',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SectionBox(
            title: 'info.position — null vs non-null semantics',
            child: Column(
              children: <Widget>[
                _InfoTable(
                  headers: const <String>['Scenario', 'info.position'],
                  rows: const <List<String>>[
                    [
                      'controller.open() — no arg',
                      'null → use anchorRect.bottomLeft',
                    ],
                    [
                      'controller.open(position: p)',
                      'p (anchor-local offset)',
                    ],
                    [
                      'Right-click at local (30, 50)',
                      'Offset(30, 50)',
                    ],
                    [
                      'Long-press at local (80, 120)',
                      'Offset(80, 120)',
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Tab 8 — Pitfalls
// ─────────────────────────────────────────────────────────────

class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Common Pitfalls',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _PitfallCard(
            index: 1,
            title: 'Overflow off screen',
            description:
                'Placing the menu at anchorRect.bottomLeft without clamping '
                'to overlaySize causes the panel to render outside the visible '
                'area on small screens or when the anchor is near an edge.',
            fix: '// Always clamp:\n'
                'left: info.anchorRect.left.clamp(\n'
                '    0, info.overlaySize.width - panelWidth),\n'
                'top: info.anchorRect.bottom.clamp(\n'
                '    0, info.overlaySize.height - panelHeight),',
            color: const Color(0xFFB71C1C),
          ),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 2,
            title: 'Forgetting tapRegionGroupId',
            description:
                'Omitting TapRegion(groupId: info.tapRegionGroupId) means '
                'outside taps are never reported to onTapOutside, so the menu '
                'stays open when the user clicks elsewhere.',
            fix: 'TapRegion(\n'
                '  groupId: info.tapRegionGroupId,\n'
                '  onTapOutside: (_) => controller.close(),\n'
                '  child: menuPanel,\n'
                ')',
            color: const Color(0xFFE65100),
          ),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 3,
            title: 'Z-order: menu behind other overlays',
            description:
                'When useRootOverlay is false the menu is rendered in the '
                'nearest Overlay ancestor, which may be below SnackBars, '
                'dialogs, or other overlays using the root Overlay.',
            fix: '// Use root overlay for always-on-top menus:\n'
                'RawMenuAnchor(\n'
                '  useRootOverlay: true,\n'
                '  ...\n'
                ')',
            color: const Color(0xFF1A237E),
          ),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 4,
            title: 'Nested menu tap interference',
            description:
                'Without a shared TapRegion groupId, tapping a submenu item '
                'may trigger onTapOutside on the parent menu, closing it '
                'before the submenu action fires.',
            fix: '// Ensure parent and submenu share the same groupId:\n'
                'TapRegion(\n'
                '  groupId: parentInfo.tapRegionGroupId,  // same group\n'
                '  child: submenuPanel,\n'
                ')',
            color: const Color(0xFF004D40),
          ),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 5,
            title: 'anchorRect is stale after scroll',
            description:
                'RawMenuAnchor automatically closes open menus when a '
                'Scrollable ancestor scrolls. If you bypass this (custom '
                'implementation), anchorRect will be stale and the menu '
                'will float at the wrong position.',
            fix: '// Let RawMenuAnchor manage scroll-close automatically.\n'
                '// If custom: re-open with updated position on scroll.',
            color: const Color(0xFF4A148C),
          ),
          const SizedBox(height: 12),
          _PitfallCard(
            index: 6,
            title: 'Rebuilding MenuController inside build()',
            description:
                'Creating MenuController() inside the build method of a '
                'StatelessWidget creates a new controller on every rebuild, '
                'detaching any open menu. Use a top-level or field-level '
                'controller.',
            fix: '// Correct: top-level or field\n'
                'final MenuController _ctrl = MenuController();\n\n'
                '// Wrong: inside build\n'
                'Widget build(ctx) {\n'
                '  final c = MenuController(); // recreated every rebuild\n'
                '  return RawMenuAnchor(controller: c, ...);\n'
                '}',
            color: const Color(0xFF37474F),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Tab 9 — Use cases
// ─────────────────────────────────────────────────────────────

class _UseCasesTab extends StatelessWidget {
  const _UseCasesTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Use Cases',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'Six scenarios where RawMenuAnchor + RawMenuOverlayInfo '
            'is the right tool.',
            style: TextStyle(height: 1.5),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.9,
            children: const <Widget>[
              _UseCaseCard(
                icon: Icons.menu,
                title: 'Custom Dropdown',
                description:
                    'Replace DropdownButton with a fully custom panel. '
                    'overlayBuilder positions the list below the trigger '
                    'using anchorRect.bottom.',
                accentColor: Color(0xFF1565C0),
              ),
              _UseCaseCard(
                icon: Icons.mouse,
                title: 'Right-click Context Menu',
                description:
                    'Use info.position (forwarded from tap coordinates) '
                    'to open a context menu exactly at the pointer location.',
                accentColor: Color(0xFFC62828),
              ),
              _UseCaseCard(
                icon: Icons.more_vert,
                title: 'Three-dot Action Menu',
                description:
                    'Anchor to an icon button; position the compact action '
                    'list below-right. Clamp with overlaySize to stay visible.',
                accentColor: Color(0xFF2E7D32),
              ),
              _UseCaseCard(
                icon: Icons.arrow_right,
                title: 'Cascading Menu',
                description:
                    'Nest RawMenuAnchor widgets. Child\'s anchorRect '
                    'describes the parent item; open sub-panel to its right.',
                accentColor: Color(0xFF6A1B9A),
              ),
              _UseCaseCard(
                icon: Icons.emoji_emotions,
                title: 'Emoji / Color Picker',
                description:
                    'Overlays a picker panel anchored to a toolbar button. '
                    'Uses overlaySize to keep the grid fully on-screen.',
                accentColor: Color(0xFFE65100),
              ),
              _UseCaseCard(
                icon: Icons.search,
                title: 'Autocomplete Dropdown',
                description:
                    'Open a suggestion list below a text field anchor. '
                    'anchorRect.width constrains the panel to match the '
                    'field width.',
                accentColor: Color(0xFF00695C),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SectionBox(
            title: 'API cheat sheet',
            child: Column(
              children: <Widget>[
                _InfoTable(
                  headers: const <String>['Member', 'Type', 'Purpose'],
                  rows: const <List<String>>[
                    [
                      'anchorRect',
                      'Rect',
                      'Anchor bounding box in overlay coords',
                    ],
                    [
                      'overlaySize',
                      'Size',
                      'Full size of containing Overlay',
                    ],
                    [
                      'position',
                      'Offset?',
                      'Extra offset from MenuController.open()',
                    ],
                    [
                      'tapRegionGroupId',
                      'Object',
                      'TapRegion group for outside-tap dismissal',
                    ],
                    [
                      '==  /  hashCode',
                      '—',
                      'Value equality over all four fields',
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                _InfoTable(
                  headers: const <String>['RawMenuAnchor prop', 'Role'],
                  rows: const <List<String>>[
                    ['controller (required)', 'MenuController to open/close'],
                    [
                      'overlayBuilder (required)',
                      'Builds overlay; receives RawMenuOverlayInfo',
                    ],
                    ['builder', 'Builds anchor trigger widget'],
                    ['useRootOverlay', 'true → root Overlay; false → nearest'],
                    [
                      'consumeOutsideTaps',
                      'Whether outside taps are swallowed',
                    ],
                    [
                      'onOpenRequested',
                      'Intercept open; trigger animations',
                    ],
                    [
                      'onCloseRequested',
                      'Intercept close; finish animations',
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// Reusable helper widgets
// ══════════════════════════════════════════════════════════════

class _FieldCard extends StatelessWidget {
  const _FieldCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.type,
    required this.summary,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String type;
  final String summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: color.withAlpha(120)),
        borderRadius: BorderRadius.circular(10),
        color: color.withAlpha(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color.withAlpha(30),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'monospace',
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(summary, style: const TextStyle(fontSize: 13, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionBox extends StatelessWidget {
  const _SectionBox({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  const _BulletRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 13, height: 1.4)),
          ),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Color(0xFFCDCDCD),
          height: 1.5,
        ),
      ),
    );
  }
}

class _SimpleMenuPanel extends StatelessWidget {
  const _SimpleMenuPanel({
    required this.items,
    required this.onSelected,
  });

  final List<String> items;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 160,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: items
              .map(
                (String item) => ListTile(
                  dense: true,
                  title: Text(item),
                  onTap: () => onSelected(item),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// ── Simulator showing anchorRect visually ──

class _AnchorRectSimulator extends StatelessWidget {
  const _AnchorRectSimulator();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Offset>(
      valueListenable: _demoAnchorOffset,
      builder: (BuildContext ctx, Offset anchorOffset, _) {
        return ValueListenableBuilder<Size>(
          valueListenable: _demoOverlaySize,
          builder: (BuildContext ctx2, Size overlaySize, _) {
            const Size anchorSize = Size(120, 44);
            final Rect anchorRect =
                Rect.fromLTWH(anchorOffset.dx, anchorOffset.dy, anchorSize.width, anchorSize.height);
            // Simulate a menu panel below
            const double panelW = 140;
            const double panelH = 100;
            final double menuLeft =
                anchorRect.left.clamp(0, overlaySize.width - panelW);
            final double menuTop = anchorRect.bottom + 6;
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 300,
                  child: CustomPaint(
                    painter: _AnchorSimPainter(
                      anchorRect: anchorRect,
                      overlaySize: overlaySize,
                      menuLeft: menuLeft,
                      menuTop: menuTop,
                      panelW: panelW,
                      panelH: panelH,
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'anchorRect = Rect.fromLTWH('
                  '${anchorRect.left.toStringAsFixed(0)}, '
                  '${anchorRect.top.toStringAsFixed(0)}, '
                  '${anchorRect.width.toStringAsFixed(0)}, '
                  '${anchorRect.height.toStringAsFixed(0)})',
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
                Text(
                  'overlaySize = Size('
                  '${overlaySize.width.toStringAsFixed(0)}, '
                  '${overlaySize.height.toStringAsFixed(0)})',
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _AnchorSimPainter extends CustomPainter {
  const _AnchorSimPainter({
    required this.anchorRect,
    required this.overlaySize,
    required this.menuLeft,
    required this.menuTop,
    required this.panelW,
    required this.panelH,
  });

  final Rect anchorRect;
  final Size overlaySize;
  final double menuLeft;
  final double menuTop;
  final double panelW;
  final double panelH;

  @override
  void paint(Canvas canvas, Size size) {
    // Scale factor to fit the overlay into the paint area
    final double scaleX = size.width / overlaySize.width;
    final double scaleY = size.height / overlaySize.height;
    final double scale = scaleX < scaleY ? scaleX : scaleY;

    // Overlay background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, overlaySize.width * scale, overlaySize.height * scale),
      Paint()..color = const Color(0xFFEEEEEE),
    );

    // Anchor widget
    final Rect scaledAnchor = Rect.fromLTWH(
      anchorRect.left * scale,
      anchorRect.top * scale,
      anchorRect.width * scale,
      anchorRect.height * scale,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(scaledAnchor, const Radius.circular(4)),
      Paint()..color = const Color(0xFF1565C0),
    );
    _drawLabel(canvas, scaledAnchor.center, 'Anchor', const Color(0xFFFFFFFF), 10);

    // Menu panel
    final Rect scaledMenu = Rect.fromLTWH(
      menuLeft * scale,
      menuTop * scale,
      panelW * scale,
      panelH * scale,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(scaledMenu, const Radius.circular(4)),
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(scaledMenu, const Radius.circular(4)),
      Paint()
        ..color = const Color(0xFF1565C0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    _drawLabel(
      canvas,
      scaledMenu.center,
      'Menu panel',
      const Color(0xFF1565C0),
      9,
    );

    // Arrow
    final Offset arrowStart = scaledAnchor.bottomCenter;
    final Offset arrowEnd = Offset(scaledMenu.left + scaledMenu.width / 2, scaledMenu.top - 2);
    canvas.drawLine(
      arrowStart,
      arrowEnd,
      Paint()
        ..color = const Color(0xFFC62828)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );

    // Overlay border
    canvas.drawRect(
      Rect.fromLTWH(0, 0, overlaySize.width * scale, overlaySize.height * scale),
      Paint()
        ..color = const Color(0xFF9E9E9E)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  void _drawLabel(
    Canvas canvas,
    Offset center,
    String text,
    Color color,
    double fontSize,
  ) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: fontSize),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      Offset(center.dx - tp.width / 2, center.dy - tp.height / 2),
    );
  }

  @override
  bool shouldRepaint(_AnchorSimPainter old) =>
      old.anchorRect != anchorRect || old.overlaySize != overlaySize;
}

// ── Architecture painter ──

class _ArchitecturePainter extends CustomPainter {
  const _ArchitecturePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;

    // Boxes
    final List<(Rect, String, Color)> boxes = <(Rect, String, Color)>[
      (
        Rect.fromCenter(center: Offset(cx, 40), width: 200, height: 36),
        'MenuController.open(pos?)',
        const Color(0xFF1565C0),
      ),
      (
        Rect.fromCenter(center: Offset(cx, 120), width: 220, height: 36),
        'RawMenuAnchor._buildOverlay()',
        const Color(0xFF2E7D32),
      ),
      (
        Rect.fromCenter(center: Offset(cx - 100, 200), width: 180, height: 36),
        'Read anchor RenderBox',
        const Color(0xFF6A1B9A),
      ),
      (
        Rect.fromCenter(center: Offset(cx + 100, 200), width: 180, height: 36),
        'Read overlay RenderBox',
        const Color(0xFF6A1B9A),
      ),
      (
        Rect.fromCenter(center: Offset(cx, 290), width: 260, height: 44),
        'RawMenuOverlayInfo(\n  anchorRect, overlaySize,\n  position, tapRegionGroupId)',
        const Color(0xFFC62828),
      ),
      (
        Rect.fromCenter(center: Offset(cx, 380), width: 220, height: 36),
        'overlayBuilder(context, info)',
        const Color(0xFF00695C),
      ),
      (
        Rect.fromCenter(center: Offset(cx, 450), width: 200, height: 36),
        'Positioned menu panel in Overlay',
        const Color(0xFF37474F),
      ),
    ];

    final Paint boxPaint = Paint()..style = PaintingStyle.fill;
    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (final (Rect r, String label, Color c) in boxes) {
      boxPaint.color = c.withAlpha(30);
      borderPaint.color = c;
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(6)),
        boxPaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(6)),
        borderPaint,
      );
      _drawCentredText(canvas, r.center, label, c, 10);
    }

    // Connector lines
    final Paint linePaint = Paint()
      ..color = const Color(0xFF757575)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // box0 → box1
    canvas.drawLine(
      Offset(cx, 58),
      Offset(cx, 102),
      linePaint,
    );
    // box1 → box2
    canvas.drawLine(
      Offset(cx, 138),
      Offset(cx - 100, 182),
      linePaint,
    );
    // box1 → box3
    canvas.drawLine(
      Offset(cx, 138),
      Offset(cx + 100, 182),
      linePaint,
    );
    // box2 → box4
    canvas.drawLine(
      Offset(cx - 100, 218),
      Offset(cx - 40, 268),
      linePaint,
    );
    // box3 → box4
    canvas.drawLine(
      Offset(cx + 100, 218),
      Offset(cx + 40, 268),
      linePaint,
    );
    // box4 → box5
    canvas.drawLine(
      Offset(cx, 312),
      Offset(cx, 362),
      linePaint,
    );
    // box5 → box6
    canvas.drawLine(
      Offset(cx, 398),
      Offset(cx, 432),
      linePaint,
    );
  }

  void _drawCentredText(
    Canvas canvas,
    Offset center,
    String text,
    Color color,
    double fontSize,
  ) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 240);
    tp.paint(
      canvas,
      Offset(center.dx - tp.width / 2, center.dy - tp.height / 2),
    );
  }

  @override
  bool shouldRepaint(_ArchitecturePainter _) => false;
}

// ── Alignment diagram ──

class _AlignmentDiagram extends StatelessWidget {
  const _AlignmentDiagram({required this.alignmentIndex});

  final int alignmentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: CustomPaint(
        painter: _AlignmentPainter(alignmentIndex: alignmentIndex),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _AlignmentPainter extends CustomPainter {
  const _AlignmentPainter({required this.alignmentIndex});

  final int alignmentIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    const double aw = 120;
    const double ah = 40;
    const double mw = 100;
    const double mh = 80;
    const double gap = 6;

    // Draw overlay boundary
    canvas.drawRect(
      Rect.fromLTWH(4, 4, size.width - 8, size.height - 8),
      Paint()
        ..color = const Color(0xFFEEEEEE)
        ..style = PaintingStyle.fill,
    );
    canvas.drawRect(
      Rect.fromLTWH(4, 4, size.width - 8, size.height - 8),
      Paint()
        ..color = const Color(0xFF9E9E9E)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    // Anchor rect centred
    final Rect anchor =
        Rect.fromCenter(center: Offset(cx, cy), width: aw, height: ah);
    canvas.drawRRect(
      RRect.fromRectAndRadius(anchor, const Radius.circular(4)),
      Paint()..color = const Color(0xFF1565C0),
    );
    _label(canvas, anchor.center, 'Anchor', Colors.white, 10);

    // Compute menu rect based on alignment
    final Offset menuOrigin = _menuOrigin(anchor, size, mw, mh, gap);
    final Rect menu = Rect.fromLTWH(menuOrigin.dx, menuOrigin.dy, mw, mh);

    canvas.drawRRect(
      RRect.fromRectAndRadius(menu, const Radius.circular(4)),
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(menu, const Radius.circular(4)),
      Paint()
        ..color = const Color(0xFFC62828)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
    _label(canvas, menu.center, 'Menu', const Color(0xFFC62828), 10);

    // Dashed connector
    _drawDashed(canvas, anchor.center, menu.center, const Color(0xFF757575));
  }

  Offset _menuOrigin(
    Rect anchor,
    Size canvas,
    double mw,
    double mh,
    double gap,
  ) {
    switch (alignmentIndex) {
      case 0: // Below left
        return Offset(anchor.left, anchor.bottom + gap);
      case 1: // Below centre
        return Offset(anchor.center.dx - mw / 2, anchor.bottom + gap);
      case 2: // Below right
        return Offset(anchor.right - mw, anchor.bottom + gap);
      case 3: // Above left
        return Offset(anchor.left, anchor.top - mh - gap);
      case 4: // Left centre
        return Offset(anchor.left - mw - gap, anchor.center.dy - mh / 2);
      case 5: // Right centre
        return Offset(anchor.right + gap, anchor.center.dy - mh / 2);
      default:
        return Offset(anchor.left, anchor.bottom + gap);
    }
  }

  void _drawDashed(Canvas canvas, Offset start, Offset end, Color color) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 1;
    const double dashLen = 4;
    const double gapLen = 3;
    final double total = (end - start).distance;
    double drawn = 0;
    final Offset dir = (end - start) / total;
    while (drawn < total) {
      final Offset s = start + dir * drawn;
      final double segEnd = (drawn + dashLen).clamp(0, total);
      final Offset e = start + dir * segEnd;
      canvas.drawLine(s, e, p);
      drawn += dashLen + gapLen;
    }
  }

  void _label(Canvas c, Offset o, String t, Color col, double sz) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: t, style: TextStyle(color: col, fontSize: sz)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(c, Offset(o.dx - tp.width / 2, o.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(_AlignmentPainter old) =>
      old.alignmentIndex != alignmentIndex;
}

class _AlignmentFormula extends StatelessWidget {
  const _AlignmentFormula({required this.alignmentIndex});

  final int alignmentIndex;

  static const List<String> _formulas = <String>[
    'left: anchorRect.left\ntop:  anchorRect.bottom + gap',
    'left: anchorRect.center.dx - menuWidth / 2\ntop:  anchorRect.bottom + gap',
    'left: anchorRect.right - menuWidth\ntop:  anchorRect.bottom + gap',
    'left: anchorRect.left\ntop:  anchorRect.top - menuHeight - gap',
    'left: anchorRect.left - menuWidth - gap\ntop:  anchorRect.center.dy - menuHeight / 2',
    'left: anchorRect.right + gap\ntop:  anchorRect.center.dy - menuHeight / 2',
  ];

  @override
  Widget build(BuildContext context) {
    return _CodeBlock(code: _formulas[alignmentIndex]);
  }
}

// ── Context menu demo widget ──

class _ContextMenuDemo extends StatelessWidget {
  const _ContextMenuDemo();

  @override
  Widget build(BuildContext context) {
    final MenuController ctrl = MenuController();
    return Column(
      children: <Widget>[
        const Text(
          'Tap the coloured positions to open the menu at that exact point.',
          style: TextStyle(fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 12),
        RawMenuAnchor(
          controller: ctrl,
          overlayBuilder: (BuildContext ctx, RawMenuOverlayInfo info) {
            final Offset tap = info.position ?? Offset.zero;
            final Offset base = info.anchorRect.topLeft;
            final double left =
                (base.dx + tap.dx).clamp(0, info.overlaySize.width - 160);
            final double top =
                (base.dy + tap.dy).clamp(0, info.overlaySize.height - 130);
            return Positioned(
              left: left,
              top: top,
              child: TapRegion(
                groupId: info.tapRegionGroupId,
                onTapOutside: (_) => ctrl.close(),
                child: _SimpleMenuPanel(
                  items: const <String>['Cut', 'Copy', 'Paste', 'Select All'],
                  onSelected: (_) => ctrl.close(),
                ),
              ),
            );
          },
          builder: (BuildContext ctx, MenuController c, Widget? child) {
            return SizedBox(
              width: double.infinity,
              height: 120,
              child: Stack(
                children: <Widget>[
                  // Background
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                  ),
                  // Three tap targets at different positions
                  _TapTarget(
                    offset: const Offset(20, 20),
                    label: 'Pos A',
                    color: const Color(0xFF1565C0),
                    onTap: () => c.open(position: const Offset(20, 20)),
                  ),
                  _TapTarget(
                    offset: const Offset(140, 50),
                    label: 'Pos B',
                    color: const Color(0xFFC62828),
                    onTap: () => c.open(position: const Offset(140, 50)),
                  ),
                  _TapTarget(
                    offset: const Offset(240, 20),
                    label: 'Pos C',
                    color: const Color(0xFF2E7D32),
                    onTap: () => c.open(position: const Offset(240, 20)),
                  ),
                  ?child,
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _TapTarget extends StatelessWidget {
  const _TapTarget({
    required this.offset,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final Offset offset;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
    );
  }
}

// ── Pitfall card ──

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({
    required this.index,
    required this.title,
    required this.description,
    required this.fix,
    required this.color,
  });

  final int index;
  final String title;
  final String description;
  final String fix;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withAlpha(14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: color,
                radius: 13,
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(fontSize: 13, height: 1.4)),
          const SizedBox(height: 8),
          _CodeBlock(code: fix),
        ],
      ),
    );
  }
}

// ── Use case card ──

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.accentColor,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accentColor.withAlpha(18),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accentColor.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: accentColor, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: accentColor,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(fontSize: 11, height: 1.4),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Info table ──

class _InfoTable extends StatelessWidget {
  const _InfoTable({required this.headers, required this.rows});

  final List<String> headers;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Table(
      border: TableBorder.all(color: cs.outlineVariant),
      defaultColumnWidth: const FlexColumnWidth(),
      children: <TableRow>[
        TableRow(
          decoration: BoxDecoration(color: cs.primaryContainer),
          children: headers
              .map(
                (String h) => Padding(
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    h,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        ...rows.map(
          (List<String> row) => TableRow(
            children: row
                .map(
                  (String cell) => Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(cell, style: const TextStyle(fontSize: 12)),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

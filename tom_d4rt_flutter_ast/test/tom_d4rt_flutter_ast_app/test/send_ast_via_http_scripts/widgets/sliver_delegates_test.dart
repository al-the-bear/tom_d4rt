// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SliverChildBuilderDelegate, SliverChildListDelegate,
// SliverChildDelegate, SliverAnimatedList, SliverSafeArea, SliverVisibility,
// SliverLayoutBuilder.
//
// Deep Demo theme: a Librarian's Card-Catalog Drawer.
// Each delegate is a different way of arranging index cards in a wooden
// drawer — some cards are pre-printed and stacked (eager), others are typed
// on-demand by the librarian as the patron pulls the drawer (lazy).
import 'package:flutter/material.dart';

// Theme palette — wood, brass, parchment, ink, ribbon.
const Color _kWood = Color(0xFF6E4B2A);
const Color _kWoodDark = Color(0xFF3F2A18);
const Color _kWoodLight = Color(0xFFA1714A);
const Color _kBrass = Color(0xFFB08338);
const Color _kBrassDark = Color(0xFF7A5A20);
const Color _kParchment = Color(0xFFF6ECD4);
const Color _kParchmentDeep = Color(0xFFE6D6A8);
const Color _kInk = Color(0xFF2A1F12);
const Color _kRibbon = Color(0xFF8C2A2A);
const Color _kStamp = Color(0xFF1F4F2A);

dynamic build(BuildContext context) {
  print('SliverDelegates Deep Demo — Librarian\'s Card-Catalog Drawer');
  print('Boot sequence: oiling drawer rails, sharpening pencils, '
      'unrolling the catalog ribbon...');

  // ============================================================
  // SECTION 1: Drawer Header & Anatomy
  // ============================================================
  print('=== Section 1: Drawer Header & Anatomy ===');

  final headerCard = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_kWoodDark, _kWood, _kWoodLight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: _kWoodDark.withValues(alpha: 0.55),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
      border: Border.all(color: _kBrassDark, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: _kBrass,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: _kBrassDark.withValues(alpha: 0.6),
                    blurRadius: 4.0,
                    offset: const Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: const Icon(Icons.inventory_2_outlined,
                  color: _kParchment, size: 30.0),
            ),
            const SizedBox(width: 14.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CARD-CATALOG DRAWER №7',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: _kParchment,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    'Sliver Child Delegates · Lazy & Eager',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: _kParchmentDeep,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kParchment,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                color: _kInk.withValues(alpha: 0.25),
                blurRadius: 3.0,
                offset: const Offset(0.0, 1.0),
              ),
            ],
          ),
          child: const Text(
            'A SliverChildDelegate is the Dewey-decimal mind of a sliver list. '
            'It tells the sliver how many index-cards exist, how to fetch the '
            'card at slot N, and which clerical conveniences (keep-alive, '
            'repaint isolation, semantic numbering) to stamp on the card '
            'before handing it to the patron.',
            style: TextStyle(
              fontSize: 12.5,
              color: _kInk,
              height: 1.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
  print('Header card composed.');

  // ============================================================
  // SECTION 2: Delegate Hierarchy Diagram
  // ============================================================
  print('=== Section 2: SliverChildDelegate Hierarchy ===');

  final hierarchyDiagram = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kParchment, _kParchmentDeep],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kBrassDark, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _kInk.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        const Text(
          'Class Hierarchy',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: _kInk,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'abstract → concrete: who knows their child count up-front?',
          style: TextStyle(
            fontSize: 11.5,
            color: _kInk.withValues(alpha: 0.7),
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 18.0),
        // Abstract root box.
        _hierarchyNode(
          'SliverChildDelegate',
          'abstract — the catalog\'s contract',
          _kInk,
          isAbstract: true,
        ),
        const SizedBox(height: 4.0),
        Icon(Icons.arrow_downward, color: _kInk.withValues(alpha: 0.5)),
        const SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: _hierarchyNode(
                'SliverChildBuilderDelegate',
                'lazy — typed on demand',
                _kStamp,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: _hierarchyNode(
                'SliverChildListDelegate',
                'eager — pre-printed stack',
                _kRibbon,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kInk.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: _kBrassDark.withValues(alpha: 0.4)),
          ),
          child: const Text(
            'Both concrete delegates expose the same stamping flags: '
            'addAutomaticKeepAlives, addRepaintBoundaries, addSemanticIndexes. '
            'The builder variant additionally exposes childCount, '
            'estimatedChildCount, and a semanticIndexCallback.',
            style: TextStyle(
              fontSize: 11.5,
              color: _kInk,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Hierarchy diagram drafted.');

  // ============================================================
  // SECTION 3: Lazy vs Eager — visual comparison
  // ============================================================
  print('=== Section 3: Lazy vs Eager Resolution ===');

  final lazyVsEagerDiagram = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _kParchment,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kBrass, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _kBrassDark.withValues(alpha: 0.3),
          blurRadius: 8.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Lazy vs Eager Resolution',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: _kInk,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _resolutionPanel(true)),
            const SizedBox(width: 12.0),
            Expanded(child: _resolutionPanel(false)),
          ],
        ),
      ],
    ),
  );
  print('Lazy/eager comparison rendered.');

  // ============================================================
  // SECTION 4: SliverChildBuilderDelegate — full parameter tour
  // ============================================================
  print('=== Section 4: SliverChildBuilderDelegate ===');

  // Construct a delegate with EVERY meaningful parameter.
  final builderTitled = SliverChildBuilderDelegate(
    (BuildContext ctx, int index) {
      return _catalogCardTile(
        index: index,
        callNumber: _callNumberFor(index),
        title: _titleFor(index),
        author: _authorFor(index),
      );
    },
    childCount: 30,
    addAutomaticKeepAlives: true,
    addRepaintBoundaries: true,
    addSemanticIndexes: true,
    semanticIndexOffset: 1,
    semanticIndexCallback: (Widget _, int localIndex) {
      // Skip every third card from the semantic numbering — the librarian
      // pretends those are "blank divider" cards.
      if (localIndex % 3 == 2) return null;
      return localIndex + 1;
    },
  );
  print('Built SliverChildBuilderDelegate (30 cards, semantic skip-every-3rd).');
  print('  childCount         = ${builderTitled.childCount}');
  print('  estimatedChildCount= ${builderTitled.estimatedChildCount}');

  // A delegate WITHOUT a known childCount (open-ended) — used in infinite
  // scrolls. The builder returns null past a private cap to terminate.
  final builderUnbounded = SliverChildBuilderDelegate(
    (BuildContext ctx, int index) {
      if (index >= 12) return null;
      return _catalogCardTile(
        index: index,
        callNumber: 'UN-${(index + 100).toString().padLeft(3, '0')}',
        title: 'Unbounded Card #$index',
        author: 'Anonymous Patron',
      );
    },
    addAutomaticKeepAlives: false,
    addRepaintBoundaries: true,
    addSemanticIndexes: true,
  );
  print('Built unbounded SliverChildBuilderDelegate (null-terminated at 12).');
  print('  childCount         = ${builderUnbounded.childCount}');
  print('  estimatedChildCount= ${builderUnbounded.estimatedChildCount}');

  final builderParamMatrix = _paramMatrix(<List<String>>[
    <String>[
      'childCount',
      'int?',
      'Total slots — null for open-ended drawers.',
    ],
    <String>[
      'estimatedChildCount',
      'int?',
      'Hint when count is unknown; here matches childCount when set.',
    ],
    <String>[
      'addAutomaticKeepAlives',
      'bool',
      'Wrap each card in AutomaticKeepAlive — preserves State across recycles.',
    ],
    <String>[
      'addRepaintBoundaries',
      'bool',
      'Isolate each card\'s repaint — protects neighbours from costly redraws.',
    ],
    <String>[
      'addSemanticIndexes',
      'bool',
      'Stamp ordinal indexes for assistive tech (screen readers).',
    ],
    <String>[
      'semanticIndexCallback',
      'SemanticIndexCallback',
      'Custom mapper from local→semantic; return null to skip.',
    ],
    <String>[
      'semanticIndexOffset',
      'int',
      'Constant added to the semantic index — handy for headered lists.',
    ],
  ]);
  print('Builder parameter matrix wired up.');

  // ============================================================
  // SECTION 5: SliverChildListDelegate — eager variant tour
  // ============================================================
  print('=== Section 5: SliverChildListDelegate ===');

  final listChildren = <Widget>[];
  for (var i = 0; i < 6; i++) {
    listChildren.add(
      _catalogCardTile(
        index: i,
        callNumber: 'L-${(200 + i).toString()}',
        title: _eagerTitleFor(i),
        author: _eagerAuthorFor(i),
      ),
    );
  }
  final listDelegate = SliverChildListDelegate(
    listChildren,
    addAutomaticKeepAlives: true,
    addRepaintBoundaries: true,
    addSemanticIndexes: true,
    semanticIndexOffset: 0,
    semanticIndexCallback: (Widget _, int localIndex) => localIndex,
  );
  print('SliverChildListDelegate (eager) — '
      'estimated=${listDelegate.estimatedChildCount}.');

  // The .fixed flavour signals to Flutter that the list won't change —
  // each child is identified solely by its initial index, never by Key.
  final listDelegateFixed = SliverChildListDelegate.fixed(
    listChildren,
    addRepaintBoundaries: true,
    addSemanticIndexes: true,
  );
  print('SliverChildListDelegate.fixed — '
      'estimated=${listDelegateFixed.estimatedChildCount}.');

  final listVariantsTable = _twoColumnTable(<List<String>>[
    <String>[
      'SliverChildListDelegate(...)',
      'Default — children may be reordered/replaced; uses Keys to match state.',
    ],
    <String>[
      'SliverChildListDelegate.fixed(...)',
      'Optimisation — promises children never change; identity is by index.',
    ],
  ], _kRibbon);

  // ============================================================
  // SECTION 6: Sample renders inside a CustomScrollView
  // ============================================================
  print('=== Section 6: Live CustomScrollView Compositions ===');

  // Composition A — builder delegate with header & footer.
  final compositionA = SizedBox(
    height: 320.0,
    child: Container(
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kBrassDark, width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _drawerLabel(
                'A. Builder Delegate · childCount: 30',
                Icons.menu_book,
                _kStamp,
              ),
            ),
            SliverList(delegate: builderTitled),
            SliverToBoxAdapter(
              child: _drawerFooter('— END OF DRAWER A —'),
            ),
          ],
        ),
      ),
    ),
  );

  // Composition B — list delegate (eager) with safe area padding.
  final compositionB = SizedBox(
    height: 280.0,
    child: Container(
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kBrassDark, width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _drawerLabel(
                'B. List Delegate (eager, 6 cards) wrapped in SliverSafeArea',
                Icons.shield_outlined,
                _kRibbon,
              ),
            ),
            SliverSafeArea(
              top: false,
              bottom: false,
              minimum: const EdgeInsets.symmetric(horizontal: 8.0),
              sliver: SliverList(delegate: listDelegate),
            ),
            SliverToBoxAdapter(
              child: _drawerFooter('— END OF DRAWER B —'),
            ),
          ],
        ),
      ),
    ),
  );

  // Composition C — unbounded builder (null-terminated) inside a grid.
  final compositionC = SizedBox(
    height: 300.0,
    child: Container(
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kBrassDark, width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _drawerLabel(
                'C. Unbounded builder + SliverGrid (3 across, null-stop @12)',
                Icons.grid_view_outlined,
                _kBrass,
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 6.0,
                crossAxisSpacing: 6.0,
                childAspectRatio: 1.6,
              ),
              delegate: builderUnbounded,
            ),
          ],
        ),
      ),
    ),
  );

  // Composition D — Visibility wrappers (visible & replaced).
  final compositionD = SizedBox(
    height: 220.0,
    child: Container(
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kBrassDark, width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _drawerLabel(
                'D. SliverVisibility — visible / hidden+replacement',
                Icons.visibility_outlined,
                _kStamp,
              ),
            ),
            SliverVisibility(
              visible: true,
              sliver: SliverToBoxAdapter(
                child: _stampLine('VISIBLE', 'this card draws normally',
                    _kStamp),
              ),
            ),
            SliverVisibility(
              visible: false,
              sliver: SliverToBoxAdapter(
                child: _stampLine('HIDDEN', 'never reached', _kRibbon),
              ),
              replacementSliver: SliverToBoxAdapter(
                child: _stampLine(
                  'REPLACED',
                  'standin while the card is checked out',
                  _kBrassDark,
                ),
              ),
            ),
            SliverVisibility(
              visible: true,
              maintainState: true,
              maintainAnimation: true,
              maintainSize: true,
              sliver: SliverToBoxAdapter(
                child: _stampLine(
                  'MAINTAIN',
                  'visible + maintainState/animation/size flags',
                  _kBrass,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // Composition E — SliverLayoutBuilder reacting to viewport constraints.
  final compositionE = SizedBox(
    height: 220.0,
    child: Container(
      decoration: BoxDecoration(
        color: _kParchment,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kBrassDark, width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _drawerLabel(
                'E. SliverLayoutBuilder — measures the drawer slot',
                Icons.straighten,
                _kRibbon,
              ),
            ),
            SliverLayoutBuilder(
              builder: (BuildContext ctx, constraints) {
                final remaining =
                    constraints.remainingPaintExtent.toStringAsFixed(1);
                final cross = constraints.crossAxisExtent.toStringAsFixed(1);
                final scrollOff = constraints.scrollOffset.toStringAsFixed(1);
                return SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: _kInk.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: _kBrassDark.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'measured at layout time:',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                            color: _kInk,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'crossAxisExtent       = $cross px',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: _kInk,
                          ),
                        ),
                        Text(
                          'remainingPaintExtent  = $remaining px',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: _kInk,
                          ),
                        ),
                        Text(
                          'scrollOffset          = $scrollOff px',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: _kInk,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SliverList(delegate: listDelegateFixed),
          ],
        ),
      ),
    ),
  );

  // ============================================================
  // SECTION 7: SliverAnimatedList scaffolding (declarative only)
  // ============================================================
  print('=== Section 7: SliverAnimatedList Scaffolding ===');

  final animatedListPanel = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _kStamp.withValues(alpha: 0.08),
          _kBrass.withValues(alpha: 0.06),
        ],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kStamp.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: _kStamp.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.auto_stories, color: _kStamp, size: 22.0),
            const SizedBox(width: 8.0),
            const Text(
              'SliverAnimatedList — animated card insertions',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
                color: _kStamp,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'SliverAnimatedList is the sliver counterpart of AnimatedList. '
          'It is scaffolded with an initialItemCount and an itemBuilder that '
          'receives an Animation<double> per slot. We render it here in '
          'static form (no controller) — the snapshot below shows what '
          'the rack would look like with all entry animations frozen at '
          'value=1.0.',
          style: TextStyle(
            fontSize: 12.0,
            color: _kInk,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 220.0,
          child: Container(
            decoration: BoxDecoration(
              color: _kParchment,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: _kStamp.withValues(alpha: 0.5)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7.0),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: _drawerLabel(
                      'Animated rack — initialItemCount: 5',
                      Icons.history_edu,
                      _kStamp,
                    ),
                  ),
                  SliverAnimatedList(
                    initialItemCount: 5,
                    itemBuilder: (
                      BuildContext ctx,
                      int index,
                      Animation<double> animation,
                    ) {
                      return FadeTransition(
                        opacity: const AlwaysStoppedAnimation<double>(1.0),
                        child: SizeTransition(
                          sizeFactor: const AlwaysStoppedAnimation<double>(1.0),
                          child: _catalogCardTile(
                            index: index,
                            callNumber: 'A-${(300 + index).toString()}',
                            title: _animatedTitleFor(index),
                            author: 'Catalog Clerk',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kInk.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Text(
            'In production, you obtain the SliverAnimatedListState via '
            'GlobalKey<SliverAnimatedListState> and call insertItem(i) / '
            'removeItem(i, builder) to animate the rack. Inside the bridge '
            'we keep the demo declarative — no controllers — by snapshotting '
            'animations at AlwaysStoppedAnimation<double>(1.0).',
            style: TextStyle(
              fontSize: 11.0,
              color: _kInk,
              height: 1.4,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Pairings reference
  // ============================================================
  print('=== Section 8: Typical Pairings ===');

  final pairings = <List<String>>[
    <String>[
      'SliverList',
      'SliverChildBuilderDelegate',
      'Long, lazily-typed lists; the most common pairing.',
    ],
    <String>[
      'SliverList',
      'SliverChildListDelegate',
      'Short, hand-curated stacks; eager.',
    ],
    <String>[
      'SliverGrid',
      'SliverChildBuilderDelegate',
      'Photo-grid, tile-grid; lazy.',
    ],
    <String>[
      'SliverGrid',
      'SliverChildListDelegate',
      'Static dashboards; eager.',
    ],
    <String>[
      'SliverAnimatedList',
      '— (uses its own builder, not a delegate)',
      'Animates insertions/removals.',
    ],
    <String>[
      'SliverSafeArea',
      'wraps another sliver',
      'Insets the inner sliver away from system intrusions.',
    ],
    <String>[
      'SliverVisibility',
      'wraps another sliver',
      'Show/hide a sliver, with optional replacementSliver.',
    ],
    <String>[
      'SliverLayoutBuilder',
      'builds a sliver from constraints',
      'Layout-aware sliver composition.',
    ],
  ];

  final pairingsTable = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kParchmentDeep,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kBrassDark, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _kInk.withValues(alpha: 0.18),
          blurRadius: 5.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Sliver / Delegate Pairings',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: _kInk,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          decoration: BoxDecoration(
            color: _kBrass,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: const <Widget>[
              SizedBox(width: 8.0),
              Expanded(flex: 3, child: _PairingsHeader('Sliver')),
              Expanded(flex: 3, child: _PairingsHeader('Delegate')),
              Expanded(flex: 5, child: _PairingsHeader('Use')),
              SizedBox(width: 8.0),
            ],
          ),
        ),
        for (var i = 0; i < pairings.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
            decoration: BoxDecoration(
              color: i.isEven
                  ? _kParchment
                  : _kParchment.withValues(alpha: 0.6),
              border: Border(
                bottom: BorderSide(
                  color: _kBrassDark.withValues(alpha: 0.3),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                const SizedBox(width: 4.0),
                Expanded(
                  flex: 3,
                  child: Text(
                    pairings[i][0],
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                      color: _kInk,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    pairings[i][1],
                    style: TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      color: _kInk.withValues(alpha: 0.85),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    pairings[i][2],
                    style: TextStyle(
                      fontSize: 11.0,
                      color: _kInk.withValues(alpha: 0.85),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
  print('Pairings reference table built (${pairings.length} rows).');

  // ============================================================
  // SECTION 9: Code examples (parchment + ink)
  // ============================================================
  print('=== Section 9: Code Examples ===');

  final codeExamples = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_kInk, _kWoodDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: _kInk.withValues(alpha: 0.4),
          blurRadius: 8.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.terminal, color: _kBrass, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'specimen pages — copy with quill',
              style: TextStyle(
                color: _kBrass,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _codeBlock(
          'SliverList(\n'
          '  delegate: SliverChildBuilderDelegate(\n'
          '    (BuildContext ctx, int index) => CardTile(index: index),\n'
          '    childCount: 30,\n'
          '    addAutomaticKeepAlives: true,\n'
          '    addRepaintBoundaries: true,\n'
          '    addSemanticIndexes: true,\n'
          '    semanticIndexOffset: 1,\n'
          '    semanticIndexCallback: (Widget _, int i) =>\n'
          '        i % 3 == 2 ? null : i + 1,\n'
          '  ),\n'
          ')',
          _kParchment,
        ),
        const SizedBox(height: 10.0),
        _codeBlock(
          'SliverList(\n'
          '  delegate: SliverChildListDelegate.fixed(\n'
          '    <Widget>[\n'
          '      ListTile(title: Text(\'A\')),\n'
          '      ListTile(title: Text(\'B\')),\n'
          '      ListTile(title: Text(\'C\')),\n'
          '    ],\n'
          '    addRepaintBoundaries: true,\n'
          '    addSemanticIndexes: true,\n'
          '  ),\n'
          ')',
          _kBrass,
        ),
        const SizedBox(height: 10.0),
        _codeBlock(
          'SliverSafeArea(\n'
          '  minimum: const EdgeInsets.symmetric(horizontal: 8.0),\n'
          '  sliver: SliverVisibility(\n'
          '    visible: showList,\n'
          '    sliver: SliverList(delegate: builderTitled),\n'
          '    replacementSliver: const SliverToBoxAdapter(\n'
          '      child: Padding(\n'
          '        padding: EdgeInsets.all(16.0),\n'
          '        child: Text(\'Drawer is checked out.\'),\n'
          '      ),\n'
          '    ),\n'
          '  ),\n'
          ')',
          _kRibbon,
        ),
        const SizedBox(height: 10.0),
        _codeBlock(
          'SliverLayoutBuilder(\n'
          '  builder: (BuildContext ctx, SliverConstraints c) {\n'
          '    final wide = c.crossAxisExtent > 600.0;\n'
          '    return wide\n'
          '        ? SliverGrid(\n'
          '            gridDelegate: const\n'
          '                SliverGridDelegateWithFixedCrossAxisCount(\n'
          '              crossAxisCount: 3,\n'
          '            ),\n'
          '            delegate: builderTitled,\n'
          '          )\n'
          '        : SliverList(delegate: builderTitled);\n'
          '  },\n'
          ')',
          _kStamp,
        ),
        const SizedBox(height: 10.0),
        _codeBlock(
          'final _key = GlobalKey<SliverAnimatedListState>();\n\n'
          'SliverAnimatedList(\n'
          '  key: _key,\n'
          '  initialItemCount: items.length,\n'
          '  itemBuilder: (ctx, i, animation) => SizeTransition(\n'
          '    sizeFactor: animation,\n'
          '    child: CardTile(index: i),\n'
          '  ),\n'
          ')\n\n'
          '// later:\n'
          '_key.currentState!.insertItem(\n'
          '  index,\n'
          '  duration: const Duration(milliseconds: 320),\n'
          ');',
          _kParchmentDeep,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Glossary stamps
  // ============================================================
  print('=== Section 10: Glossary Stamps ===');

  final glossaryEntries = <List<String>>[
    <String>[
      'lazy resolution',
      'children are typed only when the viewport asks for them. '
          'Frees memory for off-screen items.',
    ],
    <String>[
      'eager resolution',
      'all children are constructed up-front; cheap to look up, '
          'expensive to build for huge stacks.',
    ],
    <String>[
      'AutomaticKeepAlive',
      'wrapper that lets a child opt into surviving viewport recycling '
          '(via KeepAliveNotification).',
    ],
    <String>[
      'RepaintBoundary',
      'isolates a subtree\'s painting; neighbours aren\'t invalidated '
          'when this card repaints.',
    ],
    <String>[
      'semantic index',
      'ordinal label exposed to assistive tech — "card 3 of 7".',
    ],
    <String>[
      'sliver protocol',
      'a pact between sliver and viewport: the sliver lays out only the '
          'portion needed for the current scroll offset.',
    ],
  ];

  final glossaryWidgets = <Widget>[];
  for (var i = 0; i < glossaryEntries.length; i++) {
    glossaryWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: _kParchment,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: _kBrassDark.withValues(alpha: 0.4)),
          boxShadow: [
            BoxShadow(
              color: _kInk.withValues(alpha: 0.07),
              blurRadius: 2.0,
              offset: const Offset(0.0, 1.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: _kRibbon.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: _kRibbon, width: 1.0),
              ),
              child: Text(
                glossaryEntries[i][0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 10.0,
                  color: _kRibbon,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                glossaryEntries[i][1],
                style: const TextStyle(
                  fontSize: 11.5,
                  color: _kInk,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Glossary composed (${glossaryEntries.length} stamps).');

  // ============================================================
  // SECTION 11: Closing seal
  // ============================================================
  print('=== Section 11: Closing Seal ===');

  final closingSeal = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_kRibbon, _kWoodDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: _kRibbon.withValues(alpha: 0.4),
          blurRadius: 10.0,
          offset: const Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kBrass,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _kBrassDark.withValues(alpha: 0.5),
                blurRadius: 4.0,
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
          child: const Icon(Icons.verified, color: _kInk, size: 28.0),
        ),
        const SizedBox(width: 14.0),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Catalog drawer sealed.',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: _kParchment,
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Eight delegate variants, four live compositions, one '
                'animated rack — all stamped, sleeved, and re-shelved.',
                style: TextStyle(
                  fontSize: 11.5,
                  color: _kParchmentDeep,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('SliverDelegates Deep Demo composed successfully.');

  // ============================================================
  // Final assembly
  // ============================================================
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _kParchment,
            _kParchmentDeep.withValues(alpha: 0.7),
            _kParchment,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          headerCard,
          const SizedBox(height: 22.0),
          _sectionHeading('1. The Drawer Itself'),
          const SizedBox(height: 8.0),
          Text(
            'Each sliver list is a wooden drawer in a card-catalog cabinet. '
            'The SliverChildDelegate is the rule-book the librarian follows '
            'to decide which index card to slide into the patron\'s hand at '
            'slot N. Some drawers are pre-stocked; others are typed live.',
            style: TextStyle(
              fontSize: 12.5,
              color: _kInk.withValues(alpha: 0.85),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16.0),
          _sectionHeading('2. Delegate Hierarchy'),
          hierarchyDiagram,
          const SizedBox(height: 16.0),
          _sectionHeading('3. Lazy vs Eager'),
          lazyVsEagerDiagram,
          const SizedBox(height: 16.0),
          _sectionHeading('4. Builder Delegate Parameter Tour'),
          const SizedBox(height: 8.0),
          builderParamMatrix,
          const SizedBox(height: 16.0),
          _sectionHeading('5. List Delegate Variants'),
          const SizedBox(height: 8.0),
          listVariantsTable,
          const SizedBox(height: 16.0),
          _sectionHeading('6. Live Compositions (CustomScrollView)'),
          const SizedBox(height: 8.0),
          compositionA,
          const SizedBox(height: 12.0),
          compositionB,
          const SizedBox(height: 12.0),
          compositionC,
          const SizedBox(height: 12.0),
          compositionD,
          const SizedBox(height: 12.0),
          compositionE,
          const SizedBox(height: 16.0),
          _sectionHeading('7. SliverAnimatedList'),
          animatedListPanel,
          const SizedBox(height: 16.0),
          _sectionHeading('8. Pairings'),
          pairingsTable,
          const SizedBox(height: 16.0),
          _sectionHeading('9. Code Specimen Pages'),
          codeExamples,
          const SizedBox(height: 16.0),
          _sectionHeading('10. Glossary'),
          ...glossaryWidgets,
          closingSeal,
        ],
      ),
    ),
  );
}

// ==================================================================
// Top-level helpers
// ==================================================================

class _PairingsHeader extends StatelessWidget {
  final String text;
  const _PairingsHeader(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11.5,
        color: _kParchment,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
    );
  }
}

Widget _sectionHeading(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_kBrassDark, _kBrass],
      ),
      borderRadius: BorderRadius.circular(6.0),
      boxShadow: [
        BoxShadow(
          color: _kBrassDark.withValues(alpha: 0.4),
          blurRadius: 3.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: _kParchment,
        letterSpacing: 1.2,
      ),
    ),
  );
}

Widget _hierarchyNode(
  String name,
  String subtitle,
  Color accent, {
  bool isAbstract = false,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: isAbstract
          ? _kInk.withValues(alpha: 0.05)
          : accent.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: accent,
        width: 1.5,
        style: isAbstract ? BorderStyle.solid : BorderStyle.solid,
      ),
    ),
    child: Column(
      children: <Widget>[
        Text(
          name + (isAbstract ? '   «abstract»' : ''),
          style: TextStyle(
            fontSize: 12.5,
            fontFamily: 'monospace',
            color: accent,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 10.5,
            color: _kInk.withValues(alpha: 0.7),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _resolutionPanel(bool lazy) {
  final accent = lazy ? _kStamp : _kRibbon;
  final title = lazy ? 'LAZY (builder)' : 'EAGER (list)';
  final subtitle = lazy
      ? 'Cards typed only when the patron pulls the drawer.'
      : 'Cards pre-printed and stacked at construction.';
  final blocks = <Widget>[];
  for (var i = 0; i < 6; i++) {
    final resolved = lazy ? i < 3 : true;
    blocks.add(
      Container(
        margin: const EdgeInsets.only(bottom: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: resolved
              ? accent.withValues(alpha: 0.18)
              : _kInk.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: resolved
                ? accent
                : _kInk.withValues(alpha: 0.15),
            width: 1.0,
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              resolved ? Icons.check_box : Icons.check_box_outline_blank,
              size: 13.0,
              color: resolved ? accent : _kInk.withValues(alpha: 0.4),
            ),
            const SizedBox(width: 6.0),
            Text(
              'card #$i',
              style: TextStyle(
                fontSize: 10.5,
                fontFamily: 'monospace',
                color: resolved ? accent : _kInk.withValues(alpha: 0.55),
              ),
            ),
            const Spacer(),
            Text(
              resolved ? 'resolved' : 'untyped',
              style: TextStyle(
                fontSize: 9.5,
                fontStyle: FontStyle.italic,
                color: resolved ? accent : _kInk.withValues(alpha: 0.45),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _kParchment,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.2),
          blurRadius: 4.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: accent,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 10.0,
            color: _kInk.withValues(alpha: 0.65),
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 8.0),
        ...blocks,
      ],
    ),
  );
}

Widget _paramMatrix(List<List<String>> rows) {
  final matrixRows = <Widget>[];
  for (var i = 0; i < rows.length; i++) {
    matrixRows.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
        decoration: BoxDecoration(
          color: i.isEven ? _kParchment : _kParchment.withValues(alpha: 0.6),
          border: Border(
            bottom: BorderSide(
              color: _kBrassDark.withValues(alpha: 0.3),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Text(
                rows[i][0],
                style: const TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  color: _kStamp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                rows[i][1],
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: _kInk.withValues(alpha: 0.85),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Text(
                rows[i][2],
                style: TextStyle(
                  fontSize: 11.0,
                  color: _kInk.withValues(alpha: 0.8),
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    decoration: BoxDecoration(
      color: _kParchmentDeep,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kBrassDark, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: _kInk.withValues(alpha: 0.15),
          blurRadius: 4.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: _kStamp,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9.0),
              topRight: Radius.circular(9.0),
            ),
          ),
          child: Row(
            children: const <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                  'parameter',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: _kParchment,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'type',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: _kParchment,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  'role',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: _kParchment,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        ...matrixRows,
      ],
    ),
  );
}

Widget _twoColumnTable(List<List<String>> rows, Color accent) {
  final widgets = <Widget>[];
  for (var i = 0; i < rows.length; i++) {
    widgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 6.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: _kParchment,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: accent.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              rows[i][0],
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                color: accent,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              rows[i][1],
              style: TextStyle(
                fontSize: 11.0,
                color: _kInk.withValues(alpha: 0.85),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Column(children: widgets);
}

Widget _drawerLabel(String text, IconData icon, Color accent) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: accent, width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Icon(icon, color: accent, size: 16.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 11.5,
              color: accent,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _drawerFooter(String text) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    alignment: Alignment.center,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10.0,
        color: _kInk.withValues(alpha: 0.5),
        fontFamily: 'monospace',
        letterSpacing: 1.5,
      ),
    ),
  );
}

Widget _stampLine(String stamp, String body, Color accent) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: accent.withValues(alpha: 0.4)),
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(3.0),
            border: Border.all(color: accent),
          ),
          child: Text(
            stamp,
            style: TextStyle(
              fontSize: 9.5,
              color: accent,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            body,
            style: TextStyle(
              fontSize: 11.0,
              color: _kInk.withValues(alpha: 0.85),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _catalogCardTile({
  required int index,
  required String callNumber,
  required String title,
  required String author,
}) {
  // Pre-compute a deterministic "ribbon hue" based on index.
  final ribbonHues = <Color>[
    _kRibbon,
    _kStamp,
    _kBrassDark,
    _kWoodLight,
    _kBrass,
  ];
  final hue = ribbonHues[index % ribbonHues.length];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _kParchment,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: _kBrassDark.withValues(alpha: 0.5)),
      boxShadow: [
        BoxShadow(
          color: _kInk.withValues(alpha: 0.12),
          blurRadius: 2.0,
          offset: const Offset(0.0, 1.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 6.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: hue,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: _kInk.withValues(alpha: 0.07),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Text(
                      callNumber,
                      style: const TextStyle(
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        color: _kInk,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    'slot $index',
                    style: TextStyle(
                      fontSize: 9.5,
                      color: _kInk.withValues(alpha: 0.55),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: _kInk,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                author,
                style: TextStyle(
                  fontSize: 10.5,
                  color: _kInk.withValues(alpha: 0.65),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kInk,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _kBrass.withValues(alpha: 0.4)),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

// --------------- Title generators (deterministic) -----------------

String _callNumberFor(int index) {
  // Mock Library-of-Congress style call numbers.
  final letters = <String>['QA', 'PR', 'TX', 'BL', 'HD', 'ZA', 'NK', 'GV'];
  final letter = letters[index % letters.length];
  final num1 = 76 + (index * 13) % 800;
  final num2 = (index * 7) % 100;
  return '$letter$num1.$num2';
}

String _titleFor(int index) {
  final stems = <String>[
    'Treatise on the Sliver Protocol',
    'A Field Guide to Lazy Resolution',
    'On the Art of Repaint Boundaries',
    'Index Cards & Their Enemies',
    'Memoirs of a Catalog Clerk',
    'Concerning Keep-Alives',
    'Of Drawers and Their Contents',
    'A Brief History of Semantics',
    'Pamphlet on Eager Children',
    'Notebook of an Itinerant Patron',
  ];
  return '${stems[index % stems.length]} (vol. ${(index ~/ stems.length) + 1})';
}

String _authorFor(int index) {
  final names = <String>[
    'I. Slivers',
    'M. Builder',
    'Q. Patron',
    'B. Boundary',
    'K. Alive',
    'S. Mantic',
    'R. Esolve',
    'D. Ewey',
  ];
  return names[index % names.length];
}

String _eagerTitleFor(int index) {
  final titles = <String>[
    'Hand-Bound Compendium A',
    'Hand-Bound Compendium B',
    'Hand-Bound Compendium C',
    'Pre-Printed Almanac',
    'Eager Reader\'s Digest',
    'Static Manuscript III',
  ];
  return titles[index % titles.length];
}

String _eagerAuthorFor(int index) {
  final names = <String>[
    'O. Pening',
    'P. Reprint',
    'F. Ixed',
    'L. Iteral',
    'C. Onstant',
    'I. Mmediate',
  ];
  return names[index % names.length];
}

String _animatedTitleFor(int index) {
  final titles = <String>[
    'Animated Edition №1',
    'Animated Edition №2',
    'Animated Edition №3',
    'Animated Edition №4',
    'Animated Edition №5',
    'Animated Edition №6',
  ];
  return titles[index % titles.length];
}

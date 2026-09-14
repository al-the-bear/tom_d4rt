// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for ReorderableListView,
// SliverReorderableList, and the reorderable drag-handle family
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('reorderable_material_test: building deep visual demo');

  // ------------------------------------------------------------------------
  // SECTION DATA POOLS
  // ------------------------------------------------------------------------
  // Each ReorderableListView below uses its own static backing list. The
  // onReorder callback is a no-op closure so we never actually mutate state
  // (this script is StatelessWidget-only). The lists therefore visually
  // never change, which is fine for a layout / parameter tour.
  final List<String> palette = <String>[
    'Carmine',
    'Indigo',
    'Saffron',
    'Verdigris',
    'Cerulean',
    'Vermilion',
    'Periwinkle',
    'Ochre',
  ];

  final List<String> playlist = <String>[
    'Spectral Drift',
    'Aurora Bloom',
    'Solar Tide',
    'Nimbus Echo',
    'Quartz Lullaby',
    'Glass Horizon',
    'Velvet Atlas',
    'Mosaic Rain',
    'Ember Cradle',
    'Lapis Vault',
  ];

  final List<String> chapters = <String>[
    'Foundations of Reorderable Lists',
    'Drag Handles and Listeners',
    'Custom Proxy Decorators',
    'Slivers in Custom Scrolls',
    'Headers, Footers, and Padding',
    'Reverse and Horizontal Layouts',
    'Performance with Builder Mode',
    'Composition with Cards and Tiles',
  ];

  final List<String> tasks = <String>[
    'Sketch the storyboard',
    'Review the parameter map',
    'Capture three proxyDecorator variants',
    'Wire the manual drag listener',
    'Embed the sliver into a CustomScrollView',
    'Document the reverse axis quirk',
    'Bake the parameter reference card',
    'Add a glassmorphism overlay',
    'Validate the no-op onReorder',
    'Iterate the analyzer-clean pass',
  ];

  final List<String> kanban = <String>[
    'Draft API outline',
    'Identify drag-handle widget',
    'Spec the elevated decorator',
    'Spec the scaled decorator',
    'Spec the themed decorator',
    'Author the gallery section',
    'Polish the parameter card',
  ];

  final List<IconData> sectionIcons = <IconData>[
    Icons.view_list_outlined,
    Icons.build_outlined,
    Icons.brush_outlined,
    Icons.menu_open,
    Icons.swap_vert,
    Icons.swap_horiz,
    Icons.dashboard_outlined,
    Icons.layers_outlined,
  ];

  // ------------------------------------------------------------------------
  // PROXY DECORATOR FAMILY
  // ------------------------------------------------------------------------
  // The Flutter signature is:
  //   Widget proxyDecorator(Widget child, int index, Animation<double> a)
  // We deliberately do NOT read from the animation to keep this script
  // analyzer-clean and deterministic. Each decorator below is a pure
  // visual wrapper around the child.
  Widget elevatedProxy(Widget child, int index, Animation<double> animation) {
    return Material(
      elevation: 12.0,
      color: Colors.transparent,
      shadowColor: Colors.black54,
      borderRadius: BorderRadius.circular(14.0),
      child: child,
    );
  }

  Widget framedProxy(Widget child, int index, Animation<double> animation) {
    return Material(
      elevation: 6.0,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.indigo, width: 2.0),
          color: Colors.indigo.shade50,
        ),
        child: child,
      ),
    );
  }

  Widget themedProxy(Widget child, int index, Animation<double> animation) {
    return Material(
      elevation: 8.0,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.deepPurple.shade400,
              Colors.deepPurple.shade100,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: child,
      ),
    );
  }

  Widget compactProxy(Widget child, int index, Animation<double> animation) {
    return Material(
      elevation: 3.0,
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(6.0),
      child: child,
    );
  }

  Widget glassProxy(Widget child, int index, Animation<double> animation) {
    return Material(
      elevation: 10.0,
      color: Colors.white.withOpacity(0.7),
      borderRadius: BorderRadius.circular(20.0),
      shadowColor: Colors.cyan,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.cyan.shade200, width: 1.5),
        ),
        child: child,
      ),
    );
  }

  Widget badgeProxy(Widget child, int index, Animation<double> animation) {
    return Material(
      elevation: 4.0,
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          child,
          Positioned(
            top: -8.0,
            right: -8.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: const Text(
                'DRAG',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------------
  // SHARED CALLBACK HOOKS (all no-op)
  // ------------------------------------------------------------------------
  void onReorderNoop(int oldIndex, int newIndex) {
    // Deliberately empty: this script is stateless.
    // In a real app you'd splice the model list here.
  }

  void onReorderStartNoop(int index) {
    // Useful for haptic feedback / analytics in a real app.
  }

  void onReorderEndNoop(int index) {
    // Useful for committing a debounced persistence event.
  }

  // ------------------------------------------------------------------------
  // COMMON WIDGET BUILDERS
  // ------------------------------------------------------------------------
  Widget sectionTitle(String title, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[color, color.withOpacity(0.4)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white, size: 28.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget explanatoryCard(String heading, String body, Color tint) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      elevation: 2.0,
      color: tint,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              heading,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              body,
              style: const TextStyle(fontSize: 13.5, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget paramRow(String name, String type, String purpose) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ),
          SizedBox(
            width: 130.0,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: Colors.teal,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              purpose,
              style: const TextStyle(fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // SECTION 1: Default ReorderableListView gallery
  // ========================================================================
  print('reorderable_material_test: section 1 — default gallery');

  final List<Widget> paletteTiles = <Widget>[];
  for (int i = 0; i < palette.length; i = i + 1) {
    paletteTiles.add(
      Card(
        key: ValueKey<String>('palette-${palette[i]}'),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        elevation: 2.0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.primaries[i % Colors.primaries.length],
            child: Text(
              palette[i].substring(0, 1),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(palette[i]),
          subtitle: Text('Tile #${i + 1} in the palette gallery'),
          trailing: const Icon(Icons.drag_handle),
        ),
      ),
    );
  }

  final Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle(
        'Section 1 · Default ReorderableListView gallery',
        sectionIcons[0],
        Colors.deepPurple,
      ),
      explanatoryCard(
        'ReorderableListView with positional children',
        'The simplest constructor takes a fixed list of children plus an '
            'onReorder callback. Every child MUST have a unique Key. The '
            'list below uses the default buildDefaultDragHandles, which '
            'wires invisible drag handles automatically on the trailing '
            'edge of each tile.',
        Colors.deepPurple.shade50,
      ),
      SizedBox(
        height: 420.0,
        child: ReorderableListView(
          onReorder: onReorderNoop,
          onReorderStart: onReorderStartNoop,
          onReorderEnd: onReorderEndNoop,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          buildDefaultDragHandles: true,
          header: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.deepPurple.shade100,
            child: const Text(
              'Palette · drag to reorder',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          footer: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.deepPurple.shade50,
            child: const Text(
              'End of palette · static demo (no mutation)',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          proxyDecorator: elevatedProxy,
          children: paletteTiles,
        ),
      ),
    ],
  );

  // ========================================================================
  // SECTION 2: ReorderableListView.builder with explicit drag handles
  // ========================================================================
  print('reorderable_material_test: section 2 — builder showcase');

  final Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle(
        'Section 2 · ReorderableListView.builder',
        sectionIcons[6],
        Colors.teal,
      ),
      explanatoryCard(
        'Lazy item construction',
        'When the list is long, use ReorderableListView.builder to build '
            'tiles on demand. itemBuilder receives an index. Here we also '
            'set buildDefaultDragHandles to false and wire a manual '
            'ReorderableDragStartListener around a custom handle icon.',
        Colors.teal.shade50,
      ),
      SizedBox(
        height: 460.0,
        child: ReorderableListView.builder(
          itemCount: playlist.length,
          buildDefaultDragHandles: false,
          padding: const EdgeInsets.all(8.0),
          proxyDecorator: framedProxy,
          onReorder: onReorderNoop,
          onReorderStart: onReorderStartNoop,
          onReorderEnd: onReorderEndNoop,
          header: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.teal.shade200,
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: const EdgeInsets.only(bottom: 8.0),
            child: const Text(
              'Playlist · long-press the speaker icon to drag',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          itemBuilder: (BuildContext ctx, int index) {
            return Container(
              key: ValueKey<String>('playlist-${playlist[index]}'),
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: index.isEven
                    ? Colors.teal.shade50
                    : Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.teal.shade100),
              ),
              child: Row(
                children: <Widget>[
                  ReorderableDragStartListener(
                    index: index,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.music_note,
                        color: Colors.teal.shade700,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            playlist[index],
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Track #${index + 1} · drag from the note icon',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.teal.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.more_vert, color: Colors.grey),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );

  // ========================================================================
  // SECTION 3: proxyDecorator catalog
  // ========================================================================
  print('reorderable_material_test: section 3 — proxyDecorator catalog');

  Widget chapterTile(int index, String label) {
    return Container(
      key: ValueKey<String>('chapter-$label'),
      height: 64.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 8.0,
            height: 64.0,
            decoration: BoxDecoration(
              color: Colors.primaries[index % Colors.primaries.length],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Text(
            '${index + 1}.',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ReorderableDragStartListener(
            index: index,
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(Icons.drag_indicator, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  final List<Widget> chapterTilesA = <Widget>[];
  final List<Widget> chapterTilesB = <Widget>[];
  final List<Widget> chapterTilesC = <Widget>[];
  for (int i = 0; i < chapters.length; i = i + 1) {
    chapterTilesA.add(chapterTile(i, chapters[i]));
    chapterTilesB.add(chapterTile(i, chapters[i]));
    chapterTilesC.add(chapterTile(i, chapters[i]));
  }

  final Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle(
        'Section 3 · proxyDecorator catalog',
        sectionIcons[2],
        Colors.deepOrange,
      ),
      explanatoryCard(
        'Three visual moods for the drag proxy',
        'The proxyDecorator decides how the floating item looks while '
            'being dragged. Below are three side-by-side ReorderableListView '
            'instances, each using a different decorator: elevatedProxy, '
            'themedProxy, and glassProxy.',
        Colors.deepOrange.shade50,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.deepOrange.shade100,
                  child: const Text(
                    'elevatedProxy',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 360.0,
                  child: ReorderableListView(
                    onReorder: onReorderNoop,
                    buildDefaultDragHandles: false,
                    proxyDecorator: elevatedProxy,
                    padding: const EdgeInsets.all(6.0),
                    children: chapterTilesA,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.deepOrange.shade200,
                  child: const Text(
                    'themedProxy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 360.0,
                  child: ReorderableListView(
                    onReorder: onReorderNoop,
                    buildDefaultDragHandles: false,
                    proxyDecorator: themedProxy,
                    padding: const EdgeInsets.all(6.0),
                    children: chapterTilesB,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.deepOrange.shade300,
                  child: const Text(
                    'glassProxy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 360.0,
                  child: ReorderableListView(
                    onReorder: onReorderNoop,
                    buildDefaultDragHandles: false,
                    proxyDecorator: glassProxy,
                    padding: const EdgeInsets.all(6.0),
                    children: chapterTilesC,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 8.0),
      explanatoryCard(
        'Two more decorators',
        'compactProxy keeps the dragged item flat and tight. badgeProxy '
            'overlays a corner badge to communicate the drag state to '
            'screen-reader-impaired sighted users. These are shown in '
            'Section 4 with a different list.',
        Colors.deepOrange.shade50,
      ),
    ],
  );

  // ========================================================================
  // SECTION 4: ReorderableDragStartListener and the delayed variant
  // ========================================================================
  print('reorderable_material_test: section 4 — drag-start listeners');

  final List<Widget> taskTiles = <Widget>[];
  for (int i = 0; i < tasks.length; i = i + 1) {
    taskTiles.add(
      Container(
        key: ValueKey<String>('task-${tasks[i]}'),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.amber.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.amber.shade200),
        ),
        child: Row(
          children: <Widget>[
            // Manual handle: instant grab.
            ReorderableDragStartListener(
              index: i,
              child: Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: Colors.amber.shade300,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
                child: const Icon(Icons.menu, color: Colors.white),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  tasks[i],
                  style: const TextStyle(fontSize: 14.0),
                ),
              ),
            ),
            // Delayed handle: long-press to grab.
            ReorderableDelayedDragStartListener(
              index: i,
              child: Container(
                padding: const EdgeInsets.all(14.0),
                child: Icon(
                  Icons.touch_app,
                  color: Colors.amber.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle(
        'Section 4 · Drag-start listeners',
        sectionIcons[1],
        Colors.amber.shade800,
      ),
      explanatoryCard(
        'Instant vs delayed drag',
        'ReorderableDragStartListener kicks in immediately on pointer '
            'down. ReorderableDelayedDragStartListener requires a long '
            'press first — perfect for touch surfaces where accidental '
            'drags would conflict with scrolling. The list below wires '
            'BOTH on each row, demonstrating that you can offer multiple '
            'affordances simultaneously.',
        Colors.amber.shade50,
      ),
      SizedBox(
        height: 540.0,
        child: ReorderableListView(
          onReorder: onReorderNoop,
          buildDefaultDragHandles: false,
          proxyDecorator: badgeProxy,
          padding: const EdgeInsets.all(8.0),
          header: Container(
            padding: const EdgeInsets.all(12.0),
            color: Colors.amber.shade100,
            child: const Text(
              'Task board · two handles per row',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          footer: Container(
            padding: const EdgeInsets.all(12.0),
            color: Colors.amber.shade50,
            child: const Text(
              'Left handle = instant · right handle = long-press',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          children: taskTiles,
        ),
      ),
    ],
  );

  // ========================================================================
  // SECTION 5: SliverReorderableList in a CustomScrollView
  // ========================================================================
  print('reorderable_material_test: section 5 — sliver in custom scroll');

  Widget kanbanTile(BuildContext ctx, int index) {
    return Container(
      key: ValueKey<String>('kanban-${kanban[index]}'),
      height: 72.0,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 56.0,
            height: 72.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Colors.cyan.shade400,
                  Colors.cyan.shade100,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
              ),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    kanban[index],
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Kanban card #${index + 1}',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ReorderableDragStartListener(
            index: index,
            child: const Padding(
              padding: EdgeInsets.all(14.0),
              child: Icon(Icons.drag_handle, color: Colors.cyan),
            ),
          ),
        ],
      ),
    );
  }

  final Widget section5 = SizedBox(
    height: 720.0,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: sectionTitle(
            'Section 5 · SliverReorderableList in CustomScrollView',
            sectionIcons[3],
            Colors.cyan.shade700,
          ),
        ),
        SliverToBoxAdapter(
          child: explanatoryCard(
            'Embed reorderable list inside a sliver tree',
            'SliverReorderableList is the lower-level building block. It '
                'plugs straight into a CustomScrollView alongside '
                'SliverAppBar, SliverGrid, SliverPersistentHeader, and so '
                'on. The handles and proxyDecorator are configured per '
                'sliver, not per app.',
            Colors.cyan.shade50,
          ),
        ),
        SliverAppBar(
          backgroundColor: Colors.cyan.shade400,
          floating: true,
          pinned: false,
          title: const Text('Kanban board'),
          expandedHeight: 90.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Colors.cyan.shade200,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'Drag the cards to reorder',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverReorderableList(
          itemCount: kanban.length,
          itemBuilder: kanbanTile,
          proxyDecorator: compactProxy,
          onReorder: onReorderNoop,
          onReorderStart: onReorderStartNoop,
          onReorderEnd: onReorderEndNoop,
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.cyan.shade50,
            child: const Text(
              'End of sliver list · ordinary sliver children follow.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int i) {
              return Container(
                color: Colors.cyan.shade100,
                child: Center(
                  child: Text(
                    'g${i + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
            childCount: 8,
          ),
        ),
      ],
    ),
  );

  // ========================================================================
  // SECTION 6: Horizontal and reversed scroll directions
  // ========================================================================
  print('reorderable_material_test: section 6 — axis and reverse tour');

  final List<Widget> horizontalTiles = <Widget>[];
  for (int i = 0; i < 8; i = i + 1) {
    horizontalTiles.add(
      Container(
        key: ValueKey<String>('horiz-$i'),
        width: 120.0,
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
        decoration: BoxDecoration(
          color: Colors.primaries[i % Colors.primaries.length].shade100,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.primaries[i % Colors.primaries.length],
            width: 2.0,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.swap_horiz,
                color: Colors.primaries[i % Colors.primaries.length],
              ),
              const SizedBox(height: 6.0),
              Text(
                'Card ${i + 1}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4.0),
              ReorderableDragStartListener(
                index: i,
                child: const Icon(Icons.drag_indicator),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<Widget> reverseTiles = <Widget>[];
  for (int i = 0; i < 6; i = i + 1) {
    reverseTiles.add(
      Container(
        key: ValueKey<String>('reverse-$i'),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.pink.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.pink.shade200),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 32.0,
              height: 32.0,
              decoration: const BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'Reverse item ${i + 1}',
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
            ReorderableDragStartListener(
              index: i,
              child: const Icon(Icons.drag_handle),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle(
        'Section 6 · Axis and reverse',
        sectionIcons[5],
        Colors.pink,
      ),
      explanatoryCard(
        'scrollDirection: Axis.horizontal',
        'Setting scrollDirection to horizontal turns the list into a row. '
            'Drag handles still work but the proxy slides left/right '
            'instead of up/down. The buildDefaultDragHandles flag is '
            'still honored.',
        Colors.pink.shade50,
      ),
      SizedBox(
        height: 200.0,
        child: ReorderableListView(
          scrollDirection: Axis.horizontal,
          buildDefaultDragHandles: false,
          padding: const EdgeInsets.all(12.0),
          physics: const BouncingScrollPhysics(),
          onReorder: onReorderNoop,
          proxyDecorator: framedProxy,
          children: horizontalTiles,
        ),
      ),
      explanatoryCard(
        'reverse: true with a vertical list',
        'Setting reverse to true draws the list from bottom to top. The '
            'first item appears at the bottom of the viewport, which is '
            'handy for chat transcripts and log views. ReorderableListView '
            'preserves the visual drag direction relative to user input.',
        Colors.pink.shade50,
      ),
      SizedBox(
        height: 360.0,
        child: ReorderableListView(
          reverse: true,
          buildDefaultDragHandles: false,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          physics: const ClampingScrollPhysics(),
          onReorder: onReorderNoop,
          proxyDecorator: compactProxy,
          children: reverseTiles,
        ),
      ),
    ],
  );

  // ========================================================================
  // SECTION 7: Headers, footers, padding, physics
  // ========================================================================
  print('reorderable_material_test: section 7 — chrome and physics');

  final List<Widget> paddedTiles = <Widget>[];
  for (int i = 0; i < 6; i = i + 1) {
    paddedTiles.add(
      Container(
        key: ValueKey<String>('padded-$i'),
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.lightGreen.shade100,
              Colors.green.shade50,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green.shade400,
            child: Text(
              '${i + 1}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text('Padded row ${i + 1}'),
          subtitle: const Text('Demonstrates padding and physics'),
          trailing: ReorderableDragStartListener(
            index: i,
            child: const Icon(Icons.drag_handle),
          ),
        ),
      ),
    );
  }

  final Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle(
        'Section 7 · Chrome and physics',
        sectionIcons[4],
        Colors.green,
      ),
      explanatoryCard(
        'header, footer, padding and physics',
        'header and footer are rendered above and below the reorderable '
            'children. They do NOT participate in reordering. padding is '
            'applied around the whole list. physics swaps the scroll '
            'simulation: bouncing (iOS), clamping (Android), never-'
            'scrollable, or always-scrollable.',
        Colors.green.shade50,
      ),
      SizedBox(
        height: 480.0,
        child: ReorderableListView(
          buildDefaultDragHandles: false,
          padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
          physics: const AlwaysScrollableScrollPhysics(),
          onReorder: onReorderNoop,
          onReorderStart: onReorderStartNoop,
          onReorderEnd: onReorderEndNoop,
          proxyDecorator: themedProxy,
          header: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green.shade200,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Row(
              children: <Widget>[
                Icon(Icons.label, color: Colors.white),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Header widget (no reordering here)',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          footer: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Row(
              children: <Widget>[
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Footer widget (also not reorderable)',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
          children: paddedTiles,
        ),
      ),
    ],
  );

  // ========================================================================
  // SECTION 8: Parameter reference card
  // ========================================================================
  print('reorderable_material_test: section 8 — parameter reference');

  final Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      sectionTitle(
        'Section 8 · Parameter reference card',
        sectionIcons[7],
        Colors.indigo,
      ),
      Card(
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'ReorderableListView · key parameters',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              paramRow(
                'onReorder',
                'ReorderCallback',
                'Required. Called when a drag completes; you splice '
                    '(oldIndex, newIndex) into the model.',
              ),
              paramRow(
                'onReorderStart',
                'void Function(int)',
                'Called at the moment the drag begins.',
              ),
              paramRow(
                'onReorderEnd',
                'void Function(int)',
                'Called once the drag is released or cancelled.',
              ),
              paramRow(
                'proxyDecorator',
                'ReorderItemProxy...',
                'Wraps the floating drag item with chrome (elevation, '
                    'border, gradient, badge).',
              ),
              paramRow(
                'buildDefaultDragHandles',
                'bool',
                'If true (default), each child gets an invisible drag '
                    'handle on the trailing edge.',
              ),
              paramRow(
                'header',
                'Widget?',
                'A widget rendered above the reorderable children.',
              ),
              paramRow(
                'footer',
                'Widget?',
                'A widget rendered below the reorderable children.',
              ),
              paramRow(
                'padding',
                'EdgeInsetsGeometry?',
                'Padding around the whole reorderable area.',
              ),
              paramRow(
                'physics',
                'ScrollPhysics?',
                'Bouncing, clamping, never-, or always-scrollable.',
              ),
              paramRow(
                'scrollDirection',
                'Axis',
                'Vertical (default) or Axis.horizontal.',
              ),
              paramRow(
                'reverse',
                'bool',
                'If true, draws items from bottom-to-top (or right-to-'
                    'left in horizontal mode).',
              ),
            ],
          ),
        ),
      ),
      Card(
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Drag-start listeners',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              paramRow(
                'Reorderable...Listener',
                'Widget',
                'Wraps a child so pointer-down on that child immediately '
                    'starts a drag for the given index.',
              ),
              paramRow(
                'ReorderableDelayed...',
                'Widget',
                'Same idea, but requires a long-press before the drag '
                    'starts. Pairs well with scrollable rows.',
              ),
              paramRow(
                'index',
                'int',
                'Identifies which child of the reorderable parent this '
                    'listener controls.',
              ),
              paramRow(
                'enabled',
                'bool',
                'When false, the listener ignores pointer events — handy '
                    'for read-only modes.',
              ),
            ],
          ),
        ),
      ),
      Card(
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'SliverReorderableList',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              paramRow(
                'itemBuilder',
                'IndexedWidgetBuilder',
                'Lazily constructs each child by index.',
              ),
              paramRow(
                'itemCount',
                'int',
                'Number of items in the sliver.',
              ),
              paramRow(
                'onReorder',
                'ReorderCallback',
                'Same semantics as the box-based widget.',
              ),
              paramRow(
                'proxyDecorator',
                'ReorderItemProxy...',
                'Same decorator hook; works identically inside a '
                    'CustomScrollView.',
              ),
              paramRow(
                'itemExtent',
                'double?',
                'When all items share a height, set this to enable fast '
                    'scrolling math.',
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ========================================================================
  // OUTRO / FOOTER
  // ========================================================================
  print('reorderable_material_test: assembling scaffold');

  final Widget outro = Container(
    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.indigo.shade700,
          Colors.deepPurple.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'End of demo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'This script is a stateless visual tour. The onReorder callbacks '
          'are intentional no-ops; mutate your own model in real code.',
          style: TextStyle(color: Colors.white, height: 1.4),
        ),
      ],
    ),
  );

  // ========================================================================
  // FINAL SCAFFOLD
  // ========================================================================
  return Scaffold(
    appBar: AppBar(
      title: const Text('ReorderableListView · deep visual demo'),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      elevation: 4.0,
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          section1,
          section2,
          section3,
          section4,
          section5,
          section6,
          section7,
          section8,
          outro,
        ],
      ),
    ),
    backgroundColor: Colors.grey.shade100,
  );
}

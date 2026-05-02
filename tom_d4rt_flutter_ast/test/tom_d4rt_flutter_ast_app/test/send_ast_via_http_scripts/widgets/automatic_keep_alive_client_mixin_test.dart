// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =====================================================================
//  AutomaticKeepAliveClientMixin<T> — Deep Hand-Authored Demo
// ---------------------------------------------------------------------
//  This file is a long, hand-authored visual walk-through of the
//  AutomaticKeepAliveClientMixin<T> mixin. The mixin is applied to a
//  State<T extends StatefulWidget> in order to keep that state alive
//  even when its parent widget (commonly a lazy list, page view, or
//  tab view) would otherwise dispose it for performance reasons.
//
//  Each section below is rendered as a separate "chapter" in a
//  scrollable column, and each chapter includes both narrative text
//  and an interactive demo widget that exercises the mixin.
//
//  Top-level rules followed in this file:
//
//    * Only `package:flutter/material.dart` is imported.
//    * The entry point is a top-level `dynamic build(BuildContext context)`
//      function that returns a `MaterialApp` rooted at a `Scaffold` >
//      `SafeArea` > `SingleChildScrollView` > `Column` tree.
//    * The file is hand-authored and verbose so a learner can read it
//      end-to-end and see every variation of the mixin in context.
//    * `dart analyze` is expected to pass cleanly.
//
//  The mixin contract in plain words:
//
//    1. Mix `AutomaticKeepAliveClientMixin` into a `State<T>`.
//    2. Override `bool get wantKeepAlive` and decide when to keep alive.
//    3. In `build`, call `super.build(context)` first thing — this
//       registers the keep-alive request with the closest
//       `AutomaticKeepAlive` ancestor (provided automatically by lazy
//       parents like `ListView`, `PageView`, `GridView`, and
//       `TabBarView` when their `addAutomaticKeepAlives` flag is true,
//       which is the default).
//    4. If `wantKeepAlive` ever changes value at runtime, call
//       `updateKeepAlive()` so the framework picks up the new value.
// =====================================================================

dynamic build(BuildContext context) {
  print('=== AutomaticKeepAliveClientMixin Deep Demo ===');
  return const MaterialApp(
    title: 'AutomaticKeepAliveClientMixin Deep Demo',
    home: _KeepAliveDemoHome(),
  );
}

// ---------------------------------------------------------------------
//  Top-level home page
// ---------------------------------------------------------------------

class _KeepAliveDemoHome extends StatelessWidget {
  const _KeepAliveDemoHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutomaticKeepAliveClientMixin'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _SectionTitle('1. What is AutomaticKeepAliveClientMixin?'),
              _IntroSection(),
              SizedBox(height: 24),
              _SectionTitle('2. PageView with kept-alive counters'),
              _PageViewKeepAliveSection(),
              SizedBox(height: 24),
              _SectionTitle('3. PageView WITHOUT keep-alive (comparison)'),
              _PageViewNoKeepSection(),
              SizedBox(height: 24),
              _SectionTitle('4. ListView with sparse keep-alive'),
              _SparseKeepAliveSection(),
              SizedBox(height: 24),
              _SectionTitle('5. Tab + nested scroll keep-alive'),
              _TabKeepAliveSection(),
              SizedBox(height: 24),
              _SectionTitle('6. Conditional wantKeepAlive (toggleable)'),
              _ConditionalKeepAliveSection(),
              SizedBox(height: 24),
              _SectionTitle('7. Multiple kept-alive widgets composed'),
              _ComposedKeepAliveSection(),
              SizedBox(height: 24),
              _SectionTitle('8. Heavy widget keep-alive'),
              _HeavyKeepAliveSection(),
              SizedBox(height: 24),
              _SectionTitle('9. wantKeepAlive vs Provider-based persistence'),
              _MixinVsProviderSection(),
              SizedBox(height: 24),
              _SectionTitle('10. Common pitfalls'),
              _PitfallsSection(),
              SizedBox(height: 24),
              _SectionTitle('11. updateKeepAlive() showcase'),
              _UpdateKeepAliveSection(),
              SizedBox(height: 24),
              _SectionTitle('12. Recipe gallery'),
              _RecipeGallerySection(),
              SizedBox(height: 24),
              _SectionTitle('13. Reference table'),
              _ReferenceTableSection(),
              SizedBox(height: 32),
              _FooterCard(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
//  Shared layout helpers
// ---------------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  final String text;
  const _Caption(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade800,
          height: 1.4,
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  const _CodeBlock(this.code);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          color: Colors.greenAccent,
          fontSize: 13,
          height: 1.4,
        ),
      ),
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(Icons.circle, size: 8, color: Colors.indigo),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;
  final Color color;

  const _InfoCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(body, style: const TextStyle(fontSize: 13, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
//  Section 1 — Intro
// =====================================================================

class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            _Caption(
              'Lazy parents like ListView, PageView, GridView, and '
              'TabBarView dispose off-screen children to save memory. '
              'When a child is disposed, all of its in-state data '
              '(counters, controllers, animations, scroll offsets, '
              'focus, text editing) is reset on the next reveal.',
            ),
            _Caption(
              'AutomaticKeepAliveClientMixin lets a State<T> opt out '
              'of disposal: it asks the closest AutomaticKeepAlive '
              'ancestor (inserted automatically by the lazy parent) '
              'to keep the subtree alive even when scrolled out of '
              'view. The State is preserved, so re-entering the '
              'viewport feels instant and stateful.',
            ),
            SizedBox(height: 8),
            _CodeBlock(
              'class _MyState extends State<MyWidget>\n'
              '    with AutomaticKeepAliveClientMixin {\n'
              '  @override\n'
              '  bool get wantKeepAlive => true;\n\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    super.build(context); // REQUIRED\n'
              '    return ...;\n'
              '  }\n'
              '}',
            ),
            SizedBox(height: 8),
            _Caption('Lifecycle diagram:'),
            _LifecycleDiagram(),
          ],
        ),
      ),
    );
  }
}

class _LifecycleDiagram extends StatelessWidget {
  const _LifecycleDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.indigo.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _LifecycleRow(
            stage: 'built',
            description: 'State() and initState() run, build() returns UI',
            color: Colors.green,
          ),
          _LifecycleRow(
            stage: 'in viewport',
            description: 'Widget is visible, full state is active',
            color: Colors.blue,
          ),
          _LifecycleRow(
            stage: 'scroll away',
            description: 'Parent decides whether to keep alive',
            color: Colors.amber,
          ),
          _LifecycleRow(
            stage: 'kept-alive',
            description: 'wantKeepAlive == true → State preserved',
            color: Colors.teal,
          ),
          _LifecycleRow(
            stage: 'disposed',
            description: 'wantKeepAlive == false → dispose() called',
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _LifecycleRow extends StatelessWidget {
  final String stage;
  final String description;
  final Color color;

  const _LifecycleRow({
    required this.stage,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 90,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color),
            ),
            child: Text(
              stage,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
//  Section 2 — PageView with kept-alive counters
// =====================================================================

class _PageViewKeepAliveSection extends StatelessWidget {
  const _PageViewKeepAliveSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            _Caption(
              'A horizontal PageView contains five _CountedPage widgets. '
              'Each one mixes in AutomaticKeepAliveClientMixin and keeps '
              'a private counter. Tap +1 on a page, swipe between pages, '
              'and notice that returning to a page restores its counter '
              'instead of resetting to zero — the State was kept alive.',
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 220,
              child: _CountedPageView(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CountedPageView extends StatefulWidget {
  const _CountedPageView();

  @override
  State<_CountedPageView> createState() => _CountedPageViewState();
}

class _CountedPageViewState extends State<_CountedPageView> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: 5,
            itemBuilder: (context, index) => _CountedPage(index: index),
          ),
        ),
        const SizedBox(height: 6),
        _PageDots(controller: _controller, count: 5),
      ],
    );
  }
}

class _PageDots extends StatefulWidget {
  final PageController controller;
  final int count;

  const _PageDots({required this.controller, required this.count});

  @override
  State<_PageDots> createState() => _PageDotsState();
}

class _PageDotsState extends State<_PageDots> {
  double _page = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      _page = widget.controller.page ?? 0.0;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(widget.count, (i) {
        final bool active = (_page.round() == i);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 14 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? Colors.indigo : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

class _CountedPage extends StatefulWidget {
  final int index;

  const _CountedPage({required this.index});

  @override
  State<_CountedPage> createState() => _CountedPageState();
}

class _CountedPageState extends State<_CountedPage>
    with AutomaticKeepAliveClientMixin<_CountedPage> {
  int _count = 0;

  @override
  bool get wantKeepAlive => true;

  void _bump() => setState(() => _count++);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final List<Color> palette = <Color>[
      Colors.indigo,
      Colors.teal,
      Colors.deepOrange,
      Colors.purple,
      Colors.green,
    ];
    final Color color = palette[widget.index % palette.length];
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        color: color.withOpacity(0.1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: color.withOpacity(0.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Page ${widget.index + 1}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Counter: $_count',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: color),
                onPressed: _bump,
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('+1', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 4),
              const Text(
                'wantKeepAlive: true',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
//  Section 3 — PageView WITHOUT keep-alive
// =====================================================================

class _PageViewNoKeepSection extends StatelessWidget {
  const _PageViewNoKeepSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            _Caption(
              'Same PageView shape, but each page is a _CountedPageNoKeep '
              'that does NOT mix in AutomaticKeepAliveClientMixin. Swipe '
              'away and return — the counter resets to zero because the '
              'State was disposed and recreated. Compare with section 2.',
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 220,
              child: _NoKeepPageView(),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoKeepPageView extends StatefulWidget {
  const _NoKeepPageView();

  @override
  State<_NoKeepPageView> createState() => _NoKeepPageViewState();
}

class _NoKeepPageViewState extends State<_NoKeepPageView> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: 5,
            itemBuilder: (context, index) => _CountedPageNoKeep(index: index),
          ),
        ),
        const SizedBox(height: 6),
        _PageDots(controller: _controller, count: 5),
      ],
    );
  }
}

class _CountedPageNoKeep extends StatefulWidget {
  final int index;

  const _CountedPageNoKeep({required this.index});

  @override
  State<_CountedPageNoKeep> createState() => _CountedPageNoKeepState();
}

class _CountedPageNoKeepState extends State<_CountedPageNoKeep> {
  int _count = 0;

  void _bump() => setState(() => _count++);

  @override
  Widget build(BuildContext context) {
    final List<Color> palette = <Color>[
      Colors.redAccent,
      Colors.orangeAccent,
      Colors.amber,
      Colors.brown,
      Colors.pink,
    ];
    final Color color = palette[widget.index % palette.length];
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        color: color.withOpacity(0.1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: color.withOpacity(0.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Page ${widget.index + 1} (no keep)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Counter: $_count',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: color),
                onPressed: _bump,
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('+1', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 4),
              const Text(
                'no mixin → State disposed when off-screen',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
//  Section 4 — Sparse keep-alive in a ListView
// =====================================================================

class _SparseKeepAliveSection extends StatelessWidget {
  const _SparseKeepAliveSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            _Caption(
              'A long ListView contains 50 _BookmarkedListItem widgets. '
              'Each one mixes in AutomaticKeepAliveClientMixin but its '
              'wantKeepAlive depends on whether the user toggled the '
              'bookmark icon. Bookmarked items keep their counter even '
              'after scrolling far away; non-bookmarked items reset.',
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 320,
              child: _SparseKeepListView(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SparseKeepListView extends StatefulWidget {
  const _SparseKeepListView();

  @override
  State<_SparseKeepListView> createState() => _SparseKeepListViewState();
}

class _SparseKeepListViewState extends State<_SparseKeepListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) => _BookmarkedListItem(index: index),
    );
  }
}

class _BookmarkedListItem extends StatefulWidget {
  final int index;

  const _BookmarkedListItem({required this.index});

  @override
  State<_BookmarkedListItem> createState() => _BookmarkedListItemState();
}

class _BookmarkedListItemState extends State<_BookmarkedListItem>
    with AutomaticKeepAliveClientMixin<_BookmarkedListItem> {
  int _count = 0;
  bool _bookmarked = false;

  @override
  bool get wantKeepAlive => _bookmarked;

  void _toggleBookmark() {
    setState(() {
      _bookmarked = !_bookmarked;
    });
    updateKeepAlive();
  }

  void _bump() => setState(() => _count++);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        color: _bookmarked
            ? Colors.amber.shade50
            : Colors.grey.shade100,
        child: ListTile(
          leading: IconButton(
            icon: Icon(
              _bookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _bookmarked ? Colors.amber.shade800 : Colors.grey,
            ),
            onPressed: _toggleBookmark,
          ),
          title: Text('Item ${widget.index + 1}'),
          subtitle: Text(
            _bookmarked
                ? 'kept-alive (count survives scroll)'
                : 'not kept-alive (count resets when off-screen)',
            style: const TextStyle(fontSize: 12),
          ),
          trailing: SizedBox(
            width: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('$_count'),
                const SizedBox(width: 6),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: _bump,
                  color: Colors.indigo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================================
//  Section 5 — Tab + nested scroll keep-alive
// =====================================================================

class _TabKeepAliveSection extends StatelessWidget {
  const _TabKeepAliveSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            _Caption(
              'A four-tab TabBar. Each tab body is a _KeepAliveTab. '
              'When you switch tabs the off-tab body would normally be '
              'disposed; with the mixin in place each tab keeps its '
              'simulated content (animation phase, text, scroll offset). '
              'Returning to a tab feels instantaneous.',
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 360,
              child: _TabKeepAliveScaffold(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabKeepAliveScaffold extends StatefulWidget {
  const _TabKeepAliveScaffold();

  @override
  State<_TabKeepAliveScaffold> createState() => _TabKeepAliveScaffoldState();
}

class _TabKeepAliveScaffoldState extends State<_TabKeepAliveScaffold>
    with TickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          color: Colors.indigo.shade50,
          child: TabBar(
            controller: _controller,
            labelColor: Colors.indigo,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.indigo,
            tabs: const <Widget>[
              Tab(text: 'Alpha'),
              Tab(text: 'Beta'),
              Tab(text: 'Gamma'),
              Tab(text: 'Delta'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: const <Widget>[
              _KeepAliveTab(label: 'Alpha', color: Colors.indigo),
              _KeepAliveTab(label: 'Beta', color: Colors.teal),
              _KeepAliveTab(label: 'Gamma', color: Colors.deepOrange),
              _KeepAliveTab(label: 'Delta', color: Colors.purple),
            ],
          ),
        ),
      ],
    );
  }
}

class _KeepAliveTab extends StatefulWidget {
  final String label;
  final Color color;

  const _KeepAliveTab({required this.label, required this.color});

  @override
  State<_KeepAliveTab> createState() => _KeepAliveTabState();
}

class _KeepAliveTabState extends State<_KeepAliveTab>
    with
        AutomaticKeepAliveClientMixin<_KeepAliveTab>,
        TickerProviderStateMixin<_KeepAliveTab> {
  late final AnimationController _anim;
  final ScrollController _scroll = ScrollController();
  int _localCount = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _anim.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      controller: _scroll,
      itemCount: 25,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tab "${widget.label}"',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.color,
                  ),
                ),
                const SizedBox(height: 8),
                AnimatedBuilder(
                  animation: _anim,
                  builder: (context, child) {
                    return Container(
                      height: 16,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            widget.color.withOpacity(_anim.value),
                            widget.color.withOpacity(1 - _anim.value),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.color,
                      ),
                      onPressed: () => setState(() => _localCount++),
                      child: const Text(
                        '+1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text('counter: $_localCount'),
                  ],
                ),
              ],
            ),
          );
        }
        return ListTile(
          dense: true,
          leading: Icon(Icons.bolt, color: widget.color),
          title: Text('${widget.label} row $index'),
        );
      },
    );
  }
}

// =====================================================================
//  Section 6 — Conditional wantKeepAlive (toggleable)
// =====================================================================

class _ConditionalKeepAliveSection extends StatelessWidget {
  const _ConditionalKeepAliveSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            _Caption(
              'A horizontal carousel of three _ToggleKeepAlive widgets. '
              'Each one has a Switch labeled "Keep alive". When ON, '
              'wantKeepAlive returns true and the counter survives '
              'scrolling away. When OFF, wantKeepAlive becomes false '
              'and the next time the widget is scrolled out it can be '
              'disposed.',
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 240,
              child: _ToggleCarousel(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleCarousel extends StatefulWidget {
  const _ToggleCarousel();

  @override
  State<_ToggleCarousel> createState() => _ToggleCarouselState();
}

class _ToggleCarouselState extends State<_ToggleCarousel> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: 6,
      itemBuilder: (context, index) => _ToggleKeepAlive(index: index),
    );
  }
}

class _ToggleKeepAlive extends StatefulWidget {
  final int index;

  const _ToggleKeepAlive({required this.index});

  @override
  State<_ToggleKeepAlive> createState() => _ToggleKeepAliveState();
}

class _ToggleKeepAliveState extends State<_ToggleKeepAlive>
    with AutomaticKeepAliveClientMixin<_ToggleKeepAlive> {
  bool _keep = false;
  int _count = 0;

  @override
  bool get wantKeepAlive => _keep;

  void _toggle(bool v) {
    setState(() => _keep = v);
    updateKeepAlive();
  }

  void _bump() => setState(() => _count++);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 2,
        color: _keep ? Colors.green.shade50 : Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: _keep ? Colors.green : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Item ${widget.index + 1}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                title: const Text('Keep alive'),
                value: _keep,
                onChanged: _toggle,
              ),
              Text('counter: $_count'),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: _bump, child: const Text('+1')),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
//  Section 7 — Multiple kept-alive widgets composed
// =====================================================================

class _ComposedKeepAliveSection extends StatelessWidget {
  const _ComposedKeepAliveSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            _Caption(
              'A complex page hosts three nested kept-alive widgets: a '
              'counter, an animation, and a focused TextField. The page '
              'lives inside a PageView. Swipe to another page and back; '
              'all three children preserve their state because each '
              'mixes in AutomaticKeepAliveClientMixin independently.',
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 320,
              child: _ComposedPageView(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComposedPageView extends StatefulWidget {
  const _ComposedPageView();

  @override
  State<_ComposedPageView> createState() => _ComposedPageViewState();
}

class _ComposedPageViewState extends State<_ComposedPageView> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        if (index == 0) return const _ComposedRichPage();
        return _ComposedFiller(index: index);
      },
    );
  }
}

class _ComposedFiller extends StatelessWidget {
  final int index;
  const _ComposedFiller({required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        color: Colors.blueGrey.shade50,
        child: Center(
          child: Text(
            'Filler page ${index + 1}',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class _ComposedRichPage extends StatelessWidget {
  const _ComposedRichPage();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: const <Widget>[
          _CounterKeepAlive(),
          SizedBox(height: 12),
          _AnimKeepAlive(),
          SizedBox(height: 12),
          _FieldKeepAlive(),
        ],
      ),
    );
  }
}

class _CounterKeepAlive extends StatefulWidget {
  const _CounterKeepAlive();

  @override
  State<_CounterKeepAlive> createState() => _CounterKeepAliveState();
}

class _CounterKeepAliveState extends State<_CounterKeepAlive>
    with AutomaticKeepAliveClientMixin<_CounterKeepAlive> {
  int _count = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      child: ListTile(
        leading: const Icon(Icons.add_circle, color: Colors.indigo),
        title: const Text('Counter (kept alive)'),
        subtitle: Text('value: $_count'),
        trailing: ElevatedButton(
          onPressed: () => setState(() => _count++),
          child: const Text('+1'),
        ),
      ),
    );
  }
}

class _AnimKeepAlive extends StatefulWidget {
  const _AnimKeepAlive();

  @override
  State<_AnimKeepAlive> createState() => _AnimKeepAliveState();
}

class _AnimKeepAliveState extends State<_AnimKeepAlive>
    with
        AutomaticKeepAliveClientMixin<_AnimKeepAlive>,
        TickerProviderStateMixin<_AnimKeepAlive> {
  late final AnimationController _controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Animation (kept alive)'),
            const SizedBox(height: 8),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return LinearProgressIndicator(value: _controller.value);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldKeepAlive extends StatefulWidget {
  const _FieldKeepAlive();

  @override
  State<_FieldKeepAlive> createState() => _FieldKeepAliveState();
}

class _FieldKeepAliveState extends State<_FieldKeepAlive>
    with AutomaticKeepAliveClientMixin<_FieldKeepAlive> {
  final TextEditingController _controller =
      TextEditingController(text: 'draft text');
  final FocusNode _focus = FocusNode();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: TextField(
          controller: _controller,
          focusNode: _focus,
          decoration: const InputDecoration(
            labelText: 'Draft text (kept alive)',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}

// =====================================================================
//  Section 8 — Heavy widget keep-alive
// =====================================================================

class _HeavyKeepAliveSection extends StatelessWidget {
  const _HeavyKeepAliveSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            _Caption(
              'A _HeavyWidget simulates expensive setup: in initState it '
              'computes a cached gradient palette of 256 colors. With '
              'AutomaticKeepAliveClientMixin in place, that init runs '
              'once and is preserved across PageView swipes.',
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 240,
              child: _HeavyPageView(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeavyPageView extends StatefulWidget {
  const _HeavyPageView();

  @override
  State<_HeavyPageView> createState() => _HeavyPageViewState();
}

class _HeavyPageViewState extends State<_HeavyPageView> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => _HeavyWidget(index: index),
    );
  }
}

class _HeavyWidget extends StatefulWidget {
  final int index;
  const _HeavyWidget({required this.index});

  @override
  State<_HeavyWidget> createState() => _HeavyWidgetState();
}

class _HeavyWidgetState extends State<_HeavyWidget>
    with AutomaticKeepAliveClientMixin<_HeavyWidget> {
  late final List<Color> _palette;
  int _initRuns = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _palette = _computePalette();
    _initRuns = 1;
  }

  List<Color> _computePalette() {
    return List<Color>.generate(256, (i) {
      final int r = (i * 7 + widget.index * 31) % 256;
      final int g = (i * 13 + widget.index * 17) % 256;
      final int b = (i * 23 + widget.index * 11) % 256;
      return Color.fromARGB(255, r, g, b);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Heavy widget #${widget.index + 1}  '
                '(initState ran $_initRuns time)',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 16,
                ),
                itemCount: _palette.length,
                itemBuilder: (context, i) {
                  return Container(color: _palette[i]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
//  Section 9 — wantKeepAlive vs Provider-based persistence
// =====================================================================

class _MixinVsProviderSection extends StatelessWidget {
  const _MixinVsProviderSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            _Caption(
              'AutomaticKeepAliveClientMixin keeps in-State data alive '
              'within the same widget tree. Lifting state to a Provider, '
              'InheritedWidget, or any external store decouples the data '
              'lifetime from the widget lifetime. They solve overlapping '
              'but not identical problems.',
            ),
            SizedBox(height: 8),
            _MixinVsProviderTable(),
          ],
        ),
      ),
    );
  }
}

class _MixinVsProviderTable extends StatelessWidget {
  const _MixinVsProviderTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: const <Widget>[
          _CompareRow(
            label: 'Scope',
            mixin: 'Single State<T> in tree',
            provider: 'Anywhere via DI / context',
          ),
          _CompareRow(
            label: 'Survives navigation',
            mixin: 'No (only same parent)',
            provider: 'Yes (lives outside route)',
          ),
          _CompareRow(
            label: 'Survives parent rebuild',
            mixin: 'No (must remain mounted)',
            provider: 'Yes',
          ),
          _CompareRow(
            label: 'Memory cost',
            mixin: 'Whole widget retained',
            provider: 'Only data retained',
          ),
          _CompareRow(
            label: 'Code complexity',
            mixin: 'Tiny: one mixin',
            provider: 'Higher: setup + listening',
          ),
          _CompareRow(
            label: 'Best for',
            mixin: 'Tabs, lazy lists, page views',
            provider: 'App-wide state, models',
          ),
        ],
      ),
    );
  }
}

class _CompareRow extends StatelessWidget {
  final String label;
  final String mixin;
  final String provider;
  const _CompareRow({
    required this.label,
    required this.mixin,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(flex: 3, child: Text(mixin)),
          Expanded(flex: 3, child: Text(provider)),
        ],
      ),
    );
  }
}

// =====================================================================
//  Section 10 — Common pitfalls
// =====================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _InfoCard(
          icon: Icons.error,
          color: Colors.red,
          title: 'Forgetting super.build(context)',
          body:
              'AutomaticKeepAliveClientMixin asserts that build calls '
              'super.build(context) first. Skipping it triggers an '
              'assertion in debug mode and silently breaks the keep-alive '
              'request in release mode.',
        ),
        _InfoCard(
          icon: Icons.warning,
          color: Colors.orange,
          title: 'wantKeepAlive returning false initially',
          body:
              'If wantKeepAlive returns false on the first build the '
              'subtree is not registered. Later flipping to true does '
              'nothing unless you call updateKeepAlive() to re-register.',
        ),
        _InfoCard(
          icon: Icons.memory,
          color: Colors.deepPurple,
          title: 'Keep-alive uses memory',
          body:
              'Each kept-alive subtree keeps its full Element + State '
              'graph, including controllers and large caches. Use it '
              'sparingly: only on items the user is likely to return to.',
        ),
        _InfoCard(
          icon: Icons.alt_route,
          color: Colors.teal,
          title: 'Does NOT help with cross-route state',
          body:
              'When a route is popped the entire subtree is gone, '
              'mixin or not. Use Navigator state, an InheritedWidget, '
              'or a Provider/Bloc/Riverpod for cross-route persistence.',
        ),
        _InfoCard(
          icon: Icons.bolt,
          color: Colors.amber,
          title: 'Does not flip on the spot',
          body:
              'If wantKeepAlive changes value at runtime, you must call '
              'updateKeepAlive() yourself. The framework re-evaluates '
              'the keep-alive request only when notified.',
        ),
      ],
    );
  }
}

// =====================================================================
//  Section 11 — updateKeepAlive() showcase
// =====================================================================

class _UpdateKeepAliveSection extends StatelessWidget {
  const _UpdateKeepAliveSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            _Caption(
              '_DynamicKeep maintains a wantKeepAlive value that can '
              'change at runtime. After flipping the bool we call '
              'updateKeepAlive() so the framework re-registers the '
              'state with the AutomaticKeepAlive ancestor. The chips '
              'below display whether the widget is currently being '
              'kept alive.',
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 240,
              child: _DynamicKeepCarousel(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DynamicKeepCarousel extends StatelessWidget {
  const _DynamicKeepCarousel();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(viewportFraction: 0.85),
      itemCount: 4,
      itemBuilder: (context, index) => _DynamicKeep(index: index),
    );
  }
}

class _DynamicKeep extends StatefulWidget {
  final int index;
  const _DynamicKeep({required this.index});

  @override
  State<_DynamicKeep> createState() => _DynamicKeepState();
}

class _DynamicKeepState extends State<_DynamicKeep>
    with AutomaticKeepAliveClientMixin<_DynamicKeep> {
  bool _keep = false;
  int _count = 0;

  @override
  bool get wantKeepAlive => _keep;

  void _flip() {
    setState(() => _keep = !_keep);
    updateKeepAlive();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Dynamic ${widget.index + 1}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children: <Widget>[
                  Chip(
                    label: Text(_keep ? 'kept-alive' : 'not kept-alive'),
                    backgroundColor:
                        _keep ? Colors.green.shade100 : Colors.red.shade100,
                  ),
                  Chip(label: Text('counter: $_count')),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => setState(() => _count++),
                    child: const Text('+1'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _flip,
                    child: Text(_keep ? 'stop keeping' : 'start keeping'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
//  Section 12 — Recipe gallery
// =====================================================================

class _RecipeGallerySection extends StatelessWidget {
  const _RecipeGallerySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _RecipeCard(
          title: 'Video player keeps playback state',
          icon: Icons.play_circle,
          color: Colors.redAccent,
          body:
              'Mix the mixin into the video page; wantKeepAlive => true. '
              'The user can scroll an outer feed without restarting '
              'playback when they return.',
        ),
        _RecipeCard(
          title: 'Form preserves draft input',
          icon: Icons.edit_note,
          color: Colors.indigo,
          body:
              'TextEditingControllers and form errors live inside the '
              'kept-alive State, so a half-typed reply survives a tab '
              'switch without auto-saving to disk.',
        ),
        _RecipeCard(
          title: 'Expensive heatmap caches paint',
          icon: Icons.dashboard_customize,
          color: Colors.deepPurple,
          body:
              'A heatmap whose cells are computed from a large dataset '
              'caches its painted picture in the State; keep-alive '
              'avoids paying that cost on every revisit.',
        ),
        _RecipeCard(
          title: 'Tab content loads once',
          icon: Icons.tab,
          color: Colors.teal,
          body:
              'Each tab body fetches its data on first build. With the '
              'mixin, switching tabs does not re-trigger the fetch — '
              'state is preserved until the parent dies.',
        ),
      ],
    );
  }
}

class _RecipeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String body;

  const _RecipeCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: color.withOpacity(0.4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(body, style: const TextStyle(fontSize: 13, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
//  Section 13 — Reference table
// =====================================================================

class _ReferenceTableSection extends StatelessWidget {
  const _ReferenceTableSection();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            _Caption(
              'A short reference of the related types in '
              'package:flutter/widgets.dart that participate in '
              'keep-alive negotiations.',
            ),
            SizedBox(height: 8),
            _ReferenceTable(),
          ],
        ),
      ),
    );
  }
}

class _ReferenceTable extends StatelessWidget {
  const _ReferenceTable();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: const <Widget>[
          _RefRow(
            name: 'AutomaticKeepAliveClientMixin',
            kind: 'mixin',
            description:
                'Mixed into State<T>; declares wantKeepAlive and '
                'sends KeepAliveNotifications up the tree.',
          ),
          _RefRow(
            name: 'AutomaticKeepAlive',
            kind: 'widget',
            description:
                'Inserted by lazy parents (ListView, PageView…); '
                'listens for KeepAliveNotifications and wraps the '
                'child in a KeepAlive when requested.',
          ),
          _RefRow(
            name: 'KeepAlive',
            kind: 'widget',
            description:
                'Parent-data widget that marks its child as kept '
                'alive in a SliverWithKeepAliveWidget context.',
          ),
          _RefRow(
            name: 'KeepAliveNotification',
            kind: 'notification',
            description:
                'Sent by a State to ask its closest '
                'AutomaticKeepAlive ancestor to keep its subtree '
                'alive (or to release it).',
          ),
          _RefRow(
            name: 'KeepAliveHandle',
            kind: 'class',
            description:
                'The token returned by a KeepAliveNotification; '
                'the handle is released when the State no longer '
                'wants to be kept alive.',
          ),
        ],
      ),
    );
  }
}

class _RefRow extends StatelessWidget {
  final String name;
  final String kind;
  final String description;

  const _RefRow({
    required this.name,
    required this.kind,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  kind,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.indigo,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(description, style: const TextStyle(fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}

// =====================================================================
//  Footer card
// =====================================================================

class _FooterCard extends StatelessWidget {
  const _FooterCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo.shade50,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.indigo.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              'Recap',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 8),
            _BulletPoint(
              'Mix AutomaticKeepAliveClientMixin into State<T> '
              'when a lazy parent will dispose your widget.',
            ),
            _BulletPoint(
              'Override wantKeepAlive — return true unconditionally '
              'or return a dynamic value tied to your state.',
            ),
            _BulletPoint(
              'Always call super.build(context) first inside build.',
            ),
            _BulletPoint(
              'Use updateKeepAlive() when wantKeepAlive value '
              'changes at runtime.',
            ),
            _BulletPoint(
              'Prefer external state stores (Provider, InheritedWidget) '
              'when state must outlive the widget tree.',
            ),
            _BulletPoint(
              'Use sparingly: each kept-alive subtree retains its full '
              'Element + State graph in memory.',
            ),
          ],
        ),
      ),
    );
  }
}

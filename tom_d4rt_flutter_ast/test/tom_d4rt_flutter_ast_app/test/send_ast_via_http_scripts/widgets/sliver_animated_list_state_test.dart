// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

/// Deep visual demo — SliverAnimatedListState
///
/// SliverAnimatedListState is the state object associated with
/// SliverAnimatedList. It exposes APIs to insert and remove items
/// with animated transitions, exactly like AnimatedListState does
/// for AnimatedList. The sliver variant integrates into a
/// CustomScrollView alongside other slivers.
///
/// Sections
/// ─────────
/// 1. What is SliverAnimatedListState?
/// 2. API surface — insertItem, removeItem, insertAllItems, removeAllItems
/// 3. GlobalKey access pattern
/// 4. Live: interactive animated list (insert, remove, shuffle)
/// 5. Live: multi-operation queue
/// 6. Best practices

// ─── palette ───────────────────────────────────────────────
const _kSlate      = Color(0xFF546E7A);
const _kSlateLight = Color(0xFFCFD8DC);
const _kSlateDark  = Color(0xFF263238);
const _kOrange     = Color(0xFFFF9800);
const _kOrangeLight = Color(0xFFFFF3E0);
const _kOrangeDark = Color(0xFFE65100);
const _kSurface    = Color(0xFFFBFCFD);
const _kDivider    = Color(0xFFE0E0E0);
const _kTextDark   = Color(0xFF212121);
const _kTextMuted  = Color(0xFF757575);

// ─── theory content ────────────────────────────────────────
const _kOverview = 'SliverAnimatedListState coordinates animated insertions '
    'and removals in a SliverAnimatedList. It works like AnimatedListState '
    'but lives inside a CustomScrollView, composing with other slivers. '
    'Access it via a GlobalKey<SliverAnimatedListState> and call insertItem() '
    'or removeItem() to trigger animated transitions. The framework handles '
    'synchronizing the animation with the underlying scroll layout.';

class _ApiMethod {
  const _ApiMethod(this.name, this.signature, this.description);
  final String name;
  final String signature;
  final String description;
}

const _kApiMethods = <_ApiMethod>[
  _ApiMethod('insertItem', 'insertItem(int index, {Duration duration})',
      'Inserts an item at the given index. The list grows by one '
      'and the inserted item animates in using the itemBuilder\'s '
      'animation parameter. Duration defaults to 300ms.'),
  _ApiMethod('removeItem',
      'removeItem(int index, AnimatedRemovedItemBuilder builder, {Duration duration})',
      'Removes the item at the given index. You must provide a builder '
      'that returns the widget during the removal animation, typically '
      'using SizeTransition or FadeTransition. The builder receives '
      'the animation that drives from 1.0 to 0.0.'),
  _ApiMethod('insertAllItems', 'insertAllItems(int index, int length, {Duration duration})',
      'Inserts multiple items starting at the given index. Each item '
      'is animated in sequence. The total visual duration depends on '
      'the length and per-item duration.'),
  _ApiMethod('removeAllItems',
      'removeAllItems(AnimatedRemovedItemBuilder builder, {Duration duration})',
      'Removes all items, animating each out using the provided builder. '
      'Useful for clearing the list with a sweep animation.'),
];

class _Practice {
  const _Practice(this.tip, this.detail);
  final String tip;
  final String detail;
}

const _kPractices = <_Practice>[
  _Practice('Always sync your data model',
      'Call insertItem / removeItem AND update your backing list at '
      'the same time. The animated list tracks item count internally '
      'and will throw if counts diverge.'),
  _Practice('Use GlobalKey, not context.findAncestorStateOfType',
      'SliverAnimatedList is often deep in the widget tree. A GlobalKey '
      'provides direct access without traversing context.'),
  _Practice('Keep removal builder lightweight',
      'The removal builder runs for every frame of the exit animation. '
      'Cache any expensive computation before calling removeItem.'),
  _Practice('Stagger insertAllItems for visual polish',
      'insertAllItems animates each item with the same duration. '
      'For staggered effects, call insertItem multiple times with '
      'addPostFrameCallback or a Timer cascade.'),
  _Practice('Wrap in SliverPadding for spacing',
      'SliverAnimatedList does not support padding directly. '
      'Wrap it in SliverPadding inside your CustomScrollView.'),
];

// ─── shared helpers ────────────────────────────────────────
Widget _sectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [_kSlateDark, _kOrangeDark]),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 16,
                  fontWeight: FontWeight.w700, letterSpacing: 0.4)),
        ),
      ],
    ),
  );
}

Widget _card({required Widget child}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kDivider),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04),
          blurRadius: 6, offset: Offset(0, 2))],
    ),
    child: child,
  );
}

Widget _label(String text) {
  return Text(text,
      style: TextStyle(fontSize: 11, color: _kTextMuted,
          fontWeight: FontWeight.w600, letterSpacing: 0.6));
}

Widget _mono(String text, {Color? color}) {
  return Text(text,
      style: TextStyle(fontFamily: 'monospace', fontSize: 12.5,
          color: color ?? _kTextDark, height: 1.45));
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 8, bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(margin: EdgeInsets.only(top: 7), width: 5, height: 5,
            decoration: BoxDecoration(color: _kSlate, shape: BoxShape.circle)),
        SizedBox(width: 10),
        Expanded(child: Text(text,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
      ],
    ),
  );
}

// ─── entry point ───────────────────────────────────────────
dynamic build(BuildContext context) {
  print('SliverAnimatedListState deep visual demo');
  print('─' * 48);
  print('Sections: overview, API, GlobalKey, interactive animated list,');
  print('multi-operation queue, best practices.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: _kSlate, brightness: Brightness.light),
      scaffoldBackgroundColor: _kSurface,
    ),
    home: _DemoScaffold(),
  );
}

class _DemoScaffold extends StatefulWidget {
  @override
  State<_DemoScaffold> createState() => _DemoScaffoldState();
}

class _DemoScaffoldState extends State<_DemoScaffold> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverAnimatedListState'),
        backgroundColor: _kSlateDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: [_TheoryPage(), _InteractivePage(), _QueuePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        selectedItemColor: _kSlateDark,
        onTap: (i) => setState(() => _tabIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.school_outlined), label: 'Theory'),
          BottomNavigationBarItem(icon: Icon(Icons.touch_app), label: 'Interactive'),
          BottomNavigationBarItem(icon: Icon(Icons.queue), label: 'Queue'),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 1: Theory
// ═══════════════════════════════════════════════════════════
class _TheoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 40),
      children: [
        _sectionHeader('1 · What Is SliverAnimatedListState?', Icons.info_outline),
        SizedBox(height: 8),
        _card(child: Text(_kOverview,
            style: TextStyle(fontSize: 13, color: _kTextDark, height: 1.4))),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('GLOBAL KEY PATTERN'),
              SizedBox(height: 8),
              _mono('final _listKey ='),
              _mono('  GlobalKey<SliverAnimatedListState>();'),
              SizedBox(height: 6),
              _mono('SliverAnimatedList('),
              _mono('  key: _listKey,'),
              _mono('  initialItemCount: items.length,'),
              _mono('  itemBuilder: (ctx, idx, anim) =>'),
              _mono('    SizeTransition('),
              _mono('      sizeFactor: anim,'),
              _mono('      child: ItemTile(items[idx]),'),
              _mono('    ),'),
              _mono(')'),
              SizedBox(height: 8),
              _bullet('Declare a GlobalKey typed to SliverAnimatedListState.'),
              _bullet('Pass it to SliverAnimatedList via the key parameter.'),
              _bullet('Access the state via _listKey.currentState to insert/remove.'),
            ],
          ),
        ),

        SizedBox(height: 12),
        _sectionHeader('2 · API Surface', Icons.api),
        SizedBox(height: 8),
        ..._kApiMethods.map((m) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _kOrangeLight,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(m.name,
                    style: TextStyle(fontFamily: 'monospace',
                        fontWeight: FontWeight.w700, fontSize: 12,
                        color: _kOrangeDark)),
              ),
              SizedBox(height: 4),
              Text(m.signature,
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11,
                      color: _kTextMuted)),
              SizedBox(height: 6),
              Text(m.description,
                  style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
            ],
          ),
        )),

        SizedBox(height: 12),
        _sectionHeader('3 · Insert / Remove Flow', Icons.swap_vert),
        SizedBox(height: 8),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('INSERT FLOW'),
              SizedBox(height: 6),
              _mono('1. _items.insert(index, newItem);'),
              _mono('2. _listKey.currentState!'),
              _mono('     .insertItem(index);'),
              _mono('3. itemBuilder called with animation'),
              _mono('   going from 0.0 → 1.0'),
              SizedBox(height: 12),
              _label('REMOVE FLOW'),
              SizedBox(height: 6),
              _mono('1. final removed = _items.removeAt(index);'),
              _mono('2. _listKey.currentState!.removeItem('),
              _mono('     index,'),
              _mono('     (ctx, anim) => SizeTransition('),
              _mono('       sizeFactor: anim,'),
              _mono('       child: ItemTile(removed),'),
              _mono('     ),'),
              _mono('   );'),
              _mono('3. Builder animates 1.0 → 0.0, then'),
              _mono('   widget is discarded.'),
            ],
          ),
        ),

        SizedBox(height: 12),
        _sectionHeader('4 · Best Practices', Icons.lightbulb_outlined),
        SizedBox(height: 8),
        ..._kPractices.map((p) => _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline, color: _kOrange, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(p.tip,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13,
                            color: _kSlateDark)),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text(p.detail,
                    style: TextStyle(fontSize: 12.5, color: _kTextDark, height: 1.35)),
              ),
            ],
          ),
        )),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 2: Interactive animated list
// ═══════════════════════════════════════════════════════════
class _InteractivePage extends StatefulWidget {
  @override
  State<_InteractivePage> createState() => _InteractivePageState();
}

class _InteractivePageState extends State<_InteractivePage> {
  final _listKey = GlobalKey<SliverAnimatedListState>();
  final _items = <_ListItem>[];
  int _nextId = 1;
  int _insertCount = 0;
  int _removeCount = 0;

  static const _kColors = <Color>[
    Color(0xFFE3F2FD), Color(0xFFFFF3E0), Color(0xFFE8F5E9),
    Color(0xFFFCE4EC), Color(0xFFF3E5F5), Color(0xFFFFFDE7),
    Color(0xFFE0F7FA), Color(0xFFEFEBE9), Color(0xFFE8EAF6),
  ];

  void _insertAtTop() {
    final item = _ListItem(id: _nextId++,
        color: _kColors[_items.length % _kColors.length]);
    _items.insert(0, item);
    _listKey.currentState?.insertItem(0, duration: Duration(milliseconds: 400));
    setState(() => _insertCount++);
  }

  void _insertAtEnd() {
    final idx = _items.length;
    final item = _ListItem(id: _nextId++,
        color: _kColors[idx % _kColors.length]);
    _items.add(item);
    _listKey.currentState?.insertItem(idx, duration: Duration(milliseconds: 400));
    setState(() => _insertCount++);
  }

  void _removeAt(int index) {
    if (index < 0 || index >= _items.length) return;
    final removed = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildRemoving(removed, animation),
      duration: Duration(milliseconds: 350),
    );
    setState(() => _removeCount++);
  }

  void _clearAll() {
    if (_items.isEmpty) return;
    final old = List<_ListItem>.from(_items);
    _items.clear();
    _listKey.currentState?.removeAllItems(
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: FadeTransition(
          opacity: animation,
          child: Container(
            height: 60, margin: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            decoration: BoxDecoration(
              color: _kSlateLight.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      duration: Duration(milliseconds: 300),
    );
    setState(() => _removeCount += old.length);
  }

  Widget _buildItem(_ListItem item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: _ItemTile(
          item: item,
          index: _items.indexOf(item),
          onRemove: () => _removeAt(_items.indexOf(item)),
        ),
      ),
    );
  }

  Widget _buildRemoving(_ListItem item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: Container(
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red.shade200),
          ),
          alignment: Alignment.center,
          child: Text('Removing #${item.id}',
              style: TextStyle(color: Colors.red, fontSize: 12,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          color: _kSlateDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('INTERACTIVE ANIMATED LIST',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 4),
              Text('Tap buttons to insert or remove items with animations. '
                  'Each operation syncs the data model with the animated state.',
                  style: TextStyle(color: Colors.white70, fontSize: 10.5,
                      height: 1.3)),
              SizedBox(height: 8),
              Row(
                children: [
                  _statBadge('Items', '${_items.length}'),
                  SizedBox(width: 8),
                  _statBadge('Inserts', '$_insertCount'),
                  SizedBox(width: 8),
                  _statBadge('Removes', '$_removeCount'),
                ],
              ),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _actionButton('+ Top', Icons.vertical_align_top, _insertAtTop),
                    SizedBox(width: 6),
                    _actionButton('+ End', Icons.vertical_align_bottom, _insertAtEnd),
                    SizedBox(width: 6),
                    _actionButton('- First', Icons.remove_circle_outline,
                        _items.isNotEmpty ? () => _removeAt(0) : null),
                    SizedBox(width: 6),
                    _actionButton('- Last', Icons.remove_circle_outline,
                        _items.isNotEmpty ? () => _removeAt(_items.length - 1) : null),
                    SizedBox(width: 6),
                    _actionButton('Clear', Icons.delete_sweep,
                        _items.isNotEmpty ? _clearAll : null),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(top: 8, bottom: 40),
                sliver: SliverAnimatedList(
                  key: _listKey,
                  initialItemCount: _items.length,
                  itemBuilder: (context, index, animation) =>
                      _buildItem(_items[index], animation),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statBadge(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.white54, fontSize: 9,
                fontWeight: FontWeight.w600)),
            Text(value, style: TextStyle(color: _kOrange,
                fontFamily: 'monospace', fontSize: 13,
                fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(String label, IconData icon, VoidCallback? onTap) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: enabled
              ? _kOrange.withOpacity(0.25)
              : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: enabled ? _kOrange : Colors.white24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: enabled ? _kOrange : Colors.white30, size: 14),
            SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    color: enabled ? Colors.white : Colors.white30,
                    fontSize: 10.5, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _ListItem {
  const _ListItem({required this.id, required this.color});
  final int id;
  final Color color;
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({
    required this.item,
    required this.index,
    required this.onRemove,
  });

  final _ListItem item;
  final int index;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      height: 60,
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kDivider),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Container(
            width: 34, height: 34,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text('#${item.id}',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11,
                    color: _kTextDark)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Item #${item.id}',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13,
                        color: _kTextDark)),
                Text('Position: $index',
                    style: TextStyle(fontSize: 10, color: _kTextMuted)),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                color: Colors.red.shade50, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(Icons.close, color: Colors.red, size: 14),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// TAB 3: Multi-operation queue
// ═══════════════════════════════════════════════════════════
class _QueuePage extends StatefulWidget {
  @override
  State<_QueuePage> createState() => _QueuePageState();
}

class _QueuePageState extends State<_QueuePage> {
  final _listKey = GlobalKey<SliverAnimatedListState>();
  final _items = <_QueueEntry>[];
  final _log = <String>[];
  int _nextId = 1;

  static const _kEntryColors = <Color>[
    Color(0xFFE8F5E9), Color(0xFFFFF8E1), Color(0xFFE3F2FD),
    Color(0xFFFCE4EC), Color(0xFFEDE7F6), Color(0xFFE0F7FA),
  ];

  void _enqueueInsert(int count) {
    for (var i = 0; i < count; i++) {
      final idx = _items.length;
      final entry = _QueueEntry(
        id: _nextId++,
        color: _kEntryColors[idx % _kEntryColors.length],
      );
      _items.add(entry);
      _listKey.currentState?.insertItem(idx,
          duration: Duration(milliseconds: 350));
    }
    setState(() {
      _log.insert(0, 'Inserted $count items (total: ${_items.length})');
    });
  }

  void _dequeueRemove(int count) {
    final toRemove = count.clamp(0, _items.length);
    for (var i = 0; i < toRemove; i++) {
      if (_items.isEmpty) break;
      final removed = _items.removeAt(0);
      _listKey.currentState?.removeItem(
        0,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: FadeTransition(
            opacity: animation,
            child: Container(
              height: 52,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Text('Dequeuing #${removed.id}',
                  style: TextStyle(fontSize: 11, color: Colors.red)),
            ),
          ),
        ),
        duration: Duration(milliseconds: 250),
      );
    }
    setState(() {
      _log.insert(0, 'Removed $toRemove items (total: ${_items.length})');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          color: _kSlateDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('MULTI-OPERATION QUEUE',
                  style: TextStyle(color: Colors.white70, fontSize: 11,
                      fontWeight: FontWeight.w700, letterSpacing: 0.6)),
              SizedBox(height: 4),
              Text('Add or remove batches of items. Operations queue and '
                  'animate in sequence, showing how SliverAnimatedListState '
                  'handles rapid fire mutations.',
                  style: TextStyle(color: Colors.white70, fontSize: 10.5,
                      height: 1.3)),
              SizedBox(height: 8),
              Row(
                children: [
                  _queueButton('+ 1', () => _enqueueInsert(1)),
                  SizedBox(width: 6),
                  _queueButton('+ 3', () => _enqueueInsert(3)),
                  SizedBox(width: 6),
                  _queueButton('+ 5', () => _enqueueInsert(5)),
                  SizedBox(width: 12),
                  _queueButton('- 1', () => _dequeueRemove(1)),
                  SizedBox(width: 6),
                  _queueButton('- 3', () => _dequeueRemove(3)),
                  SizedBox(width: 6),
                  _queueButton('- All', () => _dequeueRemove(_items.length)),
                ],
              ),
            ],
          ),
        ),
        // Operation log
        if (_log.isNotEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: _kSlateLight.withOpacity(0.4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('OPERATION LOG', style: TextStyle(fontSize: 9,
                    fontWeight: FontWeight.w700, color: _kTextMuted,
                    letterSpacing: 0.5)),
                SizedBox(height: 4),
                ..._log.take(5).map((l) => Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(l, style: TextStyle(fontFamily: 'monospace',
                      fontSize: 10.5, color: _kTextDark)),
                )),
              ],
            ),
          ),
        // Animated list
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(top: 8, bottom: 40),
                sliver: SliverAnimatedList(
                  key: _listKey,
                  initialItemCount: _items.length,
                  itemBuilder: (context, index, animation) {
                    final item = _items[index];
                    return SizeTransition(
                      sizeFactor: animation,
                      child: FadeTransition(
                        opacity: animation,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 3),
                          height: 52,
                          decoration: BoxDecoration(
                            color: item.color,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _kDivider),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            children: [
                              Container(
                                width: 30, height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  shape: BoxShape.circle),
                                alignment: Alignment.center,
                                child: Text('${item.id}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 11, color: _kTextDark)),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text('Queue entry #${item.id}',
                                    style: TextStyle(fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: _kTextDark)),
                              ),
                              Text('pos $index',
                                  style: TextStyle(fontFamily: 'monospace',
                                      fontSize: 10, color: _kTextMuted)),
                            ],
                          ),
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
    );
  }

  Widget _queueButton(String label, VoidCallback onTap) {
    final isRemove = label.startsWith('-');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isRemove
              ? Colors.red.withOpacity(0.2)
              : _kOrange.withOpacity(0.25),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isRemove ? Colors.red.shade300 : _kOrange,
          ),
        ),
        child: Text(label,
            style: TextStyle(
                color: Colors.white, fontSize: 11,
                fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class _QueueEntry {
  const _QueueEntry({required this.id, required this.color});
  final int id;
  final Color color;
}

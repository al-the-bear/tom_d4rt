// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  ScrollViewKeyboardDismissBehavior  –  Deep Visual Demo
//
//  Palette : Indigo 700 / Pink 300
//  Tabs    : Theory · Playground · Comparison
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('ScrollViewKeyboardDismissBehavior demo building');
  return _ScrollViewKBDDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFF303F9F); // Indigo 700
const _kAccent = Color(0xFFF06292); // Pink 300
const _kSurface = Color(0xFFE8EAF6); // Indigo 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF1A237E); // Indigo 900
const _kMuted = Color(0xFF9FA8DA); // Indigo 200
const _kCodeBg = Color(0xFFFCE4EC); // Pink 50
const _kManualColor = Color(0xFF1565C0); // Blue 800
const _kOnDragColor = Color(0xFF2E7D32); // Green 800
const _kHighlight = Color(0xFFFFF8E1); // Amber 50
const _kDisabledBg = Color(0xFFF5F5F5);

class _ScrollViewKBDDemo extends StatefulWidget {
  @override
  State<_ScrollViewKBDDemo> createState() =>
      _ScrollViewKBDDemoState();
}

class _ScrollViewKBDDemoState extends State<_ScrollViewKBDDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        title: Text('ScrollViewKeyboardDismissBehavior',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kAccent,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Theory'),
            Tab(text: 'Playground'),
            Tab(text: 'Comparison'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _PlaygroundTab(),
          _ComparisonTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 1  –  Theory
// ═══════════════════════════════════════════════════════════
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── Overview ────────────────────────────────────
        _sectionCard(
          'What is ScrollViewKeyboardDismissBehavior?',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ScrollViewKeyboardDismissBehavior is an enum that controls '
                'whether a scroll view automatically dismisses the on-screen '
                'keyboard when the user begins scrolling. It is passed to '
                'ListView, GridView, CustomScrollView, and other scrollable '
                'widgets via the keyboardDismissBehavior parameter.',
                style: TextStyle(
                    color: _kDarkText, fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 12),
              _codeBlock(
                'enum ScrollViewKeyboardDismissBehavior {\n'
                '  manual,   // default — keyboard stays open\n'
                '  onDrag,   // dismisses when scrolling begins\n'
                '}',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Values ──────────────────────────────────────
        _sectionCard(
          'Enum Values',
          Column(
            children: [
              _enumValue(
                'manual',
                'The keyboard is NOT automatically dismissed when the user '
                'scrolls. This is the default behaviour. The user must '
                'explicitly dismiss it (e.g. tapping outside the text field '
                'or pressing the platform\'s dismiss button).',
                _kManualColor,
                Icons.keyboard,
                isDefault: true,
              ),
              SizedBox(height: 10),
              _enumValue(
                'onDrag',
                'The keyboard is dismissed as soon as the user begins '
                'dragging the scroll view. This provides a smoother UX in '
                'search-and-scroll patterns where the user types in a '
                'text field and then scrolls to browse the results.',
                _kOnDragColor,
                Icons.swipe_vertical,
                isDefault: false,
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Usage context ───────────────────────────────
        _sectionCard(
          'Which Widgets Use It?',
          Column(
            children: [
              _widgetRow('ListView', 'keyboardDismissBehavior', true),
              _widgetRow('GridView', 'keyboardDismissBehavior', true),
              _widgetRow(
                  'CustomScrollView', 'keyboardDismissBehavior', true),
              _widgetRow('SingleChildScrollView',
                  'keyboardDismissBehavior', true),
              _widgetRow('NestedScrollView',
                  'keyboardDismissBehavior', true),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kHighlight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: Color(0xFFFFC107).withOpacity(0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline,
                        size: 16, color: Color(0xFFF57F17)),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'All of these widgets delegate the actual dismiss '
                        'logic to their underlying Scrollable, which calls '
                        'SystemChannels.textInput.invokeMethod("TextInput.hide")'
                        ' when a drag starts and the behaviour is onDrag.',
                        style: TextStyle(
                            fontSize: 12,
                            color: _kDarkText,
                            height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── How it works internally ─────────────────────
        _sectionCard(
          'Internal Mechanism',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _step(1, 'Widget creation',
                  'You pass keyboardDismissBehavior: ScrollViewKeyboard'
                  'DismissBehavior.onDrag to a ListView (or similar).',
                  _kPrimary),
              SizedBox(height: 6),
              _step(2, 'Scrollable receives value',
                  'The ScrollView passes the behaviour to its Scrollable '
                  'child widget.',
                  Color(0xFF6A1B9A)),
              SizedBox(height: 6),
              _step(3, 'Drag notification',
                  'When a drag gesture starts, Scrollable checks the '
                  'behaviour enum.',
                  Color(0xFFC62828)),
              SizedBox(height: 6),
              _step(4, 'Keyboard dismiss',
                  'If onDrag, the Scrollable calls '
                  'primaryFocus?.unfocus() and '
                  'SystemChannels.textInput.invokeMethod("TextInput.hide").',
                  _kOnDragColor),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Code example ────────────────────────────────
        _sectionCard(
          'Code Example',
          _codeBlock(
            'ListView.builder(\n'
            '  keyboardDismissBehavior:\n'
            '      ScrollViewKeyboardDismissBehavior.onDrag,\n'
            '  itemCount: items.length,\n'
            '  itemBuilder: (context, index) {\n'
            '    return ListTile(\n'
            '      title: Text(items[index]),\n'
            '    );\n'
            '  },\n'
            ')',
          ),
        ),
        SizedBox(height: 14),

        // ── Best practices ──────────────────────────────
        _sectionCard(
          'Best Practices',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bp(true,
                  'Use onDrag for search-and-scroll UX patterns where '
                  'the user types in a text field above a scrollable list.'),
              _bp(true,
                  'Use manual (default) when the user needs to keep '
                  'editing while scrolling, such as forms with many fields.'),
              _bp(true,
                  'Combine with GestureDetector.onTap → FocusScope.unfocus() '
                  'for a "tap outside to dismiss" pattern on manual.'),
              _bp(false,
                  'Do NOT use onDrag on forms where the user scrolls between '
                  'input fields — the keyboard closing and reopening is jarring.'),
              _bp(false,
                  'Do NOT rely on this alone for accessibility — always '
                  'provide an explicit dismiss button for keyboard users.'),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 2  –  Playground
// ═══════════════════════════════════════════════════════════
class _PlaygroundTab extends StatefulWidget {
  @override
  State<_PlaygroundTab> createState() => _PlaygroundTabState();
}

class _PlaygroundTabState extends State<_PlaygroundTab> {
  ScrollViewKeyboardDismissBehavior _behavior =
      ScrollViewKeyboardDismissBehavior.manual;

  final TextEditingController _searchCtrl = TextEditingController();
  String _filter = '';
  int _dragCount = 0;
  bool _keyboardShown = false;
  final List<_ScrollEvent> _events = [];
  int _eventId = 0;

  final List<String> _allItems = List.generate(
      60,
      (i) => [
            'Apple', 'Banana', 'Cherry', 'Date', 'Elderberry',
            'Fig', 'Grape', 'Honeydew', 'Kiwi', 'Lemon',
            'Mango', 'Nectarine', 'Orange', 'Papaya', 'Quince',
            'Raspberry', 'Strawberry', 'Tangerine', 'Ugli Fruit',
            'Watermelon',
          ][i % 20]);

  void _onSearchChanged(String text) {
    setState(() => _filter = text.toLowerCase());
  }

  void _trackDrag() {
    _dragCount++;
    _eventId++;
    final dismissed =
        _behavior == ScrollViewKeyboardDismissBehavior.onDrag &&
            _keyboardShown;
    setState(() {
      _events.insert(
          0,
          _ScrollEvent(
            id: _eventId,
            action: 'Drag started',
            behavior: _behavior.name,
            keyboardDismissed: dismissed,
            time: DateTime.now(),
          ));
      if (_events.length > 30) _events.removeLast();
      if (dismissed) _keyboardShown = false;
    });
    print('Drag #$_dragCount, behavior=${_behavior.name}, '
        'dismissed=$dismissed');
  }

  void _trackFocus(bool focused) {
    _eventId++;
    setState(() {
      _keyboardShown = focused;
      _events.insert(
          0,
          _ScrollEvent(
            id: _eventId,
            action: focused ? 'Keyboard shown' : 'Keyboard hidden',
            behavior: _behavior.name,
            keyboardDismissed: false,
            time: DateTime.now(),
          ));
      if (_events.length > 30) _events.removeLast();
    });
  }

  List<String> get _filteredItems => _filter.isEmpty
      ? _allItems
      : _allItems.where((s) => s.toLowerCase().contains(_filter)).toList();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left: interactive scroll area
        Expanded(
          flex: 3,
          child: Column(
            children: [
              // ── Behavior selector ────────────────────
              Container(
                color: _kCardBg,
                padding:
                    EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    Text('Behavior:',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: _kDarkText)),
                    SizedBox(width: 10),
                    _behaviorChip(
                        ScrollViewKeyboardDismissBehavior.manual,
                        'manual',
                        _kManualColor),
                    SizedBox(width: 6),
                    _behaviorChip(
                        ScrollViewKeyboardDismissBehavior.onDrag,
                        'onDrag',
                        _kOnDragColor),
                    Spacer(),
                    // Keyboard indicator
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _keyboardShown
                            ? Color(0xFFC8E6C9)
                            : _kDisabledBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _keyboardShown
                                ? Icons.keyboard
                                : Icons.keyboard_hide,
                            size: 14,
                            color: _keyboardShown
                                ? _kOnDragColor
                                : _kMuted,
                          ),
                          SizedBox(width: 4),
                          Text(
                            _keyboardShown ? 'Open' : 'Closed',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: _keyboardShown
                                    ? _kOnDragColor
                                    : _kMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1),

              // ── Search field ─────────────────────────
              Container(
                color: _kCardBg,
                padding:
                    EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Focus(
                  onFocusChange: _trackFocus,
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Search fruits...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      prefixIcon: Icon(Icons.search, size: 18),
                      suffixIcon: _filter.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                _searchCtrl.clear();
                                _onSearchChanged('');
                              },
                              child: Icon(Icons.clear, size: 16),
                            )
                          : null,
                    ),
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ),
              Divider(height: 1),

              // ── Info banner ──────────────────────────
              Container(
                color: _behavior ==
                        ScrollViewKeyboardDismissBehavior.onDrag
                    ? _kOnDragColor.withOpacity(0.06)
                    : _kManualColor.withOpacity(0.06),
                padding:
                    EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                child: Row(
                  children: [
                    Icon(
                      _behavior ==
                              ScrollViewKeyboardDismissBehavior.onDrag
                          ? Icons.swipe_vertical
                          : Icons.touch_app,
                      size: 14,
                      color: _behavior ==
                              ScrollViewKeyboardDismissBehavior.onDrag
                          ? _kOnDragColor
                          : _kManualColor,
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        _behavior ==
                                ScrollViewKeyboardDismissBehavior.onDrag
                            ? 'onDrag: Tap the search field, then scroll '
                                'the list — keyboard will auto-dismiss.'
                            : 'manual: Tap the search field, then scroll — '
                                'keyboard stays open until you dismiss it.',
                        style: TextStyle(
                            fontSize: 11,
                            color: _kDarkText,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Scrollable list ──────────────────────
              Expanded(
                child: NotificationListener<ScrollStartNotification>(
                  onNotification: (n) {
                    if (n.dragDetails != null) _trackDrag();
                    return false;
                  },
                  child: ListView.builder(
                    keyboardDismissBehavior: _behavior,
                    padding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    itemCount: _filteredItems.length,
                    itemBuilder: (_, i) {
                      final item = _filteredItems[i];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: _kCardBg,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 4,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color:
                                      _kPrimary.withOpacity(0.08),
                                  borderRadius:
                                      BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  item.substring(0, 1),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: _kPrimary),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(item,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: _kDarkText)),
                              ),
                              Text('#${i + 1}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: _kMuted)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

        // Right: event log sidebar
        Container(
          width: 240,
          decoration: BoxDecoration(
            color: _kCardBg,
            border:
                Border(left: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: _kPrimary.withOpacity(0.06),
                child: Row(
                  children: [
                    Icon(Icons.list_alt,
                        size: 16, color: _kPrimary),
                    SizedBox(width: 6),
                    Text('Event Log',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: _kDarkText)),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _kPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('$_dragCount drags',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _events.isEmpty
                    ? Center(
                        child: Text(
                          'Interact with the search\n'
                          'and list to see events',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: _kMuted, fontSize: 11),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(6),
                        itemCount: _events.length,
                        itemBuilder: (_, i) {
                          final e = _events[i];
                          final isKb =
                              e.action.contains('Keyboard');
                          final isDrag =
                              e.action.contains('Drag');
                          return Padding(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: e.keyboardDismissed
                                    ? _kOnDragColor
                                        .withOpacity(0.06)
                                    : _kPrimary.withOpacity(0.03),
                                borderRadius:
                                    BorderRadius.circular(6),
                                border: Border.all(
                                    color: e.keyboardDismissed
                                        ? _kOnDragColor
                                            .withOpacity(0.2)
                                        : _kPrimary
                                            .withOpacity(0.08)),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        isKb
                                            ? (e.action
                                                    .contains('shown')
                                                ? Icons.keyboard
                                                : Icons
                                                    .keyboard_hide)
                                            : Icons.swipe_vertical,
                                        size: 12,
                                        color: isDrag
                                            ? _kPrimary
                                            : _kOnDragColor,
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(e.action,
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.w600,
                                                fontSize: 10,
                                                color: _kDarkText)),
                                      ),
                                      Text(
                                        '${e.time.hour.toString().padLeft(2, '0')}:'
                                        '${e.time.minute.toString().padLeft(2, '0')}:'
                                        '${e.time.second.toString().padLeft(2, '0')}',
                                        style: TextStyle(
                                            fontSize: 8,
                                            color: _kMuted),
                                      ),
                                    ],
                                  ),
                                  if (e.keyboardDismissed) ...[
                                    SizedBox(height: 3),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2),
                                      decoration: BoxDecoration(
                                        color: _kOnDragColor
                                            .withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(
                                                4),
                                      ),
                                      child: Text(
                                        'Keyboard auto-dismissed by onDrag',
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight:
                                                FontWeight.w600,
                                            color: _kOnDragColor),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              // Stats bar at bottom
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kPrimary.withOpacity(0.04),
                  border: Border(
                      top: BorderSide(color: Colors.grey.shade200)),
                ),
                child: Column(
                  children: [
                    _statRow('Total drags', '$_dragCount'),
                    SizedBox(height: 3),
                    _statRow(
                      'Auto-dismissals',
                      '${_events.where((e) => e.keyboardDismissed).length}',
                    ),
                    SizedBox(height: 3),
                    _statRow('Current mode', _behavior.name),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _behaviorChip(
      ScrollViewKeyboardDismissBehavior val, String label, Color color) {
    final active = _behavior == val;
    return GestureDetector(
      onTap: () => setState(() => _behavior = val),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding:
            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? color.withOpacity(0.12) : _kDisabledBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: active ? color : Colors.grey.shade300,
              width: active ? 2 : 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (active)
              Padding(
                padding: EdgeInsets.only(right: 4),
                child: Icon(Icons.check, size: 12, color: color),
              ),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight:
                        active ? FontWeight.w700 : FontWeight.w500,
                    color: active ? color : _kMuted)),
          ],
        ),
      ),
    );
  }

  Widget _statRow(String label, String value) {
    return Row(
      children: [
        Text(label,
            style: TextStyle(fontSize: 10, color: _kMuted)),
        Spacer(),
        Text(value,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: _kDarkText)),
      ],
    );
  }
}

class _ScrollEvent {
  final int id;
  final String action;
  final String behavior;
  final bool keyboardDismissed;
  final DateTime time;
  _ScrollEvent({
    required this.id,
    required this.action,
    required this.behavior,
    required this.keyboardDismissed,
    required this.time,
  });
}

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Comparison
// ═══════════════════════════════════════════════════════════
class _ComparisonTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── Side-by-side visual ─────────────────────────
        _sectionCard(
          'Side-by-Side Behaviour',
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ComparisonPanel(
                  label: 'manual',
                  desc: 'Keyboard stays open while scrolling.',
                  color: _kManualColor,
                  icon: Icons.keyboard,
                  behavior: ScrollViewKeyboardDismissBehavior.manual,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ComparisonPanel(
                  label: 'onDrag',
                  desc: 'Keyboard dismissed when dragging.',
                  color: _kOnDragColor,
                  icon: Icons.swipe_vertical,
                  behavior: ScrollViewKeyboardDismissBehavior.onDrag,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Comparison table ────────────────────────────
        _sectionCard(
          'Comparison Table',
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              _tableRow(['Aspect', 'manual', 'onDrag'],
                  isHeader: true),
              _tableRow([
                'Dismiss trigger',
                'Explicit user action',
                'Scroll drag start',
              ]),
              _tableRow([
                'UX pattern',
                'Form editing, multi-field input',
                'Search-then-scroll, list browsing',
              ]),
              _tableRow([
                'Platform feel',
                'Desktop-like (keyboard persists)',
                'Mobile-native (keyboard yields)',
              ]),
              _tableRow([
                'Default',
                'Yes (default value)',
                'Must be explicitly set',
              ]),
              _tableRow([
                'User effort',
                'Higher — must dismiss manually',
                'Lower — automatic on scroll',
              ]),
              _tableRow([
                'Risk',
                'Keyboard may obstruct content',
                'May lose keyboard unexpectedly',
              ]),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Decision tree ───────────────────────────────
        _sectionCard(
          'Which to Choose?',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _decision(
                'Does the user type THEN scroll?',
                'Use onDrag — keyboard gets out of the way automatically.',
                _kOnDragColor,
                Icons.check_circle,
              ),
              SizedBox(height: 8),
              _decision(
                'Does the user scroll BETWEEN text fields?',
                'Use manual — fields stay focused, keyboard stays open.',
                _kManualColor,
                Icons.edit_note,
              ),
              SizedBox(height: 8),
              _decision(
                'Is the scroll view the MAIN content area?',
                'Use onDrag — maximize visible content after input.',
                _kOnDragColor,
                Icons.fullscreen,
              ),
              SizedBox(height: 8),
              _decision(
                'Is the scroll view inside a small card or dialog?',
                'Use manual — avoid jarring layout shifts in small spaces.',
                _kManualColor,
                Icons.crop_square,
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Platform differences ────────────────────────
        _sectionCard(
          'Platform Notes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _platformNote('iOS',
                  'The keyboard has a built-in "Done" button. onDrag works smoothly with iOS scrolling physics.',
                  Icons.phone_iphone, Color(0xFF424242)),
              SizedBox(height: 6),
              _platformNote('Android',
                  'No native "Done" button by default. onDrag is especially useful because the back button is the usual dismiss mechanism.',
                  Icons.phone_android, Color(0xFF2E7D32)),
              SizedBox(height: 6),
              _platformNote('Web',
                  'Physical keyboards are common. manual is usually preferable since there is no virtual keyboard to dismiss.',
                  Icons.web, _kPrimary),
              SizedBox(height: 6),
              _platformNote('Desktop',
                  'Virtual keyboards are rare. The behaviour has no visible effect unless an on-screen keyboard is active.',
                  Icons.desktop_mac, Color(0xFF6A1B9A)),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Common mistakes ─────────────────────────────
        _sectionCard(
          'Common Mistakes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _mistake(
                'Using onDrag on a form with vertical field flow',
                'Every scroll between fields triggers keyboard dismiss '
                'then reopen, causing layout jank.',
              ),
              SizedBox(height: 8),
              _mistake(
                'Ignoring keyboard overlap on manual',
                'Long forms may have their lower fields hidden behind '
                'the keyboard. Use a ScrollController to scroll the '
                'focused field into view.',
              ),
              SizedBox(height: 8),
              _mistake(
                'Assuming onDrag works on web with physical keyboards',
                'There is no virtual keyboard to dismiss, so onDrag has '
                'no visible effect. Users may expect different behavior.',
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _decision(String question, String answer, Color color,
      IconData icon) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: _kDarkText)),
          SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 14, color: color),
              SizedBox(width: 6),
              Expanded(
                child: Text(answer,
                    style: TextStyle(
                        fontSize: 11,
                        color: color,
                        height: 1.3)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _platformNote(
      String platform, String note, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(platform,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: _kDarkText)),
                SizedBox(height: 2),
                Text(note,
                    style: TextStyle(
                        fontSize: 11,
                        color: _kDarkText,
                        height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mistake(String title, String desc) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFC62828).withOpacity(0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFC62828).withOpacity(0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded,
              size: 16, color: Color(0xFFC62828)),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: Color(0xFFC62828))),
                SizedBox(height: 2),
                Text(desc,
                    style: TextStyle(
                        fontSize: 11,
                        color: _kDarkText,
                        height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonPanel extends StatefulWidget {
  final String label;
  final String desc;
  final Color color;
  final IconData icon;
  final ScrollViewKeyboardDismissBehavior behavior;
  const _ComparisonPanel({
    required this.label,
    required this.desc,
    required this.color,
    required this.icon,
    required this.behavior,
  });

  @override
  State<_ComparisonPanel> createState() => _ComparisonPanelState();
}

class _ComparisonPanelState extends State<_ComparisonPanel> {
  int _scrollCount = 0;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.03),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.08),
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Row(
              children: [
                Icon(widget.icon, size: 16, color: widget.color),
                SizedBox(width: 6),
                Text(widget.label,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        color: widget.color)),
              ],
            ),
          ),
          // Description
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(widget.desc,
                style: TextStyle(
                    fontSize: 10,
                    color: _kDarkText,
                    fontStyle: FontStyle.italic)),
          ),
          // Search field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Focus(
              onFocusChange: (f) =>
                  setState(() => _focused = f),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 6),
                  prefixIcon: Icon(Icons.search, size: 14),
                ),
                style: TextStyle(fontSize: 11),
              ),
            ),
          ),
          SizedBox(height: 4),
          // Status
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(
                  _focused ? Icons.keyboard : Icons.keyboard_hide,
                  size: 12,
                  color: _focused ? widget.color : _kMuted,
                ),
                SizedBox(width: 4),
                Text(
                  'KB: ${_focused ? "open" : "closed"}',
                  style: TextStyle(
                      fontSize: 9,
                      color: _focused ? widget.color : _kMuted,
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text('Scrolls: $_scrollCount',
                    style: TextStyle(
                        fontSize: 9,
                        color: _kMuted)),
              ],
            ),
          ),
          SizedBox(height: 4),
          // Scrollable list
          Expanded(
            child: NotificationListener<ScrollStartNotification>(
              onNotification: (n) {
                if (n.dragDetails != null) {
                  setState(() => _scrollCount++);
                }
                return false;
              },
              child: ListView.builder(
                keyboardDismissBehavior: widget.behavior,
                padding: EdgeInsets.symmetric(horizontal: 6),
                itemCount: 20,
                itemBuilder: (_, i) => Container(
                  margin: EdgeInsets.only(bottom: 3),
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: _kCardBg,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: widget.color.withOpacity(0.08)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color:
                              widget.color.withOpacity(0.08),
                          borderRadius:
                              BorderRadius.circular(4),
                        ),
                        alignment: Alignment.center,
                        child: Text('${i + 1}',
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: widget.color)),
                      ),
                      SizedBox(width: 8),
                      Text('Item ${i + 1}',
                          style: TextStyle(
                              fontSize: 11,
                              color: _kDarkText)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  Shared helpers
// ═══════════════════════════════════════════════════════════

Widget _sectionCard(String title, Widget child) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: _kPrimary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: _kDarkText)),
            ),
          ],
        ),
        SizedBox(height: 12),
        child,
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
      border: Border.all(color: _kAccent.withOpacity(0.3)),
    ),
    child: Text(code,
        style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: _kDarkText,
            height: 1.5)),
  );
}

Widget _enumValue(String name, String desc, Color color, IconData icon,
    {required bool isDefault}) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.04),
      borderRadius: BorderRadius.circular(10),
      border: Border(left: BorderSide(color: color, width: 3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name,
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: color)),
                  if (isDefault) ...[
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius:
                            BorderRadius.circular(4),
                      ),
                      child: Text('DEFAULT',
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w800,
                              color: color)),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 4),
              Text(desc,
                  style: TextStyle(
                      fontSize: 12,
                      color: _kDarkText,
                      height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _widgetRow(String name, String param, bool supported) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4),
    child: Container(
      padding:
          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kPrimary.withOpacity(0.03),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(Icons.widgets,
              size: 14, color: _kPrimary),
          SizedBox(width: 8),
          Text(name,
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: _kDarkText)),
          Spacer(),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _kOnDragColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(param,
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9,
                    color: _kOnDragColor)),
          ),
        ],
      ),
    ),
  );
}

Widget _step(int num, String title, String desc, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.04),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.15)),
    ),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text('$num',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  color: color)),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: _kDarkText)),
              Text(desc,
                  style: TextStyle(
                      fontSize: 11,
                      color: _kMuted,
                      height: 1.3)),
            ],
          ),
        ),
      ],
    ),
  );
}

TableRow _tableRow(List<String> cells, {bool isHeader = false}) {
  return TableRow(
    decoration: isHeader
        ? BoxDecoration(color: _kPrimary.withOpacity(0.08))
        : null,
    children: cells.map((c) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Text(c,
            style: TextStyle(
                fontSize: 11,
                fontWeight:
                    isHeader ? FontWeight.w700 : FontWeight.w400,
                color: isHeader ? _kPrimary : _kDarkText)),
      );
    }).toList(),
  );
}

Widget _bp(bool isGood, String text) {
  final color = isGood ? Color(0xFF2E7D32) : Color(0xFFC62828);
  final icon =
      isGood ? Icons.check_circle_outline : Icons.cancel_outlined;
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  fontSize: 12, color: _kDarkText, height: 1.4)),
        ),
      ],
    ),
  );
}

// ignore_for_file: avoid_print
// D4rt deep demo: AutomaticKeepAliveClientMixin — mixin that prevents
// widget disposal when scrolled off-screen in lazy lists.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AutomaticKeepAliveClientMixin deep demo executing');
  print('=' * 60);
  print('  Mixin on State<T>');
  print('  Keeps widget state alive when scrolled off-screen');
  print('  Requires: wantKeepAlive override + super.build()');
  print('=' * 60);

  // ── colour palette ──────────────────────────────────────────
  const akPrimary = Color(0xFF1A237E);   // midnight
  const akAccent = Color(0xFF5C6BC0);    // cobalt
  const akLight = Color(0xFFE8EAF6);     // pale indigo
  const akDark = Color(0xFF0D1442);      // deep midnight
  const akSurface = Color(0xFFF5F6FF);
  const akMuted = Color(0xFF6B6F8A);

  // state-specific colours
  const akAlive = Color(0xFF2E7D32);     // green for kept alive
  const akDisposed = Color(0xFFC62828);  // red for disposed

  // ── data ────────────────────────────────────────────────────
  final List<Map<String, String>> akSteps = [
    {
      'step': '1',
      'title': 'Add the mixin',
      'code': 'class _MyState extends State<MyWidget>\n'
          '    with AutomaticKeepAliveClientMixin',
      'desc': 'Mix AutomaticKeepAliveClientMixin into your State class. '
          'This gives you the wantKeepAlive getter and hooks into the '
          'keep-alive notification system.',
    },
    {
      'step': '2',
      'title': 'Override wantKeepAlive',
      'code': '@override\nbool get wantKeepAlive => true;',
      'desc': 'Return true to keep this widget alive when it scrolls '
          'off-screen. Return false or make it dynamic to control '
          'keep-alive behaviour conditionally.',
    },
    {
      'step': '3',
      'title': 'Call super.build()',
      'code': '@override\nWidget build(BuildContext context) {\n'
          '  super.build(context); // REQUIRED!\n'
          '  return MyContent();\n}',
      'desc': 'You MUST call super.build(context) at the start of your '
          'build method. This triggers the KeepAliveNotification that '
          'tells the parent Viewport to retain this widget.',
    },
  ];

  // ── helpers ─────────────────────────────────────────────────
  Widget akSection(String title, {Widget? child, List<Widget>? children}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: akAccent.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: akPrimary.withValues(alpha: 0.07),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [akPrimary, akDark],
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child ??
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children ?? []),
          ),
        ],
      ),
    );
  }

  Widget akBody(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text,
          style: TextStyle(fontSize: 12, color: akMuted, height: 1.5)),
    );
  }

  Widget akChip(String label, {Color? bg}) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg ?? akLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: akAccent.withValues(alpha: 0.4)),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget akDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(color: akAccent.withValues(alpha: 0.2), height: 1),
    );
  }

  // Status indicator
  Widget akStatus(bool alive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: alive
            ? akAlive.withValues(alpha: 0.1)
            : akDisposed.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: alive
              ? akAlive.withValues(alpha: 0.4)
              : akDisposed.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            alive ? Icons.check_circle : Icons.cancel,
            color: alive ? akAlive : akDisposed,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(alive ? 'Kept Alive' : 'Disposed',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: alive ? akAlive : akDisposed)),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  // BUILD
  // ══════════════════════════════════════════════════════════════
  return SingleChildScrollView(
    child: Container(
      color: akSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. Title Banner ──────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 42, 24, 28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [akDark, akPrimary, akAccent],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('AutomaticKeepAlive\nClientMixin',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        height: 1.2)),
                const SizedBox(height: 8),
                Text(
                  'A mixin on State that prevents widget disposal when '
                  'scrolled off-screen in lazy lists — preserving state, '
                  'scroll position, and user input.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.87),
                      fontSize: 14,
                      height: 1.5),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    akChip('mixin', bg: Colors.white.withValues(alpha: 0.2)),
                    akChip('State<T>',
                        bg: Colors.white.withValues(alpha: 0.2)),
                    akChip('lazy lists',
                        bg: Colors.white.withValues(alpha: 0.2)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── 2. Mixin Overview ────────────────────────────────
          akSection('Mixin Overview',
            children: [
              akBody(
                'AutomaticKeepAliveClientMixin is a mixin on State<T> '
                'that integrates with AutomaticKeepAlive widgets inside '
                'lazy builders (ListView.builder, GridView.builder, etc). '
                'When wantKeepAlive returns true, the widget state '
                'persists even when scrolled out of the viewport.'),
              akBody(
                'Without this mixin, lazy list items are created on '
                'demand and disposed when they scroll off-screen. This '
                'means any local state (form input, animations, scroll '
                'positions) is lost and must be rebuilt.'),
              Wrap(
                children: [
                  akChip('wantKeepAlive'),
                  akChip('super.build()'),
                  akChip('KeepAliveNotification'),
                ],
              ),
            ],
          ),

          // ── 3. Implementation Steps ──────────────────────────
          akSection('Implementation Steps',
            children: [
              for (final s in akSteps) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: akPrimary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(s['step']!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(s['title']!,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: akLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(s['code']!,
                      style: const TextStyle(
                          fontSize: 11,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w500)),
                ),
                const SizedBox(height: 6),
                akBody(s['desc']!),
                if (s['step'] != '3') akDivider(),
              ],
            ],
          ),

          // ── 4. With vs Without Keep-Alive ────────────────────
          akSection('With vs Without Keep-Alive',
            children: [
              akBody(
                'A side-by-side comparison showing what happens '
                'when a list item scrolls off-screen:'),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: akDisposed.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: akDisposed.withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.cancel, color: akDisposed, size: 28),
                          const SizedBox(height: 6),
                          const Text('Without Mixin',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 8),
                          for (final item in [
                            'State disposed on scroll out',
                            'Rebuilt from scratch on scroll back',
                            'Form input lost',
                            'Animations restart',
                            'Network requests refired',
                            'Less memory used',
                          ])
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('• ',
                                      style: TextStyle(
                                          color: akDisposed, fontSize: 11)),
                                  Expanded(
                                    child: Text(item,
                                        style: TextStyle(
                                            fontSize: 10, color: akMuted)),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: akAlive.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: akAlive.withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.check_circle,
                              color: akAlive, size: 28),
                          const SizedBox(height: 6),
                          const Text('With Mixin',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 8),
                          for (final item in [
                            'State preserved off-screen',
                            'Instant display on scroll back',
                            'Form input retained',
                            'Animations continue',
                            'No redundant requests',
                            'More memory used',
                          ])
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('• ',
                                      style: TextStyle(
                                          color: akAlive, fontSize: 11)),
                                  Expanded(
                                    child: Text(item,
                                        style: TextStyle(
                                            fontSize: 10, color: akMuted)),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ── 5. Visual Scroll Simulation ──────────────────────
          akSection('Scroll Behaviour Simulation',
            children: [
              akBody(
                'This simulates how items in a ListView behave '
                'as the user scrolls. Green items are kept alive, '
                'red items are disposed:'),
              for (int i = 0; i < 6; i++)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: i < 2
                        ? akDisposed.withValues(alpha: 0.06)
                        : i < 4
                            ? akPrimary.withValues(alpha: 0.06)
                            : akDisposed.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: i < 2
                          ? akDisposed.withValues(alpha: 0.2)
                          : i < 4
                              ? akPrimary.withValues(alpha: 0.2)
                              : akDisposed.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: i >= 2 && i < 4
                              ? akPrimary
                              : Colors.grey.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: Text('$i',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: i >= 2 && i < 4
                                    ? Colors.white
                                    : akMuted)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          i < 2
                              ? 'Off-screen (above viewport)'
                              : i < 4
                                  ? 'Visible in viewport'
                                  : 'Off-screen (below viewport)',
                          style: TextStyle(fontSize: 11, color: akMuted),
                        ),
                      ),
                      akStatus(i < 2 ? true : i < 4 ? true : false),
                    ],
                  ),
                ),
              const SizedBox(height: 6),
              akBody(
                'Items 0-1 scrolled above but kept alive. Items 2-3 '
                'are in viewport. Items 4-5 have not been built yet.'),
            ],
          ),

          // ── 6. Notification System ───────────────────────────
          akSection('How It Works Internally',
            children: [
              akBody(
                'The mixin sends a KeepAliveNotification up the '
                'widget tree when super.build() is called:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: akLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final line in [
                      '1. super.build(context) is called',
                      '   → dispatches KeepAliveNotification',
                      '',
                      '2. AutomaticKeepAlive widget receives it',
                      '   → wrapped by SliverChildDelegate',
                      '',
                      '3. AutomaticKeepAlive tells Viewport',
                      '   → "do not dispose this child"',
                      '',
                      '4. Viewport retains the RenderObject',
                      '   → paint is skipped but state lives',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(line,
                            style: const TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w500)),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 7. Use Cases ─────────────────────────────────────
          akSection('Use Cases',
            children: [
              for (final uc in [
                {
                  'name': 'Chat Messages with Media',
                  'icon': Icons.chat_bubble_outline,
                  'detail': 'Video/audio players in a chat list should '
                      'keep playing when scrolled slightly off-screen. '
                      'Without keep-alive, media restarts.',
                },
                {
                  'name': 'Form Fields in Lists',
                  'icon': Icons.edit_outlined,
                  'detail': 'A long form built as a list of input fields. '
                      'Without keep-alive, typed text is lost when '
                      'fields scroll out of view.',
                },
                {
                  'name': 'Feed with Animations',
                  'icon': Icons.animation,
                  'detail': 'Social media cards with progress animations. '
                      'Keep-alive prevents animation restarts when '
                      'scrolling back to a previously viewed card.',
                },
                {
                  'name': 'Tab Content in PageView',
                  'icon': Icons.tab,
                  'detail': 'Pages in a PageView or TabBarView that have '
                      'expensive state (loaded data, scroll positions). '
                      'Keep-alive retains them between tab switches.',
                },
                {
                  'name': 'Interactive Widgets',
                  'icon': Icons.touch_app,
                  'detail': 'Widgets with sliders, toggles, or expansion '
                      'states in a list. Keep-alive preserves user '
                      'interaction state.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: akLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: akPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Icon(uc['icon'] as IconData,
                            color: akPrimary, size: 18),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(uc['name'] as String,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 3),
                            Text(uc['detail'] as String,
                                style: TextStyle(
                                    fontSize: 11, color: akMuted)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 8. Dynamic wantKeepAlive ─────────────────────────
          akSection('Dynamic wantKeepAlive',
            children: [
              akBody(
                'wantKeepAlive can be dynamic — changing at runtime '
                'based on conditions. Call updateKeepAlive() after '
                'changing the value:'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: akLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final line in [
                      'bool _hasUnsavedChanges = false;',
                      '',
                      '@override',
                      'bool get wantKeepAlive =>',
                      '    _hasUnsavedChanges;',
                      '',
                      'void onTextChanged(String text) {',
                      '  setState(() {',
                      '    _hasUnsavedChanges =',
                      '        text.isNotEmpty;',
                      '    updateKeepAlive();',
                      '  });',
                      '}',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(line,
                            style: const TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w500)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              akBody(
                'This pattern keeps items alive only while they have '
                'unsaved data — minimising memory usage while '
                'protecting user input.'),
            ],
          ),

          // ── 9. Memory Impact ─────────────────────────────────
          akSection('Memory Impact',
            children: [
              akBody(
                'Keep-alive items consume memory because their state, '
                'render objects, and element trees are retained:'),
              for (final mem in [
                {
                  'scenario': 'Small list (< 20 items)',
                  'impact': 'Negligible',
                  'rec': 'Safe to keep all alive',
                  'color': akAlive,
                },
                {
                  'scenario': 'Medium list (20-100)',
                  'impact': 'Moderate',
                  'rec': 'Keep alive selectively',
                  'color': akAccent,
                },
                {
                  'scenario': 'Large list (100-1000)',
                  'impact': 'Significant',
                  'rec': 'Use dynamic wantKeepAlive',
                  'color': const Color(0xFFFF8F00),
                },
                {
                  'scenario': 'Huge list (1000+)',
                  'impact': 'Dangerous',
                  'rec': 'Avoid keep-alive or limit count',
                  'color': akDisposed,
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (mem['color'] as Color).withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color:
                            (mem['color'] as Color).withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(mem['scenario'] as String,
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(mem['impact'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: mem['color'] as Color)),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(mem['rec'] as String,
                            style: TextStyle(
                                fontSize: 10, color: akMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 10. Compatible Widgets ───────────────────────────
          akSection('Compatible Widgets',
            children: [
              akBody(
                'AutomaticKeepAliveClientMixin works with any widget '
                'that uses SliverChildDelegate internally:'),
              for (final w in [
                {
                  'widget': 'ListView.builder',
                  'desc': 'Standard lazy list with keep-alive support',
                },
                {
                  'widget': 'ListView.separated',
                  'desc': 'List with separators, same keep-alive behaviour',
                },
                {
                  'widget': 'GridView.builder',
                  'desc': 'Lazy grid layout with keep-alive items',
                },
                {
                  'widget': 'PageView',
                  'desc': 'Swipeable pages — keeps offscreen pages alive',
                },
                {
                  'widget': 'TabBarView',
                  'desc': 'Tab content retention between switches',
                },
                {
                  'widget': 'CustomScrollView',
                  'desc': 'With SliverList/SliverGrid using delegates',
                },
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text(w['widget']!,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'monospace',
                                color: akDark)),
                      ),
                      Expanded(
                        child: Text(w['desc']!,
                            style: TextStyle(fontSize: 11, color: akMuted)),
                      ),
                    ],
                  ),
                ),
              akDivider(),
              akBody(
                'Does NOT work with: ListView() (non-lazy constructor), '
                'Column, SingleChildScrollView — because they build '
                'all children eagerly.'),
            ],
          ),

          // ── 11. Lifecycle Comparison ─────────────────────────
          akSection('Widget Lifecycle Comparison',
            children: [
              akBody(
                'How the widget lifecycle differs with and without '
                'the keep-alive mixin:'),
              SizedBox(
                width: double.infinity,
                child: Table(
                  border: TableBorder.all(
                      color: akAccent.withValues(alpha: 0.3), width: 1),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(1.5),
                    2: FlexColumnWidth(1.5),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: akPrimary),
                      children: [
                        for (final h in ['Event', 'Without', 'With Mixin'])
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(h,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center),
                          ),
                      ],
                    ),
                    for (final row in [
                      ['Scroll into view', 'createState', 'createState'],
                      ['First build', 'build()', 'build() + super'],
                      ['Scroll off-screen', 'dispose()', 'deactivate()'],
                      ['Scroll back', 'createState+build', 'activate+build'],
                      ['State preserved?', 'No', 'Yes'],
                      ['Memory released?', 'Yes', 'No'],
                    ])
                      TableRow(
                        decoration: BoxDecoration(
                          color: row == ['State preserved?', 'No', 'Yes'] ||
                                  row == ['Memory released?', 'Yes', 'No']
                              ? akLight
                              : Colors.white,
                        ),
                        children: [
                          for (int c = 0; c < 3; c++)
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(row[c],
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: c == 0
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: c == 0 ? akDark : akMuted),
                                  textAlign: c == 0
                                      ? TextAlign.left
                                      : TextAlign.center),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 12. Common Pitfalls ──────────────────────────────
          akSection('Common Pitfalls',
            children: [
              for (final pit in [
                {
                  'title': 'Forgetting super.build(context)',
                  'detail':
                      'This is the most common mistake. Without calling '
                      'super.build(context), the KeepAliveNotification '
                      'is never sent and the widget will be disposed '
                      'normally. The mixin has no effect.',
                },
                {
                  'title': 'Using with non-lazy constructors',
                  'detail':
                      'ListView() without .builder eagerly builds all '
                      'children. Keep-alive is meaningless because '
                      'items are never disposed. Use .builder or '
                      '.separated constructors.',
                },
                {
                  'title': 'Keeping all items alive in a huge list',
                  'detail':
                      'Every kept-alive item retains its full widget '
                      'subtree, element tree, and render objects in '
                      'memory. In very long lists this causes OOM crashes.',
                },
                {
                  'title': 'Not calling updateKeepAlive()',
                  'detail':
                      'When wantKeepAlive changes dynamically, you '
                      'must call updateKeepAlive() to send a new '
                      'notification. Without it, the old value persists.',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8EAF6),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: akPrimary.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: akDark, size: 16),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(pit['title']!,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(pit['detail']!,
                          style: TextStyle(fontSize: 11, color: akMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 13. Decision Guide ───────────────────────────────
          akSection('Decision Guide',
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: akLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final step in [
                      'Is the list lazy (.builder / .separated)?',
                      '  NO  → Mixin has no effect. Stop.',
                      '  YES → Continue...',
                      '',
                      'Does the item have important local state?',
                      '  NO  → No mixin needed',
                      '  YES → Continue...',
                      '',
                      'Is the list very long (1000+ items)?',
                      '  NO  → Safe to use mixin',
                      '  YES → Use dynamic wantKeepAlive',
                      '',
                      'Can state be restored from a model?',
                      '  YES → Prefer restoring over keep-alive',
                      '  NO  → Use the mixin',
                    ])
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(step,
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                fontWeight: FontWeight.w500)),
                      ),
                  ],
                ),
              ),
            ],
          ),

          // ── 14. Alternatives ─────────────────────────────────
          akSection('Alternatives to Keep-Alive',
            children: [
              akBody(
                'In some cases, alternatives may be more appropriate:'),
              for (final alt in [
                {
                  'name': 'State restoration',
                  'desc': 'Store state in a model and restore in '
                      'initState. Works for any list size.',
                },
                {
                  'name': 'Provider / Bloc',
                  'desc': 'Lift state out of the widget into a '
                      'state management solution. Cleanest approach.',
                },
                {
                  'name': 'addAutomaticKeepAlives: true',
                  'desc': 'SliverChildBuilderDelegate wraps each child '
                      'in AutomaticKeepAlive automatically when true.',
                },
                {
                  'name': 'cacheExtent',
                  'desc': 'Increase ScrollView.cacheExtent to keep '
                      'more off-screen items built (not disposed).',
                },
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: akLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(alt['name']!,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 3),
                      Text(alt['desc']!,
                          style: TextStyle(fontSize: 11, color: akMuted)),
                    ],
                  ),
                ),
            ],
          ),

          // ── 15. Related APIs ─────────────────────────────────
          akSection('Related APIs',
            children: [
              for (final api in [
                {
                  'name': 'AutomaticKeepAlive',
                  'rel': 'Widget that listens for KeepAliveNotification',
                },
                {
                  'name': 'KeepAliveNotification',
                  'rel': 'Notification dispatched by super.build()',
                },
                {
                  'name': 'KeepAliveHandle',
                  'rel': 'Handle used internally to track keep-alive state',
                },
                {
                  'name': 'SliverChildBuilderDelegate',
                  'rel': 'Delegate that wraps children in AutomaticKeepAlive',
                },
                {
                  'name': 'ListView.builder',
                  'rel': 'Most common lazy list that supports keep-alive',
                },
                {
                  'name': 'PageView',
                  'rel': 'Supports keep-alive for page content',
                },
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 220,
                        child: Text(api['name']!,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: akDark)),
                      ),
                      Expanded(
                        child: Text(api['rel']!,
                            style: TextStyle(fontSize: 12, color: akMuted)),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // ── 16. Summary Dashboard ────────────────────────────
          akSection('Summary Dashboard',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: akPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('3',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: akDark)),
                            const Text('Setup Steps',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: akAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('6',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: akDark)),
                            const Text('Compatible Widgets',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: akLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text('16',
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: akDark)),
                            const Text('Sections',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: akLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'AutomaticKeepAliveClientMixin preserves widget '
                    'state in lazy lists, preventing disposal on '
                    'scroll — essential for forms, media players, and '
                    'any list item with important local state.',
                    style: TextStyle(
                        fontSize: 12, color: akMuted, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // ── Footer ───────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: akDark,
            child: Column(
              children: [
                const Text('AutomaticKeepAliveClientMixin Deep Demo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(
                  'Midnight/Cobalt theme  •  Batch 62  •  '
                  'mixin on State  •  16 sections',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

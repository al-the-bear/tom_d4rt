// ignore_for_file: avoid_print
// D4rt deep demo: NotifiableElementMixin — mixin enabling elements to receive notifications
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Claret / Bordeaux ─────────────────────────────────────
  const deepClaret = Color(0xFF4A148C);
  const claret = Color(0xFF6A1B9A);
  const bordeaux = Color(0xFF7B1FA2);
  const softClaret = Color(0xFF9C27B0);
  const lightBordeaux = Color(0xFFCE93D8);
  const paleClaret = Color(0xFFF3E5F5);
  const whiteClaret = Color(0xFFFCF5FF);
  const darkInk = Color(0xFF1A0030);
  const accentRose = Color(0xFFC62828);
  const accentTeal = Color(0xFF00695C);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.78)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(subtitle,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 13, color: darkInk)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: darkInk)),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // ── Print diagnostics ──────────────────────────────────────────────
  print('NotifiableElementMixin deep demo executing');
  print('=' * 60);

  print('\n--- What is NotifiableElementMixin ---');
  print('A mixin on Element that can receive Notifications');
  print('Abstract method: onNotification(Notification)');
  print('Returns bool: true = handled, false = bubble up');
  print('Used by NotificationListener\'s element');

  print('\n--- Notification bubble mechanism ---');
  print('1. Widget dispatches Notification');
  print('2. Notification walks up the Element tree');
  print('3. Each NotifiableElementMixin.onNotification() is called');
  print('4. Return true stops bubble, false continues');

  print('\n--- Key relationships ---');
  print('NotificationListener creates _NotificationElement');
  print('_NotificationElement uses NotifiableElementMixin');
  print('Notification.dispatch(context) starts the bubble');

  print('\n${'=' * 60}');
  print('NotifiableElementMixin deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepClaret, claret, bordeaux],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.notifications_active, size: 28,
                      color: lightBordeaux),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('NotifiableElementMixin',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Mixin on Element — enables element tree nodes to '
                  'intercept and handle Notification objects as they bubble up',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('mixin', bordeaux, Colors.white),
                tag('on Element', softClaret, Colors.white),
                tag('Notification', lightBordeaux, darkInk),
                tag('bubble up', paleClaret, darkInk),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is NotifiableElementMixin',
            'A mixin that gives Elements the ability to intercept notifications',
            deepClaret, Colors.white),
        noteBox(
          'NotifiableElementMixin is a mixin declared as "mixin on Element" '
          'in notification_listener.dart. It defines a single abstract method '
          'onNotification(Notification) that returns bool. When a Notification '
          'object bubbles up the element tree (via dispatch()), every element '
          'with this mixin gets a chance to handle it. Returning true stops '
          'the bubble; returning false lets it continue upward.',
          claret,
          whiteClaret,
        ),
        dataRow('Declaration', 'mixin NotifiableElementMixin on Element', claret),
        dataRow('Abstract method', 'bool onNotification(Notification)', deepClaret),
        dataRow('Return true', 'Notification handled, stop bubbling', accentTeal),
        dataRow('Return false', 'Not handled, continue bubbling up', accentRose),
        dataRow('Defined in', 'widgets/notification_listener.dart', darkInk),
        dataRow('Primary user', '_NotificationElement (from NotificationListener)',
            bordeaux),
        const SizedBox(height: 14),

        // ── 3. Notification bubble mechanism ─────────────────────────
        sectionBanner('2 \u00b7 How Notifications Bubble Up',
            'The lifecycle of a Notification from dispatch to handling',
            claret, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteClaret,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightBordeaux),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 5; i++)
                ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: [
                        softClaret,
                        bordeaux,
                        claret,
                        deepClaret,
                        accentTeal,
                      ][i]
                          .withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: [
                        softClaret,
                        bordeaux,
                        claret,
                        deepClaret,
                        accentTeal,
                      ][i]),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: [
                              softClaret,
                              bordeaux,
                              claret,
                              deepClaret,
                              accentTeal,
                            ][i],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text([
                            'Child widget calls MyNotification().dispatch(context)',
                            'Framework walks up element tree from child',
                            'At each element with NotifiableElementMixin...',
                            'Calls onNotification(notification)',
                            'If true: stop. If false: keep walking up',
                          ][i],
                              style: TextStyle(
                                  fontSize: 11, color: darkInk)),
                        ),
                      ],
                    ),
                  ),
                  if (i < 4)
                    Center(
                      child: Icon(Icons.arrow_upward,
                          size: 14, color: lightBordeaux),
                    ),
                ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Mixin definition ──────────────────────────────────────
        sectionBanner('3 \u00b7 Mixin Definition',
            'The actual SDK source code', bordeaux, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteClaret,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepClaret.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepClaret.withValues(alpha: 0.3)),
            ),
            child: Text(
                'mixin NotifiableElementMixin on Element {\n'
                '  bool onNotification(\n'
                '      Notification notification);\n'
                '\n'
                '  @override\n'
                '  void attachNotificationTree() {\n'
                '    _notificationTree =\n'
                '        _NotificationNode(\n'
                '            _parent?._notificationTree,\n'
                '            this);\n'
                '  }\n'
                '}',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: deepClaret)),
          ),
        ),
        noteBox(
          'The mixin provides onNotification() as the abstract hook and '
          'overrides attachNotificationTree() to register itself as a '
          'notification handler node. The _NotificationNode linked list '
          'allows efficient walking without visiting every element — only '
          'those with the mixin.',
          bordeaux,
          paleClaret,
        ),
        const SizedBox(height: 14),

        // ── 5. NotificationListener connection ───────────────────────
        sectionBanner('4 \u00b7 Connection to NotificationListener',
            'How this mixin powers the public API',
            deepClaret, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: whiteClaret,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightBordeaux),
          ),
          child: Column(
            children: [
              // NotificationListener
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: claret.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: claret, width: 2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.hearing, size: 20, color: claret),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('NotificationListener<T>',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                  color: claret)),
                          Text('Widget — the public API for listening',
                              style: TextStyle(
                                  fontSize: 10, color: darkInk)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    Icon(Icons.arrow_downward, size: 16,
                        color: lightBordeaux),
                    Text('creates',
                        style: TextStyle(
                            fontSize: 8, color: lightBordeaux)),
                  ],
                ),
              ),
              // _NotificationElement
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bordeaux.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: bordeaux),
                ),
                child: Row(
                  children: [
                    Icon(Icons.account_tree, size: 20,
                        color: bordeaux),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('_NotificationElement',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                  color: bordeaux)),
                          Text('Element — uses NotifiableElementMixin',
                              style: TextStyle(
                                  fontSize: 10, color: darkInk)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    Icon(Icons.arrow_downward, size: 16,
                        color: lightBordeaux),
                    Text('implements',
                        style: TextStyle(
                            fontSize: 8, color: lightBordeaux)),
                  ],
                ),
              ),
              // Mixin
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepClaret.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: deepClaret, width: 2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.notifications, size: 20,
                        color: deepClaret),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('NotifiableElementMixin',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                  color: deepClaret)),
                          Text('Mixin — onNotification() handler',
                              style: TextStyle(
                                  fontSize: 10, color: darkInk)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Return value semantics ────────────────────────────────
        sectionBanner('5 \u00b7 Return Value Semantics',
            'What true and false mean in onNotification()',
            claret, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteClaret,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentTeal.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentTeal, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.stop_circle, size: 28,
                          color: accentTeal),
                      const SizedBox(height: 4),
                      Text('return true',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: accentTeal)),
                      const SizedBox(height: 4),
                      Text('Handled.\nStop bubbling.\nNo ancestor sees it.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkInk)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentRose.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentRose, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.arrow_upward, size: 28,
                          color: accentRose),
                      const SizedBox(height: 4),
                      Text('return false',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: accentRose)),
                      const SizedBox(height: 4),
                      Text('Not handled.\nKeep bubbling.\nAncestors can catch.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkInk)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Notification types ────────────────────────────────────
        sectionBanner('6 \u00b7 Built-in Notification Types',
            'Common notifications that flow through the mixin',
            bordeaux, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteClaret,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final notif in [
                ('ScrollNotification', 'Scroll position changes — start, '
                    'update, end, overscroll.', Icons.swap_vert, claret),
                ('LayoutChangedNotification', 'Layout geometry has changed. '
                    'SizeChangedLayoutNotifier dispatches these.',
                    Icons.crop_square, bordeaux),
                ('OverscrollIndicatorNotification', 'Glow effect about to '
                    'be shown. Can be canceled by returning true.',
                    Icons.blur_on, softClaret),
                ('KeepAliveNotification', 'Child wants parent to keep it '
                    'alive in a lazy list (wantKeepAlive).',
                    Icons.favorite, accentRose),
                ('Custom notifications', 'Any class extending Notification '
                    'can be dispatched and caught.',
                    Icons.build, accentTeal),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: notif.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: notif.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(notif.$3, size: 20, color: notif.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notif.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                    color: notif.$4)),
                            Text(notif.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkInk)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Live demo: NotificationListener ───────────────────────
        sectionBanner('7 \u00b7 Live Demo: NotificationListener',
            'Catching ScrollNotification via the mixin under the hood',
            deepClaret, Colors.white),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: whiteClaret,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightBordeaux),
          ),
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              print('Scroll: ${notification.runtimeType}');
              return false;
            },
            child: ListView.builder(
              itemCount: 30,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? claret.withValues(alpha: 0.06)
                        : bordeaux.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(
                            color: index.isEven ? claret : bordeaux,
                            width: 2)),
                  ),
                  child: Text('Item $index',
                      style: TextStyle(fontSize: 12, color: darkInk)),
                );
              },
            ),
          ),
        ),
        noteBox(
          'This ListView dispatches ScrollNotification as you scroll. '
          'NotificationListener catches them via _NotificationElement '
          'which uses NotifiableElementMixin.onNotification(). The handler '
          'returns false to let notifications continue bubbling.',
          claret,
          paleClaret,
        ),
        const SizedBox(height: 14),

        // ── 9. Custom notification ───────────────────────────────────
        sectionBanner('8 \u00b7 Custom Notification Pattern',
            'Creating and dispatching your own notifications',
            claret, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteClaret,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepClaret.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepClaret.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// Define\n'
                    'class MyNotification extends Notification {\n'
                    '  final String message;\n'
                    '  MyNotification(this.message);\n'
                    '}\n'
                    '\n'
                    '// Dispatch\n'
                    'MyNotification("hello").dispatch(context);\n'
                    '\n'
                    '// Listen\n'
                    'NotificationListener<MyNotification>(\n'
                    '  onNotification: (n) {\n'
                    '    print(n.message); // "hello"\n'
                    '    return true; // handled\n'
                    '  },\n'
                    '  child: myChild,\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepClaret)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'Custom notifications follow the same path. dispatch() walks '
                'up the element tree. Each _NotificationElement with '
                'NotifiableElementMixin checks if the notification matches its '
                'generic type parameter, then calls the onNotification callback.',
                claret,
                paleClaret,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. _NotificationNode tree ───────────────────────────────
        sectionBanner('9 \u00b7 The _NotificationNode Optimization',
            'How Flutter avoids visiting every element',
            bordeaux, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteClaret,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bordeaux.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: bordeaux.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    for (final line in [
                      'Element tree:  A \u2192 B \u2192 C(NL) \u2192 D \u2192 E(NL) \u2192 F',
                      '_NotificationNode chain:  C \u2192 E',
                      '',
                      'NL = has NotifiableElementMixin',
                      'dispatch() jumps C \u2192 E, skipping D',
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(line,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  color: darkInk)),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              noteBox(
                'Instead of walking every element in the tree, '
                'attachNotificationTree() builds a sparse linked list of only '
                'the elements that have NotifiableElementMixin. This means '
                'notification dispatch skips elements that cannot handle '
                'notifications, which is critical for deep widget trees with '
                'thousands of elements.',
                bordeaux,
                paleClaret,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Comparison: Notifications vs others ──────────────────
        sectionBanner('10 \u00b7 Notifications vs Other Patterns',
            'When to use notifications instead of alternatives',
            deepClaret, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteClaret,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepClaret),
                children: [
                  for (final h in ['Pattern', 'Direction', 'Use Case'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                ],
              ),
              for (final row in [
                ('Notification', 'Child \u2192 Parent',
                    'Scroll events, layout changes'),
                ('InheritedWidget', 'Parent \u2192 Child',
                    'Theme, Locale, MediaQuery'),
                ('Callback', 'Child \u2192 Parent',
                    'onTap, onChanged'),
                ('Stream / ChangeNotifier', 'Any \u2192 Any',
                    'State management'),
                ('GlobalKey', 'Any \u2192 Specific',
                    'Cross-tree communication'),
              ])
                TableRow(
                  decoration: row.$1 == 'Notification'
                      ? BoxDecoration(
                          color: claret.withValues(alpha: 0.06))
                      : null,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: row.$1 == 'Notification'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: row.$1 == 'Notification'
                                  ? claret
                                  : darkInk)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: darkInk)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: darkInk)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Mixin constraint ─────────────────────────────────────
        sectionBanner('11 \u00b7 Mixin Constraint: "on Element"',
            'Why NotifiableElementMixin requires Element',
            claret, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteClaret,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final reason in [
                ('Element tree access', 'The mixin must participate in the '
                    'element tree to intercept bubbling notifications. Only '
                    'Element subclasses exist in the tree.',
                    Icons.account_tree, claret),
                ('attachNotificationTree()', 'The mixin overrides this Element '
                    'method to register itself in the _NotificationNode chain. '
                    'This method only exists on Element.',
                    Icons.link, bordeaux),
                ('Parent reference', 'The mixin accesses _parent to find the '
                    'parent _NotificationNode. Only Element has the parent '
                    'chain linking the tree.',
                    Icons.family_restroom, deepClaret),
                ('Not for widgets', 'You cannot apply this mixin to a Widget '
                    'subclass. Widgets create Elements; the mixin goes on the '
                    'Element, not the Widget.',
                    Icons.block, accentRose),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: reason.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: reason.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(reason.$3, size: 20, color: reason.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(reason.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: darkInk)),
                            Text(reason.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkInk)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Live demo: nested listeners ──────────────────────────
        sectionBanner('12 \u00b7 Live Demo: Nested Listeners',
            'Multiple notification listeners at different tree levels',
            bordeaux, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteClaret,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightBordeaux),
          ),
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              return false; // outer: keep bubbling
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: softClaret.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: softClaret),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.hearing, size: 16, color: softClaret),
                      const SizedBox(width: 6),
                      Text('Outer listener (returns false)',
                          style: TextStyle(
                              fontSize: 11, color: darkInk)),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 120,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      return false; // inner: keep bubbling
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: claret),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: claret.withValues(alpha: 0.08),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.hearing, size: 14,
                                    color: claret),
                                const SizedBox(width: 6),
                                Text('Inner listener (returns false)',
                                    style: TextStyle(
                                        fontSize: 10, color: darkInk)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 15,
                              padding: const EdgeInsets.all(4),
                              itemBuilder: (context, i) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 1),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: bordeaux
                                        .withValues(alpha: 0.06),
                                    borderRadius:
                                        BorderRadius.circular(4),
                                  ),
                                  child: Text('Nested item $i',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: darkInk)),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                noteBox(
                  'Both listeners return false, so scroll notifications bubble '
                  'through both. If the inner listener returned true, the outer '
                  'would never see the notification. This is the mixin at work '
                  '— each _NotificationElement checks via onNotification().',
                  bordeaux,
                  paleClaret,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Performance ──────────────────────────────────────────
        sectionBanner('13 \u00b7 Performance Characteristics',
            'Why the notification system is efficient',
            deepClaret, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteClaret,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final perf in [
                ('Sparse traversal', 'Only visits elements with the mixin. '
                    'In a tree of 10,000 elements with 5 listeners, only 5 '
                    'onNotification() calls happen.',
                    Icons.speed, accentTeal),
                ('No allocation', 'The _NotificationNode list is maintained '
                    'incrementally during tree mutations. No per-dispatch '
                    'allocation needed.',
                    Icons.memory, claret),
                ('Type checking', 'Generic type parameter on '
                    'NotificationListener means the callback only fires for '
                    'matching notification types.',
                    Icons.filter_alt, bordeaux),
                ('Early stop', 'Returning true halts traversal immediately. '
                    'No wasted work visiting remaining ancestors.',
                    Icons.stop, accentRose),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: perf.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: perf.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(perf.$3, size: 20, color: perf.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(perf.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: darkInk)),
                            Text(perf.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkInk)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Hierarchy ────────────────────────────────────────────
        sectionBanner('14 \u00b7 Mixin Application Hierarchy',
            'Where the mixin sits in the type system',
            claret, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteClaret,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Element', Colors.grey),
                ('\u2514\u2500 + NotifiableElementMixin', bordeaux),
                ('    \u2514\u2500 _NotificationElement', claret),
                ('        (from NotificationListener)', softClaret),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight:
                              level.$1.contains('NotifiableElementMixin')
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                          color: level.$2)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepClaret, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepClaret, claret],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'mixin NotifiableElementMixin on Element — must be applied to Element subclasses',
                'Abstract method: bool onNotification(Notification)',
                'Return true to stop bubble, false to continue',
                'Used internally by NotificationListener via _NotificationElement',
                'Builds a sparse _NotificationNode linked list for efficient traversal',
                'Only elements with this mixin are visited during dispatch',
                'Handles all Notification subtypes: scroll, layout, custom',
                'Notification.dispatch(context) starts the upward bubble',
                'Essential performance optimization for deep widget trees',
                'Part of Flutter\u0027s child-to-parent communication pattern',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightBordeaux,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}

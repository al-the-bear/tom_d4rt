// ignore_for_file: avoid_print
// D4rt deep demo: Notification — abstract class for child-to-parent communication via bubbling
import 'package:flutter/material.dart';

// ── Custom notification subclasses for demos ─────────────────────────
class CounterNotification extends Notification {
  final int count;
  const CounterNotification(this.count);
}

class StatusNotification extends Notification {
  final String status;
  final Color color;
  const StatusNotification(this.status, this.color);
}

class PriorityNotification extends Notification {
  final String message;
  final int priority;
  const PriorityNotification(this.message, this.priority);
}

dynamic build(BuildContext context) {
  // ── Palette: Sangria / Merlot ──────────────────────────────────────
  const deepSangria = Color(0xFF880E4F);
  const sangria = Color(0xFFC2185B);
  const merlot = Color(0xFFD81B60);
  const softSangria = Color(0xFFEC407A);
  const lightMerlot = Color(0xFFF48FB1);
  const paleSangria = Color(0xFFFCE4EC);
  const whiteSangria = Color(0xFFFFF5F7);
  const darkWine = Color(0xFF311B1B);
  const accentTeal = Color(0xFF00695C);
  const accentIndigo = Color(0xFF283593);

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
          style: TextStyle(fontSize: 13, color: darkWine)),
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
                style: TextStyle(fontSize: 13, color: darkWine)),
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
  print('Notification deep demo executing');
  print('=' * 60);

  print('\n--- What is Notification ---');
  print('Abstract class for child-to-parent communication');
  print('Constructor: const Notification()');
  print('Key method: dispatch(BuildContext? target)');
  print('Bubbles UP the element tree from child to ancestor');
  print('NotificationListener catches bubbled notifications');

  print('\n--- dispatch() mechanism ---');
  print('1. Child calls MyNotification().dispatch(context)');
  print('2. Context delegates to _NotificationNode');
  print('3. _NotificationNode walks up the tree');
  print('4. At each NotifiableElementMixin: onNotification() called');
  print('5. Return true = stop, false = continue bubbling');

  print('\n--- Built-in subclasses ---');
  print('ScrollNotification (scroll events)');
  print('LayoutChangedNotification (layout changes)');
  print('SizeChangedLayoutNotification');
  print('KeepAliveNotification');
  print('OverscrollIndicatorNotification');
  print('DraggableScrollableNotification');
  print('NavigationNotification');

  print('\n${'=' * 60}');
  print('Notification deep demo completed');

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
              colors: [deepSangria, sangria, merlot],
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
                  Icon(Icons.campaign, size: 28, color: lightMerlot),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('Notification',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Abstract base class for child-to-parent event '
                  'communication — notifications bubble up the element tree '
                  'until caught by a NotificationListener',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('abstract class', merlot, Colors.white),
                tag('dispatch()', softSangria, darkWine),
                tag('bubble up', lightMerlot, darkWine),
                tag('NotificationListener', paleSangria, darkWine),
              ]),
            ],
          ),
        ),

        // ── 2. What is Notification ──────────────────────────────────
        sectionBanner('1 \u00b7 What Is Notification',
            'The base class for Flutter\u0027s bubbling event pattern',
            deepSangria, Colors.white),
        noteBox(
          'Notification is an abstract class with a const constructor. '
          'It provides a single key method: dispatch(BuildContext?). When '
          'called, the notification walks up the element tree from the '
          'given context, visiting each element that has '
          'NotifiableElementMixin (which is how NotificationListener works). '
          'At each stop, onNotification() is called. Returning true stops '
          'the bubble; returning false lets it continue to ancestors.',
          sangria,
          whiteSangria,
        ),
        dataRow('Type', 'abstract class Notification', sangria),
        dataRow('Constructor', 'const Notification()', deepSangria),
        dataRow('Key method', 'void dispatch(BuildContext? target)', merlot),
        dataRow('Direction', 'Child \u2192 Parent (bottom-up)', accentTeal),
        dataRow('Defined in', 'widgets/notification_listener.dart', darkWine),
        dataRow('Caught by', 'NotificationListener<T>', accentIndigo),
        const SizedBox(height: 14),

        // ── 3. dispatch() mechanism ──────────────────────────────────
        sectionBanner('2 \u00b7 The dispatch() Mechanism',
            'How a notification travels up the tree',
            sangria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSangria,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightMerlot),
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
                        merlot,
                        sangria,
                        deepSangria,
                        accentTeal,
                        accentIndigo,
                      ][i]
                          .withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: [
                        merlot,
                        sangria,
                        deepSangria,
                        accentTeal,
                        accentIndigo,
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
                              merlot,
                              sangria,
                              deepSangria,
                              accentTeal,
                              accentIndigo,
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
                            'MyNotification().dispatch(context)',
                            'context.dispatchNotification(this)',
                            '_NotificationNode walks up sparse chain',
                            'Each NotifiableElementMixin: onNotification()',
                            'Return true = stop, false = keep bubbling',
                          ][i],
                              style: TextStyle(
                                  fontSize: 11, color: darkWine)),
                        ),
                      ],
                    ),
                  ),
                  if (i < 4)
                    Center(
                      child: Icon(Icons.arrow_upward,
                          size: 14, color: lightMerlot),
                    ),
                ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Class definition ──────────────────────────────────────
        sectionBanner('3 \u00b7 Class Definition',
            'The SDK source code', merlot, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSangria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepSangria.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepSangria.withValues(alpha: 0.3)),
            ),
            child: Text(
                'abstract class Notification {\n'
                '  const Notification();\n'
                '\n'
                '  void dispatch(BuildContext? target) {\n'
                '    target?.dispatchNotification(this);\n'
                '  }\n'
                '\n'
                '  @protected @mustCallSuper\n'
                '  void debugFillDescription(\n'
                '      List<String> description) {}\n'
                '}',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: deepSangria)),
          ),
        ),
        noteBox(
          'Just two methods: dispatch() which triggers the bubble, and '
          'debugFillDescription() for debugging output. The entire mechanism '
          'depends on the element tree — dispatch walks the _NotificationNode '
          'sparse chain built by NotifiableElementMixin.',
          sangria,
          paleSangria,
        ),
        const SizedBox(height: 14),

        // ── 5. Live demo: custom notification ────────────────────────
        sectionBanner('4 \u00b7 Live Demo: Custom Notification',
            'Creating and dispatching a custom notification',
            deepSangria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSangria,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightMerlot),
          ),
          child: NotificationListener<CounterNotification>(
            onNotification: (notification) {
              print('CounterNotification received: ${notification.count}');
              return true;
            },
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentTeal.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: accentTeal),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.hearing, size: 16, color: accentTeal),
                      const SizedBox(width: 6),
                      Text('NotificationListener<CounterNotification>',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: accentTeal)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Builder(builder: (innerContext) {
                  return Row(
                    children: [
                      for (var i = 1; i <= 3; i++)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3),
                            child: ElevatedButton(
                              onPressed: () {
                                CounterNotification(i)
                                    .dispatch(innerContext);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: sangria,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6),
                              ),
                              child: Text('Send $i',
                                  style:
                                      const TextStyle(fontSize: 11)),
                            ),
                          ),
                        ),
                    ],
                  );
                }),
                const SizedBox(height: 8),
                noteBox(
                  'Each button dispatches a CounterNotification with a '
                  'different count. The listener above catches it and '
                  'prints the value. The notification bubbles from the '
                  'button context up to the listener.',
                  sangria,
                  paleSangria,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Built-in notification subclasses ──────────────────────
        sectionBanner('5 \u00b7 Built-in Notification Subclasses',
            'The notification types Flutter provides out of the box',
            sangria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSangria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final notif in [
                ('ScrollNotification', 'Abstract base for all scroll '
                    'events. Subtypes: ScrollStart, ScrollUpdate, '
                    'ScrollEnd, OverscrollNotification.',
                    Icons.swap_vert, sangria),
                ('LayoutChangedNotification', 'Dispatched when layout '
                    'geometry changes. Base for SizeChangedLayout '
                    'notification.',
                    Icons.crop_square, merlot),
                ('KeepAliveNotification', 'Dispatched by '
                    'AutomaticKeepAliveClientMixin to tell lazy lists '
                    'to keep a child alive when scrolled off-screen.',
                    Icons.favorite, deepSangria),
                ('OverscrollIndicatorNotification', 'Dispatched before '
                    'the glow overscroll indicator is shown. Can be '
                    'canceled by returning true.',
                    Icons.blur_on, softSangria),
                ('NavigationNotification', 'Dispatched by Navigator '
                    'when navigation state changes. Can be used for '
                    'analytics or breadcrumbs.',
                    Icons.navigation, accentIndigo),
                ('DraggableScrollableNotification', 'Dispatched by '
                    'DraggableScrollableSheet when its extent changes.',
                    Icons.drag_handle, accentTeal),
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
                                    fontSize: 11, color: darkWine)),
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

        // ── 7. Live demo: ScrollNotification ─────────────────────────
        sectionBanner('6 \u00b7 Live Demo: ScrollNotification',
            'Catching scroll events as they bubble up',
            merlot, Colors.white),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: whiteSangria,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightMerlot),
          ),
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) {
                print('Scroll started');
              } else if (notification is ScrollEndNotification) {
                print('Scroll ended');
              }
              return false;
            },
            child: ListView.builder(
              itemCount: 40,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? sangria.withValues(alpha: 0.06)
                        : merlot.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(
                            color: index.isEven ? sangria : merlot,
                            width: 2)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.circle, size: 8,
                          color: index.isEven ? sangria : merlot),
                      const SizedBox(width: 8),
                      Text('Scrollable item $index',
                          style: TextStyle(
                              fontSize: 12, color: darkWine)),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        noteBox(
          'Scrolling this list dispatches ScrollStartNotification, '
          'ScrollUpdateNotification, and ScrollEndNotification. The '
          'listener catches them and prints start/end. Returns false '
          'to let them keep bubbling to any parent listeners.',
          merlot,
          paleSangria,
        ),
        const SizedBox(height: 14),

        // ── 8. Return value semantics ────────────────────────────────
        sectionBanner('7 \u00b7 Return Value Semantics',
            'How true/false control the bubble',
            deepSangria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSangria,
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
                      Text('Consumed.\nStop bubbling.\nAncestors\ndon\u0027t see it.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkWine)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: sangria.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: sangria, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.arrow_upward, size: 28,
                          color: sangria),
                      const SizedBox(height: 4),
                      Text('return false',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: sangria)),
                      const SizedBox(height: 4),
                      Text('Not consumed.\nKeep bubbling.\nAncestors can\ncatch it.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkWine)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Custom notification pattern ───────────────────────────
        sectionBanner('8 \u00b7 Creating Custom Notifications',
            'The three-step pattern for your own notifications',
            sangria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSangria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                ('1. Define', 'class MyNotification extends Notification {\n'
                    '  final String data;\n'
                    '  const MyNotification(this.data);\n'
                    '}', sangria),
                ('2. Dispatch', 'MyNotification("hello")\n'
                    '    .dispatch(context);', merlot),
                ('3. Listen', 'NotificationListener<MyNotification>(\n'
                    '  onNotification: (n) {\n'
                    '    print(n.data);\n'
                    '    return true;\n'
                    '  },\n'
                    '  child: myChild,\n'
                    ')', deepSangria),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: step.$3.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: step.$3, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(step.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: step.$3)),
                      const SizedBox(height: 4),
                      Text(step.$2,
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: darkWine)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Live demo: status notifications ──────────────────────
        sectionBanner('9 \u00b7 Live Demo: Status Notifications',
            'Rich notification with data payload',
            merlot, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSangria,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightMerlot),
          ),
          child: NotificationListener<StatusNotification>(
            onNotification: (notification) {
              print('Status: ${notification.status}');
              return true;
            },
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: merlot.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: merlot),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.hearing, size: 16, color: merlot),
                      const SizedBox(width: 6),
                      Text('Listener: StatusNotification',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: merlot)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Builder(builder: (innerCtx) {
                  return Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final status in [
                        ('Success', const Color(0xFF2E7D32)),
                        ('Warning', const Color(0xFFF57F17)),
                        ('Error', const Color(0xFFC62828)),
                        ('Info', accentIndigo),
                      ])
                        ElevatedButton.icon(
                          onPressed: () {
                            StatusNotification(
                                    status.$1, status.$2)
                                .dispatch(innerCtx);
                          },
                          icon: Icon(
                              status.$1 == 'Success'
                                  ? Icons.check_circle
                                  : status.$1 == 'Warning'
                                      ? Icons.warning
                                      : status.$1 == 'Error'
                                          ? Icons.error
                                          : Icons.info,
                              size: 14),
                          label: Text(status.$1,
                              style:
                                  const TextStyle(fontSize: 11)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: status.$2,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                          ),
                        ),
                    ],
                  );
                }),
                const SizedBox(height: 8),
                noteBox(
                  'StatusNotification carries both a message and a color. '
                  'Each button dispatches a different status. The listener '
                  'catches all of them since they all extend '
                  'StatusNotification.',
                  merlot,
                  paleSangria,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Notification vs other patterns ───────────────────────
        sectionBanner('10 \u00b7 Notification vs Other Patterns',
            'When to use notifications instead of alternatives',
            deepSangria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSangria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepSangria),
                children: [
                  for (final h in ['Pattern', 'Direction', 'Best For'])
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
                    'Scroll events, layout changes, unnamed child signals'),
                ('Callback', 'Child \u2192 Parent',
                    'Direct 1:1 communication (onTap, onChanged)'),
                ('InheritedWidget', 'Parent \u2192 Child',
                    'Theme, Locale, MediaQuery — many descendants read'),
                ('Stream', 'Any \u2192 Any',
                    'Async events, state management across tree'),
                ('ValueNotifier', 'Any \u2192 Any',
                    'Simple observable value with listeners'),
              ])
                TableRow(
                  decoration: row.$1 == 'Notification'
                      ? BoxDecoration(
                          color: sangria.withValues(alpha: 0.06))
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
                                  ? sangria
                                  : darkWine)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: darkWine)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: darkWine)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Nested listeners ─────────────────────────────────────
        sectionBanner('11 \u00b7 Live Demo: Nested Listeners',
            'How multiple listeners interact with the same notification',
            sangria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSangria,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightMerlot),
          ),
          child: NotificationListener<PriorityNotification>(
            onNotification: (n) {
              print('Outer listener got priority ${n.priority}: ${n.message}');
              return true;
            },
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: sangria.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: sangria),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.hearing, size: 14, color: sangria),
                      const SizedBox(width: 6),
                      Text('Outer listener (returns true \u2192 stops)',
                          style: TextStyle(
                              fontSize: 10, color: darkWine)),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                NotificationListener<PriorityNotification>(
                  onNotification: (n) {
                    print('Inner listener got: ${n.message}');
                    return n.priority >= 5;
                  },
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: merlot.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: merlot),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.hearing, size: 14,
                                color: merlot),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                  'Inner listener (returns true if priority >= 5)',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: darkWine)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Builder(builder: (innerCtx) {
                        return Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  PriorityNotification('Low', 2)
                                      .dispatch(innerCtx);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accentTeal,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6),
                                ),
                                child: Text('Priority 2\n(bubbles)',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 10)),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  PriorityNotification('High', 8)
                                      .dispatch(innerCtx);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: deepSangria,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6),
                                ),
                                child: Text('Priority 8\n(consumed)',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 10)),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                noteBox(
                  'Priority 2: Inner returns false \u2192 bubbles to outer. '
                  'Priority 8: Inner returns true \u2192 outer never sees it. '
                  'This demonstrates conditional consumption.',
                  sangria,
                  paleSangria,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Notification hierarchy ───────────────────────────────
        sectionBanner('12 \u00b7 Notification Hierarchy',
            'Built-in notification class tree',
            merlot, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSangria,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Notification (abstract)', deepSangria),
                ('\u2514\u2500 LayoutChangedNotification', sangria),
                ('    \u2514\u2500 SizeChangedLayoutNotification', merlot),
                ('\u2514\u2500 ScrollNotification (abstract)', sangria),
                ('    \u2514\u2500 ScrollStartNotification', softSangria),
                ('    \u2514\u2500 ScrollUpdateNotification', softSangria),
                ('    \u2514\u2500 ScrollEndNotification', softSangria),
                ('    \u2514\u2500 OverscrollNotification', softSangria),
                ('    \u2514\u2500 UserScrollNotification', softSangria),
                ('\u2514\u2500 KeepAliveNotification', accentTeal),
                ('\u2514\u2500 OverscrollIndicatorNotification', accentIndigo),
                ('\u2514\u2500 NavigationNotification', Colors.grey),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'monospace',
                          fontWeight:
                              level.$1.startsWith('Notification')
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                          color: level.$2)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. debugFillDescription ─────────────────────────────────
        sectionBanner('13 \u00b7 debugFillDescription()',
            'Adding debug output to custom notifications',
            deepSangria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSangria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepSangria.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepSangria.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'class CounterNotification\n'
                    '    extends Notification {\n'
                    '  final int count;\n'
                    '  const CounterNotification(this.count);\n'
                    '\n'
                    '  @override\n'
                    '  void debugFillDescription(\n'
                    '      List<String> description) {\n'
                    '    super.debugFillDescription(description);\n'
                    '    description.add("count: \$count");\n'
                    '  }\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepSangria)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'Override debugFillDescription to add diagnostic info. '
                'Flutter\u0027s devtools and error messages use this to display '
                'meaningful information about notification objects during '
                'debugging.',
                deepSangria,
                paleSangria,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Type-safe listening ──────────────────────────────────
        sectionBanner('14 \u00b7 Type-Safe Listening',
            'Generic parameter controls which notifications are caught',
            sangria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteSangria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final example in [
                ('NotificationListener<ScrollNotification>',
                    'Catches ScrollStart, ScrollUpdate, ScrollEnd, '
                    'Overscroll — all subclasses of ScrollNotification.',
                    Icons.swap_vert, sangria),
                ('NotificationListener<ScrollEndNotification>',
                    'Only catches scroll-end events. Start and update '
                    'pass through uncaught.',
                    Icons.last_page, merlot),
                ('NotificationListener<Notification>',
                    'Catches every notification type. Broad but may '
                    'receive too many events.',
                    Icons.all_inclusive, deepSangria),
                ('NotificationListener<MyCustomNotification>',
                    'Only catches your custom type. All built-in '
                    'notifications pass through.',
                    Icons.tune, accentTeal),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: example.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: example.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(example.$3, size: 20, color: example.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(example.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: example.$4)),
                            Text(example.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkWine)),
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

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepSangria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepSangria, sangria],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Abstract class with const constructor and dispatch() method',
                'dispatch(context) bubbles the notification up the element tree',
                'NotificationListener<T> catches matching notification types',
                'Return true to consume (stop bubble), false to pass through',
                'Sparse _NotificationNode chain for efficient traversal',
                'Rich built-in subclass hierarchy: scroll, layout, keep-alive',
                'Custom notifications: extend, dispatch, listen — three steps',
                'Generic type parameter provides type-safe listening',
                'debugFillDescription adds diagnostics for devtools',
                'Ideal for child-to-parent communication without callbacks',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightMerlot,
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

// ignore_for_file: avoid_print
// D4rt deep demo: NavigationNotification — notification for navigation state changes
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Wisteria / Periwinkle ─────────────────────────────────
  const deepWisteria = Color(0xFF4527A0);
  const wisteria = Color(0xFF5E35B1);
  const periwinkle = Color(0xFF7E57C2);
  const softWisteria = Color(0xFF9575CD);
  const lightPeriwinkle = Color(0xFFB39DDB);
  const paleWisteria = Color(0xFFEDE7F6);
  const whiteWisteria = Color(0xFFF5F2FC);
  const darkPlum = Color(0xFF311B92);
  const coralWarm = Color(0xFFE53935);
  const tealBright = Color(0xFF00ACC1);

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
          style: TextStyle(fontSize: 13, color: darkPlum)),
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
                style: TextStyle(fontSize: 13, color: darkPlum)),
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
  print('NavigationNotification deep demo executing');
  print('=' * 60);

  print('\n--- What is NavigationNotification ---');
  print('A Notification subclass for navigation state changes');
  print('Has one property: canHandlePop (bool)');
  print('Dispatched by Navigator and PopScope when pop state changes');

  final notification = NavigationNotification(canHandlePop: true);
  print('\n--- Properties ---');
  print('canHandlePop: ${notification.canHandlePop}');

  print('\n--- How it works ---');
  print('1. Navigator/PopScope dispatches NavigationNotification');
  print('2. Notification bubbles up the widget tree');
  print('3. MaterialApp/WidgetsApp listens and reports to system');
  print('4. System back button behavior updates accordingly');

  print('\n--- Consumers ---');
  print('MaterialApp and WidgetsApp listen for this notification');
  print('They call SystemNavigator.setFrameworkHandlesBack()');
  print('This tells the OS whether the app can handle back navigation');

  print('\n${'=' * 60}');
  print('NavigationNotification deep demo completed');

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
              colors: [deepWisteria, wisteria, periwinkle],
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
                      color: paleWisteria),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('NavigationNotification',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Notification dispatched when navigation state changes — tells the system about back handling',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Notification', periwinkle, Colors.white),
                tag('canHandlePop', softWisteria, darkPlum),
                tag('Navigator', lightPeriwinkle, darkPlum),
                tag('System Back', paleWisteria, darkPlum),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is NavigationNotification',
            'A notification about navigation pop-handling capability',
            deepWisteria, Colors.white),
        noteBox(
          'NavigationNotification is a class that extends Notification. It '
          'carries a single boolean property — canHandlePop — indicating '
          'whether a Navigator or PopScope below can handle a pop (back) '
          'action. This notification bubbles up the widget tree and is typically '
          'consumed by MaterialApp or WidgetsApp to inform the operating system '
          'whether the app can handle the system back button/gesture.',
          wisteria,
          whiteWisteria,
        ),
        dataRow('Extends', 'Notification', wisteria),
        dataRow('Constructor', 'const NavigationNotification({required canHandlePop})', deepWisteria),
        dataRow('Property', 'canHandlePop (final bool)', periwinkle),
        dataRow('Defined in', 'widgets/navigator.dart', darkPlum),
        const SizedBox(height: 14),

        // ── 3. The Notification pattern ──────────────────────────────
        sectionBanner('2 \u00b7 The Notification Pattern',
            'How Flutter notifications bubble up the tree',
            wisteria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: whiteWisteria,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightPeriwinkle),
          ),
          child: Column(
            children: [
              // Source
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: tealBright.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: tealBright),
                ),
                child: Row(
                  children: [
                    Icon(Icons.navigation, size: 20, color: tealBright),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Navigator / PopScope',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: tealBright)),
                        Text('Dispatches NavigationNotification',
                            style: TextStyle(
                                fontSize: 10, color: darkPlum)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    Icon(Icons.arrow_upward, size: 16, color: periwinkle),
                    Text('bubbles up',
                        style: TextStyle(fontSize: 8, color: periwinkle)),
                  ],
                ),
              ),
              // Intermediate
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: periwinkle.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: periwinkle.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.layers, size: 20,
                        color: periwinkle.withValues(alpha: 0.5)),
                    const SizedBox(width: 8),
                    Text('Any intermediate widgets...',
                        style: TextStyle(
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            color: periwinkle)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    Icon(Icons.arrow_upward, size: 16, color: periwinkle),
                    Text('bubbles up',
                        style: TextStyle(fontSize: 8, color: periwinkle)),
                  ],
                ),
              ),
              // Consumer
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepWisteria.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: deepWisteria, width: 2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.phone_android, size: 20, color: deepWisteria),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('MaterialApp / WidgetsApp',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: deepWisteria)),
                          Text('Listens and calls SystemNavigator.setFrameworkHandlesBack()',
                              style: TextStyle(
                                  fontSize: 10, color: darkPlum)),
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

        // ── 4. canHandlePop property ─────────────────────────────────
        sectionBanner('3 \u00b7 The canHandlePop Property',
            'What it means and when it changes',
            periwinkle, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteWisteria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: tealBright.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: tealBright, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_circle, size: 28, color: tealBright),
                      const SizedBox(height: 6),
                      Text('true',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'monospace',
                              color: tealBright)),
                      const SizedBox(height: 6),
                      Text('App can handle pop',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: darkPlum)),
                      const SizedBox(height: 4),
                      Text('Navigator has routes to pop, or a PopScope is blocking. '
                          'System back gesture will be handled by the app.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkPlum)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: coralWarm.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: coralWarm, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.cancel, size: 28, color: coralWarm),
                      const SizedBox(height: 6),
                      Text('false',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'monospace',
                              color: coralWarm)),
                      const SizedBox(height: 6),
                      Text('App cannot handle pop',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: darkPlum)),
                      const SizedBox(height: 4),
                      Text('At the root route with no PopScope. System back '
                          'gesture will exit the app or return to launcher.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkPlum)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Who dispatches it ─────────────────────────────────────
        sectionBanner('4 \u00b7 Who Dispatches It',
            'Sources that create and dispatch the notification',
            deepWisteria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteWisteria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final source in [
                ('Navigator', 'Dispatches when routes are pushed or popped. '
                    'canHandlePop is true when there is more than one route.',
                    Icons.navigation, wisteria),
                ('PopScope', 'Dispatches when its canPop property changes. '
                    'Overrides Navigator\'s pop behavior while active.',
                    Icons.block, periwinkle),
                ('NavigatorState', 'After didPush, didPop, didRemove, or '
                    'didReplace callbacks fire, it schedules notification dispatch.',
                    Icons.timeline, deepWisteria),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: source.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: source.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(source.$3, size: 20, color: source.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(source.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                    color: source.$4)),
                            Text(source.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkPlum)),
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

        // ── 6. Who consumes it ───────────────────────────────────────
        sectionBanner('5 \u00b7 Who Consumes It',
            'Widgets that listen for the notification',
            wisteria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteWisteria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final consumer in [
                ('MaterialApp', 'Wraps the app with a NotificationListener<NavigationNotification> '
                    'and calls SystemNavigator.setFrameworkHandlesBack(canHandlePop).',
                    Icons.phone_android, deepWisteria),
                ('WidgetsApp', 'Base class for MaterialApp/CupertinoApp. Contains the '
                    'actual notification listener implementation.',
                    Icons.widgets, wisteria),
                ('Custom Listener', 'You can add your own NotificationListener to track '
                    'navigation state for analytics, UI updates, etc.',
                    Icons.hearing, periwinkle),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: consumer.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(consumer.$3, size: 20, color: consumer.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(consumer.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                    color: consumer.$4)),
                            Text(consumer.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkPlum)),
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

        // ── 7. System back button flow ───────────────────────────────
        sectionBanner('6 \u00b7 System Back Button Flow',
            'End-to-end: from Navigator to OS back button',
            periwinkle, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteWisteria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                (1, 'Route pushed/popped', 'Navigator updates its route stack',
                    tealBright),
                (2, 'Notification dispatched', 'NavigationNotification(canHandlePop: hasRoutes)',
                    wisteria),
                (3, 'Bubbles to WidgetsApp', 'NotificationListener<NavigationNotification> catches it',
                    periwinkle),
                (4, 'System call', 'SystemNavigator.setFrameworkHandlesBack(canHandlePop)',
                    deepWisteria),
                (5, 'OS updated', 'Android/iOS knows whether to defer back to the app',
                    darkPlum),
                (6, 'Back pressed', 'If canHandlePop=true, app pops route; if false, OS handles',
                    coralWarm),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: step.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: step.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: step.$4,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('${step.$1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(step.$2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: darkPlum)),
                            Text(step.$3,
                                style: TextStyle(
                                    fontSize: 11, color: darkPlum)),
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

        // ── 8. Route stack scenarios ─────────────────────────────────
        sectionBanner('7 \u00b7 Route Stack Scenarios',
            'When canHandlePop is true vs false',
            deepWisteria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteWisteria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final scenario in [
                ('Single route (root)', '[/]', false,
                    'Nothing to pop — OS handles back', coralWarm),
                ('Two routes', '[/, /details]', true,
                    'Can pop /details to return to /', tealBright),
                ('Three routes', '[/, /list, /item]', true,
                    'Can pop /item to return to /list', tealBright),
                ('Root + PopScope', '[/] + PopScope(canPop: false)', true,
                    'PopScope intercepts — app handles', wisteria),
                ('Dialog open', '[/, /home, dialog]', true,
                    'Can dismiss dialog', tealBright),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: scenario.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: scenario.$5, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        scenario.$3 ? Icons.check_circle : Icons.cancel,
                        size: 18,
                        color: scenario.$3 ? tealBright : coralWarm,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(scenario.$1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: darkPlum)),
                                const SizedBox(width: 6),
                                Text(scenario.$2,
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontFamily: 'monospace',
                                        color: periwinkle)),
                              ],
                            ),
                            Text(scenario.$4,
                                style: TextStyle(
                                    fontSize: 10, color: darkPlum)),
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

        // ── 9. Live demo: listening for the notification ─────────────
        sectionBanner('8 \u00b7 Live Demo: Notification Listener',
            'Using NotificationListener to observe navigation state',
            wisteria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteWisteria,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightPeriwinkle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: wisteria.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: wisteria.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'NotificationListener<NavigationNotification>(\n'
                    '  onNotification: (notification) {\n'
                    '    print(notification.canHandlePop);\n'
                    '    return false; // allow bubbling\n'
                    '  },\n'
                    '  child: Navigator(...),\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepWisteria)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'Return false from onNotification to let the notification continue '
                'bubbling. Return true to stop it — but this prevents MaterialApp '
                'from receiving it, which breaks system back button integration.',
                wisteria,
                paleWisteria,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. PopScope interaction ─────────────────────────────────
        sectionBanner('9 \u00b7 PopScope Interaction',
            'How PopScope affects NavigationNotification',
            periwinkle, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteWisteria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: tealBright.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: tealBright),
                      ),
                      child: Column(
                        children: [
                          Text('PopScope(canPop: true)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: tealBright)),
                          const SizedBox(height: 4),
                          Text('Normal behavior.\nNavigator decides\ncanHandlePop.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkPlum)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: coralWarm.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: coralWarm),
                      ),
                      child: Column(
                        children: [
                          Text('PopScope(canPop: false)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: coralWarm)),
                          const SizedBox(height: 4),
                          Text('Forces canHandlePop\nto true. Back goes\nto onPopInvokedWithResult.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkPlum)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              noteBox(
                'PopScope with canPop: false intercepts the system back button. '
                'It forces canHandlePop to true in the notification so the OS '
                'defers to the app. The onPopInvokedWithResult callback then '
                'decides what to do (e.g., show a confirmation dialog).',
                periwinkle,
                whiteWisteria,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Nested navigators ────────────────────────────────────
        sectionBanner('10 \u00b7 Nested Navigators',
            'How notifications work with multiple navigators',
            deepWisteria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteWisteria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepWisteria.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: deepWisteria),
                ),
                child: Column(
                  children: [
                    Text('Root Navigator',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: deepWisteria)),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: wisteria.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: wisteria),
                      ),
                      child: Column(
                        children: [
                          Text('Nested Navigator (tab)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: wisteria)),
                          const SizedBox(height: 4),
                          Text('Dispatches its own notification',
                              style: TextStyle(
                                  fontSize: 10, color: darkPlum)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('Both navigators dispatch independently',
                        style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: darkPlum)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              noteBox(
                'Each Navigator dispatches its own NavigationNotification. '
                'With nested navigators (e.g., in a TabView), the inner '
                'navigator\'s notification bubbles through the outer one. '
                'MaterialApp receives all of them and the last one wins.',
                deepWisteria,
                paleWisteria,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Predictive back ──────────────────────────────────────
        sectionBanner('11 \u00b7 Predictive Back Gesture',
            'Android 13+ predictive back and NavigationNotification',
            wisteria, Colors.white),
        noteBox(
          'On Android 13+ with predictive back enabled, the OS shows a preview '
          'of the previous screen during back swipe. NavigationNotification '
          'tells the system whether the app handles back. If canHandlePop is '
          'false, the OS shows the launcher preview. If true, the app gets the '
          'back event and can animate its own transition.',
          wisteria,
          whiteWisteria,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteWisteria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: tealBright.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: tealBright),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.swipe_left, size: 22, color: tealBright),
                      const SizedBox(height: 4),
                      Text('canHandlePop: true',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: tealBright)),
                      Text('App handles swipe\nand pops route',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkPlum)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: coralWarm.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: coralWarm),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.swipe_right, size: 22, color: coralWarm),
                      const SizedBox(height: 4),
                      Text('canHandlePop: false',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: coralWarm)),
                      Text('Swipe shows home\nlauncher preview',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkPlum)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Comparison with other notifications ──────────────────
        sectionBanner('12 \u00b7 Comparison With Other Notifications',
            'NavigationNotification vs other framework notifications',
            periwinkle, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteWisteria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(4),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepWisteria),
                children: [
                  for (final h in ['Notification', 'Purpose'])
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
                ('ScrollNotification', 'Scroll position/direction changes'),
                ('OverscrollNotification', 'Scroll beyond bounds'),
                ('LayoutChangedNotification', 'Layout metrics updated'),
                ('SizeChangedLayoutNotification', 'Size of widget changed'),
                ('KeepAliveNotification', 'Request to keep alive in viewport'),
                ('NavigationNotification', 'Navigation pop-handling state'),
              ])
                TableRow(
                  decoration: row.$1 == 'NavigationNotification'
                      ? BoxDecoration(
                          color: wisteria.withValues(alpha: 0.08))
                      : null,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              fontWeight: row.$1 == 'NavigationNotification'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: row.$1 == 'NavigationNotification'
                                  ? wisteria
                                  : darkPlum)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: darkPlum)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Class definition ─────────────────────────────────────
        sectionBanner('13 \u00b7 Class Definition',
            'The complete class as defined in the SDK',
            deepWisteria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteWisteria,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepWisteria.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepWisteria.withValues(alpha: 0.3)),
            ),
            child: Text(
                'class NavigationNotification extends Notification {\n'
                '  const NavigationNotification({\n'
                '    required this.canHandlePop,\n'
                '  });\n'
                '\n'
                '  /// Whether a [Navigator] or [PopScope]\n'
                '  /// in the tree can handle a pop.\n'
                '  final bool canHandlePop;\n'
                '}',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: deepWisteria)),
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Class hierarchy ──────────────────────────────────────
        sectionBanner('14 \u00b7 Class Hierarchy',
            'Inheritance chain',
            wisteria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteWisteria,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Object', Colors.grey),
                ('\u2514\u2500 Notification', softWisteria),
                ('    \u2514\u2500 NavigationNotification', wisteria),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight: level.$1.contains('NavigationNotification')
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
            'Key takeaways', deepWisteria, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepWisteria, wisteria],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Extends Notification with one property: canHandlePop (bool)',
                'Dispatched by Navigator and PopScope when navigation state changes',
                'Bubbles up the widget tree like all Flutter notifications',
                'Consumed by MaterialApp/WidgetsApp for system back button integration',
                'canHandlePop=true means app can handle back (pop a route)',
                'canHandlePop=false means at root — OS handles back (exit app)',
                'PopScope with canPop: false forces canHandlePop to true',
                'Essential for Android 13+ predictive back gesture support',
                'Nested navigators each dispatch independently',
                'Use NotificationListener<NavigationNotification> to observe',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightPeriwinkle,
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

// ignore_for_file: avoid_print
// D4rt deep demo: MenuController — controls MenuAnchor menu open/close state
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Carmine / Scarlet ─────────────────────────────────────
  const deepCarmine = Color(0xFF7F1D1D);
  const carmine = Color(0xFF991B1B);
  const scarlet = Color(0xFFB91C1C);
  const brightRed = Color(0xFFDC2626);
  const warmRed = Color(0xFFEF4444);
  const paleRose = Color(0xFFFEE2E2);
  const creamWhite = Color(0xFFFEF2F2);
  const darkBurgundy = Color(0xFF450A0A);
  const tealContrast = Color(0xFF0D9488);
  const amberContrast = Color(0xFFD97706);

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
          style: TextStyle(fontSize: 13, color: darkBurgundy)),
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
                style: TextStyle(fontSize: 13, color: darkBurgundy)),
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

  // ── Create sample controller ───────────────────────────────────────
  print('MenuController deep demo executing');
  print('=' * 60);

  final controller = MenuController();

  // Section 1
  print('\n--- What is MenuController ---');
  print('Controls the open/close state of a MenuAnchor menu');
  print('Properties: isOpen');
  print('Methods: open(), close(), closeChildren()');
  print('Static: maybeOf(context)');

  // Section 2
  print('\n--- Initial state ---');
  print('isOpen: ${controller.isOpen}');

  // Section 3
  print('\n--- Controller methods ---');
  print('open({Offset? position}) - opens the menu');
  print('close() - closes the menu and children');
  print('closeChildren() - closes only nested submenus');
  print('maybeOf(context) - finds controller from context');

  print('\n${'=' * 60}');
  print('MenuController deep demo completed');

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
              colors: [deepCarmine, carmine, scarlet],
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
                  Icon(Icons.menu_open, size: 28, color: paleRose),
                  const SizedBox(width: 10),
                  const Text('MenuController',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              Text('Programmatic control of MenuAnchor menu open/close state',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('ChangeNotifier', scarlet, Colors.white),
                tag('isOpen / open / close', brightRed, Colors.white),
                tag('MenuAnchor Integration', paleRose, deepCarmine),
                tag('Context Lookup', warmRed, Colors.white),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is MenuController',
            'Programmatic menu lifecycle management',
            deepCarmine, Colors.white),
        noteBox(
          'MenuController is a ChangeNotifier that controls whether a '
          'MenuAnchor menu is open or closed. You create a MenuController, '
          'pass it to a MenuAnchor widget, and then call open() or close() '
          'to programmatically control the menu. The controller also exposes '
          'isOpen to query the current state and closeChildren() to close '
          'nested submenus without closing the parent.',
          scarlet,
          creamWhite,
        ),
        dataRow('Extends', 'ChangeNotifier', scarlet),
        dataRow('Constructor', 'MenuController()', brightRed),
        dataRow('Key property', 'isOpen (bool)', carmine),
        dataRow('Defined in', 'widgets/raw_menu_anchor.dart', deepCarmine),
        const SizedBox(height: 14),

        // ── 3. API surface ───────────────────────────────────────────
        sectionBanner('2 \u00b7 API Surface',
            'All public members of MenuController',
            carmine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final member in [
                ('isOpen', 'bool', 'Whether the menu is currently showing',
                    'Property', scarlet, Icons.visibility),
                ('open()', 'void', 'Opens the menu (optional position parameter)',
                    'Method', brightRed, Icons.open_in_new),
                ('close()', 'void', 'Closes the menu and all descendant menus',
                    'Method', carmine, Icons.close),
                ('closeChildren()', 'void', 'Closes nested submenus only',
                    'Method', deepCarmine, Icons.subdirectory_arrow_left),
                ('maybeOf(ctx)', 'MenuController?', 'Finds controller from BuildContext',
                    'Static', darkBurgundy, Icons.search),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: member.$5, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: member.$5.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Icon(member.$6, size: 18, color: member.$5),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(member.$1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        fontFamily: 'monospace',
                                        color: darkBurgundy)),
                                const SizedBox(width: 6),
                                tag(member.$4,
                                    member.$5.withValues(alpha: 0.1),
                                    member.$5),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(member.$3,
                                style: TextStyle(
                                    fontSize: 11, color: carmine)),
                            Text('Returns: ${member.$2}',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: deepCarmine.withValues(alpha: 0.7))),
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

        // ── 4. State machine ─────────────────────────────────────────
        sectionBanner('3 \u00b7 State Machine',
            'The two states of a MenuController',
            scarlet, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleRose),
          ),
          child: Row(
            children: [
              // Closed state
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: tealContrast.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: tealContrast, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.menu, size: 28, color: tealContrast),
                      const SizedBox(height: 6),
                      Text('CLOSED',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: tealContrast)),
                      Text('isOpen = false',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: tealContrast)),
                    ],
                  ),
                ),
              ),
              // Arrows
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('open()',
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: scarlet)),
                        Icon(Icons.arrow_forward, size: 14, color: scarlet),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.arrow_back, size: 14, color: tealContrast),
                        Text('close()',
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: tealContrast)),
                      ],
                    ),
                  ],
                ),
              ),
              // Open state
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: scarlet.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: scarlet, width: 2),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.menu_open, size: 28, color: scarlet),
                      const SizedBox(height: 6),
                      Text('OPEN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: scarlet)),
                      Text('isOpen = true',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: scarlet)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. open() method detail ──────────────────────────────────
        sectionBanner('4 \u00b7 open() Method',
            'Opens the menu — optional position parameter',
            brightRed, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('void open({Offset? position})',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontFamily: 'monospace',
                      color: scarlet)),
              const SizedBox(height: 10),
              for (final detail in [
                ('No position', 'Menu opens at anchor default location',
                    'Used for button-triggered menus', tealContrast),
                ('With position', 'Menu opens at specified screen offset',
                    'Used for context menus at tap location', scarlet),
                ('Already open', 'Calling open() again is a no-op',
                    'Safe to call repeatedly', amberContrast),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: detail.$4, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(detail.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: detail.$4)),
                      Text(detail.$2,
                          style: TextStyle(
                              fontSize: 11, color: darkBurgundy)),
                      Text(detail.$3,
                          style: TextStyle(
                              fontSize: 10,
                              color: darkBurgundy.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. close() vs closeChildren() ────────────────────────────
        sectionBanner('5 \u00b7 close() vs closeChildren()',
            'Two different levels of menu dismissal',
            carmine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepCarmine),
                children: [
                  for (final h in ['Aspect', 'close()', 'closeChildren()'])
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
                ('This menu', 'Closes', 'Stays open'),
                ('Child menus', 'Closes all', 'Closes all'),
                ('isOpen after', 'false', 'true (still open)'),
                ('Use case', 'Full dismiss', 'Reset submenus'),
                ('Typical trigger', 'Item selected', 'Hover change'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: scarlet)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: carmine)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: tealContrast)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. MenuAnchor integration ────────────────────────────────
        sectionBanner('6 \u00b7 MenuAnchor Integration',
            'How MenuController connects to the widget tree',
            deepCarmine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                (1, 'Create MenuController', 'final controller = MenuController()',
                    scarlet),
                (2, 'Pass to MenuAnchor', 'MenuAnchor(controller: controller, ...)',
                    brightRed),
                (3, 'MenuAnchor attaches', 'Internal _attach() binds controller to state',
                    carmine),
                (4, 'Call controller.open()', 'Controller tells MenuAnchor to show overlay',
                    deepCarmine),
                (5, 'Menu is displayed', 'Overlay entry with menu items appears',
                    darkBurgundy),
                (6, 'Call controller.close()', 'Menu overlay is dismissed',
                    tealContrast),
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
                                    color: darkBurgundy)),
                            Text(step.$3,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: carmine)),
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

        // ── 8. maybeOf() static method ───────────────────────────────
        sectionBanner('7 \u00b7 MenuController.maybeOf()',
            'Finding a controller from the widget tree',
            scarlet, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('static MenuController? maybeOf(BuildContext context)',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: scarlet)),
              const SizedBox(height: 10),
              for (final scenario in [
                ('Inside MenuAnchor', 'Returns the controller attached to the nearest MenuAnchor',
                    tealContrast, Icons.check_circle),
                ('Outside MenuAnchor', 'Returns null — no menu ancestor found',
                    amberContrast, Icons.warning),
                ('Nested menus', 'Returns the nearest (innermost) controller',
                    scarlet, Icons.layers),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: scenario.$3, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Icon(scenario.$4, size: 18, color: scenario.$3),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(scenario.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: scenario.$3)),
                            Text(scenario.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkBurgundy)),
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

        // ── 9. Visual menu tree ──────────────────────────────────────
        sectionBanner('8 \u00b7 Menu Tree Visualization',
            'A parent menu with nested submenus',
            brightRed, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleRose),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Anchor button
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: scarlet,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.menu, size: 16, color: Colors.white),
                    const SizedBox(width: 6),
                    Text('File',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              // Menu items
              Container(
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: paleRose),
                  boxShadow: [
                    BoxShadow(
                      color: deepCarmine.withValues(alpha: 0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    for (final item in [
                      ('New', false, null),
                      ('Open', false, null),
                      ('Recent', true, [
                        'file1.dart',
                        'file2.dart',
                        'file3.dart',
                      ]),
                      ('Save', false, null),
                      ('Exit', false, null),
                    ])
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: paleRose.withValues(alpha: 0.5)),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(item.$1,
                                  style: TextStyle(
                                      fontSize: 12, color: darkBurgundy)),
                            ),
                            if (item.$2)
                              Icon(Icons.chevron_right,
                                  size: 14, color: scarlet),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              // Submenu arrow and panel
              Padding(
                padding: const EdgeInsets.only(left: 160, top: 0),
                child: Container(
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: paleRose),
                    boxShadow: [
                      BoxShadow(
                        color: deepCarmine.withValues(alpha: 0.1),
                        blurRadius: 6,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      for (final sub
                          in ['file1.dart', 'file2.dart', 'file3.dart'])
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          child: Text(sub,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                  color: carmine)),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              noteBox(
                'closeChildren() on the File controller closes the Recent '
                'submenu but keeps File menu open. close() closes everything.',
                scarlet,
                paleRose,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Context menu pattern ─────────────────────────────────
        sectionBanner('9 \u00b7 Context Menu Pattern',
            'Using open(position:) for right-click menus',
            carmine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final step in [
                (1, 'Detect secondary tap', 'GestureDetector.onSecondaryTapUp',
                    scarlet),
                (2, 'Get tap position', 'details.globalPosition',
                    brightRed),
                (3, 'Call open(position:)', 'controller.open(position: tapPos)',
                    carmine),
                (4, 'Menu appears at cursor', 'Overlay positioned at tap location',
                    deepCarmine),
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
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: step.$4,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Text('${step.$1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(step.$2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: darkBurgundy)),
                            Text(step.$3,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: carmine)),
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

        // ── 11. ChangeNotifier behavior ──────────────────────────────
        sectionBanner('10 \u00b7 ChangeNotifier Behavior',
            'MenuController extends ChangeNotifier',
            deepCarmine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final behavior in [
                ('addListener()', 'Register callback for open/close state changes',
                    scarlet),
                ('removeListener()', 'Unregister callback', brightRed),
                ('notifyListeners()', 'Called internally when state changes',
                    carmine),
                ('dispose()', 'Clean up — important to call when done', deepCarmine),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: behavior.$3, width: 3)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(behavior.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: behavior.$3)),
                      ),
                      Expanded(
                        child: Text(behavior.$2,
                            style: TextStyle(
                                fontSize: 11, color: darkBurgundy)),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              noteBox(
                'Because MenuController is a ChangeNotifier, you can use '
                'ListenableBuilder or AnimatedBuilder to rebuild parts of '
                'the UI when the menu opens or closes — e.g., changing a '
                'button icon from menu to close.',
                brightRed,
                paleRose,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Menu types comparison ────────────────────────────────
        sectionBanner('11 \u00b7 Menu Widget Comparison',
            'Where MenuController fits in Flutter\'s menu ecosystem',
            scarlet, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2.5),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepCarmine),
                children: [
                  for (final h in ['Widget', 'Controller?', 'Use Case'])
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
                ('MenuAnchor', 'MenuController', 'General purpose anchor menu'),
                ('MenuBar', 'Per-item controller', 'Desktop-style menu bar'),
                ('DropdownMenu', 'No (built-in)', 'Material dropdown selection'),
                ('PopupMenuButton', 'No (callback)', 'Simple popup menu'),
                ('ContextMenuRegion', 'No (automatic)', 'Right-click context menus'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                              color: scarlet)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: carmine)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: darkBurgundy)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Common patterns ──────────────────────────────────────
        sectionBanner('12 \u00b7 Common Usage Patterns',
            'Typical ways to use MenuController',
            brightRed, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final pattern in [
                ('Button-triggered menu', 'Create controller in State, pass to MenuAnchor, '
                    'call open() from button onPressed',
                    Icons.smart_button, scarlet),
                ('Right-click context menu', 'Wrap area in GestureDetector, call '
                    'open(position: details.globalPosition) on secondary tap',
                    Icons.mouse, brightRed),
                ('Programmatic toggle', 'Check isOpen and call open() or close() accordingly '
                    'for toggle behavior',
                    Icons.toggle_on, carmine),
                ('Keyboard shortcut menu', 'Use Shortcuts/Actions to call open() or close() '
                    'on key combinations',
                    Icons.keyboard, deepCarmine),
                ('Auto-close on selection', 'In onPressed of MenuItemButton, call '
                    'controller.close() to dismiss menu',
                    Icons.check, darkBurgundy),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: pattern.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: pattern.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(pattern.$3, size: 22, color: pattern.$4),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pattern.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: darkBurgundy)),
                            Text(pattern.$2,
                                style: TextStyle(
                                    fontSize: 11, color: carmine)),
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

        // ── 14. Internal mechanism ───────────────────────────────────
        sectionBanner('13 \u00b7 Internal Mechanism',
            'How MenuController communicates with MenuAnchor',
            deepCarmine, Colors.white),
        noteBox(
          'MenuController uses internal _attach() and _detach() methods. '
          'When a MenuAnchor is built with a controller, it calls _attach() '
          'to bind the controller to its state (_RawMenuAnchorBaseMixin). '
          'When the MenuAnchor is disposed, _detach() unbinds it. The '
          'controller\'s open() and close() methods delegate to the attached '
          'state\'s _open() and _close() methods, which manage the overlay.',
          deepCarmine,
          creamWhite,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final internal in [
                ('_attach(state)', 'Binds controller to MenuAnchor state', carmine),
                ('_detach(state)', 'Unbinds controller from state', scarlet),
                ('_open(position:)', 'Delegates to state._open()', brightRed),
                ('_close()', 'Delegates to state._close()', deepCarmine),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(internal.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: internal.$3)),
                      ),
                      Expanded(
                        child: Text(internal.$2,
                            style: TextStyle(
                                fontSize: 11, color: darkBurgundy)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Inheritance ──────────────────────────────────────────
        sectionBanner('14 \u00b7 Class Hierarchy',
            'Where MenuController sits', deepCarmine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: creamWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Object', 0, Colors.grey),
                ('\u2514\u2500 ChangeNotifier', 1, carmine),
                ('    \u2514\u2500 MenuController', 2, scarlet),
              ])
                Padding(
                  padding: EdgeInsets.only(
                      left: level.$2 * 4.0, top: 4, bottom: 4),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'monospace',
                          fontWeight: level.$2 == 2
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: level.$3)),
                ),
              const SizedBox(height: 6),
              Text(
                  'Extends ChangeNotifier for listener support. '
                  'No mixins, no implements. Simple inheritance chain.',
                  style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: carmine)),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepCarmine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepCarmine, carmine],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'MenuController extends ChangeNotifier for menu state management',
                'isOpen — read-only property for current menu state',
                'open({Offset? position}) — shows menu, optional position for context menus',
                'close() — dismisses menu and all descendant submenus',
                'closeChildren() — closes nested submenus while keeping parent open',
                'maybeOf(context) — static lookup from widget tree',
                'Used with MenuAnchor widget — pass controller to constructor',
                'Internal _attach/_detach for widget communication',
                'Supports button-triggered, right-click, programmatic, and keyboard patterns',
                'Defined in widgets/raw_menu_anchor.dart',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: warmRed,
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

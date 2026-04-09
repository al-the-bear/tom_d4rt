// ignore_for_file: avoid_print
// D4rt deep demo: LocalHistoryEntry — route-local history entries for sub-page navigation
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Jade / Celadon ────────────────────────────────────────
  const deepJade = Color(0xFF004D40);
  const richJade = Color(0xFF00695C);
  const celadon = Color(0xFF00897B);
  const seafoam = Color(0xFF26A69A);
  const malachite = Color(0xFF4DB6AC);
  const aquaMint = Color(0xFF80CBC4);
  const paleCeladon = Color(0xFFB2DFDB);
  const jadeWhite = Color(0xFFE0F2F1);
  const coralAccent = Color(0xFFFF7043);
  const amberSignal = Color(0xFFFFB300);

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
      child: Text(text, style: TextStyle(fontSize: 13, color: deepJade)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: deepJade)),
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

  Widget apiCard(String name, String description, IconData icon, Color accent) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: jadeWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        fontFamily: 'monospace',
                        color: deepJade)),
                const SizedBox(height: 3),
                Text(description,
                    style: TextStyle(fontSize: 12, color: celadon)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget flowStep(int number, String title, String detail, Color accent) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('$number',
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
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: deepJade)),
                Text(detail,
                    style: TextStyle(fontSize: 11, color: celadon)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Gather data ────────────────────────────────────────────────────
  print('LocalHistoryEntry deep demo executing');
  print('=' * 60);

  // Section 1 — what is it
  print('\n--- What is LocalHistoryEntry ---');
  print('An entry in a routes local history stack');
  print('Allows sub-page navigation without pushing new routes');

  // Section 2 — creation
  print('\n--- Creation ---');
  var removeCount = 0;
  final entry = LocalHistoryEntry(onRemove: () {
    removeCount++;
    print('  onRemove callback fired (count: $removeCount)');
  });
  print('  Created with onRemove callback');

  final entryNoCallback = LocalHistoryEntry();
  print('  Created without callback: $entryNoCallback');

  // Section 3 — API
  print('\n--- API ---');
  print('  onRemove: VoidCallback? (constructor parameter)');
  print('  remove(): removes this entry from the route');
  print('  impliesAppBarDismissal: ${entry.impliesAppBarDismissal}');

  // Section 4 — impliesAppBarDismissal
  print('\n--- impliesAppBarDismissal ---');
  print('  Default: ${entry.impliesAppBarDismissal}');
  print('  Subclass can override to suppress back button');

  // Section 5 — callback behavior
  print('\n--- Callback behavior ---');
  print('  onRemove fires when entry is removed from route');
  print('  removeCount before: $removeCount');

  print('\n${'=' * 60}');
  print('LocalHistoryEntry deep demo completed');

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
              colors: [deepJade, richJade, celadon],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('LocalHistoryEntry',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Sub-page navigation without pushing new routes',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Class', celadon, Colors.white),
                tag('Navigation', seafoam, Colors.white),
                tag('ModalRoute', malachite, Colors.white),
                tag('Back Button', aquaMint, deepJade),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is LocalHistoryEntry',
            'Route-local history management for sub-page states',
            deepJade, Colors.white),
        noteBox(
          'LocalHistoryEntry represents an entry in a ModalRoute\'s local '
          'history stack. When users push local history entries, the back '
          'button pops them before actually navigating away from the route. '
          'This enables tab switching, form wizards, and nested panels '
          'that respond to the back button without creating new routes.',
          deepJade,
          jadeWhite,
        ),
        dataRow('Type', 'class', richJade),
        dataRow('Constructor', 'LocalHistoryEntry({VoidCallback? onRemove})', celadon),
        dataRow('Used with', 'ModalRoute.addLocalHistoryEntry()', seafoam),
        dataRow('Back button', 'Pops local entries before route', malachite),
        const SizedBox(height: 14),

        // ── 3. API surface ───────────────────────────────────────────
        sectionBanner('2 \u00b7 API Surface',
            'Constructor parameter and key members',
            richJade, Colors.white),
        apiCard('onRemove', 'VoidCallback? — called when entry is removed from route', Icons.notifications_active, deepJade),
        apiCard('remove()', 'Removes this entry from the local history', Icons.delete_outline, richJade),
        apiCard('impliesAppBarDismissal', 'bool — whether AppBar shows back/close button (default: true)', Icons.arrow_back, celadon),
        const SizedBox(height: 14),

        // ── 4. Creation patterns ─────────────────────────────────────
        sectionBanner('3 \u00b7 Creation Patterns',
            'Different ways to create entries',
            celadon, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: jadeWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final pattern in [
                ('With callback', 'LocalHistoryEntry(onRemove: () { ... })', 'Most common — reacts to removal', deepJade),
                ('Without callback', 'LocalHistoryEntry()', 'Just for back button interception', richJade),
                ('Stored reference', 'final entry = LocalHistoryEntry(...)', 'Allows programmatic removal', celadon),
                ('Inline creation', 'route.addLocalHistoryEntry(LocalHistoryEntry(...))', 'One-shot usage', seafoam),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: pattern.$4, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pattern.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: pattern.$4)),
                      const SizedBox(height: 2),
                      Text(pattern.$2,
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: deepJade)),
                      const SizedBox(height: 2),
                      Text(pattern.$3,
                          style: TextStyle(
                              fontSize: 11, color: malachite)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. Back button flow ──────────────────────────────────────
        sectionBanner('4 \u00b7 Back Button Behavior',
            'How local history interacts with navigation',
            deepJade, Colors.white),
        flowStep(1, 'User pushes route', 'Navigator.push() creates new route with empty local history', deepJade),
        flowStep(2, 'App adds local entries', 'ModalRoute.of(context)!.addLocalHistoryEntry(entry)', richJade),
        flowStep(3, 'User presses back', 'System checks for local history entries first', celadon),
        flowStep(4, 'Local entry popped', 'Last entry removed, onRemove called', seafoam),
        flowStep(5, 'More entries?', 'If yes, repeat step 3-4. If no, pop the route itself', malachite),
        flowStep(6, 'Route popped', 'Only when all local entries are exhausted', aquaMint),
        const SizedBox(height: 14),

        // ── 6. impliesAppBarDismissal ────────────────────────────────
        sectionBanner('5 \u00b7 impliesAppBarDismissal',
            'Controls AppBar leading button appearance',
            richJade, Colors.white),
        noteBox(
          'When impliesAppBarDismissal is true (default), adding a local '
          'history entry causes the AppBar to show a back arrow or close '
          'button, signalling to the user that pressing back will undo '
          'something. Override this to false in a subclass to add local '
          'history entries without visual indication.',
          richJade,
          jadeWhite,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: jadeWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              for (final scenario in [
                (true, 'Default entry', Icons.arrow_back, 'AppBar shows back arrow', deepJade),
                (true, 'Tab switcher', Icons.tab, 'User sees they can go back', richJade),
                (false, 'Silent entry', Icons.visibility_off, 'No visual change to AppBar', coralAccent),
                (false, 'Background state', Icons.settings_backup_restore, 'Hidden undo point', amberSignal),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: scenario.$5.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(scenario.$3, size: 20, color: scenario.$5),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 100,
                        child: Text(scenario.$2,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: deepJade)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: scenario.$1
                              ? deepJade.withValues(alpha: 0.1)
                              : coralAccent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(scenario.$1 ? 'true' : 'false',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: scenario.$1 ? deepJade : coralAccent)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(scenario.$4,
                            style: TextStyle(
                                fontSize: 11, color: celadon)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Stack visualization ───────────────────────────────────
        sectionBanner('6 \u00b7 Local History Stack',
            'Visual representation of entries on a route',
            celadon, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: jadeWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleCeladon),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.layers, size: 20, color: deepJade),
                  const SizedBox(width: 8),
                  Text('Route Local History Stack',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: deepJade)),
                ],
              ),
              const SizedBox(height: 12),
              for (final layer in [
                ('Entry 3', 'Tab: Settings', 'TOP \u2190 back pops this first', coralAccent),
                ('Entry 2', 'Tab: Profile', 'Next in line', seafoam),
                ('Entry 1', 'Tab: Home', 'First added', celadon),
                ('Route', 'MaterialPageRoute', 'Popped only when stack empty', deepJade),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: layer.$4.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: layer.$4.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: Text(layer.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: layer.$4)),
                      ),
                      SizedBox(
                        width: 110,
                        child: Text(layer.$2,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: deepJade)),
                      ),
                      Expanded(
                        child: Text(layer.$3,
                            style: TextStyle(
                                fontSize: 11, color: malachite)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Use cases ─────────────────────────────────────────────
        sectionBanner('7 \u00b7 Common Use Cases',
            'Where local history entries shine',
            deepJade, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: jadeWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final useCase in [
                ('Tab navigation', Icons.tab, 'Switch tabs with back-button support', deepJade),
                ('Form wizard', Icons.list_alt, 'Multi-step forms that undo per-step', richJade),
                ('Panel toggling', Icons.view_sidebar, 'Show/hide panels with back support', celadon),
                ('Search overlay', Icons.search, 'Dismiss search bar via back button', seafoam),
                ('Filter selection', Icons.filter_list, 'Remove filters one at a time', malachite),
                ('Image gallery', Icons.photo_library, 'Navigate sub-images within a page', aquaMint),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: useCase.$4, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Icon(useCase.$2, size: 22, color: useCase.$4),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(useCase.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: deepJade)),
                            Text(useCase.$3,
                                style: TextStyle(
                                    fontSize: 12, color: celadon)),
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

        // ── 9. Simulated tab switcher ────────────────────────────────
        sectionBanner('8 \u00b7 Simulated Tab Switcher',
            'Visual demo: tabs as local history entries',
            richJade, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: jadeWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleCeladon),
          ),
          child: Column(
            children: [
              // Tab bar
              Row(
                children: [
                  for (final tab in [
                    ('Home', Icons.home, deepJade, false),
                    ('Search', Icons.search, richJade, false),
                    ('Profile', Icons.person, celadon, true),
                  ])
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: tab.$4
                              ? tab.$3
                              : tab.$3.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Icon(tab.$2,
                                size: 20,
                                color: tab.$4 ? Colors.white : tab.$3),
                            const SizedBox(height: 2),
                            Text(tab.$1,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: tab.$4
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: tab.$4 ? Colors.white : tab.$3)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              // History indicators
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepJade.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Local history:',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: deepJade)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        for (final histEntry in [
                          ('Home', deepJade),
                          ('Search', richJade),
                          ('Profile', celadon),
                        ]) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: histEntry.$2.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(histEntry.$1,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: histEntry.$2)),
                          ),
                          if (histEntry.$1 != 'Profile')
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text('\u2192',
                                  style: TextStyle(
                                      fontSize: 12, color: aquaMint)),
                            ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Back button: Profile \u2192 Search \u2192 Home \u2192 pop route',
                        style: TextStyle(
                            fontSize: 10, color: malachite)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. onRemove lifecycle ───────────────────────────────────
        sectionBanner('9 \u00b7 onRemove Lifecycle',
            'When and how the callback fires',
            celadon, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: jadeWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final trigger in [
                ('Back button pressed', Icons.arrow_back, 'System pops last local entry', true, deepJade),
                ('entry.remove() called', Icons.delete_outline, 'Programmatic removal', true, richJade),
                ('Route itself popped', Icons.exit_to_app, 'All remaining entries removed', true, celadon),
                ('Route replaced', Icons.swap_horiz, 'Old route cleaned up', true, seafoam),
                ('Entry added', Icons.add, 'NOT triggered on add', false, coralAccent),
                ('Another entry popped', Icons.layers_clear, 'NOT triggered for siblings', false, amberSignal),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: trigger.$5.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(trigger.$2, size: 18, color: trigger.$5),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(trigger.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: deepJade)),
                            Text(trigger.$3,
                                style: TextStyle(
                                    fontSize: 11, color: malachite)),
                          ],
                        ),
                      ),
                      tag(trigger.$4 ? 'FIRES' : 'NO',
                          trigger.$4
                              ? deepJade.withValues(alpha: 0.1)
                              : coralAccent.withValues(alpha: 0.1),
                          trigger.$4 ? deepJade : coralAccent),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Comparison with alternatives ─────────────────────────
        sectionBanner('10 \u00b7 Comparison with Navigation Patterns',
            'Local history vs other approaches',
            deepJade, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: jadeWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepJade),
                children: [
                  for (final h in ['Approach', 'Routes', 'Back Button', 'Complexity'])
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
                ('LocalHistoryEntry', 'Same route', 'Per-entry', 'Low'),
                ('Navigator.push', 'New route', 'Pops route', 'Medium'),
                ('Nested Navigator', 'Sub-navigator', 'Sub-stack', 'High'),
                ('WillPopScope', 'N/A', 'Intercept only', 'Low'),
                ('Router / GoRouter', 'Declarative', 'Configurable', 'Medium'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: row.$1 == 'LocalHistoryEntry'
                                  ? deepJade
                                  : Colors.grey.shade700)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: richJade)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: celadon)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$4,
                          style: TextStyle(
                              fontSize: 10, color: seafoam)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Integration with ModalRoute ──────────────────────────
        sectionBanner('11 \u00b7 Integration with ModalRoute',
            'How entries connect to the route system',
            richJade, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: jadeWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in [
                ('Navigator', 'Manages route stack', deepJade),
                ('  \u2514\u2500 ModalRoute', 'Owns local history list', richJade),
                ('       \u251c\u2500 addLocalHistoryEntry()', 'Pushes entry', celadon),
                ('       \u251c\u2500 removeLocalHistoryEntry()', 'Pops entry', seafoam),
                ('       \u251c\u2500 willHandlePopInternally', 'True if entries exist', malachite),
                ('       \u2514\u2500 LocalHistoryEntry', 'The entry object', aquaMint),
                ('            \u251c\u2500 onRemove callback', 'Fires on removal', paleCeladon),
                ('            \u2514\u2500 impliesAppBarDismissal', 'Controls back icon', amberSignal),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(line.$1,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          color: line.$3)),
                ),
            ],
          ),
        ),
        noteBox(
          'ModalRoute.willHandlePopInternally returns true when there '
          'are local history entries. This tells the framework to pop '
          'local entries instead of popping the route.',
          richJade,
          jadeWhite,
        ),
        const SizedBox(height: 14),

        // ── 13. Form wizard simulation ───────────────────────────────
        sectionBanner('12 \u00b7 Form Wizard Simulation',
            'Multi-step form with per-step undo',
            celadon, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: jadeWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paleCeladon),
          ),
          child: Column(
            children: [
              for (final step in [
                (1, 'Personal Info', Icons.person, true, deepJade),
                (2, 'Address', Icons.location_on, true, richJade),
                (3, 'Payment', Icons.payment, true, celadon),
                (4, 'Review', Icons.check_circle_outline, false, coralAccent),
              ])
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: step.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: step.$5, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: step.$4
                              ? step.$5
                              : step.$5.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: step.$4
                            ? Icon(Icons.check,
                                size: 16, color: Colors.white)
                            : Text('${step.$1}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 10),
                      Icon(step.$3, size: 18, color: step.$5),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(step.$2,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: deepJade)),
                      ),
                      tag(step.$4 ? 'ENTRY' : 'CURRENT',
                          step.$4
                              ? deepJade.withValues(alpha: 0.1)
                              : coralAccent.withValues(alpha: 0.1),
                          step.$4 ? deepJade : coralAccent),
                    ],
                  ),
                ),
              const SizedBox(height: 6),
              noteBox(
                'Steps 1-3 each have a LocalHistoryEntry. Pressing back '
                'returns to the previous step. Only when step 1 is reached '
                'does back actually pop the route.',
                celadon,
                jadeWhite,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Gotchas and tips ─────────────────────────────────────
        sectionBanner('13 \u00b7 Gotchas and Best Practices',
            'Common mistakes to avoid',
            deepJade, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: jadeWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final tip in [
                ('\u26a0\ufe0f', 'Don\'t add duplicate entries', 'Track whether an entry was already added', coralAccent),
                ('\u26a0\ufe0f', 'Don\'t call remove() after route popped', 'Entry is already cleaned up', coralAccent),
                ('\u2705', 'Store entry reference for removal', 'Enables programmatic undo', deepJade),
                ('\u2705', 'Use onRemove to reset UI state', 'E.g., switch back to previous tab index', richJade),
                ('\u2705', 'Check mounted before setState', 'Callback may fire during dispose', celadon),
                ('\u2705', 'Test with PopScope too', 'Works alongside local history', seafoam),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 22,
                        child: Text(tip.$1, style: const TextStyle(fontSize: 14)),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tip.$2,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: tip.$4)),
                            Text(tip.$3,
                                style: TextStyle(
                                    fontSize: 11, color: malachite)),
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

        // ── 15. Inheritance ──────────────────────────────────────────
        sectionBanner('14 \u00b7 Inheritance Hierarchy',
            'Where LocalHistoryEntry sits in the framework',
            richJade, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: jadeWhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Object', 0, Colors.grey),
                ('\u2514\u2500 LocalHistoryEntry', 1, deepJade),
                ('     \u2514\u2500 (your subclass)', 2, celadon),
              ])
                Padding(
                  padding: EdgeInsets.only(left: level.$2 * 12.0, top: 4, bottom: 4),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'monospace',
                          fontWeight: level.$2 == 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: level.$3)),
                ),
            ],
          ),
        ),
        noteBox(
          'LocalHistoryEntry is not a widget and does not extend '
          'ChangeNotifier. It is a simple class with a VoidCallback. '
          'Subclass it to override impliesAppBarDismissal or add '
          'custom state tracking.',
          richJade,
          jadeWhite,
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepJade, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepJade, richJade],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Represents an entry in a route\'s local history stack',
                'Accepts onRemove callback for cleanup on removal',
                'Back button pops local entries before the route itself',
                'impliesAppBarDismissal controls back arrow visibility',
                'Used with ModalRoute.addLocalHistoryEntry()',
                'Perfect for tab switchers, form wizards, nested panels',
                'Lightweight alternative to pushing new routes',
                'Not a widget or notifier — just a callback container',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: aquaMint,
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

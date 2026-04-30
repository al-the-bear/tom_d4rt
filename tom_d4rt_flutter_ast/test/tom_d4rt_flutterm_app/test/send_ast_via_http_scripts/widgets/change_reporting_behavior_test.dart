// ignore_for_file: avoid_print
// Deep demo: ChangeReportingBehavior — controlling change notification propagation
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Sage Green / Ivory
// ─────────────────────────────────────────────────────────────
const Color _crSage = Color(0xFF4A7C59);
const Color _crIvory = Color(0xFFFAFAF0);
const Color _crDarkSage = Color(0xFF2E5339);
const Color _crMedSage = Color(0xFF6B9F7B);
const Color _crLightSage = Color(0xFFA8D5B8);
const Color _crWhite = Color(0xFFFFFFFF);
const Color _crDarkText = Color(0xFF2C3E2C);
const Color _crAccentOrange = Color(0xFFE65100);
const Color _crAccentBlue = Color(0xFF1565C0);
const Color _crAccentPurple = Color(0xFF6A1B9A);
const Color _crAccentTeal = Color(0xFF00796B);
const Color _crAccentRed = Color(0xFFC62828);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _crSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _crWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _crLightSage, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x154A7C59), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _crSage,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _crWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _crLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _crDarkSage,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _crBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(
            color: _crDarkText, fontSize: 12.5, height: 1.5)),
  );
}

Widget _crCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFEFF5EF),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _crLightSage.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _crDarkSage,
            height: 1.45)),
  );
}

Widget _crChip(String text, Color bg, Color fg) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(text,
        style:
            TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _crDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _crLightSage.withValues(alpha: 0.4),
  );
}

// ─────────────────────────────────────────────────────────────
// Main build
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════');
  print('  DEEP DEMO: ChangeReportingBehavior');
  print('  Controlling change notification propagation');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _crIvory,
      appBarTheme: const AppBarTheme(
        backgroundColor: _crSage,
        foregroundColor: _crWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('ChangeReportingBehavior',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Banner
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_crDarkSage, _crSage, _crMedSage],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _crWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.sync_alt,
                        color: _crWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('ChangeReportingBehavior',
                      style: TextStyle(
                          color: _crWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text(
                      'How widgets decide when to dispatch change notifications',
                      style: TextStyle(
                          color: _crWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _crChip('Notify', _crWhite.withValues(alpha: 0.25), _crWhite),
                      _crChip('Silent', _crWhite.withValues(alpha: 0.25), _crWhite),
                      _crChip('Conditional', _crWhite.withValues(alpha: 0.25), _crWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is it?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _crSection('1 · What Is ChangeReportingBehavior?', [
              _crBody(
                'ChangeReportingBehavior defines whether and when a '
                'controller, notifier, or observable should fire '
                'change notifications to its listeners. It is the '
                'policy layer between "a value changed" and "rebuild now".',
              ),
              _crLabel('Core concept'),
              _crCodeBlock(
                'ChangeReportingBehavior\n'
                '├─ always      → Notify on every mutation\n'
                '├─ silent      → Mutate without notifying\n'
                '└─ conditional → Notify only when value differs',
              ),
              _crDivider(),
              _crBody(
                'By separating mutation from notification, Flutter gives '
                'you fine-grained control over rebuilds and performance.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: Reporting modes
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _crSection('2 · The Three Reporting Modes', [
              ..._buildReportingModes(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Notification flow
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _crSection('3 · Notification Flow Diagram', [
              _crBody(
                'How a mutation flows through the reporting pipeline:',
              ),
              _buildNotificationFlow(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Widget rebuilds
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _crSection('4 · Widget Rebuilds and Reporting', [
              _crBody(
                'The reporting behavior directly affects how many times '
                'widgets rebuild in a frame.',
              ),
              _buildRebuildComparison(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: Why suppress
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _crSection('5 · Why Suppress Notifications?', [
              _crBody(
                'Not every mutation needs a rebuild. Sometimes you need to '
                'update multiple values without triggering intermediate '
                'builds.',
              ),
              _buildSuppressReasons(),
              _crDivider(),
              _crLabel('Code pattern'),
              _crCodeBlock(
                '// Without suppression: 3 rebuilds\n'
                'controller.name = newName;   // rebuild!\n'
                'controller.age = newAge;     // rebuild!\n'
                'controller.email = newEmail; // rebuild!\n'
                '\n'
                '// With silent mode: 0 rebuilds + 1 manual\n'
                'controller.reporting = silent;\n'
                'controller.name = newName;   // no rebuild\n'
                'controller.age = newAge;     // no rebuild\n'
                'controller.email = newEmail; // no rebuild\n'
                'controller.reporting = always;\n'
                'controller.notifyListeners(); // 1 rebuild',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: Batch updates
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _crSection('6 · Batch Updates Pattern', [
              _crBody(
                'Batch updates combine silent mode with explicit '
                'notification to achieve atomic multi-field updates.',
              ),
              _buildBatchUpdateFlow(),
              _crDivider(),
              _crCodeBlock(
                'void updateProfile({\n'
                '  required String name,\n'
                '  required int age,\n'
                '  required String bio,\n'
                '}) {\n'
                '  beginBatchUpdate();   // sets silent\n'
                '  this.name = name;\n'
                '  this.age = age;\n'
                '  this.bio = bio;\n'
                '  endBatchUpdate();     // restores + notify\n'
                '}',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Per-field reporting
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _crSection('7 · Per-Field Reporting Scenarios', [
              _crBody(
                'Different fields may need different reporting behaviors '
                'depending on how expensive their dependent widgets are.',
              ),
              _buildFieldReportingTable(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Observable state pattern
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _crSection('8 · Observable State Integration', [
              _crBody(
                'Many state management patterns incorporate change '
                'reporting to optimize reactivity.',
              ),
              ..._buildObservableStateCards(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Comparison table
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _crSection('9 · Comparison: Always vs Silent vs Conditional', [
              _buildComparisonTable(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Real-world form scenario
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _crSection('10 · Real-World: Profile Editor Form', [
              _crBody(
                'A profile editor where different fields have different '
                'reporting strategies to minimize unnecessary rebuilds.',
              ),
              _buildProfileEditorDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Anti-patterns
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _crSection('11 · Anti-Patterns to Avoid', [
              ..._buildAntiPatterns(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _crSection('12 · Summary', [
              _crBody(
                'ChangeReportingBehavior gives you precise control '
                'over when change notifications fire.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_crSage, _crMedSage],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _crSummaryRow(Icons.notifications_active, 'Always mode: immediate rebuild on every change'),
                    _crSummaryRow(Icons.notifications_off, 'Silent mode: mutate without triggering rebuilds'),
                    _crSummaryRow(Icons.filter_alt, 'Conditional mode: only notify when value differs'),
                    _crSummaryRow(Icons.batch_prediction, 'Batch updates: silent → mutate → notify once'),
                    _crSummaryRow(Icons.speed, 'Performance: reduce unnecessary widget rebuilds'),
                    _crSummaryRow(Icons.architecture, 'Architecture: separate mutation from notification'),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 2: Reporting modes
// ─────────────────────────────────────────────────────────────
List<Widget> _buildReportingModes() {
  final modes = <Map<String, dynamic>>[
    {
      'mode': 'Always',
      'desc': 'Every mutation fires notifyListeners(). Simplest, '
          'most predictable. Default for most controllers.',
      'icon': Icons.notifications_active,
      'color': _crAccentOrange,
      'code': 'set value(T newVal) {\n  _value = newVal;\n  notifyListeners(); // Always\n}',
    },
    {
      'mode': 'Silent',
      'desc': 'Mutations update the value but skip notifications. '
          'Useful for batch updates.',
      'icon': Icons.notifications_off,
      'color': _crAccentTeal,
      'code': 'set value(T newVal) {\n  _value = newVal;\n  // No notification — caller controls\n}',
    },
    {
      'mode': 'Conditional',
      'desc': 'Only notifies when the new value differs from the '
          'old value. Prevents redundant rebuilds.',
      'icon': Icons.filter_alt,
      'color': _crAccentPurple,
      'code': 'set value(T newVal) {\n  if (_value != newVal) {\n    _value = newVal;\n    notifyListeners();\n  }\n}',
    },
  ];

  return modes.map((m) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (m['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: (m['color'] as Color).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: m['color'] as Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(m['icon'] as IconData,
                    color: _crWhite, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(m['mode'] as String,
                    style: TextStyle(
                        color: m['color'] as Color,
                        fontSize: 14,
                        fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(m['desc'] as String,
              style: const TextStyle(
                  color: _crDarkText, fontSize: 11.5, height: 1.4)),
          const SizedBox(height: 8),
          _crCodeBlock(m['code'] as String),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 3: Notification flow
// ─────────────────────────────────────────────────────────────
Widget _buildNotificationFlow() {
  final steps = <Map<String, dynamic>>[
    {'label': 'Setter called', 'icon': Icons.edit, 'color': _crAccentBlue},
    {'label': 'Check behavior', 'icon': Icons.rule, 'color': _crSage},
    {'label': 'Always → notify', 'icon': Icons.notifications_active, 'color': _crAccentOrange},
    {'label': 'Silent → skip', 'icon': Icons.notifications_off, 'color': _crAccentTeal},
    {'label': 'Conditional → diff?', 'icon': Icons.compare_arrows, 'color': _crAccentPurple},
    {'label': 'Listeners rebuild', 'icon': Icons.refresh, 'color': _crAccentRed},
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _crIvory,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _crLightSage),
    ),
    child: Column(
      children: steps.asMap().entries.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: entry.value['color'] as Color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(entry.value['icon'] as IconData,
                    color: _crWhite, size: 14),
              ),
              const SizedBox(width: 10),
              Container(
                width: 20,
                alignment: Alignment.center,
                child: Text('${entry.key + 1}',
                    style: const TextStyle(
                        color: _crDarkSage,
                        fontSize: 10,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: (entry.value['color'] as Color)
                        .withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: (entry.value['color'] as Color)
                            .withValues(alpha: 0.3)),
                  ),
                  child: Text(entry.value['label'] as String,
                      style: TextStyle(
                          color: entry.value['color'] as Color,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 4: Rebuild comparison
// ─────────────────────────────────────────────────────────────
Widget _buildRebuildComparison() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _crIvory,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _crLightSage),
    ),
    child: Row(
      children: [
        Expanded(
          child: _crComparisonCard(
            'Always Mode',
            '3 mutations → 3 rebuilds',
            ['set name → rebuild', 'set age → rebuild', 'set email → rebuild'],
            _crAccentOrange,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _crComparisonCard(
            'Batch / Silent',
            '3 mutations → 1 rebuild',
            ['set name → (silent)', 'set age → (silent)', 'set email → notify'],
            _crAccentTeal,
          ),
        ),
      ],
    ),
  );
}

Widget _crComparisonCard(
    String title, String subtitle, List<String> items, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: color, fontSize: 12, fontWeight: FontWeight.w700)),
        Text(subtitle,
            style: const TextStyle(color: _crDarkText, fontSize: 10)),
        const SizedBox(height: 6),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(item,
                        style: const TextStyle(
                            color: _crDarkText,
                            fontSize: 10,
                            fontFamily: 'monospace')),
                  ),
                ],
              ),
            )),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 5: Suppress reasons
// ─────────────────────────────────────────────────────────────
Widget _buildSuppressReasons() {
  final reasons = <Map<String, dynamic>>[
    {'reason': 'Batch updates', 'desc': 'Set 5 fields, notify once', 'icon': Icons.batch_prediction, 'color': _crAccentBlue},
    {'reason': 'Initialization', 'desc': 'Set defaults without rebuilds', 'icon': Icons.play_arrow, 'color': _crSage},
    {'reason': 'Undo / Redo', 'desc': 'Restore state silently first', 'icon': Icons.undo, 'color': _crAccentPurple},
    {'reason': 'Server sync', 'desc': 'Apply API response atomically', 'icon': Icons.cloud_download, 'color': _crAccentTeal},
    {'reason': 'Animation frames', 'desc': 'Avoid mid-tween rebuilds', 'icon': Icons.animation, 'color': _crAccentOrange},
  ];

  return Column(
    children: reasons.map((r) {
      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (r['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: (r['color'] as Color).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: r['color'] as Color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(r['icon'] as IconData,
                  color: _crWhite, size: 14),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r['reason'] as String,
                      style: TextStyle(
                          color: r['color'] as Color,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.5)),
                  Text(r['desc'] as String,
                      style: const TextStyle(
                          color: _crDarkText, fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 6: Batch update flow
// ─────────────────────────────────────────────────────────────
Widget _buildBatchUpdateFlow() {
  final steps = <Map<String, dynamic>>[
    {'step': 'Begin', 'desc': 'Save current behavior, set to silent', 'icon': Icons.lock, 'color': _crAccentBlue},
    {'step': 'Mutate 1', 'desc': 'controller.name = "Alice"', 'icon': Icons.edit, 'color': _crSage},
    {'step': 'Mutate 2', 'desc': 'controller.age = 30', 'icon': Icons.edit, 'color': _crSage},
    {'step': 'Mutate 3', 'desc': 'controller.bio = "Engineer"', 'icon': Icons.edit, 'color': _crSage},
    {'step': 'End', 'desc': 'Restore behavior, notifyListeners()', 'icon': Icons.lock_open, 'color': _crAccentOrange},
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _crIvory,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _crLightSage),
    ),
    child: Column(
      children: steps.asMap().entries.map((entry) {
        final s = entry.value;
        return Container(
          margin: const EdgeInsets.only(bottom: 6),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: s['color'] as Color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('${entry.key + 1}',
                      style: const TextStyle(
                          color: _crWhite,
                          fontSize: 11,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (s['color'] as Color).withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: (s['color'] as Color).withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(s['icon'] as IconData,
                          size: 16, color: s['color'] as Color),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(s['step'] as String,
                                style: TextStyle(
                                    color: s['color'] as Color,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700)),
                            Text(s['desc'] as String,
                                style: const TextStyle(
                                    color: _crDarkText, fontSize: 9.5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 7: Field reporting table
// ─────────────────────────────────────────────────────────────
Widget _buildFieldReportingTable() {
  final rows = <List<String>>[
    ['Field', 'Behavior', 'Reason'],
    ['username', 'Conditional', 'Only rebuild if actually changed'],
    ['avatar', 'Always', 'Image cache may differ per URL'],
    ['theme', 'Always', 'Must rebuild entire subtree'],
    ['scrollOffset', 'Silent', 'Animation handles its own frames'],
    ['lastSynced', 'Silent', 'Only metadata, not visible'],
    ['itemCount', 'Conditional', 'Rebuild list only if size changed'],
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _crLightSage),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          color: isHeader
              ? _crSage
              : entry.key.isEven
                  ? _crIvory
                  : _crWhite,
          child: Row(
            children: entry.value.asMap().entries.map((col) {
              return Expanded(
                flex: col.key == 2 ? 3 : 2,
                child: Text(col.value,
                    style: TextStyle(
                        color: isHeader ? _crWhite : _crDarkText,
                        fontSize: isHeader ? 11 : 10.5,
                        fontWeight:
                            isHeader ? FontWeight.w700 : FontWeight.w400,
                        fontFamily: col.key == 0 ? 'monospace' : null)),
              );
            }).toList(),
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 8: Observable state cards
// ─────────────────────────────────────────────────────────────
List<Widget> _buildObservableStateCards() {
  final patterns = <Map<String, dynamic>>[
    {
      'name': 'ChangeNotifier',
      'desc': 'Flutter core. Always reporting by default. '
          'Call notifyListeners() explicitly.',
      'icon': Icons.foundation,
      'color': _crAccentBlue,
    },
    {
      'name': 'ValueNotifier<T>',
      'desc': 'Conditional by default — only notifies when '
          'value != old value using == operator.',
      'icon': Icons.data_object,
      'color': _crSage,
    },
    {
      'name': 'StreamController',
      'desc': 'Always mode — every add() fires. Use '
          'distinct() for conditional behavior.',
      'icon': Icons.stream,
      'color': _crAccentPurple,
    },
    {
      'name': 'BLoC / Cubit',
      'desc': 'Conditional via Equatable. State emission '
          'skipped if new state == current state.',
      'icon': Icons.architecture,
      'color': _crAccentTeal,
    },
  ];

  return patterns.map((p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (p['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: (p['color'] as Color).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: p['color'] as Color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(p['icon'] as IconData,
                color: _crWhite, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['name'] as String,
                    style: TextStyle(
                        color: p['color'] as Color,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                Text(p['desc'] as String,
                    style: const TextStyle(
                        color: _crDarkText,
                        fontSize: 10.5,
                        height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 9: Comparison table
// ─────────────────────────────────────────────────────────────
Widget _buildComparisonTable() {
  final rows = <List<String>>[
    ['Aspect', 'Always', 'Silent', 'Conditional'],
    ['Notification', 'Every setter', 'Never auto', 'Only on diff'],
    ['Rebuilds', '1 per mutation', '0', '0 or 1'],
    ['Complexity', 'Simple', 'Manual notify', 'Needs == op'],
    ['Performance', 'Can thrash', 'Optimal batch', 'Optimal single'],
    ['Use case', 'Most fields', 'Batch/init', 'Frequent sets'],
    ['Default in', 'ChangeNotifier', '(manual)', 'ValueNotifier'],
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _crLightSage),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
          color: isHeader
              ? _crSage
              : entry.key.isEven
                  ? _crIvory
                  : _crWhite,
          child: Row(
            children: entry.value.asMap().entries.map((col) {
              return Expanded(
                flex: col.key == 0 ? 2 : 2,
                child: Text(col.value,
                    style: TextStyle(
                        color: isHeader ? _crWhite : _crDarkText,
                        fontSize: 10,
                        fontWeight:
                            isHeader ? FontWeight.w700 : FontWeight.w400)),
              );
            }).toList(),
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 10: Profile editor demo
// ─────────────────────────────────────────────────────────────
Widget _buildProfileEditorDemo() {
  final fields = <Map<String, dynamic>>[
    {'field': 'Display Name', 'value': 'Alice Chen', 'behavior': 'Always', 'rebuilds': 'Header, sidebar', 'color': _crAccentOrange},
    {'field': 'Bio', 'value': 'Flutter developer & designer', 'behavior': 'Conditional', 'rebuilds': 'Profile card only', 'color': _crAccentPurple},
    {'field': 'Theme Pref', 'value': 'Dark', 'behavior': 'Always', 'rebuilds': 'Entire app', 'color': _crAccentBlue},
    {'field': 'Last Login', 'value': '2026-04-08 09:30', 'behavior': 'Silent', 'rebuilds': 'None (metadata)', 'color': _crAccentTeal},
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _crLightSage),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          color: _crSage,
          child: const Row(
            children: [
              Icon(Icons.person, color: _crWhite, size: 16),
              SizedBox(width: 8),
              Text('Profile Editor',
                  style: TextStyle(
                      color: _crWhite,
                      fontSize: 12,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        ...fields.map((f) {
          return Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: _crLightSage.withValues(alpha: 0.3))),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(f['field'] as String,
                      style: const TextStyle(
                          color: _crDarkSage,
                          fontSize: 10,
                          fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _crIvory,
                      borderRadius: BorderRadius.circular(4),
                      border:
                          Border.all(color: _crLightSage),
                    ),
                    child: Text(f['value'] as String,
                        style: const TextStyle(
                            color: _crDarkText,
                            fontSize: 10.5,
                            fontFamily: 'monospace')),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: (f['color'] as Color)
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(f['behavior'] as String,
                      style: TextStyle(
                          color: f['color'] as Color,
                          fontSize: 9,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          );
        }),
        Container(
          padding: const EdgeInsets.all(10),
          color: _crIvory,
          child: const Text(
              'Each field uses the reporting behavior best suited to its rebuild cost',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: _crSage,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 11: Anti-patterns
// ─────────────────────────────────────────────────────────────
List<Widget> _buildAntiPatterns() {
  final antiPatterns = <Map<String, dynamic>>[
    {
      'bad': 'Forgetting to notify after silent batch',
      'fix': 'Always use beginBatch/endBatch pattern',
      'icon': Icons.warning,
    },
    {
      'bad': 'Using always for high-frequency updates (scroll, animation)',
      'fix': 'Use silent or throttled notification',
      'icon': Icons.speed,
    },
    {
      'bad': 'Conditional with mutable objects (list, map)',
      'fix': 'Override == or use immutable types',
      'icon': Icons.bug_report,
    },
    {
      'bad': 'Mixing behaviors without documentation',
      'fix': 'Annotate each field with its reporting policy',
      'icon': Icons.description,
    },
  ];

  return antiPatterns.map((ap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _crAccentRed.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _crAccentRed.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(ap['icon'] as IconData,
                  size: 16, color: _crAccentRed),
              const SizedBox(width: 8),
              Expanded(
                child: Text(ap['bad'] as String,
                    style: const TextStyle(
                        color: _crAccentRed,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.check_circle,
                  size: 14, color: _crAccentTeal),
              const SizedBox(width: 8),
              Expanded(
                child: Text(ap['fix'] as String,
                    style: const TextStyle(
                        color: _crAccentTeal,
                        fontSize: 10.5)),
              ),
            ],
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Summary row helper
// ─────────────────────────────────────────────────────────────
Widget _crSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _crWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _crWhite.withValues(alpha: 0.95),
                  fontSize: 12.5)),
        ),
      ],
    ),
  );
}

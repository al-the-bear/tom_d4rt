// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — AutovalidateMode
// Demonstrates AutovalidateMode, the enum controlling when form field
// validation runs. Covers all three modes (disabled, always,
// onUserInteraction), live form demos, form-level vs field-level
// autovalidation, and real-world validation patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AutovalidateMode Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is AutovalidateMode?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.verified,
      'title': 'Form Validation in Flutter',
      'body': 'Flutter forms use validators — functions that return an '
          'error string or null. The question is: WHEN should validation '
          'run? On every keystroke? Only when the user submits? Only '
          'after the user has interacted with the field? '
          'AutovalidateMode answers this question.',
      'accent': Colors.amber[800]!,
    },
    {
      'icon': Icons.timer,
      'title': 'Timing Matters for UX',
      'body': 'Showing errors immediately on an empty form is confusing '
          '— the user hasn\'t even typed yet. But waiting until submit '
          'means delayed feedback. AutovalidateMode gives you three '
          'strategies to balance between eager and lazy validation.',
      'accent': Colors.orange[800]!,
    },
    {
      'icon': Icons.tune,
      'title': 'Three Modes',
      'body': 'disabled: validation only runs when you call validate() '
          'manually (e.g., on form submit). always: validates on every '
          'rebuild. onUserInteraction: validates after the user has '
          'first interacted with the field — the best of both worlds.',
      'accent': Colors.amber[900]!,
    },
    {
      'icon': Icons.layers,
      'title': 'Form-Level & Field-Level',
      'body': 'AutovalidateMode works at two levels. Form has its own '
          'autovalidateMode affecting all fields. Each FormField/TextFormField '
          'can also have its own mode, overriding the form\'s setting '
          'for that specific field.',
      'accent': Colors.brown,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  final conceptWidgets = conceptCards.map<Widget>((card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (card['accent'] as Color).withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (card['accent'] as Color).withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(card['icon'] as IconData,
              color: card['accent'] as Color, size: 32),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card['title'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: card['accent'] as Color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  card['body'] as String,
                  style: const TextStyle(fontSize: 13, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 2: API Surface — The Three Enum Values
  // ============================================================
  print('=== Section 2: API Surface ===');

  final modeDetails = <Map<String, dynamic>>[
    {
      'mode': 'AutovalidateMode.disabled',
      'icon': Icons.block,
      'color': Colors.grey[700]!,
      'summary': 'Manual validation only',
      'behavior': 'Validation runs only when you explicitly call '
          'FormState.validate() or FormFieldState.validate(). No '
          'automatic validation on user interaction or rebuild.',
      'useCase': 'Forms where you want full control, or where validation '
          'is expensive (API calls, complex computation).',
    },
    {
      'mode': 'AutovalidateMode.always',
      'icon': Icons.visibility,
      'color': Colors.red[700]!,
      'summary': 'Validate on every rebuild',
      'behavior': 'The field is validated every time the widget rebuilds. '
          'This means errors appear immediately, even before the user '
          'has typed anything. Can be overwhelming for new users.',
      'useCase': 'Real-time feedback forms, or fields that start with '
          'a pre-filled value that might be invalid.',
    },
    {
      'mode': 'AutovalidateMode.onUserInteraction',
      'icon': Icons.touch_app,
      'color': Colors.amber[800]!,
      'summary': 'Validate after first interaction',
      'behavior': 'Validation starts only after the user has interacted '
          'with the field (typed, focused, changed). Before interaction, '
          'no error is shown. After interaction, validates on every change.',
      'useCase': 'Registration forms, settings pages — friendly UX that '
          'doesn\'t show errors for untouched fields.',
    },
  ];

  final modeWidgets = modeDetails.map<Widget>((mode) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (mode['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (mode['color'] as Color).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: (mode['color'] as Color).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(mode['icon'] as IconData,
                    color: mode['color'] as Color, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mode['mode'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: mode['color'] as Color,
                      ),
                    ),
                    Text(
                      mode['summary'] as String,
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (mode['color'] as Color).withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Behavior:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 3),
                Text(
                  mode['behavior'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Best For:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 3),
                Text(
                  mode['useCase'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 3: Live Form Demos — Three Modes Side by Side
  // ============================================================
  print('=== Section 3: Live Form Demos ===');

  // Helper to build a mini form with a given AutovalidateMode
  Widget buildMiniForm({
    required String label,
    required AutovalidateMode mode,
    required Color accent,
    required IconData icon,
    required String modeName,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Form(
        autovalidateMode: mode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: accent, size: 22),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.08),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                modeName,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: accent,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'user@example.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: accent, width: 2),
                ),
                prefixIcon: Icon(Icons.email, color: accent, size: 20),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!value.contains('@')) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Min 8 characters',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: accent, width: 2),
                ),
                prefixIcon: Icon(Icons.lock, color: accent, size: 20),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final disabledForm = buildMiniForm(
    label: 'Mode: disabled',
    mode: AutovalidateMode.disabled,
    accent: Colors.grey[700]!,
    icon: Icons.block,
    modeName: 'AutovalidateMode.disabled',
  );

  final alwaysForm = buildMiniForm(
    label: 'Mode: always',
    mode: AutovalidateMode.always,
    accent: Colors.red[700]!,
    icon: Icons.visibility,
    modeName: 'AutovalidateMode.always',
  );

  final onInteractionForm = buildMiniForm(
    label: 'Mode: onUserInteraction',
    mode: AutovalidateMode.onUserInteraction,
    accent: Colors.amber[800]!,
    icon: Icons.touch_app,
    modeName: 'AutovalidateMode.onUserInteraction',
  );

  // ============================================================
  // SECTION 4: Mode Comparison Table
  // ============================================================
  print('=== Section 4: Mode Comparison Table ===');

  final comparisonData = <Map<String, String>>[
    {
      'scenario': 'Initial load',
      'disabled': 'No errors shown',
      'always': 'Errors shown immediately',
      'onInteraction': 'No errors shown',
    },
    {
      'scenario': 'Before user types',
      'disabled': 'No errors',
      'always': 'Required field errors',
      'onInteraction': 'No errors',
    },
    {
      'scenario': 'During typing',
      'disabled': 'No errors',
      'always': 'Real-time validation',
      'onInteraction': 'Real-time validation',
    },
    {
      'scenario': 'After clearing field',
      'disabled': 'No errors',
      'always': 'Required field error',
      'onInteraction': 'Required field error',
    },
    {
      'scenario': 'On submit button',
      'disabled': 'Errors shown (manual)',
      'always': 'Already showing',
      'onInteraction': 'Shows untouched errors',
    },
  ];

  final tableHeader = Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.amber[800],
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text('Scenario',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11)),
        ),
        Expanded(
          child: Text('disabled',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[300],
                  fontWeight: FontWeight.bold,
                  fontSize: 11)),
        ),
        Expanded(
          child: Text('always',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red[100],
                  fontWeight: FontWeight.bold,
                  fontSize: 11)),
        ),
        Expanded(
          child: Text('onInteraction',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.amber[100],
                  fontWeight: FontWeight.bold,
                  fontSize: 11)),
        ),
      ],
    ),
  );

  final tableRows = comparisonData.asMap().entries.map<Widget>((entry) {
    final i = entry.key;
    final row = entry.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: i.isEven
            ? Colors.amber.withOpacity(0.04)
            : Colors.amber.withOpacity(0.09),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(row['scenario']!,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 10)),
          ),
          Expanded(
            child: Text(row['disabled']!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10, color: Colors.grey[700])),
          ),
          Expanded(
            child: Text(row['always']!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.red[600])),
          ),
          Expanded(
            child: Text(row['onInteraction']!,
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 10, color: Colors.amber[900])),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 5: Real-World Form Patterns
  // ============================================================
  print('=== Section 5: Real-World Form Patterns ===');

  final formPatterns = <Map<String, dynamic>>[
    {
      'title': 'Registration Form',
      'mode': 'onUserInteraction',
      'icon': Icons.person_add,
      'color': Colors.amber[800]!,
      'desc': 'Users fill many fields. Showing errors on untouched '
          'fields is overwhelming. onUserInteraction validates only '
          'after the user starts typing in each field.',
      'fields': ['Name', 'Email', 'Password', 'Confirm Password'],
    },
    {
      'title': 'Quick Search Form',
      'mode': 'disabled',
      'icon': Icons.search,
      'color': Colors.grey[700]!,
      'desc': 'Search forms rarely need inline validation. Just validate '
          'on submit if needed. Disabled mode avoids unnecessary '
          'validation overhead during rapid typing.',
      'fields': ['Search query'],
    },
    {
      'title': 'Settings / Preferences',
      'mode': 'always',
      'icon': Icons.settings,
      'color': Colors.red[600]!,
      'desc': 'Fields start pre-filled with current settings. If the '
          'user changes something to an invalid value, show the error '
          'immediately. Always mode catches invalid changes in real time.',
      'fields': ['Max items', 'Timeout (seconds)', 'Custom URL'],
    },
    {
      'title': 'Payment Form',
      'mode': 'onUserInteraction',
      'icon': Icons.payment,
      'color': Colors.green[700]!,
      'desc': 'Payment forms need careful validation but shouldn\'t scare '
          'users with errors before they start. Validate card number '
          'format, expiry, CVV as the user fills each field.',
      'fields': ['Card number', 'Expiry', 'CVV', 'Name on card'],
    },
    {
      'title': 'Admin Data Entry',
      'mode': 'always',
      'icon': Icons.admin_panel_settings,
      'color': Colors.purple[700]!,
      'desc': 'Admin forms often receive pasted or imported data. '
          'Always mode ensures every field is validated immediately, '
          'catching issues with pre-filled or pasted values.',
      'fields': ['User ID', 'Role', 'Permissions', 'Expiry date'],
    },
  ];

  final patternCards = formPatterns.map<Widget>((pattern) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (pattern['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (pattern['color'] as Color).withOpacity(0.25),
        ),
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
                  color: (pattern['color'] as Color).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(pattern['icon'] as IconData,
                    color: pattern['color'] as Color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pattern['title'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: pattern['color'] as Color,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: (pattern['color'] as Color)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        pattern['mode'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: pattern['color'] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            pattern['desc'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children:
                (pattern['fields'] as List<String>).map<Widget>((f) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(f,
                    style:
                        const TextStyle(fontSize: 10, fontFamily: 'monospace')),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 6: Form-Level vs Field-Level
  // ============================================================
  print('=== Section 6: Form-Level vs Field-Level ===');

  // Live form showing mixed autovalidation modes
  final mixedForm = Form(
    autovalidateMode: AutovalidateMode.disabled,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.layers, color: Colors.amber[800], size: 22),
              const SizedBox(width: 8),
              Text(
                'Mixed-Mode Form',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Form level: disabled — each field overrides individually',
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
          const SizedBox(height: 14),
          TextFormField(
            autovalidateMode: AutovalidateMode.always,
            decoration: InputDecoration(
              labelText: 'Username (always)',
              helperText: 'Validates immediately',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red[600]!, width: 2),
              ),
              prefixIcon: Container(
                width: 40,
                alignment: Alignment.center,
                child: Text('A',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red[600],
                      fontSize: 16,
                    )),
              ),
            ),
            validator: (v) =>
                (v == null || v.isEmpty) ? 'Username required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: 'Email (onUserInteraction)',
              helperText: 'Validates after first edit',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: Colors.amber[800]!, width: 2),
              ),
              prefixIcon: Container(
                width: 40,
                alignment: Alignment.center,
                child: Text('I',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[800],
                      fontSize: 16,
                    )),
              ),
            ),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Email required';
              if (!v.contains('@')) return 'Invalid email';
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            autovalidateMode: AutovalidateMode.disabled,
            decoration: InputDecoration(
              labelText: 'Notes (disabled)',
              helperText: 'Validates only on submit',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: Colors.grey[600]!, width: 2),
              ),
              prefixIcon: Container(
                width: 40,
                alignment: Alignment.center,
                child: Text('D',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      fontSize: 16,
                    )),
              ),
            ),
            validator: (v) =>
                (v != null && v.length > 100) ? 'Max 100 chars' : null,
          ),
        ],
      ),
    ),
  );

  // Precedence explanation
  final precedenceRules = <Map<String, dynamic>>[
    {
      'rule': 'Field-level overrides form-level',
      'detail': 'When a FormField specifies autovalidateMode, it uses '
          'that value regardless of the Form\'s setting.',
      'icon': Icons.arrow_upward,
      'color': Colors.amber[800]!,
    },
    {
      'rule': 'Form-level is the default',
      'detail': 'If a FormField doesn\'t specify autovalidateMode, it '
          'inherits from the parent Form widget.',
      'icon': Icons.arrow_downward,
      'color': Colors.blue[700]!,
    },
    {
      'rule': 'No Form → disabled',
      'detail': 'A TextFormField outside of a Form with no explicit '
          'autovalidateMode defaults to disabled.',
      'icon': Icons.block,
      'color': Colors.grey[600]!,
    },
  ];

  final precedenceWidgets = precedenceRules.map<Widget>((rule) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: (rule['color'] as Color).withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: rule['color'] as Color,
            width: 3,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(rule['icon'] as IconData,
              color: rule['color'] as Color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rule['rule'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: rule['color'] as Color,
                  ),
                ),
                Text(
                  rule['detail'] as String,
                  style: const TextStyle(fontSize: 11, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 7: Validation Timing Diagram
  // ============================================================
  print('=== Section 7: Validation Timing Diagram ===');

  final timelineEvents = <Map<String, dynamic>>[
    {
      'event': 'Widget builds for the first time',
      'disabled': '—',
      'always': 'Validates',
      'onInteraction': '—',
    },
    {
      'event': 'User focuses the field',
      'disabled': '—',
      'always': 'Validates',
      'onInteraction': '—',
    },
    {
      'event': 'User types first character',
      'disabled': '—',
      'always': 'Validates',
      'onInteraction': 'Validates',
    },
    {
      'event': 'User continues typing',
      'disabled': '—',
      'always': 'Validates',
      'onInteraction': 'Validates',
    },
    {
      'event': 'User clears the field',
      'disabled': '—',
      'always': 'Validates',
      'onInteraction': 'Validates',
    },
    {
      'event': 'User moves to next field',
      'disabled': '—',
      'always': 'Validates',
      'onInteraction': 'Validates',
    },
    {
      'event': 'FormState.validate() called',
      'disabled': 'Validates',
      'always': 'Validates',
      'onInteraction': 'Validates',
    },
  ];

  final timelineWidgets = timelineEvents.map<Widget>((te) {
    Widget statusBadge(String text) {
      final isValidates = text == 'Validates';
      return Container(
        width: 60,
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: isValidates
              ? Colors.amber.withOpacity(0.15)
              : Colors.grey.withOpacity(0.08),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9,
            fontWeight: isValidates ? FontWeight.bold : FontWeight.normal,
            color: isValidates ? Colors.amber[900] : Colors.grey[500],
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.03),
        border: Border(
          bottom: BorderSide(color: Colors.amber.withOpacity(0.1)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              te['event'] as String,
              style: const TextStyle(fontSize: 11),
            ),
          ),
          statusBadge(te['disabled'] as String),
          const SizedBox(width: 4),
          statusBadge(te['always'] as String),
          const SizedBox(width: 4),
          statusBadge(te['onInteraction'] as String),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 8: Common Patterns and Pitfalls
  // ============================================================
  print('=== Section 8: Patterns & Pitfalls ===');

  final tips = <Map<String, dynamic>>[
    {
      'type': 'pattern',
      'title': 'Start disabled, switch to onUserInteraction on submit',
      'detail': 'A popular pattern: set mode to disabled initially. On '
          'first submit, if validation fails, switch to onUserInteraction '
          'so errors update in real time as the user fixes them.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'Use onUserInteraction for most forms',
      'detail': 'Best balance between UX and validation feedback. Users '
          'see errors only after interacting, preventing the jarring '
          'experience of errors on page load.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'Combine with onChanged for complex validation',
      'detail': 'For fields that need debounced async validation (e.g., '
          'username availability), use disabled mode with manual '
          'validation triggered by onChanged + debounce timer.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pitfall',
      'title': 'Don\'t use always for empty forms',
      'detail': 'always mode validates on first build. For empty '
          'registration forms, this shows "required" errors on every '
          'field before the user has done anything — very poor UX.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
    {
      'type': 'pitfall',
      'title': 'Don\'t forget FormState.validate() with disabled mode',
      'detail': 'In disabled mode, errors never show unless you '
          'explicitly call validate(). If you forget to call it on submit, '
          'the form silently accepts invalid data.',
      'icon': Icons.error_outline,
      'color': Colors.red,
    },
    {
      'type': 'pitfall',
      'title': 'Expensive validators in always mode',
      'detail': 'always mode runs validators on every rebuild. If your '
          'validator makes API calls or heavy computation, use disabled '
          'mode with manual triggering instead.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
  ];

  final tipWidgets = tips.map<Widget>((tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (tip['color'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(
            color: tip['color'] as Color,
            width: 4,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(tip['icon'] as IconData,
              color: tip['color'] as Color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: (tip['color'] as Color).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        (tip['type'] as String).toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: tip['color'] as Color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        tip['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: tip['color'] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  tip['detail'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 9: Summary Dashboard
  // ============================================================
  print('=== Section 9: Summary Dashboard ===');

  final summaryItems = <Map<String, dynamic>>[
    {'label': 'Validation modes', 'value': '3', 'icon': Icons.tune},
    {'label': 'Live form demos', 'value': '4', 'icon': Icons.web},
    {'label': 'Comparison scenarios', 'value': '${comparisonData.length}', 'icon': Icons.compare},
    {'label': 'Real-world patterns', 'value': '${formPatterns.length}', 'icon': Icons.pattern},
    {'label': 'Timeline events', 'value': '${timelineEvents.length}', 'icon': Icons.timeline},
    {'label': 'Patterns & pitfalls', 'value': '${tips.length}', 'icon': Icons.lightbulb},
  ];

  final summaryGrid = Wrap(
    spacing: 10,
    runSpacing: 10,
    children: summaryItems.map<Widget>((item) {
      return Container(
        width: 155,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber.withOpacity(0.15),
              Colors.amber.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.amber.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(item['icon'] as IconData, color: Colors.amber[800], size: 24),
            const SizedBox(height: 6),
            Text(
              item['value'] as String,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.amber[900],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item['label'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }).toList(),
  );

  // ============================================================
  // Helper: Section header
  // ============================================================
  Widget avSectionHeader(String number, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 28, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber[800]!, Colors.amber[500]!],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  print('AutovalidateMode Deep Demo — building final layout');

  // ============================================================
  // FINAL LAYOUT
  // ============================================================
  return Scaffold(
    appBar: AppBar(
      title: const Text('AutovalidateMode'),
      backgroundColor: Colors.amber[800],
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber[800]!, Colors.amber[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.verified, color: Colors.white, size: 40),
                const SizedBox(height: 10),
                const Text(
                  'AutovalidateMode',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'An enum that controls when form field validation runs: '
                  'disabled (manual only), always (every rebuild), or '
                  'onUserInteraction (after first touch). The right choice '
                  'balances UX with validation feedback.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Section 1
          avSectionHeader('1', 'Concept', Icons.lightbulb),
          ...conceptWidgets,

          // Section 2
          avSectionHeader('2', 'The Three Modes', Icons.tune),
          ...modeWidgets,

          // Section 3
          avSectionHeader('3', 'Live Form Demos', Icons.web),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Three identical forms with different AutovalidateMode. '
              'Try typing in each to see how validation timing differs:',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
          disabledForm,
          alwaysForm,
          onInteractionForm,

          // Section 4
          avSectionHeader('4', 'Mode Comparison', Icons.compare),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber.withOpacity(0.3)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                tableHeader,
                ...tableRows,
              ],
            ),
          ),

          // Section 5
          avSectionHeader('5', 'Real-World Patterns', Icons.pattern),
          ...patternCards,

          // Section 6
          avSectionHeader('6', 'Form vs Field Level', Icons.layers),
          ...precedenceWidgets,
          const SizedBox(height: 12),
          mixedForm,

          // Section 7
          avSectionHeader('7', 'Validation Timing', Icons.timeline),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber.withOpacity(0.2)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  color: Colors.amber.withOpacity(0.1),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text('Event',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.amber[900]))),
                      SizedBox(
                          width: 60,
                          child: Text('disabled',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                  color: Colors.grey[700]))),
                      const SizedBox(width: 4),
                      SizedBox(
                          width: 60,
                          child: Text('always',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                  color: Colors.red[700]))),
                      const SizedBox(width: 4),
                      SizedBox(
                          width: 60,
                          child: Text('onInteract',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                  color: Colors.amber[800]))),
                    ],
                  ),
                ),
                ...timelineWidgets,
              ],
            ),
          ),

          // Section 8
          avSectionHeader('8', 'Patterns & Pitfalls', Icons.lightbulb_outline),
          ...tipWidgets,

          // Section 9
          avSectionHeader('9', 'Summary Dashboard', Icons.dashboard),
          summaryGrid,
          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}

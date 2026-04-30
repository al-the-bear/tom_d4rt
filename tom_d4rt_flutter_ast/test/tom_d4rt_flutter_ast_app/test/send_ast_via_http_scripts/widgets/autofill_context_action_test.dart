// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — AutofillContextAction
// Demonstrates AutofillContextAction (commit vs cancel) and the
// AutofillGroup system. Shows login forms, multi-step wizards,
// autofill hints catalog, and platform autofill integration patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AutofillContextAction Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is AutofillContextAction?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.auto_mode,
      'title': 'Platform Autofill',
      'body': 'Mobile and desktop platforms offer autofill services '
          'that remember usernames, passwords, addresses, and other '
          'form data. Flutter integrates with these services through '
          'AutofillGroup — a widget that coordinates autofill across '
          'a group of text fields.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.commit,
      'title': 'AutofillContextAction',
      'body': 'When an AutofillGroup disposes (user navigates away, '
          'form submits), it needs to tell the platform autofill '
          'service what happened. AutofillContextAction controls this: '
          'should the entered data be committed (saved) or cancelled '
          '(discarded)?',
      'accent': Colors.green[800]!,
    },
    {
      'icon': Icons.save_alt,
      'title': 'Commit — Save the Data',
      'body': 'AutofillContextAction.commit tells the platform to save '
          'the autofill data. The user may see a "Save password?" '
          'prompt on supported platforms. Use this when the form '
          'submission was successful.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.cancel_outlined,
      'title': 'Cancel — Discard the Data',
      'body': 'AutofillContextAction.cancel tells the platform to '
          'discard the data. No "Save password?" prompt appears. '
          'Use this when the user cancels the form or when the '
          'submission failed and data should not be remembered.',
      'accent': Colors.orange,
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
  // SECTION 2: API Surface
  // ============================================================
  print('=== Section 2: API Surface ===');

  final apiItems = <Map<String, String>>[
    {
      'label': 'Class',
      'value': 'AutofillContextAction',
      'detail': 'An enum-like class defining autofill finalization behavior',
    },
    {
      'label': 'commit',
      'value': 'AutofillContextAction.commit',
      'detail': 'Tell platform to save autofill data (triggers "Save?" prompt)',
    },
    {
      'label': 'cancel',
      'value': 'AutofillContextAction.cancel',
      'detail': 'Tell platform to discard autofill data (no save prompt)',
    },
    {
      'label': 'Used By',
      'value': 'AutofillGroup.onDisposeAction',
      'detail': 'The onDisposeAction parameter of AutofillGroup widget',
    },
    {
      'label': 'Default',
      'value': 'AutofillContextAction.commit',
      'detail': 'AutofillGroup defaults to commit when not specified',
    },
    {
      'label': 'Platform',
      'value': 'Varies by OS',
      'detail': 'Android/iOS show save prompts; web/desktop vary',
    },
  ];

  final apiWidgets = apiItems.map<Widget>((item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: Colors.green[700]!, width: 4),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              item['label']!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.green[800],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['value']!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  item['detail']!,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 3: AutofillGroup Architecture
  // ============================================================
  print('=== Section 3: AutofillGroup Architecture ===');

  final archComponents = <Map<String, dynamic>>[
    {
      'name': 'AutofillGroup',
      'role': 'A widget that groups multiple TextFields for autofill. '
          'When the group disposes, it sends the AutofillContextAction '
          'to the platform.',
      'icon': Icons.group_work,
      'color': Colors.green,
    },
    {
      'name': 'AutofillHints',
      'role': 'String constants that tell the platform what kind of data '
          'a field expects: username, password, email, street address, '
          'phone number, etc.',
      'icon': Icons.lightbulb_outline,
      'color': Colors.blue,
    },
    {
      'name': 'TextInputConfiguration',
      'role': 'Each TextField sends its autofillHints via '
          'TextInputConfiguration to the text input channel. The '
          'platform reads these to populate suggestions.',
      'icon': Icons.settings,
      'color': Colors.purple,
    },
    {
      'name': 'Platform Autofill Service',
      'role': 'The OS-level credential manager (Keychain on iOS, '
          'Autofill Service on Android, browser password manager on web). '
          'It reads hints and provides saved data.',
      'icon': Icons.phone_android,
      'color': Colors.orange,
    },
    {
      'name': 'AutofillContextAction',
      'role': 'The finalization signal sent to the platform when the '
          'AutofillGroup is disposed. Determines whether data is '
          'saved (commit) or discarded (cancel).',
      'icon': Icons.flag,
      'color': Colors.red,
    },
  ];

  final archWidgets = archComponents.map<Widget>((comp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (comp['color'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(
            color: comp['color'] as Color,
            width: 4,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: (comp['color'] as Color).withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(comp['icon'] as IconData,
                color: comp['color'] as Color, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comp['name'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: comp['color'] as Color,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  comp['role'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // Data flow diagram
  final dataFlowSteps = <Map<String, String>>[
    {'step': '1', 'label': 'User focuses TextField'},
    {'step': '2', 'label': 'AutofillGroup registers fields'},
    {'step': '3', 'label': 'Platform reads AutofillHints'},
    {'step': '4', 'label': 'Platform shows saved data'},
    {'step': '5', 'label': 'User fills and submits'},
    {'step': '6', 'label': 'AutofillGroup disposes'},
    {'step': '7', 'label': 'AutofillContextAction sent'},
    {'step': '8', 'label': 'Platform saves or discards'},
  ];

  final flowWidgets = dataFlowSteps.map<Widget>((step) {
    final idx = int.parse(step['step']!) - 1;
    final green = Color.lerp(Colors.green[900], Colors.green[300], idx / 7)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: green,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step['step']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border(left: BorderSide(color: green, width: 3)),
            ),
            child: Text(
              step['label']!,
              style: TextStyle(fontSize: 12, color: green),
            ),
          ),
          if (idx < 7)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(Icons.arrow_downward,
                  size: 14, color: Colors.green[300]),
            ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 4: Live Login Form with AutofillGroup
  // ============================================================
  print('=== Section 4: Live Login Form ===');

  // A complete login form wrapped in AutofillGroup
  final loginForm = AutofillGroup(
    onDisposeAction: AutofillContextAction.commit,
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lock_outline, color: Colors.green[700], size: 28),
              const SizedBox(width: 10),
              Text(
                'Login Form',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'onDisposeAction: AutofillContextAction.commit',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.green[700],
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            autofillHints: const [AutofillHints.username],
            decoration: InputDecoration(
              labelText: 'Username',
              hintText: 'Enter your username',
              prefixIcon: Icon(Icons.person, color: Colors.green[600]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.green[700]!, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            autofillHints: const [AutofillHints.password],
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icon(Icons.lock, color: Colors.green[600]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.green[700]!, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: const Text('Sign In'),
            ),
          ),
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 5: Commit vs Cancel Comparison
  // ============================================================
  print('=== Section 5: Commit vs Cancel Comparison ===');

  Widget buildActionCard({
    required String title,
    required String subtitle,
    required AutofillContextAction action,
    required IconData icon,
    required Color color,
    required List<String> bullets,
    required String codeSnippet,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
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
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...bullets.map((b) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_right, size: 16, color: color),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(b,
                          style:
                              const TextStyle(fontSize: 12, height: 1.3)),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              codeSnippet,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  final commitCard = buildActionCard(
    title: 'AutofillContextAction.commit',
    subtitle: 'Save the autofill data',
    action: AutofillContextAction.commit,
    icon: Icons.save,
    color: Colors.green,
    bullets: [
      'Platform may prompt "Save password?" or "Update credentials?"',
      'Saved data appears in future autofill suggestions',
      'Default behavior — used when form submission succeeds',
      'On Android: triggers AutofillManager.commit()',
      'On iOS: interacts with Keychain via ASAuthorization',
      'On web: browser password manager may show save dialog',
    ],
    codeSnippet: 'AutofillGroup(\n'
        '  onDisposeAction: AutofillContextAction.commit,\n'
        '  child: Column(children: [\n'
        '    TextField(autofillHints: [AutofillHints.username]),\n'
        '    TextField(autofillHints: [AutofillHints.password]),\n'
        '  ]),\n'
        ')',
  );

  final cancelCard = buildActionCard(
    title: 'AutofillContextAction.cancel',
    subtitle: 'Discard the autofill data',
    action: AutofillContextAction.cancel,
    icon: Icons.cancel_outlined,
    color: Colors.orange[800]!,
    bullets: [
      'No "Save password?" prompt appears',
      'Entered data is not saved to the credential store',
      'Use when user cancels, form validation fails, or timeout',
      'On Android: triggers AutofillManager.cancel()',
      'On iOS: no authorization storage interaction',
      'On web: browser password manager skips save',
    ],
    codeSnippet: 'AutofillGroup(\n'
        '  onDisposeAction: AutofillContextAction.cancel,\n'
        '  child: Column(children: [\n'
        '    TextField(autofillHints: [AutofillHints.email]),\n'
        '    TextField(autofillHints: [AutofillHints.newPassword]),\n'
        '  ]),\n'
        ')',
  );

  // ============================================================
  // SECTION 6: Multi-Step Form (Registration Wizard)
  // ============================================================
  print('=== Section 6: Multi-Step Form ===');

  // Show a wizard-like registration with separate AutofillGroups
  final wizardSteps = <Map<String, dynamic>>[
    {
      'step': 'Step 1: Account',
      'action': 'cancel',
      'reason': 'User might go back — don\'t save partial data',
      'fields': ['email', 'newPassword'],
      'color': Colors.blue,
      'icon': Icons.person_add,
    },
    {
      'step': 'Step 2: Personal Info',
      'action': 'cancel',
      'reason': 'Intermediate step — saving would create duplicate entries',
      'fields': ['name', 'givenName', 'familyName'],
      'color': Colors.purple,
      'icon': Icons.badge,
    },
    {
      'step': 'Step 3: Address',
      'action': 'cancel',
      'reason': 'Still intermediate — wait for final confirmation',
      'fields': ['streetAddress', 'postalCode', 'city'],
      'color': Colors.teal,
      'icon': Icons.location_on,
    },
    {
      'step': 'Step 4: Confirm & Submit',
      'action': 'commit',
      'reason': 'Final step — now save all credentials to the platform',
      'fields': ['(summary of all data)'],
      'color': Colors.green,
      'icon': Icons.check_circle,
    },
  ];

  final wizardWidgets = wizardSteps.map<Widget>((step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (step['color'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (step['color'] as Color).withOpacity(0.25),
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
                  color: (step['color'] as Color).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(step['icon'] as IconData,
                    color: step['color'] as Color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  step['step'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: step['color'] as Color,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: step['action'] == 'commit'
                      ? Colors.green.withOpacity(0.15)
                      : Colors.orange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: step['action'] == 'commit'
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
                child: Text(
                  step['action'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: step['action'] == 'commit'
                        ? Colors.green[800]
                        : Colors.orange[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            step['reason'] as String,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: (step['fields'] as List<String>).map<Widget>((f) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  f,
                  style: const TextStyle(
                      fontFamily: 'monospace', fontSize: 10),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 7: AutofillHints Catalog
  // ============================================================
  print('=== Section 7: AutofillHints Catalog ===');

  final hintCategories = <Map<String, dynamic>>[
    {
      'category': 'Credentials',
      'icon': Icons.lock,
      'color': Colors.red,
      'hints': [
        {'hint': 'username', 'desc': 'Account username'},
        {'hint': 'password', 'desc': 'Current password'},
        {'hint': 'newPassword', 'desc': 'New password (registration)'},
        {'hint': 'newUsername', 'desc': 'New username'},
      ],
    },
    {
      'category': 'Personal',
      'icon': Icons.person,
      'color': Colors.blue,
      'hints': [
        {'hint': 'name', 'desc': 'Full name'},
        {'hint': 'givenName', 'desc': 'First name'},
        {'hint': 'familyName', 'desc': 'Last name'},
        {'hint': 'middleName', 'desc': 'Middle name'},
        {'hint': 'nickname', 'desc': 'Preferred nickname'},
        {'hint': 'birthday', 'desc': 'Date of birth'},
      ],
    },
    {
      'category': 'Contact',
      'icon': Icons.phone,
      'color': Colors.green,
      'hints': [
        {'hint': 'email', 'desc': 'Email address'},
        {'hint': 'telephoneNumber', 'desc': 'Phone number'},
      ],
    },
    {
      'category': 'Address',
      'icon': Icons.location_on,
      'color': Colors.purple,
      'hints': [
        {'hint': 'streetAddressLine1', 'desc': 'Street address line 1'},
        {'hint': 'streetAddressLine2', 'desc': 'Street address line 2'},
        {'hint': 'postalCode', 'desc': 'Postal / ZIP code'},
        {'hint': 'addressCity', 'desc': 'City'},
        {'hint': 'addressState', 'desc': 'State or province'},
        {'hint': 'countryName', 'desc': 'Country'},
      ],
    },
    {
      'category': 'Payment',
      'icon': Icons.credit_card,
      'color': Colors.orange,
      'hints': [
        {'hint': 'creditCardNumber', 'desc': 'Card number'},
        {'hint': 'creditCardName', 'desc': 'Name on card'},
        {'hint': 'creditCardExpirationDate', 'desc': 'Expiration date'},
        {'hint': 'creditCardSecurityCode', 'desc': 'CVV / CVC'},
      ],
    },
  ];

  print('  ${hintCategories.length} hint categories');

  final hintCatalogWidgets = hintCategories.map<Widget>((cat) {
    final hints = cat['hints'] as List<Map<String, String>>;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (cat['color'] as Color).withOpacity(0.25),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: (cat['color'] as Color).withOpacity(0.1),
            ),
            child: Row(
              children: [
                Icon(cat['icon'] as IconData,
                    color: cat['color'] as Color, size: 18),
                const SizedBox(width: 8),
                Text(
                  cat['category'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: cat['color'] as Color,
                  ),
                ),
                const Spacer(),
                Text(
                  '${hints.length} hints',
                  style: TextStyle(
                      fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          ...hints.asMap().entries.map<Widget>((entry) {
            final i = entry.key;
            final hint = entry.value;
            return Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: i.isEven
                    ? Colors.transparent
                    : (cat['color'] as Color).withOpacity(0.03),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      'AutofillHints.${hint['hint']}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      hint['desc']!,
                      style: TextStyle(
                          fontSize: 11, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 8: Common Patterns and Pitfalls
  // ============================================================
  print('=== Section 8: Common Patterns and Pitfalls ===');

  final patternsAndPitfalls = <Map<String, dynamic>>[
    {
      'type': 'pattern',
      'title': 'Wrap login forms in AutofillGroup',
      'detail': 'Always wrap related fields (username + password) in a '
          'single AutofillGroup. The platform needs to see them as one '
          'credential set to offer proper autofill.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'Use commit for successful submissions',
      'detail': 'Set onDisposeAction to commit when the user successfully '
          'submits. This triggers the platform\'s "Save password?" prompt.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'Use cancel for multi-step intermediate pages',
      'detail': 'In a wizard flow, use cancel for intermediate steps and '
          'only commit on the final step to avoid duplicate save prompts.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'Always provide autofillHints',
      'detail': 'TextFields need autofillHints to participate in autofill. '
          'Without hints, the platform cannot identify what data to suggest.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pitfall',
      'title': 'Multiple AutofillGroups for one credential',
      'detail': 'Don\'t split username and password into separate '
          'AutofillGroups. The platform needs them in one group to '
          'correctly associate the credential pair.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
    {
      'type': 'pitfall',
      'title': 'Committing on cancel button',
      'detail': 'If the user presses Cancel, make sure to set the action '
          'to cancel, not the default commit. Otherwise the platform may '
          'save incorrect partial data.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
    {
      'type': 'pitfall',
      'title': 'Forgetting to call TextInput.finishAutofillContext',
      'detail': 'In programmatic scenarios, you may need to manually call '
          'TextInput.finishAutofillContext() to trigger the autofill '
          'finalization. AutofillGroup does this automatically on dispose.',
      'icon': Icons.error_outline,
      'color': Colors.red,
    },
  ];

  final patternWidgets = patternsAndPitfalls.map<Widget>((item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (item['color'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(
            color: item['color'] as Color,
            width: 4,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item['icon'] as IconData,
              color: item['color'] as Color, size: 20),
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
                        color: (item['color'] as Color).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        (item['type'] as String).toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: item['color'] as Color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: item['color'] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item['detail'] as String,
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

  final totalHints = hintCategories.fold<int>(
    0,
    (sum, cat) => sum + (cat['hints'] as List).length,
  );

  final summaryItems = <Map<String, dynamic>>[
    {'label': 'Context actions', 'value': '2', 'icon': Icons.flag},
    {'label': 'Architecture parts', 'value': '${archComponents.length}', 'icon': Icons.architecture},
    {'label': 'Hint categories', 'value': '${hintCategories.length}', 'icon': Icons.category},
    {'label': 'Autofill hints', 'value': '$totalHints', 'icon': Icons.lightbulb},
    {'label': 'Wizard steps', 'value': '${wizardSteps.length}', 'icon': Icons.linear_scale},
    {'label': 'Patterns & pitfalls', 'value': '${patternsAndPitfalls.length}', 'icon': Icons.lightbulb_outline},
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
              Colors.green.withOpacity(0.12),
              Colors.green.withOpacity(0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(item['icon'] as IconData, color: Colors.green[700], size: 24),
            const SizedBox(height: 6),
            Text(
              item['value'] as String,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
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
  Widget afSectionHeader(String number, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 28, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[800]!, Colors.green[400]!],
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

  print('AutofillContextAction Deep Demo — building final layout');

  // ============================================================
  // FINAL LAYOUT
  // ============================================================
  return Scaffold(
    appBar: AppBar(
      title: const Text('AutofillContextAction'),
      backgroundColor: Colors.green[800],
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
                colors: [Colors.green[800]!, Colors.green[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.auto_mode, color: Colors.white, size: 40),
                const SizedBox(height: 10),
                const Text(
                  'AutofillContextAction',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Controls what happens when an AutofillGroup finishes: '
                  'should the platform autofill service save the entered '
                  'credentials (commit) or discard them (cancel)? This '
                  'drives the "Save password?" experience across platforms.',
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
          afSectionHeader('1', 'Concept', Icons.lightbulb),
          ...conceptWidgets,

          // Section 2
          afSectionHeader('2', 'API Surface', Icons.code),
          ...apiWidgets,

          // Section 3
          afSectionHeader('3', 'AutofillGroup Architecture', Icons.architecture),
          ...archWidgets,
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data Flow:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(height: 8),
                ...flowWidgets,
              ],
            ),
          ),

          // Section 4
          afSectionHeader('4', 'Live Login Form', Icons.lock),
          loginForm,

          // Section 5
          afSectionHeader('5', 'Commit vs Cancel', Icons.compare),
          commitCard,
          cancelCard,

          // Section 6
          afSectionHeader('6', 'Multi-Step Registration', Icons.linear_scale),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'In wizard flows, use cancel for intermediate steps and '
              'commit only on the final confirmation step:',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
          ...wizardWidgets,

          // Section 7
          afSectionHeader('7', 'AutofillHints Catalog', Icons.list_alt),
          ...hintCatalogWidgets,

          // Section 8
          afSectionHeader('8', 'Patterns & Pitfalls', Icons.lightbulb_outline),
          ...patternWidgets,

          // Section 9
          afSectionHeader('9', 'Summary Dashboard', Icons.dashboard),
          summaryGrid,
          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}

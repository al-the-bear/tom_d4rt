// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unnecessary_import
// D4rt test script: Tests TextInputAction enum from package:flutter/services.dart
// Deep Demo: A visual, instructive tour of the keyboard "action key" enum that
// drives the return/enter button on the soft keyboard for TextField/TextFormField
// widgets. Covers per-value semantics, platform mappings (iOS UIReturnKeyType,
// Android EditorInfo.IME_ACTION_*), mock soft-keyboard renderings, recipes for
// realistic flows (login chain, search, comment compose), and pitfalls around
// `newline`, `continueAction`, and the relationship to `keyboardType`.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('TextInputAction Deep Demo executing');
  print('Total TextInputAction values: ${TextInputAction.values.length}');
  for (final action in TextInputAction.values) {
    print('  TextInputAction.${action.name} (index=${action.index})');
  }

  // ============================================================
  // Shared metadata table for every TextInputAction value.
  // ============================================================
  // Each entry collects everything we want to teach for a value:
  //   - icon: a Material icon that visually evokes the action
  //   - label: the typical localized button label
  //   - color: a per-value palette accent
  //   - description: what the action communicates to the user
  //   - iosMapping: the corresponding UIReturnKeyType
  //   - androidMapping: the corresponding EditorInfo.IME_ACTION_*
  //   - example: a realistic place where this value is appropriate
  final Map<TextInputAction, Map<String, Object>> meta = {
    TextInputAction.none: {
      'icon': Icons.block,
      'label': 'none',
      'color': Colors.blueGrey,
      'description':
          'Suppress any action key entirely. The keyboard renders no '
              'special return key (or a disabled one). Rare in user-facing UIs.',
      'iosMapping': 'UIReturnKeyType.default (suppressed)',
      'androidMapping': 'IME_ACTION_NONE',
      'example':
          'Read-only / display-only TextFields where user input is not expected.',
    },
    TextInputAction.unspecified: {
      'icon': Icons.help_outline,
      'label': 'return',
      'color': Colors.grey,
      'description':
          'Default action; lets the platform choose. Falls back to "done" '
              'on iOS and to a generic newline/done on Android.',
      'iosMapping': 'UIReturnKeyType.default',
      'androidMapping': 'IME_ACTION_UNSPECIFIED',
      'example':
          'Plain TextFields where you do not care about the return key label.',
    },
    TextInputAction.done: {
      'icon': Icons.check_circle_outline,
      'label': 'Done',
      'color': Colors.green,
      'description':
          'User signals "I am finished editing this field". Typically '
              'closes the keyboard and unfocuses the input.',
      'iosMapping': 'UIReturnKeyType.done',
      'androidMapping': 'IME_ACTION_DONE',
      'example':
          'Last field of a profile form, or a single-field dialog like '
              '"Rename folder".',
    },
    TextInputAction.go: {
      'icon': Icons.arrow_forward,
      'label': 'Go',
      'color': Colors.indigo,
      'description':
          'User wants to navigate or submit toward a destination. Common '
              'for URL bars and "load this thing" inputs.',
      'iosMapping': 'UIReturnKeyType.go',
      'androidMapping': 'IME_ACTION_GO',
      'example':
          'Browser address bar; "open project by id" prompt.',
    },
    TextInputAction.search: {
      'icon': Icons.search,
      'label': 'Search',
      'color': Colors.deepPurple,
      'description':
          'User is ready to execute a search query. Strong semantic '
              'signal — pair with `keyboardType: TextInputType.text` or '
              '`webSearchAddress`.',
      'iosMapping': 'UIReturnKeyType.search',
      'androidMapping': 'IME_ACTION_SEARCH',
      'example': 'App-bar search field; help/article lookup.',
    },
    TextInputAction.send: {
      'icon': Icons.send,
      'label': 'Send',
      'color': Colors.teal,
      'description':
          'User is shipping a message — chat, comment, e-mail compose. '
              'Often paired with onSubmitted that posts to a backend.',
      'iosMapping': 'UIReturnKeyType.send',
      'androidMapping': 'IME_ACTION_SEND',
      'example': 'Chat compose box; comment box; SMS-like input.',
    },
    TextInputAction.next: {
      'icon': Icons.arrow_forward_ios,
      'label': 'Next',
      'color': Colors.blue,
      'description':
          'Moves focus to the next input in a form chain. Use with '
              'FocusNode / FocusScope.of(context).nextFocus() in onSubmitted.',
      'iosMapping': 'UIReturnKeyType.next',
      'androidMapping': 'IME_ACTION_NEXT',
      'example': 'Username -> Password chain; multi-step registration.',
    },
    TextInputAction.previous: {
      'icon': Icons.arrow_back_ios,
      'label': 'Prev',
      'color': Colors.cyan,
      'description':
          'Moves focus to the previous input. Less common because most '
              'keyboards only render one primary action key, but useful for '
              'forms where backward navigation matters.',
      'iosMapping': 'UIReturnKeyType.default (no native "prev")',
      'androidMapping': 'IME_ACTION_PREVIOUS',
      'example':
          'Multi-page wizard where the last field offers "Back" instead of "Next".',
    },
    TextInputAction.continueAction: {
      'icon': Icons.skip_next,
      'label': 'Continue',
      'color': Colors.orange,
      'description':
          'iOS-flavoured "Continue" button. On Android it falls back to '
              '"next" or "done". Commonly used for onboarding flows.',
      'iosMapping': 'UIReturnKeyType.continue',
      'androidMapping': 'IME_ACTION_NEXT (fallback)',
      'example':
          'Onboarding step "Enter your e-mail" where the next screen continues setup.',
    },
    TextInputAction.join: {
      'icon': Icons.group_add,
      'label': 'Join',
      'color': Colors.lightGreen,
      'description':
          'iOS Wi-Fi / community style "Join" button. On Android it '
              'usually maps to IME_ACTION_DONE.',
      'iosMapping': 'UIReturnKeyType.join',
      'androidMapping': 'IME_ACTION_DONE (fallback)',
      'example':
          'Joining a Wi-Fi network, joining a chat room, joining a meeting.',
    },
    TextInputAction.route: {
      'icon': Icons.alt_route,
      'label': 'Route',
      'color': Colors.amber,
      'description':
          'iOS "Route" button, used in maps to compute a route. Android '
              'falls back to default.',
      'iosMapping': 'UIReturnKeyType.route',
      'androidMapping': 'IME_ACTION_UNSPECIFIED (fallback)',
      'example':
          'Address field in a maps / navigation application.',
    },
    TextInputAction.emergencyCall: {
      'icon': Icons.local_hospital,
      'label': 'Call',
      'color': Colors.red,
      'description':
          'iOS "Emergency Call" button. Reserved for system-level '
              'emergency dialer flows; almost never appropriate in app UI.',
      'iosMapping': 'UIReturnKeyType.emergencyCall',
      'androidMapping': 'IME_ACTION_UNSPECIFIED (fallback)',
      'example':
          'System emergency dialer; do not use in regular product flows.',
    },
    TextInputAction.newline: {
      'icon': Icons.subdirectory_arrow_left,
      'label': 'return',
      'color': Colors.brown,
      'description':
          'Inserts a newline instead of submitting. ONLY VALID for '
              'multi-line TextFields (maxLines != 1). Using it on a '
              'single-line field will throw an assertion in debug.',
      'iosMapping': 'UIReturnKeyType.default (newline)',
      'androidMapping': 'IME_ACTION_NONE + multiline flag',
      'example':
          'Long-form note editor; multi-line comment composer.',
    },
  };
  print('Built meta map with ${meta.length} entries');

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  print('=== Section 1: Hero header ===');
  final hero = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade700,
          Colors.deepPurple.shade500,
          Colors.pink.shade300,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.pink.withValues(alpha: 0.2),
          blurRadius: 32.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.keyboard, size: 44.0, color: Colors.white),
            SizedBox(width: 12.0),
            Icon(Icons.keyboard_return, size: 44.0, color: Colors.white70),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'TextInputAction',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'The keyboard\'s action key, demystified',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white.withValues(alpha: 0.9),
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _heroChip('${TextInputAction.values.length} values', Icons.list_alt),
            _heroChip('package:flutter/services.dart', Icons.inventory_2),
            _heroChip('drives onSubmitted', Icons.bolt),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Concept primer
  // ============================================================
  print('=== Section 2: Concept primer ===');
  final primer = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.12),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.school, color: Colors.indigo.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'What is TextInputAction?',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Every soft keyboard on mobile has a single primary "action key" — '
              'often labelled return, done, search, send, go, next, etc. '
              'TextInputAction tells the platform which label and which icon '
              'to render and which IME action to fire when pressed.',
          style: TextStyle(fontSize: 14.0, color: Colors.indigo.shade900),
        ),
        SizedBox(height: 12.0),
        Text(
          'When the user taps that key:',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        _primerBullet('TextField.onSubmitted(value) is invoked.'),
        _primerBullet('TextField.onEditingComplete fires (default unfocuses).'),
        _primerBullet(
            'For Form fields, onFieldSubmitted runs and validators may trigger.'),
        _primerBullet(
            'Focus may move (e.g. nextFocus()) when you wire it up explicitly.'),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.indigo.shade100),
          ),
          child: Text(
            'TextField(\n'
                '  textInputAction: TextInputAction.next,\n'
                '  onSubmitted: (value) {\n'
                '    // value is the submitted text\n'
                '    // move focus, validate, send to API, ...\n'
                '  },\n'
                ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.indigo.shade900,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-value cards (one per TextInputAction value)
  // ============================================================
  print('=== Section 3: Per-value cards ===');
  final List<Widget> valueCards = [];
  for (final action in TextInputAction.values) {
    final m = meta[action]!;
    final color = m['color'] as Color;
    final icon = m['icon'] as IconData;
    final label = m['label'] as String;
    final description = m['description'] as String;
    final ios = m['iosMapping'] as String;
    final android = m['androidMapping'] as String;
    final example = m['example'] as String;
    print(
        'Card[${action.name}] -> iOS=$ios | Android=$android | label="$label"');

    valueCards.add(Container(
      width: 320.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.08),
            color.withValues(alpha: 0.18),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 10.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24.0),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TextInputAction.${action.name}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      'index ${action.index}',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              _miniKeyboardKey(label, color),
            ],
          ),
          SizedBox(height: 12.0),
          Text(
            description,
            style: TextStyle(fontSize: 13.0, color: Colors.black87, height: 1.3),
          ),
          SizedBox(height: 12.0),
          _platformRow(Icons.phone_iphone, 'iOS', ios, Colors.grey.shade800),
          SizedBox(height: 4.0),
          _platformRow(
              Icons.android, 'Android', android, Colors.green.shade800),
          SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: color.withValues(alpha: 0.4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline, size: 14.0, color: color),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    example,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
  print('Built ${valueCards.length} value cards');

  // ============================================================
  // SECTION 4: Mock soft-keyboard renderings
  // ============================================================
  print('=== Section 4: Mock soft-keyboards ===');
  final List<Widget> mockKeyboards = [];
  for (final action in TextInputAction.values) {
    final m = meta[action]!;
    final color = m['color'] as Color;
    final label = m['label'] as String;
    mockKeyboards.add(_mockKeyboard(action.name, label, color));
  }
  final mockKeyboardsWrap = Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    children: mockKeyboards,
  );

  // ============================================================
  // SECTION 5: Real TextField grid (one per value)
  // ============================================================
  print('=== Section 5: Real TextField grid ===');
  final List<Widget> realFields = [];
  for (final action in TextInputAction.values) {
    final m = meta[action]!;
    final color = m['color'] as Color;
    final isMultiline = action == TextInputAction.newline;
    realFields.add(Container(
      width: 300.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 8.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(m['icon'] as IconData, color: color, size: 18.0),
              SizedBox(width: 6.0),
              Text(
                'textInputAction: .${action.name}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          TextField(
            textInputAction: action,
            maxLines: isMultiline ? 3 : 1,
            minLines: isMultiline ? 2 : 1,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: isMultiline
                  ? 'Type a few lines... return inserts newlines'
                  : 'Try the keyboard return key',
              prefixIcon: Icon(m['icon'] as IconData, color: color),
            ),
            onSubmitted: (_) {},
            onEditingComplete: () {},
          ),
        ],
      ),
    ));
  }
  print('Built ${realFields.length} live TextFields');

  // ============================================================
  // SECTION 6: Recipes — login chain, search bar, comment compose
  // ============================================================
  print('=== Section 6: Recipes ===');
  final loginRecipe = _recipeCard(
    title: 'Recipe 1 — Login form chain (next + done)',
    color: Colors.blue,
    icon: Icons.login,
    description:
        'Use TextInputAction.next on every field except the final one, '
            'which uses TextInputAction.done. In onSubmitted, move focus '
            'forward until the last field, where you submit the form.',
    code: 'final emailFocus = FocusNode();\n'
        'final pwdFocus = FocusNode();\n\n'
        'TextField(\n'
        '  focusNode: emailFocus,\n'
        '  textInputAction: TextInputAction.next,\n'
        '  onSubmitted: (_) => pwdFocus.requestFocus(),\n'
        '),\n'
        'TextField(\n'
        '  focusNode: pwdFocus,\n'
        '  obscureText: true,\n'
        '  textInputAction: TextInputAction.done,\n'
        '  onSubmitted: (_) => submitForm(),\n'
        '),',
    body: Column(
      children: [
        TextField(
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'E-mail',
            prefixIcon: Icon(Icons.email_outlined),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (_) {},
        ),
        SizedBox(height: 8.0),
        TextField(
          textInputAction: TextInputAction.done,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock_outline),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (_) {},
        ),
      ],
    ),
  );

  final searchRecipe = _recipeCard(
    title: 'Recipe 2 — Search bar (search)',
    color: Colors.deepPurple,
    icon: Icons.search,
    description:
        'A search input wants the keyboard\'s "Search" key. Combine with '
            'a leading magnifier icon and clear UX affordance. Submit performs '
            'the query.',
    code: 'TextField(\n'
        '  textInputAction: TextInputAction.search,\n'
        '  decoration: InputDecoration(\n'
        '    hintText: "Search articles...",\n'
        '    prefixIcon: Icon(Icons.search),\n'
        '  ),\n'
        '  onSubmitted: (q) => runQuery(q),\n'
        ')',
    body: TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search articles, files, or people...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.deepPurple.shade50,
      ),
      onSubmitted: (_) {},
    ),
  );

  final composeRecipe = _recipeCard(
    title: 'Recipe 3 — Comment compose (send)',
    color: Colors.teal,
    icon: Icons.send,
    description:
        'A comment / chat box uses TextInputAction.send. Note: if you want '
            'multi-line input, use TextInputAction.newline OR a separate Send '
            'button — you cannot have both newline insertion AND a send key '
            'on the same field.',
    code: 'TextField(\n'
        '  textInputAction: TextInputAction.send,\n'
        '  decoration: InputDecoration(\n'
        '    hintText: "Add a comment",\n'
        '    suffixIcon: Icon(Icons.send, color: Colors.teal),\n'
        '  ),\n'
        '  onSubmitted: (msg) => postComment(msg),\n'
        ')',
    body: TextField(
      textInputAction: TextInputAction.send,
      decoration: InputDecoration(
        hintText: 'Add a comment...',
        suffixIcon: Icon(Icons.send, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
        ),
        filled: true,
        fillColor: Colors.teal.shade50,
      ),
      onSubmitted: (_) {},
    ),
  );

  // ============================================================
  // SECTION 7: Comparison matrix — TextInputAction vs TextInputType
  // ============================================================
  print('=== Section 7: Comparison matrix ===');
  final comparisonMatrix = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Colors.orange.shade900, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'textInputAction vs keyboardType',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'These two are independent axes. keyboardType picks WHICH '
              'characters the keyboard shows (numbers, e-mail, URL, multiline). '
              'textInputAction picks the LABEL of the action key. They '
              'compose:',
          style: TextStyle(fontSize: 13.0, color: Colors.brown.shade900),
        ),
        SizedBox(height: 12.0),
        _comparisonRow('Numeric keypad', 'TextInputType.number',
            'TextInputAction.done', Colors.blue),
        _comparisonRow('Email address', 'TextInputType.emailAddress',
            'TextInputAction.next', Colors.indigo),
        _comparisonRow('URL bar', 'TextInputType.url', 'TextInputAction.go',
            Colors.purple),
        _comparisonRow('Search', 'TextInputType.text',
            'TextInputAction.search', Colors.deepPurple),
        _comparisonRow('Chat compose', 'TextInputType.text',
            'TextInputAction.send', Colors.teal),
        _comparisonRow('Multi-line note', 'TextInputType.multiline',
            'TextInputAction.newline', Colors.brown),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Pitfalls
  // ============================================================
  print('=== Section 8: Pitfalls ===');
  final pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.red.shade800, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & gotchas',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pitfall(
          icon: Icons.error_outline,
          title: 'newline only for multi-line fields',
          body:
              'TextInputAction.newline asserts that maxLines != 1. Setting it on '
              'a single-line TextField throws in debug and falls back at runtime.',
        ),
        _pitfall(
          icon: Icons.phonelink_off,
          title: 'iOS-only values fall back on Android',
          body:
              'continueAction, route, join, emergencyCall and previous have no '
              'direct UIReturnKey on Android — the IME picks a sensible '
              'IME_ACTION_* (often DONE or UNSPECIFIED). Do not rely on visuals.',
        ),
        _pitfall(
          icon: Icons.translate,
          title: 'Localization is the platform\'s job',
          body:
              'You set the SEMANTIC action; the platform localizes the visible '
              'label. Do not hard-code the English word into your UI strings.',
        ),
        _pitfall(
          icon: Icons.touch_app,
          title: 'send + multiline cannot share a keyboard',
          body:
              'A field cannot insert newlines AND show a Send key on the action '
              'button at the same time. Pick one — usually a separate Send '
              'IconButton beside a multiline field.',
        ),
        _pitfall(
          icon: Icons.privacy_tip,
          title: 'emergencyCall is not for app UIs',
          body:
              'emergencyCall is for system-level emergency dialer flows. Using '
              'it in a regular product can be misleading and rejected in review.',
        ),
        _pitfall(
          icon: Icons.next_plan,
          title: 'next without focus management does nothing',
          body:
              'Setting TextInputAction.next does NOT automatically move focus. '
              'You must call FocusScope.of(context).nextFocus() (or request a '
              'specific FocusNode) inside onSubmitted.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footer with file path + ASCII box
  // ============================================================
  print('=== Section 9: Footer ===');
  const String asciiBox = '''
+-------------------------------------------------------------+
|  TextInputAction Deep Demo                                  |
|  package:flutter/services.dart                              |
|  bridges/services_bridges.b.dart -> BridgedEnumDefinition   |
|                                                             |
|  values: none, unspecified, done, go, search, send, next,   |
|          previous, continueAction, join, route,             |
|          emergencyCall, newline                             |
|                                                             |
|  primary hook: TextField.onSubmitted(String value)          |
+-------------------------------------------------------------+
''';
  final footer = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 7.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.folder_open, color: Colors.cyanAccent, size: 18.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/'
                    'services/text_input_action_test.dart',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.cyanAccent,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          asciiBox,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.greenAccent,
            height: 1.3,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'TextInputAction Deep Demo finished.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  print('TextInputAction Deep Demo build complete');

  // ============================================================
  // Compose the full layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        hero,
        SizedBox(height: 20.0),
        _sectionTitle('1. Concept primer', Icons.school, Colors.indigo),
        primer,
        SizedBox(height: 20.0),
        _sectionTitle('2. Per-value cards', Icons.style, Colors.deepPurple),
        Wrap(alignment: WrapAlignment.center, children: valueCards),
        SizedBox(height: 24.0),
        _sectionTitle(
            '3. Mock soft-keyboards', Icons.keyboard, Colors.blueGrey),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: mockKeyboardsWrap,
        ),
        SizedBox(height: 24.0),
        _sectionTitle(
            '4. Live TextField grid', Icons.input, Colors.teal),
        Wrap(alignment: WrapAlignment.center, children: realFields),
        SizedBox(height: 24.0),
        _sectionTitle('5. Recipes', Icons.menu_book, Colors.blue),
        loginRecipe,
        SizedBox(height: 12.0),
        searchRecipe,
        SizedBox(height: 12.0),
        composeRecipe,
        SizedBox(height: 24.0),
        _sectionTitle(
            '6. Axes: action vs keyboardType', Icons.compare, Colors.orange),
        comparisonMatrix,
        SizedBox(height: 24.0),
        _sectionTitle('7. Pitfalls', Icons.warning_amber, Colors.red),
        pitfalls,
        SizedBox(height: 24.0),
        _sectionTitle('8. Footer', Icons.bookmark, Colors.blueGrey),
        footer,
      ],
    ),
  );
}

// ----------------------------------------------------------------
// Helper widgets
// ----------------------------------------------------------------

Widget _heroChip(String text, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14.0),
        SizedBox(width: 6.0),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _sectionTitle(String text, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.18),
          color.withValues(alpha: 0.05),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _primerBullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.adjust, size: 14.0, color: Colors.indigo.shade400),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13.0, color: Colors.indigo.shade900),
          ),
        ),
      ],
    ),
  );
}

Widget _platformRow(IconData icon, String platform, String mapping, Color color) {
  return Row(
    children: [
      Icon(icon, color: color, size: 14.0),
      SizedBox(width: 6.0),
      Text(
        '$platform: ',
        style: TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      Expanded(
        child: Text(
          mapping,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.grey.shade800,
          ),
        ),
      ),
    ],
  );
}

Widget _miniKeyboardKey(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, Color.alphaBlend(Colors.black12, color)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(6.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.45),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _mockKeyboard(String name, String actionLabel, Color color) {
  // A schematic 3-row keyboard with a highlighted action key on the right.
  const rows = [
    'qwertyuiop',
    'asdfghjkl',
    'zxcvbnm',
  ];
  return Container(
    width: 280.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade200, Colors.grey.shade400],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '.${name}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_drop_down, size: 14.0, color: Colors.grey.shade700),
          ],
        ),
        SizedBox(height: 8.0),
        for (final row in rows)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final ch in row.split(''))
                  Container(
                    width: 18.0,
                    height: 22.0,
                    margin: EdgeInsets.symmetric(horizontal: 1.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 1.0,
                          offset: Offset(0.0, 1.0),
                        ),
                      ],
                    ),
                    child: Text(
                      ch,
                      style: TextStyle(fontSize: 9.0, color: Colors.black87),
                    ),
                  ),
              ],
            ),
          ),
        SizedBox(height: 4.0),
        // Spacebar + action key row
        Row(
          children: [
            Container(
              width: 36.0,
              height: 24.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text('123',
                  style: TextStyle(fontSize: 9.0, color: Colors.black87)),
            ),
            SizedBox(width: 4.0),
            Expanded(
              child: Container(
                height: 24.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text('space',
                    style: TextStyle(fontSize: 9.0, color: Colors.black54)),
              ),
            ),
            SizedBox(width: 4.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, Color.alphaBlend(Colors.black26, color)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(4.0),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.5),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Text(
                actionLabel,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _comparisonRow(
    String useCase, String kbType, String action, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.12),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 110.0,
          child: Text(
            useCase,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            kbType,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.indigo.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            action,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.deepPurple.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _recipeCard({
  required String title,
  required Color color,
  required IconData icon,
  required String description,
  required String code,
  required Widget body,
}) {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.06),
          color.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.22),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          description,
          style: TextStyle(fontSize: 13.0, color: Colors.black87, height: 1.3),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: body,
        ),
      ],
    ),
  );
}

Widget _pitfall({
  required IconData icon,
  required String title,
  required String body,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.red.shade700, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.red.shade900,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

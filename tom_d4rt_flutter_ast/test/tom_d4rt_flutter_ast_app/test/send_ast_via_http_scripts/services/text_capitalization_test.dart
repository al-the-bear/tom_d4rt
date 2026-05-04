// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_import
// D4rt test script: TextCapitalization enum from package:flutter/services.dart
// Deep Demo: Visual demonstration of the four TextCapitalization modes —
// `words`, `sentences`, `characters`, `none` — with mock-keyboard previews,
// shift-state indicators, side-by-side input/output transformations, recipes
// showing the TextField.textCapitalization parameter, an IME-vs-app
// responsibility diagram, and a list of platform pitfalls.
//
// This file is consumed by the d4rt interpreter as an AST and rendered via
// the AST-over-HTTP harness; the test is purely declarative — no test() or
// expect() calls are present, no animation controllers are constructed, and
// any motion references AlwaysStoppedAnimation<double> with Duration.zero so
// the harness can build the widget tree once and snapshot it deterministically.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('TextCapitalization Deep Demo executing');
  print('Today is a great day to learn about TextCapitalization!');

  // A static, non-running animation reference. We intentionally never tick
  // any controller — the harness must be able to render this tree exactly
  // once and capture its visual output without time advancing.
  final AlwaysStoppedAnimation<double> stillness =
      AlwaysStoppedAnimation<double>(0.0);
  final Duration noMotion = Duration.zero;
  print('Stillness animation status: ${stillness.status}');
  print('Motion duration: $noMotion');

  // ============================================================
  // Sample inputs reused throughout the demo so users can compare
  // identical strings under different capitalization modes.
  // ============================================================
  final List<String> sampleInputs = <String>[
    'hello world from flutter.',
    'a quick brown fox. lazy dogs jump high.',
    'the answer is 42 — keep calm and carry on.',
    'multi-word phrases like "ad hoc" stay tricky.',
    'i type fast. she types faster. they type fastest!',
  ];

  print('=== Section 1: Hero Header ===');

  // ============================================================
  // SECTION 1: Hero Header
  // ============================================================
  final Widget heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.indigo.shade700,
          Colors.purple.shade600,
          Colors.pink.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 18.0,
          spreadRadius: 1.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.25),
          blurRadius: 36.0,
          offset: Offset(0.0, 16.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: Icon(Icons.keyboard, size: 44.0, color: Colors.white),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'TextCapitalization',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/services.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'monospace',
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Text(
          'Hint to the platform IME about how to capitalize letters as the '
          'user types. Flutter does NOT transform what you type — it asks '
          'the keyboard to suggest a capitalization style. The actual '
          'enforcement (and the visible Shift indicator) is the keyboard\'s '
          'job, not the framework\'s.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.95),
            height: 1.4,
          ),
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final TextCapitalization v in TextCapitalization.values)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.45),
                    width: 1.0,
                  ),
                ),
                child: Text(
                  '${v.index}. ${v.name}',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'monospace',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
  print('Hero header built');

  print('=== Section 2: Anatomy / Enum Signature ===');

  // ============================================================
  // SECTION 2: Anatomy & Enum Signature
  // ============================================================
  final Widget anatomyCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Enum Anatomy',
              style: TextStyle(
                color: Colors.cyan.shade200,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.cyan.shade700.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Text(
            'enum TextCapitalization {\n'
            '  // Capitalize the first letter of every word.\n'
            '  words,\n'
            '  // Capitalize the first letter of every sentence.\n'
            '  sentences,\n'
            '  // Capitalize every letter (Caps-Lock style).\n'
            '  characters,\n'
            '  // No automatic capitalization (default).\n'
            '  none,\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: Colors.greenAccent.shade100,
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        _buildAnatomyRow(
          'Library',
          'package:flutter/services.dart',
          Icons.inventory_2,
        ),
        _buildAnatomyRow(
          'Length',
          '${TextCapitalization.values.length} values',
          Icons.format_list_numbered,
        ),
        _buildAnatomyRow(
          'First',
          '${TextCapitalization.values.first.name} '
              '(index ${TextCapitalization.values.first.index})',
          Icons.first_page,
        ),
        _buildAnatomyRow(
          'Last',
          '${TextCapitalization.values.last.name} '
              '(index ${TextCapitalization.values.last.index})',
          Icons.last_page,
        ),
        _buildAnatomyRow(
          'Default',
          'TextCapitalization.none',
          Icons.flag,
        ),
        _buildAnatomyRow(
          'Used by',
          'TextField, TextFormField, EditableText',
          Icons.widgets,
        ),
      ],
    ),
  );
  for (final TextCapitalization v in TextCapitalization.values) {
    print('  enum value: ${v.name} -> index ${v.index}');
  }

  print('=== Section 3: Per-Value Cards ===');

  // ============================================================
  // SECTION 3: Per-Value Cards
  // ============================================================
  final List<_CapDescriptor> descriptors = <_CapDescriptor>[
    _CapDescriptor(
      value: TextCapitalization.words,
      title: 'Words',
      subtitle: 'Capitalize every word',
      icon: Icons.title,
      accent: Colors.teal,
      gradient: <Color>[Colors.teal.shade100, Colors.teal.shade300],
      shiftMode: 'auto-cycle',
      transform: _capitalizeWords,
      use: 'Names, titles, addresses, tags',
      example: 'jane doe -> Jane Doe',
    ),
    _CapDescriptor(
      value: TextCapitalization.sentences,
      title: 'Sentences',
      subtitle: 'Capitalize the first letter of each sentence',
      icon: Icons.short_text,
      accent: Colors.indigo,
      gradient: <Color>[Colors.indigo.shade100, Colors.indigo.shade300],
      shiftMode: 'first letter only',
      transform: _capitalizeSentences,
      use: 'Comments, free-form descriptions, chat',
      example: 'hello. how are you? -> Hello. How are you?',
    ),
    _CapDescriptor(
      value: TextCapitalization.characters,
      title: 'Characters',
      subtitle: 'Caps-Lock the entire input',
      icon: Icons.text_fields,
      accent: Colors.deepOrange,
      gradient: <Color>[Colors.deepOrange.shade100, Colors.deepOrange.shade300],
      shiftMode: 'caps-lock',
      transform: _capitalizeCharacters,
      use: 'Country/airport codes, license plates',
      example: 'fra -> FRA',
    ),
    _CapDescriptor(
      value: TextCapitalization.none,
      title: 'None',
      subtitle: 'Leave the user\'s typing untouched',
      icon: Icons.lock_open,
      accent: Colors.blueGrey,
      gradient: <Color>[Colors.blueGrey.shade100, Colors.blueGrey.shade300],
      shiftMode: 'manual',
      transform: _capitalizeNone,
      use: 'Passwords, usernames, code identifiers',
      example: 'kEepCaSe -> kEepCaSe',
    ),
  ];

  final List<Widget> perValueCards = <Widget>[];
  for (final _CapDescriptor d in descriptors) {
    print('  card: ${d.value.name} (${d.title}) -- ${d.example}');
    perValueCards.add(_buildPerValueCard(d, sampleInputs.first));
  }

  print('=== Section 4: Mock Keyboard Previews ===');

  // ============================================================
  // SECTION 4: Mock Keyboard Previews
  // ============================================================
  final List<Widget> keyboardPreviews = <Widget>[];
  for (final _CapDescriptor d in descriptors) {
    keyboardPreviews.add(_buildMockKeyboard(d));
    print('  keyboard preview: ${d.value.name}, shift=${d.shiftMode}');
  }

  print('=== Section 5: Side-by-side transformation table ===');

  // ============================================================
  // SECTION 5: Side-by-side Input Transformation Table
  // ============================================================
  final Widget transformationTable = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.amber.shade50, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.compare_arrows,
                color: Colors.deepOrange.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Same Input, Four Modes',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'For illustration only — Flutter does not perform these '
          'transformations itself. The platform IME does (or does not).',
          style: TextStyle(
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
            color: Colors.deepOrange.shade700,
          ),
        ),
        SizedBox(height: 14.0),
        // Header row
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade300,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: <Widget>[
              _tableHeader('Input', flex: 4),
              _tableHeader('words', flex: 3),
              _tableHeader('sentences', flex: 3),
              _tableHeader('characters', flex: 3),
              _tableHeader('none', flex: 3),
            ],
          ),
        ),
        SizedBox(height: 6.0),
        for (int i = 0; i < sampleInputs.length; i++)
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
            decoration: BoxDecoration(
              color: i.isEven
                  ? Colors.white.withValues(alpha: 0.7)
                  : Colors.amber.shade50.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(6.0),
              border: Border(
                bottom: BorderSide(
                  color: Colors.orange.shade200,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _tableCell(sampleInputs[i], flex: 4, mono: true),
                _tableCell(_capitalizeWords(sampleInputs[i]),
                    flex: 3, mono: true, accent: Colors.teal.shade800),
                _tableCell(_capitalizeSentences(sampleInputs[i]),
                    flex: 3, mono: true, accent: Colors.indigo.shade700),
                _tableCell(_capitalizeCharacters(sampleInputs[i]),
                    flex: 3, mono: true, accent: Colors.deepOrange.shade800),
                _tableCell(_capitalizeNone(sampleInputs[i]),
                    flex: 3, mono: true, accent: Colors.blueGrey.shade700),
              ],
            ),
          ),
      ],
    ),
  );
  print('Transformation table contains ${sampleInputs.length} input rows');

  print('=== Section 6: Recipes ===');

  // ============================================================
  // SECTION 6: Recipes (TextField textCapitalization parameter)
  // ============================================================
  final Widget recipes = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book_outlined,
                color: Colors.lightGreenAccent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recipes — TextField.textCapitalization',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreenAccent.shade100,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Drop the parameter into any TextField (or TextFormField, or '
          'EditableText). Pair it with a matching keyboardType and '
          'autocorrect setting for the best UX.',
          style: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        _buildRecipeBlock(
          'Person Name field',
          'TextField(\n'
              '  textCapitalization: TextCapitalization.words,\n'
              '  decoration: InputDecoration(labelText: \'Full name\'),\n'
              '  keyboardType: TextInputType.name,\n'
              '),',
          Colors.tealAccent.shade200,
        ),
        SizedBox(height: 10.0),
        _buildRecipeBlock(
          'Free-form Comment',
          'TextField(\n'
              '  textCapitalization: TextCapitalization.sentences,\n'
              '  maxLines: 4,\n'
              '  decoration: InputDecoration(hintText: \'Tell us more\'),\n'
              '),',
          Colors.lightBlueAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _buildRecipeBlock(
          'Country / Airport code',
          'TextField(\n'
              '  textCapitalization: TextCapitalization.characters,\n'
              '  maxLength: 3,\n'
              '  decoration: InputDecoration(labelText: \'IATA\'),\n'
              '),',
          Colors.orangeAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _buildRecipeBlock(
          'Username / case-sensitive identifier',
          'TextField(\n'
              '  textCapitalization: TextCapitalization.none,\n'
              '  autocorrect: false,\n'
              '  decoration: InputDecoration(labelText: \'Username\'),\n'
              '),',
          Colors.pinkAccent.shade100,
        ),
      ],
    ),
  );
  print('Generated ${descriptors.length} recipes');

  print('=== Section 7: Pitfalls ===');

  // ============================================================
  // SECTION 7: Pitfalls
  // ============================================================
  final List<_Pitfall> pitfalls = <_Pitfall>[
    _Pitfall(
      icon: Icons.warning_amber,
      title: 'IME-dependent enforcement',
      detail: 'TextCapitalization is a HINT to the platform keyboard. '
          'Custom IMEs, hardware keyboards, and software keyboards on '
          'older Android versions may ignore it entirely.',
      tone: Colors.amber,
    ),
    _Pitfall(
      icon: Icons.public_off,
      title: 'iOS vs. Android divergence',
      detail: 'iOS honours all four values reliably. Android maps them to '
          'TYPE_TEXT_FLAG_CAP_* flags which some keyboards (e.g. SwiftKey) '
          'treat as advisory.',
      tone: Colors.deepOrange,
    ),
    _Pitfall(
      icon: Icons.keyboard_hide,
      title: 'Hardware keyboards bypass it',
      detail: 'Bluetooth keyboards, USB keyboards, and emulator host-keyboard '
          'input do NOT consult the IME hint — what you type is what you get.',
      tone: Colors.red,
    ),
    _Pitfall(
      icon: Icons.transform,
      title: 'No retroactive transformation',
      detail: 'Changing textCapitalization at runtime affects FUTURE keystrokes '
          'only. Existing controller text is never rewritten by Flutter.',
      tone: Colors.purple,
    ),
    _Pitfall(
      icon: Icons.web,
      title: 'Web inconsistency',
      detail: 'On Flutter web the value is forwarded to the autocapitalize '
          'HTML attribute — browser support varies, especially on desktop.',
      tone: Colors.blue,
    ),
    _Pitfall(
      icon: Icons.text_format,
      title: 'Validation must NOT rely on it',
      detail: 'Always normalise (.toUpperCase() / .toLowerCase() / .trim()) '
          'inside the validator. Never assume the IME enforced your hint.',
      tone: Colors.teal,
    ),
  ];

  final Widget pitfallList = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.red.shade50, Colors.deepOrange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.12),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.report_problem,
                color: Colors.red.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & Platform Caveats',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        for (final _Pitfall p in pitfalls) _buildPitfallTile(p),
      ],
    ),
  );
  print('Listed ${pitfalls.length} pitfalls');

  print('=== Section 8: IME-vs-app responsibility diagram ===');

  // ============================================================
  // SECTION 8: IME-vs-App Responsibility Diagram
  // ============================================================
  final Widget responsibilityDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Colors.blue.shade50,
          Colors.cyan.shade50,
          Colors.teal.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Text(
          'Who does what?',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Capitalization is a co-operative dance between three actors. '
          'Understanding the boundary prevents 90% of bug reports.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.cyan.shade800,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildResponsibilityActor(
              'Your App',
              Icons.phone_iphone,
              Colors.indigo,
              <String>[
                'Picks a TextCapitalization',
                'Validates final text',
                'Normalises before save',
              ],
            ),
            Icon(Icons.arrow_forward, color: Colors.cyan.shade700, size: 28.0),
            _buildResponsibilityActor(
              'Flutter Engine',
              Icons.flutter_dash,
              Colors.teal,
              <String>[
                'Forwards hint via',
                'TextInputConfiguration',
                'No transformation',
              ],
            ),
            Icon(Icons.arrow_forward, color: Colors.cyan.shade700, size: 28.0),
            _buildResponsibilityActor(
              'Platform IME',
              Icons.keyboard,
              Colors.deepOrange,
              <String>[
                'Decides Shift state',
                'Suggests capitalization',
                'Sends final keys',
              ],
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.cyan.shade200),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.lightbulb,
                  color: Colors.amber.shade700, size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'TL;DR — your app sets a hint, the engine forwards it, the '
                  'keyboard decides whether to honour it. Always validate.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Built responsibility diagram');

  print('=== Section 9: ASCII footer ===');

  // ============================================================
  // SECTION 9: ASCII Footer
  // ============================================================
  final String asciiArt = ''
      '+======================================================+\n'
      '|   T E X T   C A P I T A L I Z A T I O N             |\n'
      '+------------------------------------------------------+\n'
      '|  words      => Hello World From Flutter             |\n'
      '|  sentences  => Hello world from flutter             |\n'
      '|  characters => HELLO WORLD FROM FLUTTER             |\n'
      '|  none       => hello world from flutter             |\n'
      '+------------------------------------------------------+\n'
      '|  flutter --> engine --> IME --> user keystrokes     |\n'
      '+======================================================+';

  final Widget asciiFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.black, Colors.blueGrey.shade900],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.terminal,
                color: Colors.greenAccent.shade200, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'tom@d4rt:~/services\$',
              style: TextStyle(
                color: Colors.greenAccent.shade200,
                fontFamily: 'monospace',
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          asciiArt,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: Colors.greenAccent.shade100,
            height: 1.35,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          '# end of demo — return MaterialApp(home: Scaffold(body: ...))',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.cyan.shade200,
          ),
        ),
      ],
    ),
  );
  print('ASCII footer prepared');

  print('TextCapitalization Deep Demo build complete');

  // ============================================================
  // Final assembly — single MaterialApp(home: Scaffold(body: ...))
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TextCapitalization Deep Demo',
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              heroHeader,
              SizedBox(height: 20.0),

              _buildSectionTitle('1. Anatomy & Enum Signature',
                  Icons.account_tree, Colors.indigo),
              anatomyCard,
              SizedBox(height: 18.0),

              _buildSectionTitle(
                  '2. The Four Modes', Icons.style, Colors.teal),
              SizedBox(height: 8.0),
              for (final Widget w in perValueCards) ...<Widget>[
                w,
                SizedBox(height: 12.0),
              ],

              SizedBox(height: 6.0),
              _buildSectionTitle('3. Mock Keyboard Previews',
                  Icons.keyboard_alt, Colors.deepOrange),
              SizedBox(height: 8.0),
              for (final Widget w in keyboardPreviews) ...<Widget>[
                w,
                SizedBox(height: 12.0),
              ],

              SizedBox(height: 6.0),
              _buildSectionTitle('4. Side-by-side Transformations',
                  Icons.compare_arrows, Colors.orange),
              transformationTable,
              SizedBox(height: 18.0),

              _buildSectionTitle(
                  '5. Recipes', Icons.restaurant_menu, Colors.green),
              recipes,
              SizedBox(height: 18.0),

              _buildSectionTitle(
                  '6. Pitfalls', Icons.report_problem, Colors.red),
              pitfallList,
              SizedBox(height: 18.0),

              _buildSectionTitle('7. IME vs. App Responsibilities',
                  Icons.account_tree_outlined, Colors.cyan),
              responsibilityDiagram,
              SizedBox(height: 18.0),

              _buildSectionTitle(
                  '8. ASCII Console Footer', Icons.terminal, Colors.black87),
              asciiFooter,
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// Section title helper
// ============================================================
Widget _buildSectionTitle(String text, IconData icon, Color accent) {
  return Container(
    margin: EdgeInsets.only(top: 8.0, bottom: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          accent.withValues(alpha: 0.12),
          accent.withValues(alpha: 0.04),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: accent, width: 4.0),
      ),
    ),
    child: Row(
      children: <Widget>[
        Icon(icon, color: accent, size: 22.0),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: accent,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Anatomy row helper
// ============================================================
Widget _buildAnatomyRow(String label, String value, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: Colors.cyan.shade300, size: 16.0),
        SizedBox(width: 8.0),
        SizedBox(
          width: 80.0,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.cyan.shade100,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Per-value card builder
// ============================================================
Widget _buildPerValueCard(_CapDescriptor d, String sample) {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: d.gradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: d.accent.shade400, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: d.accent.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: d.accent.withValues(alpha: 0.3),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Icon(d.icon, color: d.accent.shade700, size: 28.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'TextCapitalization.${d.value.name}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: d.accent.shade900,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    d.subtitle,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: d.accent.shade800,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: d.accent.shade400, width: 1.0),
              ),
              child: Text(
                'idx ${d.value.index}',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: d.accent.shade800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // Sample input/output
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: d.accent.shade200,
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildInOutRow('input ', sample, Colors.blueGrey.shade700),
              SizedBox(height: 4.0),
              _buildInOutRow(
                'output',
                d.transform(sample),
                d.accent.shade900,
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            Expanded(
              child: _buildMetaPill(
                  'Use cases', d.use, d.accent, Icons.workspaces_outline),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _buildMetaPill(
                  'Example', d.example, d.accent, Icons.science),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================
// In/out row inside per-value card
// ============================================================
Widget _buildInOutRow(String label, String text, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: color,
          ),
        ),
      ),
    ],
  );
}

// ============================================================
// Meta pill helper
// ============================================================
Widget _buildMetaPill(
    String label, String value, MaterialColor accent, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: accent.shade300.withValues(alpha: 0.7),
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, size: 12.0, color: accent.shade700),
            SizedBox(width: 4.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: accent.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            fontSize: 11.0,
            color: accent.shade900,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Mock keyboard preview
// ============================================================
Widget _buildMockKeyboard(_CapDescriptor d) {
  // Choose a Shift visual based on the mode.
  final bool shiftLatched = d.value == TextCapitalization.characters;
  final bool shiftActive = d.value == TextCapitalization.words ||
      d.value == TextCapitalization.sentences;
  final Color shiftColor = shiftLatched
      ? Colors.deepOrange.shade600
      : (shiftActive ? Colors.indigo.shade600 : Colors.blueGrey.shade400);
  final String shiftLabel = shiftLatched
      ? 'CAPS'
      : (shiftActive ? 'SHIFT' : 'shift');

  // Two rows of keys; the displayed face changes based on mode.
  final List<String> row1 = <String>['q', 'w', 'e', 'r', 't', 'y'];
  final List<String> row2 = <String>['a', 's', 'd', 'f', 'g', 'h'];

  String face(String c) {
    switch (d.value) {
      case TextCapitalization.characters:
        return c.toUpperCase();
      case TextCapitalization.words:
      case TextCapitalization.sentences:
        // Visual cue: first key on row 1 shown capitalized.
        return c == row1.first ? c.toUpperCase() : c;
      case TextCapitalization.none:
        return c;
    }
  }

  Widget keyCap(String label) {
    return Container(
      width: 38.0,
      height: 44.0,
      margin: EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Colors.grey.shade50, Colors.grey.shade300],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.grey.shade400, width: 0.8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 1.5,
            offset: Offset(0.0, 1.5),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 14.0,
          color: Colors.blueGrey.shade900,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          d.accent.shade50,
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: d.accent.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: d.accent.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.keyboard, color: d.accent.shade700, size: 18.0),
            SizedBox(width: 6.0),
            Text(
              'Mock keyboard — ${d.value.name}',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: d.accent.shade800,
              ),
            ),
            Spacer(),
            // Shift indicator
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: shiftColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: shiftColor, width: 1.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    shiftLatched
                        ? Icons.lock
                        : (shiftActive
                            ? Icons.arrow_upward
                            : Icons.arrow_upward_outlined),
                    size: 12.0,
                    color: shiftColor,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    shiftLabel,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: shiftColor,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Shift state: ${d.shiftMode}',
          style: TextStyle(
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
            color: d.accent.shade700,
          ),
        ),
        SizedBox(height: 10.0),
        // Preview text strip
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            d.transform('the quick brown fox jumps over the lazy dog'),
            style: TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: Colors.blueGrey.shade900,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        // Two rows of key caps
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[for (final String c in row1) keyCap(face(c))],
        ),
        SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[for (final String c in row2) keyCap(face(c))],
        ),
        SizedBox(height: 6.0),
        // Spacebar row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 60.0,
              height: 32.0,
              margin: EdgeInsets.symmetric(horizontal: 3.0),
              decoration: BoxDecoration(
                color: shiftColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: shiftColor, width: 1.0),
              ),
              alignment: Alignment.center,
              child: Text(
                shiftLabel,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: shiftColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 180.0,
              height: 32.0,
              margin: EdgeInsets.symmetric(horizontal: 3.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Colors.grey.shade50, Colors.grey.shade300],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade400),
              ),
              alignment: Alignment.center,
              child: Text(
                'space',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: Colors.blueGrey.shade700,
                ),
              ),
            ),
            Container(
              width: 60.0,
              height: 32.0,
              margin: EdgeInsets.symmetric(horizontal: 3.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.blueGrey.shade400),
              ),
              alignment: Alignment.center,
              child: Text(
                'enter',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: Colors.blueGrey.shade800,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================
// Table helpers
// ============================================================
Widget _tableHeader(String text, {required int flex}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11.5,
          color: Colors.white,
          fontFamily: 'monospace',
        ),
      ),
    ),
  );
}

Widget _tableCell(
  String text, {
  required int flex,
  bool mono = false,
  Color accent = Colors.black87,
}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: mono ? 'monospace' : null,
          fontSize: 10.5,
          color: accent,
          height: 1.25,
        ),
      ),
    ),
  );
}

// ============================================================
// Recipe block helper
// ============================================================
Widget _buildRecipeBlock(String title, String code, Color titleColor) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: titleColor.withValues(alpha: 0.5),
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: titleColor, size: 14.0),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.grey.shade100,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Pitfall tile helper
// ============================================================
Widget _buildPitfallTile(_Pitfall p) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: p.tone, width: 4.0),
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: p.tone.withValues(alpha: 0.12),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(p.icon, color: p.tone, size: 22.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                p.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: p.tone,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                p.detail,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.blueGrey.shade900,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Responsibility actor helper
// ============================================================
Widget _buildResponsibilityActor(
  String name,
  IconData icon,
  MaterialColor color,
  List<String> bullets,
) {
  return Container(
    width: 130.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.shade100,
          color.shade50,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade400, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 5.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Icon(icon, size: 32.0, color: color.shade700),
        SizedBox(height: 6.0),
        Text(
          name,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        for (final String b in bullets)
          Padding(
            padding: EdgeInsets.only(bottom: 2.0),
            child: Text(
              '- $b',
              style: TextStyle(
                fontSize: 9.5,
                color: color.shade800,
                height: 1.25,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    ),
  );
}

// ============================================================
// Pure-Dart capitalization simulators (illustration only)
// ============================================================
String _capitalizeNone(String input) => input;

String _capitalizeCharacters(String input) => input.toUpperCase();

String _capitalizeWords(String input) {
  if (input.isEmpty) return input;
  final List<String> parts = input.split(' ');
  final List<String> out = <String>[];
  for (final String p in parts) {
    if (p.isEmpty) {
      out.add(p);
    } else {
      out.add('${p.substring(0, 1).toUpperCase()}${p.substring(1)}');
    }
  }
  return out.join(' ');
}

String _capitalizeSentences(String input) {
  if (input.isEmpty) return input;
  final StringBuffer buf = StringBuffer();
  bool capitalizeNext = true;
  for (int i = 0; i < input.length; i++) {
    final String ch = input[i];
    if (capitalizeNext && _isLetter(ch)) {
      buf.write(ch.toUpperCase());
      capitalizeNext = false;
    } else {
      buf.write(ch);
    }
    if (ch == '.' || ch == '!' || ch == '?') {
      capitalizeNext = true;
    }
  }
  return buf.toString();
}

bool _isLetter(String ch) {
  if (ch.isEmpty) return false;
  final int code = ch.codeUnitAt(0);
  return (code >= 0x41 && code <= 0x5A) || (code >= 0x61 && code <= 0x7A);
}

// ============================================================
// Internal data classes
// ============================================================
class _CapDescriptor {
  _CapDescriptor({
    required this.value,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.gradient,
    required this.shiftMode,
    required this.transform,
    required this.use,
    required this.example,
  });

  final TextCapitalization value;
  final String title;
  final String subtitle;
  final IconData icon;
  final MaterialColor accent;
  final List<Color> gradient;
  final String shiftMode;
  final String Function(String) transform;
  final String use;
  final String example;
}

class _Pitfall {
  _Pitfall({
    required this.icon,
    required this.title,
    required this.detail,
    required this.tone,
  });

  final IconData icon;
  final String title;
  final String detail;
  final MaterialColor tone;
}

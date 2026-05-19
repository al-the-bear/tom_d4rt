// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt test script: Deep visual demo of the Unicode bidi-control constants
// from package:flutter/foundation.dart (Unicode.LRE, RLE, PDF, LRO, RLO, LRI,
// RLI, FSI, PDI, LRM, RLM, ALM).
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ============================================================================
// Constant metadata model: name, code-point, full Unicode title, semantic
// family, primary swatch, glyph hint, and a one-line behavioural description.
// ============================================================================
class _BidiConstant {
  const _BidiConstant({
    required this.name,
    required this.character,
    required this.codePoint,
    required this.title,
    required this.family,
    required this.swatch,
    required this.hint,
    required this.summary,
  });

  final String name;
  final String character;
  final String codePoint;
  final String title;
  final String family;
  final MaterialColor swatch;
  final String hint;
  final String summary;
}

// ============================================================================
// build(context): assembles ten themed sections into one Scaffold/SingleChild
// scroll layout. Pure visual, static motion only. Returns MaterialApp.
// ============================================================================
dynamic build(BuildContext context) {
  // --------------------------------------------------------------------------
  // Static motion: explicit AlwaysStoppedAnimation rails so the file shows
  // animation API surfaces without ever ticking. Duration.zero is reused as a
  // semantic "no transition" marker for the recipe section.
  // --------------------------------------------------------------------------
  final AlwaysStoppedAnimation<double> railFade = AlwaysStoppedAnimation<double>(1.0);
  final AlwaysStoppedAnimation<double> railHalf = AlwaysStoppedAnimation<double>(0.5);
  final AlwaysStoppedAnimation<double> railQuarter = AlwaysStoppedAnimation<double>(0.25);
  final AlwaysStoppedAnimation<double> railThreeQuarter = AlwaysStoppedAnimation<double>(0.75);
  final Duration zeroDuration = Duration.zero;

  // --------------------------------------------------------------------------
  // Master constant table - every Unicode bidi character exposed by Flutter.
  // --------------------------------------------------------------------------
  final List<_BidiConstant> constants = <_BidiConstant>[
    _BidiConstant(
      name: 'LRE',
      character: Unicode.LRE,
      codePoint: 'U+202A',
      title: 'LEFT-TO-RIGHT EMBEDDING',
      family: 'Embedding',
      swatch: Colors.blue,
      hint: 'soft LTR push',
      summary: 'Open an LTR embedding scope - close with PDF.',
    ),
    _BidiConstant(
      name: 'RLE',
      character: Unicode.RLE,
      codePoint: 'U+202B',
      title: 'RIGHT-TO-LEFT EMBEDDING',
      family: 'Embedding',
      swatch: Colors.indigo,
      hint: 'soft RTL push',
      summary: 'Open an RTL embedding scope - close with PDF.',
    ),
    _BidiConstant(
      name: 'PDF',
      character: Unicode.PDF,
      codePoint: 'U+202C',
      title: 'POP DIRECTIONAL FORMATTING',
      family: 'Pop',
      swatch: Colors.grey,
      hint: 'pop embed/override',
      summary: 'Close the most recent LRE / RLE / LRO / RLO scope.',
    ),
    _BidiConstant(
      name: 'LRO',
      character: Unicode.LRO,
      codePoint: 'U+202D',
      title: 'LEFT-TO-RIGHT OVERRIDE',
      family: 'Override',
      swatch: Colors.cyan,
      hint: 'force LTR rendering',
      summary: 'Force following text to render LTR (even Hebrew).',
    ),
    _BidiConstant(
      name: 'RLO',
      character: Unicode.RLO,
      codePoint: 'U+202E',
      title: 'RIGHT-TO-LEFT OVERRIDE',
      family: 'Override',
      swatch: Colors.deepPurple,
      hint: 'force RTL rendering',
      summary: 'Force following text to render RTL (English appears mirrored).',
    ),
    _BidiConstant(
      name: 'LRI',
      character: Unicode.LRI,
      codePoint: 'U+2066',
      title: 'LEFT-TO-RIGHT ISOLATE',
      family: 'Isolate',
      swatch: Colors.teal,
      hint: 'LTR sandbox',
      summary: 'Isolated LTR scope - close with PDI.',
    ),
    _BidiConstant(
      name: 'RLI',
      character: Unicode.RLI,
      codePoint: 'U+2067',
      title: 'RIGHT-TO-LEFT ISOLATE',
      family: 'Isolate',
      swatch: Colors.pink,
      hint: 'RTL sandbox',
      summary: 'Isolated RTL scope - close with PDI.',
    ),
    _BidiConstant(
      name: 'FSI',
      character: Unicode.FSI,
      codePoint: 'U+2068',
      title: 'FIRST STRONG ISOLATE',
      family: 'Isolate',
      swatch: Colors.amber,
      hint: 'auto-detect direction',
      summary: 'Auto-detect direction from first strong char - close with PDI.',
    ),
    _BidiConstant(
      name: 'PDI',
      character: Unicode.PDI,
      codePoint: 'U+2069',
      title: 'POP DIRECTIONAL ISOLATE',
      family: 'Pop',
      swatch: Colors.brown,
      hint: 'pop isolate',
      summary: 'Close the most recent LRI / RLI / FSI scope.',
    ),
    _BidiConstant(
      name: 'LRM',
      character: Unicode.LRM,
      codePoint: 'U+200E',
      title: 'LEFT-TO-RIGHT MARK',
      family: 'Mark',
      swatch: Colors.lightBlue,
      hint: 'invisible LTR pin',
      summary: 'Zero-width strong-LTR character - resolves neutral runs.',
    ),
    _BidiConstant(
      name: 'RLM',
      character: Unicode.RLM,
      codePoint: 'U+200F',
      title: 'RIGHT-TO-LEFT MARK',
      family: 'Mark',
      swatch: Colors.deepOrange,
      hint: 'invisible RTL pin',
      summary: 'Zero-width strong-RTL character - resolves neutral runs.',
    ),
    _BidiConstant(
      name: 'ALM',
      character: Unicode.ALM,
      codePoint: 'U+061C',
      title: 'ARABIC LETTER MARK',
      family: 'Mark',
      swatch: Colors.red,
      hint: 'invisible Arabic pin',
      summary: 'Zero-width strong-RTL Arabic-classified mark.',
    ),
  ];

  // --------------------------------------------------------------------------
  // Section 1: Hero header. Big gradient banner with title, subtitle, count
  // chips, and a strip of the bidi families. Establishes the visual language
  // (deep gradients, rounded corners, soft outer shadows).
  // --------------------------------------------------------------------------
  final Widget heroHeader = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF1A237E),
          Color(0xFF6A1B9A),
          Color(0xFFC2185B),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 28.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 14.0),
        ),
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
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
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 1.5),
              ),
              child: Icon(Icons.text_format, size: 36.0, color: Colors.white),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Unicode',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Bidirectional control characters from flutter/foundation',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _heroChip(Icons.numbers, '${constants.length} constants'),
            _heroChip(Icons.swap_horiz, 'LTR + RTL'),
            _heroChip(Icons.layers, '4 families'),
            _heroChip(Icons.rule, 'TR9 algorithm'),
            _heroChip(Icons.code, 'static const String'),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            'These twelve invisible characters drive the Unicode bidirectional '
            'algorithm (UAX #9). They never produce a glyph - they reshape how '
            'the surrounding strong / weak / neutral characters are ordered.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 13.0,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // Section 2: Anatomy of bidi - explains the four families with iconography.
  // Demonstrates the conceptual difference between embed / override / isolate
  // / mark before drilling into per-constant cards.
  // --------------------------------------------------------------------------
  final Widget anatomySection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.blueGrey.shade50, Colors.indigo.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          icon: Icons.account_tree,
          color: Colors.indigo,
          title: 'Anatomy of bidi control',
          subtitle: 'Four functional families form the bidi vocabulary',
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            _familyTile(
              family: 'Embedding',
              members: 'LRE / RLE',
              icon: Icons.format_indent_increase,
              color: Colors.blue,
              behaviour: 'Soft directional push - inherits surrounding context, ' 'closed with PDF.',
            ),
            _familyTile(
              family: 'Override',
              members: 'LRO / RLO',
              icon: Icons.swap_horizontal_circle,
              color: Colors.deepPurple,
              behaviour: 'Forces every following character to a fixed direction, ' 'closed with PDF.',
            ),
            _familyTile(
              family: 'Isolate',
              members: 'LRI / RLI / FSI',
              icon: Icons.shield,
              color: Colors.teal,
              behaviour: 'Wraps an inner run so it does not affect outer ' 'paragraph direction, closed with PDI.',
            ),
            _familyTile(
              family: 'Mark',
              members: 'LRM / RLM / ALM',
              icon: Icons.push_pin,
              color: Colors.deepOrange,
              behaviour: 'Zero-width strong-direction pin - resolves the ' 'direction of nearby neutral characters.',
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.indigo.shade100, width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 22.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Rule of thumb: prefer ISOLATE (LRI / RLI / FSI / PDI) for new '
                  'code. Embeddings leak; isolates do not. Overrides should be '
                  'reserved for very specific UI tricks like control-character '
                  'visualisers.',
                  style: TextStyle(fontSize: 12.5, color: Colors.indigo.shade900, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // Section 3: Per-constant cards. One panel per Unicode constant in the
  // canonical order. Each card carries: name, code point, swatch ribbon, glyph
  // (rendered with explicit textDirection), summary, sample phrase showing
  // before/after. The card uses gradients tinted by the constant swatch so
  // related families read at a glance.
  // --------------------------------------------------------------------------
  final List<Widget> constantCards = <Widget>[];
  for (int i = 0; i < constants.length; i += 1) {
    final _BidiConstant c = constants[i];
    constantCards.add(_constantCard(c, i));
  }

  // --------------------------------------------------------------------------
  // Section 4: RTL/LTR live scenarios. Side-by-side mini frames illustrating
  // what each control character does to a sample mixed-script sentence.
  // --------------------------------------------------------------------------
  final Widget scenariosSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.20),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          icon: Icons.compare_arrows,
          color: Colors.teal,
          title: 'RTL / LTR scenarios',
          subtitle: 'How a single control character reshapes a sentence',
        ),
        SizedBox(height: 16.0),
        _scenarioRow(
          label: 'Plain mix',
          before: 'order [N°1] is hello',
          after: 'order [N°1] is hello',
          baseDirection: TextDirection.ltr,
          color: Colors.blueGrey,
          note: 'Baseline LTR, no controls.',
        ),
        SizedBox(height: 12.0),
        _scenarioRow(
          label: 'LRE wrap',
          before: 'order is hello',
          after: '${Unicode.LRE}order is hello${Unicode.PDF}',
          baseDirection: TextDirection.ltr,
          color: Colors.blue,
          note: 'LRE...PDF embeds the run as LTR.',
        ),
        SizedBox(height: 12.0),
        _scenarioRow(
          label: 'RLE wrap',
          before: 'shalom world',
          after: '${Unicode.RLE}shalom world${Unicode.PDF}',
          baseDirection: TextDirection.ltr,
          color: Colors.indigo,
          note: 'RLE...PDF embeds the run as RTL.',
        ),
        SizedBox(height: 12.0),
        _scenarioRow(
          label: 'LRO force',
          before: 'forced LTR run',
          after: '${Unicode.LRO}forced LTR run${Unicode.PDF}',
          baseDirection: TextDirection.rtl,
          color: Colors.cyan,
          note: 'Override pins direction even inside RTL paragraph.',
        ),
        SizedBox(height: 12.0),
        _scenarioRow(
          label: 'RLO mirror',
          before: 'HELLO',
          after: '${Unicode.RLO}HELLO${Unicode.PDF}',
          baseDirection: TextDirection.ltr,
          color: Colors.deepPurple,
          note: 'RLO...PDF mirrors a Latin run visually.',
        ),
        SizedBox(height: 12.0),
        _scenarioRow(
          label: 'LRI isolate',
          before: 'tag (run) end',
          after: 'tag ${Unicode.LRI}(run)${Unicode.PDI} end',
          baseDirection: TextDirection.ltr,
          color: Colors.teal,
          note: 'Isolates the inner span so neutrals do not leak out.',
        ),
        SizedBox(height: 12.0),
        _scenarioRow(
          label: 'RLI isolate',
          before: 'name <user> here',
          after: 'name ${Unicode.RLI}<user>${Unicode.PDI} here',
          baseDirection: TextDirection.ltr,
          color: Colors.pink,
          note: 'RLI...PDI sandboxes an RTL fragment in an LTR sentence.',
        ),
        SizedBox(height: 12.0),
        _scenarioRow(
          label: 'FSI auto',
          before: 'val: \"data\"',
          after: 'val: ${Unicode.FSI}"data"${Unicode.PDI}',
          baseDirection: TextDirection.ltr,
          color: Colors.amber,
          note: 'Lets the first strong char inside choose direction.',
        ),
        SizedBox(height: 12.0),
        _scenarioRow(
          label: 'LRM mark',
          before: 'price (USD)',
          after: 'price (USD)${Unicode.LRM}',
          baseDirection: TextDirection.rtl,
          color: Colors.lightBlue,
          note: 'Trailing LRM keeps closing parenthesis attached LTR-side.',
        ),
        SizedBox(height: 12.0),
        _scenarioRow(
          label: 'RLM mark',
          before: '/ separator /',
          after: '${Unicode.RLM}/ separator /${Unicode.RLM}',
          baseDirection: TextDirection.ltr,
          color: Colors.deepOrange,
          note: 'RLM pins neutral slashes to RTL run.',
        ),
        SizedBox(height: 12.0),
        _scenarioRow(
          label: 'ALM mark',
          before: '12:34',
          after: '${Unicode.ALM}12:34',
          baseDirection: TextDirection.rtl,
          color: Colors.red,
          note: 'Arabic Letter Mark joins the run as Arabic-strong.',
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // Section 5: Practical recipes. Curated patterns for common Flutter use
  // cases - logging, file paths, code blocks, mixed-direction usernames.
  // --------------------------------------------------------------------------
  final Widget recipesSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.green.shade50, Colors.lime.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.green.shade200, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          icon: Icons.menu_book,
          color: Colors.green,
          title: 'Practical recipes',
          subtitle: 'Drop-in patterns using Unicode constants in Flutter apps',
        ),
        SizedBox(height: 16.0),
        _recipeCard(
          title: 'Wrap user content as LTR-safe',
          accent: Colors.blue,
          codeLines: <String>[
            "final safe = '\${Unicode.LRI}\$userText\${Unicode.PDI}';",
            'Text(safe, textDirection: paragraphDirection)',
          ],
          note: 'Prevents user-supplied strong-RTL text from flipping the '
              'surrounding UI labels.',
        ),
        SizedBox(height: 12.0),
        _recipeCard(
          title: 'Render literal control character names',
          accent: Colors.deepPurple,
          codeLines: <String>[
            "final glyph = '\${Unicode.LRO}\${value}\${Unicode.PDF}';",
            "Text(glyph, style: TextStyle(fontFamily: 'monospace'))",
          ],
          note: 'LRO + PDF guarantees the glyph renders LTR even when the '
              'paragraph context is RTL.',
        ),
        SizedBox(height: 12.0),
        _recipeCard(
          title: 'Auto-detect email username direction',
          accent: Colors.amber,
          codeLines: <String>[
            "final pretty = 'From: \${Unicode.FSI}\$name\${Unicode.PDI}';",
            'return Text(pretty);',
          ],
          note: 'FSI/PDI lets the first strong character of <name> choose, '
              'avoiding LTR/RTL guesses.',
        ),
        SizedBox(height: 12.0),
        _recipeCard(
          title: 'Pin a neutral suffix to the RTL paragraph',
          accent: Colors.deepOrange,
          codeLines: <String>[
            "final tagged = label + '\${Unicode.RLM}';",
            'Text(tagged, textDirection: TextDirection.rtl)',
          ],
          note: 'RLM glues trailing punctuation to the RTL side so it does '
              'not jump to the visual left.',
        ),
        SizedBox(height: 12.0),
        _recipeCard(
          title: 'Wrap a debug log line',
          accent: Colors.teal,
          codeLines: <String>[
            "final line = '\${Unicode.LRE}\$tag\${Unicode.PDF} \$message';",
            'debugPrint(line);',
          ],
          note: 'LRE/PDF embed the bracketed tag as LTR even if message ' 'contains RTL text.',
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // Section 6: Pitfalls panel. Highlights common mistakes - mismatched POPs,
  // override leaks, mark abuse - with a strong yellow/red palette.
  // --------------------------------------------------------------------------
  final Widget pitfallsSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.amber.shade50, Colors.red.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.amber.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          icon: Icons.warning_amber,
          color: Colors.deepOrange,
          title: 'Pitfalls',
          subtitle: 'Common mistakes when shipping bidi controls',
        ),
        SizedBox(height: 16.0),
        _pitfallTile(
          severity: 'High',
          title: 'Forgetting PDF / PDI',
          colors: <Color>[Colors.red.shade400, Colors.red.shade700],
          body: 'Every LRE / RLE / LRO / RLO must be closed by PDF. Every LRI '
              '/ RLI / FSI must be closed by PDI. Unbalanced controls leak '
              'into the rest of the paragraph.',
        ),
        SizedBox(height: 10.0),
        _pitfallTile(
          severity: 'High',
          title: 'Using RLO for visual mirroring',
          colors: <Color>[Colors.deepOrange.shade400, Colors.deepOrange.shade700],
          body: 'RLO mirrors text but does not reorder semantics. Screen '
              'readers still read it left-to-right - prefer Transform.scale or ' 'real translation.',
        ),
        SizedBox(height: 10.0),
        _pitfallTile(
          severity: 'Medium',
          title: 'Stacking marks unnecessarily',
          colors: <Color>[Colors.amber.shade500, Colors.amber.shade800],
          body: 'Adding LRM / RLM / ALM everywhere bloats strings and confuses '
              'copy/paste. Use one mark exactly where direction resolution ' 'is ambiguous.',
        ),
        SizedBox(height: 10.0),
        _pitfallTile(
          severity: 'Medium',
          title: 'Embedding instead of isolating',
          colors: <Color>[Colors.orange.shade400, Colors.orange.shade700],
          body: 'Old codebases use LRE/RLE for templating. Modern code should '
              'prefer LRI/RLI/FSI - isolates do not affect outer paragraph ' 'direction.',
        ),
        SizedBox(height: 10.0),
        _pitfallTile(
          severity: 'Low',
          title: 'Trusting FSI for short strings',
          colors: <Color>[Colors.yellow.shade700, Colors.amber.shade600],
          body: 'FSI auto-detection picks the first strong character. A leading '
              'quote or emoji can flip the result - test with real data.',
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // Section 7: Comparison matrix - one row per constant covering family,
  // closes-with, neutral effect and recommended use. Pure tabular layout.
  // --------------------------------------------------------------------------
  final Widget comparisonTable = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.grey.shade50, Colors.blueGrey.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.20),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle(
          icon: Icons.table_chart,
          color: Colors.blueGrey,
          title: 'Comparison matrix',
          subtitle: 'All twelve Unicode constants at a glance',
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Colors.blueGrey.shade700, Colors.blueGrey.shade900],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: <Widget>[
              _matrixHeader('Name', 70.0),
              _matrixHeader('Code', 80.0),
              _matrixHeader('Family', 90.0),
              _matrixHeader('Glyph hint', 130.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        for (int i = 0; i < constants.length; i += 1)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: i.isEven ? Colors.white : Colors.blueGrey.shade50,
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: EdgeInsets.only(top: 2.0),
            child: Row(
              children: <Widget>[
                _matrixCell(constants[i].name, 70.0, FontWeight.bold, constants[i].swatch.shade700),
                _matrixCell(constants[i].codePoint, 80.0, FontWeight.normal, Colors.black87),
                _matrixCell(constants[i].family, 90.0, FontWeight.w500, Colors.indigo.shade700),
                _matrixCell(constants[i].hint, 130.0, FontWeight.normal, Colors.black54),
              ],
            ),
          ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // Section 8: Quick reference card. One-screen cheat-sheet using monospace
  // text on a deep background, mimicking a terminal palette.
  // --------------------------------------------------------------------------
  final Widget quickReference = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF0F172A),
          Color(0xFF1E293B),
          Color(0xFF334155),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.cyan.shade400, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.30),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.terminal, color: Colors.cyanAccent, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'quick-reference.md',
              style: TextStyle(
                color: Colors.cyanAccent,
                fontFamily: 'monospace',
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        for (final _BidiConstant c in constants)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontFamily: 'monospace', fontSize: 12.5),
                children: <TextSpan>[
                  TextSpan(
                    text: c.name.padRight(5),
                    style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: c.codePoint.padRight(8),
                    style: TextStyle(color: Colors.amberAccent),
                  ),
                  TextSpan(
                    text: c.family.padRight(11),
                    style: TextStyle(color: Colors.lightGreenAccent),
                  ),
                  TextSpan(
                    text: c.summary,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.85)),
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // Section 9: Code-snippet showcase. Three syntax-highlighted snippets that
  // live as Text widgets - shows realistic call sites for the constants.
  // --------------------------------------------------------------------------
  final Widget codeShowcase = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF111827),
          Color(0xFF1F2937),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, color: Colors.lightBlueAccent, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'code showcase',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontFamily: 'monospace',
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeSnippet(
          label: 'Embed an LTR fragment',
          accent: Colors.lightBlueAccent,
          source: "final mixed = '\${Unicode.LRE}\$ltr\${Unicode.PDF} \$rest';",
        ),
        SizedBox(height: 10.0),
        _codeSnippet(
          label: 'Isolate a username',
          accent: Colors.tealAccent,
          source: "final pretty = '@\${Unicode.LRI}\$username\${Unicode.PDI}';",
        ),
        SizedBox(height: 10.0),
        _codeSnippet(
          label: 'Force RTL (mirroring)',
          accent: Colors.deepPurpleAccent,
          source: "final mirrored = '\${Unicode.RLO}\$ascii\${Unicode.PDF}';",
        ),
        SizedBox(height: 10.0),
        _codeSnippet(
          label: 'Auto-detect direction',
          accent: Colors.amberAccent,
          source: "final auto = '\${Unicode.FSI}\$value\${Unicode.PDI}';",
        ),
        SizedBox(height: 10.0),
        _codeSnippet(
          label: 'Pin trailing punctuation',
          accent: Colors.orangeAccent,
          source: "final pinned = '\$rtlSuffix\${Unicode.RLM}';",
        ),
      ],
    ),
  );

  // --------------------------------------------------------------------------
  // Section 10: ASCII footer. Pure decorative ASCII art establishing the doc
  // ends. Demonstrates static motion via AlwaysStoppedAnimation rails baked
  // into a wrapper that exposes them via Opacity.
  // --------------------------------------------------------------------------
  final Widget asciiFooter = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF0D47A1),
          Color(0xFF311B92),
          Color(0xFF880E4F),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.30),
          blurRadius: 22.0,
          offset: Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Opacity(
      opacity: railFade.value,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '+----------------------------------------+',
            style: TextStyle(fontFamily: 'monospace', color: Colors.white, fontSize: 13.0),
          ),
          Text(
            '|   Unicode bidi control reference deck   |',
            style: TextStyle(fontFamily: 'monospace', color: Colors.white, fontSize: 13.0),
          ),
          Text(
            '|   12 constants  -  4 families  -  TR9   |',
            style: TextStyle(fontFamily: 'monospace', color: Colors.white, fontSize: 13.0),
          ),
          Text(
            '+----------------------------------------+',
            style: TextStyle(fontFamily: 'monospace', color: Colors.white, fontSize: 13.0),
          ),
          SizedBox(height: 16.0),
          Opacity(
            opacity: railThreeQuarter.value,
            child: Text(
              'flutter/foundation - package:flutter/foundation.dart',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Opacity(
            opacity: railHalf.value,
            child: Text(
              'rendered with static motion (zero duration: ${zeroDuration.inMicroseconds}us)',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 11.0,
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Opacity(
            opacity: railQuarter.value,
            child: Text(
              'end of document',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 10.0,
                letterSpacing: 4.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // --------------------------------------------------------------------------
  // Final assembly: SingleChildScrollView containing every section in display
  // order with consistent vertical rhythm.
  // --------------------------------------------------------------------------
  final Widget body = SingleChildScrollView(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        heroHeader,
        SizedBox(height: 8.0),
        anatomySection,
        SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            '3. Per-constant cards',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        ...constantCards,
        SizedBox(height: 16.0),
        scenariosSection,
        SizedBox(height: 16.0),
        recipesSection,
        SizedBox(height: 16.0),
        pitfallsSection,
        SizedBox(height: 16.0),
        comparisonTable,
        SizedBox(height: 16.0),
        quickReference,
        SizedBox(height: 16.0),
        codeShowcase,
        SizedBox(height: 16.0),
        asciiFooter,
      ],
    ),
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F7FB),
      body: body,
    ),
  );
}

// ============================================================================
// _heroChip: pill-style chip used inside the hero header. Translucent white
// over the gradient banner.
// ============================================================================
Widget _heroChip(IconData icon, String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(40.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.45), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: Colors.white, size: 14.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

// ============================================================================
// _sectionTitle: shared title row used by every coloured section.
// ============================================================================
Widget _sectionTitle({
  required IconData icon,
  required Color color,
  required String title,
  required String subtitle,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.45), width: 1.0),
        ),
        child: Icon(icon, color: color, size: 22.0),
      ),
      SizedBox(width: 12.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12.0, color: Colors.black54),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// _familyTile: anatomy-section card describing one bidi family.
// ============================================================================
Widget _familyTile({
  required String family,
  required String members,
  required IconData icon,
  required Color color,
  required String behaviour,
}) {
  return SizedBox(
    width: 240.0,
    child: Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            color.withValues(alpha: 0.10),
            color.withValues(alpha: 0.20),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: color, size: 22.0),
              SizedBox(width: 8.0),
              Text(
                family,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              members,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            behaviour,
            style: TextStyle(fontSize: 11.5, color: Colors.black87, height: 1.4),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// _constantCard: the per-constant panel.
// ============================================================================
Widget _constantCard(_BidiConstant c, int index) {
  // Compose example before/after text demonstrating the constant in action.
  final String beforeSample = _sampleBefore(c);
  final String afterSample = _sampleAfter(c);

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: c.swatch.withValues(alpha: 0.30),
          blurRadius: 14.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Top ribbon with name + code point.
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  c.swatch.shade700,
                  c.swatch.shade400,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '#${(index + 1).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  c.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  c.codePoint,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontFamily: 'monospace',
                    fontSize: 13.0,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
                  ),
                  child: Text(
                    c.family,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Body with summary and before/after demo.
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  c.swatch.shade50,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  c.title,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: c.swatch.shade900,
                    letterSpacing: 0.6,
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  c.summary,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.black87,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 12.0),
                _beforeAfter(
                  swatch: c.swatch,
                  before: beforeSample,
                  after: afterSample,
                  hint: c.hint,
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: c.swatch.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.fingerprint, size: 14.0, color: c.swatch.shade700),
                      SizedBox(width: 6.0),
                      Text(
                        'codeUnit: 0x${c.character.codeUnitAt(0).toRadixString(16).toUpperCase()}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          color: c.swatch.shade900,
                        ),
                      ),
                      SizedBox(width: 14.0),
                      Icon(Icons.straighten, size: 14.0, color: c.swatch.shade700),
                      SizedBox(width: 6.0),
                      Text(
                        'length: ${c.character.length}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          color: c.swatch.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// _sampleBefore / _sampleAfter: generates illustrative phrases for a constant.
// ============================================================================
String _sampleBefore(_BidiConstant c) {
  switch (c.name) {
    case 'LRE':
    case 'RLE':
    case 'LRO':
    case 'RLO':
      return 'price 100 USD';
    case 'PDF':
      return 'open scope';
    case 'LRI':
    case 'RLI':
    case 'FSI':
      return 'value: <data>';
    case 'PDI':
      return 'isolate scope';
    case 'LRM':
      return 'price (USD)';
    case 'RLM':
      return '/ slash /';
    case 'ALM':
      return '12:34';
  }
  return 'sample text';
}

String _sampleAfter(_BidiConstant c) {
  switch (c.name) {
    case 'LRE':
      return '${Unicode.LRE}price 100 USD${Unicode.PDF}';
    case 'RLE':
      return '${Unicode.RLE}price 100 USD${Unicode.PDF}';
    case 'LRO':
      return '${Unicode.LRO}price 100 USD${Unicode.PDF}';
    case 'RLO':
      return '${Unicode.RLO}price 100 USD${Unicode.PDF}';
    case 'PDF':
      return '${Unicode.LRE}open scope${Unicode.PDF} (closed)';
    case 'LRI':
      return '${Unicode.LRI}value: <data>${Unicode.PDI}';
    case 'RLI':
      return '${Unicode.RLI}value: <data>${Unicode.PDI}';
    case 'FSI':
      return '${Unicode.FSI}value: <data>${Unicode.PDI}';
    case 'PDI':
      return '${Unicode.LRI}isolate scope${Unicode.PDI} (closed)';
    case 'LRM':
      return 'price (USD)${Unicode.LRM}';
    case 'RLM':
      return '${Unicode.RLM}/ slash /${Unicode.RLM}';
    case 'ALM':
      return '${Unicode.ALM}12:34';
  }
  return 'sample text';
}

// ============================================================================
// _beforeAfter: side-by-side before/after panels for a constant card.
// ============================================================================
Widget _beforeAfter({
  required MaterialColor swatch,
  required String before,
  required String after,
  required String hint,
}) {
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #20, P1):
  // Row(crossAxisAlignment: stretch) inside the unbounded vertical
  // SingleChildScrollView propagated infinite height. Wrap in
  // IntrinsicHeight so the row sizes to its tallest intrinsic child.
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
      Expanded(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade300, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.label_outline, size: 14.0, color: Colors.grey.shade600),
                  SizedBox(width: 4.0),
                  Text(
                    'before',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey.shade700,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                before,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.black87,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(width: 8.0),
      Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              swatch.shade400,
              swatch.shade700,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(Icons.arrow_forward, color: Colors.white, size: 18.0),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                swatch.shade50,
                swatch.shade100,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: swatch.shade400, width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.bolt, size: 14.0, color: swatch.shade700),
                  SizedBox(width: 4.0),
                  Text(
                    'after  -  $hint',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: swatch.shade700,
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                after,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.black87,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ),
    ],
    ),
  );
}

// ============================================================================
// _scenarioRow: one row inside the scenarios section.
// ============================================================================
Widget _scenarioRow({
  required String label,
  required String before,
  required String after,
  required TextDirection baseDirection,
  required MaterialColor color,
  required String note,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade200, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: color.shade400, width: 1.0),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              baseDirection == TextDirection.ltr ? 'LTR paragraph' : 'RTL paragraph',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #20, P1):
        // Wrap stretch-Row in IntrinsicHeight to bound height.
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('before',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey.shade600,
                          )),
                      SizedBox(height: 4.0),
                      Text(
                        before,
                        textDirection: baseDirection,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'monospace',
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: color.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: color.shade300, width: 1.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('after',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: color.shade700,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 4.0),
                      Text(
                        after,
                        textDirection: baseDirection,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'monospace',
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.info_outline, size: 14.0, color: color.shade700),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                note,
                style: TextStyle(
                  fontSize: 11.5,
                  color: color.shade900,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// _recipeCard: one entry in the recipes panel - title, code lines, footnote.
// ============================================================================
Widget _recipeCard({
  required String title,
  required MaterialColor accent,
  required List<String> codeLines,
  required String note,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.shade200, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
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
              width: 4.0,
              height: 18.0,
              decoration: BoxDecoration(
                color: accent.shade400,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: accent.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (final String line in codeLines)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.0),
                  child: Text(
                    line,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: accent.shade100,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          note,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black87,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// _pitfallTile: warning row in pitfalls section. Severity ribbon + body text.
// ============================================================================
Widget _pitfallTile({
  required String severity,
  required String title,
  required List<Color> colors,
  required String body,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: colors.last.withValues(alpha: 0.45), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: colors.last.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 78.0,
          padding: EdgeInsets.symmetric(vertical: 6.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: Text(
            severity,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: colors.last,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// _matrixHeader / _matrixCell: cells for the comparison matrix.
// ============================================================================
Widget _matrixHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _matrixCell(String text, double width, FontWeight weight, Color color) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: weight,
        color: color,
        fontFamily: 'monospace',
      ),
      overflow: TextOverflow.ellipsis,
    ),
  );
}

// ============================================================================
// _codeSnippet: titled monospace block for the code-showcase section.
// ============================================================================
Widget _codeSnippet({
  required String label,
  required Color accent,
  required String source,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF0F172A),
          Color(0xFF1E293B),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.45), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.chevron_right, color: accent, size: 16.0),
            SizedBox(width: 4.0),
            Text(
              label,
              style: TextStyle(
                color: accent,
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          source,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontFamily: 'monospace',
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

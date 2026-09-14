// ignore_for_file: avoid_print
// D4rt deep demo: SmartDashesType — the enum that controls automatic
// dash replacement behavior in text fields, converting hyphens to
// en-dashes and em-dashes as the user types.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Plum / Orchid palette ───
  const Color plum = Color(0xFF7C3AED);
  const Color orchid = Color(0xFFC084FC);
  const Color deepPlum = Color(0xFF6D28D9);
  const Color paleOrchid = Color(0xFFF5F3FF);
  const Color amethyst = Color(0xFF8B5CF6);
  const Color lilac = Color(0xFFDDD6FE);
  const Color violet = Color(0xFF5B21B6);
  const Color indigo = Color(0xFF4C1D95);
  const Color lavender = Color(0xFFEDE9FE);
  const Color iris = Color(0xFFA78BFA);

  print('[sd] ===== SMART DASHES TYPE DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sdBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [indigo, deepPlum],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: indigo.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: plum,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: orchid, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget sdNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleOrchid,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lilac),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: indigo.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget sdCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lilac.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: indigo.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: plum.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: indigo)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget sdRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? plum.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: lilac.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? indigo : deepPlum)),
          );
        }).toList(),
      ),
    );
  }

  Widget sdFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? indigo : deepPlum,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(steps[i],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      );
      if (i < steps.length - 1) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.arrow_forward, size: 12, color: plum),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is SmartDashesType? ━━━━━━
  print('[sd-01] Section 1: What is SmartDashesType?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('01', 'What Is SmartDashesType?'),
      sdNote(
        'SmartDashesType is an enum that controls whether the platform '
        'keyboard automatically replaces sequences of hyphens with '
        'typographic dashes. Two hyphens become an en-dash (–), and three '
        'become an em-dash (—). This is controlled per text field.',
      ),
      sdCard(
        'Dash Replacements',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sdFlow(['User types --', 'Platform detects', 'SmartDashesType?',
                'Replace with –', 'Display en-dash']),
            const SizedBox(height: 10),
            _sdDashDemo('- (hyphen)', 'U+002D', 'Single keystroke', indigo),
            _sdDashDemo('– (en-dash)', 'U+2013', 'Two hyphens → --', deepPlum),
            _sdDashDemo('— (em-dash)', 'U+2014', 'Three hyphens → ---', plum),
            _sdDashDemo('− (minus)', 'U+2212', 'Math context only', amethyst),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Enum values ━━━━━━
  print('[sd-02] Section 2: Enum values');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('02', 'SmartDashesType Values'),
      sdNote(
        'SmartDashesType has two values: enabled and disabled. When enabled, '
        'the platform keyboard performs automatic dash replacement. When '
        'disabled, hyphens remain as typed. The default depends on the '
        'text field type.',
      ),
      sdCard(
        'Enum Definition',
        Column(
          children: [
            sdRow(['Value', 'Behavior', 'Default For'], isHeader: true),
            sdRow(['enabled', 'Replace -- with – and --- with —', 'TextField']),
            sdRow(['disabled', 'Keep hyphens as-is', 'Code editors']),
          ],
        ),
      ),
      sdCard(
        'Default Behavior',
        Column(
          children: [
            sdRow(['Widget', 'Default', 'Reason'], isHeader: true),
            sdRow(['TextField', 'enabled', 'Natural prose input']),
            sdRow(['CupertinoTextField', 'enabled', 'iOS convention']),
            sdRow(['EditableText', 'disabled', 'Low-level, explicit']),
            sdRow(['TextFormField', 'enabled', 'Wraps TextField']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Typography background ━━━━━━
  print('[sd-03] Section 3: Typography');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('03', 'Typographic Dash Background'),
      sdNote(
        'In typography, different dashes serve different purposes. The '
        'hyphen joins compound words (well-known). The en-dash shows ranges '
        '(2020–2024). The em-dash creates pauses — like this one. Smart '
        'dashes automate typographic correctness.',
      ),
      sdCard(
        'Dash Usage Guide',
        Column(
          children: [
            sdRow(['Dash', 'Name', 'Usage', 'Example'], isHeader: true),
            sdRow(['-', 'Hyphen', 'Compounds', 'self-service']),
            sdRow(['–', 'En-dash', 'Ranges', 'pp. 12–34']),
            sdRow(['—', 'Em-dash', 'Parenthetical', 'She — the CEO — spoke']),
            sdRow(['−', 'Minus', 'Math', '5 − 3 = 2']),
            sdRow(['‐', 'Hyphen (U+2010)', 'Explicit hyphen', 'Line-break hyphen']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Platform behavior ━━━━━━
  print('[sd-04] Section 4: Platform behavior');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('04', 'Platform-Specific Behavior'),
      sdNote(
        'Smart dash replacement is a platform keyboard feature, not Flutter\'s. '
        'iOS and macOS have robust smart dashes. Android\'s behavior varies '
        'by keyboard app (Gboard, Samsung, SwiftKey). Web follows browser '
        'behavior.',
      ),
      sdCard(
        'Platform Matrix',
        Column(
          children: [
            sdRow(['Platform', 'Smart Dashes', 'Notes'], isHeader: true),
            sdRow(['iOS', 'Native', 'System setting + per-field']),
            sdRow(['macOS', 'Native', 'System Preferences toggle']),
            sdRow(['Android', 'Keyboard-dependent', 'Gboard has it']),
            sdRow(['Web', 'Browser-dependent', 'Chrome/Safari differ']),
            sdRow(['Linux', 'IME-dependent', 'Rare']),
            sdRow(['Windows', 'Keyboard-dependent', 'SwiftKey has it']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: TextField configuration ━━━━━━
  print('[sd-05] Section 5: TextField config');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('05', 'TextField Configuration'),
      sdNote(
        'Set smartDashesType on TextField to control dash replacement. '
        'This property sends a flag to the platform keyboard. The platform '
        'decides how to implement it — Flutter doesn\'t do text replacement '
        'itself.',
      ),
      sdCard(
        'Configuration API',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sdCodeLine('TextField(', indigo),
            _sdCodeLine('  smartDashesType:', deepPlum),
            _sdCodeLine('    SmartDashesType.enabled,', plum),
            _sdCodeLine('  // also available:', amethyst),
            _sdCodeLine('  smartQuotesType:', violet),
            _sdCodeLine('    SmartQuotesType.enabled,', violet),
            _sdCodeLine(')', indigo),
            const SizedBox(height: 8),
            sdRow(['Property', 'Type', 'Related'], isHeader: true),
            sdRow(['smartDashesType', 'SmartDashesType?', 'Dash replacement']),
            sdRow(['smartQuotesType', 'SmartQuotesType?', 'Quote replacement']),
            sdRow(['autocorrect', 'bool', 'Spell correction']),
            sdRow(['enableSuggestions', 'bool', 'Word suggestions']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: SmartQuotesType companion ━━━━━━
  print('[sd-06] Section 6: SmartQuotesType');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('06', 'SmartQuotesType Companion'),
      sdNote(
        'SmartQuotesType is the sibling enum that controls automatic '
        'replacement of straight quotes (\' and ") with curly/typographic '
        'quotes (\u2018\u2019 and \u201C\u201D). Both enums work together to control '
        'typographic auto-correction in text fields.',
      ),
      sdCard(
        'Quote Replacements',
        Column(
          children: [
            sdRow(['Input', 'Replaced With', 'Unicode'], isHeader: true),
            sdRow(['" (straight)', '\u201C or \u201D (curly)', 'U+201C / U+201D']),
            sdRow(['\' (straight)', '\u2018 or \u2019 (curly)', 'U+2018 / U+2019']),
          ],
        ),
      ),
      sdCard(
        'Combined Configuration',
        Column(
          children: [
            sdRow(['Scenario', 'Dashes', 'Quotes'], isHeader: true),
            sdRow(['Prose writing', 'enabled', 'enabled']),
            sdRow(['Code editing', 'disabled', 'disabled']),
            sdRow(['Data entry', 'disabled', 'disabled']),
            sdRow(['Markdown', 'disabled', 'disabled']),
            sdRow(['Chat / messaging', 'enabled', 'enabled']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Use cases for disabling ━━━━━━
  print('[sd-07] Section 7: When to disable');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('07', 'When to Disable Smart Dashes'),
      sdNote(
        'Smart dashes should be disabled when exact characters matter: '
        'code editors, command-line input, URLs, file paths, search queries '
        'with symbols, programming languages, and database queries.',
      ),
      sdCard(
        'Disable Scenarios',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sdScenarioItem(Icons.code, 'Code editors', 'Syntax breaks with em-dash', indigo),
            _sdScenarioItem(Icons.link, 'URL fields', 'Dashes in URLs must be exact', deepPlum),
            _sdScenarioItem(Icons.terminal, 'Terminal input', 'CLI flags use hyphens', plum),
            _sdScenarioItem(Icons.search, 'Search queries', 'Operators use hyphens', amethyst),
            _sdScenarioItem(Icons.storage, 'Database queries', 'SQL needs exact chars', violet),
            _sdScenarioItem(Icons.folder, 'File paths', 'Filenames use hyphens', iris),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: TextInputConfiguration ━━━━━━
  print('[sd-08] Section 8: TextInputConfiguration');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('08', 'TextInputConfiguration'),
      sdNote(
        'SmartDashesType is sent to the platform as part of '
        'TextInputConfiguration. This configuration is sent when the text '
        'field gains focus. The platform keyboard reads it and adjusts '
        'its behavior accordingly.',
      ),
      sdCard(
        'Configuration Fields',
        Column(
          children: [
            sdRow(['Field', 'Type', 'Default'], isHeader: true),
            sdRow(['smartDashesType', 'SmartDashesType', 'enabled']),
            sdRow(['smartQuotesType', 'SmartQuotesType', 'enabled']),
            sdRow(['autocorrect', 'bool', 'true']),
            sdRow(['enableSuggestions', 'bool', 'true']),
            sdRow(['keyboardType', 'TextInputType', 'text']),
            sdRow(['textCapitalization', 'TextCapitalization', 'none']),
            sdRow(['inputAction', 'TextInputAction', 'done']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: iOS system settings ━━━━━━
  print('[sd-09] Section 9: iOS settings');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('09', 'iOS System Settings'),
      sdNote(
        'On iOS, smart dashes can be toggled globally in Settings > General > '
        'Keyboard > Smart Punctuation. When the system setting is off, the '
        'per-field SmartDashesType.enabled is ignored. The system setting '
        'takes precedence.',
      ),
      sdCard(
        'Setting Hierarchy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sdHierarchyLevel(1, 'System setting OFF', 'No smart dashes anywhere', indigo),
            _sdHierarchyLevel(2, 'System setting ON', 'Respects per-field setting', deepPlum),
            _sdHierarchyLevel(3, 'Field: enabled', 'Smart dashes active', plum),
            _sdHierarchyLevel(4, 'Field: disabled', 'No replacement', amethyst),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Interaction with autocorrect ━━━━━━
  print('[sd-10] Section 10: Autocorrect interaction');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('10', 'Interaction with Autocorrect'),
      sdNote(
        'Smart dashes, smart quotes, and autocorrect are independent features '
        'that can be enabled/disabled separately. However, they all share the '
        'same keyboard configuration channel. Disabling autocorrect does not '
        'disable smart dashes — they must be set independently.',
      ),
      sdCard(
        'Feature Independence',
        Column(
          children: [
            sdRow(['Feature', 'Controls', 'Independent?'], isHeader: true),
            sdRow(['smartDashesType', 'Dash replacement', 'Yes']),
            sdRow(['smartQuotesType', 'Quote replacement', 'Yes']),
            sdRow(['autocorrect', 'Spell correction', 'Yes']),
            sdRow(['enableSuggestions', 'Word bar', 'Yes']),
            sdRow(['textCapitalization', 'Case rules', 'Yes']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Internationalization ━━━━━━
  print('[sd-11] Section 11: Internationalization');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('11', 'Internationalization'),
      sdNote(
        'Different languages use different dash conventions. German uses '
        'spaced en-dashes for parenthetical asides. French uses em-dashes '
        'for dialogue. CJK text uses different dashes entirely. Smart dashes '
        'follow the active keyboard language.',
      ),
      sdCard(
        'Language Conventions',
        Column(
          children: [
            sdRow(['Language', 'Parenthetical', 'Dialogue'], isHeader: true),
            sdRow(['English', 'em-dash (—)', 'Quotation marks']),
            sdRow(['German', 'en-dash ( – )', 'Quotation marks']),
            sdRow(['French', 'em-dash (—)', 'em-dash (—)']),
            sdRow(['Chinese', '\u2014\u2014 (double)', 'em-dash']),
            sdRow(['Japanese', '\u2015 (horizontal bar)', 'Brackets']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Undo behavior ━━━━━━
  print('[sd-12] Section 12: Undo behavior');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('12', 'Undo & Reversal'),
      sdNote(
        'When a smart dash replacement occurs, the user can typically undo '
        'it immediately by pressing backspace — the platform reverts the '
        'en/em-dash to hyphens. This undo is handled by the platform '
        'keyboard, not by Flutter.',
      ),
      sdCard(
        'Undo Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sdFlow(['Type --', 'Auto-replace –', 'Backspace',
                'Revert to --', 'Hyphens restored']),
            const SizedBox(height: 10),
            sdRow(['Action', 'Before', 'After'], isHeader: true),
            sdRow(['Type --', 'hello--', 'hello–']),
            sdRow(['Backspace', 'hello–', 'hello--']),
            sdRow(['Continue', 'hello--w', 'hello--world']),
            sdRow(['Type ---', 'text---', 'text—']),
            sdRow(['Backspace', 'text—', 'text---']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Accessibility ━━━━━━
  print('[sd-13] Section 13: Accessibility');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('13', 'Accessibility Considerations'),
      sdNote(
        'Screen readers announce dashes differently: hyphen is silent in '
        'compound words, en-dash is read as "to" in ranges, em-dash as a '
        'pause. Smart dashes improve screen reader output by using the '
        'semantically correct character.',
      ),
      sdCard(
        'Screen Reader Behavior',
        Column(
          children: [
            sdRow(['Character', 'VoiceOver', 'TalkBack'], isHeader: true),
            sdRow(['- (hyphen)', 'Silent or "hyphen"', 'Silent or "hyphen"']),
            sdRow(['– (en-dash)', '"to" in ranges', '"to" in ranges']),
            sdRow(['— (em-dash)', 'Pause / "em dash"', 'Pause']),
            sdRow(['-- (two hyphens)', '"hyphen hyphen"', '"dash dash"']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Testing smart dashes ━━━━━━
  print('[sd-14] Section 14: Testing');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('14', 'Testing Smart Dashes'),
      sdNote(
        'Testing smart dashes requires care: platform keyboards in Widget '
        'tests don\'t perform replacements. Test on real devices or use '
        'integration tests. Verify both that replacement occurs when enabled '
        'and doesn\'t when disabled.',
      ),
      sdCard(
        'Test Strategy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sdTestItem('Unit tests', 'Verify configuration is passed correctly', indigo),
            _sdTestItem('Widget tests', 'Platform keyboard not simulated', deepPlum),
            _sdTestItem('Integration tests', 'Real keyboard on device', plum),
            _sdTestItem('Manual test', 'Type -- and --- on real device', amethyst),
            _sdTestItem('Cross-platform', 'Test on iOS + Android separately', violet),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Best practices ━━━━━━
  print('[sd-15] Section 15: Best practices');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('15', 'Best Practices'),
      sdNote(
        'Enable smart dashes for natural prose input (notes, messages, '
        'documents). Disable for technical input (code, URLs, data). Never '
        'rely on smart dashes for data transformation — they\'re a UI '
        'convenience, not a data processing tool.',
      ),
      sdCard(
        'Practice Guide',
        Column(
          children: [
            sdRow(['Practice', 'Reason'], isHeader: true),
            sdRow(['Enable for prose', 'Better typography']),
            sdRow(['Disable for code', 'Syntax correctness']),
            sdRow(['Disable for URLs', 'URL integrity']),
            sdRow(['Test on device', 'Simulator may differ']),
            sdRow(['Set both dash + quote', 'Consistent behavior']),
            sdRow(['Document for users', 'Avoid confusion']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[sd-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sdBanner('16', 'Summary Dashboard'),
      sdCard(
        'SmartDashesType — Complete',
        Column(
          children: [
            sdRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            sdRow(['What', 'S01', 'Auto-replace -- with – and --- with —']),
            sdRow(['Values', 'S02', 'enabled / disabled enum']),
            sdRow(['Typography', 'S03', 'Hyphen vs en-dash vs em-dash']),
            sdRow(['Platforms', 'S04', 'iOS native, Android keyboard-dep.']),
            sdRow(['Config', 'S05', 'smartDashesType on TextField']),
            sdRow(['Quotes', 'S06', 'SmartQuotesType companion']),
            sdRow(['Disable', 'S07', 'Code, URLs, terminal, search']),
            sdRow(['TextInput', 'S08', 'Part of TextInputConfiguration']),
            sdRow(['iOS setting', 'S09', 'System overrides per-field']),
            sdRow(['Autocorrect', 'S10', 'Independent features']),
            sdRow(['i18n', 'S11', 'Language-specific conventions']),
            sdRow(['Undo', 'S12', 'Backspace reverts replacement']),
            sdRow(['A11y', 'S13', 'Screen readers read dashes differently']),
            sdRow(['Testing', 'S14', 'Real device required']),
            sdRow(['Practices', 'S15', 'Prose = on, code = off']),
          ],
        ),
      ),
      sdCard(
        'Plum / Orchid Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _sdColorSwatch('Plum', plum),
            _sdColorSwatch('Orchid', orchid),
            _sdColorSwatch('Amethyst', amethyst),
            _sdColorSwatch('Violet', violet),
            _sdColorSwatch('Indigo', indigo),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [indigo, deepPlum],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('SmartDashesType — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'Automatic typographic dash replacement in Flutter: from Unicode '
              'dash types through platform behavior, configuration, i18n, '
              'accessibility, and the smart quotes companion.',
              style: TextStyle(color: paleOrchid, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[sd] palette: $iris, $lavender, $lilac, $paleOrchid');
  print('[sd] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('SmartDashesType — Typographic Dashes'),
        backgroundColor: indigo,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFAF8FF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            section1, section2, section3, section4,
            section5, section6, section7, section8,
            section9, section10, section11, section12,
            section13, section14, section15, section16,
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════
// Top-level helpers
// ═══════════════════════════════════════════════════

Widget _sdDashDemo(String dash, String unicode, String trigger, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(dash,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold, color: color)),
        ),
        SizedBox(
          width: 60,
          child: Text(unicode,
              style: TextStyle(
                  fontSize: 9, fontFamily: 'monospace', color: color.withValues(alpha: 0.6))),
        ),
        Expanded(
          child: Text(trigger,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _sdCodeLine(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Text(text,
        style: TextStyle(
            fontSize: 10,
            fontFamily: 'monospace',
            color: color,
            height: 1.3)),
  );
}

Widget _sdScenarioItem(IconData icon, String title, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        SizedBox(
          width: 90,
          child: Text(title,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _sdHierarchyLevel(int level, String name, String effect, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: (level - 1) * 16.0, bottom: 5),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text('$level',
                style: const TextStyle(
                    color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 6),
        SizedBox(
          width: 120,
          child: Text(name,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        ),
        Expanded(
          child: Text(effect,
              style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _sdTestItem(String type, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 100,
          child: Text(type,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w600, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _sdColorSwatch(String name, Color color) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(height: 3),
      Text(name, style: const TextStyle(fontSize: 8)),
    ],
  );
}

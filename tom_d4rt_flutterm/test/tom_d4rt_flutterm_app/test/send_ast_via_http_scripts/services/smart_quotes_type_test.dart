// ignore_for_file: avoid_print
// D4rt deep demo: SmartQuotesType — the enum that governs whether a
// text field automatically converts straight quotes into typographic
// curly quotes as the user types, enabling richer text presentation.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Sapphire / Azure palette ───
  const Color sapphire = Color(0xFF1E40AF);
  const Color azure = Color(0xFF3B82F6);
  const Color deepNavy = Color(0xFF1E3A5F);
  const Color paleSky = Color(0xFFEFF6FF);
  const Color cobalt = Color(0xFF2563EB);
  const Color powder = Color(0xFFDBEAFE);
  const Color midnight = Color(0xFF172554);
  const Color steel = Color(0xFF1D4ED8);
  const Color frost = Color(0xFFBFDBFE);
  const Color cerulean = Color(0xFF60A5FA);

  print('===== SMART QUOTES TYPE DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [midnight, deepNavy],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: midnight.withValues(alpha: 0.35),
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
              color: sapphire,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: azure, width: 1.5),
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

  Widget noteBox(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleSky,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: powder),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: midnight.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget infoCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: frost),
        boxShadow: [
          BoxShadow(
            color: sapphire.withValues(alpha: 0.07),
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
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            decoration: BoxDecoration(
              color: paleSky,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: sapphire)),
          ),
          Padding(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }

  Widget tag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget dataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: deepNavy)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: midnight)),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: midnight.withValues(alpha: 0.2), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepNavy),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget progressBar(String label, double fraction, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 11, color: deepNavy)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: frost,
              borderRadius: BorderRadius.circular(3.5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Section 1: Overview & Purpose ───
  print('[Section 1] Overview & Purpose');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'SmartQuotesType is a simple yet essential enum in the Flutter '
          'services layer that determines whether text input fields '
          'automatically convert straight quotation marks (\' and ") into '
          'their typographic curly counterparts (\u2018\u2019 and \u201C\u201D). '
          'This improves readability and gives apps a polished feel.'),
      infoCard(
          'Enum Values',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('enabled', 'Auto-convert quotes to curly variants'),
              dataRow('disabled', 'Keep straight quotes as typed'),
            ],
          )),
      infoCard(
          'Source Location',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Package', 'flutter/services'),
              dataRow('File', 'text_input.dart'),
              dataRow('Related', 'SmartDashesType, TextInputType'),
            ],
          )),
      noteBox(
          'When enabled, the platform text input service intercepts quote '
          'characters and replaces them with context-appropriate curly '
          'quotes — opening quotes when preceded by whitespace, closing '
          'quotes otherwise.'),
    ],
  );

  // ─── Section 2: Enum Anatomy & API Surface ───
  print('[Section 2] Enum Anatomy & API Surface');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Enum Anatomy & API Surface'),
      infoCard(
          'Constructor & Factory',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'enum SmartQuotesType'),
              dataRow('Values', 'enabled, disabled'),
              dataRow('Default', 'Platform-dependent'),
              dataRow('Null behavior', 'Falls back to platform default'),
            ],
          )),
      noteBox(
          'SmartQuotesType is one of the simplest enums in Flutter — just '
          'two values. Its power lies in how the text input channel uses '
          'it to configure platform-level input behavior behind the scenes.'),
      infoCard(
          'TextField Integration',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Parameter', 'smartQuotesType'),
              dataRow('Accepts', 'SmartQuotesType? (nullable)'),
              dataRow('Inherited by', 'EditableText, CupertinoTextField'),
              dataRow('Serialized as', 'Boolean in platform channel'),
            ],
          )),
      infoCard(
          'Companion Enums',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('SmartDashesType', 'Controls dash replacement'),
              dataRow('TextInputAction', 'Controls keyboard action button'),
              dataRow('TextInputType', 'Controls keyboard type'),
              dataRow('TextCapitalization', 'Controls auto-capitalization'),
            ],
          )),
    ],
  );

  // ─── Section 3: Quote Transformation Patterns ───
  print('[Section 3] Quote Transformation Patterns');

  final quoteExamples = <Map<String, String>>[
    {'input': "He said 'hello'", 'output': 'He said \u2018hello\u2019', 'rule': 'Single quotes'},
    {'input': 'She said "goodbye"', 'output': 'She said \u201Cgoodbye\u201D', 'rule': 'Double quotes'},
    {'input': "It's fine", 'output': 'It\u2019s fine', 'rule': 'Apostrophe'},
    {'input': "'Twas the night", 'output': '\u2018Twas the night', 'rule': 'Leading single'},
    {'input': '"Nested \'inner\'"', 'output': '\u201CNested \u2018inner\u2019\u201D', 'rule': 'Nested quotes'},
  ];

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Quote Transformation Patterns'),
      noteBox(
          'The platform text input system uses context-aware heuristics '
          'to decide between opening and closing quote marks. The rules '
          'consider whitespace, punctuation, and paragraph boundaries.'),
      for (final example in quoteExamples)
        infoCard(
            'Pattern: ${example['rule']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Input', example['input']!),
                dataRow('Output', example['output']!),
                dataRow('Rule', example['rule']!),
              ],
            )),
    ],
  );

  // ─── Section 4: Platform Behavior Matrix ───
  print('[Section 4] Platform Behavior Matrix');

  final platforms = <Map<String, String>>[
    {'name': 'iOS', 'default': 'enabled', 'support': 'Native'},
    {'name': 'Android', 'default': 'enabled', 'support': 'IME-dependent'},
    {'name': 'macOS', 'default': 'enabled', 'support': 'Native'},
    {'name': 'Windows', 'default': 'disabled', 'support': 'Limited'},
    {'name': 'Linux', 'default': 'disabled', 'support': 'IBus/Fcitx'},
    {'name': 'Web', 'default': 'disabled', 'support': 'Browser-dependent'},
  ];

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Platform Behavior Matrix'),
      for (final p in platforms)
        infoCard(
            '${p['name']} Platform',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Default', p['default']!),
                dataRow('Support Level', p['support']!),
                dataRow('Override', 'Via smartQuotesType parameter'),
              ],
            )),
      noteBox(
          'On Apple platforms, smart quotes are a system-wide preference '
          'that Flutter respects by default. On other platforms, the '
          'behavior is less consistent and often disabled.'),
    ],
  );

  // ─── Section 5: Text Input Configuration Chain ───
  print('[Section 5] Text Input Configuration Chain');

  final configChain = <Map<String, String>>[
    {'step': '1', 'component': 'TextField widget', 'role': 'User-facing API'},
    {'step': '2', 'component': 'EditableText', 'role': 'State management'},
    {'step': '3', 'component': 'TextInputConnection', 'role': 'Platform bridge'},
    {'step': '4', 'component': 'TextInputConfiguration', 'role': 'Config carrier'},
    {'step': '5', 'component': 'Platform channel', 'role': 'Native serialization'},
    {'step': '6', 'component': 'Native text input', 'role': 'OS-level handling'},
  ];

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Text Input Configuration Chain'),
      noteBox(
          'SmartQuotesType flows through a well-defined chain from the '
          'widget layer down to the native platform, each step adding '
          'its own processing and validation.'),
      for (final step in configChain)
        infoCard(
            'Step ${step['step']}: ${step['component']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Component', step['component']!),
                dataRow('Role', step['role']!),
                dataRow('SmartQuotes', 'Passed through configuration'),
              ],
            )),
    ],
  );

  // ─── Section 6: Typography Quality Metrics ───
  print('[Section 6] Typography Quality Metrics');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Typography Quality Metrics'),
      noteBox(
          'Enabling smart quotes measurably improves the typographic '
          'quality of user-generated content, bringing app text closer '
          'to professionally typeset documents.'),
      infoCard(
          'Readability Scores',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Typographic polish', 0.92, sapphire),
              progressBar('User satisfaction', 0.87, cobalt),
              progressBar('Professional appearance', 0.94, azure),
              progressBar('Accessibility score', 0.78, steel),
            ],
          )),
      infoCard(
          'Character Mapping',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('U+0027 (\') →', 'U+2018/U+2019 (\u2018/\u2019)'),
              dataRow('U+0022 (") →', 'U+201C/U+201D (\u201C/\u201D)'),
              dataRow('Apostrophe →', 'U+2019 (right single quote)'),
              dataRow('Backtick →', 'Not converted (code context)'),
            ],
          )),
      infoCard(
          'Font Requirements',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Glyph coverage', 'Must include curly quote glyphs'),
              dataRow('Fallback', 'System font typically covers them'),
              dataRow('Monospace', 'May lack distinct curly glyphs'),
              dataRow('CJK fonts', 'Use fullwidth quotation marks'),
            ],
          )),
    ],
  );

  // ─── Section 7: Locale & Language Considerations ───
  print('[Section 7] Locale & Language Considerations');

  final localeQuotes = <Map<String, String>>[
    {'locale': 'English', 'open': '\u201C', 'close': '\u201D', 'single': '\u2018/\u2019'},
    {'locale': 'German', 'open': '\u201E', 'close': '\u201C', 'single': '\u201A/\u2018'},
    {'locale': 'French', 'open': '\u00AB', 'close': '\u00BB', 'single': '\u2039/\u203A'},
    {'locale': 'Japanese', 'open': '\u300C', 'close': '\u300D', 'single': '\u300E/\u300F'},
    {'locale': 'Chinese', 'open': '\u201C', 'close': '\u201D', 'single': '\u2018/\u2019'},
    {'locale': 'Polish', 'open': '\u201E', 'close': '\u201D', 'single': '\u201A/\u2019'},
  ];

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Locale & Language Considerations'),
      noteBox(
          'Different locales use different quotation mark styles. The smart '
          'quotes system should ideally respect these conventions, though '
          'platform support varies.'),
      for (final lq in localeQuotes)
        infoCard(
            '${lq['locale']} Quotes',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Opening', lq['open']!),
                dataRow('Closing', lq['close']!),
                dataRow('Single', lq['single']!),
              ],
            )),
    ],
  );

  // ─── Section 8: Integration with TextField ───
  print('[Section 8] Integration with TextField');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Integration with TextField'),
      noteBox(
          'TextField and CupertinoTextField both accept an optional '
          'smartQuotesType parameter. When null, the platform default '
          'applies. Explicitly setting it overrides the default.'),
      infoCard(
          'TextField Configuration',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Parameter', 'SmartQuotesType? smartQuotesType'),
              dataRow('Default when null', 'Platform decides'),
              dataRow('Material default', 'enabled on iOS/macOS'),
              dataRow('Cupertino default', 'enabled'),
            ],
          )),
      infoCard(
          'EditableText Bridge',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Property', 'smartQuotesType'),
              dataRow('Resolution', 'Widget → EditableText → Connection'),
              dataRow('Rebuild trigger', 'Only when value changes'),
              dataRow('Hot reload', 'Requires reconnection'),
            ],
          )),
      infoCard(
          'TextInputConfiguration Mapping',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Field', 'enableSuggestions vs enableSmartQuotes'),
              dataRow('Serialization', 'Boolean flag in JSON'),
              dataRow('Channel', 'TextInput.setClient'),
              dataRow('Timing', 'Set once at connection time'),
            ],
          )),
      infoCard(
          'Impact on UX',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Chat apps', 'Enable for natural conversation'),
              dataRow('Code editors', 'Disable to preserve syntax'),
              dataRow('Note taking', 'Enable for polished output'),
              dataRow('Search fields', 'Disable to avoid confusion'),
            ],
          )),
    ],
  );

  // ─── Section 9: Testing Strategies ───
  print('[Section 9] Testing Strategies');

  final testCases = <Map<String, String>>[
    {'name': 'Default behavior', 'verify': 'Platform default is applied'},
    {'name': 'Explicit enable', 'verify': 'Curly quotes appear in output'},
    {'name': 'Explicit disable', 'verify': 'Straight quotes preserved'},
    {'name': 'Null parameter', 'verify': 'Falls back to platform default'},
    {'name': 'Hot restart', 'verify': 'Setting persists across restart'},
    {'name': 'Locale switch', 'verify': 'Quote style matches new locale'},
  ];

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Testing Strategies'),
      noteBox(
          'Testing smart quotes requires platform-aware test harnesses '
          'since the actual quote conversion happens in native code. '
          'Widget tests can verify configuration propagation.'),
      for (final tc in testCases)
        infoCard(
            'Test: ${tc['name']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Scenario', tc['name']!),
                dataRow('Verify', tc['verify']!),
                dataRow('Level', 'Integration / Widget test'),
              ],
            )),
    ],
  );

  // ─── Section 10: Accessibility Implications ───
  print('[Section 10] Accessibility Implications');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Accessibility Implications'),
      noteBox(
          'Curly quotes can affect screen readers, text-to-speech engines, '
          'and assistive technology. Understanding these impacts helps '
          'developers make informed choices about smart quotes.'),
      infoCard(
          'Screen Reader Behavior',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('VoiceOver', 'Reads both styles identically'),
              dataRow('TalkBack', 'May announce "left/right quote"'),
              dataRow('NVDA', 'Configurable punctuation level'),
              dataRow('JAWS', 'Announces based on verbosity'),
            ],
          )),
      infoCard(
          'Copy-Paste Considerations',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Code editors', 'Curly quotes cause syntax errors'),
              dataRow('Terminal', 'Curly quotes break commands'),
              dataRow('URLs', 'Curly quotes invalid in URIs'),
              dataRow('Search engines', 'May treat as different chars'),
            ],
          )),
      infoCard(
          'Encoding Impacts',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('UTF-8 size', '3 bytes vs 1 byte for ASCII'),
              dataRow('ASCII fallback', 'Cannot represent curly quotes'),
              dataRow('HTML entities', '&ldquo; &rdquo; &lsquo; &rsquo;'),
              dataRow('LaTeX', '`` and \'\' for double quotes'),
            ],
          )),
    ],
  );

  // ─── Section 11: Comparison with SmartDashesType ───
  print('[Section 11] Comparison with SmartDashesType');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Comparison with SmartDashesType'),
      noteBox(
          'SmartQuotesType and SmartDashesType are sibling enums that '
          'control parallel typographic features. They share the same '
          'architecture and configuration path through the input system.'),
      infoCard(
          'Feature Comparison',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('SmartQuotesType', 'Converts \' " to curly variants'),
              dataRow('SmartDashesType', 'Converts -- to en/em dashes'),
              dataRow('Both', 'Enum with enabled/disabled values'),
              dataRow('Both', 'Nullable in TextField API'),
            ],
          )),
      infoCard(
          'Shared Architecture',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Config carrier', 'TextInputConfiguration'),
              dataRow('Channel', 'TextInput.setClient'),
              dataRow('Widget param', 'TextField.smartQuotesType / smartDashesType'),
              dataRow('Platform level', 'Handled by same native module'),
            ],
          )),
      infoCard(
          'Independent Control',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Can mix', 'Yes — enable one, disable the other'),
              dataRow('Use case', 'Code editor: disable quotes, enable dashes'),
              dataRow('Default linkage', 'No — each has own default'),
              dataRow('User preference', 'System settings may link them'),
            ],
          )),
    ],
  );

  // ─── Section 12: Performance & Memory ───
  print('[Section 12] Performance & Memory');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Performance & Memory'),
      noteBox(
          'As a simple enum, SmartQuotesType has near-zero memory overhead. '
          'The real performance consideration is the platform text input '
          'processing that happens in response to the setting.'),
      infoCard(
          'Memory Footprint',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Enum instance', '~8 bytes on 64-bit'),
              dataRow('Configuration', 'Part of TextInputConfiguration'),
              dataRow('Allocations', 'Zero per keystroke'),
              dataRow('GC pressure', 'None'),
            ],
          )),
      infoCard(
          'Processing Cost',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Enum comparison', 0.02, sapphire),
              progressBar('Config serialization', 0.08, cobalt),
              progressBar('Platform channel', 0.15, azure),
              progressBar('Native processing', 0.25, steel),
            ],
          )),
      infoCard(
          'Optimization Notes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Lazy config', 'Only serialized when connecting'),
              dataRow('Change detection', 'No-op if value unchanged'),
              dataRow('Batching', 'Sent with all input config at once'),
              dataRow('Caching', 'Platform caches the setting'),
            ],
          )),
    ],
  );

  // ─── Section 13: Edge Cases & Gotchas ───
  print('[Section 13] Edge Cases & Gotchas');

  final edgeCases = <Map<String, String>>[
    {'case': 'Programmatic text', 'issue': 'Not converted — only user input'},
    {'case': 'Paste from clipboard', 'issue': 'Existing quotes preserved'},
    {'case': 'IME composition', 'issue': 'Conversion after commit'},
    {'case': 'Emoji adjacent', 'issue': 'Quote direction may be wrong'},
    {'case': 'RTL text', 'issue': 'Opening/closing may swap'},
  ];

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Edge Cases & Gotchas'),
      noteBox(
          'Smart quote conversion is not perfectly reliable in all contexts. '
          'Developers should be aware of situations where the automatic '
          'conversion produces unexpected results.'),
      for (final ec in edgeCases)
        infoCard(
            'Edge Case: ${ec['case']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Scenario', ec['case']!),
                dataRow('Issue', ec['issue']!),
                dataRow('Mitigation', 'Document behavior or disable'),
              ],
            )),
    ],
  );

  // ─── Section 14: Best Practices ───
  print('[Section 14] Best Practices');

  final practices = <Map<String, String>>[
    {'practice': 'Enable for prose', 'reason': 'Improves readability'},
    {'practice': 'Disable for code input', 'reason': 'Prevents syntax errors'},
    {'practice': 'Disable for search', 'reason': 'Avoids matching issues'},
    {'practice': 'Test both states', 'reason': 'Ensure correct behavior'},
    {'practice': 'Document the choice', 'reason': 'Future maintainability'},
    {'practice': 'Respect user settings', 'reason': 'Use null for system default'},
  ];

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Best Practices'),
      noteBox(
          'Choose the smart quotes setting intentionally based on the '
          'type of content your text field accepts. A blanket enable '
          'or disable is rarely the best approach.'),
      for (final pr in practices)
        infoCard(
            pr['practice']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Practice', pr['practice']!),
                dataRow('Reason', pr['reason']!),
              ],
            )),
    ],
  );

  // ─── Section 15: Real-World Application Patterns ───
  print('[Section 15] Real-World Application Patterns');

  final appPatterns = <Map<String, String>>[
    {'app': 'Messaging app', 'setting': 'enabled', 'reason': 'Natural conversation'},
    {'app': 'IDE / Code editor', 'setting': 'disabled', 'reason': 'Code fidelity'},
    {'app': 'Word processor', 'setting': 'enabled', 'reason': 'Professional output'},
    {'app': 'Terminal emulator', 'setting': 'disabled', 'reason': 'Command accuracy'},
    {'app': 'Email client', 'setting': 'enabled', 'reason': 'Polished correspondence'},
  ];

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Real-World Application Patterns'),
      noteBox(
          'Different application categories have different needs for '
          'smart quotes. Here are common patterns seen in production apps.'),
      for (final ap in appPatterns)
        infoCard(
            '${ap['app']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Application', ap['app']!),
                dataRow('Recommended', ap['setting']!),
                dataRow('Reason', ap['reason']!),
              ],
            )),
      infoCard(
          'Hybrid Approach',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Strategy', 'Per-field configuration'),
              dataRow('Example', 'Enable in body, disable in code blocks'),
              dataRow('Implementation', 'Separate TextField instances'),
              dataRow('Benefit', 'Best of both worlds'),
            ],
          )),
    ],
  );

  // ─── Section 16: Visual Dashboard ───
  print('[Section 16] Visual Dashboard');

  final section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('16', 'Visual Dashboard'),
      noteBox('Comprehensive overview of the SmartQuotesType deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Sapphire', sapphire),
              colorSwatch('Azure', azure),
              colorSwatch('Deep Navy', deepNavy),
              colorSwatch('Pale Sky', paleSky),
              colorSwatch('Cobalt', cobalt),
              colorSwatch('Powder', powder),
              colorSwatch('Midnight', midnight),
              colorSwatch('Steel', steel),
              colorSwatch('Frost', frost),
              colorSwatch('Cerulean', cerulean),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview & Purpose', 1.0, sapphire),
              progressBar('Enum Anatomy', 1.0, cobalt),
              progressBar('Quote Patterns', 1.0, azure),
              progressBar('Platform Matrix', 1.0, steel),
              progressBar('Config Chain', 1.0, cerulean),
              progressBar('Typography Metrics', 1.0, sapphire),
              progressBar('Locale Considerations', 1.0, cobalt),
              progressBar('TextField Integration', 1.0, azure),
              progressBar('Testing Strategies', 1.0, steel),
              progressBar('Accessibility', 1.0, cerulean),
              progressBar('SmartDashes Comparison', 1.0, sapphire),
              progressBar('Performance', 1.0, cobalt),
              progressBar('Edge Cases', 1.0, azure),
              progressBar('Best Practices', 1.0, steel),
              progressBar('App Patterns', 1.0, cerulean),
              progressBar('Dashboard', 1.0, sapphire),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Sapphire / Azure'),
              dataRow('Palette colors', '10'),
              dataRow('Quote patterns', '${quoteExamples.length}'),
              dataRow('Platforms covered', '${platforms.length}'),
              dataRow('Test scenarios', '${testCases.length}'),
              dataRow('Locale examples', '${localeQuotes.length}'),
              dataRow('Edge cases', '${edgeCases.length}'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('SmartQuotesType', sapphire, Colors.white),
          tag('Typography', cobalt, Colors.white),
          tag('TextInput', azure, Colors.white),
          tag('Services', steel, Colors.white),
          tag('Curly Quotes', midnight, Colors.white),
          tag('Platform', deepNavy, Colors.white),
          tag('Accessibility', cerulean, Colors.white),
          tag('i18n', sapphire.withValues(alpha: 0.8), Colors.white),
        ],
      ),
    ],
  );

  print('===== END SMART QUOTES TYPE DEEP DEMO =====');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
        section12,
        section13,
        section14,
        section15,
        section16,
      ],
    ),
  );
}

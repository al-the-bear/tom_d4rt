// ignore_for_file: avoid_print
// D4rt deep demo: SpellCheckService — the abstract service that provides
// spell-checking capabilities to Flutter text fields, detecting misspelled
// words and offering correction suggestions via platform integration.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Terracotta / Copper palette ───
  const Color terracotta = Color(0xFFC2410C);
  const Color copper = Color(0xFFEA580C);
  const Color burnSienna = Color(0xFF9A3412);
  const Color paleWarm = Color(0xFFFFF7ED);
  const Color rust = Color(0xFFD97706);
  const Color sandstone = Color(0xFFFED7AA);
  const Color mahogany = Color(0xFF7C2D12);
  const Color bronze = Color(0xFFB45309);
  const Color warmGlow = Color(0xFFFDE68A);
  const Color amber = Color(0xFFF59E0B);

  print('===== SPELL CHECK SERVICE DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [mahogany, burnSienna],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: mahogany.withValues(alpha: 0.35),
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
              color: terracotta,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: copper, width: 1.5),
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
        color: paleWarm,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sandstone),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: mahogany.withValues(alpha: 0.9),
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
        border: Border.all(color: warmGlow),
        boxShadow: [
          BoxShadow(
            color: terracotta.withValues(alpha: 0.07),
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
              color: paleWarm,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: terracotta)),
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
                    color: burnSienna)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: mahogany)),
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
                  color: mahogany.withValues(alpha: 0.2), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: burnSienna),
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
                  style: TextStyle(fontSize: 11, color: burnSienna)),
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
              color: warmGlow,
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
          'SpellCheckService is an abstract class that defines the interface '
          'for spell-checking in Flutter text fields. It bridges the gap '
          'between platform-native spell-check engines and Flutter widgets, '
          'enabling red-underline misspelling indicators and correction '
          'suggestions in text input fields.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Abstract class'),
              dataRow('Package', 'flutter/services'),
              dataRow('Purpose', 'Platform spell-check integration'),
              dataRow('Subclass', 'DefaultSpellCheckService'),
            ],
          )),
      infoCard(
          'Key Responsibilities',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Fetch results', 'Request spell-check from platform'),
              dataRow('Return suggestions', 'List<SuggestionSpan>'),
              dataRow('Manage lifecycle', 'Dispose resources when done'),
              dataRow('Handle locale', 'Pass language context to platform'),
            ],
          )),
    ],
  );

  // ─── Section 2: Abstract API Surface ───
  print('[Section 2] Abstract API Surface');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Abstract API Surface'),
      noteBox(
          'The abstract class defines a minimal but complete contract — '
          'a single async method that takes text and locale, returning '
          'a list of suggestion spans for misspelled regions.'),
      infoCard(
          'Method Signature',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Method', 'fetchSpellCheckSuggestions'),
              dataRow('Return', 'Future<List<SuggestionSpan>?>'),
              dataRow('Param: locale', 'Locale for dictionary selection'),
              dataRow('Param: text', 'The text to spell-check'),
            ],
          )),
      infoCard(
          'SuggestionSpan',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('range', 'TextRange of the misspelled word'),
              dataRow('suggestions', 'List<String> of corrections'),
              dataRow('Immutable', 'Yes — all fields are final'),
              dataRow('Equality', 'Based on range and suggestions'),
            ],
          )),
      infoCard(
          'DefaultSpellCheckService',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Extends', 'SpellCheckService'),
              dataRow('Implementation', 'Uses platform channels'),
              dataRow('Channel', 'SpellCheck.initiateSpellCheck'),
              dataRow('Platform', 'Delegates to native spell engine'),
            ],
          )),
    ],
  );

  // ─── Section 3: Platform Spell-Check Engines ───
  print('[Section 3] Platform Spell-Check Engines');

  final engines = <Map<String, String>>[
    {'platform': 'iOS', 'engine': 'UITextChecker', 'quality': 'Excellent'},
    {'platform': 'Android', 'engine': 'SpellCheckerService', 'quality': 'Good'},
    {'platform': 'macOS', 'engine': 'NSSpellChecker', 'quality': 'Excellent'},
    {'platform': 'Windows', 'engine': 'ISpellChecker (Win8+)', 'quality': 'Good'},
    {'platform': 'Linux', 'engine': 'Hunspell / Aspell', 'quality': 'Moderate'},
    {'platform': 'Web', 'engine': 'Browser built-in', 'quality': 'Varies'},
  ];

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Platform Spell-Check Engines'),
      noteBox(
          'Each platform provides its own spell-checking engine. The '
          'SpellCheckService abstraction normalizes these differences '
          'into a single Flutter-friendly interface.'),
      for (final engine in engines)
        infoCard(
            '${engine['platform']} Engine',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Platform', engine['platform']!),
                dataRow('Engine', engine['engine']!),
                dataRow('Quality', engine['quality']!),
              ],
            )),
    ],
  );

  // ─── Section 4: Suggestion Span Architecture ───
  print('[Section 4] Suggestion Span Architecture');

  final spanExamples = <Map<String, String>>[
    {'word': 'teh', 'range': '0-3', 'suggestions': 'the, tea, ten'},
    {'word': 'recieve', 'range': '5-12', 'suggestions': 'receive, relieve'},
    {'word': 'occured', 'range': '0-7', 'suggestions': 'occurred, obscured'},
    {'word': 'seperate', 'range': '10-18', 'suggestions': 'separate, desperate'},
    {'word': 'accomodate', 'range': '4-14', 'suggestions': 'accommodate'},
  ];

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Suggestion Span Architecture'),
      noteBox(
          'SuggestionSpan objects carry the location and corrections for '
          'each misspelled word. They are immutable value objects that can '
          'be compared and cached efficiently.'),
      for (final span in spanExamples)
        infoCard(
            'Misspelling: "${span['word']}"',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Word', span['word']!),
                dataRow('Range', span['range']!),
                dataRow('Suggestions', span['suggestions']!),
              ],
            )),
    ],
  );

  // ─── Section 5: Integration Pipeline ───
  print('[Section 5] Integration Pipeline');

  final pipeline = <Map<String, String>>[
    {'step': '1', 'stage': 'Text changes', 'action': 'User types in TextField'},
    {'step': '2', 'stage': 'Debounce', 'action': 'Wait for typing pause'},
    {'step': '3', 'stage': 'Service call', 'action': 'fetchSpellCheckSuggestions'},
    {'step': '4', 'stage': 'Platform channel', 'action': 'Send to native engine'},
    {'step': '5', 'stage': 'Engine process', 'action': 'Dictionary lookup & match'},
    {'step': '6', 'stage': 'Results return', 'action': 'List<SuggestionSpan> back'},
    {'step': '7', 'stage': 'Overlay render', 'action': 'Red underlines drawn'},
    {'step': '8', 'stage': 'User interaction', 'action': 'Tap for suggestions menu'},
  ];

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Integration Pipeline'),
      noteBox(
          'The spell-check pipeline flows from user input through the '
          'service abstraction to the platform engine and back, with '
          'visual feedback rendered as text decorations.'),
      for (final step in pipeline)
        infoCard(
            'Step ${step['step']}: ${step['stage']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Stage', step['stage']!),
                dataRow('Action', step['action']!),
              ],
            )),
    ],
  );

  // ─── Section 6: Performance Characteristics ───
  print('[Section 6] Performance Characteristics');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Performance Characteristics'),
      noteBox(
          'Spell-checking is inherently I/O-bound due to dictionary '
          'lookups. The async design ensures the UI thread remains '
          'responsive while checks run in the background.'),
      infoCard(
          'Latency Profile',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Short text (<50 chars)', 0.15, terracotta),
              progressBar('Medium text (50-500)', 0.35, copper),
              progressBar('Long text (500-5000)', 0.65, rust),
              progressBar('Very long (>5000)', 0.90, bronze),
            ],
          )),
      infoCard(
          'Resource Usage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('CPU', 'Low — mostly I/O wait'),
              dataRow('Memory', 'Dictionary cached by platform'),
              dataRow('Battery', 'Negligible per check'),
              dataRow('Network', 'None (offline dictionaries)'),
            ],
          )),
      infoCard(
          'Optimization Strategies',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Debounce', '300-500ms after last keystroke'),
              dataRow('Incremental', 'Check only changed region'),
              dataRow('Batch', 'Combine multiple words per call'),
              dataRow('Cache', 'Reuse results for unchanged text'),
            ],
          )),
    ],
  );

  // ─── Section 7: Custom SpellCheckService Implementation ───
  print('[Section 7] Custom SpellCheckService Implementation');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Custom SpellCheckService Implementations'),
      noteBox(
          'Developers can extend SpellCheckService to provide custom '
          'spell-checking logic — local dictionaries, AI-powered '
          'suggestions, domain-specific vocabularies, and more.'),
      infoCard(
          'Custom Implementation Pattern',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Extend', 'SpellCheckService'),
              dataRow('Override', 'fetchSpellCheckSuggestions'),
              dataRow('Return', 'Future<List<SuggestionSpan>?>'),
              dataRow('Register', 'Pass to EditableText/TextField'),
            ],
          )),
      infoCard(
          'Use Cases for Custom Services',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Medical terms', 'Custom dictionary with terminology'),
              dataRow('Legal jargon', 'Law-specific word acceptance'),
              dataRow('Brand names', 'Allow product names without red lines'),
              dataRow('Code keywords', 'Don\'t flag programming terms'),
            ],
          )),
      infoCard(
          'AI-Powered Spell Check',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Context-aware', 'Uses sentence context for guesses'),
              dataRow('Grammar check', 'Extends beyond pure spelling'),
              dataRow('Latency trade-off', 'Network round-trip needed'),
              dataRow('Fallback', 'Use platform engine when offline'),
            ],
          )),
    ],
  );

  // ─── Section 8: Locale & Dictionary Management ───
  print('[Section 8] Locale & Dictionary Management');

  final dictionaries = <Map<String, String>>[
    {'locale': 'en_US', 'words': '~170,000', 'source': 'Platform default'},
    {'locale': 'en_GB', 'words': '~165,000', 'source': 'Platform default'},
    {'locale': 'de_DE', 'words': '~300,000', 'source': 'Compound words'},
    {'locale': 'fr_FR', 'words': '~180,000', 'source': 'Platform default'},
    {'locale': 'es_ES', 'words': '~175,000', 'source': 'Platform default'},
    {'locale': 'ja_JP', 'words': 'N/A', 'source': 'IME handles corrections'},
  ];

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Locale & Dictionary Management'),
      noteBox(
          'Each locale has its own dictionary and correction algorithms. '
          'The service passes the locale to the platform so the correct '
          'dictionary is selected for spell-checking.'),
      for (final dict in dictionaries)
        infoCard(
            'Dictionary: ${dict['locale']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Locale', dict['locale']!),
                dataRow('Approx. words', dict['words']!),
                dataRow('Source', dict['source']!),
              ],
            )),
    ],
  );

  // ─── Section 9: Error Handling & Resilience ───
  print('[Section 9] Error Handling & Resilience');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Error Handling & Resilience'),
      noteBox(
          'Spell-check operations can fail for various reasons — missing '
          'dictionaries, platform limitations, or service unavailability. '
          'Robust error handling ensures graceful degradation.'),
      infoCard(
          'Failure Modes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Null return', 'Service unavailable on platform'),
              dataRow('Empty list', 'No misspellings found'),
              dataRow('Timeout', 'Platform engine too slow'),
              dataRow('Exception', 'Channel communication failure'),
            ],
          )),
      infoCard(
          'Graceful Degradation',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Null handling', 'Show no underlines (safe)'),
              dataRow('Retry logic', 'Exponential backoff on failure'),
              dataRow('Fallback', 'Use cached results or skip check'),
              dataRow('User feedback', 'No error shown — silent fail'),
            ],
          )),
      infoCard(
          'Testing Error Paths',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Mock service', 'Return null or throw'),
              dataRow('Empty locale', 'Verify platform handles it'),
              dataRow('Empty text', 'Should return empty list'),
              dataRow('Concurrent calls', 'Verify no race conditions'),
            ],
          )),
    ],
  );

  // ─── Section 10: Visual Feedback System ───
  print('[Section 10] Visual Feedback System');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Visual Feedback System'),
      noteBox(
          'When spell-check results are available, the text field overlay '
          'renders visual indicators — typically red wavy underlines — '
          'beneath misspelled words to alert the user.'),
      infoCard(
          'Underline Styles',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Wavy red', 'Standard misspelling indicator'),
              dataRow('Dotted blue', 'Grammar suggestion (future)'),
              dataRow('Solid green', 'Style improvement (future)'),
              dataRow('None', 'When spell-check is disabled'),
            ],
          )),
      infoCard(
          'Suggestion Menu',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Trigger', 'Tap or long-press on underlined word'),
              dataRow('Content', 'List of suggestion strings'),
              dataRow('Selection', 'Replaces misspelled word'),
              dataRow('Dismiss', 'Tap outside or "Add to dictionary"'),
            ],
          )),
      infoCard(
          'Rendering Pipeline',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Layer', 'SpellCheckSuggestionsToolbar'),
              dataRow('Positioning', 'Anchored to misspelled word'),
              dataRow('Animation', 'Fade in/out'),
              dataRow('Theming', 'Respects Material/Cupertino style'),
            ],
          )),
    ],
  );

  // ─── Section 11: TextField & EditableText Integration ───
  print('[Section 11] TextField & EditableText Integration');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'TextField & EditableText Integration'),
      noteBox(
          'SpellCheckService is injected into the text editing stack via '
          'the spellCheckConfiguration parameter, which bundles the '
          'service instance and visual configuration together.'),
      infoCard(
          'SpellCheckConfiguration',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('spellCheckService', 'The service instance'),
              dataRow('misspelledTextStyle', 'TextStyle for underlines'),
              dataRow('spellCheckSuggestionsToolbarBuilder', 'Custom toolbar'),
              dataRow('enabled', 'Derived from service != null'),
            ],
          )),
      infoCard(
          'Widget Hierarchy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('TextField', 'Accepts SpellCheckConfiguration'),
              dataRow('EditableText', 'Manages the service lifecycle'),
              dataRow('RenderEditable', 'Draws spell-check overlays'),
              dataRow('Toolbar overlay', 'Shows correction suggestions'),
            ],
          )),
      infoCard(
          'Lifecycle Management',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Create', 'Service instantiated with config'),
              dataRow('Attach', 'Bound to EditableTextState'),
              dataRow('Active', 'fetchSpellCheckSuggestions on changes'),
              dataRow('Dispose', 'Cleaned up with widget disposal'),
            ],
          )),
    ],
  );

  // ─── Section 12: Comparison with Other Services ───
  print('[Section 12] Comparison with Other Services');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Comparison with Other Services'),
      noteBox(
          'SpellCheckService is one of several abstract services in Flutter '
          'that bridge platform capabilities. Understanding its place in '
          'the services layer helps see the bigger design pattern.'),
      infoCard(
          'Service Comparison Matrix',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('SpellCheckService', 'Spell checking & suggestions'),
              dataRow('TextInput', 'Keyboard & text editing'),
              dataRow('HapticFeedback', 'Tactile feedback'),
              dataRow('SystemChrome', 'System UI management'),
            ],
          )),
      infoCard(
          'Pattern Similarities',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Abstract base', 'All define a contract'),
              dataRow('Platform channel', 'All use method channels'),
              dataRow('Default impl', 'All provide platform-based default'),
              dataRow('Override pattern', 'All support custom implementations'),
            ],
          )),
    ],
  );

  // ─── Section 13: Testing Approaches ───
  print('[Section 13] Testing Approaches');

  final testApproaches = <Map<String, String>>[
    {'approach': 'Mock service', 'description': 'Return predefined SuggestionSpans'},
    {'approach': 'Widget test', 'description': 'Verify underline rendering'},
    {'approach': 'Integration test', 'description': 'Test with real platform engine'},
    {'approach': 'Golden test', 'description': 'Snapshot misspelling UI'},
    {'approach': 'Stress test', 'description': 'Large text performance'},
    {'approach': 'Locale test', 'description': 'Multiple dictionary switching'},
  ];

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Testing Approaches'),
      noteBox(
          'Testing spell-check requires mock services for unit tests '
          'and real platform integration for end-to-end verification. '
          'The abstract design makes mocking straightforward.'),
      for (final test in testApproaches)
        infoCard(
            test['approach']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Approach', test['approach']!),
                dataRow('Description', test['description']!),
              ],
            )),
    ],
  );

  // ─── Section 14: Limitations & Future Directions ───
  print('[Section 14] Limitations & Future Directions');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Limitations & Future Directions'),
      noteBox(
          'The current SpellCheckService API is intentionally minimal. '
          'Future versions may add grammar checking, auto-correction, '
          'and richer suggestion metadata.'),
      infoCard(
          'Current Limitations',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('No grammar check', 'Only spelling, not grammar'),
              dataRow('No auto-correct', 'Only suggestions, no auto-fix'),
              dataRow('Single locale', 'One locale per check call'),
              dataRow('No user dict', 'No "learn word" API in Flutter'),
            ],
          )),
      infoCard(
          'Possible Future Extensions',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Grammar checking', 'GrammarCheckService parallel'),
              dataRow('Auto-correction', 'Automatic fix with undo'),
              dataRow('User dictionary', 'Learn/ignore word API'),
              dataRow('Multi-locale', 'Detect and check mixed languages'),
            ],
          )),
      infoCard(
          'Community Discussion',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('GitHub issues', 'Active feature requests'),
              dataRow('Plugin ecosystem', 'Third-party spell-check pkgs'),
              dataRow('LanguageTool', 'Popular grammar-check integration'),
              dataRow('Hunspell Dart', 'Pure Dart dictionary lookup'),
            ],
          )),
    ],
  );

  // ─── Section 15: Security & Privacy ───
  print('[Section 15] Security & Privacy');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Security & Privacy'),
      noteBox(
          'Spell-checking involves analyzing user-typed text, which '
          'raises important privacy considerations — especially when '
          'custom services might send text to remote servers.'),
      infoCard(
          'Privacy Concerns',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Local only', 'Default service is offline'),
              dataRow('Custom risk', 'Cloud services see user text'),
              dataRow('Sensitive fields', 'Disable for passwords'),
              dataRow('GDPR', 'Text may be PII'),
            ],
          )),
      infoCard(
          'Security Best Practices',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Password fields', 'Never enable spell-check'),
              dataRow('Credit cards', 'Disable for financial input'),
              dataRow('API keys', 'Disable for secret entry fields'),
              dataRow('Cloud services', 'Encrypt text in transit'),
            ],
          )),
      infoCard(
          'Data Handling',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Retention', 'Results discarded after display'),
              dataRow('Logging', 'Don\'t log spell-check text'),
              dataRow('Caching', 'Clear cache on user logout'),
              dataRow('Consent', 'Inform users of cloud checking'),
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
      noteBox('Comprehensive overview of the SpellCheckService deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Terracotta', terracotta),
              colorSwatch('Copper', copper),
              colorSwatch('Burn Sienna', burnSienna),
              colorSwatch('Pale Warm', paleWarm),
              colorSwatch('Rust', rust),
              colorSwatch('Sandstone', sandstone),
              colorSwatch('Mahogany', mahogany),
              colorSwatch('Bronze', bronze),
              colorSwatch('Warm Glow', warmGlow),
              colorSwatch('Amber', amber),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview & Purpose', 1.0, terracotta),
              progressBar('Abstract API', 1.0, copper),
              progressBar('Platform Engines', 1.0, rust),
              progressBar('Suggestion Spans', 1.0, bronze),
              progressBar('Integration Pipeline', 1.0, amber),
              progressBar('Performance', 1.0, terracotta),
              progressBar('Custom Implementations', 1.0, copper),
              progressBar('Locale & Dictionaries', 1.0, rust),
              progressBar('Error Handling', 1.0, bronze),
              progressBar('Visual Feedback', 1.0, amber),
              progressBar('TextField Integration', 1.0, terracotta),
              progressBar('Service Comparison', 1.0, copper),
              progressBar('Testing', 1.0, rust),
              progressBar('Limitations & Future', 1.0, bronze),
              progressBar('Security & Privacy', 1.0, amber),
              progressBar('Dashboard', 1.0, terracotta),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Terracotta / Copper'),
              dataRow('Palette colors', '10'),
              dataRow('Platform engines', '${engines.length}'),
              dataRow('Span examples', '${spanExamples.length}'),
              dataRow('Pipeline steps', '${pipeline.length}'),
              dataRow('Dictionaries', '${dictionaries.length}'),
              dataRow('Test approaches', '${testApproaches.length}'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('SpellCheckService', terracotta, Colors.white),
          tag('SuggestionSpan', copper, Colors.white),
          tag('Dictionary', rust, Colors.white),
          tag('Services', bronze, Colors.white),
          tag('Platform', mahogany, Colors.white),
          tag('NLP', burnSienna, Colors.white),
          tag('Accessibility', amber, Colors.white),
          tag('Privacy', terracotta.withValues(alpha: 0.8), Colors.white),
        ],
      ),
    ],
  );

  print('===== END SPELL CHECK SERVICE DEEP DEMO =====');

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

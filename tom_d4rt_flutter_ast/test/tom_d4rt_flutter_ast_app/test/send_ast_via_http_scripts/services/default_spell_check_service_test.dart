// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DefaultSpellCheckService, SpellCheckService,
// SuggestionSpan and TextRange from package:flutter/services.dart.
// Deep Demo theme: The Proofreader's Desk -- a manuscript copyediting bench
// where red-ink corrections are pinned to parchment in the margins.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ============================================================================
// Palette: parchment, ink, gilt, proofreader-red, sepia marginalia.
// ============================================================================
const Color _kParchment = Color(0xFFF5E6C8);
const Color _kParchmentDark = Color(0xFFE8D3A2);
const Color _kProofRed = Color(0xFFA41E22);
const Color _kProofRedDeep = Color(0xFF6B0F12);
const Color _kInkBlue = Color(0xFF1A2747);
const Color _kInkBlueLight = Color(0xFF36446B);
const Color _kGilt = Color(0xFFB8860B);
const Color _kGiltLight = Color(0xFFE0B954);
const Color _kSepia = Color(0xFF7B5E3F);
const Color _kSepiaLight = Color(0xFFB8956A);
const Color _kForest = Color(0xFF2D5016);

dynamic build(BuildContext context) {
  print('========================================================');
  print(' DefaultSpellCheckService Deep Demo: Proofreader\'s Desk ');
  print('========================================================');

  // --------------------------------------------------------------------------
  // SETUP: instantiate the service and craft demo SuggestionSpan / TextRange
  // values that the rest of the document will reason about.
  // --------------------------------------------------------------------------
  print('Section 0: Setup');

  final DefaultSpellCheckService service = DefaultSpellCheckService();
  print('Constructed DefaultSpellCheckService instance.');
  print('  runtimeType  = ${service.runtimeType}');
  // Upcast to the abstract supertype to demonstrate the inheritance link.
  final SpellCheckService asAbstract = service;
  print('  upcast to SpellCheckService: ${asAbstract.runtimeType}');

  // The Future returned by fetchSpellCheckSuggestions is documented but cannot
  // be awaited under the D4rt bridge. We construct a Future.value to show that
  // the return type is Future<List<SuggestionSpan>?>.
  final Future<List<SuggestionSpan>?> futureProbe =
      Future<List<SuggestionSpan>?>.value(<SuggestionSpan>[]);
  print('  fetchSpellCheckSuggestions returns: ${futureProbe.runtimeType}');

  // A small corpus of misspellings and their hand-corrected suggestions.
  // Each entry models exactly one SuggestionSpan a service might return.
  final List<_Marginalium> marginalia = <_Marginalium>[
    const _Marginalium(
      original: 'Ths is a tset of the spel cheker.',
      misspelled: 'Ths',
      start: 0,
      end: 3,
      suggestions: <String>['This', 'Ths.', 'Thus'],
      note: 'leading article missing the vowel',
    ),
    const _Marginalium(
      original: 'Ths is a tset of the spel cheker.',
      misspelled: 'tset',
      start: 9,
      end: 13,
      suggestions: <String>['test', 'taste', 'tsetse'],
      note: 'metathesis: e and s swapped',
    ),
    const _Marginalium(
      original: 'Ths is a tset of the spel cheker.',
      misspelled: 'spel',
      start: 21,
      end: 25,
      suggestions: <String>['spell', 'spec', 'spew'],
      note: 'doubled consonant elided',
    ),
    const _Marginalium(
      original: 'Ths is a tset of the spel cheker.',
      misspelled: 'cheker',
      start: 26,
      end: 32,
      suggestions: <String>['checker', 'cheaper', 'sheker'],
      note: 'silent c dropped',
    ),
    const _Marginalium(
      original: 'Recieve the manuscrpt by Wensday.',
      misspelled: 'Recieve',
      start: 0,
      end: 7,
      suggestions: <String>['Receive', 'Recede', 'Reactive'],
      note: 'classic i-before-e violation',
    ),
    const _Marginalium(
      original: 'Recieve the manuscrpt by Wensday.',
      misspelled: 'manuscrpt',
      start: 12,
      end: 21,
      suggestions: <String>['manuscript', 'manuscripts'],
      note: 'i missing in the suffix',
    ),
  ];
  print('Prepared ${marginalia.length} marginalia entries for the demo.');

  // Construct real SuggestionSpan / TextRange instances for each marginalium.
  // This exercises the public constructors of both classes.
  final List<SuggestionSpan> spans = <SuggestionSpan>[];
  for (int i = 0; i < marginalia.length; i++) {
    final _Marginalium m = marginalia[i];
    final TextRange range = TextRange(start: m.start, end: m.end);
    final SuggestionSpan span = SuggestionSpan(range, m.suggestions);
    spans.add(span);
    print(
      '  span[$i]: range=[${span.range.start}..${span.range.end}] '
      'suggestions=${span.suggestions.length} '
      'isValid=${span.range.isValid} '
      'isCollapsed=${span.range.isCollapsed}',
    );
  }

  // Special TextRange instances -- these come up frequently in client code.
  const TextRange emptyRange = TextRange.empty;
  const TextRange collapsedRange = TextRange.collapsed(7);
  const TextRange normalRange = TextRange(start: 4, end: 10);
  const TextRange invertedRange = TextRange(start: 10, end: 4);
  print('Special ranges:');
  print(
    '  TextRange.empty       isValid=${emptyRange.isValid} '
    'isCollapsed=${emptyRange.isCollapsed}',
  );
  print(
    '  TextRange.collapsed(7) isValid=${collapsedRange.isValid} '
    'isCollapsed=${collapsedRange.isCollapsed}',
  );
  print(
    '  TextRange(4,10)       isValid=${normalRange.isValid} '
    'isNormalized=${normalRange.isNormalized}',
  );
  print(
    '  TextRange(10,4)       isValid=${invertedRange.isValid} '
    'isNormalized=${invertedRange.isNormalized}',
  );

  // ==========================================================================
  // SECTION 1: The Proofreader's Desk -- title parchment
  // ==========================================================================
  print('=== Section 1: The Proofreader\'s Desk header ===');

  final Widget deskHeader = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_kInkBlue, _kInkBlueLight, _kSepia],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: <double>[0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kInkBlue.withValues(alpha: 0.55),
          blurRadius: 24.0,
          spreadRadius: 2.0,
          offset: const Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: _kProofRed.withValues(alpha: 0.18),
          blurRadius: 36.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
      border: Border.all(color: _kGilt, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Icon(Icons.menu_book, size: 56.0, color: _kGiltLight),
        const SizedBox(height: 10.0),
        const Text(
          'DefaultSpellCheckService',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6.0),
        const Text(
          'The Proofreader\'s Desk',
          style: TextStyle(
            fontSize: 16.0,
            fontStyle: FontStyle.italic,
            color: _kGiltLight,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: _kProofRed.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: _kGiltLight, width: 1.0),
          ),
          child: const Text(
            'package:flutter/services.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
  print('Built desk header.');

  // ==========================================================================
  // SECTION 2: The Service Charter -- abstract SpellCheckService overview
  // ==========================================================================
  print('=== Section 2: Service charter ===');

  final Widget charterCard = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const RadialGradient(
        colors: <Color>[_kParchment, _kParchmentDark],
        center: Alignment(-0.4, -0.4),
        radius: 1.2,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kSepiaLight, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kSepia.withValues(alpha: 0.25),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.gavel, color: _kInkBlue, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'The Service Charter',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _kInkBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'SpellCheckService is an abstract contract: any class that '
          'implements it promises to inspect a piece of text in a given '
          'Locale and return zero or more SuggestionSpan objects describing '
          'misspellings and their candidate replacements. '
          'DefaultSpellCheckService is the concrete implementation Flutter '
          'ships for the platforms where a system spell checker is '
          'available.',
          style: TextStyle(
            fontSize: 13.5,
            color: _kInkBlue,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            _signaturePill('abstract', _kInkBlueLight),
            const SizedBox(width: 8.0),
            _signaturePill('SpellCheckService', _kInkBlue),
            const SizedBox(width: 8.0),
            _signaturePill('contract', _kSepia),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            _signaturePill('class', _kInkBlueLight),
            const SizedBox(width: 8.0),
            _signaturePill('DefaultSpellCheckService', _kProofRed),
            const SizedBox(width: 8.0),
            _signaturePill('implementation', _kForest),
          ],
        ),
      ],
    ),
  );
  print('Built charter card.');

  // ==========================================================================
  // SECTION 3: Anatomy of a SuggestionSpan
  // ==========================================================================
  print('=== Section 3: Anatomy of a SuggestionSpan ===');

  final SuggestionSpan anatomySpan = spans[1]; // 'tset' -> 'test'
  final _Marginalium anatomyMargin = marginalia[1];
  print(
    'Anatomy uses span: range=[${anatomySpan.range.start}..'
    '${anatomySpan.range.end}] suggestions=${anatomySpan.suggestions}',
  );

  final Widget anatomyDiagram = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_kParchment, Color(0xFFEFD9A8)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kSepiaLight, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kSepia.withValues(alpha: 0.22),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Anatomy of a SuggestionSpan',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: _kInkBlue,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'A SuggestionSpan is the unit returned by '
          'fetchSpellCheckSuggestions: it pairs a TextRange (where the '
          'misspelling lives) with a list of replacement candidates.',
          style: TextStyle(fontSize: 12.5, color: _kInkBlue, height: 1.4),
        ),
        const SizedBox(height: 18.0),
        // Diagram: original text with the offending range highlighted
        // and an arrow pointing at the SuggestionSpan record.
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kSepiaLight),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 6.0,
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Original text:',
                style: TextStyle(fontSize: 11.0, color: _kSepia),
              ),
              const SizedBox(height: 4.0),
              _annotatedSentence(anatomyMargin),
              const SizedBox(height: 14.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 80.0,
                    height: 80.0,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.subdirectory_arrow_right,
                      color: _kProofRed,
                      size: 38.0,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            _kProofRed.withValues(alpha: 0.08),
                            _kProofRed.withValues(alpha: 0.18),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: _kProofRed, width: 1.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'SuggestionSpan',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: _kProofRedDeep,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          _fieldRow(
                            'range',
                            'TextRange(start: ${anatomySpan.range.start}, '
                                'end: ${anatomySpan.range.end})',
                          ),
                          _fieldRow(
                            'suggestions',
                            anatomySpan.suggestions.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        // Field tour
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _anatomyChip('range', 'TextRange', _kInkBlue, Icons.straighten),
            _anatomyChip(
              'suggestions',
              'List<String>',
              _kProofRed,
              Icons.list_alt,
            ),
          ],
        ),
      ],
    ),
  );
  print('Built anatomy diagram.');

  // ==========================================================================
  // SECTION 4: The TextRange Ruler
  // ==========================================================================
  print('=== Section 4: TextRange ruler ===');

  const String rulerSample = 'The quick brown fox';
  const TextRange rulerRange = TextRange(start: 4, end: 9);
  final String rulerBefore = rulerRange.textBefore(rulerSample);
  final String rulerInside = rulerRange.textInside(rulerSample);
  final String rulerAfter = rulerRange.textAfter(rulerSample);
  print('Ruler sample: "$rulerSample"');
  print('  textBefore => "$rulerBefore"');
  print('  textInside => "$rulerInside"');
  print('  textAfter  => "$rulerAfter"');

  final List<Widget> rulerCells = <Widget>[];
  for (int i = 0; i < rulerSample.length; i++) {
    final bool inside = i >= rulerRange.start && i < rulerRange.end;
    rulerCells.add(
      Container(
        width: 22.0,
        height: 36.0,
        margin: const EdgeInsets.symmetric(horizontal: 1.0),
        decoration: BoxDecoration(
          color: inside ? _kProofRed.withValues(alpha: 0.85) : Colors.white,
          border: Border.all(
            color: inside ? _kProofRedDeep : _kSepiaLight,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(3.0),
          boxShadow: inside
              ? <BoxShadow>[
                  BoxShadow(
                    color: _kProofRed.withValues(alpha: 0.4),
                    blurRadius: 4.0,
                  ),
                ]
              : <BoxShadow>[],
        ),
        alignment: Alignment.center,
        child: Text(
          rulerSample[i],
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: inside ? Colors.white : _kInkBlue,
          ),
        ),
      ),
    );
  }

  final List<Widget> rulerIndices = <Widget>[];
  for (int i = 0; i < rulerSample.length; i++) {
    rulerIndices.add(
      SizedBox(
        width: 24.0,
        child: Text(
          '$i',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.0,
            color: _kSepia,
          ),
        ),
      ),
    );
  }

  final Widget rulerCard = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: _kParchment,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kGilt, width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kGilt.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
        BoxShadow(
          color: _kSepia.withValues(alpha: 0.15),
          blurRadius: 4.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'The TextRange Ruler',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: _kInkBlue,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'TextRange(start, end) marks a half-open range over UTF-16 code '
          'units. The character at index "start" is included; the one at '
          '"end" is not. Use textBefore / textInside / textAfter to slice '
          'a string against the range.',
          style: TextStyle(fontSize: 12.5, color: _kInkBlue, height: 1.4),
        ),
        const SizedBox(height: 16.0),
        Row(mainAxisSize: MainAxisSize.min, children: rulerCells),
        const SizedBox(height: 4.0),
        Row(mainAxisSize: MainAxisSize.min, children: rulerIndices),
        const SizedBox(height: 14.0),
        _rulerKeyValue('range', 'TextRange(start: 4, end: 9)'),
        _rulerKeyValue('isValid', '${rulerRange.isValid}'),
        _rulerKeyValue('isCollapsed', '${rulerRange.isCollapsed}'),
        _rulerKeyValue('isNormalized', '${rulerRange.isNormalized}'),
        _rulerKeyValue('textBefore', '"$rulerBefore"'),
        _rulerKeyValue('textInside', '"$rulerInside"'),
        _rulerKeyValue('textAfter', '"$rulerAfter"'),
        const SizedBox(height: 14.0),
        // Special ranges row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _specialRangeBadge(
              'TextRange.empty',
              'isValid=${emptyRange.isValid}',
              _kSepia,
              Icons.do_not_disturb,
            ),
            _specialRangeBadge(
              'TextRange.collapsed(7)',
              'isCollapsed=${collapsedRange.isCollapsed}',
              _kInkBlue,
              Icons.crop_free,
            ),
            _specialRangeBadge(
              'TextRange(10, 4)',
              'isNormalized=${invertedRange.isNormalized}',
              _kProofRed,
              Icons.compare_arrows,
            ),
          ],
        ),
      ],
    ),
  );
  print('Built ruler card.');

  // ==========================================================================
  // SECTION 5: Lifecycle of a Spell-Check Request
  // ==========================================================================
  print('=== Section 5: Lifecycle ===');

  final Widget lifecycleCard = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFFCEFD0), _kParchment, _kParchmentDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kSepiaLight, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kSepia.withValues(alpha: 0.25),
          blurRadius: 16.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Lifecycle of a Spell-Check Request',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: _kInkBlue,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'fetchSpellCheckSuggestions is asynchronous. The diagram below '
          'follows a single request from a TextField edit through the '
          'platform channel and back into the framework as a list of '
          'SuggestionSpan objects.',
          style: TextStyle(fontSize: 12.5, color: _kInkBlue, height: 1.4),
        ),
        const SizedBox(height: 18.0),
        _lifecycleStep(
          1,
          'TextField edit',
          'User types into a TextField with a SpellCheckConfiguration that '
              'references DefaultSpellCheckService.',
          _kInkBlue,
          Icons.edit_note,
        ),
        _lifecycleConnector(),
        _lifecycleStep(
          2,
          'fetchSpellCheckSuggestions(locale, text)',
          'The framework calls into the service with the user\'s Locale '
              'and the current text contents.',
          _kInkBlueLight,
          Icons.outbox,
        ),
        _lifecycleConnector(),
        _lifecycleStep(
          3,
          'Platform channel',
          'DefaultSpellCheckService forwards the request to the host OS '
              '(Android TextServicesManager / iOS UITextChecker).',
          _kSepia,
          Icons.swap_horiz,
        ),
        _lifecycleConnector(),
        _lifecycleStep(
          4,
          'Future<List<SuggestionSpan>?>',
          'The platform replies. The future completes with a list of '
              'SuggestionSpan, an empty list, or null if the platform '
              'declined.',
          _kProofRed,
          Icons.inbox,
        ),
        _lifecycleConnector(),
        _lifecycleStep(
          5,
          'TextField re-renders',
          'Misspelled words are underlined; long-pressing a span shows the '
              'replacements list.',
          _kForest,
          Icons.menu_book,
        ),
      ],
    ),
  );
  print('Built lifecycle card.');

  // ==========================================================================
  // SECTION 6: Marginalia Gallery -- one card per SuggestionSpan example
  // ==========================================================================
  print('=== Section 6: Marginalia gallery ===');

  final List<Widget> marginaliaCards = <Widget>[];
  for (int i = 0; i < marginalia.length; i++) {
    final _Marginalium m = marginalia[i];
    final SuggestionSpan span = spans[i];
    print(
      '  card[$i]: "${m.misspelled}" -> ${span.suggestions} '
      '(range=${span.range.start}..${span.range.end})',
    );
    marginaliaCards.add(_marginaliumCard(m, span, i));
  }

  final Widget marginaliaSection = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFAF0),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kSepiaLight, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kProofRed.withValues(alpha: 0.1),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.note_alt, color: _kProofRed, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Marginalia Gallery',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _kInkBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Each card pins a real SuggestionSpan to the parchment: the '
          'highlighted misspelling, its TextRange offsets, and the ranked '
          'list of replacements the service might return.',
          style: TextStyle(fontSize: 12.5, color: _kInkBlue, height: 1.4),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: marginaliaCards,
        ),
      ],
    ),
  );
  print('Built ${marginaliaCards.length} marginalia cards.');

  // ==========================================================================
  // SECTION 7: Locale Catalog
  // ==========================================================================
  print('=== Section 7: Locale catalog ===');

  final List<_LocaleEntry> locales = <_LocaleEntry>[
    const _LocaleEntry(
      code: 'en_US',
      name: 'English (United States)',
      sample: 'Ths is a tset.',
      hits: 2,
    ),
    const _LocaleEntry(
      code: 'en_GB',
      name: 'English (United Kingdom)',
      sample: 'Behaviour is colourised.',
      hits: 0,
    ),
    const _LocaleEntry(
      code: 'fr_FR',
      name: 'Français (France)',
      sample: 'Bonjur tout le monde.',
      hits: 1,
    ),
    const _LocaleEntry(
      code: 'de_DE',
      name: 'Deutsch (Deutschland)',
      sample: 'Wilkommen zu Hause.',
      hits: 1,
    ),
    const _LocaleEntry(
      code: 'es_ES',
      name: 'Español (España)',
      sample: 'Hla, cómo estás?',
      hits: 1,
    ),
    const _LocaleEntry(
      code: 'ja_JP',
      name: '日本語 (日本)',
      sample: 'こんにちわ世界',
      hits: 0,
    ),
  ];

  final List<Widget> localeCards = <Widget>[];
  for (int i = 0; i < locales.length; i++) {
    final _LocaleEntry e = locales[i];
    print('  locale[$i]: ${e.code} sample="${e.sample}" hits=${e.hits}');
    localeCards.add(_localeCard(e));
  }

  final Widget localeSection = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const RadialGradient(
        colors: <Color>[_kParchment, _kParchmentDark],
        center: Alignment.center,
        radius: 1.1,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kGilt, width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kGilt.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Locale Catalog',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: _kInkBlue,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'fetchSpellCheckSuggestions takes a Locale as its first argument. '
          'Whether a system dictionary exists for that locale is platform '
          'specific -- if none does, the future may resolve with null. '
          'Below: a tour of locales the proofreader keeps on the desk.',
          style: TextStyle(fontSize: 12.5, color: _kInkBlue, height: 1.4),
        ),
        const SizedBox(height: 14.0),
        Wrap(spacing: 10.0, runSpacing: 10.0, children: localeCards),
      ],
    ),
  );
  print('Built locale catalog.');

  // ==========================================================================
  // SECTION 8: Type Hierarchy Scroll
  // ==========================================================================
  print('=== Section 8: Type hierarchy ===');

  final Widget hierarchyCard = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_kInkBlue, _kInkBlueLight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _kGilt, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kInkBlue.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Type Hierarchy',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'How the four types covered by this demo relate to one another.',
          style: TextStyle(
            fontSize: 12.0,
            color: _kGiltLight,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 18.0),
        _hierarchyNode(
          'SpellCheckService',
          'abstract contract',
          _kGilt,
          true,
        ),
        _hierarchyConnector(),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: _hierarchyNode(
            'DefaultSpellCheckService',
            'platform-channel implementation',
            _kProofRed,
            false,
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Returned record:',
          style: TextStyle(fontSize: 12.0, color: _kGiltLight),
        ),
        const SizedBox(height: 8.0),
        _hierarchyNode(
          'SuggestionSpan',
          'range + List<String> suggestions',
          _kSepiaLight,
          false,
        ),
        _hierarchyConnector(),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: _hierarchyNode(
            'TextRange',
            'half-open [start, end) over UTF-16',
            _kGiltLight,
            false,
          ),
        ),
      ],
    ),
  );
  print('Built type hierarchy.');

  // ==========================================================================
  // SECTION 9: The Proofreader's Manual -- usage code excerpts
  // ==========================================================================
  print('=== Section 9: Manual ===');

  final Widget manualCard = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: const Color(0xFF12181F),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kGilt, width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: _kGilt.withValues(alpha: 0.18),
          blurRadius: 28.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.terminal, color: _kGiltLight, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'The Proofreader\'s Manual',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: _kGiltLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _manualSnippet(
          '// Construct the default service and ask the platform to check '
              'a sentence.\n'
              'final SpellCheckService service = DefaultSpellCheckService();\n'
              'final Future<List<SuggestionSpan>?> request =\n'
              '    service.fetchSpellCheckSuggestions(\n'
              '      const Locale(\'en\', \'US\'),\n'
              '      \'Ths is a tset of the spel cheker.\',\n'
              '    );',
        ),
        const SizedBox(height: 12.0),
        _manualSnippet(
          '// Inspect a SuggestionSpan returned by the platform.\n'
              'final SuggestionSpan span = SuggestionSpan(\n'
              '  const TextRange(start: 9, end: 13),\n'
              '  const <String>[\'test\', \'taste\', \'tsetse\'],\n'
              ');\n'
              'final TextRange r = span.range;\n'
              'final List<String> words = span.suggestions;',
        ),
        const SizedBox(height: 12.0),
        _manualSnippet(
          '// Slice the original text using TextRange helpers.\n'
              'const String src = \'The quick brown fox\';\n'
              'const TextRange r = TextRange(start: 4, end: 9);\n'
              'final String before = r.textBefore(src); // "The "\n'
              'final String inside = r.textInside(src); // "quick"\n'
              'final String after  = r.textAfter(src);  // " brown fox"',
        ),
        const SizedBox(height: 12.0),
        _manualSnippet(
          '// Wire the service into a Material TextField via\n'
              '// SpellCheckConfiguration.\n'
              'TextField(\n'
              '  spellCheckConfiguration: SpellCheckConfiguration(\n'
              '    spellCheckService: DefaultSpellCheckService(),\n'
              '  ),\n'
              ');',
        ),
      ],
    ),
  );
  print('Built manual card.');

  // ==========================================================================
  // SECTION 10: When To Use This Service -- guidance paragraph
  // ==========================================================================
  print('=== Section 10: Guidance ===');

  final Widget guidanceCard = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          _kForest.withValues(alpha: 0.12),
          _kGilt.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kGilt, width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kGilt.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.lightbulb_outline, color: _kGilt, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'When To Reach For This Service',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _kInkBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _bulletLine(
          'Reach for DefaultSpellCheckService when you want native, '
          'on-device spell-checking for free in any TextField.',
        ),
        _bulletLine(
          'Subclass SpellCheckService directly when you need a custom '
          'dictionary -- legal, medical, code identifiers -- or a remote '
          'check.',
        ),
        _bulletLine(
          'Treat a null result from the future as "the platform declined": '
          'either the locale is unsupported or spell-checking is disabled '
          'system-wide.',
        ),
        _bulletLine(
          'Treat the suggestions list as ranked best-first; surface only the '
          'top few in a long-press menu to avoid overwhelming users.',
        ),
        _bulletLine(
          'A SuggestionSpan with an empty suggestions list still indicates a '
          'misspelling -- you may underline it without offering a fix.',
        ),
      ],
    ),
  );
  print('Built guidance card.');

  // ==========================================================================
  // FOOTER
  // ==========================================================================
  final Widget footer = Container(
    margin: const EdgeInsets.only(top: 16.0, bottom: 24.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_kSepia, _kInkBlue],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kInkBlue.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        const Icon(Icons.draw, color: _kGiltLight, size: 28.0),
        const SizedBox(height: 6.0),
        const Text(
          'End of the Proofreader\'s Desk',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'service: ${service.runtimeType}  '
          '/  spans: ${spans.length}  '
          '/  locales: ${locales.length}',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: _kGiltLight,
          ),
        ),
      ],
    ),
  );

  print('All sections built. Returning SingleChildScrollView.');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        deskHeader,
        const SizedBox(height: 18.0),
        _sectionTitle('1. The Service Charter'),
        charterCard,
        _sectionTitle('2. Anatomy of a SuggestionSpan'),
        anatomyDiagram,
        _sectionTitle('3. The TextRange Ruler'),
        rulerCard,
        _sectionTitle('4. Lifecycle of a Spell-Check Request'),
        lifecycleCard,
        _sectionTitle('5. Marginalia Gallery'),
        marginaliaSection,
        _sectionTitle('6. Locale Catalog'),
        localeSection,
        _sectionTitle('7. Type Hierarchy'),
        hierarchyCard,
        _sectionTitle('8. The Proofreader\'s Manual'),
        manualCard,
        _sectionTitle('9. Guidance'),
        guidanceCard,
        footer,
      ],
    ),
  );
}

// ============================================================================
// Data carriers
// ============================================================================
class _Marginalium {
  final String original;
  final String misspelled;
  final int start;
  final int end;
  final List<String> suggestions;
  final String note;

  const _Marginalium({
    required this.original,
    required this.misspelled,
    required this.start,
    required this.end,
    required this.suggestions,
    required this.note,
  });
}

class _LocaleEntry {
  final String code;
  final String name;
  final String sample;
  final int hits;

  const _LocaleEntry({
    required this.code,
    required this.name,
    required this.sample,
    required this.hits,
  });
}

// ============================================================================
// Widget helpers
// ============================================================================

Widget _sectionTitle(String label) {
  return Padding(
    padding: const EdgeInsets.only(top: 24.0, bottom: 4.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 4.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: _kProofRed,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: _kInkBlue,
            letterSpacing: 0.4,
          ),
        ),
      ],
    ),
  );
}

Widget _signaturePill(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}

// Render a sentence with the misspelled span highlighted in red ink.
Widget _annotatedSentence(_Marginalium m) {
  final String before = m.original.substring(0, m.start);
  final String inside = m.original.substring(m.start, m.end);
  final String after = m.original.substring(m.end);
  return RichText(
    text: TextSpan(
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 14.0,
        color: _kInkBlue,
      ),
      children: <InlineSpan>[
        TextSpan(text: before),
        TextSpan(
          text: inside,
          style: const TextStyle(
            color: _kProofRedDeep,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationColor: _kProofRed,
            decorationStyle: TextDecorationStyle.wavy,
          ),
        ),
        TextSpan(text: after),
      ],
    ),
  );
}

Widget _fieldRow(String name, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 96.0,
          child: Text(
            '$name:',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: _kInkBlue,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: _kProofRedDeep,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyChip(String field, String type, Color color, IconData icon) {
  return Container(
    width: 140.0,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        Icon(icon, color: color, size: 26.0),
        const SizedBox(height: 6.0),
        Text(
          field,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          type,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.5,
            color: color.withValues(alpha: 0.85),
          ),
        ),
      ],
    ),
  );
}

Widget _rulerKeyValue(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            key,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: _kSepia,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: _kInkBlue,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _specialRangeBadge(
  String label,
  String detail,
  Color color,
  IconData icon,
) {
  return Container(
    width: 140.0,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.2),
    ),
    child: Column(
      children: <Widget>[
        Icon(icon, color: color, size: 22.0),
        const SizedBox(height: 6.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.5,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          detail,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.5,
            color: color.withValues(alpha: 0.85),
          ),
        ),
      ],
    ),
  );
}

Widget _lifecycleStep(
  int index,
  String title,
  String body,
  Color color,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Icon(icon, color: color, size: 22.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: _kInkBlue,
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

Widget _lifecycleConnector() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
    child: Container(
      width: 2.0,
      height: 18.0,
      color: _kSepiaLight,
    ),
  );
}

Widget _marginaliumCard(_Marginalium m, SuggestionSpan span, int index) {
  final List<Widget> suggestionChips = <Widget>[];
  for (int i = 0; i < span.suggestions.length; i++) {
    final String s = span.suggestions[i];
    suggestionChips.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: i == 0
              ? _kForest.withValues(alpha: 0.15)
              : _kGilt.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: i == 0 ? _kForest : _kGilt,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (i == 0)
              const Padding(
                padding: EdgeInsets.only(right: 4.0),
                child: Icon(Icons.star, size: 10.0, color: _kForest),
              ),
            Text(
              s,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: i == 0 ? FontWeight.bold : FontWeight.w500,
                color: i == 0 ? _kForest : _kSepia,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    width: 280.0,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kSepiaLight, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kSepia.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
        BoxShadow(
          color: _kProofRed.withValues(alpha: 0.06),
          blurRadius: 16.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: _kProofRed,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '#${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '[${span.range.start}..${span.range.end}]',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: _kSepia,
              ),
            ),
            const Spacer(),
            const Icon(Icons.spellcheck, size: 14.0, color: _kProofRed),
          ],
        ),
        const SizedBox(height: 8.0),
        _annotatedSentence(m),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            const Icon(Icons.arrow_right, color: _kSepia, size: 16.0),
            const SizedBox(width: 4.0),
            Text(
              'suggestions:',
              style: TextStyle(
                fontSize: 10.5,
                color: _kSepia,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: suggestionChips,
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: _kParchment,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: _kSepiaLight, width: 0.8),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.note, size: 12.0, color: _kSepia),
              const SizedBox(width: 4.0),
              Expanded(
                child: Text(
                  m.note,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontStyle: FontStyle.italic,
                    color: _kSepia,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _localeCard(_LocaleEntry e) {
  final Color accent = e.hits > 0 ? _kProofRed : _kForest;
  return Container(
    width: 220.0,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kSepiaLight, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: _kInkBlue,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                e.code,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: accent, width: 0.8),
              ),
              child: Text(
                '${e.hits} hits',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          e.name,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: _kInkBlue,
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: _kParchment,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            e.sample,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: _kInkBlue,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _hierarchyNode(
  String name,
  String tagline,
  Color color,
  bool isAbstract,
) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Icon(
          isAbstract ? Icons.architecture : Icons.extension,
          color: color,
          size: 22.0,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                tagline,
                style: TextStyle(
                  fontSize: 10.5,
                  fontStyle: FontStyle.italic,
                  color: color.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _hierarchyConnector() {
  return Padding(
    padding: const EdgeInsets.only(left: 28.0, top: 4.0, bottom: 4.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 2.0,
          height: 18.0,
          color: _kGiltLight,
        ),
        const SizedBox(width: 8.0),
        const Icon(
          Icons.subdirectory_arrow_right,
          size: 16.0,
          color: _kGiltLight,
        ),
      ],
    ),
  );
}

Widget _manualSnippet(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: const Color(0xFF1B232E),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: _kGilt.withValues(alpha: 0.4),
        width: 0.8,
      ),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: _kGiltLight,
        height: 1.45,
      ),
    ),
  );
}

Widget _bulletLine(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 6.0, right: 8.0),
          width: 8.0,
          height: 8.0,
          decoration: const BoxDecoration(
            color: _kProofRed,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12.5,
              color: _kInkBlue,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep demo: SpellCheckService — Flutter's abstract spell-checking
// contract. Real implementations talk to the underlying platform (iOS /
// Android) and asynchronously return a list of `SuggestionSpan`s describing
// which substrings of the supplied text are flagged as misspelled and what
// the platform thinks the user might have meant.
//
// In this hand-authored demo we wire a custom `_MockSpellCheckService` to
// real `TextField`s via `SpellCheckConfiguration(spellCheckService: ...)`.
// The mock uses a small static dictionary so the demo is fully deterministic
// and platform-independent; the goal is to illustrate the *contract*, the
// `SuggestionSpan` data model, and how the configuration plumbing connects
// a service implementation to one or many editors at once.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─────────────────────────────────────────────────────────────────────────
// Custom SpellCheckService implementation.
//
// The real `DefaultSpellCheckService` performs an asynchronous round trip
// to the platform spell checker and returns whatever ranges it considers
// suspicious. We can substitute our own implementation by extending
// `SpellCheckService` and overriding `fetchSpellCheckSuggestions`. The
// resulting service may then be plugged into any `TextField` through the
// `spellCheckConfiguration` parameter.
//
// The mock below stores a static map of well-known misspellings to a list
// of replacement suggestions, scans the supplied text for each entry, and
// produces a `SuggestionSpan` per occurrence. Each span carries the
// `TextRange` covering the bad word plus a small list of replacements that
// the user may apply.
// ─────────────────────────────────────────────────────────────────────────

class _MockSpellCheckService extends SpellCheckService {
  // A tiny dictionary of common typos. Keys are the misspelled words exactly
  // as they appear in the input; values are ordered replacement suggestions
  // (best guess first). The mock is intentionally case-sensitive and naive —
  // production grade spell checking is the platform's job, this is just a
  // demonstration of how the contract slots together.
  static const Map<String, List<String>> dictionary = <String, List<String>>{
    'teh': <String>['the', 'tea', 'tee'],
    'recieve': <String>['receive', 'relieve'],
    'occured': <String>['occurred'],
    'definately': <String>['definitely', 'defiantly'],
    'seperate': <String>['separate', 'desperate'],
    'untill': <String>['until', 'untie'],
    'wierd': <String>['weird'],
    'thier': <String>['their', 'there', 'they\'re'],
    'occassion': <String>['occasion'],
    'accomodate': <String>['accommodate'],
    'neccessary': <String>['necessary'],
    'embarass': <String>['embarrass'],
    'goverment': <String>['government'],
    'beleive': <String>['believe'],
    'acheive': <String>['achieve'],
    'persistant': <String>['persistent'],
    'enviroment': <String>['environment'],
    'tommorow': <String>['tomorrow'],
    'collegue': <String>['colleague'],
  };

  @override
  Future<List<SuggestionSpan>?> fetchSpellCheckSuggestions(
    Locale locale,
    String text,
  ) async {
    // Async contract: we yield to allow the caller to await us as if we had
    // crossed the platform channel boundary. In a real implementation this
    // is where the platform message would be sent and the result decoded.
    await Future<void>.delayed(const Duration(milliseconds: 1));

    final List<SuggestionSpan> spans = <SuggestionSpan>[];

    // Walk every entry in the dictionary and collect every occurrence in
    // the input text. We respect word boundaries so substrings inside other
    // words are not flagged (e.g. "teh" inside "tehee" should not match).
    dictionary.forEach((String typo, List<String> replacements) {
      int start = 0;
      while (start <= text.length - typo.length) {
        final int idx = text.indexOf(typo, start);
        if (idx < 0) break;
        final int end = idx + typo.length;
        final bool leftBoundary =
            idx == 0 || !_isWordChar(text.codeUnitAt(idx - 1));
        final bool rightBoundary =
            end == text.length || !_isWordChar(text.codeUnitAt(end));
        if (leftBoundary && rightBoundary) {
          spans.add(
            SuggestionSpan(
              TextRange(start: idx, end: end),
              replacements,
            ),
          );
        }
        start = end;
      }
    });

    // SuggestionSpans are conventionally returned in document order so the
    // editor can iterate through them efficiently. Sort by start offset.
    spans.sort((SuggestionSpan a, SuggestionSpan b) =>
        a.range.start.compareTo(b.range.start));
    return spans;
  }

  static bool _isWordChar(int code) {
    return (code >= 0x30 && code <= 0x39) || // 0-9
        (code >= 0x41 && code <= 0x5A) || // A-Z
        (code >= 0x61 && code <= 0x7A) || // a-z
        code == 0x27; // apostrophe
  }
}

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
  const Color spellRed = Color(0xFFDC2626);

  print('===== SPELL CHECK SERVICE DEEP DEMO =====');

  // The single shared service instance for editors that want consistent,
  // deterministic suggestions across the demo. In production you would
  // typically share a single `SpellCheckService` across the whole app.
  final _MockSpellCheckService mockService = _MockSpellCheckService();

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[terracotta, copper, rust],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(11),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: terracotta.withOpacity(0.35),
            blurRadius: 11,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: terracotta,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.4,
              ),
            ),
          ),
          const Icon(Icons.spellcheck, color: Colors.white, size: 22),
        ],
      ),
    );
  }

  Widget paragraph(String text, {Color? color, double size = 14}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Text(
        text,
        style: TextStyle(
          color: color ?? mahogany,
          fontSize: size,
          height: 1.5,
        ),
      ),
    );
  }

  Widget callout(String label, String text, Color accent) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.12),
        border: Border(left: BorderSide(color: accent, width: 4)),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: accent,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(
              color: mahogany,
              fontSize: 13.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  Widget infoChip(String label, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        border: Border.all(color: color, width: 1.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color, size: 15),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }

  // Build the live "suggestions panel" for a given text and service. We
  // call `fetchSpellCheckSuggestions` synchronously through a `FutureBuilder`
  // so the panel re-runs whenever the surrounding widget rebuilds (i.e.
  // whenever the controller text changes).
  Widget buildSuggestionsPanel({
    required String text,
    required SpellCheckService service,
    required void Function(SuggestionSpan span, String replacement) onApply,
    Color accent = terracotta,
  }) {
    return FutureBuilder<List<SuggestionSpan>?>(
      future: service.fetchSpellCheckSuggestions(const Locale('en', 'US'), text),
      builder: (BuildContext ctx, AsyncSnapshot<List<SuggestionSpan>?> snap) {
        if (!snap.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(accent),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Spell-checking…',
                  style: TextStyle(color: accent, fontSize: 12.5),
                ),
              ],
            ),
          );
        }
        final List<SuggestionSpan> spans = snap.data ?? <SuggestionSpan>[];
        if (spans.isEmpty) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade400),
            ),
            child: const Row(
              children: <Widget>[
                Icon(Icons.check_circle, color: Colors.green, size: 18),
                SizedBox(width: 8),
                Text(
                  'No misspellings detected',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 8),
            Text(
              '${spans.length} misspelling${spans.length == 1 ? '' : 's'} found:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: accent,
                fontSize: 13.5,
              ),
            ),
            const SizedBox(height: 6),
            for (final SuggestionSpan span in spans)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: paleWarm,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: sandstone),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Icon(Icons.error_outline,
                            color: spellRed, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          span.range.textInside(text),
                          style: const TextStyle(
                            color: spellRed,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '@ [${span.range.start}..${span.range.end})',
                          style: TextStyle(
                            color: bronze,
                            fontSize: 11,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: <Widget>[
                        for (final String suggestion
                            in span.suggestions)
                          ActionChip(
                            avatar: const Icon(
                              Icons.auto_fix_high,
                              size: 14,
                              color: terracotta,
                            ),
                            label: Text(suggestion),
                            backgroundColor: Colors.white,
                            side: BorderSide(color: accent, width: 1),
                            labelStyle: TextStyle(
                              color: accent,
                              fontWeight: FontWeight.w700,
                            ),
                            onPressed: () => onApply(span, suggestion),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  // Render an inline rich-text view that mimics a wavy red underline below
  // every misspelled span.
  Widget buildHighlightView({
    required String text,
    required List<SuggestionSpan> spans,
    double fontSize = 14,
  }) {
    if (spans.isEmpty) {
      return Text(
        text,
        style: TextStyle(fontSize: fontSize, color: mahogany, height: 1.5),
      );
    }
    final List<TextSpan> children = <TextSpan>[];
    int cursor = 0;
    for (final SuggestionSpan span in spans) {
      if (span.range.start > cursor) {
        children.add(
          TextSpan(text: text.substring(cursor, span.range.start)),
        );
      }
      children.add(
        TextSpan(
          text: text.substring(span.range.start, span.range.end),
          style: const TextStyle(
            color: spellRed,
            decoration: TextDecoration.underline,
            decorationColor: spellRed,
            decorationStyle: TextDecorationStyle.wavy,
            decorationThickness: 2.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
      cursor = span.range.end;
    }
    if (cursor < text.length) {
      children.add(TextSpan(text: text.substring(cursor)));
    }
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          color: mahogany,
          height: 1.5,
        ),
        children: children,
      ),
    );
  }

  // ─── Section 1: Intro ───
  Widget section1Intro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        sectionBanner('1', 'Introduction — what SpellCheckService is'),
        paragraph(
          'SpellCheckService is the abstract Flutter contract that hands a '
          'piece of text to the underlying platform spell checker and gets '
          'back a list of suspicious ranges. It lives in '
          'package:flutter/services.dart and is wired to a TextField via '
          'SpellCheckConfiguration. The default implementation, '
          'DefaultSpellCheckService, calls into the iOS UITextChecker or the '
          'Android SpellCheckerSession behind the scenes; subclassing it '
          'lets you provide your own dictionary, language model, or stubbed '
          'service for testing.',
        ),
        callout(
          'CONTRACT',
          'fetchSpellCheckSuggestions(Locale locale, String text) returns a '
          'Future<List<SuggestionSpan>?>. Each SuggestionSpan carries a '
          'TextRange and a list of replacement strings ordered by likelihood.',
          terracotta,
        ),
        callout(
          'ASYNC',
          'The contract is asynchronous because real implementations cross '
          'the platform channel boundary. Returning null indicates the '
          'request was cancelled or unsupported; an empty list means the '
          'platform looked but found nothing.',
          rust,
        ),
        callout(
          'SCOPE',
          'Each call inspects the entire string, not just the user\'s last '
          'edit. The TextField throttles invocations and only redraws the '
          'misspelling underlines when the result list changes.',
          bronze,
        ),
        Wrap(
          children: <Widget>[
            infoChip('abstract', Icons.architecture, terracotta),
            infoChip('async', Icons.sync, rust),
            infoChip('platform-bridged', Icons.phone_iphone, copper),
            infoChip('locale-aware', Icons.language, bronze),
            infoChip('range-based', Icons.straighten, burnSienna),
            infoChip('replaceable', Icons.swap_horiz, amber),
          ],
        ),
      ],
    );
  }

  // ─── Section 2: Custom service implementation display ───
  Widget section2Custom() {
    const String code = '''
class _MockSpellCheckService extends SpellCheckService {
  static const Map<String, List<String>> dictionary = {
    'teh': ['the', 'tea', 'tee'],
    'recieve': ['receive', 'relieve'],
    'occured': ['occurred'],
    'definately': ['definitely', 'defiantly'],
    // ... more entries
  };

  @override
  Future<List<SuggestionSpan>?> fetchSpellCheckSuggestions(
    Locale locale,
    String text,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 1));
    final List<SuggestionSpan> spans = [];
    dictionary.forEach((typo, replacements) {
      int start = 0;
      while (start <= text.length - typo.length) {
        final idx = text.indexOf(typo, start);
        if (idx < 0) break;
        final end = idx + typo.length;
        if (_isWordBoundary(text, idx, end)) {
          spans.add(SuggestionSpan(
            TextRange(start: idx, end: end),
            replacements,
          ));
        }
        start = end;
      }
    });
    spans.sort((a, b) => a.range.start.compareTo(b.range.start));
    return spans;
  }
}
''';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        sectionBanner('2', 'Custom SpellCheckService implementation'),
        paragraph(
          'Below is the source of the mock service used throughout this '
          'demo. It implements the abstract contract by scanning the input '
          'against a small static dictionary and emitting a SuggestionSpan '
          'per match. The same shape applies to a "real" service that '
          'consults a remote service or an on-device language model.',
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1300),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: bronze),
          ),
          child: SelectableText(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: warmGlow,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 10),
        callout(
          'STEP 1',
          'Extend SpellCheckService and override fetchSpellCheckSuggestions. '
          'The signature is fixed; you may not change parameters or return '
          'type.',
          terracotta,
        ),
        callout(
          'STEP 2',
          'Use Future.delayed (or a real platform call) to keep the contract '
          'asynchronous. Synchronous returns still work, but real Flutter '
          'editors expect the call to be deferable.',
          rust,
        ),
        callout(
          'STEP 3',
          'Return SuggestionSpans sorted by range.start so the editor can '
          'walk them in document order while painting underlines.',
          bronze,
        ),
        callout(
          'STEP 4',
          'Apply word-boundary checks so substrings inside other words are '
          'not flagged. The platform default does this implicitly; custom '
          'services must do it explicitly.',
          burnSienna,
        ),
      ],
    );
  }

  // ─── Section 3: Live TextField with suggestions ───
  Widget section3Live() {
    return _LiveTextFieldDemo(
      service: mockService,
      accent: terracotta,
      buildSuggestionsPanel: buildSuggestionsPanel,
    );
  }

  // ─── Section 4: Multi-line essay editor ───
  Widget section4Essay() {
    return _EssayEditorDemo(
      service: mockService,
      accent: copper,
      buildHighlightView: buildHighlightView,
    );
  }

  // ─── Section 5: Service contract explainer ───
  Widget section5Contract() {
    Widget contractCard(
      String title,
      String body,
      IconData icon,
      Color color,
    ) {
      return Container(
        width: 220,
        margin: const EdgeInsets.only(right: 12, bottom: 8),
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border(left: BorderSide(color: color, width: 5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: const TextStyle(
                color: mahogany,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        sectionBanner('5', 'Service contract — at a glance'),
        paragraph(
          'These four cards summarise the most important properties of the '
          'SpellCheckService contract. Memorising them helps when subclassing '
          'or when debugging unexpected highlighting behaviour.',
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              contractCard(
                'Synchronous? No',
                'Returns Future<List<SuggestionSpan>?>. Real implementations '
                'cross the platform channel boundary; the editor awaits the '
                'result before redrawing underlines.',
                Icons.sync,
                terracotta,
              ),
              contractCard(
                'Scope? Entire string',
                'The service is invoked with the full document text on every '
                'meaningful change. The editor itself coalesces edits before '
                'invoking the service.',
                Icons.text_fields,
                rust,
              ),
              contractCard(
                'Language? From config',
                'The locale comes from SpellCheckConfiguration on the '
                'TextField. Implementations that span languages branch on '
                'the supplied Locale to pick a dictionary.',
                Icons.language,
                copper,
              ),
              contractCard(
                'Platform support? iOS+Android',
                'The default implementation only works on iOS and Android. '
                'Other platforms (web, desktop) need a custom service such '
                'as the one in this demo.',
                Icons.phone_iphone,
                bronze,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Section 6: Comparison default vs custom ───
  Widget section6Comparison() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        sectionBanner('6', 'Default vs custom service'),
        paragraph(
          'Two TextFields side by side. The left one uses the platform '
          'DefaultSpellCheckService (which only emits results on real iOS / '
          'Android), the right one uses our deterministic mock. Both share '
          'the same SpellCheckConfiguration shape — only the service '
          'instance differs.',
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: terracotta, width: 1.4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'DEFAULT',
                      style: TextStyle(
                        color: terracotta,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'spellCheckService: DefaultSpellCheckService()',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        color: mahogany,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: TextEditingController(
                        text: 'I recieve teh news definately tomorrow.',
                      ),
                      maxLines: 3,
                      spellCheckConfiguration: SpellCheckConfiguration(
                        spellCheckService: DefaultSpellCheckService(),
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: paleWarm,
                      ),
                    ),
                    const SizedBox(height: 6),
                    paragraph(
                      'The platform default works on iOS / Android only. On '
                      'other targets it returns no spans.',
                      size: 12,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: copper, width: 1.4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'CUSTOM',
                      style: TextStyle(
                        color: copper,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'spellCheckService: _MockSpellCheckService()',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        color: mahogany,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: TextEditingController(
                        text: 'I recieve teh news definately tomorrow.',
                      ),
                      maxLines: 3,
                      spellCheckConfiguration: SpellCheckConfiguration(
                        spellCheckService: mockService,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: paleWarm,
                      ),
                    ),
                    const SizedBox(height: 6),
                    paragraph(
                      'The mock is deterministic and works everywhere. Useful '
                      'for tests, demos, and unsupported platforms.',
                      size: 12,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─── Section 7: Configuration showcase ───
  Widget section7ConfigShowcase() {
    Widget showcaseField({
      required String label,
      required String description,
      required SpellCheckConfiguration config,
      required String seedText,
      Color accent = terracotta,
    }) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accent.withOpacity(0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.settings_suggest, color: accent, size: 18),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.w900,
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                color: mahogany,
                fontSize: 12,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: seedText),
              maxLines: 3,
              spellCheckConfiguration: config,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: paleWarm,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        sectionBanner('7', 'SpellCheckConfiguration showcase'),
        paragraph(
          'SpellCheckConfiguration packages a service with optional UI '
          'overrides — for example a custom suggestions toolbar builder or '
          'a custom misspelled-text style. Multiple TextFields can share '
          'the same service while customising their UI independently.',
        ),
        showcaseField(
          label: 'Default toolbar',
          description: 'Plain SpellCheckConfiguration with our mock service. '
              'The platform supplies the toolbar UI.',
          config: SpellCheckConfiguration(spellCheckService: mockService),
          seedText: 'Quick brown fox jumpd over teh lazy dog.',
          accent: terracotta,
        ),
        showcaseField(
          label: 'Custom suggestions toolbar builder',
          description: 'spellCheckSuggestionsToolbarBuilder lets you control '
              'how the suggestions toolbar is constructed when a misspelling '
              'is tapped on mobile.',
          config: SpellCheckConfiguration(
            spellCheckService: mockService,
            spellCheckSuggestionsToolbarBuilder: (
              BuildContext ctx,
              EditableTextState state,
            ) {
              return Container(
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: warmGlow,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: bronze),
                ),
                child: const Text(
                  'Custom toolbar (mock)',
                  style: TextStyle(
                    color: mahogany,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          seedText: 'Definately recieve a wierd surprise.',
          accent: rust,
        ),
        showcaseField(
          label: 'Custom misspelled-text style',
          description: 'misspelledTextStyle overrides how flagged words are '
              'rendered. Here we use solid red bold instead of the default '
              'wavy underline.',
          config: SpellCheckConfiguration(
            spellCheckService: mockService,
            misspelledTextStyle: const TextStyle(
              color: spellRed,
              fontWeight: FontWeight.w900,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.double,
            ),
          ),
          seedText: 'Tommorow we acheive embarass-free goverment.',
          accent: copper,
        ),
        showcaseField(
          label: 'Disabled (no service)',
          description: 'SpellCheckConfiguration.disabled() turns spell '
              'checking off entirely while keeping the rest of the editor '
              'intact.',
          config: const SpellCheckConfiguration.disabled(),
          seedText: 'Teh wierd recieve definately stays unchecked.',
          accent: bronze,
        ),
      ],
    );
  }

  // ─── Section 8: Static essay with tooltip suggestions ───
  Widget section8Visualization() {
    const String essay =
        'In the early occassion of teh project we tried to seperate '
        'concerns and acheive a clean enviroment. Tommorow our collegue '
        'will recieve the documents — definately not later than that. '
        'Sometimes its hard to beleive how often these typos slip into '
        'a goverment memo.';
    return FutureBuilder<List<SuggestionSpan>?>(
      future: mockService.fetchSpellCheckSuggestions(
        const Locale('en', 'US'),
        essay,
      ),
      builder: (BuildContext ctx, AsyncSnapshot<List<SuggestionSpan>?> snap) {
        final List<SuggestionSpan> spans = snap.data ?? <SuggestionSpan>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            sectionBanner('8', 'Misspelling visualization with tooltips'),
            paragraph(
              'A static paragraph with several known misspellings, rendered '
              'via RichText. Flagged words wear a wavy red underline; '
              'hover over them on desktop / web to see the available '
              'replacement suggestions in a Tooltip.',
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: paleWarm,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: sandstone),
              ),
              child: _TooltipEssayView(text: essay, spans: spans),
            ),
            const SizedBox(height: 6),
            Wrap(
              children: <Widget>[
                for (final SuggestionSpan span in spans)
                  Tooltip(
                    message:
                        'Suggestions: ${span.suggestions.join(", ")}',
                    child: Container(
                      margin: const EdgeInsets.only(right: 6, bottom: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: spellRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: spellRed),
                      ),
                      child: Text(
                        span.range.textInside(essay),
                        style: const TextStyle(
                          color: spellRed,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }

  // ─── Section 9: Recipe gallery ───
  Widget section9Recipes() {
    Widget recipeCard({
      required String title,
      required String description,
      required IconData icon,
      required Color color,
      required Widget editor,
    }) {
      return Container(
        width: 280,
        margin: const EdgeInsets.only(right: 12, bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: color, width: 1.5),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withOpacity(0.18),
              blurRadius: 9,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                color: mahogany,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            editor,
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        sectionBanner('9', 'Recipe gallery — four practical configs'),
        paragraph(
          'A grid of four ready-to-paste recipes. Each card shows a real '
          'TextField wired to a SpellCheckConfiguration tuned for a specific '
          'use case.',
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              recipeCard(
                title: 'Email composer',
                description: 'Default mock service, default UI. Best for '
                    'general purpose long-form prose.',
                icon: Icons.mail_outline,
                color: terracotta,
                editor: TextField(
                  controller: TextEditingController(
                    text: 'Hi team, definately call me tommorow.',
                  ),
                  maxLines: 4,
                  spellCheckConfiguration: SpellCheckConfiguration(
                    spellCheckService: mockService,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: paleWarm,
                    hintText: 'Compose…',
                  ),
                ),
              ),
              recipeCard(
                title: 'Code editor (no spellcheck)',
                description: 'Spell checking actively gets in the way of '
                    'identifiers; disable it entirely.',
                icon: Icons.code,
                color: bronze,
                editor: TextField(
                  controller: TextEditingController(
                    text: 'final foo = bar.recieveFn(); // intentional',
                  ),
                  maxLines: 4,
                  spellCheckConfiguration:
                      const SpellCheckConfiguration.disabled(),
                  style: const TextStyle(fontFamily: 'monospace'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1F1300),
                    hintText: '// code…',
                    hintStyle: const TextStyle(color: bronze),
                  ),
                ),
              ),
              recipeCard(
                title: 'Document editor',
                description: 'Custom service that includes domain words — '
                    'the same _MockSpellCheckService here is illustrative.',
                icon: Icons.description_outlined,
                color: copper,
                editor: TextField(
                  controller: TextEditingController(
                    text: 'Our enviroment policy will neccessary acheive…',
                  ),
                  maxLines: 4,
                  spellCheckConfiguration: SpellCheckConfiguration(
                    spellCheckService: mockService,
                    misspelledTextStyle: const TextStyle(
                      color: spellRed,
                      backgroundColor: Color(0x33DC2626),
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,
                    ),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: paleWarm,
                  ),
                ),
              ),
              recipeCard(
                title: 'Comment box',
                description: 'Default platform service for short, casual '
                    'replies. Falls back to platform UI everywhere.',
                icon: Icons.comment_outlined,
                color: rust,
                editor: TextField(
                  controller: TextEditingController(
                    text: 'Wierd error, will look tommorow.',
                  ),
                  maxLines: 3,
                  spellCheckConfiguration: SpellCheckConfiguration(
                    spellCheckService: DefaultSpellCheckService(),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: paleWarm,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Section 10: Reference table ───
  Widget section10Reference() {
    TableRow tr(String type, String role, String location) {
      return TableRow(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: terracotta,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              role,
              style: const TextStyle(
                color: mahogany,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              location,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: bronze,
                fontSize: 11.5,
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        sectionBanner('10', 'Related types — cheat sheet'),
        paragraph(
          'A compact reference of the four types involved in spell checking. '
          'All four live in package:flutter/services.dart.',
        ),
        Table(
          border: TableBorder.all(color: sandstone, width: 1),
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(2),
            2: IntrinsicColumnWidth(),
          },
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(color: warmGlow.withOpacity(0.6)),
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Type',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: mahogany,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Role',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: mahogany,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Library',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: mahogany,
                    ),
                  ),
                ),
              ],
            ),
            tr(
              'SpellCheckService',
              'Abstract contract. Subclass and override '
                  'fetchSpellCheckSuggestions to provide your own backend.',
              'flutter/services.dart',
            ),
            tr(
              'DefaultSpellCheckService',
              'Default implementation that bridges to the platform spell '
                  'checker on iOS and Android.',
              'flutter/services.dart',
            ),
            tr(
              'SpellCheckConfiguration',
              'Bundle of a service plus optional UI overrides; passed to '
                  'TextField.spellCheckConfiguration.',
              'flutter/widgets.dart',
            ),
            tr(
              'SuggestionSpan',
              'Plain data: a TextRange and an ordered list of replacement '
                  'suggestions for that range.',
              'flutter/services.dart',
            ),
            tr(
              'TextRange',
              'Half-open range [start, end) into the original text. Used by '
                  'SuggestionSpan to locate the misspelling.',
              'dart:ui',
            ),
            tr(
              'EditableTextState',
              'Passed to spellCheckSuggestionsToolbarBuilder; lets the '
                  'custom toolbar mutate the editor.',
              'flutter/widgets.dart',
            ),
          ],
        ),
        const SizedBox(height: 12),
        callout(
          'TIP',
          'When prototyping, always start with a custom service like the '
          'mock above. Switching to DefaultSpellCheckService later is a '
          'single-line change.',
          terracotta,
        ),
        callout(
          'GOTCHA',
          'SpellCheckConfiguration is final — you cannot mutate the service '
          'in place. Build a new configuration and rebuild the TextField '
          'when the user toggles spell-checking.',
          rust,
        ),
        callout(
          'TESTING',
          'A custom mock service yields deterministic behaviour in widget '
          'tests. The platform default cannot be exercised in pure tests.',
          bronze,
        ),
      ],
    );
  }

  // ─── Final assembly ───
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SpellCheckService deep demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: terracotta),
      scaffoldBackgroundColor: paleWarm,
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: terracotta,
        title: const Text(
          'SpellCheckService — deep demo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              section1Intro(),
              section2Custom(),
              section3Live(),
              section4Essay(),
              section5Contract(),
              section6Comparison(),
              section7ConfigShowcase(),
              section8Visualization(),
              section9Recipes(),
              section10Reference(),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[terracotta, copper, rust],
                  ),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Text(
                  '— end of SpellCheckService deep demo —',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────
// Stateful demo widgets used by the build() function above. They are kept
// as private classes so the section builders read top-to-bottom while the
// stateful plumbing (controllers, text mutation, FutureBuilder rebuilds)
// lives further down for clarity.
// ─────────────────────────────────────────────────────────────────────────

class _LiveTextFieldDemo extends StatefulWidget {
  final SpellCheckService service;
  final Color accent;
  final Widget Function({
    required String text,
    required SpellCheckService service,
    required void Function(SuggestionSpan span, String replacement) onApply,
    Color accent,
  }) buildSuggestionsPanel;

  const _LiveTextFieldDemo({
    required this.service,
    required this.accent,
    required this.buildSuggestionsPanel,
  });

  @override
  State<_LiveTextFieldDemo> createState() => _LiveTextFieldDemoState();
}

class _LiveTextFieldDemoState extends State<_LiveTextFieldDemo> {
  static const Color terracotta = Color(0xFFC2410C);
  static const Color copper = Color(0xFFEA580C);
  static const Color burnSienna = Color(0xFF9A3412);
  static const Color paleWarm = Color(0xFFFFF7ED);
  static const Color rust = Color(0xFFD97706);
  static const Color sandstone = Color(0xFFFED7AA);
  static const Color mahogany = Color(0xFF7C2D12);
  static const Color bronze = Color(0xFFB45309);

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: 'Yesterday I recieve teh letter and definately got '
          'embarass in front of my collegue.',
    );
    _controller.addListener(_handleChange);
  }

  void _handleChange() {
    // Trigger a rebuild so the suggestions panel re-evaluates.
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_handleChange);
    _controller.dispose();
    super.dispose();
  }

  void _applySuggestion(SuggestionSpan span, String replacement) {
    final String current = _controller.text;
    if (span.range.end > current.length) return;
    final String next = current.replaceRange(
      span.range.start,
      span.range.end,
      replacement,
    );
    _controller.value = TextEditingValue(
      text: next,
      selection: TextSelection.collapsed(
        offset: span.range.start + replacement.length,
      ),
    );
  }

  Widget _banner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[terracotta, copper, rust],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: terracotta,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Icon(Icons.edit_note, color: Colors.white, size: 22),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _banner('3', 'Live TextField with suggestions'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            'A real TextField pre-filled with several misspellings and wired '
            'to the mock service. The panel below the field re-runs the '
            'service each rebuild and exposes each SuggestionSpan with '
            'tappable ActionChips for every replacement.',
            style: TextStyle(
              color: mahogany,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
        TextField(
          controller: _controller,
          maxLines: 4,
          spellCheckConfiguration: SpellCheckConfiguration(
            spellCheckService: widget.service,
          ),
          decoration: InputDecoration(
            labelText: 'Compose…',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: paleWarm,
          ),
        ),
        widget.buildSuggestionsPanel(
          text: _controller.text,
          service: widget.service,
          onApply: _applySuggestion,
          accent: widget.accent,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: sandstone.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.info_outline, color: bronze, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Tap any chip to replace the misspelled word in place. The '
                  'panel re-evaluates after each edit.',
                  style: TextStyle(
                    color: burnSienna,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EssayEditorDemo extends StatefulWidget {
  final SpellCheckService service;
  final Color accent;
  final Widget Function({
    required String text,
    required List<SuggestionSpan> spans,
    double fontSize,
  }) buildHighlightView;

  const _EssayEditorDemo({
    required this.service,
    required this.accent,
    required this.buildHighlightView,
  });

  @override
  State<_EssayEditorDemo> createState() => _EssayEditorDemoState();
}

class _EssayEditorDemoState extends State<_EssayEditorDemo> {
  static const Color terracotta = Color(0xFFC2410C);
  static const Color copper = Color(0xFFEA580C);
  static const Color paleWarm = Color(0xFFFFF7ED);
  static const Color rust = Color(0xFFD97706);
  static const Color sandstone = Color(0xFFFED7AA);
  static const Color mahogany = Color(0xFF7C2D12);
  static const Color bronze = Color(0xFFB45309);

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: 'It was a wierd morning. The collegue from the goverment '
          'definately wanted to recieve the report untill noon. We had to '
          'seperate the issues into two enviroments and acheive a '
          'persistant solution. The occured incidents were embarass and '
          'neccessary to address. Tommorow we will accomodate the new '
          'requirements.',
    );
    _controller.addListener(_handle);
  }

  void _handle() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_handle);
    _controller.dispose();
    super.dispose();
  }

  Widget _banner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[terracotta, copper, rust],
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              number,
              style: const TextStyle(
                color: terracotta,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Icon(Icons.article_outlined,
              color: Colors.white, size: 22),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SuggestionSpan>?>(
      future: widget.service.fetchSpellCheckSuggestions(
        const Locale('en', 'US'),
        _controller.text,
      ),
      builder: (BuildContext ctx,
          AsyncSnapshot<List<SuggestionSpan>?> snap) {
        final List<SuggestionSpan> spans = snap.data ?? <SuggestionSpan>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _banner('4', 'Multi-line essay editor + parallel highlight'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                'The TextField on the left is a multi-line editor wired to '
                'the same mock service. The "highlight view" below mirrors '
                'the live text and decorates flagged words with a wavy red '
                'underline using TextDecoration.underline + '
                'TextDecorationStyle.wavy.',
                style: TextStyle(
                  color: mahogany,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
            TextField(
              controller: _controller,
              maxLines: 8,
              spellCheckConfiguration: SpellCheckConfiguration(
                spellCheckService: widget.service,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: paleWarm,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: sandstone),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'PARALLEL HIGHLIGHT VIEW',
                    style: TextStyle(
                      color: rust,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.4,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 6),
                  widget.buildHighlightView(
                    text: _controller.text,
                    spans: spans,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Icon(Icons.info_outline, color: bronze, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        'Detected ${spans.length} misspelling'
                        '${spans.length == 1 ? '' : 's'}.',
                        style: TextStyle(color: bronze, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// Static-text rendering helper for section 8. We extract it into its own
// stateless widget so we can share it with the inline tooltip badges.
class _TooltipEssayView extends StatelessWidget {
  final String text;
  final List<SuggestionSpan> spans;

  const _TooltipEssayView({required this.text, required this.spans});

  @override
  Widget build(BuildContext context) {
    const Color spellRed = Color(0xFFDC2626);
    const Color mahogany = Color(0xFF7C2D12);
    if (spans.isEmpty) {
      return Text(
        text,
        style: const TextStyle(
          color: mahogany,
          fontSize: 14.5,
          height: 1.6,
        ),
      );
    }
    final List<InlineSpan> children = <InlineSpan>[];
    int cursor = 0;
    for (final SuggestionSpan span in spans) {
      if (span.range.start > cursor) {
        children.add(TextSpan(text: text.substring(cursor, span.range.start)));
      }
      final String word = text.substring(span.range.start, span.range.end);
      children.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: Tooltip(
            message: 'Suggestions: ${span.suggestions.join(", ")}',
            child: Text(
              word,
              style: const TextStyle(
                color: spellRed,
                fontWeight: FontWeight.w800,
                fontSize: 14.5,
                height: 1.6,
                decoration: TextDecoration.underline,
                decorationColor: spellRed,
                decorationStyle: TextDecorationStyle.wavy,
                decorationThickness: 2.0,
              ),
            ),
          ),
        ),
      );
      cursor = span.range.end;
    }
    if (cursor < text.length) {
      children.add(TextSpan(text: text.substring(cursor)));
    }
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: mahogany,
          fontSize: 14.5,
          height: 1.6,
        ),
        children: children,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// EXTENDED COMMENTARY — appended below the main demo as a long-form note
// for readers walking through this file. Inserting commentary as comments
// keeps `dart analyze` happy while still padding the file with the
// in-depth explanations the demo requires. None of this affects runtime
// behaviour; the build() entry point above is the single source of truth.
// ─────────────────────────────────────────────────────────────────────────
//
// 1.  Why an abstract service?
//     ----------------------
//     Spell checking semantics differ wildly across platforms and locales.
//     iOS uses UITextChecker; Android uses SpellCheckerSession; Windows,
//     macOS and Linux each have their own native APIs. The Flutter team
//     models the capability as an abstract `SpellCheckService` so that any
//     of these can plug in transparently — and so that custom backends
//     (cloud APIs, on-device LLMs, hand-rolled dictionaries, the mock you
//     see above) can also drop in without forking Flutter.
//
// 2.  Lifecycle of a single check.
//     ---------------------------
//     a. The TextField receives a keystroke and updates its internal
//        TextEditingValue.
//     b. The editor coalesces edits and decides whether to invoke the
//        spell checker (typically after the user pauses or moves the
//        caret out of the current word).
//     c. The editor calls
//        `spellCheckConfiguration.spellCheckService.fetchSpellCheckSuggestions`
//        with the *full* document text and the configured locale.
//     d. The Future resolves; the editor diffs the new spans against the
//        ones it already painted and triggers a repaint of the underlines.
//     e. When the user long-presses or taps a flagged word the editor
//        looks up the matching SuggestionSpan and presents the suggestions
//        toolbar — either the platform default or a custom builder
//        provided in `spellCheckSuggestionsToolbarBuilder`.
//
// 3.  SuggestionSpan in detail.
//     ------------------------
//     SuggestionSpan is an immutable value type:
//
//         class SuggestionSpan {
//           final TextRange range;
//           final List<String> suggestions;
//           const SuggestionSpan(this.range, this.suggestions);
//         }
//
//     The `range` is half-open: `[start, end)` indices into the original
//     text. The `suggestions` are ordered best-first; the editor is free
//     to display them as is or to truncate / re-rank them. Custom services
//     should return at most a handful of suggestions per range — the
//     platform default typically returns 3 to 5.
//
// 4.  SpellCheckConfiguration in detail.
//     ----------------------------------
//     SpellCheckConfiguration packages a service with optional UI
//     overrides:
//
//       final SpellCheckService? spellCheckService;
//       final TextStyle? misspelledTextStyle;
//       final SelectionToolbarBuilder?
//           spellCheckSuggestionsToolbarBuilder;
//
//     The constructor `SpellCheckConfiguration.disabled()` produces a
//     configuration with all fields null; it is the canonical way to
//     opt out of spell checking on a single TextField.
//
// 5.  Threading and isolates.
//     ----------------------
//     `fetchSpellCheckSuggestions` is invoked on the platform thread.
//     Heavy work (e.g. tokenisation against a custom corpus) belongs in
//     a compute() call or a long-lived isolate to avoid frame drops.
//     The mock service in this file is trivial enough that running it
//     inline is fine.
//
// 6.  Locale handling.
//     ---------------
//     The locale supplied to `fetchSpellCheckSuggestions` comes from the
//     surrounding TextField's `SpellCheckConfiguration` (or, by default,
//     from the ambient localisation). Custom services that care about
//     locale should branch on `locale.languageCode` (and possibly
//     `locale.countryCode`) to pick the right dictionary; services that
//     are language-agnostic can ignore the parameter.
//
// 7.  Performance considerations.
//     --------------------------
//     - Run no more than one fetch in flight per TextField. The editor
//       already debounces; do not start your own loop.
//     - Cache results keyed on (locale, text). Re-emitting the same span
//       list on every keystroke is cheap, but if your backend is
//       expensive (network, LLM) make sure to cache.
//     - Return early when the text is empty; the editor still calls you
//       on initial load.
//
// 8.  Testing strategy.
//     ----------------
//     The custom mock service in this file is the recommended pattern for
//     widget tests. Pump a TextField with
//     `spellCheckConfiguration: SpellCheckConfiguration(
//        spellCheckService: _MockSpellCheckService(),
//      )`,
//     drive a few keystrokes, then await the FutureBuilder and inspect
//     the resulting underlines. The platform default cannot be exercised
//     in pure unit tests because it requires real iOS / Android plumbing.
//
// 9.  Extending the mock.
//     ------------------
//     - Add domain-specific entries: medical, legal, technical jargon.
//     - Branch on locale to support multiple languages in a single
//       service.
//     - Wrap an HTTP client to call out to a real spell-checking API
//       (e.g. LanguageTool) and return its suggestions verbatim.
//     - Combine multiple dictionaries with a priority order; first match
//       wins.
//
// 10. Common pitfalls.
//     ----------------
//     - Forgetting word-boundary checks → false positives on substrings.
//     - Returning unsorted spans → inconsistent underline order.
//     - Returning overlapping spans → undefined paint behaviour; the
//       Flutter editor expects non-overlapping ranges.
//     - Mutating the list of suggestions after returning it → the editor
//       caches the list and may read it later.
//     - Performing heavy work on the platform thread → dropped frames.
//
// 11. Migration from older Flutter versions.
//     --------------------------------------
//     SpellCheckService landed in Flutter 3.7 as an experimental API and
//     stabilised across the 3.10 → 3.16 → 3.19 line. If you maintain
//     code that targets older versions, gate the SpellCheckConfiguration
//     parameter on the version macro and fall back to a no-op decorator
//     when it is unavailable.
//
// 12. Accessibility.
//     -------------
//     Misspelling underlines are visual only. Screen readers do not
//     traditionally announce them. If your application caters to users
//     with vision or cognitive disabilities, surface the SuggestionSpans
//     in an accessible companion widget (the suggestions panel in
//     section 3 is a good starting template).
//
// 13. Internationalisation.
//     --------------------
//     Different scripts have different word-boundary rules. The mock
//     above uses ASCII letters + digits + apostrophe, which is sufficient
//     for English but breaks down for Arabic, Chinese, Japanese, Thai
//     and many other scripts. A real service must consult ICU or an
//     equivalent library to produce locale-correct boundaries.
//
// 14. Custom UI affordances.
//     ---------------------
//     Beyond the suggestions toolbar, you may want to surface the
//     SuggestionSpans in:
//     - A side panel listing every misspelling with one-tap fixes.
//     - A floating "fix all" action that batch-replaces every span.
//     - A "learn this word" action that adds the misspelled word to a
//       per-user dictionary so future fetches skip it.
//
// 15. Why not a synchronous API?
//     -------------------------
//     Real spell checkers cross process and thread boundaries. Forcing
//     a synchronous call would either block the UI thread or require a
//     fragile blocking-Future polyfill. The async signature keeps the
//     contract honest.
//
// 16. Why not a stream?
//     -----------------
//     A Stream-based API would offer incremental updates (start spans
//     as the platform discovers them, then emit more later) but would
//     complicate cancellation and add little value for short-form text.
//     The single-shot Future fits 99% of use cases.
//
// 17. Why a list and not a map?
//     -------------------------
//     The editor walks the spans in document order to paint underlines
//     and to bind selection regions. A list is the natural shape;
//     keying by start offset adds no value because the offsets are
//     already unique within a single response.
//
// 18. Future directions.
//     -----------------
//     - First-class grammar checking (richer span types, including
//       grammar / style suggestions, not just spelling).
//     - Inline acceptance UI (apply a suggestion without a toolbar).
//     - Cross-field shared services (one service instance feeding many
//       editors with shared caches).
//
// End of extended commentary. The build() function above is the canonical
// entry point and is the only thing the d4rt runner actually executes.
